# general
options(max.print = 500, help_type = "html")
# options(width = 156)

# for tidyverse in terminal
# options(cli.unicode = FALSE) 
# options(crayon.enabled = FALSE)

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
if (Sys.info()["nodename"] == "t14") {
  options(browser = "/usr/bin/firefox")
}

