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
      0.02769738 * age + 
      0.046519389 * sex +
      0.21534249 * race + 
      0.25066223 * ethnicity + 
      0.10339145 * metastasis + 
      0.111154 * smoking + 
      0.48221815 * ecog
    
    # Set the baseline hazard
    bh <- 0.06214834
    
    # Survival probability
    exp(-bh * exp(lp))
    
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
      -0.0093463464 * age + 
      3.7117113e-06 * max(age - 40, 0)**3 + 
      -1.0100723e-05 * max(age - 61, 0)**3 + 
      6.3890113e-06 * max(age - 73.2, 0)**3 + 
      -0.49016314 * sex + 
      -0.16773575 * race + 
      0.16788119 * ethnicity + 
      -0.014728896 * metastasis + 
      0.4234505 * smoking + 
      -0.41680141 * ecog
    
    # Set the baseline hazard
    bh <- 1.306852
    
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
      -0.025575253 * age + 
      1.4529833e-05 * max(age - 40, 0)**3 + 
      -3.9540201e-05 * max(age - 61, 0)**3 + 
      2.5010368e-05 * max(age - 73.2, 0)**3 + 
      -0.31854392 * sex + 
      0.43738733 * race + 
      0.70659194 * ethnicity + 
      -0.251373 * metastasis + 
      -0.12175779 * smoking + 
      -0.53180406 * ecog
    
    # Set the baseline hazard
    bh <- 8.809191
    
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
      -0.010155196 * age + 
      -2.40357e-05 * max(age - 40, 0)**3 + 
      6.5408625e-05 * max(age - 61, 0)**3 + 
      -4.1372925e-05 * max(age - 73.2, 0)**3 + 
      -0.11610836 * sex +
      -0.0251625 * race + 
      0.75390202 * ethnicity +
      -0.08885298 * metastasis + 
      0.33632951 * smoking + 
      0.28792515 * ecog
    
    # Set the baseline hazard
    bh <- 1.005674
    
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
      0.045518845 * age +
      -2.2513831e-05 * max(age - 40, 0)**3 + 
      6.1267148e-05 * max(age - 61, 0)**3 +
      -3.8753316e-05 * max(age - 73.2, 0)**3 +
      -0.62035233 * sex +
      -0.44344806 * race + 
      0.040175353 * ethnicity +
      -0.22403732 * metastasis + 
      0.21447126 * smoking + 
      0.1256404 * ecog
    
    # Set the baseline hazard
    bh <- 0.1105714
    
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
      0.030870855 * age + 
      -4.3204299e-05 * max(age - 40, 0)**3 + 
      0.00011757235 * max(age - 61, 0)**3 +
      -7.4368056e-05 * max(age - 73.2, 0)**3 +
      -0.31250556 * sex + 
      -0.053560863 * race + 
      0.4128901 * ethnicity +
      -1.0495525 * metastasis +
      -0.083692145 * smoking +
      -0.14383037 * ecog
    
    # Set the baseline hazard
    bh <- 0.3087803
    
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
      0.0085633215 * age + 
      0.22785173 * sex + 
      0.20643154 * race + 
      0.24860545 * ethnicity + 
      0.015177977 * metastasis + 
      0.32301552 * smoking +
      -0.11723563 * ecog
    
    # Set the baseline hazard
    bh <- 2.122848
    
    # Risk of event
    1 - exp(-bh * exp(lp))
    
  }