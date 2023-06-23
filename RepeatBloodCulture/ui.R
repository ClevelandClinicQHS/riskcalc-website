library(shiny)
fluidPage(
  # App title
  titlePanel("Probablity that a repeat blood culture shows gram negative"),
  
  # Sidebar layout with input and output definitions
  sidebarLayout(
    # Sidebar panel for inputs
    sidebarPanel(
    
      
      
        # Input: text input for BMI
      textInput("BMI", "BMI", value = 23, placeholder = "12 - 52"),
     
       # Input: text input for Age
      textInput("Age", "Age (years)", value = 70, placeholder = "1 - 110"),
     
       # Input: select list input for Gender
      selectInput("Gender", "Gender",  choices = c("Male", "Female")),
      
      # Input: select list input for Race
      selectInput("Race", "Race",choices = c("Black", "White", "Other")),      
      
      # Input: select list input for Cardiac Device
      selectInput("CardiacDevice", "Cardiac Device?",   choices = c("No", "Pacmaker/defibrillator")),
     
       # Input: select list input for Joint Replacement 
      selectInput("JointReplacement", "Joint Replacement?",  choices = c("No", "Yes")),
     
       # Input: select list input for MDRO 
      selectInput("mdr_organism", "MDR Organism?",  choices = c("No", "MDRO")),
     
       # Input: select list input for resist 
      selectInput("resist_abx_adm", "Resist to ABX on Admission",  choices = c("Yes", "No")),
      
      # Input: select list input for source 
      selectInput("source", "Infection Source",
                  choices = c("URINARY TRACT INFECTION",
                              "CENTRAL LINE INFECTION", "GASTROINTESTINAL INFECTION", "PNEUMONIA", "PROSTHETIC/HARDWARE/FOREIGN DEVICE INFECTION",
                              "SKIN/SOFT TISSUE INFECTION", "UKNOWN SOURCE")),
     
       # Input: select list input for bld_clt_adm 
      selectInput("bld_clt_adm", "Blood Culture on Admission",
                  choices = c("ESCHERICHIA COLI", "KLEBSIELLA PNEUMONIA", "OTHER GRAM NEGATIVE", "PSEUDOMONAS AERUGINOSA")),
     
       # Input: text input for BMI
      textInput("resp_rateAt48hrs", "Respiratory Rate at 48 hours",  value = 18, placeholder = "0 - 1000"),
    
        # Input: text input for systolic_48Hrs
      textInput("systolic_48Hrs", "Systolic BP at 48 hours",  value = 124, placeholder = "0 - 1000"),
    
       # Input: text input for pulse
      textInput("pulse_48Hrs", "Pulse at 48 hours", value = 83, placeholder = "0 - 1000"),
      
      # Input: text input for WBC_AtAdmsn
      textInput("WBC_AtAdmsn", "WBC at Admission",  value = 12, placeholder = "0 - 1000"),
      
      # Input: text input for pulse
     #textInput("WBCOrd_value_48Hrs", "WBC at 48 hours",  value = 9, placeholder = "0 - 1000"),
     
       # Input: text input for pulse
      #textInput("PLTOrd_value_48Hrs", "PLT at 48 hours",  value = 140, placeholder = "0 - 1000"),
     
       # Input: text input for glucose_Admsn
      textInput("glucose_Admsn", "Glucose at Admission",  value = 126, placeholder = "0 - 1000"),
      
      # Input: text input for pulse
      textInput("glucose_48Hrs", "Glucose at 48 hours",    value = 109, placeholder = "0 - 1000"),      
   
      # Input: text input for CarbonDioxideAdmsn
      textInput("CarbonDioxideAdmsn", "Carbon Dioxide at Admission", value = 22, placeholder = "0 - 240"),
      
      # Input: text input for 
      #textInput("CarbonDioxide_48Hrs", "Carbon Dioxide at 48 hours", value = 22, placeholder = "0 - 240"),      
      
      # Input: text input for Serum_Creat_Admsn
      textInput("Serum_Creat_Admsn", "Serum Creatinine at Admission",     value = 1, placeholder = "0 - 240"),

      # Input: text input for BUNOrd_value_AtAdmsn
      textInput("BUNOrd_value_AtAdmsn", "BUN at Admission",  value = 25, placeholder = "0 - 240"),
      
      # Input: text input for pulse
     # textInput("BUNOrd_value_48Hrs", "BUN at 48 hours",  value = 22, placeholder = "0 - 240"),    
 
      # Input: text input for K_Blood_Admsn
      textInput("K_Blood_Admsn", "Potassium at Admission",    value = 4, placeholder = "0 - 240"),
   
      # Input: text input for SerumSodium_Admsn
      textInput("SerumSodium_Admsn", "Serum Sodium at Admission",   value = 140, placeholder = "0 - 240")),

    # Main panel for displaying outputs
    mainPanel(
      # Output: Table
      tableOutput("result")
    )
  )
)