#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(dplyr)
library(penalized)

# Load the lasso model fit
#load(here::here("shiny_app", "lasso_fit.rda"))
load("lasso_fit.rda")


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    # Take the input variables and create a dataframe
    # Then create dummy variables for use in the model
    newdat = reactive({
      tibble(
        quadrant_cats = input$quadrant,
        lbd = input$lbd,
        height = input$height,
        color_cats = "Melanotic",
        margins = "Sharp",
        pigment_dispersion = as.numeric(input$pigment_dispersion),
        vascularity_cats = as.numeric(input$feeder_intrinsic),
        iris_location = input$iris_location,
        ectropion_correctopia = as.numeric(input$ectropion_corectopia),
        angle_cbd = as.numeric(input$angle_cbd)
        ) %>%
        # Need to specify all levels for the factor variables
        mutate(
          quadrant_cats = factor(quadrant_cats, levels = c("Inferior-temporal", 
                                                           "Superior-nasal",    
                                                           "Superior-temporal", 
                                                           "Inferior-nasal")),
          color_cats = factor(color_cats, levels = c("Melanotic", 
                                                     "Partial", 
                                                     "Amelanotic")),
          margins = factor(margins, levels = c("Not defined", 
                                               "Sharp", 
                                               "Feathery")),
          iris_location = factor(iris_location, levels = c("Peripheral", 
                                                           "Pupillary", 
                                                           "Central", 
                                                           "Pan iris"))
        )
      })
      
    # Get predictions
    pred_mel = reactive({
      predict(
        object = fit1, 
        data = newdat())
    })
    
    # Print the result as text
    output$pred_text <- renderText({
      paste0("The predicted probability of melanoma is ",
             round(pred_mel()*100, 1),
             "%.")
    })

})
