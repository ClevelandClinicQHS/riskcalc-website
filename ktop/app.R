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
library(DT)

## Data formatting
library(tidyverse)

## Model
library(timereg)
library(rms)
# library(prodlim)
# library(riskRegression)

## Visualization
library(personograph)


###############################
# Load models
survival_simple <- readRDS("models/surv_fgr_simple.rds")
dwfg_simple <- readRDS("models/dwfg_fgr_simple.rds")
fail_simple <- readRDS("models/fail_fgr_simple.rds")
survival_full <- readRDS("models/surv_fgr_full.rds")
dwfg_full <- readRDS("models/dwfg_fgr_full.rds")
fail_full <- readRDS("models/fail_fgr_full.rds")
## Without ET variables
survival_simple_wet <- readRDS("models/surv_fgr_simple_wet.rds")
dwfg_simple_wet <- readRDS("models/dwfg_fgr_simple_wet.rds")
fail_simple_wet <- readRDS("models/fail_fgr_simple_wet.rds")
survival_full_wet <- readRDS("models/surv_fgr_full_wet.rds")
dwfg_full_wet <- readRDS("models/dwfg_fgr_full_wet.rds")
fail_full_wet <- readRDS("models/fail_fgr_full_wet.rds")


###############################
# Define constants
# Most of the limits were taken from the min and max values 
# of the data calculated in the data_description file
min_waiting_years <- 0.2
mean_waiting_years <- 5.3
max_waiting_years <- 19.4
min_D_TXP_AGE <- 0
mean_D_TXP_AGE <- 49.2
max_D_TXP_AGE <- 86
min_R_TXP_AGE <- 17
mean_R_TXP_AGE <- 51.4
max_R_TXP_AGE <- 79
min_CIT.hours <- 2.3
mean_CIT.hours <- 13.9
max_CIT.hours <- 35

min_prediction_days <- 1
max_prediction_days <- min(4376)#dwfg_model$cum[nrow(dwfg_model$cum),1], fail_model$cum[nrow(fail_model$cum),1], 
min_prediction_yrs <- ceiling(min_prediction_days/365.25)
max_prediction_yrs <- floor(max_prediction_days/365.25)

# Prediction times for simple calculator in days
simple_times <- 365.25 * c(5, 10)


