library(tidycensus)
library(tidyverse)
library(sf)
library(readxl)

census_api_key("1f9ec8043c07df314c33eb363518931cc231aa05", install = T)
income = get_acs(
  geography = "tract", 
  variables = c(
    Population = "B01003_001",
    MedianIncome = "B19013_001",
    TotalHousing = "B25001_001"), 
  year = 2018,
  state = c("AL","AK","AZ","AR","CA","CO","CT","DE","DC","FL","GA","HI","ID",
            "IL","IN","IA","KS","KY","LA","ME","MT","NE","NV","NH","NJ","NM",
            "NY","NC","ND","OH","OK","OR","MD","MA","MI","MN","MS","MO","PA",
            "RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY"),
  geometry = T,
  cache_table = T)

area = st_area(income)

income = income %>% select(-moe) %>% 
  pivot_wider(names_from = "variable", values_from = "estimate") %>% 
  select(-HousingWithMogage, -HousingWoMogage) %>% 
  mutate(area = as.numeric(area))

zip_code = read_xlsx("TRACT_ZIP_122019.xlsx")

income1 = left_join(income, zip_code %>% select(ZIP, TRACT),
                   by = c("GEOID" = "TRACT"))

income1 = income1 %>% 
  group_by(ZIP) %>% 
  summarise(Population = sum(Population, na.rm = T),
            MedianIncome = mean(MedianIncome, na.rm = T),
            TotalHousing = sum(TotalHousing, na.rm = T),
            Area = sum(area, na.rm = T) / 1000000) %>% 
  mutate(PopulationPerHousingUnit = Population / TotalHousing,
         PopulationPerSqKm = Population / Area) %>% 
  mutate(PopulationPerHousingUnit = ifelse(is.na(PopulationPerHousingUnit), median(PopulationPerHousingUnit, na.rm = T), PopulationPerHousingUnit),
         PopulationPerSqKm = ifelse(is.na(PopulationPerSqKm), median(PopulationPerSqKm, na.rm = T), PopulationPerSqKm),
         MedianIncome  = ifelse(is.na(MedianIncome), median(MedianIncome, na.rm = T), MedianIncome)) %>% 
  select(ZIP, MedianIncome, PopulationPerHousingUnit, PopulationPerSqKm)

income2 = income %>% 
  mutate(PopulationPerHousingUnit = Population / TotalHousing,
         PopulationPerSqKm = Population / (area / 1000000)) %>% 
  mutate(PopulationPerHousingUnit = ifelse(is.na(PopulationPerHousingUnit), median(PopulationPerHousingUnit, na.rm = T), PopulationPerHousingUnit),
         PopulationPerSqKm = ifelse(is.na(PopulationPerSqKm), median(PopulationPerSqKm, na.rm = T), PopulationPerSqKm),
         MedianIncome  = ifelse(is.na(MedianIncome), median(MedianIncome, na.rm = T), MedianIncome)) %>% 
  select(GEOID, MedianIncome, PopulationPerHousingUnit, PopulationPerSqKm)


income_zip = get_acs(
  geography = "zcta", 
  variables = c(
    Population = "B01003_001",
    MedianIncome = "B19013_001",
    TotalHousing = "B25001_001"), 
  year = 2018,
  geometry = T,
  cache_table = T)

area = st_area(income_zip)

income_zip = income_zip %>% as.data.frame() %>% select(-moe, -geometry) %>% 
  pivot_wider(names_from = "variable", values_from = "estimate") %>% 
  rename(ZIP = GEOID) %>% 
  mutate(area = as.numeric(area[1:33120])) %>% 
  mutate(PopulationPerHousingUnit = Population / TotalHousing,
         PopulationPerSqKm = Population / (area / 1000000)) %>% 
  select(ZIP, MedianIncome, PopulationPerHousingUnit, PopulationPerSqKm)

