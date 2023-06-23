
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

          titlePanel('Prostate Cancer - Predicting Cancer Risk Following Initial Biopsy'),
          sidebarLayout(
              sidebarPanel(id = "sidebar",
                           selectInput('DRE', 'Abnormal DRE Results', choices = c('Normal', 'Abnormal')),
                           textInput('AgeYr', 'Age (years)', placeholder = '>=0'),
                           textInput('Cores', 'Cores To Be Removed', placeholder = '>=0'),
                           selectInput('Family_hx', 'Family History of Prostate Cancer?', choices = c('No', 'Yes')),
                           textInput('FPSA', 'Most Recent Percent Free PSA Value (%)', placeholder = '0 - 100'),
                           textInput('PSA', 'Most Recent PSA Level (ng/mL)', placeholder = '0.2 - 123'),
                           selectInput('Race', 'Race', choices = c('African American', 'Asian', 'Caucasian', 'Other')),
                           textInput('IPSS', 'Symptom Score', placeholder = '0 - 36'),
                           selectInput('TotalVolumeMissing', 'Is Total Prostate Volume (cc) missing?', choices = c('Yes', 'No')),
                           conditionalPanel(
                            condition = "input.TotalVolumeMissing == 'No'",
                            textInput('TotalVolume', 'Total Prostate Volume (if measured by MRI or Ultrasound) (cc)', placeholder = '>=0')
                            )
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
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] Nam RK, Toi A, Klotz LH, Trachtenberg J, Jewett MA, Appu S, Loblaw DA, Sugar L, Narod SA, Kattan MW. ",a('Assessing individual risk for prostate cancer', href='https://www.ncbi.nlm.nih.gov/pubmed/17704405'),". J Clin Oncol. 2007 Aug 20;25(24):3582-8")),
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