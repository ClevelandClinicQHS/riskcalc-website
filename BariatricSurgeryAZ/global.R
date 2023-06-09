#Created: 2019-05-13
#Author: Alex Zajichek
#Project: Individualized Diabetes Complications Risk Scores
#Description: Initializes/loads objects when application is loaded

#Load packages
require(shiny)
require(dplyr)
require(DT)
library(yonder)
require(randomForestSRC)
library(shinyjs)

shiny::addResourcePath("shinyjs", system.file("srcjs", package = "shinyjs"))
#Load random forest model
load("CVD_surgery_rf_model_20190618.RData")

#Read in model coefficients
coefs <- 
  read.csv(
    file = "Medtronic_RegressionCoefficients_FORAPP_20190619.csv",
    header = TRUE,
    stringsAsFactors = FALSE,
    na.strings = c("", " ", "NA", "NULL")
  ) 

#Read in base risks
baserisk <-
  read.csv(
    file = "Medtronic_RegressionBaseRisks_20190619.csv",
    header = TRUE,
    stringsAsFactors = FALSE,
    na.strings = c("", " ", "NA", "NULL")
  )

#Get random forest prediction
predict_cvd_rf_10year <-
  function(dat) {
    dat$Treatment <- "Surgical"
    dat$Treatment <- factor(dat$Treatment, levels = c("Surgical", "Nonsurgical"))
    
    preds <-
      predict(
        CVD_surgery_rf_model,
        dat
      )$cif[,,2]
    
    preds[length(preds)]
  }

#Function to get risks from regression models
regression_risks <-
  function(dat) {
    model.matrix(
      ~.,
      data = dat
    ) %>%
      as.data.frame() %>%
      tidyr::gather(
        key = "Variable",
        value = "Multiplier"
      ) %>%
      inner_join(y = coefs, by = "Variable") %>%
      mutate(
        Value = Value*Multiplier
      ) %>%
      group_by(
        Model,
        Outcome
      ) %>%
      summarise(
        Value = sum(Value)
      ) %>%
      ungroup %>%
      inner_join(
        y = baserisk,
        by = c("Model", "Outcome")
      ) %>%
      mutate(
        Risk = 
          case_when(
            Type == "survreg" ~ 1 - BaseRisk^(1 / exp(Value)),
            Type == "coxph" ~ 1 - exp(-BaseRisk)^(exp(Value)),
            TRUE ~ 1 - BaseRisk^(exp(Value))
          )
      )
  }