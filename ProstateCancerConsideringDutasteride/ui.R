
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

          titlePanel('Patients at High Risk for Prostate Cancer - with a Prior Negative 6- to 12-Core Biopsy in the Past 6 Months'),
          sidebarLayout(
              sidebarPanel(id = "sidebar",
                           textInput('AGE', 'Age (years)', placeholder = '50 - 75'),
                           selectInput('SBSRL', 'Are you sexually active?', choices = c('No', 'Yes', 'Unknown')),
                           selectInput('IMP', 'Do you have a history of impotence?', choices = c('No', 'Yes', 'Unknown')),
                           selectInput('LIB', 'Do you have a history of libido problems?', choices = c('No', 'Yes', 'Unknown')),
                           selectInput('HIS_PCA', 'Do you have family history of prostate cancer', choices = c('No', 'Yes', 'Unknown')),
                           textInput('B_OPSA', 'Prostate Specific Antigen (PSA)', placeholder = '2 - 10'),
                           selectInput('B_DRE', 'What is the DRE result?', choices = c('Normal', 'Abnormal', 'Unknown')),
                           textInput('B_OPFPS', '[optional] % free PSA', placeholder = '2 - 64'),
                           textInput('B_BMI', '[optional] BMI (kg/m2)', placeholder = '15 - 50'),
                           textInput('B_IPSS', '[optional] IPSS score', placeholder = '0 - 25'),
                           textInput('B_QM', '[optional] Maximum urinary flow rate (Qmax, ml/s)', placeholder = '0 - 50'),
                           textInput('B_NOCOR', '[optional] Number of biopsy cores', placeholder = '6 - 12'),
                           textInput('B_PV', '[optional] Prostate volume (cm3)', placeholder = '15 - 75'),
                           textInput('B_RSD', '[optional] Residual urine volume (cm3)', placeholder = '0 - 150')
                           ),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
                  h4(textOutput('note')),
                  br(),
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),
                            p("[1] Andriole GL, Bostwick DG, Brawley OW, Gomella LG, Marberger M, Montorsi F, Pettaway CA, Tammela TL, Teloken C, Tindall DJ, Somerville MC, Wilson TH, Fowler IL, Rittmaster RS; REDUCE Study Group.. ",a('Effect of dutasteride on the risk of prostate cancer.', href='http://www.nejm.org/doi/pdf/10.1056/NEJMoa0908127'),". N Engl J Med. 2010 Apr 1;362(13):1192-202. doi: 10.1056/NEJMoa0908127."),
                            p("[2] Carvell T. Nguyen, Brandon Isariyawongse, Changhong Yu and Michael W. Kattan. ",a('The REDUCE metagram: a comprehensive prediction tool for determining the utility of dutasteride chemoprevention in men at risk for prostate cancer', href='http://journal.frontiersin.org/article/10.3389/fonc.2012.00138/abstract'),". Front. Oncol., 11 October 2012 | http://dx.doi.org/10.3389/fonc.2012.00138")),
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
                    style = "text-align: center;"),
                  img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;"))))