require(shiny)
require(shinydashboard)

dashboardPage(skin = "blue", 
              dashboardHeader(title = "Risk Factors", titleWidth = 300),
              dashboardSidebar(width = 300,
                               tags$head(
                                 
                                 tags$style(HTML(".sidebar {height: 100vh; overflow-y: auto;}") # close HTML
                                 )# close tags$style
                                 
                               ),
                               
                               
                               h5("Age (yrs.)"),
                               sliderInput('AGE', NULL, NULL, min=50, max=90, value=67),
                               
                               h5("Gender"),
                               selectInput("FEMALE", NULL, choices=list("Male", "Female")),
                               
                               h5("Race"),
                               selectInput("RACE", NULL, choices=list("White", "Black", "Hispanic", "Other")),
                               
                               h5("Smoking Status"),
                               selectInput("SMOKE_3CAT", NULL, choices=list("Never", "Former", "Current")),
                               
                               h5("Daily Aspirin Use"),
                               selectInput("ASPIRIN", NULL, choices=list("Yes", "No")),
                               
                               h5("Treated with Antihypertensive Agents?"),
                               selectInput("NOAGENTS", NULL, choices=list("No", "Yes")),
                               
                               h5("Number of Antihypertensive Agents"),
                               sliderInput('N_AGENTS', NULL, min=0, max=10, value=0),
                               
                               h5("Statin"),
                               selectInput("STATIN", NULL, choices=list("No", "Yes")), 
                               
                               h5("Chronic Kidney Disease (Estimated Glomerular Filtration Rate 20 - 59)"),
                               selectInput("SUB_CKD", NULL, choices=list("No", "Yes")), 
                               
                               h5("History of Clinical Cardiovascular Disease †"),
                               selectInput("SUB_CLINICALCVD", NULL, choices=list("No", "Yes")), 
                               
                               h5("History of Subclinical Cardiovascular Disease ‡"),
                               selectInput("SUB_SUBCLINICALCVD", NULL, choices=list("No", "Yes")), 
                               
                               h5("Body Mass Index (kg/m^2)"),
                               h6("Range: 13 to 70", style="color:gray"),
                               numericInput('BMI', NULL, 30, min=13, max=70),
                               
                               h5("Estimated Glomerular Filtration Rate (mL/min/1.73m^2)"),
                               h6("Range: 14 to 190", style="color:gray"),
                               numericInput('EGFR', NULL, 71, min=14, max=200),
                               
                               h5("Systolic Blood Pressure  (mm Hg)"),
                               h6("Range: 130 to 180", style="color:gray"),
                               numericInput('SBP', NULL, 139, min=130, max=180),
                               
                               h5("Diastolic Blood Pressure  (mm Hg)"),
                               h6("Range: 40 to 135", style="color:gray"),
                               numericInput('DBP', NULL, 78, min=40, max=90),
                               
                               h5("Total Cholesterol (mg/dL)"),
                               h6("Range: 70 to 438", style="color:gray"),
                               numericInput('CHR', NULL, 190, min=70, max=450),
                               
                               h5("High-Density Lipoprotein (HDL) Cholesterol Direct (mg/dL)"),
                               h6("Range: 17 to 161", style="color:gray"),
                               numericInput('HDL', NULL, 52, min=17, max=161),
                               
                               h5("Serum Creatinine (mg/dL)"),
                               h6("Range: 0.2 to 4.0", style="color:gray"),
                               numericInput('SCREAT', NULL, 1.08, min=0.1, max=10),
                               
                               h5("Urine Albumin/Creatinine Ratio (mg/g)"),
                               h6("Range: 1 to 5000", style="color:gray"),
                               numericInput('UMALCR', NULL, 42),
                               
                               h5("Glucose (mg/dL)"),
                               h6("Range: 40 to 199", style="color:gray"),
                               numericInput('GLUR', NULL, 98, min=40, max=199),
                               
                               h5("Triglycerides (mg/dL)"),
                               h6("Range: 23 to 4000", style="color:gray"),
                               numericInput('TRR', NULL, 125, min=20)
                               #p(em(strong("*"), "Risk predictions are only reliable within the documented ranges.  Values exceeding these ranges are not guaranteed to be as reliable."))  
              ),
              dashboardBody(
                
                
                h1("Systolic Blood PRessure INtervention Trial (SPRINT) Selection", style = "color:Blue"),
                p("The risk calculator is intended for patients with NO history of diabetes mellitus or stroke. Risk models are built from the SPRINT trial data."),
                h2(textOutput("text")),
                
                
                
                box(
                  width = 100, status = "primary", solidHeader = TRUE, background = "blue", title="4-Year Risk of Major Outcomes", collapsible=T,
                  conditionalPanel(condition = "input.BMI >= 13 && input.BMI <= 70 && input.EGFR >= 14 && input.EGFR <= 190 && input.SBP >= 130 && input.SBP <= 180 && input.DBP >= 40 && input.DBP <= 135 && input.CHR >= 70 && input.CHR <= 438 && input.HDL >= 17 && input.HDL <= 161 && input.SCREAT >= 0.2 && input.SCREAT <= 4 && input.UMALCR >= 1 && input.UMALCR <= 5000 && input.GLUR >= 40 && input.GLUR <= 199 && input.TRR >= 23 && input.TRR <= 4000",
                                   plotOutput("pred1", height = "600px")),
                  conditionalPanel(condition = "input.BMI < 13 || input.BMI > 70",
                                   h5("Body Mass Index is out of range")),
                  conditionalPanel(condition = "input.EGFR < 14 || input.EGFR > 190",
                                   h5("Estimated Glomerular Filtration Rate is out of range")),
                  conditionalPanel(condition = "input.SBP < 130 || input.SBP > 180",
                                   h5("Systolic Blood Pressure is out of range")),
                  conditionalPanel(condition = "input.DBP < 40 || input.DBP > 135",
                                   h5("Diastolic Blood Pressure is out of range")),
                  conditionalPanel(condition = "input.CHR < 70 || input.CHR > 438",
                                   h5("Total Cholesterol is out of range")),
                  conditionalPanel(condition = "input.HDL < 17 || input.HDL > 161",
                                   h5("High-Density Lipoprotein (HDL) is out of range")),
                  conditionalPanel(condition = "input.SCREAT < 0.2 || input.SCREAT > 4",
                                   h5("Serum Creatinine is out of range")),
                  conditionalPanel(condition = "input.UMALCR < 1 || input.UMALCR > 5000",
                                   h5("Urine Albumin/Creatinine Ratio is out of range")),
                  conditionalPanel(condition = "input.GLUR < 40 || input.GLUR > 199",
                                   h5("Glucose is out of range")),
                  conditionalPanel(condition = "input.TRR < 23 || input.TRR > 4000",
                                   h5("Triglycerides is out of range"))
                ),
                
                
                
              box(
                width = 100, status = "primary", solidHeader = TRUE, background = "blue", title="4-Year Risk of Major Outcomes", collapsible=T,
                conditionalPanel(condition = "input.BMI >= 13 && input.BMI <= 70 && input.EGFR >= 14 && input.EGFR <= 190 && input.SBP >= 130 && input.SBP <= 180 && input.DBP >= 40 && input.DBP <= 135 && input.CHR >= 70 && input.CHR <= 438 && input.HDL >= 17 && input.HDL <= 161 && input.SCREAT >= 0.2 && input.SCREAT <= 4 && input.UMALCR >= 1 && input.UMALCR <= 5000 && input.GLUR >= 40 && input.GLUR <= 199 && input.TRR >= 23 && input.TRR <= 4000",
                                 plotOutput("pred2", height = "600px")),
                conditionalPanel(condition = "input.BMI < 13 || input.BMI > 70",
                                 h5("Body Mass Index is out of range")),
                conditionalPanel(condition = "input.EGFR < 14 || input.EGFR > 190",
                                 h5("Estimated Glomerular Filtration Rate is out of range")),
                conditionalPanel(condition = "input.SBP < 130 || input.SBP > 180",
                                 h5("Systolic Blood Pressure is out of range")),
                conditionalPanel(condition = "input.DBP < 40 || input.DBP > 135",
                                 h5("Diastolic Blood Pressure is out of range")),
                conditionalPanel(condition = "input.CHR < 70 || input.CHR > 438",
                                 h5("Total Cholesterol is out of range")),
                conditionalPanel(condition = "input.HDL < 17 || input.HDL > 161",
                                 h5("High-Density Lipoprotein (HDL) is out of range")),
                conditionalPanel(condition = "input.SCREAT < 0.2 || input.SCREAT > 4",
                                 h5("Serum Creatinine is out of range")),
                conditionalPanel(condition = "input.UMALCR < 1 || input.UMALCR > 5000",
                                 h5("Urine Albumin/Creatinine Ratio is out of range")),
                conditionalPanel(condition = "input.GLUR < 40 || input.GLUR > 199",
                                 h5("Glucose is out of range")),
                conditionalPanel(condition = "input.TRR < 23 || input.TRR > 4000",
                                 h5("Triglycerides is out of range"))
              ),
              
              plotOutput("color.plot", height = "400px"),
              p(em(strong("† History of Clinical Cardiovascular Disease:"), "a) Previous myocardial infarction, percutaneous coronary intervention, coronary artery bypass grafting (CABG), carotid endarterectomy, carotid stenting, b) peripheral artery disease with revascularization, c) acute coronary syndrome with or without resting ECG change, ECG changes on a graded exercise test, or positive cardiac imaging study, d) at least a 50% diameter stenosis of a coronary, carotid, or lower extremity artery, e) abdominal aortic aneurysm ≥ 5 cm with or without repair.")),
              p(em(strong("‡ History of Subclinical Cardiovascular Disease:"), "a)  Coronary artery calcium score ≥ 400 Agatston units within the past 2 years, b) ankle brachial index ≤ 0.90 within the past 2 years, c) left ventricular hypertrophy by ECG, echocardiogram report, or other cardiac imaging procedure report within the past 2 years."))
              
              
)
)
