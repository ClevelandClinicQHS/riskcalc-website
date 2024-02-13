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
  function(pred_dat, with_results) {
    
    # Get the right model
    if(!with_results) {
      
      ampicillin <- ampicillin_before
      cefazolin <- cefazolin_before
      cefepime <- cefepime_before
      ceftriaxone <- ceftriaxone_before
      ciprofloxacin <- ciprofloxacin_before
      gentamicins <- gentamicins_before
      meropenem <- meropenem_before
      nitrofurantoin <- nitrofurantoin_before
      piperacillin <- piperacillin_before
      trimethoprim <- trimethoprim_before
      vancomycin <- vancomycin_before
      
    } else {
      
      ampicillin <- ampicillin_after
      cefazolin <- cefazolin_after
      cefepime <- cefepime_after
      ceftriaxone <- ceftriaxone_after
      ciprofloxacin <- ciprofloxacin_after
      gentamicins <- gentamicins_after
      meropenem <- meropenem_after
      nitrofurantoin <- nitrofurantoin_after
      piperacillin <- piperacillin_after
      trimethoprim <- trimethoprim_after
      vancomycin <- vancomycin_after
      
    }
    
    
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
            "Gentamicin",
            "Meropenem",
            "Nitrofurantoin",
            "Piperacillin-Tazobactam",
            "Trimethoprim-Sulfamethoxazole",
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

# Function to populate organism list
organisms <- names(modeling_dataset_metadata)[grepl("_Positive$", names(modeling_dataset_metadata))]
indicate_organisms <- 
  function(org_list) {
    
    # Check if the organism is in the selected set
    in_set <- ifelse(organisms %in% org_list, "Y", "N")
    
    # Make a transposed data frame
    temp <- t(data.frame(organisms, in_set))
    
    # Set the column names
    colnames(temp) <- temp[1,]
    
    # Convert to data frame
    temp <- as.data.frame(temp, row.names = NA)
    
    # Remove the row
    temp <- temp[-1,]
    
    # Convert to factor
    for(i in 1:ncol(temp))
      temp[,i] <- as.factor(temp[,i])
    
    temp
    
  }