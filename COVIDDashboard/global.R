library(shiny)
library(shinyjs)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyWidgets)
library(shinycssloaders)
library(leaflet)
library(tidyverse)
library(lubridate)
library(sf)
library(plotly)

load("covid.RData")
`%notin%` <- Negate(`%in%`)
usmap = readRDS("usmap.RDS")
tot_pop = sum(usmap$pop, na.rm=T)

i = 0
max_diff = as.numeric(Sys.Date() - update_time)
message(Sys.Date())
while (i < max_diff) {
  prev_day = paste(substr(as.character(Sys.Date()-days(i)),6,7),"-",
                   substr(as.character(Sys.Date()-days(i)),9,10), "-",
                   substr(as.character(Sys.Date()-days(i)),1,4), ".csv", sep = '')
  print(prev_day)
  file = paste("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/", 
               prev_day, sep="")
  tryCatch(download.file(file, paste("./data/", prev_day,sep = ''), mode = "w", quiet = FALSE), 
           error = function(e) print(paste(file, 'did not work out')))  
  i = i + 1
}

temp = list.files(path="./data/",pattern="*.csv")
if (length(temp) > 0) {
  myfiles = lapply(paste("./data/", temp, sep=""), read.csv)
  file.remove(paste("./data/", temp, sep=""))
  myfiles = lapply(1:length(myfiles), function(x) {
    df = myfiles[[x]]
    names(df) = make.names(names(df), allow_ = FALSE)
    df = df %>% select("Province.State","Country.Region","Last.Update","Confirmed",
                       "Deaths","Recovered")
    df$Last.Update = str_replace(temp[x], ".csv", "")
    df
  })
  
  df = do.call("rbind", myfiles)
  df = df %>% 
    filter(Country.Region == "US") %>% 
    mutate(Last.Update = mdy(Last.Update)) %>% 
    # mutate(Last.Update = str_replace(Last.Update, "[ T].*$", "")) %>% 
    # mutate(Last.Update = ifelse(str_detect(Last.Update, "/"), 
    #                             paste("2020-",str_extract(Last.Update, "^[0-9]+"), "-", str_extract("1/20/20", "(?<=/)[0-9]+"), sep=""),
    #                             Last.Update)) %>% 
    mutate(Deaths = ifelse(is.na(Deaths), 0, Deaths),
           Recovered = ifelse(is.na(Recovered), 0, Recovered),
           Confirmed = ifelse(is.na(Confirmed), 0, Confirmed)) %>% 
    mutate(Last.Update = ymd(Last.Update)) %>% 
    mutate(State = case_when(
      str_detect(Province.State, "Diamond") ~ "Diamond Princess",
      str_detect(Province.State, "Puerto Rico") ~ "Puerto Rico",
      str_detect(Province.State, "Grand Princess") ~ "Grand Princess",
      str_detect(Province.State, "Chicago") ~ "Illinois",
      str_detect(Province.State, "Virgin Islands") ~ "United States Virgin Islands",
      TRUE                                     ~ as.character(Province.State)),
      State = as.character(State))
  for (i in 1:nrow(usmap)) {
    df = df %>% mutate(State = ifelse(str_detect(State, usmap$STUSPS[i]), usmap$NAME[i], State))
  }
  df = df %>% mutate(State = ifelse(State %in% c("Grand Princess", "Diamond Princess", usmap$NAME), State, "Other"))
  df = left_join(df, usmap %>% select(NAME, pop) %>% filter(!is.na(pop)), by=c("State"="NAME"))
  df$geometry=NULL
  df = df %>% 
    group_by(Last.Update, State, pop) %>% 
    summarise(Confirmed = sum(Confirmed),
              Deaths = sum(Deaths)) %>% 
    ungroup() %>% 
    mutate(Confirmed_capita = Confirmed / pop * 100000,
           Deaths_capita = Deaths / pop * 100000)
  
  data = rbind(data, df)
  update_time = max(data$Last.Update)
  write.table(update_time, file = 'restart.txt')
}


update_df = data %>% 
  filter(Last.Update == update_time) %>% 
  mutate(labels = paste("<strong>", State,"</strong><br/>Confirmed: ",
                        formatC(Confirmed,format="d", big.mark=","),
                        "<br/>Death:",
                        formatC(Deaths,format="d", big.mark=","), sep="") %>% 
           lapply(htmltools::HTML)) %>% 
  mutate(labels_capita = paste("<strong>", State,"</strong><br/>Confirmed: ",
                               formatC(Confirmed_capita,format="f", digits=2, big.mark=","),
                               "<br/>Death:",
                               formatC(Deaths_capita,format="f", digits=4, big.mark=","), sep="") %>% 
           lapply(htmltools::HTML))

mymap = inner_join(usmap, update_df %>% filter(!is.na(Confirmed_capita)) %>% select(-pop), by=c("NAME"="State"))

save(list = c("data", "update_time"), file = "covid.RData", version = 2)

