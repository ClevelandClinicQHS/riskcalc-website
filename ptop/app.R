##########################################################
# 
# Description
#
#
#

###############################
# Libraries
## Shiny libraries
library(shiny)
library(shinycssloaders)
library(shinythemes)
library(shinydashboard)
library(shinyWidgets)
library(shinyBS)
# library(DT)

## Data formatting
library(tidyverse)

## Model
# library(timereg)
library(rms)

## Visualization
# library(personograph)


###############################
# Load models
survival_simple <- readRDS("models/cph_surv_full.rds")
pa_simple <- readRDS("models/cph_pa_full.rds")
ki_simple <- readRDS("models/cph_ki_full.rds")


###############################
# Define constants
# Most limits were taken from the 1%/50%/99% quantile values 
# of the data calculated in the data_description file (close enough at least)
default_kidney <- TRUE
default_other_organs <- FALSE
default_kidney_transplants <- FALSE
default_rescue_allocation <- FALSE
min_recipient_age <- 25
default_recipient_age <- 45
max_recipient_age <- 60
min_waiting_time <- 0.01
default_waiting_time <- 1
max_waiting_time <- 6
min_donor_age <- 6
default_donor_age <- 30
max_donor_age <- 54
min_recipient_bmi <- 17
default_recipient_bmi <- 25
max_recipient_bmi <- 34


min_prediction_days <- 1
max_prediction_days <- min(4376)#dwfg_model$cum[nrow(dwfg_model$cum),1], fail_model$cum[nrow(fail_model$cum),1], 
min_prediction_yrs <- ceiling(min_prediction_days/365.25)
max_prediction_yrs <- floor(max_prediction_days/365.25)

# Prediction times for simple calculator in days
simple_times <- 365.25 * c(5, 10)


# Colors for personographs
main_colour <- "#d9230f"
surv_colour <- "#5eaaa8"
death_colour <- "#f05945"
pa_colour <- "#ffb26b"
ki_colour <- "#ffd56b"
na_colour <- "#808080"

# Disclaimer string
disclaimer_str <- HTML("<br><br><p align='justify'; style='color:gray'><font size='2'>Disclaimer: 
No Medical Advice. ALTHOUGH SOME CONTENT MAY BE PROVIDED BY 
INDIVIDUALS IN THE MEDICAL PROFESSION, YOU ACKNOWLEDGE THAT 
PROVISION OF SUCH CONTENT DOES NOT CREATE A MEDICAL 
PROFESSIONAL-PATIENT RELATIONSHIP AND DOES NOT CONSTITUTE AN 
OPINION, MEDICAL ADVICE, PROFESSIONAL DIAGNOSIS, SERVICE OR 
TREATMENT OF ANY CONDITION. Access to general information is 
provided for educational purposes only, through this site and 
links to other sites. Content is not recommended or endorsed 
by any doctor or healthcare provider. The information and 
Content provided are not substitutes for medical or 
professional care, and you should not use the information in 
place of a visit, call, consultation or the advice of your 
physician or other healthcare provider. You are liable or 
responsible for any advice, course of treatment, diagnosis or 
any other information, services or product obtained through 
this site.</font></p>"
)



