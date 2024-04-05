# Created: 2024-04-05
# Author: Alex Zajichek
# Project: Lorlatinib
# Description: App global objects

# Load packages
library(shiny)
library(shinythemes)

## Define functions to compute predicted risks

# In each function, age is a number, everything else must be a boolean (or 1/0)

# Progression (5-year)
f_progression <- 
  function(
      age,
      sex,
      race,
      ethnicity,
      metastasis,
      smoking,
      ecog
    ) {
    
    # Linear predictor
    lp <- 
      0.0277 * age +
      0.0465 * sex +
      0.2153 * race +
      0.2507 * ethnicity +
      0.1034 * metastasis +
      0.1112 * smoking +
      0.4822 * ecog
    
    # Set the baseline hazard
    bh <- .5
    
    # Risk of event
    1 - exp(-bh * exp(lp))
    
  }

# CNS (5-year)
f_cns <- 
  function(
    age,
    sex,
    race,
    ethnicity,
    metastasis,
    smoking,
    ecog
  ) {
    
    # Linear predictor
    lp <-
      -0.0093 * age +
      0.0041 * max(age - 50, 0)**3 +
      -0.4902 * sex + 
      -0.1677 * race + 
      0.1679 * ethnicity + 
      -0.0147 * metastasis + 
      0.4235 * smoking + 
      -0.4168 * ecog
    
    # Set the baseline hazard
    bh <- .5
    
    # Risk of event
    1 - exp(-bh * exp(lp))
    
  }

# Hyperlipidemia (1-year)
f_hyperlipidemia <- 
  function(
    age,
    sex,
    race,
    ethnicity,
    metastasis,
    smoking,
    ecog
  ) {
    
    # Linear predictor
    lp <-
      -0.0256 * age +
      0.016 * max(age - 50, 0)**3 +
      -0.3185 * sex +
      0.4374 * race +
      0.7066 * ethnicity +
      -0.2514 * metastasis +
      -0.1218 * smoking +
      -0.5318 * ecog
    
    # Set the baseline hazard
    bh <- .5
    
    # Risk of event
    1 - exp(-bh * exp(lp))
    
  }

# Weight gain (5-year)
f_weight <- 
  function(
    age,
    sex,
    race,
    ethnicity,
    metastasis,
    smoking,
    ecog
  ) {
    
    # Linear predictor
    lp <-
      -0.0102 * age +
      -0.0265 * max(age - 50, 0)**3 +
      -0.1161 * sex +
      -0.0252 * race +
      0.7539 * ethnicity + 
      -0.0889 * metastasis +
      0.3363 * smoking + 
      0.2879 * ecog
    
    # Set the baseline hazard
    bh <- .5
    
    # Risk of event
    1 - exp(-bh * exp(lp))
    
  }

# Edema (5-year)
f_edema <- 
  function(
    age,
    sex,
    race,
    ethnicity,
    metastasis,
    smoking,
    ecog
  ) {
    
    # Linear predictor
    lp <-
      0.0455 * age + 
      -0.0248 * max(age - 50, 0)**3 +
      -0.6204 * sex + 
      -0.4434 * race +
      0.0402 * ethnicity +
      -0.224 * metastasis +
      0.2145 * smoking + 
      0.1256 * ecog
    
    
    # Set the baseline hazard
    bh <- .5
    
    # Risk of event
    1 - exp(-bh * exp(lp))
    
  }

# Peripheral neuropathy (5-year)
f_peripheral <- 
  function(
    age,
    sex,
    race,
    ethnicity,
    metastasis,
    smoking,
    ecog
  ) {
    
    # Linear predictor
    lp <-
      0.0309 * age +
      -0.0476 * max(age - 50, 0)**3 +
      -0.3125 * sex + 
      -0.0536 * race + 
      0.4129 * ethnicity +
      -1.0496 * metastasis +
      -0.0837 * smoking + 
      -0.1438 * ecog
    
    # Set the baseline hazard
    bh <- .5
    
    # Risk of event
    1 - exp(-bh * exp(lp))
    
  }

# Any G3/G4 (5-year)
f_g3g4 <- 
  function(
    age,
    sex,
    race,
    ethnicity,
    metastasis,
    smoking,
    ecog
  ) {
    
    # Linear predictor
    lp <-
      0.0086 * age + 
      0.2279 * sex +
      0.2064 * race + 
      0.2486 * ethnicity +
      0.0152 * metastasis +
      0.323 * smoking +
      -0.1172 * ecog
    
    # Set the baseline hazard
    bh <- .5
    
    # Risk of event
    1 - exp(-bh * exp(lp))
    
  }
