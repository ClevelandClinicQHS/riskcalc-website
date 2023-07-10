library(shiny)
library(shinyBS)
library(shinythemes)
library(shinyjs)
library(shinyWidgets)

fluidPage(
  shinyjs::useShinyjs(), 
  theme = shinytheme("flatly"),
  
  tags$script(HTML(
    'function myFunction() {
  var txt;
  if (confirm("This is a mailbox for reporting website errors to programmers for the risk calculator website.  If you have questions or concerns about a specific calculator, please use the calculator Author Contact Information found on the publication for that calculator.  Each calculator is documented by a specific publication with a corresponding author.")) {
    window.open("mailto:rcalcsupport@ccf.org");
  }
}'
  )),
  
  titlePanel('Calculate BMI'),
  column(3,
         wellPanel(
           radioGroupButtons(inputId = "metric",label = "Height and weight", choices = c("English", "Metric"),status = "info"),
           conditionalPanel(
             condition = "input.metric == 'English'",
             numericInput('height_inch', 'Height (inch)', value = 68, min = 40, max = 96),
             bsPopover(id = "height_inch",title= "Height (inch)", content = "Height in inches: 40-96", placement = "right", trigger = "hover", options = list(container = "body")),
             numericInput('weight_pound', 'Weight (pound)', value = 150, min = 60, max = 500),
             bsPopover(id = "weight_pound",title= "Weight (pound)", content = "Weight in pounds: 60-500", placement = "right", trigger = "hover", options = list(container = "body"))
           ),
           conditionalPanel(
             condition = "input.metric == 'Metric'",
             numericInput('height_cm', 'Height (cm)', value = 170, min = 80, max = 240),
             bsPopover(id = "height_cm",title= "Height (cm)", content = "Height in cms: 80-240", placement = "right", trigger = "hover", options = list(container = "body")),
             numericInput('weight_kg', 'Weight (kg)', value = 80, min = 30, max = 250),
             bsPopover(id = "weight_kg",title= "Weight (kg)", content = "Weight in kgs: 30-250", placement = "right", trigger = "hover", options = list(container = "body"))
           ))
  ),
  column(9,
         actionButton("goButton", "Run Calculator"),
         br(),
         hr(),
         tags$head(
           tags$style(type="text/css", "tfoot {display:none;}")
         ),
         div(id = "result_panel", 
             DT::dataTableOutput('result')),
         br(),
         wellPanel(h3('Click Below for Calculator and Author Contact Information'),
                   p("[1] World Health Organization ",
                     a('Body mass index (BMI)',
                       href='https://www.who.int/data/gho/data/themes/topics/topic-details/GHO/body-mass-index'))),
         
         wellPanel(h3('Disclaimer'),
                   p("No Medical Advice. ALTHOUGH SOME CONTENT MAY BE PROVIDED BY INDIVIDUALS IN THE MEDICAL PROFESSION, YOU ACKNOWLEDGE THAT PROVISION OF SUCH CONTENT DOES NOT CREATE A MEDICAL PROFESSIONAL-PATIENT RELATIONSHIP AND DOES NOT CONSTITUTE AN OPINION, MEDICAL ADVICE, PROFESSIONAL DIAGNOSIS, SERVICE OR TREATMENT OF ANY CONDITION. Access to general information is provided for educational purposes only, through this site and links to other sites. Content is not recommended or endorsed by any doctor or healthcare provider. The information and Content provided are not substitutes for medical or professional care, and you should not use the information in place of a visit, call, consultation or the advice of your physician or other healthcare provider. You are liable or responsible for any advice, course of treatment, diagnosis or any other information, services or product obtained through this site.")),
         p(a("Homepage",
             href = "../", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"), 
           " | ",
           a("Website Error Messages",
             href = "javascript:myFunction()",
             style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
           " | ",
           a("Source Code", 
             href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/AppExample", 
             style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
           style = "text-align: center;"),
         img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;")))