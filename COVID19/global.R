library(shinyWidgets)
require(shinythemes)
library(shinyBS)
library(shinyjs)
library(dplyr)

`%notin%` <- Negate(`%in%`)

zip_file = file.path("data", "zip.csv") 
zip_data = read.csv(zip_file) %>% filter(!is.na(ZIP))
tract_file = file.path("data", "tract.csv") 
tract_data = read.csv(tract_file)
