library(shiny)
library(shinyBS)
library(shinyjs)
library(shinythemes)

fluidPage(
  shinyjs::useShinyjs(), 
  theme = shinytheme("flatly"),
          tags$head(
            tags$style(HTML("hr {border-top: 1px solid #000000;}"))
          ),
    tags$script(HTML(
    'function myFunction() {
  var txt;
  if (confirm("This is a mailbox for reporting website errors to programmers for the risk calculator website.  If you have questions or concerns about a specific calculator, please use the calculator Author Contact Information found on the publication for that calculator.  Each calculator is documented by a specific publication with a corresponding author.")) {
    window.open("mailto:rcalcsupport@ccf.org");
  }
}'
  )),

          titlePanel('For Patients Eligible For Epilepsy Surgery'),
          sidebarLayout(
              sidebarPanel(id = "sidebar",
                           numericInput('Epilepsy_duration', 'Epilepsy duration', value = 0, min = 0, max = 60),
                           bsTooltip("Epilepsy_duration", "Range: 0 - 60", "right", options = list(container = "body")),
                           selectInput('Gender', 'Gender', choices = c('Male', 'Female')),
                           selectInput('GTC', 'Generalized Tonic-Clonic (GTC) Seizure', choices = c('No', 'Yes')),
                           selectInput('MRI', 'MRI', choices = c('Normal', 'Abnormal')),
                           selectInput('Expected_Epilepsy_Localization', 'Expected Epilepsy Localization', choices = c('Temporal', 'Extratemporal')),
                           selectInput('EEG', 'EEG interictal findings ', choices = c('No interictal discharge', 'Unilateral interictal discharge', 'Bilateral interictal discharge')),
              ),
              mainPanel(
                  div(id = "result_panel", DT::dataTableOutput('result')),
                  br(),
                  # wellPanel(h3('Click Below for Calculator and Author Contact Information'),
                  #           p("[1] Jehi L, Yardi R, Chagin K, Tassi L, Russo GL, Worrell G, Hu W, Cendes F, Morita M, Bartolomei F, Chauvel P, Najm I, Gonzalez-Martinez J, Bingaman W, Kattan MW ",a('Development and validation of nomograms to provide individualised predictions of seizure outcomes after epilepsy surgery: a retrospective analysis.', href='http://www.ncbi.nlm.nih.gov/pubmed/25638640'),". Lancet Neurol. 2015 Mar;14(3):283-90. doi: 10.1016/S1474-4422(14)70325-4. Epub 2015 Jan 29."),
                  #           p("[2] Improving the prediction of epilepsy surgery outcomes using basic scalp EEG findings")),
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