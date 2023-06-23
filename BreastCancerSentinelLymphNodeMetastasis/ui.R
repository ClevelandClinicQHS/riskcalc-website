
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

          titlePanel('Predicting Sentinel Lymph Node Metastasis in Patients with Breat Cancer with or without Pre-Operative Information including ERPR Status'),
          sidebarLayout(
              sidebarPanel(id = "sidebar"
                           ,
                           textInput('AgeYr', 'Age (Years)', placeholder = '20 - 91'),
                           textInput('Pathsize', 'Pathological Size of Primary Tumor (cm)', placeholder = '0.1 - 11'),
                           selectInput('TLOC', 'Location of Primary Tumor', choices = c('UIQ', 'Other Quadrant(s)')),
                           selectInput('SpecType', 'Type of Tumor', choices = c('No', 'Yes')),
                           selectInput('Nuclob', 'Nuclear Grade of Primary Tumor', choices = c('1', '2', '3', 'Lobular')),
                           selectInput('LVInv', 'LVI of Primary Tumor', choices = c('No', 'Yes')),
                           selectInput('MultFoca', 'Multifocality of Primary Tumor', choices = c('No', 'Yes')),
                           selectInput('ERTest', 'Estrogen Receptor (ER) Status', choices = c('Negative', 'Positive', 'Unknown')),
                           selectInput('PRTest', 'Progesterone Receptor (PR) Status', choices = c('Negative', 'Positive', 'Unknown'))),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
                  br(),
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] Van Zee KJ, Manasseh DM, Bevilacqua JL, Boolbol SK, Fey JV, Tan LK, Borgen PI, Cody HS 3rd, Kattan MW. ",a('A nomogram for predicting the likelihood of additional nodal metastases in breast cancer patients with a positive sentinel node biopsy', href='http://journals.ohiolink.edu/ejc/article.cgi?issn=10689265&issue=v10i0010&article=1140_anfptlwapsnb'),". Ann Surg Oncol. 2003 Dec;10(10):1140-51")),
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