# Colors for personographs
surv_colour <- "#5eaaa8"
death_colour <- "#f05945"
fail_colour <- "#ffb26b"
dwfg_colour <- "#ffd56b"
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
        span("KTOP ", style = "color: #e83131; font-size: 30px; font-weight: 550;"), # font-weight: bold;
        "Kidney Transplant Outcome Prediction"), 
        windowTitle = "KTOP: Kidney transplant outcome prediction", 
        theme = shinytheme("simplex"), #journal
        
        ###### Here : insert shinydashboard dependencies ######
        header = tagList(
            useShinydashboard()
        ),
        
        
        
        #################################################################################
        # Simple calculator - UI
        ######################
        tabPanel("Basic Calculator", fluid = TRUE, icon = icon("percentage"),#percentage,chart-bar
                 fluidRow(
                     column(10, align="center", offset=1, 
                            shinydashboard::box(width=20, title="Recipient information",
                                                
                                                div(style="vertical-align:top;display:inline-block;width:100px;text-align:left;",
                                                    radioButtons("r_sex_simple",
                                                                 HTML("Gender"),
                                                                 c("Female"="F",
                                                                   "Male"="M"),
                                                                 selected="F", 
                                                                 inline=FALSE)),
                                                
                                                div(style="vertical-align:top;display:inline-block;width:120px;text-align:left;",
                                                    radioButtons("disease_simple",
                                                                 HTML("Primary disease"),
                                                                 c("Diabetes"="Diabetes",
                                                                   "Cystic disease"="Cystic",
                                                                   "Other/None"="Other"),
                                                                 selected="Other", 
                                                                 inline=FALSE)),
                                                
                                                div(style="vertical-align:top;display:inline-block;width:120px;text-align:left;",
                                                    radioButtons("seq_simple",
                                                                 HTML("Transplant count"),
                                                                 c("1"="1",
                                                                   "2"="2",
                                                                   "3"="3",
                                                                   "4"="4"),
                                                                 selected=1,
                                                                 inline=FALSE)),
                                                
                                                div(style="vertical-align:top;display:inline-block;width:150px;text-align:left;",
                                                    radioButtons("program_simple",
                                                                 HTML("ET allocation program"),
                                                                 c("Not sure"=NA, 
                                                                   "ETKAS"="ETKAS",
                                                                   "ESP"="ESP"),
                                                                 selected=NA,
                                                                 inline=FALSE)),
                                                
                                                div(style="vertical-align:top;display:inline-block;width:120px;text-align:left;",
                                                    numericInput("recipientage_simple",
                                                                 HTML("Age"),
                                                                 value=round(mean_R_TXP_AGE),
                                                                 min=round(min_R_TXP_AGE),
                                                                 max=round(max_R_TXP_AGE),
                                                                 width="80%"),
                                                    bsTooltip(id="recipientage_simple",
                                                              title=paste0("Age of transplant recipient in years at transplant time"),
                                                              placement = "bottom", trigger = "hover")),
                                                
                                                div(style="vertical-align:top;display:inline-block;width:120px;",
                                                    numericInput("waitingyears_simple",
                                                                 HTML("Waiting time"),
                                                                 value=round(mean_waiting_years),
                                                                 min=round(min_waiting_years),
                                                                 max=round(max_waiting_years),
                                                                 width="80%"),
                                                    bsTooltip(id = "waitingyears_simple",
                                                              title=paste0("Waiting time until transplant in years"),
                                                              placement = "bottom", trigger = "hover")),
                                                
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
                                                    plotOutput("simple_mortality", height="50%"),
                                                    htmlOutput("simple_surv_text"),
                                                    cellArgs = list(style = "vertical-align: middle; white-space: normal;"),
                                                    cellWidths = c("60%", "40%")
                                                )
                            ),
                            htmlOutput("simple_fail_text"), 
                            htmlOutput("simple_dwfg_text"), 
                            tags$br(), 
                            tags$br()
                     )
                 ), 
                 disclaimer_str
        ),
        
        
        #################################################################################
        # Expert calculator - UI
        ######################
        tabPanel("Expert Calculator", fluid = TRUE, icon = icon("chart-bar"),#percentage,chart-bar
                 fluidRow(
                     column(10, align="center", offset=1, 
                            shinydashboard::box(width=12, title="Recipient-specific values",
                                                
                                                div(style="vertical-align:top;display:inline-block;width:130px;text-align:left;",
                                                    checkboxGroupInput("r_sex",
                                                                       "Recipient gender",
                                                                       c("Female"="F",
                                                                         "Male"="M"),
                                                                       inline=FALSE)),
                                                
                                                div(style="vertical-align:top;display:inline-block;width:130px;text-align:left;",
                                                    checkboxGroupInput("disease",
                                                                       "Primary disease",
                                                                       c("Diabetes"="Diabetes",
                                                                         "Cystic"="Cystic",
                                                                         "Other/None"="Other"),
                                                                       inline=FALSE)),
                                                
                                                div(style="vertical-align:top;display:inline-block;width:130px;text-align:left;",
                                                    checkboxGroupInput("seq",
                                                                       "Transplant count",
                                                                       c("1"="1",
                                                                         "2"="2",
                                                                         "3"="3",
                                                                         "4"="4"),
                                                                       #selected=1,
                                                                       inline=FALSE)),
                                                
                                                div(style="vertical-align:top;display:inline-block;width:150px;text-align:left;",
                                                    checkboxGroupInput("program",
                                                                       "ET allocation program",
                                                                       c("Not sure"=NA, 
                                                                         "ETKAS"="ETKAS",
                                                                         "ESP"="ESP"),
                                                                       #selected=NA,
                                                                       inline=FALSE)),
                                                
                                                div(style="vertical-align:top;display:inline-block;width:130px;text-align:left;",
                                                    textInput("recipientage",
                                                              "Recipient age",
                                                              #placeholder = mean_R_TXP_AGE,
                                                              width="75%"),
                                                    bsTooltip(id="recipientage",
                                                              title=paste0("Age of recipient in years at transplant time (",
                                                                           min_R_TXP_AGE, "-", max_R_TXP_AGE, ")"),
                                                              placement = "bottom", trigger = "hover")),
                                                
                                                div(style="vertical-align:top;display:inline-block;width:140px;text-align:left;",
                                                    textInput("waitingyears",
                                                              "Waiting time [yr]",
                                                              #placeholder = mean_waiting_years,
                                                              width="75%"),
                                                    bsTooltip(id = "waitingyears",
                                                              title=paste0("Waiting time until transplant in years (",
                                                                           min_waiting_years, "-", max_waiting_years, ")"),
                                                              placement = "bottom", trigger = "hover")),
                                                
                                                div(style="vertical-align:top;display:inline-block;width:150px;text-align:left;",
                                                    textInput("predictiontime",
                                                              "Prediction time [yr]",
                                                              #placeholder = "5",
                                                              width="80%",
                                                              value=5),
                                                    bsTooltip(id = "predictiontime",
                                                              title=paste0("Future time point of interest in years (",
                                                                           min_prediction_yrs, "-", max_prediction_yrs, ")"),
                                                              placement = "bottom", trigger = "hover"))
                            )),
                     
                     column(10, align="center", offset=1, 
                            shinydashboard::box(width=12, title="Transplant-specific values",
                                                
                                                div(style="vertical-align:top;display:inline-block;width:140px;text-align:left;",
                                                    checkboxGroupInput("hla_a",
                                                                       "HLA A matches",
                                                                       c("0"="0",
                                                                         "1"="1",
                                                                         "2"="2"),
                                                                       #selected=1,
                                                                       inline=TRUE)),
                                                
                                                div(style="vertical-align:top;display:inline-block;width:140px;text-align:left;",
                                                    checkboxGroupInput("hla_b",
                                                                       "HLA B matches",
                                                                       c("0"="0",
                                                                         "1"="1",
                                                                         "2"="2"),
                                                                       #selected=1,
                                                                       inline=TRUE)),
                                                
                                                div(style="vertical-align:top;display:inline-block;width:140px;text-align:left;",
                                                    checkboxGroupInput("hla_dr",
                                                                       "HLA DR matches",
                                                                       c("0"="0",
                                                                         "1"="1",
                                                                         "2"="2"),
                                                                       #selected=1,
                                                                       inline=TRUE)),
                                                
                                                div(style="vertical-align:top;display:inline-block;width:140px;text-align:left;",
                                                    textInput("donorage",
                                                              "Donor age",
                                                              #placeholder = mean_D_TXP_AGE,
                                                              width="75%"),
                                                    bsTooltip(id="donorage",
                                                              title=paste0("Age of donor in years at transplant time (",
                                                                           min_D_TXP_AGE, "-", max_D_TXP_AGE, ")"),
                                                              placement = "bottom", trigger = "hover")),
                                                
                                                div(style="vertical-align:top;display:inline-block;width:140px;text-align:left;",
                                                    textInput("cithours",
                                                              "CIT [h]",
                                                              #placeholder = mean_CIT.hours,
                                                              width="75%"),
                                                    bsTooltip(id="cithours",
                                                              title=paste0("Cold ischemia time in hours (",
                                                                           min_CIT.hours, "-", max_CIT.hours, ")"),
                                                              placement = "bottom", trigger = "hover"))
                            )
                     )),
                 
                 fluidRow(
                     column(10, offset=1, 
                            shinydashboard::box(width=12, title="Prediction overview and visualization selection",
                                                htmlOutput("expert_waiting_for_input"), 
                                                withSpinner(DT::dataTableOutput("predict_table", width="50%")), 
                                                br()
                            ))
                 ),
                 
                 
                 fluidRow(
                     column(5, align="center", offset=1, 
                            shinydashboard::box(
                                title="Mortality",
                                width=12, solidHeader=T, #status="primary",
                                splitLayout(
                                    plotOutput("surv_person", height="50%"),
                                    htmlOutput("full_surv_text"),
                                    cellArgs = list(style = "vertical-align: middle; white-space: normal;")
                                )
                            )), 
                     column(5, align="center", offset=0, 
                            shinydashboard::box(
                                title="Graft survival",
                                width=12, solidHeader=T, #status="info",
                                splitLayout(
                                    plotOutput("dwfg_fail_person", height="50%"),
                                    htmlOutput("full_fail_dwfg_text"),
                                    cellArgs = list(style = "vertical-align: middle; white-space: normal;")
                                )
                            )
                     )
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
                                                                <b>KTOP</b> allows the prediction of certain outcomes 
                                                                after kidney transplantations from brain-dead deceased donors. 
                                                                It estimates the risk of death during a 
                                                                certain timeframe after the operation 
                                                                as well as the cumulative 
                                                                incidence of organ failures and deaths with a 
                                                                functioning graft. 
                                                                All calculations are based on data from Eurotransplant, the largest 
                                                                international European organ allocation organization.
                                                            </p>"), 
                                                HTML("<p align='justify'>
                                                                The <b>basic calculator</b> requires only patient-specific 
                                                                information, which is already available before a potential 
                                                                donor kidney has been identified. 
                                                                Its predictions are for the fixed timeframes of five and 
                                                                ten years.
                                                            </p>"), 
                                                HTML("<p align='justify'>
                                                                The <b>expert calculator</b> requires transplant-specific 
                                                                values to achieve a higher prediction accuracy. 
                                                                It allows the entry of multiple values per risk factor as well as 
                                                                multiple timeframes and considers all 
                                                                possible entry combinations for prediction. 
                                                                Multiple numbers can be entered by separating them with a comma. 
                                                                After calculation, individual rows can be selected in 
                                                                the resulting dataframe to be visualized below.
                                                            </p><br>"), 
                                                # define class for indentation class of div
                                                tags$style(HTML("
                                                            .indent {
                                                            padding-left: 1.5em;
                                                            text-indent:-1.5em;
                                                            vertical-align: top;
                                                            }")), 
                                                HTML("<p align='justify'><b>Term explanations</b><br>
                                                                <div class='indent'>
                                                                    <i>CIT</i><br>
                                                                    Cold ischemia time - time period between initiation of 
                                                                    donor in vivo cold organ preservation and cold storage in 
                                                                    postmortal organ donation for transplantation until removal 
                                                                    of the graft from the storage container and start of surgical 
                                                                    anastomoses of the vessels
                                                                </div>
                                                                <div class='indent'>
                                                                    <i>Cumulative incidence</i><br>
                                                                    Proportion of individuals who develop the 
                                                                    outcome
                                                                </div>
                                                                <div class='indent'>
                                                                    <i>ET allocation program</i><br>
                                                                    Indicates the Eurotransplant allocation program 
                                                                    of the organ recipient (see ETKAS and ESP)
                                                                </div>
                                                                <div class='indent'>
                                                                    <i>ETKAS</i><br>
                                                                    Eurotransplant kidney allocation system - the standard 
                                                                    allocation system of Eurotransplant
                                                                </div>
                                                                <div class='indent'>
                                                                    <i>ESP</i><br>
                                                                    Eurotransplant Senior Program - the allocation system of 
                                                                    Eurotransplant reserved for recipients older than 64 years
                                                                </div>
                                                                <div class='indent'>
                                                                    <i>HLA</i><br>
                                                                    Human leukocyte antigen - more matches indicate a better 
                                                                    immunological fit between recipient and transplant
                                                                </div>
                                                                <div class='indent'>
                                                                    <i>Transplant count</i><br>
                                                                    Number specifying if the transplant is a retransplantation or not
                                                                </div>
                                                                <br>
                                                            </p>"), 
                                                HTML("<p align='justify'>
                                                                <b>Reference</b>
                                                                <br>
                                                                G. Miller, D.P. Ankerst, M.W. Kattan, N. H&uuml;ser, 
                                                                S. Vogelaar, I. Tieken, U. Heemann, V. Assfalg. 
                                                                <i>Kidney Transplantation Outcome Predictions (KTOP): 
                                                                A Risk Prediction 
                                                                Tool for Kidney Transplants from Brain-dead Deceased Donors 
                                                                Based on a Large European Cohort</i>, Eur Urol (2022), 
                                                                <a href='https://doi.org/10.1016/j.eururo.2021.12.008' 
                                                                target='_blank'>https://doi.org/10.1016/j.eururo.2021.12.008</a>.
                                                            </p><br>"), 
                                                HTML("<p align='justify'>
                                                                <b>Affiliations</b>
                                                                <br>
                                                                <div class='indent'>
                                                                    <i>Technical University of Munich</i>
                                                                    <br>
                                                                    TransplanTUM - Munich Transplant Center, Klinikum rechts der Isar
                                                                    <br>
                                                                    Department of Mathematics
                                                                    <br>
                                                                    Department of Life Science Systems, Munich Data Science Institute
                                                                </div>
                                                                <div class='indent'>
                                                                    <i>Cleveland Clinic</i>
                                                                    <br>
                                                                    Department of Quantitative Health Sciences
                                                                </div>
                                                                <i>Eurotransplant International Foundation</i>
                                                                <br>
                                                            </p>"),
                                                HTML("<p align='justify'>
                                                                <br>
                                                                <a href='https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/ktop'>Source code</a>.
                                                            </p><br>")
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
            str <- "Press 'Calculate' to predict the transplant success of a deceased-donor kidney"
            HTML(paste("<div style='text-align:center'><FONT size='3pt'>", str, "</FONT></div>"))
        }
    })
    
    #################################################################################
    # Create dataframe with all properties and resulting prediction
    predict_dt_simple <- eventReactive(input$calculate_simple, {
        
        
        ## Categorical values
        ALLOCATION <- input$program_simple
        R_SEX <- input$r_sex_simple
        disease_lvl2 <- input$disease_simple
        SEQ <- as.numeric(input$seq_simple)
        R_TXP_AGE <- as.numeric(input$recipientage_simple)
        waiting_years <- as.numeric(input$waitingyears_simple)
        
        
        # Crossing is needed if we have multiple values for one or more variables
        predict_dt_simple <- crossing(ALLOCATION, waiting_years, R_TXP_AGE, R_SEX, disease_lvl2, SEQ)
        
        # Calculate variables
        predict_dt_simple <- predict_dt_simple %>%
            mutate(Diabetes = ifelse(disease_lvl2=="Diabetes", TRUE, FALSE),
                   Cystic = ifelse(disease_lvl2=="Cystic", TRUE, FALSE),
                   ALLOCATION = factor(ALLOCATION, levels=c("ETKAS", "ESP")),
                   R_SEX = factor(R_SEX, levels=c("F", "M")),
                   R_TXP_AGExxDiabetes = as.numeric(Diabetes)*R_TXP_AGE, 
                   R_TXP_AGExxSEQ = R_TXP_AGE * SEQ, 
                   R_SEXxxCystic = (as.numeric(R_SEX)-1) * as.numeric(Cystic), 
                   waiting_yearsxxR_TXP_AGE = waiting_years * R_TXP_AGE / 100, 
                   ALLOCATIONxxSEQ = (as.numeric(ALLOCATION)-1) * SEQ, 
                   waiting_yearsxxDiabetes = as.numeric(Diabetes) * waiting_years, 
                   id_cluster = -1) %>% 
            as.data.frame()
        
        result_dt_simple <- data.frame()
        
        for(i in 1:nrow(predict_dt_simple)){
            if(predict_dt_simple[i, "ALLOCATION"] %in% c("ETKAS", "ESP")){
                pred_simple_surv <- survest(survival_simple, times=simple_times, newdata=predict_dt_simple[i,], 
                                            conf.int=FALSE, what="survival")$surv
                pred_simple_dwfg <- predict(dwfg_simple, times=simple_times, newdata=predict_dt_simple[i,])$P1
                pred_simple_fail <- predict(fail_simple, times=simple_times, newdata=predict_dt_simple[i,])$P1
            }else if(is.na(predict_dt_simple[i, "ALLOCATION"])){
                pred_simple_surv <- survest(survival_simple_wet, times=simple_times, newdata=predict_dt_simple[i,], 
                                            conf.int=FALSE, what="survival")$surv
                pred_simple_dwfg <- predict(dwfg_simple_wet, times=simple_times, newdata=predict_dt_simple[i,])$P1
                pred_simple_fail <- predict(fail_simple_wet, times=simple_times, newdata=predict_dt_simple[i,])$P1
            }
            
            
            # Save cumulative incidence predictions and standard error
            result_dt_simple <- cbind(predict_dt_simple[i,],
                                      prediction_horizon = simple_times,
                                      surv = as.vector(pred_simple_surv),
                                      dwfg = as.vector(pred_simple_dwfg),
                                      fail = as.vector(pred_simple_fail), 
                                      row.names=NULL) %>%
                rbind(result_dt_simple, ., row.names=NULL)
        }
        result_dt_simple
        
    })
    
    
    
    
    
    
    #################################################################################
    # Create output texts
    output$simple_surv_text <- renderUI({
        str <- paste0("<FONT size='8pt'><b>", round(100*as.data.frame(predict_dt_simple())[1, "surv"]), 
                      "%</b></FONT> ", 
                      "survival probability in the first ", 
                      "<b>", round(as.data.frame(predict_dt_simple())[1, "prediction_horizon"]/365.25, 1), 
                      " years</b> after the transplant (<b>", 
                      round(as.data.frame(predict_dt_simple())[2, "prediction_horizon"]/365.25, 1), 
                      " years: ", 
                      "<FONT size='5pt'>", round(100*as.data.frame(predict_dt_simple())[2, "surv"]), 
                      "%</FONT></b>)."
        )
        HTML(paste("<FONT size='5pt'>", str, "</FONT>"))
    })
    
    output$simple_fail_text <- renderUI({
        str <- paste0("<FONT size='5pt'><b>", round(100*as.data.frame(predict_dt_simple())[1, "fail"]), 
                      "%</b></FONT> ", 
                      "graft failures after ", 
                      round(as.data.frame(predict_dt_simple())[1, "prediction_horizon"]/365.25, 1), 
                      " years ", 
                      "(", 
                      round(as.data.frame(predict_dt_simple())[2, "prediction_horizon"]/365.25, 1), 
                      " years: ", 
                      round(100*as.data.frame(predict_dt_simple())[2, "fail"]), 
                      "%)."
        )
        HTML(paste("<FONT size='4pt'>", str, "</FONT>"))
    })
    
    output$simple_dwfg_text <- renderUI({
        str <- paste0("<FONT size='5pt'><b>", round(100*as.data.frame(predict_dt_simple())[1, "dwfg"]), 
                      "%</b></FONT> ", 
                      "deaths with a functioning graft after ", 
                      round(as.data.frame(predict_dt_simple())[1, "prediction_horizon"]/365.25, 1), 
                      " years ", 
                      "(", 
                      round(as.data.frame(predict_dt_simple())[2, "prediction_horizon"]/365.25, 1), 
                      " years: ", 
                      round(100*as.data.frame(predict_dt_simple())[2, "dwfg"]), 
                      "%)."
        )
        HTML(paste("<FONT size='4pt'>", str, "</FONT>"))
    })
    
    
    #################################################################################
    # Create survival personographs
    
    ## Starting values
    # prob <- 0
    # col_surv <- col_death <- na_colour
    simple_plot <- eventReactive(input$calculate_simple, {
        prob <- round(as.data.frame(predict_dt_simple())[1, "surv"], 2)
        col_surv <- surv_colour
        col_death <- death_colour
        
        personograph(list(first=prob, second=1-prob),
                     n.icons=50, dimensions=c(5,10), 
                     #plot.width=1.1,
                     colors=list(first=col_surv, second=col_death),
                     draw.legend=F, icon.style = 1)
    })
    
    output$simple_mortality <- renderPlot({
        simple_plot()
    }, width=400, height=300)
    
    
    
    
    
    #################################################################################
    # Expert calculator
    ######################
    
    
    #################################################################################
    # Check if there are missing values
    output$expert_waiting_for_input <- renderUI({
        if(
            !isTruthy(input$waitingyears) | !isTruthy(input$recipientage) | !isTruthy(input$donorage) | 
            !isTruthy(input$cithours) | !isTruthy(input$r_sex) | !isTruthy(input$disease) | 
            !isTruthy(input$predictiontime) | is.null(input$program) | !isTruthy(input$hla_a) |
            !isTruthy(input$hla_b) | !isTruthy(input$hla_dr) | !isTruthy(input$seq)
        ){
            str <- "Please enter a value for all properties to receive a prediction!"
            HTML(paste("<div style='text-align:center'><FONT size='4pt'>", str, "</FONT></div>"))
        }
    })
    
    #################################################################################
    # Create dataframe with all properties and resulting prediction
    predict_dt <- reactive({
        # Require input
        req(input$waitingyears)
        req(input$recipientage)
        req(input$donorage)
        req(input$cithours)
        req(input$r_sex)
        req(input$disease)
        req(input$predictiontime)
        shiny::validate(
            need(!is.null(input$program), "Please select at least one program"),
            need(!is.null(input$hla_a), "Please select at least one HLA A matching."),
            need(!is.null(input$hla_b), "Please select at least one HLA B matching."),
            need(!is.null(input$hla_dr), "Please select at least one HLA DR matching."),
            need(!is.null(input$r_sex), "Please select at least one recipient gender."),
            need(!is.null(input$disease), "Please select the primary disease of the recipient."),
            need(!is.null(input$seq), "Please select the transplant count.")
        )
        
        
        
        # Process input
        ## (Multiple) numeric values
        waiting_years <- str_extract_all(input$waitingyears,
                                         "\\(?[0-9.]+\\)?")[[1]] %>%
            as.numeric() %>%
            unique()
        D_TXP_AGE <- str_extract_all(input$donorage,
                                     "\\(?[0-9.]+\\)?")[[1]] %>%
            as.numeric() %>%
            unique()
        CIT.hours <- str_extract_all(input$cithours,
                                     "\\(?[0-9.]+\\)?")[[1]] %>%
            as.numeric() %>%
            unique()
        R_TXP_AGE <- str_extract_all(input$recipientage,
                                     "\\(?[0-9.]+\\)?")[[1]] %>%
            as.numeric() %>%
            unique()
        times <- str_extract_all(input$predictiontime,
                                 "\\(?[0-9.]+\\)?")[[1]] %>%
            as.numeric() %>%
            unique()
        times <- round(times*365.25)
        
        ## Categorical values
        ALLOCATION <- input$program
        HLA_A <- as.numeric(input$hla_a)
        HLA_B <- as.numeric(input$hla_b)
        HLA_DR <- as.numeric(input$hla_dr)
        R_SEX <- input$r_sex
        disease_lvl2 <- input$disease
        SEQ <- as.numeric(input$seq)
        
        
        # Validate input
        shiny::validate(
            # Check if there is actually a numeric value
            need(length(waiting_years)>0, "Please enter a number for the waiting time."),
            need(length(D_TXP_AGE)>0, "Please enter a number for the recipient age."),
            need(length(R_TXP_AGE)>0, "Please enter a number for the donor age."),
            need(length(CIT.hours)>0, "Please enter a number for the cold ischemia time."),
            need(length(times)>0, "Please enter a number for prediction time."),
            
            # Check if the values are suitable
            need(all(waiting_years>=min_waiting_years & waiting_years<=max_waiting_years),
                 paste0("Please choose a value for the waiting time between ",
                        min_waiting_years, " and ", max_waiting_years, ".")),
            need(all(D_TXP_AGE>=min_D_TXP_AGE & D_TXP_AGE<=max_D_TXP_AGE),
                 paste0("Please choose a value for the donor age between ",
                        min_D_TXP_AGE, " and ", max_D_TXP_AGE, ".")),
            need(all(R_TXP_AGE>=min_R_TXP_AGE & R_TXP_AGE<=max_R_TXP_AGE),
                 paste0("Please choose a value for the recipient age between ",
                        min_R_TXP_AGE, " and ", max_R_TXP_AGE, ".")),
            need(all(CIT.hours>=min_CIT.hours & CIT.hours<=max_CIT.hours),
                 paste0("Please choose a value for the donor age between ",
                        min_D_TXP_AGE, " and ", max_D_TXP_AGE, ".")),
            need(min(times)>min_prediction_days & max(times)<max_prediction_days,
                 paste0("Please choose a value for the prediction time between ",
                        min_prediction_yrs, " and ", max_prediction_yrs, "."))
        )
        
        
        # Crossing is needed if we have multiple values for one or more variables
        predict_dt <- crossing(ALLOCATION, waiting_years, HLA_A, HLA_B, HLA_DR,
                               D_TXP_AGE, R_TXP_AGE, R_SEX, disease_lvl2, SEQ, CIT.hours)
        
        # Calculate variables
        predict_dt <- predict_dt %>%
            mutate(Match = factor(if_else(HLA_DR>0 & (HLA_A>0 | HLA_B>0), "favorable", "non-favorable"),
                                  levels=c("favorable", "non-favorable")),
                   Diabetes = ifelse(disease_lvl2=="Diabetes", TRUE, FALSE),
                   Cystic = ifelse(disease_lvl2=="Cystic", TRUE, FALSE),
                   ALLOCATION = factor(ALLOCATION, levels=c("ETKAS", "ESP")),
                   R_SEX = factor(R_SEX, levels=c("F", "M")),
                   R_TXP_AGExxDiabetes = as.numeric(Diabetes)*R_TXP_AGE, 
                   R_TXP_AGExxSEQ = R_TXP_AGE * SEQ, 
                   R_SEXxxCystic = (as.numeric(R_SEX)-1) * as.numeric(Cystic), 
                   waiting_yearsxxR_TXP_AGE = waiting_years * R_TXP_AGE / 100, 
                   ALLOCATIONxxSEQ = (as.numeric(ALLOCATION)-1) * SEQ, 
                   waiting_yearsxxDiabetes = as.numeric(Diabetes) * waiting_years, 
                   id_cluster = -1) %>% 
            as.data.frame()
        
        result_dt <- data.frame()
        
        for(i in 1:nrow(predict_dt)){
            # Distinguish between models with and without Eurotransplant allocation program
            if(predict_dt[i, "ALLOCATION"] %in% c("ETKAS", "ESP")){
                # Compute survival probability for survival
                pred_full_surv <- 1 - survest(survival_full, times=times, newdata=predict_dt[i,], 
                                          conf.int=FALSE, what="survival")$surv
                # Compute cumulative incidence predictions for DwFG and graft loss
                pred_full_dwfg <- predict(dwfg_full, times=times, newdata=predict_dt[i,])$P1
                pred_full_fail <- predict(fail_full, times=times, newdata=predict_dt[i,])$P1
            }else if(is.na(predict_dt[i, "ALLOCATION"])){
                # Compute survival probability for survival
                pred_full_surv <- 1 - survest(survival_full_wet, times=times, newdata=predict_dt[i,], 
                                          conf.int=FALSE, what="survival")$surv
                # Compute cumulative incidence predictions for DwFG and graft loss
                pred_full_dwfg <- predict(dwfg_full_wet, times=times, newdata=predict_dt[i,])$P1
                pred_full_fail <- predict(fail_full_wet, times=times, newdata=predict_dt[i,])$P1
            }
            
            
            
            # Save cumulative incidence predictions and standard error
            result_dt <- cbind(predict_dt[i,], 
                               prediction_horizon = times,
                               surv = as.vector(pred_full_surv),
                               dwfg = as.vector(pred_full_dwfg),
                               fail = as.vector(pred_full_fail), 
                               row.names=NULL) %>%
                rbind(result_dt, .)
        }
        predict_dt <- result_dt
        
        
        # Make prettier
        predict_dt <- predict_dt %>%
            mutate(dwfg_percent = round(100*dwfg, 1),
                   fail_percent = round(100*fail, 1),
                   surv_percent = round(100*surv, 1),
            ) %>%
            dplyr::select(-c(#dwfg, fail, surv,
                #dwfg_se,fail_se, surv_se,
                Diabetes, Match, Cystic)) %>%
            rename(
                Program=ALLOCATION,
                `Wait time [years]`=waiting_years,
                `HLA A`=HLA_A,
                `HLA B`=HLA_B,
                `HLA DR`=HLA_DR,
                `Donor age`=D_TXP_AGE,
                `Recipient age`=R_TXP_AGE,
                `Recipient sex`=R_SEX,
                Disease=disease_lvl2,
                `Transplant count`=SEQ,
                `Cold ischemia time [hours]`=CIT.hours, 
                `Prediction horizon [days]`=prediction_horizon,
                `DwFG incidence [%]`=dwfg_percent,
                `Graft loss incidence [%]`=fail_percent,
                `Death risk [%]`=surv_percent)
    })
    
    ## Render dataframe
    # output$predict_table <- DT::renderDataTable(
    #     predict_dt() %>%
    #         select(`Prog`=Program,
    #                `Wait [yrs]`=`Wait time [years]`,
    #                `HLA A`,
    #                `HLA B`,
    #                `HLA DR`,
    #                `Don age`=`Donor age`,
    #                `Rec age`=`Recipient age`,
    #                `Rec sex`=`Recipient sex`,
    #                `Disease`=Disease,
    #                `#`=`Transplant count`,
    #                `CIT`=`Cold ischemia time [hours]`, 
    #                `Horizon [days]`=`Prediction horizon [days]`,
    #                `DwFG [%]`=`DwFG incidence [%]`,
    #                `Loss [%]`=`Graft loss incidence [%]`,
    #                `Death [%]`=`Death risk [%]`),
    #     server=TRUE,
    #     selection=list(mode="single", selected=1, target="row"),
    #     rownames=FALSE,
    #     options = list(lengthChange = FALSE, dom="tipr")
    # )
    
    output$predict_table <- DT::renderDataTable(
        DT::datatable({
            predict_dt() %>%
                select(`Prog`=Program,
                       `Wait [yrs]`=`Wait time [years]`,
                       `HLA A`,
                       `HLA B`,
                       `HLA DR`,
                       `Don age`=`Donor age`,
                       `Rec age`=`Recipient age`,
                       `Rec sex`=`Recipient sex`,
                       `Disease`=Disease,
                       `#`=`Transplant count`,
                       `CIT`=`Cold ischemia time [hours]`, 
                       `Horizon [days]`=`Prediction horizon [days]`,
                       `DwFG [%]`=`DwFG incidence [%]`,
                       `Loss [%]`=`Graft loss incidence [%]`,
                       `Death [%]`=`Death risk [%]`) 
        }, 
        extensions = "Buttons", 
        options = list(
            paging = F,
            searching = F,
            fixedColumns = TRUE,
            autoWidth = TRUE,
            ordering = TRUE,
            dom="tB",
            buttons = list(
                list(extend="csv", 
                     text="Download as CSV"), 
                list(extend="excel", 
                     text="Download as Excel file")
            )
            #buttons = c('csv', 'excel')
        ),
        
        selection=list(mode="single", selected=1, target="row"),
        rownames=FALSE,
        class = "display")
    )
    
    
    
    
    
    #################################################################################
    # Create output texts
    output$full_surv_text <- renderUI({
        str <- paste0("<FONT size='6pt'><b>", 
                      round(100*as.data.frame(predict_dt())[input$predict_table_rows_selected, "surv"]), 
                      "%</b></FONT> ", 
                      "risk of death in the first ", 
                      "<b>", 
                      round(as.data.frame(predict_dt())[input$predict_table_rows_selected, "Prediction horizon [days]"]/365.25, 1), 
                      " years</b> after the transplant"
        )
        HTML(paste("<FONT size='5pt'>", str, "</FONT>"))
    })
    
    output$full_fail_dwfg_text <- renderUI({
        str <- paste0("<FONT size='6pt'><b>", 
                      round(100*as.data.frame(predict_dt())[input$predict_table_rows_selected, "fail"]), 
                      "%</b></FONT> ", 
                      "graft failures and ", 
                      "<FONT size='6pt'><b>", 
                      round(100*as.data.frame(predict_dt())[input$predict_table_rows_selected, "dwfg"]), 
                      "%</b></FONT> ", 
                      "deaths with a functioning graft in the first ", 
                      "<b>", 
                      round(as.data.frame(predict_dt())[input$predict_table_rows_selected, "Prediction horizon [days]"]/365.25, 1), 
                      " years</b> after transplant"
        )
        HTML(paste("<FONT size='5pt'>", str, "</FONT>"))
    })
    
    
    
    #################################################################################
    # Create survival personographs
    output$surv_person <- renderPlot({
        if(length(input$predict_table_rows_selected)){
            prob <- as.data.frame(predict_dt())[input$predict_table_rows_selected, "surv"]
            col_surv <- surv_colour
            col_death <- death_colour
        }else{
            prob <- 0
            col_surv <- col_death <- na_colour
        }
        personograph(list(first=1-prob, second=prob),
                     n.icons=50, dimensions=c(5,10),
                     #plot.width=1.1,
                     colors=list(first=col_surv, second=col_death),
                     draw.legend=F, icon.style = 1)
    }, width=270, height=270)
    
    output$dwfg_fail_person <- renderPlot({
        if(length(input$predict_table_rows_selected)){
            prob_dwfg <- round(as.data.frame(predict_dt())[input$predict_table_rows_selected, "dwfg"], 2)
            prob_fail <- round(as.data.frame(predict_dt())[input$predict_table_rows_selected, "fail"], 2)
            col_surv <- surv_colour
            col_dwfg <- dwfg_colour
            col_fail <- fail_colour
            
        }else{
            prob_dwfg <- prob_fail <- 0
            col_surv <- col_dwfg <- col_fail <- na_colour
        }
        personograph(list(first=1-round(prob_dwfg, 4) - round(prob_fail, 4), 
                          second=round(prob_dwfg, 4), 
                          third=round(prob_fail, 4)),
                     n.icons=50, dimensions=c(5,10),
                     #plot.width=1.1,
                     colors=list(first=col_surv, second=col_dwfg, third=col_fail),
                     draw.legend=F, icon.style = 1)
    }, width=270, height=270)
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
