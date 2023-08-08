
require(shinythemes)
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

          titlePanel('Renal Cancer - Pre-Operative Prediction of Cancer, Aggressive Cancer, and Freedom from Metastases'),
          sidebarLayout(
              sidebarPanel(id = "sidebar"
                           ,
                           textInput('AgeYr', 'Age (years)', placeholder = '19 - 92'),
                           textInput('CTSize', 'CT Scan Tumor Size (cm)', placeholder = '0.5 - 7'),
                           selectInput('EvidenceNecrosisByImaging', 'Evidence of Necrosis (by imaging)', choices = c('No', 'Yes')),
                           selectInput('Gender', 'Gender', choices = c('Female', 'Male')),
                           selectInput('SmokeHist', 'History of Smoking?', choices = c('No', 'Yes')),
                           selectInput('LymphadenopathyByImaging', 'Lymphadenopathy (by imaging)', choices = c('No', 'Yes')),
                           selectInput('SymptomaticAtDiagnosis', 'Symptoms at Diagnosis', choices = c('No Symptoms', 'Local Symptoms', 'Systemic Symptoms'))),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
                  br(),
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),
                            p("[1] Lane BR1, Babineau D, Kattan MW, Novick AC, Gill IS, Zhou M, Weight CJ, Campbell SC. ",a('A preoperative prognostic nomogram for solid enhancing renal tumors 7 cm or less amenable to partial nephrectomy', href='http://www.ncbi.nlm.nih.gov/pubmed/17561141'),". J Urol. 2007 Aug;178(2):429-34. Epub 2007 Jun 11"),
                            p("[2] Raj GV1, Thompson RH, Leibovich BC, Blute ML, Russo P, Kattan MW. ",a('Preoperative nomogram predicting 12-year probability of metastatic renal cancer', href='http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3985125'),". J Urol. 2008 Jun;179(6):2146-51; discussion 2151. doi: 10.1016/j.juro.2008.01.101. Epub 2008 Apr 18")),
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
   href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/SuspectedKidneyCancer", 
   style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
 ),
                    style = "text-align: center;"),          
                  img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;"))))