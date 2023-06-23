
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

          titlePanel('Urinary and Fecal Incontinence Nomogram with Planned Mode of Delivery Predictor'),
          sidebarLayout(
              sidebarPanel(id = "sidebar"
                           ,
                           selectInput('Race', 'Race', choices = c('Asian', 'Black', 'White', 'Unknown')),
                           selectInput('PrePregUI', 'Pre-pregnancy urinary incontinence', choices = c('Sometimes', 'Rarely', 'Never', 'Unknown')),
                           selectInput('AnteUI', 'Antepartum urinary incontinence', choices = c('Often', 'Sometimes', 'Rarely', 'Never', 'Unknown')),
                           textInput('PrePregBMI', 'Pre-pregnancy BMI (kg/m2)', placeholder = '>=0'),
                           textInput('PreDelivBMI', 'Pre-delivery BMI (kg/m2)', placeholder = '>=0'),
                           selectInput('PlannedDeliv', 'Planned Mode of Delivery', choices = c('Vaginal', 'Cesarean')),
                           textInput('AgeYr', 'Maternal Age (years)', placeholder = '>=0'),
                           selectInput('LabDeliv', 'Are labor and delivery variables available?', choices = c('No', 'Yes')),
                           textInput('LaborDuration', 'Duration of second stage of labor (hours)', placeholder = '>=0'),
                           selectInput('DeliveryType', 'Type of delivery', choices = c('Cesarean (other)', 'Vaginal (forceps)', 'Vaginal (spontaneous)', 'Vaginal (vacuum)', 'Cesarean (elective)', 'Unknown')),
                           selectInput('Episiotomy', 'Episiotomy', choices = c('Yes', 'No', 'Unknown')),
                           selectInput('PerinealLaceration', 'Perineal laceration degree', choices = c('No', '1st degree', '2nd degree', 'Partial 3rd degree', 'Complete 3rd degree', '3rd degree', '4th degree', 'Unknown')),
                           textInput('FetalBirthweight', 'Fetal birthweight (g)', placeholder = '>=0'),
                           textInput('FetalCircumference', 'Fetal head circumference (cm)', placeholder = '>=0'),
                           selectInput('FetalHeadPos', 'Fetal head position at crowning = OP', choices = c('Yes', 'No', 'Unknown'))),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
                  br(),
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] Jelovsek JE, Piccorelli A, Barber MD, Tunitsky-Bitton E, Kattan MW.. ",a('Prediction models for postpartum urinary and fecal incontinence in primiparous women', href='http://www.ncbi.nlm.nih.gov/pubmed/23442509'),". Female Pelvic Med Reconstr Surg. 2013 Mar-Apr;19(2):110-8. doi: 10.1097/SPV.0b013e31828508f0")),
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