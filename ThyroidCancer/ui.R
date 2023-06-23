require(shinyjs)
require(shinythemes)
fluidPage(theme = shinytheme("flatly"),
          tags$head(tags$link(rel="shortcut icon", href="../assets/icons/favicon.ico", type="image/x-icon")),
          tags$head(tags$link(rel="apple-touch-icon", href="../assets/icons/apple-touch-icon.png", type="image/x-icon")),
          useShinyjs(),
            tags$script(HTML(
    'function myFunction() {
  var txt;
  if (confirm("This is a mailbox for reporting website errors to programmers for the risk calculator website.  If you have questions or concerns about a specific calculator, please use the calculator Author Contact Information found on the publication for that calculator.  Each calculator is documented by a specific publication with a corresponding author.")) {
    window.open("mailto:rcalcsupport@ccf.org");
  }
}'
  )),

          titlePanel('Predict Risk of Malignant Thyroid Nodules Based on Clinical, Biochemical, Ultrasound with or without Cytologic Features'),
          sidebarLayout(
              sidebarPanel(id = "sidebar",
                           selectInput('FNA', 'Did you undergo a fine needle aspiration (FNA)?', choices = c('No', 'Yes')),
                           selectInput('Shape', 'Shape', choices = c('Taller Than Wide', 'Variable', 'Oval')),
                           selectInput('Vascularity', 'Vascularity', choices = c('MIXED', 'HYPOVASCULAR', 'NONE', 'PERINODULAR', 'HYPERVASCULAR')),
                           textInput('TSHLevel', 'Thyroid stimulating hormone (TSH) levels (mIU/L)', placeholder = '>=0'),
                           selectInput('EchoTexture', 'Echo texture', choices = c('Isoechoic', 'Hypochoic', 'Mixed Cystic/Solid')),
                           div(id = "fnaN",
                               textInput('AgeYr', 'Patient age (years)', placeholder = '10 - 90'),
                               selectInput('Margin', 'Margin', choices = c('Not well-defined', 'Well-defined')),
                               textInput('TumorSize', 'Tumor Size (cm)', placeholder = ">=0"),
                               selectInput('Calcification', 'Calcification', choices = c('Coarse', 'None', 'Microscopic'))
                           ),
                           shinyjs::hidden(
                               div(id = "fnaY",
                                   selectInput('Calcification', 'Calcification', choices = c('Coarse', 'None', 'Microscopic')),
                                   selectInput('Grooves', 'Grooves present?', choices = c('No', 'Yes')),
                                   selectInput('Pseudoinclusions', 'Pseudoinclusions present?', choices = c('No', 'Yes')),
                                   selectInput('Cellularity', 'Cellularity', choices = c('HYPOCELLULAR', 'MODERATELY CELLULAR', 'HYPERCELLULAR')),
                                   selectInput('Colloid', 'Colloid scant or abundant?', choices = c('Abundant', 'Scant')))
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
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] Nixon IJ, Ganly I, Hann LE, Lin O, Yu C, Brandt S, Shah JP, Shaha A, Kattan MW, Patel SG. ",a('Nomogram for predicting malignancy in thyroid nodules using clinical, biochemical, ultrasonographic, and cytologic features', href='http://www.sciencedirect.com/science/article/pii/S0039606010005222'),". Surgery. 2010 Dec;148(6):1120-7; discussion 1127-8. doi: 10.1016/j.surg.2010.09.030")),
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
                  img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;")))
          )