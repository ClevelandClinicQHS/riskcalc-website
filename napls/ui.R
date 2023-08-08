library(shiny)
library(shinyjs)

shinyUI(
    fluidPage(
        shinyjs::useShinyjs(),
        tags$head(tags$link(rel="shortcut icon", href="../assets/icons/favicon.ico", type="image/x-icon")),
        tags$head(tags$link(rel="apple-touch-icon", href="../assets/icons/apple-touch-icon.png", type="image/x-icon")),
        div(id = "napls",
            h1("An Individualized Risk Calculator for Psychosis",style = "color:ForestGreen"),
            h4("For more information on Prodromal Risk Syndromes and risk assessment, see ",
             a(tags$i("NAPLS"),
                                    href = "http://campuspress.yale.edu/napls/", style = "color:DodgerMediumBlue",target = "_blank")),
            h4("For more information on derivation and uses of this risk calculator, see ",
               a(tags$i("Cannon et al."),
                 href = "http://www.ncbi.nlm.nih.gov/pubmed/27363508", style = "color:DodgerMediumBlue",target = "_blank")),
            h5("Please check the box if your answer is yes"),
            checkboxInput("sips", "Does the patient have an interview-based SIPS diagnosis of a prodromal risk syndrome?", FALSE),
            checkboxInput("prof", "Were the ratings and test scores obtained by a professional?", FALSE),
            shinyjs::hidden(
                div(id = "display",
                    fluidRow(
                        column(4,
                               wellPanel(
                                   sliderInput("DEMO_AGE_YM", "Patient's age (Years)", value = 12, min = 12, max = 35),
                                   sliderInput("BACS_RAW", "Neuropsych BACS Symbol Coding Raw Score", value = 110, min = 0, max = 110),
                                   sliderInput("HVLT_TOTAL", "Neuropsych HVLT-R Total Raw Score", value = 36, min = 0, max = 36),
                                   sliderInput("UNDES_LIFE_EVENTS_TOTAL", "The undesirable life events score", value = 0, min = 0, max = 31),
                                   sliderInput("TOTAL_TRAUMA", "Number of types of trauma endorsed ", value = 0, min = 0, max = 6),
                                   sliderInput("P1P2", "Sum of rescaled SIPS ratings for unusual thought content (P1) and suspiciousness (P2)", value = 0, min = 0, max = 8),
                                   sliderInput("GFS_DECLINE_PAST_YEAR", "Change in Global social functioning in year prior to baseline", value = 0, min = 0, max = 6),
                                   selectInput("GENETIC_RISK", "Have first degree relative with a psychotic illness?",
                                               choices = c("No", "Yes"))
                               )),
                        column(8,
                               h2("1-year and 2-year probability of conversion to psychosis",
                                  style = "color:ForestGreen",align = "center"),
                               plotOutput("piePlot"),
                               h3("This calculator was based on a Cox proportional hazards regression model","that was developed from a cohort consisting 596 clinical high risk  participants from the second phase of the North American Prodrome Longitudinal Study(",
                                  a(tags$i("NAPLS"),
                                    href = "http://napls.commons.yale.edu/", style = "color:DodgerMediumBlue",target = "_blank"),")"))
                    ))
            ),
            p(
              a("Source Code", 
                href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/napls", 
                style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
              )
            )
            )
    )
)

