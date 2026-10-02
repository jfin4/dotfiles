# set options
local({
  r <- getOption("repos")
  r["CRAN"] <- "https://cloud.r-project.org/"
  options(
    repos = r,
    max.print = 500, 
    help_type = "html"
  )
})

# Version-specific personal library path
local({
  lib <- file.path("~/.R", paste0(R.version$major, ".", R.version$minor))
  dir.create(lib, recursive = TRUE, showWarnings = FALSE)
  .libPaths(c(lib, .libPaths()))
})

# Machine-specific options
if (Sys.info()["nodename"] == "jfin") {
  options(
    browser = "/usr/bin/firefox", 
    width = 135
  )
}

# Custom utility operators and functions
local({
  .env <- new.env(parent = baseenv())

  .env$`%~%` <- function(x, pattern) {
    grepl(pattern, x, ignore.case = TRUE)
  }

  .env$`%nin%` <- Negate(`%in%`)

  # read inputs -------------------------------------------------------------

  # main function -----------------------------------------------------------
  .env$gather <- function(input, cache_dir = ".Rcache") {

    # sort files
    input_to_remove <- sort_input(input, "remove", cache_dir)
    input_to_restore <- sort_input(input, "restore", cache_dir)
    input_to_read <- sort_input(input, "read", cache_dir)

    # remove
    if (length(input_to_remove) > 0) {
      # from env
      rm(list = names(input_to_remove), envir = .GlobalEnv)
      # from cache
      purrr::walk(input_to_remove, fs::file_delete)
      cat("\nremoved:", names(input_to_remove), sep = "\n")
    }

    # restore
    if (length(input_to_restore) > 0) {
      purrr::iwalk(input_to_restore, \(x, idx) {
        assign(idx, readRDS(x), envir = .GlobalEnv)
    })
      cat("\nrestored:", names(input_to_restore), sep = "\n")
    }

    # read
    if (length(input_to_read) > 0) {
      purrr::iwalk(input_to_read, \(x, idx) {
        read(x, idx)
        saveRDS(x, fs::path(cache_dir, stringr::str_c(idx, ".rds")))
      })
      cat("\nread:", names(input_to_read), sep = "\n")
    }
  }

  # helper functions ------------------------------------------------------

  sort_input <- function(input, bin, cache_dir) {
     
    # remove
    fs::dir_create(cache_dir)
    cache_objects <- fs::dir_ls(cache_dir, all = TRUE) |>
      (\(x) purrr::set_names(x, fs::path_ext_remove(fs::path_file(x))))()
    remove_names <- setdiff(names(cache_objects), names(input))
    input_to_remove <- cache_objects[remove_names]

    # restore
    keep_names <- intersect(names(cache_objects), names(input))
    keep_times <- purrr::map_vec(cache_objects[keep_names],
                           \(x) fs::file_info(x)$modification_time)
    input_times <- purrr::map_vec(input[keep_names],
                          \(x) fs::file_info(x)$modification_time)
    update_names <- keep_names[input_times > keep_times]
    loaded_names <- intersect(keep_names, ls(.GlobalEnv))
    input_to_restore <- cache_objects[setdiff(keep_names, 
                                              union(update_names,
                                                    loaded_names))]

    # read
    new_names <- setdiff(names(input), names(cache_objects))
    input_to_read <- input[union(new_names, update_names)]

    # return
    switch(bin,
           remove = input_to_remove,
           restore = input_to_restore,
           read = input_to_read
    )
  }

  read <- function(path, name) {
    ext <- fs::path_ext(stringr::str_to_lower(path))
    if (stringr::str_detect(ext, "xls")) {
      object <- read_excel(path)
    } else {
      object <- read_text(path)
    }
    assign(name, object, envir = .GlobalEnv)
  }

  read_excel <- function(path) {
      path |>
        readxl::excel_sheets() |>
        purrr::set_names() |>
        purrr::map(\(sheet) readxl::read_excel(path, 
                                               sheet = sheet, 
                                               col_types = "text", 
                                               na = "")) |>
        (\(wb) if (length(wb) == 1L) unlist(wb) else wb)()
  }

  read_text <- function(path) {
    readr::read_delim(path, 
                    col_types = readr::cols(.default = "c"),
                    na = "",
                    lazy = TRUE,
                    progress = FALSE) |>
    tibble::as_tibble()
  }

  attach(.env, name = "utils", warn.conflicts = FALSE)
  lockEnvironment(.env, bindings = TRUE)
})
