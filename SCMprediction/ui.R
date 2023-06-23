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
    tags$head(tags$link(rel="shortcut icon", href="../assets/icons/favicon.ico", type="image/x-icon")),
    tags$head(tags$link(rel="apple-touch-icon", href="../assets/icons/apple-touch-icon.png", type="image/x-icon")),

    # Application title
    titlePanel("Small Choroidal Melanoma Predictor"),
    
    fluidRow(column(width = 12,
                    p("This predictor is applicable to patients with small choroidal melanocytic lesions (i.e. at least 1mm and not more than 3.5mm in height and/or at
least 1mm and not more than 15mm in largest basal diameter).")
                    )
             ),
    
    fluidRow(
        column(width = 4,
               radioButtons(
                 inputId = "dist_to_on_mm",
                 label = "Distance to optic disk (mm)",
                 choices = list("<3mm", ">=3mm")),
               radioButtons(
                   inputId = "sex",
                   label = "Sex",
                   choices = list("Male", "Female")),
               sliderInput(
                   inputId= "initial_max_height_mm",
                   label = "Height (mm)",
                   min = 1,
                   max = 2.5,
                   value = 1.5,
                   step = 0.1),
               checkboxInput(
                   inputId = "srf_initial",
                   label = "Subretinal fluid",
                   value = FALSE),
               checkboxInput(
                   inputId = "op_initial",
                   label = "Orange pigment",
                   value = FALSE),
               checkboxInput(
                   inputId = "drusen",
                   label = "Drusen",
                   value = FALSE)
               ),
        
        column(width = 8,
               align = "center",
               wellPanel(h2(textOutput("pred_text"))),
               wellPanel(h3('Reference'),p("[1] Zabor, E. C., Raval, V., Luo, S., Pelayes, D. E., & Singh, A. D. (2022). A Prediction Model to Discriminate Small Choroidal Melanoma from Choroidal Nevus. Ocular oncology and pathology, 8(1), 71–78. https://doi.org/10.1159/000521541")),
               wellPanel(h3('Disclaimer'),
                         p("No Medical Advice. ALTHOUGH SOME CONTENT MAY BE PROVIDED BY INDIVIDUALS IN THE MEDICAL PROFESSION, YOU ACKNOWLEDGE THAT PROVISION OF SUCH CONTENT DOES NOT CREATE A MEDICAL PROFESSIONAL-PATIENT RELATIONSHIP AND DOES NOT CONSTITUTE AN OPINION, MEDICAL ADVICE, PROFESSIONAL DIAGNOSIS, SERVICE OR TREATMENT OF ANY CONDITION. Access to general information is provided for educational purposes only, through this site and links to other sites. Content is not recommended or endorsed by any doctor or healthcare provider. The information and Content provided are not substitutes for medical or professional care, and you should not use the information in place of a visit, call, consultation or the advice of your physician or other healthcare provider. You are liable or responsible for any advice, course of treatment, diagnosis or any other information, services or product obtained through this site."))
               
               )
    )
))
