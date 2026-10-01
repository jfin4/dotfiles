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
  .env$read <- function(paths, cache_dir = ".Rcache") {

    # get arg vecs
    remove_vec <- get_vec(paths, "remove", cache_dir)
    load_vec <- get_vec(paths, "load", cache_dir)
    read_vec <- get_vec(paths, "read", cache_dir)

    # remove stale input
    if (length(remove_vec) > 0) {
      # from env
      rm(list = names(remove_vec), envir = .GlobalEnv)
      # from cache
      purrr::walk(remove_vec, fs::file_delete)
      cat("removed: ", names(remove_vec), "\n")
    }

    # load cached input
    if (length(load_vec) > 0) {
      purrr::iwalk(load_vec, \(x, idx) assign(idx, readRDS(x), envir = .GlobalEnv))
      cat("loaded: ", names(load_vec), "\n")
    }

    if (length(read_vec) > 0) {
      purrr::iwalk(read_vec, \(x, idx) {
        make_object_from_file(x, idx)
        saveRDS(x, fs::path(cache_dir, stringr::str_c(idx, ".rds")))
      })
      cat("read: ", names(read_vec), "\n")
    }
  }

  # helper functions ------------------------------------------------------

  get_vec <- function(paths_vec, selection, cache_dir) {
     
    fs::dir_create(cache_dir)
    cache_files <- fs::dir_ls(cache_dir, all = TRUE)
    cache_names <- names(cache_files) |>
          fs::path_file() |> 
          fs::path_ext_remove()
    cache_vec <- purrr::set_names(cache_files, cache_names)

    # remove names
    path_names <- names(paths_vec)
    is_removed <- !cache_names %in% path_names
    remove_vec <- cache_vec[is_removed]

    # load names
    keep_names <- intersect(path_names, cache_names)
    keep_vec <- cache_vec[keep_names]
    keep_times <- purrr::map_vec(keep_vec[keep_names],
                           \(x) fs::file_info(x)$modification_time)
    path_times <- purrr::map_vec(paths_vec[keep_names],
                          \(x) fs::file_info(x)$modification_time)
    is_updated <- path_times > keep_times
    is_loaded <- keep_names %in% ls(.GlobalEnv, all = TRUE)
    load_vec <- keep_vec[!is_updated & !is_loaded]

    # read names
    is_new <- !path_names %in% keep_names
    read_vec <- c(paths_vec[is_new], keep_vec[is_updated])

    # select
    switch(selection,
           remove = remove_vec,
           load = load_vec,
           read = read_vec
    )
  }

  make_object_from_file <- function(path, name) {
    ext <- fs::path_ext(stringr::str_to_lower(path))
    if (stringr::str_detect(ext, "xls")) {
      object <- read_excel_file(path)
    } else {
      object <- read_text_file(path)
    }
    assign(name, object, envir = .GlobalEnv)
  }

  read_excel_file <- function(path) {
      path |>
        readxl::excel_sheets() |>
        purrr::set_names() |>
        purrr::map(\(sheet) readxl::read_excel(path, 
                                               sheet = sheet, 
                                               col_types = "text", 
                                               na = "")) |>
        (\(wb) if (length(wb) == 1L) unlist(wb) else wb)()
  }

  read_text_file <- function(path) {
    readr::read_csv(path, 
                    col_types = readr::cols(.default = "c"),
                    na = "",
                    lazy = TRUE,
                    progress = FALSE) |>
    tibble::as_tibble()
  }

  attach(.env, name = "utils", warn.conflicts = FALSE)
  lockEnvironment(.env, bindings = TRUE)
})
