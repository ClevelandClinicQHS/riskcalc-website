library(shiny)
library(shinyBS)
library(shinythemes)
library(shinyjs)

fluidPage(
  shinyjs::useShinyjs(), theme = shinytheme("flatly"),
  tags$head(tags$link(rel="shortcut icon", href="../assets/icons/favicon.ico", type="image/x-icon")),
  tags$head(tags$link(rel="apple-touch-icon", href="../assets/icons/apple-touch-icon.png", type="image/x-icon")),
  
  # Application title
  titlePanel("Predicting AKI post cardiac surgery"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      numericInput("timing", "Duration from end of surgery to metabolic panel draw (hour)", min = 0, max = 48, value = 10),
      numericInput("crPre", "Pre-operative serum creatinine (mg/dl)", min = 0, max = 4, value = 1.1),
      numericInput("crPost", "Post-operative serum creatinine (mg/dl)", min = 0, max = 4, value = 1.3),
      numericInput("albPost", "Post-operative serum albumin (mg/dl)", min = 0, max = 10, value = 2.6),
      numericInput("bunPost", "Post-operative BUN (mg/dl)", min = 0, max = 200, value = 22),
      numericInput("kPost", "Post-operative serum potassium (mmol/L)", min = 0, max = 10, value = 4.4),
      numericInput("naPost", "Post-operative serum sodium (mmol/L)", min = 80, max = 200, value = 137),
      numericInput("hco3Post", "Post-operative serum bicarbonate (mmol/L)", min = 0, max = 80, value = 23),
      
      bsTooltip("timing", "Range: 0 - 48", "right", options = list(container = "body")),
      bsTooltip("crPre", "Range: 0 - 4", "right", options = list(container = "body")),
      bsTooltip("crPost", "Range: 0 - 4", "right", options = list(container = "body")),
      bsTooltip("albPost", "Range: 0 - 10", "right", options = list(container = "body")),
      bsTooltip("bunPost", "Range: 0 - 200", "right", options = list(container = "body")),
      bsTooltip("kPost", "Range: 0 - 10", "right", options = list(container = "body")),
      bsTooltip("naPost", "Range: 80 - 200", "right", options = list(container = "body")),
      bsTooltip("hco3Post", "Range: 0 - 80", "right", options = list(container = "body")),
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      #actionButton("goButton", "Run Calculator"),
      #br(),
      #br(),
      tags$head(tags$style(type = "text/css", "tfoot {display:none;}")),
      DT::dataTableOutput('result'),
      br(),
      wellPanel(
          h3('Click Below for Calculator and Author Contact Information'),
          p(
              "Demirjian S, Bashour CA, Shaw A, et al.",
              a(
                  "Predictive Accuracy of a Perioperative Laboratory Test–Based Prediction Model for Moderate to Severe Acute Kidney Injury After Cardiac Surgery. ",
                  href = "https://jamanetwork.com/journals/jama/article-abstract/2789659"
              ),
              "JAMA. 2022;327(10):956–964. doi:10.1001/jama.2022.1751 "
          )
      ),
      wellPanel(
        h3('Disclaimer'),
        p(
          "No Medical Advice. ALTHOUGH SOME CONTENT MAY BE PROVIDED BY INDIVIDUALS IN THE MEDICAL PROFESSION, YOU ACKNOWLEDGE THAT PROVISION OF SUCH CONTENT DOES NOT CREATE A MEDICAL PROFESSIONAL-PATIENT RELATIONSHIP AND DOES NOT CONSTITUTE AN OPINION, MEDICAL ADVICE, PROFESSIONAL DIAGNOSIS, SERVICE OR TREATMENT OF ANY CONDITION. Access to general information is provided for educational purposes only, through this site and links to other sites. Content is not recommended or endorsed by any doctor or healthcare provider. The information and Content provided are not substitutes for medical or professional care, and you should not use the information in place of a visit, call, consultation or the advice of your physician or other healthcare provider. You are liable or responsible for any advice, course of treatment, diagnosis or any other information, services or product obtained through this site."
        )
      ),
      p(
        a(
          "Homepage",
          href = "../",
          style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
        ),
        " | ",
        a(
          "Website Error Messages",
          href = "javascript:myFunction()",
          #href = "mailto:rcalcsupport@ccf.org",
          style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
        ),
        " | ",
        a("Add to phone (iOS Safari)", href="https://support.apple.com/guide/iphone/bookmark-favorite-webpages-iph42ab2f3a7/ios#iph4f9a47bbc", target="_blank", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
        " | ", 
        a("Add to phone (Android)", href="https://www.cnet.com/tech/mobile/adding-one-touch-bookmarks-to-your-androids-home-screen/", target="_blank", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
        " | ",
        a("Source Code", 
          href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/AKIpostCardiacSurgery", 
          style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
        ),
        style = "text-align: center;"
      ),
      img(src = '../logo-ccf.png', style = "max-width:50%; max-height:100%;")
      
    )
  )
)
