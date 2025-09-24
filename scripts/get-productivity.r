suppressMessages(library(tidyverse))

read_csv('~/notes/hours.csv', 
         col_types = cols(.default = 'c'),
         comment = '#') %>%
mutate(date = as.Date(date, format = '%Y%m%d'),
       from = as.POSIXlt(from, format = '%H%M'),
       to = as.POSIXlt(to, format = '%H%M'),
       diff = difftime(to, from, units = 'hours') %>% as.numeric()) %>%
group_by(date) %>%
summarize(totl = sum(diff),
          work = sum(diff * (w == 1))) %>%
ungroup() %>%
mutate(prop = work / totl) %>%
{
    data <- .
    data %>%
        mutate(week = format(date, '%Y-%U')) %>%
        group_by(week) %>%
        summarize(date = last(date),
                  w_ave = mean(prop)) %>%
        ungroup() %>%
        right_join(data, by = 'date')
} %>%
{
    data <- .
    data %>%
        summarize(date = max(date),
                  t_ave = mean(prop)) %>%
    right_join(data, by = 'date')
} %>%
    arrange(desc(date)) %>%
    mutate(date = format(date, format = '%b %d')) %>% 
    select(date, work, totl, prop, w_ave, t_ave) %>% 
    slice_head(n = 20) %>% 
    # converts to char vector, each row becomes a string
    format() %>% 
    str_replace_all('NA', '  ') %>%
    str_replace('\\d+', \(x) str_dup(' ', str_length(x))) %>%
    # remove "# A tibble:... and data type row
    discard_at(c(1, 3))  %>%
    cat(sep = '\n')
