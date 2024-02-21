# Load packages
library(shiny)
library(shinythemes)
library(survival)
library(rms)

# Load model
load(file = "cv.fit2.RData")

# Make a data frame from the input data
x_dat <- data.frame(ct.fit2$x)

# Extract the 10-year (centered) baseline hazard
base_haz <- basehaz(ct.fit2)
base_haz10 <- base_haz$hazard[which.min(abs(base_haz$time/365.25 - 10))]