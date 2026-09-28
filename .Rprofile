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

  .env$load_files <- function(files) {
    cache_dir <- fs::path(".Rcache")
    fs::dir_create(cache_dir)
    object_names <- names(files)

    # ---- prune stale cache files (names not in current input) ----
    fs::dir_ls(cache_dir, all = TRUE) |>
      purrr::keep(\(x) {
        cached_name <- stringr::str_remove(x, "\\.rds$")
        !cached_name %in% object_names
      }) |>
      purrr::walk(fs::file_delete)

    # ---- read (or load from cache) each file ----
    files |>
      purrr::iwalk(\(x, idx) {
        if (exists(idx, envir = .GlobalEnv, inherits = FALSE)) return(invisible())

        cache_file <- fs::path(cache_dir, stringr::str_c(idx, ".rds"))

        if (fs::file_exists(cache_file)) {
          assign(idx, readRDS(cache_file), envir = .GlobalEnv)
          return(invisible())
        }

        ext <- fs::path_ext(stringr::str_to_lower(x))

        object <- if (stringr::str_detect(ext, "xls")) {
          x |>
            readxl::excel_sheets() |>
            purrr::set_names() |>
            purrr::map(\(y) readxl::read_excel(x, sheet = y, col_types = "text", na = "")) |>
            (\(z) if (length(z) == 1L) z[[1L]] else z)()
        } else {
          data.table::fread(x, colClasses = "character", na.strings = "")
        }

        assign(idx, object, envir = .GlobalEnv)
        saveRDS(object, cache_file)
      })

    invisible()
  }

  attach(.env, name = "utils", warn.conflicts = FALSE)
  lockEnvironment(.env, bindings = TRUE)
})
