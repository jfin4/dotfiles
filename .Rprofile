# general
options(max.print = 500)
# options(width = 156)

# for tidyverse in terminal
# options(cli.unicode = FALSE) 
# options(crayon.enabled = FALSE)

# for rselenium
Sys.setenv(PATH = paste(Sys.getenv("PATH"), 
                        "C:/Program Files (x86)/Common Files/Oracle/Java/javapath", 
                        sep = .Platform$path.sep))

# specify repo
local({
    r <- getOption("repos")
    r["CRAN"] <- "https://cloud.r-project.org/"
    options(repos = r)
})
