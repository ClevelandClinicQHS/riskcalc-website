#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(tidyverse)
library(glmnet)



# Load the lasso model fit
load("cvfit.rda")


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    # Take the input variables and create a dataframe
    # Then create dummy variables for use in the model
    newdat = reactive({
      tibble(
        # use most frequent value or median for the zero coefficients
        age_at_dx = 64,
        sexMale = ifelse(input$sex == "Male", 1, 0),
        `lateralityRight eye` = 0,
        symptomsYes = 0,
        `presenting_bcva20/20` = 0,
        `dist_to_on_mm>=3mm` = ifelse(input$dist_to_on_mm == ">=3mm", 1, 0),
        `dist_to_fov_mm>=3mm` = 0,
        initial_lbd_mm = 8,
        thickness = input$initial_max_height_mm,
        srf_initial = as.numeric(input$srf_initial),
        op_initial = as.numeric(input$op_initial),
        drusen_initial = as.numeric(input$drusen),
        rpe_atrophy_initial = 0) %>% 
        # then it needs to be a matrix
        as.matrix()
    })
    
    # Get predictions
    pred_mel = reactive({
      predict(
        cvfit, 
        newx = newdat(), 
        s = "lambda.min", 
        type = "response")
    })
    
    # Print the result as text
    output$pred_text <- renderText({
      paste0("The predicted probability of melanoma at present is ",
             round(pred_mel()[1, ]*100, 1),
             "%.")
    })

})
