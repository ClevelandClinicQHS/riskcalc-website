library(shiny)
library(magrittr)
library(boot)
# Define server logic required to draw a histogram
shinyServer(
  function(input, output) {
    
    output$text1 <- renderText({
      
      age <- input$Age
      radial <- input$radial
      td.fovea <- input$td.fovea
      td.disc <- input$td.disc
      VA50Worse <- input$VA50Worse %>%
        equals("Yes") %>%
        as.numeric
      
            predicted_risk_change <-     -2.6016484 - 
        0.029469454 * age + 
        3.0658266e-05 * max(age - 42, 0)**3 - 
        7.0647309e-05 * max(age - 63, 0)**3 + 
        3.9989043e-05 * max(age - 79.1, 0)**3 + 
        0.22178156 * radial + 
        0.025287581 * td.fovea - 
        1.6036589e-06 * max(td.fovea - 8.0855, 0)**3 + 
        2.1000639e-06 * max(td.fovea - 38.65, 0)**3 - 
        4.9640503e-07 * max(td.fovea - 137.39, 0)**3 + 
        0.0078956369 * td.disc + 
        0.61528157* VA50Worse
      
      predicted_risk  <- round(0.8905859 *inv.logit(predicted_risk_change) * 100, 0)
      
      paste(predicted_risk, "%.", sep = "")
      
    })
    
  })



# 
# 
# library(shiny)
# library(magrittr)
# library(boot)
# 
# shinyServer(
#   function(input, output) {
# 
#     output$text1 <- renderText({
#       
#       age <- input$Age
#       radial <- input$radial
#       td.fovea <- input$td.fovea
#       td.disc <- input$td.disc
#       VA50Worse <- input$VA50Worse %>%
#         equals("Yes") %>%
#         as.numeric
#       
#       predicted_risk_change <-     -2.4894145 - 0.028632193 * age + 
#         2.9843482e-05 * max(age -43, 0)**3 - 
#         6.7147835e-05 * max(age - 63, 0)**3 + 
#         3.7304353e-05 *max(age - 79, 0)**3 + 
#         0.21480105 * radial + 
#         0.026296495 * td.fovea - 
#         1.862242e-06 * max(td.fovea - 7.9611, 0)**3 + 
#         2.4301806e-06 * max(td.fovea - 37.835, 0)**3 - 
#         5.6793865e-07 * max(td.fovea - 135.79, 0)**3 + 
#         0.0074931521 * td.disc + 0.62295905 * VA50Worse
#       
#       
#       predicted_risk  <- round(0.8930421 *inv.logit(predicted_risk_change) * 100, 0)
#       
#       paste(predicted_risk, "%.", sep = "")
#       
#     })
#   
# })