#################################################################################
#
# Define UI
#
######################
ui <- fluidPage(
  
  navbarPage(span(
    span("PTOP ", style = "color: #d9230f; font-size: 30px; font-weight: 550;"), # font-weight: bold;
    "Pancreas Transplant Outcome Prediction"), 
    windowTitle = "PTOP: Pancreas transplant outcome prediction", 
    theme = shinytheme("simplex"), #journal
    
    ###### Here : insert shinydashboard dependencies ######
    header = tagList(
      useShinydashboard()
    ),
    
    
    
    #################################################################################
    # Simple calculator - UI
    ######################
    tabPanel("Calculator", fluid = TRUE, icon = icon("percentage"),#percentage,chart-bar
             fluidRow(
               column(10, align="center", offset=1, 
                      shinydashboard::box(width=20, title="Required information",
                                          
                                          div(style="vertical-align:top;display:inline-block;width:130px;
                                          text-align:left;margin-right:30px;",
                                              radioButtons("kidney_simple",
                                                           HTML("Simultaneous transplant of kidney"),
                                                           c("Yes"="TRUE",
                                                             "No"="FALSE"),
                                                           selected="TRUE", 
                                                           inline=FALSE)),
                                          
                                          div(style="vertical-align:top;display:inline-block;width:130px;
                                          text-align:left;margin-right:30px;",
                                              radioButtons("other_organs_simple",
                                                           HTML("Simultaneous transplant of other organs"),
                                                           c("Yes"="TRUE",
                                                             "No"="FALSE"),
                                                           selected="FALSE", 
                                                           inline=FALSE)),
                                          
                                          div(style="vertical-align:top;display:inline-block;width:130px;
                                          text-align:left;margin-right:30px;",
                                              radioButtons("previous_kidney_simple",
                                                           HTML("Previous kidney transplant"),
                                                           c("Yes"="TRUE", 
                                                             "No"="FALSE"),
                                                           selected="FALSE",
                                                           inline=FALSE)),
                                          
                                          div(style="vertical-align:top;display:inline-block;width:130px;
                                          text-align:left;margin-right:30px;",
                                              radioButtons("rescue_simple",
                                                           HTML("Allocation by Rescue program"),
                                                           c("Yes"="TRUE", 
                                                             "No"="FALSE"),
                                                           selected="FALSE",
                                                           inline=FALSE)),
                                          
                                          tags$br(), 
                                          tags$br(), 
                                          
                                          div(style="vertical-align:top;display:inline-block;width:130px;
                                          text-align:left;margin-right:30px;",
                                              numericInput("donorage_simple",
                                                           HTML("Donor age"),
                                                           value=default_donor_age,
                                                           min=min_donor_age,
                                                           max=max_donor_age,
                                                           width="80%"),
                                              bsTooltip(id="donorage_simple",
                                                        title=paste0("Age of transplant donor in years at transplant time"),
                                                        placement = "bottom", trigger = "hover")),
                                          
                                          div(style="vertical-align:top;display:inline-block;width:130px;
                                          text-align:left;margin-right:30px;",
                                              numericInput("recipientage_simple",
                                                           HTML("Recipient age"),
                                                           value=default_recipient_age,
                                                           min=min_recipient_age,
                                                           max=max_recipient_age,
                                                           width="80%"),
                                              bsTooltip(id="recipientage_simple",
                                                        title=paste0("Age of transplant recipient in years at transplant time"),
                                                        placement = "bottom", trigger = "hover")),
                                          
                                          div(style="vertical-align:top;display:inline-block;width:130px;
                                          text-align:left;margin-right:30px;",
                                              numericInput("recipientbmi_simple",
                                                           HTML("Recipient BMI"),
                                                           value=default_recipient_bmi,
                                                           min=min_recipient_bmi,
                                                           max=max_recipient_bmi,
                                                           width="80%"),
                                              bsTooltip(id="recipientbmi_simple",
                                                        title=paste0("BMI of recipient at transplant time"),
                                                        placement = "bottom", trigger = "hover")),
                                          
                                          div(style="vertical-align:top;display:inline-block;width:130px;
                                          text-align:left;margin-right:30px;",
                                              numericInput("waitingyears_simple",
                                                           HTML("Waiting time"),
                                                           value=default_waiting_time,
                                                           min=min_waiting_time,
                                                           max=max_waiting_time,
                                                           width="80%"),
                                              bsTooltip(id = "waitingyears_simple",
                                                        title=paste0("Waiting time until transplant in years"),
                                                        placement = "bottom", trigger = "hover")),
                                          
                                          tags$br(), 
                                          tags$br(), 
                                          
                                          div(
                                            actionButton("calculate_simple", 
                                                         "Calculate", 
                                                         style="width: 200px"))
                      )
               )),
             fluidRow(
               column(10, align="center", offset=1, 
                      shinydashboard::box(width=20, title="Risk estimation",
                                          htmlOutput("basic_waiting_for_input"), 
                                          splitLayout(
                                            htmlOutput("simple_surv_text"),
                                            plotOutput("simple_mortality", height="50%"),
                                            cellArgs = list(style = "vertical-align: middle; white-space: normal;"),
                                            cellWidths = c("60%", "40%")
                                          ), 
                                          splitLayout(
                                            htmlOutput("simple_pa_text"),
                                            plotOutput("simple_pa", height="50%"),
                                            cellArgs = list(style = "vertical-align: middle; white-space: normal;"),
                                            cellWidths = c("60%", "40%")
                                          ), 
                                          splitLayout(
                                            htmlOutput("simple_ki_text"),
                                            plotOutput("simple_ki", height="50%"),
                                            cellArgs = list(style = "vertical-align: middle; white-space: normal;"),
                                            cellWidths = c("60%", "40%")
                                          )
                      ),
                      # htmlOutput("simple_pa_text"), 
                      # htmlOutput("simple_ki_text"), 
                      tags$br(), 
                      tags$br()
               )
             ), 
             
             fluidRow(
               column(12, align="center", offset=1, 
                      shinydashboard::box(width=10, title="Overview of your last calculations",
                                          withSpinner(DT::dataTableOutput("predict_table", width="100%")),
                                          # tableOutput("predict_table"),
                                          br()
                      ))
             ),
             disclaimer_str
    ),
    
    
    
    #################################################################################
    # About - UI
    ######################
    tabPanel("Information", fluid = TRUE, icon = icon("info"),
             fluidRow(
               column(6, offset=1, 
                      shinydashboard::box(width=12, title="Information",
                                          HTML("<p align='justify'>
                                                                <b>PTOP</b> allows the prediction of outcomes 
                                                                after the transplantation of a pancreas from a deceased donor. 
                                                                It estimates the risk of death, pancreas graft loss, and 
                                                                - in the case of a simultaneous kidney transplantation - 
                                                                kidney graft loss.
                                                                All calculations are based on data from Eurotransplant, the largest 
                                                                international European organ allocation organization.
                                                            </p>"), 
                                          # define class for indentation class of div
                                          tags$style(HTML("
                                                            .indent {
                                                            padding-left: 1.5em;
                                                            text-indent:-1.5em;
                                                            vertical-align: top;
                                                            }")), 
                                          HTML("<p align='justify'><b>Term explanations</b><br>
                                                                <div class='indent'>
                                                                    <i>BMI</i><br>
                                                                    Body mass index - it is calculated as the mass in 
                                                                    kilograms divided by the squared height in metres.
                                                                </div>
                                                                <div class='indent'>
                                                                    <i>Rescue</i><br>
                                                                    When the standard allocation of Eurotransplant fails, organs 
                                                                    may be allocated via an expedited allocation. Here, this Rescue 
                                                                    allocation also includes the so-called Extended allocation.
                                                                </div>
                                                                <br>
                                                            </p>"), 
                                          HTML("<p align='justify'>
                                                                <b>Reference</b>
                                                                <br>
                                                                G. Miller, et al. 
                                                                <i>Pancreas Transplantation Outcome Predictions (PTOP): 
                                                                A Risk Prediction Tool for Pancreas Transplants from Deceased Donors 
                                                                Based on a Large European Cohort</i>, in submission.
                                                            </p><br>"), 
                                          HTML("<p align='justify'>
                                                                <b>Affiliations</b>
                                                                <br>
                                                                <div class='indent'>
                                                                    Technical University of Munich
                                                                </div>
                                                                <div class='indent'>
                                                                    Cleveland Clinic
                                                                </div>
                                                                Eurotransplant International Foundation
                                                                <br>
                                                            </p>")
                      )
               )
             ), 
             disclaimer_str
    )
    
  )
)











#https://shiny.rstudio.com/gallery/ncaa-swim-team-finder.html
#https://shiny.rstudio.com/gallery/nutrition-calculator.html
#add tooltip: https://ebailey78.github.io/shinyBS/docs/Tooltips_and_Popovers.html

#################################################################################
#
# Define server logic
#
######################
server <- function(input, output) {
  #################################################################################
  # Simple calculator
  ######################
  
  
  #################################################################################
  # Check if the 'Calculate' button has been pressed already
  output$basic_waiting_for_input <- renderUI({
    if(input$calculate_simple==0){
      str <- "Press 'Calculate' to predict the transplant success of a deceased-donor pancreas"
      HTML(paste("<div style='text-align:center'><FONT size='3pt'>", str, "</FONT></div>"))
    }
  })
  
  #################################################################################
  # Create dataframe with all properties and resulting prediction
  predict_dt_simple <- eventReactive(input$calculate_simple, {
    
    
    ## Categorical values
    Kidney <- as.logical(input$kidney_simple)
    Other_organs <- as.logical(input$other_organs_simple)
    previous_ki_transplants <- as.logical(input$previous_kidney_simple)
    Rescue_allocation <- as.logical(input$rescue_simple)
    Recipient.age <- as.numeric(input$recipientage_simple)
    Donor.age <- as.numeric(input$donorage_simple)
    waiting_time_years <- as.numeric(input$waitingyears_simple)
    Recipient.BMI <- as.numeric(input$recipientbmi_simple)
    
    
    # Crossing is needed if we have multiple values for one or more variables
    predict_dt_simple <- crossing(Kidney, Other_organs, previous_ki_transplants, 
                                  Rescue_allocation, Recipient.age, Donor.age, 
                                  waiting_time_years, Recipient.BMI)
    
    # Calculate variables
    predict_dt_simple <- predict_dt_simple %>%
      mutate(
        Kidney_recipient_age = case_when(!Kidney ~ 0, 
                                         Kidney ~ Kidney * Recipient.age), 
        Recipient_bmi_kidney_previous = case_when(!previous_ki_transplants ~ 0, 
                                                  previous_ki_transplants ~ Recipient.BMI * previous_ki_transplants)
      ) %>% 
      as.data.frame()
    
    result_dt_simple <- data.frame()
    
    
    
    
    for(i in 1:nrow(predict_dt_simple)){
      
      pred_simple_surv <- survest(survival_simple, newdata=predict_dt_simple[i,], times=simple_times)
      pred_simple_pa <- survest(pa_simple, newdata=predict_dt_simple[i,], times=simple_times)
      pred_simple_ki <- survest(ki_simple, newdata=predict_dt_simple[i,], times=simple_times)
      
      # Save survival probability estimates
      result_dt_simple <- cbind(predict_dt_simple[i,],
                                prediction_horizon = simple_times,
                                surv = as.vector(pred_simple_surv$surv), 
                                surv_lower = as.vector(pred_simple_surv$lower), 
                                surv_upper = as.vector(pred_simple_surv$upper), 
                                pa = as.vector(pred_simple_pa$surv), 
                                pa_lower = as.vector(pred_simple_pa$lower), 
                                pa_upper = as.vector(pred_simple_pa$upper), 
                                ki = as.vector(pred_simple_ki$surv), 
                                ki_lower = as.vector(pred_simple_ki$lower), 
                                ki_upper = as.vector(pred_simple_ki$upper), 
                                row.names=NULL) %>%
        rbind(result_dt_simple, ., row.names=NULL) %>% 
        mutate(pred_horizon_years = paste(round(prediction_horizon/365.25), "years")) %>% 
        mutate(pred_horizon_years = reorder(pred_horizon_years, prediction_horizon))
    }
    result_dt_simple
    
  })
  
  
  #################################################################################
  # Create output table
  latest_predictions <- reactiveValues(df = data.frame(Kidney=character(), Other_organs=character(), previous_ki_transplants=character(), 
                                                       Rescue_allocation=character(), Recipient.age=numeric(), Donor.age=numeric(), 
                                                       waiting_time_years=numeric(), Recipient.BMI=numeric(), Kidney_recipient_age=numeric(), 
                                                       Recipient_bmi_kidney_previous=numeric(), prediction_horizon=numeric(),
                                                       surv=numeric(), 
                                                       surv_lower=numeric(), 
                                                       surv_upper=numeric(), 
                                                       pa=numeric(), 
                                                       pa_lower=numeric(), 
                                                       pa_upper=numeric(), 
                                                       ki=numeric(), 
                                                       ki_lower=numeric(), 
                                                       ki_upper=numeric()))
  
  
  newEntry <- observeEvent(input$calculate_simple,{
    latest_predictions$df <- rbind(predict_dt_simple(), latest_predictions$df)
    if(nrow(latest_predictions$df)>10) latest_predictions$df <- latest_predictions$df[1:10,]
  })
  
  
  output$predict_table <- DT::renderDataTable(
    DT::datatable({
      latest_predictions$df %>%
        mutate(prediction_horizon = round(prediction_horizon/365.25),
               surv = round(100*surv),
               pa = round(100*pa),
               ki = round(100*ki)) %>%
        select(`Time [yrs]` = `prediction_horizon`,
               `Kidney` = Kidney,
               `Other organs` = `Other_organs`,
               `Previous kidney` = `previous_ki_transplants`,
               `Rescue` = `Rescue_allocation`,
               `Recipient age` = `Recipient.age`,
               `Donor age` = `Donor.age`,
               `Waiting time [yrs]` = `waiting_time_years`,
               `Recipient BMI` = `Recipient.BMI`,
               `Patient survival [%]`=`surv`,
               `Pancreas survival [%]`=`pa`,
               `Kidney survival [%]`=`ki`)
    },
    # extensions = "Buttons",
    options = list(
      paging = F,
      searching = F,
      fixedColumns = TRUE,
      autoWidth = TRUE,
      ordering = TRUE,
      dom="tB"
    ),

    # selection=list(mode="single", selected=1, target="row"),
    rownames=FALSE,
    class = "display")
  )
  
  
  
  
  
  
  #################################################################################
  # Create output texts
  surv_text <- eventReactive(input$calculate_simple, {
    paste0("<b><FONT size='6pt'>", round(100*as.data.frame(predict_dt_simple())[1, "surv"]), 
           "%</FONT> ", 
           "patient survival</b> probability ", 
           "<b>", round(as.data.frame(predict_dt_simple())[1, "prediction_horizon"]/365.25, 1), 
           " years</b> after transplantation", 
           "<br>(", 
           round(as.data.frame(predict_dt_simple())[2, "prediction_horizon"]/365.25, 1), 
           " years: ", 
           "<FONT size='4pt'>", round(100*as.data.frame(predict_dt_simple())[2, "surv"]), 
           "%</FONT>)"
    )
  })
  output$simple_surv_text <- renderUI({
    HTML(paste("<FONT size='4pt'>", surv_text(), "</FONT>"))
  })
  
  
  pa_text <- eventReactive(input$calculate_simple, {
    paste0("<b><FONT size='6pt'>", round(100*as.data.frame(predict_dt_simple())[1, "pa"]), 
           "%</FONT> ", 
           "pancreas graft survival</b> probability ", 
           "<b>", round(as.data.frame(predict_dt_simple())[1, "prediction_horizon"]/365.25, 1), 
           " years</b> after transplantation", 
           "<br>(", 
           round(as.data.frame(predict_dt_simple())[2, "prediction_horizon"]/365.25, 1), 
           " years: ", 
           round(100*as.data.frame(predict_dt_simple())[2, "pa"]), 
           "%)"
    )
  })
  output$simple_pa_text <- renderUI({
    HTML(paste("<FONT size='4pt'>", pa_text(), "</FONT>"))
  })
  
  
  ki_text <- eventReactive(input$calculate_simple, {
    req(input$kidney_simple=="TRUE")
    paste0("<b><FONT size='6pt'>", round(100*as.data.frame(predict_dt_simple())[1, "ki"]), 
           "%</FONT> ", 
           "kidney graft survival</b> probability ", 
           "<b>", round(as.data.frame(predict_dt_simple())[1, "prediction_horizon"]/365.25, 1), 
           " years</b> after transplantation", 
           "<br>(", 
           round(as.data.frame(predict_dt_simple())[2, "prediction_horizon"]/365.25, 1), 
           " years: ", 
           round(100*as.data.frame(predict_dt_simple())[2, "ki"]), 
           "%)"
    )
  })
  output$simple_ki_text <- renderUI({
    HTML(paste("<FONT size='4pt'>", ki_text(), "</FONT>"))
  })
  
  
  #################################################################################
  # Create survival graphs
  
  simple_surv_plot <- eventReactive(input$calculate_simple, {
    # prob <- round(as.data.frame(predict_dt_simple())[1, "surv"], 2)
    
    # # Semi-donut
    # ggplot() + 
    #   geom_rect(aes(ymin = c(0, prob), ymax = 1, xmin = 1, xmax = 2), fill=c(surv_colour, death_colour)) + 
    #   coord_polar(theta = "y",start=-pi/2, clip="on") + 
    #   xlim(c(0, 2)) + 
    #   ylim(c(0,2)) + 
    #   theme_void() + 
    #   theme(plot.margin = unit(c(-0.1, 0, -0.5, 0), "null"))
    
    # Barplot
    ggplot(as.data.frame(predict_dt_simple()), aes(pred_horizon_years, surv)) + 
      geom_bar(stat="identity", fill=main_colour, width=0.5) + 
      geom_errorbar(aes(ymin=surv_lower, ymax=surv_upper), width=0.1, colour="gray10") + 
      scale_y_continuous(labels=scales::percent, limits=c(0, 1), breaks=seq(0, 1, 0.2)) + 
      theme_minimal() + 
      labs(x="", y="") + 
      theme(panel.grid.major.x = element_blank(), 
            text=element_text(size=12))
    
  })
  
  simple_pa_plot <- eventReactive(input$calculate_simple, {
    ggplot(as.data.frame(predict_dt_simple()), aes(pred_horizon_years, pa)) + 
      geom_bar(stat="identity", fill=main_colour, width=0.5) + 
      geom_errorbar(aes(ymin=pa_lower, ymax=pa_upper), width=0.1, colour="gray10") + 
      scale_y_continuous(labels=scales::percent, limits=c(0, 1), breaks=seq(0, 1, 0.2)) + 
      theme_minimal() + 
      labs(x="", y="") + 
      theme(panel.grid.major.x = element_blank(), 
            text=element_text(size=12))
    
  })
  
  simple_ki_plot <- eventReactive(input$calculate_simple, {
    req(input$kidney_simple=="TRUE")
    ggplot(as.data.frame(predict_dt_simple()), aes(pred_horizon_years, ki)) + 
      geom_bar(stat="identity", fill=main_colour, width=0.5) + 
      geom_errorbar(aes(ymin=ki_lower, ymax=ki_upper), width=0.1, colour="gray10") + 
      scale_y_continuous(labels=scales::percent, limits=c(0, 1), breaks=seq(0, 1, 0.2)) + 
      theme_minimal() + 
      labs(x="", y="") + 
      theme(panel.grid.major.x = element_blank(), 
            text=element_text(size=12))
    
  })
  
  output$simple_mortality <- renderPlot({
    simple_surv_plot()
  }, width=200, height=150)
  
  output$simple_pa <- renderPlot({
    simple_pa_plot()
  }, width=200, height=150)
  
  output$simple_ki <- renderPlot({
    simple_ki_plot()
  }, width=200, height=150)
  
  
  
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)
