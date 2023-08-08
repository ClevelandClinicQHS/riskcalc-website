#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Iris Melanoma Predictor"),
    
    fluidRow(column(width = 12,
                    p("This predictor is applicable to patients with iris melanocytic tumors.")
                    )
             ),
    fluidRow(column(width = 12,
                    p("Note that in the development data, tumor seeding, glaucoma, and hyphema were present only in melanoma patients and therefore could not be included in the prediction model as they represented perfect prediction in these data.")
    )
    ),
    fluidRow(
        column(width = 4,
               sliderInput(
                 inputId= "lbd",
                 label = "Largest basal diameter (mm)",
                 min = 0.5,
                 max = 11.1,
                 value = 3,
                 step = 0.1),
               sliderInput(
                 inputId= "height",
                 label = "Height (mm)",
                 min = 0.2,
                 max = 4.2,
                 value = 1,
                 step = 0.1),
               radioButtons(
                 inputId = "iris_location",
                 label = "Iris location",
                 choices = list("Peripheral", 
                                "Pupillary", 
                                "Central", 
                                "Pan iris")),
               radioButtons(
                 inputId = "quadrant",
                 label = "Quadrantic location",
                 choices = list("Inferior-temporal", 
                                "Superior-nasal",    
                                "Superior-temporal", 
                                "Inferior-nasal")),
               strong("Other present features"),
               checkboxInput(
                 inputId = "pigment_dispersion",
                 label = "Pigment dispersion",
                 value = FALSE),
               checkboxInput(
                 inputId = "feeder_intrinsic",
                 label = "Feeder  or intrinsic vessel",
                 value = FALSE),
               checkboxInput(
                 inputId = "ectropion_corectopia",
                 label = "Ectropion uvea or corectopia",
                 value = FALSE),
               checkboxInput(
                 inputId = "angle_cbd",
                 label = "Angle or iris root involvement",
                 value = FALSE),
               p(
                 a("Source Code", 
                   href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/IrisMel", 
                   style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
                 ),
                 style = "text-align: center;"
               )
               ),
        
        column(width = 8,
               align = "center",
               h3(textOutput("pred_text"))
               )
    )
))
