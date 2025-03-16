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

# Add to your ~/.Rprofile
.First <- function() {
    # Try to get terminal width from system
    tryCatch({
        if (interactive()) {
            # Get terminal width from stty command if available
            size_str <- system("stty size", intern = TRUE)
            if (length(size_str) > 0) {
                width <- strsplit(size_str, " ")[[1]]
                width <- as.integer(width[2])  # The second number is the width (columns)
                options(width = width)
            } else {
                # Fallback to tput
                width <- as.integer(system("tput cols", intern = TRUE))
                if (!is.na(width)) {
                    options(width = width)
                }
            }
        }
    }, error = function(e) {
        # If any error occurs, use a reasonable default
        options(width = 120)
    })
}
