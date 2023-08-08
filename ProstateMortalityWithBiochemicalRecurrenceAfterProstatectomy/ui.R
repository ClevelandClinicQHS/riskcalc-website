library(shiny)
library(shinythemes)
fluidPage(theme = shinytheme("flatly"),
          tags$head(tags$link(rel="shortcut icon", href="../assets/icons/favicon.ico", type="image/x-icon")),
          tags$head(tags$link(rel="apple-touch-icon", href="../assets/icons/apple-touch-icon.png", type="image/x-icon")),
    tags$script(HTML(
    'function myFunction() {
  var txt;
  if (confirm("This is a mailbox for reporting website errors to programmers for the risk calculator website.  If you have questions or concerns about a specific calculator, please use the calculator Author Contact Information found on the publication for that calculator.  Each calculator is documented by a specific publication with a corresponding author.")) {
    window.open("mailto:rcalcsupport@ccf.org");
  }
}'
  )),

          titlePanel('Predicting Prostate Cancer Specific Mortality for Men with Biochemical Recurrence After Radical Prostatectomy'),
          sidebarLayout(
              sidebarPanel(id = "sidebar"
                           ,
                           textInput('AGEYr', 'Age at Diagnosis (in Years)', placeholder = '40 - 80'),
                           textInput('TIME_FAILURE', 'Time to BCR (in Months)', placeholder = '0 - 18'),
                           textInput('PSADT', '[optional] Prostate-Specific Antigen Doubling Time (PSADT)', placeholder = '0 - 100'),
                           textInput('REC_PSA', 'PSA at BCR', placeholder = '0.2 - 20'),
                           textInput('PREOP_PSA', 'Preoperative PSA', placeholder = '0 - 100'),
                           selectInput('RP_GLSN_New', 'Pathological Gleason Score', choices = c('6', '3+4', '4+3', '8', '9')),
                           selectInput('ECE', 'Extraprostatic Extension', choices = c('Absent', 'Present')),
                           selectInput('MARGINS', 'Surgical Margins', choices = c('Positive', 'Negative')),
                           selectInput('SVI', 'Seminal Vesicle Invasion', choices = c('Absent', 'Present')),
                           selectInput('NUM_LN_POS_New', 'Lymph Nodes', choices = c('Positive', 'Negative'))),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
                  br(),
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] Brockman JA, Alanee S, Vickers AJ, Scardino PT, Wood DP, Kibel AS, Lin DW, Bianco FJ Jr, Rabah DM, Klein EA, Ciezki JP, Gao T, Kattan MW, Stephenson AJ. . ",a('Nomogram Predicting Prostate Cancer-specific Mortality for Men with Biochemical Recurrence After Radical Prostatectomy. ', href='http://www.sciencedirect.com/science/article/pii/S0302283814009567'),". Eur Urol. 2015 Jun;67(6):1160-7. doi: 10.1016/j.eururo.2014.09.019. Epub 2014 Oct 6.")),
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
   href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/ProstateMortalityWithBiochemicalRecurrenceAfterProstatectomy", 
   style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
 ),
                    style = "text-align: center;"),
                  img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;"))))