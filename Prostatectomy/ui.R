# Created: 2024-07-22
# Author: Alex Zajichek
# Project: Risk of dying from prostate cancer
# Description: Contains the user interface

# Build the user interface
fluidPage(
  ### DEVELOPMENT INDICATION
  h3("APP CURRENTLY IN DEVELOPMENT", style = "text-align: center; background-color: tomato; color: black"),
  
  # Google Analytics
  tags$head(includeHTML("../google-analytics.html")),
  
  # App theme and title
  shinyjs::useShinyjs(),
  theme = shinytheme("flatly"),
  tags$head(tags$link(rel="shortcut icon", href="../assets/icons/favicon.ico", type="image/x-icon")),
  tags$head(tags$link(rel="apple-touch-icon", href="../assets/icons/apple-touch-icon.png", type="image/x-icon")),
  
  # Set the layout
  sidebarLayout(
    
    # Sidebar of user inputs
    sidebarPanel(
      id = "sidebar",
      
      # Temporary inputs
      numericInput(
        inputId = "rod_prostate",
        label = "Risk of death from prostate cancer",
        value = .05
      ),
      numericInput(
        inputId = "rod_other",
        label = "Risk of death from other causes",
        value = .69
      ),
      numericInput(
        inputId = "rod_trt",
        label = "Would have lived if treated",
        value = .03
      )
      
    ),
    
    # Main panel of result output
    mainPanel(
      
      tags$head(tags$style(type = "text/css", "tfoot {display:none;}")),
      
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
      
      # Plot of people
      plotOutput(outputId = "people"),
      br(),
      
      # Descriptive text
      p("The graph above has taken into account the following information that you have reported:"),
      HTML("<h4 style = 'color: #45a8d9'><strong>Health Conditions:</strong></h4>"),
      p("<List of health conditions...>"),
      HTML("<h4 style = 'color: #45a8d9'><strong>Prostate Cancer Characteristics:</strong></h4>"),
      p("<List of prostate cancer characteristics...>"),
      
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