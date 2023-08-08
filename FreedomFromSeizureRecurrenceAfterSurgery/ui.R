library(shiny)
library(shinyBS)
library(shinyjs)
library(shinythemes)

fluidPage(
  shinyjs::useShinyjs(), 
  theme = shinytheme("flatly"),
  tags$head(tags$link(rel="shortcut icon", href="../assets/icons/favicon.ico", type="image/x-icon")),
  tags$head(tags$link(rel="apple-touch-icon", href="../assets/icons/apple-touch-icon.png", type="image/x-icon")),
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
                           numericInput('Preop_Seizure_Freq', 'Preoperative Seizure Frequency (per Month)', value = 0, min = 0, max = 300),
                           bsTooltip("Preop_Seizure_Freq", "Range: 0 - 300", "right", options = list(container = "body")),
                           selectInput('GTC', 'Generalized Tonic-Clonic (GTC) Seizure', choices = c('No', 'Yes')),
                           selectInput('Pathology', 'Cause of Seizures', choices = c('Mesial Temporal Sclerosis (MTS)', 'Malformations of Cortical Development(MCD)', 'Stroke', 'Tumor', 'Other')),
                           selectInput('Type_of_Surgery', 'Type of Surgery', choices = c('Temporal Lobectomy', 'Frontal Lobectomy', 'Posterior Quadrant Resection')),
                           hr(),
                           h5(strong("Predicts 2-year and 5-year probabilities of freedom from seizure recurrence based on clinical criteria alone.[1]", style = "color:#2C3E4F")),
                           numericInput('Time_Between_Onset_Surgery', 'Epilepsy Duration at Time of Surgery (in Years)', value = NA, min = 0, max = 65),
                           bsTooltip("Time_Between_Onset_Surgery", "Range: 0 - 65", "right", options = list(container = "body")),
                           selectInput('Gender', 'Gender', choices = c("", 'Male', 'Female')),
                           hr(),
                           h5(strong("Predicts 2-year probability of freedom from seizures based on clinical criteria and EEG characteristics.[2]", style = "color:#2C3E4F")),
                           selectInput('normalmri', 'MRI Findings', choices = c("", "Normal", "Abnormal")),
                           selectInput('nonlocal', 'EEG Seizure Localization', choices = c("", "Always localizable", "Sometimes non-localizable")),
                           selectInput('bilateral', 'Interictal Epileptiform Discharges', choices = c("", "Bilateral", "No Epileptiform Discharges", ">80% Unilateral"))
              ),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  actionButton("reset_input", "Reset"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  div(id = "result_panel", DT::dataTableOutput('result')),
                  br(),
                  wellPanel(h3('Reference'),
                            p("[1] Jehi L, Yardi R, Chagin K, Tassi L, Russo GL, Worrell G, Hu W, Cendes F, Morita M, Bartolomei F, Chauvel P, Najm I, Gonzalez-Martinez J, Bingaman W, Kattan MW Development and validation of nomograms to provide individualised predictions of seizure outcomes after epilepsy surgery: a retrospective analysis. Lancet Neurol. 2015 Mar;14(3):283-90."),
                            p("[2] Fitzgerald, Z, Morita-Sherman, M., Hogue, O., Joseph, B., Alvim, M.K.M., Yasuda, C.L., Vegh, D., Nair, D., Burgess, R., Bingaman, W., Najm, I., Kattan, M.W., Blumcke, I., Worrell, G., Brinkmann, B.H., Cendes, F., Jehi, L. Improving the prediction of epilepsy surgery outcomes using basic scalp EEG findings. Epilepsia. 2021 Oct; 62(10):2439-2450.")),
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
 a("Add to phone (iOS Safari)", href="https://support.apple.com/guide/iphone/bookmark-favorite-webpages-iph42ab2f3a7/ios#iph4f9a47bbc", target="_blank", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
 " | ", 
 a("Add to phone (Android)", href="https://www.cnet.com/tech/mobile/adding-one-touch-bookmarks-to-your-androids-home-screen/", target="_blank", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
 " | ",
 a("Source Code", 
   href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/FreedomFromSeizureRecurrenceAfterSurgery", 
   style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
 ),
                    style = "text-align: center;"),
                  img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;"))))