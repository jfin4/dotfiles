suppressMessages(library(tidyverse))

read_csv('~/notes/hours.csv', 
         col_types = cols(.default = 'c'),
         comment = '#') %>%
mutate(date = as.Date(date, format = '%Y%m%d'),
       from = as.POSIXlt(from, format = '%H%M'),
       to = as.POSIXlt(to, format = '%H%M'),
       diff = difftime(to, from, units = 'hours') %>% as.numeric()) %>%
group_by(date) %>%
summarize(tot = sum(diff),
          work = sum(diff * (w == 1))) %>%
ungroup() %>%
mutate(d_ave = work / tot) %>%
{
    data <- .
    data %>%
        mutate(week = format(date, '%Y-%U')) %>%
        group_by(week) %>%
        summarize(date = last(date),
                  w_ave = mean(d_ave)) %>%
        ungroup() %>%
        right_join(data, by = 'date')
} %>% 
{
    data <- .
    data %>%
        summarize(date = max(date),
                  t_ave = mean(d_ave))  %>%
        right_join(data, by = 'date')
} %>% 
arrange(desc(date)) %>%
mutate(date = format(date, format = '%b %d')) %>% 
select(date, work, tot, d_ave, w_ave, t_ave) %>% 
slice_head(n = 20) %>% 
# converts to char vector, each row becomes a string
format() %>% 
str_replace_all('NA', '  ') %>%
str_replace('\\d+', \(x) str_dup(' ', str_length(x))) %>%
# remove "# A tibble:... and data type row
discard_at(c(1, 3)) %>% 
cat(sep = '\n')
