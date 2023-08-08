
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

          titlePanel('Pancreatic Cancer Survival After Resection for Adenocarcinoma'),
          sidebarLayout(
              sidebarPanel(id = "sidebar"
                           ,
                           textInput('SurgAge', 'Age (years)', placeholder = '33 - 89'),
                           selectInput('BackPain', 'Back Pain?', choices = c('Yes', 'No')),
                           selectInput('Gender', 'Gender', choices = c('Male', 'Female')),
                           selectInput('MarginResec', 'Margin of Resection', choices = c('Negative', 'Positive')),
                           textInput('MaxPathAxis', 'Maximum Path Axis (mm)', placeholder = '0.1 - 16'),
                           textInput('NumNegNodes', 'Number of Negative Lymph Nodes', placeholder = '0 - 83'),
                           textInput('NumPosNodes', 'Number of Positive Lymph Nodes', placeholder = '0 - 39'),
                           selectInput('PortVein', 'Portal Vein Resected?', choices = c('No', 'Yes')),
                           selectInput('PostMargin', 'Posterior Margin', choices = c('Negative', 'Positive')),
                           selectInput('Head', 'Resection Location', choices = c('Head', 'Other')),
                           selectInput('Splenectomy', 'Splenectomy?', choices = c('No', 'Yes')),
                           selectInput('Diff', 'Tumor Differentiation', choices = c('Poor', 'Moderate', 'Well')),
                           selectInput('TStage', 'Tumor Stage', choices = c('1', '2', '3', '4')),
                           selectInput('WeightLoss', 'Weight Loss?', choices = c('Yes', 'No'))),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
                  br(),
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] Brennan MF, Kattan MW, Klimstra D, Conlon K. ",a('Prognostic nomogram for patients undergoing resection for adenocarcinoma of the pancreas', href='http://www.ncbi.nlm.nih.gov/pmc/articles/PMC1356406/pdf/20040800s00015p293.pdf'),". Ann Surg. 2004 Aug;240(2):293-8")),
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
   href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/PancreaticCancer1YrSurvivalAfterResectionforAdenocarcinoma", 
   style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
 ),
                    style = "text-align: center;"),
                  img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;"))))