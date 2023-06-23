require(shiny)



shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel(h1("Systolic Blood PRessure INtervention Trial (SPRINT) Selection")),
  
  # Sidebar
  sidebarPanel(
    h3("Risk Factors", style="color:ForestGreen"),
    
    h5("Age (yrs.)", style = "color:ForestGreen"),
    sliderInput('AGE', NULL, NULL, min=18, max=90, value=67),
    
    h5("Gender", style="color:ForestGreen"),
    selectInput("FEMALE", NULL, choices=list("Male", "Female")),
    
    h5("Race", style="color:ForestGreen"),
    selectInput("RACE", NULL, choices=list("White", "Black", "Hispanic", "Other")),
    
    h5("Smoking Status", style="color:ForestGreen"),
    selectInput("SMOKE_3CAT", NULL, choices=list("Never", "Former", "Current")),
    
    h5("Daily Aspirin Use", style="color:ForestGreen"),
    selectInput("ASPIRIN", NULL, choices=list("Yes", "No")),
    
    h5("Treated with Antihypertensive Agents?", style="color:ForestGreen"),
    selectInput("NOAGENTS", NULL, choices=list("No", "Yes")),
    
    h5("Number of Antihypertensive Agents", style = "color:ForestGreen"),
    sliderInput('N_AGENTS', NULL, min=0, max=10, value=2),
  
    h5("Statin", style="color:ForestGreen"),
    selectInput("STATIN", NULL, choices=list("No", "Yes")), 
    
    h5("CKD (eGFR < 60)", style="color:ForestGreen"),
    selectInput("SUB_CKD", NULL, choices=list("No", "Yes")), 
    
    h5("History of Clinical CVD†", style="color:ForestGreen"),
    selectInput("SUB_CLINICALCVD", NULL, choices=list("No", "Yes")), 
    
    h5("History of Subclinical CVD‡", style="color:ForestGreen"),
    selectInput("SUB_SUBCLINICALCVD", NULL, choices=list("No", "Yes")), 
    
    h5("Body Mass Index (kg/m^2)", style = "color:ForestGreen"),
    h6("Range: 13 to 70", style="color:gray"),
    numericInput('BMI', NULL, 30, min=13, max=70),
    
    h5("eGFR MDRD (mL/min/1.73m^2)", style = "color:ForestGreen"),
    h6("Range: 14 to 190", style="color:gray"),
    numericInput('EGFR', NULL, 71, min=14, max=200),
    
    h5("Systolic Blood Pressure  (mm Hg)", style = "color:ForestGreen"),
    h6("Range: 70 to 230", style="color:gray"),
    numericInput('SBP', NULL, 139, min=70, max=250),
    
    h5("Diastolic Blood Pressure  (mm Hg)", style = "color:ForestGreen"),
    h6("Range: 40 to 135", style="color:gray"),
    numericInput('DBP', NULL, 78, min=40, max=90),
    
    h5("Total Cholesterol (mg/dL)", style = "color:ForestGreen"),
    h6("Range: 70 to 438", style="color:gray"),
    numericInput('CHR', NULL, 190, min=70, max=450),
    
    h5("HDL-cholesterol direct (mg/dL)", style = "color:ForestGreen"),
    h6("Range: 17 to 161", style="color:gray"),
    numericInput('HDL', NULL, 52, min=17, max=161),
    
    h5("serum creatinine (mg/dL)", style = "color:ForestGreen"),
    h6("Range: 0.2 to 4.0", style="color:gray"),
    numericInput('SCREAT', NULL, 1.08, min=0.1, max=10),
    
    h5("Urine Albumin/Creatinine Ratio (mg/g)", style = "color:ForestGreen"),
    h6("Range: 1 to 5000", style="color:gray"),
    numericInput('UMALCR', NULL, 42),
    
    h5("Glucose (mg/dL)", style = "color:ForestGreen"),
    h6("Range: 40 to 290", style="color:gray"),
    numericInput('GLUR', NULL, 98, min=40, max=290),
    
    h5("Triglycerides (mg/dL)", style = "color:ForestGreen"),
    h6("Range: 23 to 4000", style="color:gray"),
    numericInput('TRR', NULL, 125, min=20)
    
    
        
  ),
  mainPanel(
    plotOutput("pred1", height="700px"),
    
    p(em(strong("† History of Clinical CVD:"), "a) Previous myocardial infarction, percutaneous coronary intervention, coronary artery bypass grafting (CABG), carotid endarterectomy, carotid stenting, b) peripheral artery disease with revascularization, c) acute coronary syndrome with or without resting ECG change, ECG changes on a graded exercise test, or positive cardiac imaging study, d) at least a 50% diameter stenosis of a coronary, carotid, or lower extremity artery, e) abdominal aortic aneurysm ≥ 5 cm with or without repair ")),
    p(em(strong("‡ History of Subclinical CVD:"), "a)	Coronary artery calcium score ≥ 400 Agatston units within the past 2 years, b) ankle brachial index ≤ 0.90 within the past 2 years, c) left ventricular hypertrophy by ECG, echocardiogram report, or other cardiac imaging procedure report within the past 2 years.a)	Coronary artery calcium score ≥ 400 Agatston units within the past 2 years, b) ankle brachial index ≤ 0.90 within the past 2 years, c) left ventricular hypertrophy by ECG, echocardiogram report, or other cardiac imaging procedure report within the past 2 years."))
  ) 
))