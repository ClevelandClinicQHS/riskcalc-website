require(shiny)



shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel(h1("Should I be Screened for Prostate Cancer with a Prostate Specific Antigen (PSA) Test?", style = "color:ForestGreen")),
  
  # Sidebar
  sidebarPanel(
    
    h5("1.  What is your age?"),
    selectInput('Age', NULL, choices = c(">= 70", "65-69", "55-64", "45-54", "< 45")),
    
    h5("2.  What is your race/ethnicity? Select all that apply."),
    selectInput('Race', "Race", choices = c("White/Caucasian", "Black/African-American", "Asian/Pacific Islander", "Native American/Alaskan Native", "Other")),
    selectInput('Ethnic', "Ethnicity", choices = c("Non-Hispanic", "Hispanic")),
    
    h5("3.  Did any of your family members have prostate cancer?"),
    h5("(More than one answer may apply)"),
    selectInput('Hx.pc.father', "a.  My father had prostate cancer ", choices = c("No/Not Sure", "Yes")),
    selectInput('Hx_pc_brother', "b.  My brother had prostate cancer ", choices = c("No/Not Sure", "Yes")),
    conditionalPanel(condition = "input.Hx_pc_brother == 'Yes'",
                     numericInput('Num_pc_brother', "Number of brothers with Prostate Cancer", 0, min=0, max=8)
      ),
    numericInput('Other_Hx_pc_family', "c.  Other family members had prostate cancer. Please consider only those family members related by birth, not by marriage only.", value = 0, min=0),
    checkboxInput('know.family.hx', "d.  I do not know about my father's medical history", FALSE),
    checkboxInput('know.brother.hx', "e.  I do not have brothers or do not know about their medical history", FALSE),
        
    h5("4.  If you have had a digital rectal exam(DRE), what was the result?"),
    selectInput('DRE', NULL, choices = c("No previous DRE", "Normal DRE", "Abnormal DRE")),
    
    h5("5.  If you have had previous PSA level what was the result?"),
    selectInput('prev.PSA', NULL, choices = c("No previous PSA", "PSA < 1.0", "PSA 1.0-2.5", "PSA > 2.5")),
    
    h5("6.  How would you rate your health?"),
    selectInput('Health', NULL, choices = c("Excellent", "Very Good", "Good", "Poor")),
    
    h5("7.  If you were to have problems with incontinence (leakage) of urine, how bothersome would this be for you?"),
    selectInput('Leak', NULL, choices = c("Not Bothersome", "Somewhat Bothersome", "Very Bothersome", "Extremely Bothersome")),
    
    h5("8.  How important is your sex life and maintaining ability to have an erection?"),
    selectInput('Sex', NULL, choices = c("Not Important", "Somewhat Important", "Very Important", "Extremely Important")),
    
    h5("9.  Are you concerned about having or developing prostate cancer?"),
    selectInput('PC.Concern', NULL, choices = c("Not concerned at all", "Little concerned", "Very concerned", "Extremely concerned"))
    
    
    
  ),
  mainPanel(
    
    conditionalPanel(condition = "input.Num_pc_brother < 0",
                     h2("Number of brothers with Prostate Cancer CANNOT be negative (Question 3b)", style="color:Red")
                     ),
    conditionalPanel(condition = "input.Other_Hx_pc_family < 0",
                     h2("Number of other family members who had prostate cancer CANNOT be negative (Question 4c)", style="color:Red")
                     ),
    conditionalPanel(condition = "input.Num_pc_brother >= 0 && input.Other_Hx_pc_family >= 0",
                     plotOutput('pred', height = "800px", width = "75%")
                     )
     
)
))