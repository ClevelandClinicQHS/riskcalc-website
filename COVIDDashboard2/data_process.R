# usmap= us_boundaries(type = "state")
# usmap = states(cb=F, resolution="20m")
# usmap = st::st_as_sf(usmap)
# saveRDS(usmap, 'usmap.RDS', version=2)

library(tidycensus)
library(tidyverse)

census_api_key("YOUR API KEY GOES HERE")



usmap = readRDS("usmap.RDS")

temp = list.files(path="./data/",pattern="*.csv")
i = 1
while (TRUE) {
  yesterday = paste(substr(as.character(Sys.Date()-days(i)),6,7),"-",
                    substr(as.character(Sys.Date()-days(i)),9,10), "-",
                    substr(as.character(Sys.Date()-days(i)),1,4), ".csv", sep = '')
  
  if (!any(grepl(yesterday, temp))) {
    file = paste("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/", yesterday, sep="")
    oldw <- getOption("warn")
    options(warn = -1)
    tryCatch(download.file(file, paste("./data/", yesterday,sep = ''), mode = "w", quiet = FALSE), 
             error = function(e) print(paste(file, 'did not work out')))  
    i = i + 1
  } else {
    break
  }
}


temp = list.files(path="./data/",pattern="*.csv")
myfiles = lapply(paste("./data/", temp, sep=""), read.csv)
myfiles = lapply(1:length(myfiles), function(x) {
  df = myfiles[[x]]
  names(df) = make.names(names(df), allow_ = FALSE)
  df = df %>% select("Province.State","Country.Region","Last.Update","Confirmed",
                     "Deaths","Recovered")
  df$Last.Update = str_replace(temp[x], ".csv", "")
  df
})

`%notin%` <- Negate(`%in%`)
data = do.call("rbind", myfiles)
data = data %>% 
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
  data = data %>% mutate(State = ifelse(str_detect(State, usmap$STUSPS[i]), usmap$NAME[i], State))
}
data = data %>% mutate(State = ifelse(State %in% c("Grand Princess", "Diamond Princess", usmap$NAME), State, "Other"))
update_time = max(data$Last.Update)
update_df = data %>% filter(Last.Update == update_time) %>% group_by(State) %>% 
  summarise(Confirmed = sum(Confirmed),
            Deaths = sum(Deaths),
            Recovered = sum(Recovered)) %>% 
  ungroup()

