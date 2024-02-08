# Load packages
library(shiny)
library(shinythemes)
library(gbm)

## Import the metadata
load(file = "modeling_dataset_metadata.RData")

## Import the models

# Get the model list
model_list <- list.files("models")

# Iterate the list a load
for(i in model_list) 
  load(file = paste0("models/", i))

# Function to get predictions for an input set of predictors (for each antibiotic)
get_predictions <-
  function(pred_dat) {
    
    # Get the predictions from each model
    temp_preds <- 
      data.frame(
        Antibiotic = 
          c(
            "Ampicillin",
            "Cefazolin",
            "Cefepime",
            "Ceftriaxone",
            "Ciprofloxacin",
            "Gentamicins",
            "Meropenem",
            "Nitrofurantoin",
            "Piperacillin-Tazobactam Combination",
            "Trimethoprim-Sulfamethoxazole Combination",
            "Vancomycin"
          ),
        Susceptibility = 
          c(
            predict(ampicillin, newdata = pred_dat, n.trees = ampicillin$n.trees, type = "response"),
            predict(cefazolin, newdata = pred_dat, n.trees = cefazolin$n.trees, type = "response"),
            predict(cefepime, newdata = pred_dat, n.trees = cefepime$n.trees, type = "response"),
            predict(ceftriaxone, newdata = pred_dat, n.trees = ceftriaxone$n.trees, type = "response"),
            predict(ciprofloxacin, newdata = pred_dat, n.trees = ciprofloxacin$n.trees, type = "response"),
            predict(gentamicins, newdata = pred_dat, n.trees = gentamicins$n.trees, type = "response"),
            predict(meropenem, newdata = pred_dat, n.trees = meropenem$n.trees, type = "response"),
            predict(nitrofurantoin, newdata = pred_dat, n.trees = nitrofurantoin$n.trees, type = "response"),
            predict(piperacillin, newdata = pred_dat, n.trees = piperacillin$n.trees, type = "response"),
            predict(trimethoprim, newdata = pred_dat, n.trees = trimethoprim$n.trees, type = "response"),
            predict(vancomycin, newdata = pred_dat, n.trees = vancomycin$n.trees, type = "response")
          )
      )
    
    # Compute the resistance probability
    temp_preds$Resistance <- 1 - temp_preds$Susceptibility
    
    temp_preds
    
  }