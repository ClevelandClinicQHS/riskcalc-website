# Created: 2024-02-14
# Author: Alex Zajichek
# Project: Predicting hydrocephalus after hemispherectomy
# Description: App global objects

# Load packages
library(shiny)
library(shinythemes)
library(survival)

# Load model
load(file = "prod_model.RData")

# Set the baseline hazard
base_haz1 <- prod_model$BaselineHazard
