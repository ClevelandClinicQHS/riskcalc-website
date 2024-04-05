# Created: 2024-04-05
# Author: Alex Zajichek
# Project: Lorlatinib
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
  titlePanel("Lorlatinib"),

  # Set the layout
  sidebarLayout(
    
    # Sidebar of user inputs
    sidebarPanel(
      id = "sidebar",
      
      ## The inputs objects
      
      # Age
      textInput(
        inputId = "age",
        label = "Age (years)",
        placeholder = "0 - 100"
      ),
      
      # Sex
      selectInput(
        inputId = "sex",
        label = "Sex",
        choices = c("Male", "Female")
      ),
      
      # Race
      selectInput(
        inputId = "race",
        label = "Race",
        choices = c("Asian", "White")
      ),
      
      # Ethnicity
      selectInput(
        inputId = "ethnicity",
        label = "Ethnicity",
        choices = c("Other Ethnicity", "Not Hispanic or Latino")
      ),
      
      # Metastasis
      selectInput(
        inputId = "metastasis",
        label = "Invasive Metastasis Present on Baseline",
        choices = c("Yes", "No")
      ), 
      
      # Smoking
      selectInput(
        inputId = "smoking",
        label = "Smoking History",
        choices = c("Current/Former", "Never")
      ),
      
      # ECOG
      selectInput(
        inputId = "ecog",
        label = "ECOG Baseline",
        choices = c("0", "1 or 2")
      )
      
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
          href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/Lorlatinib", 
          style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
        ),
        style = "text-align: center;"
      ),
      img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;")
    )
  )
)