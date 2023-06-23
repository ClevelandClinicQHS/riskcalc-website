
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

          titlePanel('Predicting 30-Day All-Cause Mortality After Transvenous Pacemaker and Defibrillator Lead Extraction'),
          sidebarLayout(
              sidebarPanel(id = "sidebar",
                           textInput('AgeYr', 'Age (years)', placeholder = '20 - 90'),
                           textInput('BMI', 'BMI', placeholder = "15 - 50"),
                           textInput('Hemoglobin', 'Hemoglobin (g/dL)', placeholder = "1 - 16"),
                           selectInput('ESRD', 'ESRD', choices = c('No', "Yes")),
                           textInput('EF', 'Ejection Fraction (%)', placeholder = "10 - 70"),
                           selectInput('NYHA', 'NYHA Functional Class', choices = c('I or II', "III or IV")),
                           selectInput('Lead', 'Lead Extraction for Infection', choices = c('No', "Yes")),
                           selectInput('DCICD', 'Dual-coil ICD Lead Extracted', choices = c('No', "Yes")),
                           textInput('PriorProcedure', 'Prior Lead Extraction Procedures Performed by Operator', placeholder = '0 - 1000')),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
                  br(),
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] Michael P. Brunner, MD, Changhong Yu, MS, Ayman A. Hussein, MD, Khaldoun G. Tarakji, MD, MPH, Oussama M. Wazni, MD, Michael W. Kattan, PhD, Bruce L.Wilkoff, MD. ",a('Nomogram for Predicting 30-Day All-Cause Mortality After Transvenous Pacemaker and Defibrillator Lead Extraction', href='http://www.ncbi.nlm.nih.gov/pubmed/26190318'),". j.hrthm.2015.07.024. Epub 2015 Jul 17.")),
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