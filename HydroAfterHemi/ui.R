# Created: 2024-01-04
# Author: Alex Zajichek
# Project: Predicting hydrocephalus after hemispherectomy
# Description: Contains the user interface

# Build the user interface
fluidPage(
  ### DEVELOPMENT INDICATION
  h3("APP CURRENTLY IN DEVELOPMENT", style = "text-align: center; background-color: tomato; color: black"),
  
  # App theme and title
  shinyjs::useShinyjs(),
  theme = shinytheme("flatly"),
  tags$head(tags$link(rel="shortcut icon", href="../assets/icons/favicon.ico", type="image/x-icon")),
  tags$head(tags$link(rel="apple-touch-icon", href="../assets/icons/apple-touch-icon.png", type="image/x-icon")),
  titlePanel("Predict the probability of hydrocephalus after hemispherectomy in pediatric epilepsy"),

  # Set the layout
  sidebarLayout(
    
    # Sidebar of user inputs
    sidebarPanel(
      id = "sidebar",
      
      ## The inputs objects
      
      # Sex
      selectInput(
        inputId = "sex",
        label = "Sex",
        choices = c("Male", "Female")
      ),
      
      # Age (current)
      numericInput(
        inputId = "age",
        label = "Current age (years)",
        value = NA_real_,
        min = 0,
        max = 21
      ),
      
      # Date of surgery
      dateInput(
        inputId = "surgery_date",
        label = "Date of hemispherectomy",
        value = Sys.Date()
      ),
      
      # Show age at surgery
      textOutput(outputId = "surgery_age"),
      
      # Age of seizure onset
      numericInput(
        inputId = "onset_age",
        label = "Age at seizure onset (years)",
        value = NA_real_,
        min = 0,
        max = 21
      ),
      
      ## Brain volumes
      h4("Brain volume"),
      fluidRow(
        
        # Pre-op
        column(
          width = 6,
          numericInput(
            inputId = "brain_volume_pre",
            label = "Pre-op",
            value = NA_real_
          )
        ),
        
        # Post-op
        column(
          width = 6,
          numericInput(
            inputId = "brain_volume_post",
            label = "Post-op",
            value = NA_real_
          )
        )
      ),
      
      # Surgical technique
      selectInput(
        inputId = "technique",
        label = "Surgical Technique",
        choices = c("Anatomical", "Functional", "Modified Anatomical")
      ),
      
      # Complications
      checkboxInput(inputId = "previous_surgery", label = "Previous Surgery?"),
      checkboxInput(inputId = "complications", label = "Surgical Complications?"),
      checkboxInput(inputId = "infection", label = "Infection?"),
      checkboxInput(inputId = "aseptic_meningitis", label = "Aseptic Meningitis?"),
      checkboxInput(inputId = "evd", label = "EVD Usage?")
      
    ),
    
    # Main panel of result output
    mainPanel(
      
      # Button to run calculator upon entry
      actionButton(
        inputId = "goButton",
        label = "Run Calculator"
      ),
      br(),
      hr(),
      tags$head(tags$style(type = "text/css", "tfoot {display:none;}")),
      
      # Result table of prediction(s)
      div(id = "result_panel", DT::dataTableOutput(outputId = "result")),
      br(),
      
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
        a("Contact Us", href = "mailto:rcalcsupport@ccf.org?body=Predicting%20cognitive%20outcomes%20after%20epilepsy%20surgery", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
        " | ",
        a("Add to phone (iOS Safari)", href="https://support.apple.com/guide/iphone/bookmark-favorite-webpages-iph42ab2f3a7/ios#iph4f9a47bbc", target="_blank", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
        " | ", 
        a("Add to phone (Android)", href="https://www.cnet.com/tech/mobile/adding-one-touch-bookmarks-to-your-androids-home-screen/", target="_blank", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
        " | ",
        a("Source Code", 
          href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/HydroAfterHemi", 
          style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
        ),
        style = "text-align: center;"
      ),
      img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;")
    )
  )
)