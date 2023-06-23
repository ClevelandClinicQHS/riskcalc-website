library(shinyWidgets)
library(shinythemes)

fluidPage(theme = shinytheme("flatly"),
    tags$script(HTML(
    'function myFunction() {
  var txt;
  if (confirm("This is a mailbox for reporting website errors to programmers for the risk calculator website.  If you have questions or concerns about a specific calculator, please use the calculator Author Contact Information found on the publication for that calculator.  Each calculator is documented by a specific publication with a corresponding author.")) {
    window.open("mailto:rcalcsupport@ccf.org");
  }
}'
  )),

          titlePanel('Estimated age based on stress testing exercise performance (A-BEST)'),
          sidebarLayout(
              sidebarPanel(id = "sidebar",
                           selectInput("Gender", "Gender", choices = c("Male", "Female")),
                           numericInput("Age", "Age", 0, min = 0, max = 120),
                           numericInput("METs", "Peak metabolic equivalents of task (METs)", 0, min = 0, max = 200),
                           selectInput("BB", "Beta Blocking Agents", choices = c("No", "Yes")),
                           selectInput("AHRR", "Abnormal heart rate recovery", choices = c("No", "Yes")),
                           selectInput("NDCA", "Non-dihydropyridine calcium antagonist (ND-CA)", choices = c("No", "Yes")),
                           #switchInput('EstimateCRI', label = "Estimate Chronotropic Reserve Index (CRI)", value = FALSE, onLabel = 'Yes', offLabel = 'No', width = '200%', size = 'normal'),
                           materialSwitch('EstimateCRI', label = "Estimate Chronotropic Reserve Index (CRI)", status = "success"),
                           conditionalPanel(condition = "input.EstimateCRI == false",
                                            numericInput("CRI", "Chronotropic Reserve Index (CRI)", 0, min = -50, max = 50)),
                           conditionalPanel(condition = "input.EstimateCRI == true",
                                            numericInput("peak.hr", "Peak heart rate", 60, min = 0, max = 300),
                                            numericInput("rest.hr", "Resting heart rate", 60, min = 0, max = 300),
                                            radioButtons("predict_formula", "Predicted maximal HR equation", choices = c("206 - 0.88 * Age", "164 - 0.7 * Age")))
              ),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
                  br(),
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] Serge C Harb, Paul C Cremer, Yuping Wu, Bo Xu, Leslie Cho, Venu Menon and Wael A Jaber. ",a('Estimated age based on exercise stress testing performance outperforms chronological age in predicting mortality', href='https://www.ncbi.nlm.nih.gov/pubmed/30760022'),". Eur J Prev Cardiol. 2019 Feb 13:2047487319826400. doi: 10.1177/2047487319826400.")),
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
                    style = "text-align: center;"),
                  img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;"))))
