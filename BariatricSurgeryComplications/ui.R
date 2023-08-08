#Created: 2019-10-09
#Author: Alex Zajichek
#Project: Individualized Diabetes Complications Risk Scores
#Description: Holds user interface objects

require(shiny)
require(shinythemes)
require(dplyr)
require(shinycssloaders)
require(DT)

fluidPage(
    tags$head(tags$link(rel="shortcut icon", href="../assets/icons/favicon.ico", type="image/x-icon")),
    tags$head(tags$link(rel="apple-touch-icon", href="../assets/icons/apple-touch-icon.png", type="image/x-icon")),
    
  #Add title
  titlePanel(
    title = "10-year Individualized Diabetes Complications Risk Scores"
  ),
  
  #Make a side panel and main display
  sidebarLayout(
    
    #Create the side panel
    sidebarPanel(
      
      #Add tabs for each set of predictors
      tabsetPanel(
        
        #Demographics
        tabPanel(
          title = "Demographics",
          value = "demographics",
          
          ##Tab content
          HTML("<br>"),
          #Age
          textInput(
            inputId = "age",
            label = "Age (years)",
            placeholder = "18-80"
          ),
          
          #Gender
          selectInput(
            inputId = "gender",
            label = "Sex",
            choices = 
              c(
                "Male",
                "Female"
              )
          ),
          
          #BMI
          textInput(
            inputId = "bmi",
            label = HTML("BMI (kg/m<sup>2</sup>)"),
            placeholder = "30-100"
          ),
          
          #Race
          selectInput(
            inputId = "race",
            label = "Race",
            choices = 
              c(
                "Black",
                "White",
                "Other"
              )
          ),
          
          #Smoking status
          selectInput(
            inputId = "smoking",
            label = "Smoking status",
            choices = 
              c(
                "Never",
                "Quit",
                "Current"
              )
          )
        ),
        
        #Medical history
        tabPanel(
          title = "Medical history",
          value = "medicalhistory",
          
          ##Tab content
          HTML("<br>"),
          checkboxGroupInput(
            inputId = "hx_list",
            label = "History of (check all that apply):",
            choiceNames = 
              list(
                "Hypertension",
                "Dyslipidemia",
                "Chronic obstructive pulmonary disease (COPD)",
                "Heart failure",
                "Coronary artery disease",
                "Cerebrovascular disease",
                "Diabetic neuropathy",
                "Peripheral arterial disease",
                "Nephropathy (diabetic kidney disease)",
                "Dialysis"
              ),
            choiceValues = 
              as.list(
                paste0(
                  "HX_",
                  c(
                    "Hypertension",
                    "Dyslipidemia",
                    "COPD",
                    "CHF",
                    "CAD",
                    "CVD",
                    "DiabeticNeuropathy",
                    "PAD",
                    "Nephropathy",
                    "Dialysis"
                  )
                )
              )
          )
        ),
        
        ##Labs
        tabPanel(
          title = "Clinical and Lab Data",
          value = "labs",
          
          #Tab content
          HTML("<br>"),
          #A1C
          textInput(
            inputId = "a1c",
            label = "HbA1c (%)",
            placeholder = "5-14"
          ),
          
          #BP
          span(
            "Blood pressure (mm Hg)",
            style = "font-size:16px"
          ),
          fluidRow(
            column(
              4,
              textInput(
                inputId = "systolic",
                label = "systolic",
                placeholder = "90-210"
              )
            ),
            column(
              4,
              textInput(
                inputId = "diastolic",
                label = "diastolic",
                placeholder = "60-120"
              )
            )
          ),
          
          #Creatinine
          textInput(
            inputId = "creatinine",
            label = "Creatinine (mg/dL)",
            placeholder = "0.5-10"
          ),
          
          #Triglyceride
          textInput(
            inputId = "triglyceride",
            label = "Triglycerides (mg/dL)",
            placeholder = "50-2000"
          )
        ),
        
        ##Medications
        tabPanel(
          title = "Current medications",
          value = "medications",
          
          ##Tab content
          HTML("<br>"),
          checkboxGroupInput(
            inputId = "med_list",
            label = "Current medications (check all that apply):",
            choiceNames = 
              list(
                "Insulin",
                "Other diabetes medication (non-insulin)",
                "Lipid-lowering medications",
                "Angiotensin converting enzyme inhibitors or angiote-receptor blockers",
                "Other antihyperintensive medications",
                "Aspirin",
                "Warfarin"
              ),
            choiceValues = 
              list(
                "Insulin",
                "NonInsulinDiabetesMedication",
                "CholesterolLowering",
                "ACEInhibitors",
                "OtherAntihypertensives",
                "Aspirin",
                "Warfarin"
              )
          )
          
        )
        
      )
      
    ),
    
    #Main content
    mainPanel(
      
      #Button to run calculator
      actionButton(
        inputId = "run",
        label = "Run calculator",
        style="color: #fff; background-color: #337ab7; border-color: #2e6da4"
      ),
      HTML("<br><br><br>"),
      
      #Table of predictions
      dataTableOutput(
        outputId = "table1"
      ) %>% 
        withSpinner(
          color = "#337ab7",
          type = 8
        ),
      
      HTML("<br>"),
      
      textOutput(
        outputId = "footnote"
      ),
      HTML("<br>"),
      textOutput(
        outputId = "footnote2"
      ),
      
      HTML("<br>"),
      
      #References
      wellPanel(
        span(
          textOutput(
            outputId = "reference"
          ),
          style = "font-size: 25px"
        ),
        textOutput(
          outputId = "reference_text"
        ),
        textOutput(
          outputId = "reference_text2"
        )
      ),
      
      HTML("<br>"),
      
      #Disclaimer
      wellPanel(
        span(
          textOutput(
            outputId = "disclaimer"
          ),
          style = "font-size: 25px"
        ),
        textOutput(
          outputId = "disclaimer_text"
        )
      ),
      
      p(
        a("Source Code", 
          href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/BariatricSurgeryComplications", 
          style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
        ),
        style = "text-align: center;"
      ),
      
      #Add CCF letterhead
      img(
        src = "letterhead.png"
      )
      
    )
    
  )
  
)
