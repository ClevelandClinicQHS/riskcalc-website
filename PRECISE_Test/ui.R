

fluidPage(
  #titlePanel("Predicting Recurrence, Complications and Overall Health Status after Pelvic Organ Prolapse Surgery"),
  fluidRow(
    h1("Predicting Recurrence, Complications and Overall Health Status after Pelvic Organ Prolapse Surgery", style = "color:ForestGreen"),
    
    column(3, wellPanel(
      sliderInput('Age', "Age", min=18, max=100, value=63),
      selectInput('CARDIAC', "Cardiac Disorder", choices = c("No", "Yes")),
      selectInput('SF36Q3', "Current health limits vigorous activities such as running,\n lifting heavy objects, participating in strenuous sports", choices = c("Limited a little", "Limited a lot", "Not limited at all")),
      selectInput('anticoag', "Anticoagulant Use", choices = c("No", "Yes")),
      numericInput('BMI', "Body Mass Index", min=15, max=60, value=27),
      sliderInput('BP', "POPQ Stage Bp", min=-12, max=12, value=0),
      selectInput('POSTERIORC', "Concurrent Posterior Repair", choices = c("No", "Yes"))
    )),
    
    column(3, wellPanel(
      numericInput('VPARITY', "Parity", min=0, max=15, value=0),
      selectInput('uppergi', "Upper Gastrointestinal Disorder", choices = c("No", "Yes")),
      selectInput('lifting', "Heavy Lifting Frequency", choices = c("Less than or equal to once a month", "Two to three times a month", "Once a week", "More than once a week", "Never")),
      sliderInput('CMIRS_SUM', "Number of Comorbid Conditions", min=0, max=15, value=0),
      selectInput('POPQ', "POPQ Stage", choices = c("II", "III", "IV")),
      sliderInput('GH', "POPQ Stage GH", min=-12, max=12, value=0),
      selectInput('HYSTOOP', "Concurrent Hysterectomy or oophrectomy", choices = c("No", "Yes"))
    )),
    
    column(3, wellPanel(
      selectInput('Race', "Race", choices = c("White", "Black", "Other")),
      selectInput('VASCULAR', "Vascular Disorder", choices = c("No", "Yes")),
      selectInput('smoking.status', "Smoking Status", choices = c("Never", "Former", "Current")),
      selectInput('HYSTERECTOMY', "Prior Hysterectomy", choices = c("No", "Yes")),
      sliderInput('C', "POPQ Stage C", min=-12, max=12, value=0),
      selectInput('anesthetics', "Anesthesia Type", choices = c("General", "Regional")),
      selectInput('ANTIURINE', "Concurrent Continence Procedure", choices = c("Burch", "Sling/TVT", "Other", "None"))
    )),
    
    column(3, wellPanel(
      selectInput('lowergi', "Lower Gastrointestinal Disorder", choices = c("No", "Yes")),
      selectInput('TISSUE', "Connective Tissue Disorder", choices = c("No", "Yes")),
      selectInput('ESTROGEN', "Current Hormone Therapy", choices = c("No", "Yes")),
      selectInput('PRIORPOP', "Prior surgery for POP", choices = c("No", "Yes")),
      sliderInput('BA', "POPQ Stage Ba", min=-12, max=12, value=0),
      selectInput('ANTERIORC', "Concurrent Anterior Repair", choices = c("No", "Yes")),
      selectInput('vault.type', "Vault suspension repair type", choices = c("Abdominal sacral colpopexy", "Colpocleisis", "SSLS", "USLS", "Other", "None"))
    )),
    
    mainPanel(
      plotOutput("pred1", width="95%", height=800)
    )
    
  )
)

