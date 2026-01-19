# general
options(max.print = 500, help_type = "html")

# specify repo
local({
    r <- getOption("repos")
    r["CRAN"] <- "https://cloud.r-project.org/"
    options(repos = r)
})

lib_dir <- file.path("~/.R")
dir.create(lib_dir, recursive = TRUE, showWarnings = FALSE)
.libPaths(c(lib_dir, .libPaths()))

# Set browser only on t14 (Linux)
if (Sys.info()["nodename"] %in% c("t14")) {
  options(browser = "/usr/bin/firefox -P socks")
}
if (Sys.info()["nodename"] %in% c("jfin")) {
  options(browser = "/usr/bin/firefox -P socks")
}

# for lsp completion
packages <- .Options$defaultPackages
load_package <- function(package) library(package, character.only = TRUE)
suppressMessages({
    # default packages have to be loaded first, other wise stats::filter will
    # mask dplyr::filter
    lapply(packages, load_package)
    require("tidyverse", character.only = TRUE)
})
