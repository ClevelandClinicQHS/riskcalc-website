# map Risk based on input
mapRisk <- function(panelSwtich, inputTable, ageVal){
  matchRow = switch (panelSwtich,
                     Male_Yes = {inputTable[S3SmokeMen, on = names(inputTable), nomatch = NULL]},
                     Female_Yes = {inputTable[S4SmokeWomen, on = names(inputTable), nomatch = NULL]},
                     Male_No = {inputTable[S6men, on = names(inputTable), nomatch = NULL]},
                     Female_No = {inputTable[S7Women, on = names(inputTable), nomatch = NULL]}
  )
  
  return(matchRow[[ageVal]])
}

# library(data.table)
# library(readxl)
# 
# S7Women <- data.table(readxl::read_xlsx("/Users/huangs7/Desktop/Project/RiskCalculator/S7Women.xlsx"))
# S6Men <- data.table(readxl::read_xlsx("/Users/huangs7/Desktop/Project/RiskCalculator/S6Men.xlsx"))
# S3SmokeMen <- data.table(readxl::read_xlsx("/Users/huangs7/Desktop/Project/RiskCalculator/S3SmokeMen.xlsx"))
# S4SmokeWomen <- data.table(readxl::read_xlsx("/Users/huangs7/Desktop/Project/RiskCalculator/S4SmokeWomen.xlsx"))
# 
# saveRDS(S7Women, file="/Users/huangs7/Desktop/Project/RiskCalculator/RiskCalc/CancerRiskCalculator/www/S7Women.rds")
# saveRDS(S6Men, file="/Users/huangs7/Desktop/Project/RiskCalculator/RiskCalc/CancerRiskCalculator/www/S6Men.rds")
# saveRDS(S3SmokeMen, file="/Users/huangs7/Desktop/Project/RiskCalculator/RiskCalc/CancerRiskCalculator/www/S3SmokeMen.rds")
# saveRDS(S4SmokeWomen, file="/Users/huangs7/Desktop/Project/RiskCalculator/RiskCalc/CancerRiskCalculator/www/S4SmokeWomen.rds")

