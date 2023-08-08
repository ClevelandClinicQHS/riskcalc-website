
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

          titlePanel('Prostate Cancer - Predicting Post-Treatment Freedom from Recurrence and Cancer Specific Mortality'),
          sidebarLayout(
              sidebarPanel(id = "sidebar"
                           ,
                           textInput('AGE', 'Age (years)', placeholder = '18 - 100'),
                           selectInput('adjrt', 'Received Adjuvant Radiotherapy?', choices = c('No', 'Yes')),
                           selectInput('ecelev', 'Capsular Invasion Type', choices = c('None', 'Inv.Capsule', 'Focal', 'Established')),
                           selectInput('stagecha', 'Clinical Stage', choices = c('T1c', 'T2a', 'T2b', 'T2c', 'T3')),
                           selectInput('ece', 'Extracapsular Extension', choices = c('No', 'Yes')),
                           selectInput('lni', 'Lymph Node Status', choices = c('Negative', 'Positive')),
                           textInput('psa', 'Pre-Treatment PSA Level (ng/mL)', placeholder = '0 - 100'),
                           selectInput('g1', 'Primary Gleason Grade (post-op)', choices = c('1', '2', '3', '4', '5')),
                           selectInput('g2', 'Secondary Gleason Grade (post-op)', choices = c('1', '2', '3', '4', '5')),
                           selectInput('svi', 'Seminal Vesicle Invasion?', choices = c('No', 'Yes')),
                           selectInput('sm', 'Surgical Margins Status', choices = c('Negative', 'Positive'))),
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
                            p("[1] Kattan MW, Wheeler TM, Scardino PT. ",a('Postoperative nomogram for disease recurrence after radical prostatectomy for prostate cancer', href='http://jco.ascopubs.org/content/17/5/1499.full.pdf'),". J Clin Oncol. 1999 May;17(5):1499-507"),
                            p("[2] Stephenson AJ, Scardino PT, Eastham JA, Bianco FJ Jr, Dotan ZA, DiBlasio CJ, Reuther A, Klein EA, Kattan MW. ",a('Postoperative nomogram predicting the 10-year probability of prostate cancer recurrence after radical prostatectomy', href='http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2231088/pdf/nihms27199.pdf'),". J Clin Oncol. 2005 Oct 1;23(28):7005-12"),
                            p("[3] Eggener, S., P. Scardino, P. Walsh, M. Han, A. Partin, B. Trock, Z. Feng, D. Wood, J. Eastham, O. Yossepowitch, D. Rabah, M. Kattan, C. Yu, E. Klein and A. Stephenson.",a(' Predicting 15-year prostate cancer specific mortality after radical prostatectomy.', href='http://www.sciencedirect.com/science/article/pii/S002253471004958X#'),"J Urol 185(3), March 2011: 869-875.")),
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
   href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/ProstateCancerPredictingPostRadicalProstatectomy", 
   style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
 ),
                    style = "text-align: center;"),
                  img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;"))))