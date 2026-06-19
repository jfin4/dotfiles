# general
options(max.print = 500, help_type = "html")

# specify repo
local({
    r <- getOption("repos")
    r["CRAN"] <- "https://cloud.r-project.org/"
    options(repos = r)
})

lib_dir <- file.path("~/.R", paste0(R.version$major, ".", R.version$minor))
dir.create(lib_dir, recursive = TRUE, showWarnings = FALSE)
.libPaths(c(lib_dir, .libPaths()))

# Set options for home computer
if (Sys.info()["nodename"] %in% c("jfin")) {
  options(browser = "/usr/bin/firefox",
          width = 135)
}

# for lsp completion
# order matters for masking
packages <- c(.Options$defaultPackages, 
              "data.table",
              "fs", 
              "git2r",
              "readxl", 
              "tidyverse", 
              "writexl")
load_package <- function(package) {
    require(package, character.only = TRUE)
}
lapply(packages, load_package) |> 
    invisible() |>
    suppressMessages()

.env <- new.env(parent = baseenv())

.env$`%~%` <- function(x, pattern) str_detect(x, pattern)

.env$`%nin%` <- Negate(`%in%`)

attach(.env, name = "my_utils", warn.conflicts = FALSE)

lockEnvironment(.env, bindings = TRUE)
