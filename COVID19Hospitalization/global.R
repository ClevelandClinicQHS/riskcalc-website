library(shinyWidgets)
require(shinythemes)
library(shinyBS)
library(shinyjs)
library(dplyr)

`%notin%` <- Negate(`%in%`)

zip_file = file.path("zip.csv") 
zip_data = read.csv(zip_file) %>% filter(!is.na(ZIP))
