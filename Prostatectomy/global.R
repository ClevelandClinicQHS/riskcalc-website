# Created: 2024-07-22
# Author: Alex Zajichek
# Project: Risk of dying from prostate cancer
# Description: App global objects

# Load packages
library(shiny)
library(shinythemes)
library(ggplot2)
library(ggimage)
library(shinyWidgets)
library(shinycssloaders)
library(readxl)
library(dplyr)
library(stringr)
library(tibble)

## Import lookup tables

# Age
age_lookup <-
  read_excel(
    path = "MLE Model Coefficients + Lookup Values.xlsx",
    sheet = "Age"
  ) %>%
  mutate(
    Age = as.numeric(str_remove(str_remove(Name, pattern = "^Age_"), pattern = "_15$"))
  )

# Comorbidity
comorbidity_lookup <-
  read_excel(
    path = "MLE Model Coefficients + Lookup Values.xlsx",
    sheet = "Comorbidity"
  )

# Utility function to get the OR value
get_OR <- function(string) comorbidity_lookup$Value[comorbidity_lookup$Alias == string]

# Untreated PCA
untreated_pca_lookup <- 
  read_excel(
    path = "MLE Model Coefficients + Lookup Values.xlsx",
    sheet = "Untreated PCa"
  ) %>%
  
  # Parse the numeric value
  mutate(
    PreOpBCR = as.numeric(str_extract(Alias, pattern = "[0-9]{2}$"))
  )

untreated_pca_lookup <-
  
  # Make the full lookup range
  tibble(
    PreOpBCR = seq(0, 100)
  ) %>%
  
  # Join to get populated values
  left_join(
    y = untreated_pca_lookup,
    by = "PreOpBCR"
  ) %>%
  
  # Update the 
  mutate(
    Value =
      case_when(
        !is.na(Value) ~ Value,
        PreOpBCR < min(untreated_pca_lookup$PreOpBCR) ~ min(Value, na.rm = TRUE),
        PreOpBCR > max(untreated_pca_lookup$PreOpBCR) ~ max(Value, na.rm = TRUE)
      )
  ) %>%
  
  # Keep a couple columns
  select(
    PreOpBCR,
    Value
  ) 

# Treated PCA
treated_pca_lookup <- 
  read_excel(
    path = "MLE Model Coefficients + Lookup Values.xlsx",
    sheet = "Treated PCa"
  ) %>%
  
  # Parse the numeric value
  mutate(
    PreOpBCR = as.numeric(str_extract(Alias, pattern = "[0-9]{2}$"))
  )

treated_pca_lookup <-
  
  # Make the full lookup range
  tibble(
    PreOpBCR = seq(0, 100)
  ) %>%
  
  # Join to get populated values
  left_join(
    y = treated_pca_lookup,
    by = "PreOpBCR"
  ) %>%
  
  # Update the 
  mutate(
    Value =
      case_when(
        !is.na(Value) ~ Value,
        PreOpBCR < min(treated_pca_lookup$PreOpBCR) ~ min(Value, na.rm = TRUE),
        PreOpBCR > max(treated_pca_lookup$PreOpBCR) ~ max(Value, na.rm = TRUE)
      )
  ) %>%
  
  # Keep a couple columns
  select(
    PreOpBCR,
    Value
  ) 

