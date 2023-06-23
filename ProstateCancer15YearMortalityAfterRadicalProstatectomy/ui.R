require(shinythemes)
fluidPage(theme = shinytheme("flatly"),
    tags$script(HTML(
    'function myFunction() {
  var txt;
  if (confirm("This is a mailbox for reporting website errors to programmers for the risk calculator website.  If you have questions or concerns about a specific calculator, please use the calculator Author Contact Information found on the publication for that calculator.  Each calculator is documented by a specific publication with a corresponding author.")) {
    window.open("mailto:rcalcsupport@ccf.org");
  }
}'
  )),

          titlePanel('Prostate Cancer - 10- and 15-year Cancer Specific Mortality after Radical Prostatectomy'),
          sidebarLayout(
              sidebarPanel(id = "sidebar",
                           textInput('AGE', 'Age (years)', placeholder = '18 - 100'),
                           textInput('PSA', 'Prostate-Specific Antigen (PSA) (ng/mL)', placeholder = '>=0'),
                           selectInput('ECE', 'Extracapsular Extension', choices = c('No', 'Yes')),
                           selectInput('SMS', 'Positive Surgical Margin', choices = c('Negative', 'Positive')),
                           selectInput('SVI', 'Seminal Vesicle Invasion', choices = c('No', "Yes")),
                           selectInput('LNI', 'Lymph Node Metastases', choices = c('No', 'Yes')),
                           selectInput('G1', 'Primary Gleason Score', choices = c('1', '2', '3', '4', '5')),
                           selectInput('G2', 'Secondary Gleason Score', choices = c('1', '2', '3', '4', '5'))),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
                  br(),
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] Eggener, S., P. Scardino, P. Walsh, M. Han, A. Partin, B. Trock, Z. Feng, D. Wood, J. Eastham, O. Yossepowitch, D. Rabah, M. Kattan, C. Yu, E. Klein and A. Stephenson.",a(' Predicting 15-year prostate cancer specific mortality after radical prostatectomy.', href='http://www.sciencedirect.com/science/article/pii/S002253471004958X#'),"J Urol 185(3), March 2011: 869-875.")),
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