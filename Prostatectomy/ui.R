# Created: 2024-07-22
# Author: Alex Zajichek
# Project: Risk of dying from prostate cancer
# Description: Contains the user interface

# Build the user interface
navbarPage(
  
  ### DEVELOPMENT INDICATION
  h3("APP CURRENTLY IN DEVELOPMENT", style = "text-align: center; background-color: tomato; color: black"),
  
  # Google Analytics
  tags$head(includeHTML("../google-analytics.html")),
  
  # App theme and title
  title = "",
  theme = shinytheme("yeti"), 
  shinyjs::useShinyjs(),
  tags$head(tags$link(rel="shortcut icon", href="../assets/icons/favicon.ico", type="image/x-icon")),
  tags$head(tags$link(rel="apple-touch-icon", href="../assets/icons/apple-touch-icon.png", type="image/x-icon")),
  
  ## Make page structure
  navlistPanel(
    id = "main",
    "Navigation",
    
    # Directions page
    tabPanel(
      title = 'Directions',
      value = "directions",
      
      # Add text
      span('Directions:', style = 'font-size:28px'),
      HTML('<br><br>'),
      span("Fill in all information as accurately as possible. The 15-year predictions on Page 3 reflect the current configuration of the questions throughout all pages. These will be updated in real-time as answers are changed.", style = 'font-size:16px'),
      HTML('<br><br>'),
      
      #Button to go to start app
      actionButton(
        inputId = 'start',
        label = 'Start'
      )
    ),
    
    # Life expectancy questions
    tabPanel(
      title = "1. Life Expectancy",
      value = "life_expectancy",
      
      span("Click each section head to expand the list of questions.", style = 'font-size:16px; font-style: italic'),
      br(),
      br(),
      
      # 1. Heart disease
      dropdownButton(
        circle = FALSE,
        label = "Section 1: Heart Disease",
        status = "success",
        icon = icon("list"),
        
        br(),
        radioButtons(
          inputId = "s1_q1",
          label = "1. Have you ever been told that you have a problem with your heart, or have been treated for heart disease, chest pain or angina?",
          choices = c("Yes", "No"),
          selected = character(0),
          inline = TRUE
        ),
        
        # Additional questions (conditional)
        conditionalPanel(
          condition = "input.s1_q1 == 'Yes'",
          
          br(),
          h5("Angina"),
          radioButtons(
            inputId = "s1_q1a",
            label = "a. Have you ever experienced unexplained chest pain or have been diagnosed with angina or cardiac pain or arterial disease of the heart?",
            choices = c("Yes", "No"),
            selected = character(0),
            inline = TRUE
          ),
          
          br(),
          h5("Blocked Artery"),
          radioButtons(
            inputId = "s1_q1b",
            label = "b. Have you ever had a bypass surgery or a stent placed to treat a blocked artery?",
            choices = c("Yes", "No"),
            selected = character(0),
            inline = TRUE
          ),
          
          br(),
          h5("Congestive Heart Failure (CHF)"),
          radioButtons(
            inputId = "s1_q1c",
            label = "c. Have you ever been diagnosed with congestive heart failure (CHF) or “water in the lungs”, or have you ever been prescribed a “water pill” for your heart?",
            choices = c("Yes", "No"),
            selected = character(0),
            inline = TRUE
          ),
          
          br(),
          h5("Heart Attack"),
          radioButtons(
            inputId = "s1_q1d",
            label = "d. Have you ever had a heart attack?",
            choices = c("Yes", "No"),
            selected = character(0),
            inline = TRUE
          ),
          
          br(),
          h5("Aortic Stenosis"),
          radioButtons(
            inputId = "s1_q1e",
            label = "e. Have you ever been diagnosed with a heart valve problem or aortic stenosis or a blockage in one of your heart valves?",
            choices = c("Yes", "No"),
            selected = character(0),
            inline = TRUE
          ),
          
          br(),
          h5("Atrial Fibrillation"),
          radioButtons(
            inputId = "s1_q1f",
            label = "f. Have you ever been diagnosed with an irregular heartbeat or atrial fibrillation?",
            choices = c("Yes", "No"),
            selected = character(0),
            inline = TRUE
          )
          
          
        )
        
      ),
      
      conditionalPanel(
        condition = "input.s1_q1",
        HTML("&#10003"),
      ),
      
      br(),
      
      # 2. Pulmonary assessment
      dropdownButton(
        circle = FALSE,
        label = "Section 2: Pulmonary Assessment",
        status = "success",
        icon = icon("list"),
        
        br(),
        h5("Asthma"),
        radioButtons(
          inputId = "s2_q1",
          label = "1.Have you ever been diagnosed with asthma?",
          choices = c("Yes", "No"),
          selected = character(0),
          inline = TRUE
        ),
        
        # Additional question (conditional)
        conditionalPanel(
          condition = "input.s2_q1 == 'Yes'",
          
          br(),
          radioButtons(
            inputId = "s2_q1a",
            label = "a. What severity of asthma describes your illness?",
            choices = c("Mild = does not interfere with daily activities", "Moderate = some interference", "Severe = major impact"),
            selected = character(0),
            inline = TRUE
          ),
          
        ),
        
        br(),
        h5("COPD"),
        radioButtons(
          inputId = "s2_q2",
          label = "2. Do you suffer from “smoker’s lung” or have been diagnosed with chronic obstructive pulmonary disease (COPD) or emphysema?",
          choices = c("Yes", "No"),
          selected = character(0),
          inline = TRUE
        )
        
      ),
      
      conditionalPanel(
        condition = "input.s2_q2",
        HTML("&#10003"),
      ),
      
      br(),
      
      # 3. Vascular Related Conditions
      dropdownButton(
        circle = FALSE,
        label = "Section 3: Vascular Related Conditions Assessment",
        status = "success",
        icon = icon("list"),
        
        br(),
        h5("Abdominal Aortic Aneurysm"),
        radioButtons(
          inputId = "s3_q1",
          label = "1. Have you ever been diagnosed with an abdominal aortic aneurysm, or been told that you have a widening of a major artery in your abdomen?",
          choices = c("Yes", "No"),
          selected = character(0),
          inline = TRUE
        ),
        
        br(),
        h5("Peripheral Vascular Disease"),
        radioButtons(
          inputId = "s3_q2",
          label = "2. Have you ever suffered pain in your legs related to poor circulation, or have been diagnosed with peripheral vascular disease or claudication?",
          choices = c("Yes", "No"),
          selected = character(0),
          inline = TRUE
        ),
        
        br(),
        h5("Deep Venous Thrombosis"),
        radioButtons(
          inputId = "s3_q3",
          label = "3.Have you ever had a deep venous thrombosis, or have been treated with blood thinners for blood clots in your legs or arms?",
          choices = c("Yes", "No"),
          selected = character(0),
          inline = TRUE
        ),
        
        br(),
        h5("Pulmonary Embolus"),
        radioButtons(
          inputId = "s3_q4",
          label = "4. Have you ever suffered from a blood clot in your lungs or a pulmonary embolus?",
          choices = c("Yes", "No"),
          selected = character(0),
          inline = TRUE
        )
        
      ),
      
      conditionalPanel(
        condition = "input.s3_q4",
        HTML("&#10003"),
      ),
      
      br(),
      
      # 4. Additional Comorbidity Questions
      dropdownButton(
        circle = FALSE,
        label = "Section 4: Additional Comorbidity Questions",
        status = "success",
        icon = icon("list"),
        
        br(),
        h5("Smoking"),
        radioButtons(
          inputId = "s4_q1",
          label = "1. Have you smoked >100 cigarettes in your lifetime?",
          choices = c("Yes", "No"),
          selected = character(0),
          inline = TRUE
        ),
        
        # Additional questions (conditional)
        conditionalPanel(
          condition = "input.s4_q1 == 'Yes'",
          
          br(),
          radioButtons(
            inputId = "s4_q1a",
            label = "a. Have you smoked in the past 30 days?",
            choices = c("Yes", "No"),
            selected = character(0),
            inline = TRUE
          ),
          
          # Additional questions (once checked)
          conditionalPanel(
            condition = "input.s4_q1a",
            
            br(),
            selectInput(
              inputId = "s4_q1b",
              label = "b. At what age did you start smoking?",
              choices = c("<13", as.character(seq(13, 29, 1)), "30+"),
              selected = character(0)
            ),
            
            br(),
            selectInput(
              inputId = "s4_q1c",
              label = "c. What is the average number of cigarettes you smoke per day?",
              choices = c("<=5", "6-10", "11-15", "16-20", "21-25", "26-30", "31-40", "41-50", "51-60", "61-70", "71-80", "80+"),
              selected = character(0)
            ),
            
            # Additional question (if no)
            conditionalPanel(
              condition = "input.s4_q1a == 'No'",
              
              br(),
              selectInput(
                inputId = "s4_q1d",
                label = "d. At what age did you quit smoking?",
                choices = c("<13", as.character(seq(13, 69, 1)), "70+"),
                selected = character(0)
              )
              
            )
            
          )
          
        ),
        
        br(),
        h5("Cholesterol"),
        radioButtons(
          inputId = "s4_q2",
          label = "2. Do you know, approximately, what your level of total cholesterol is? If you are taking pills for your cholesterol, tell us about your cholesterol when you are on the pills.",
          choices = c("High (>270 mg/dL)", "Medium (200-270 mg/dL)", "Normal (<200 mg/dL)", "Not sure"),
          selected = character(0),
          inline = TRUE
        ),
        
        br(),
        radioButtons(
          inputId = "s4_q3",
          label = "3. Do you know approximately what your level of HDL (“good”) cholesterol is?",
          choices = c("Extremely Low (<20 mg/dL)", "Low (21-60 mg/dL)", "Normal (>60 mg/dL)", "Not sure"),
          selected = character(0),
          inline = TRUE
        ),
        
        br(),
        h5("Blood Pressure"),
        radioButtons(
          inputId = "s4_q4",
          label = "4. Blood pressure is often described as one number “over” another, such as “115 over 70”. If you know your blood pressure, approximately, what is the first (higher) number? If you are taking pills for your blood pressure, tell us about your blood pressure when you are on the pills.",
          choices = c("High (>=160 mm Hg)", "Elevated (140-159 mm Hg)", "Normal/Low (<140 mm Hg)", "Not sure"),
          selected = character(0),
          inline = TRUE
        ),
        
        br(),
        radioButtons(
          inputId = "s4_q5",
          label = "5. What is the second (lower) number?",
          choices = c("High (>= 100 mm Hg)", "Elevated (90-99 mm Hg)", "Normal/Low (<90 mm Hg)", "Not sure"),
          selected = character(0),
          inline = TRUE
        ),
        
        br(),
        h5("Diabetes"),
        radioButtons(
          inputId = "s4_q6",
          label = "6. Have you ever been diagnosed with diabetes?",
          choices = c("Yes", "No"),
          selected = character(0),
          inline = TRUE
        ),
        
        # Addition question (conditional)
        conditionalPanel(
          condition = "input.s4_q6 == 'Yes'",
          
          br(),
          radioButtons(
            inputId = "s4_q6a",
            label = "a. When were you diagnosed with diabetes?",
            choices = c("0-5 years ago", "6-10 years ago", "11-20 years ago", ">20 years ago"),
            selected = character(0),
            inline = TRUE
          )
          
        ),
        
        br(),
        h5("TIA"),
        radioButtons(
          inputId = "s4_q7",
          label = "7. Have you ever suffered from a “mini stroke” or a TIA or been treated with blood thinners for a “mini stroke”?",
          choices = c("Yes", "No"),
          selected = character(0),
          inline = TRUE
        ),
        
        br(),
        h5("Stroke"),
        radioButtons(
          inputId = "s4_q8",
          label = "8. Have you ever had a stroke?",
          choices = c("Yes", "No"),
          selected = character(0),
          inline = TRUE
        ),
        
        # Addition question (conditional)
        conditionalPanel(
          condition = "input.s4_q8 == 'Yes'",
          
          br(),
          checkboxGroupInput(
            inputId = "s4_q8a",
            label = "a. Did the stroke involve bleeding in the brain (“hemorrhage”) or a blood clot (“infarction”, “thrombosis” or “embolism”)?",
            choices = c("Bleeding", "Blood clot", "Unknown"),
            inline = TRUE
          )
          
        )
        
      ),
      
      conditionalPanel(
        condition = "input.s4_q8",
        HTML("&#10003"),
      ),
      
      br(),
      br(),
      
      # Button to go to next page
      actionButton(
        inputId = 'nextPage1',
        label = 'Next'
      )
      
    ),
    
    # Prostate cancer risk
    tabPanel(
      title = "2. Prostate Cancer Risk",
      value = "prostate_cancer",
      
      span("Click each section head to expand the list of questions.", style = 'font-size:16px; font-style: italic'),
      br(),
      br(),
      
      # 5. Prostate cancer
      dropdownButton(
        circle = FALSE,
        label = "Section 5: Prostate Cancer",
        status = "success",
        icon = icon("list"),
        
        br(),
        h5("Patient Info"),
        sliderInput(
          inputId = "s5_q1",
          label = "1. Age (18-80)",
          min = 18,
          max = 80,
          value = 31
        ),
        
        br(),
        selectInput(
          inputId = "s5_q2",
          label = "2. T Stage",
          choices = 
            c(
              "",
              "T1A/T1B: tumor in prostate tissue resected (for other reasons)",
              "T1C: tumor in biopsy performed due to an elevated serum PSA",
              "T2A: tumor in half or less than half of one of the prostate lobes",
              "T2B: tumor in more than half of one lobe, but not both",
              "T2C: tumor in both lobes but within prostatic capsule",
              "T3: tumor has spread through the prostatic capsule",
              "T4: tumor invaded other nearby structures"
            )
        ),
        
        br(),
        selectInput(
          inputId = "s5_q3",
          label = "3. M Stage",
          choices = 
            c(
              "",
              "No evidence of metastasis M0",
              "I have metastatic disease M1"
            )
        ),
        
        br(),
        selectInput(
          inputId = "s5_q4",
          label = "4. N Stage",
          choices = 
            c(
              "",
              "No evidence of cancer in lymph nodes N0",
              "I have cancer in my lymph nodes N1"
            )
        ),
        
        br(),
        selectInput(
          inputId = "s5_q5",
          label = "5. Grade",
          choices = 
            c(
              "",
              "6",
              "3+4",
              "4+3",
              "8",
              "9",
              "10"
            )
        ),
        
        br(),
        numericInput(
          inputId = "s5_q6",
          label = "6. PSA (0-100)",
          value = 0,
          min = 0,
          max = 100
        )
        
      ),
      
      conditionalPanel(
        condition = "input.s5_q5 != ''",
        HTML("&#10003"),
      ),
      
      br(),
      br(),
      
      # Button to go to next page
      actionButton(
        inputId = 'nextPage2',
        label = 'Next'
      )
      
    ),
    
    # Result page
    tabPanel(
      title = "3. 15-Year Predictions",
      value = "results",
      
      # Header
      h1("Life Expectancy Predictions"),
      
      # Descriptive text
      p("Imagine there were 100 men like you, the same age and overall health, and the same prostate cancer in terms of stage, grade, and PSA. This is what we would expect to happen:"),
      
      # Header of table
      h2("In 15 Years", style = "color: #45a8d9"),
      
      # Row of percentages above graph
      fluidRow(
        column(
          width = 3,
          htmlOutput(outputId = "label_no_death")
        ),
        column(
          width = 3,
          htmlOutput(outputId = "label_death_ps")
        ),
        column(
          width = 3,
          htmlOutput(outputId = "label_death_other")
        )
      ),
      
      # Plot of people (with a loader object)
      withSpinner(
        tagList(
          plotOutput(outputId = "people"),
          
          br(),
          
          # Descriptive text
          p("The graph above has taken into account the following information that you have reported:"),
          HTML("<h4 style = 'color: #45a8d9'><strong>Health Conditions:</strong></h4>"),
          htmlOutput(outputId = "list_of_health_conditions"),
          HTML("<h4 style = 'color: #45a8d9'><strong>Prostate Cancer Characteristics:</strong></h4>"),
          htmlOutput(outputId = "list_of_ps_factors")
        )
      )
      
    ),
    
    # About panel
    tabPanel(
      title = "About",
      value = "about",
      
      tags$head(tags$style(type = "text/css", "tfoot {display:none;}")),
      
      # Contact/citation information
      wellPanel(h3('Click Below for Calculator and Author Contact Information')),
      
      # Disclaimer message
      wellPanel(
        h3('Disclaimer'),
        p("No Medical Advice. ALTHOUGH SOME CONTENT MAY BE PROVIDED BY INDIVIDUALS IN THE MEDICAL PROFESSION, YOU ACKNOWLEDGE THAT PROVISION OF SUCH CONTENT DOES NOT CREATE A MEDICAL PROFESSIONAL-PATIENT RELATIONSHIP AND DOES NOT CONSTITUTE AN OPINION, MEDICAL ADVICE, PROFESSIONAL DIAGNOSIS, SERVICE OR TREATMENT OF ANY CONDITION. Access to general information is provided for educational purposes only, through this site and links to other sites. Content is not recommended or endorsed by any doctor or healthcare provider. The information and Content provided are not substitutes for medical or professional care, and you should not use the information in place of a visit, call, consultation or the advice of your physician or other healthcare provider. You are liable or responsible for any advice, course of treatment, diagnosis or any other information, services or product obtained through this site.")
      ),
      
      # Links
      p(
        a("Homepage", href = "../", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
        " | ",
        a("Contact Us", href = "mailto:rcalcsupport@ccf.org?body=Prostatectomy", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
        " | ",
        a("Add to phone (iOS Safari)", href="https://support.apple.com/guide/iphone/bookmark-favorite-webpages-iph42ab2f3a7/ios#iph4f9a47bbc", target="_blank", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
        " | ", 
        a("Add to phone (Android)", href="https://www.cnet.com/tech/mobile/adding-one-touch-bookmarks-to-your-androids-home-screen/", target="_blank", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
        " | ",
        a("Source Code", 
          href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/Prostatectomy", 
          style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
        ),
        style = "text-align: center;"
      ),
      img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;")
    )
    
  )

)