suppressMessages(library("tidyverse"))

options(width = 120)

rm(list = ls())

notes <- 
    read_lines("./notes.txt") %>%
    str_trim()

todo <- 
    notes %>% 
    keep(function(x) str_detect(x, "#todo")) %>% 
    { 
        data <- .
        date <- 
            data %>% 
            map_chr(function(x) str_extract(x, "\\d{4}-\\d{2}-\\d{2}")) %>%
            as_date()
        todo <- 
            data %>% 
            map_chr(function(x) str_remove(x, "#todo (\\d{4}-\\d{2}-\\d{2} )?"))
        tibble(date, todo)
    } %>%
    arrange(date)

done <- 
    notes %>% 
    keep(function(x) str_detect(x, "#done")) %>% 
    { 
        data <- .
        date <- 
            data %>% 
            map_chr(function(x) str_extract(x, "\\d{4}-\\d{2}-\\d{2}")) %>%
            as_date()
        done <- 
            data %>% 
            map_chr(function(x) str_remove(x, "#done (\\d{4}-\\d{2}-\\d{2} )?"))
        tibble(date, done)
    } %>%
    filter(date > (today() - 30))  %>%
    arrange(date)

if (nrow(todo) > 0) {
    todo %>% 
    print(n = 50) 
}

if (nrow(done) > 0) {
    cat("\n")
    done %>% 
        print(n = 50)
}
