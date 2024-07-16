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

          titlePanel('CT Calculator'),
          sidebarLayout(
              sidebarPanel(id = "sidebar"
                           ,
                           
                             selectInput('ct_contrast', 'Contrast Scan', choices = c('No', 'Yes'))
                            , textInput('L1BMDmultiHU', 'L1 BMD multi HU', placeholder = '-50 to 1200')
                            , textInput('L1BMDsingleHU', 'L1 BMD single HU', placeholder = '-50 to 1200')
                            , textInput('AbdominalAgatston', 'Abdominal Agaston', placeholder = '0 to 30000')
                            , textInput('L3SATArea', 'L3SAT Area', placeholder = '0.1 to 1000')
                            , textInput('L3TATArea', 'L3TAT Area', placeholder = '0.1 to 1500')
                            , textInput('L3VATMedianHU', 'L3VAT Median HU', placeholder = '-120 to -30')
                            , textInput('L3VATSATRatio', 'L3VATSAT Ratio', placeholder = '-1 to 4.5')
                            , textInput('KidneyVolume', 'Kidney Volume', placeholder = '0 to 1600')
                            , textInput('L3MuscleArea', 'L3 Muscle Area', placeholder = '25 to 500')
                            , textInput('L3MuscleMeanHU', 'L3 Muscle Mean HU', placeholder = '-50 to 200')
                            , textInput('SpleenVolume', 'Spleen Volume', placeholder = '0 to 6000')
                           
                           #model1
                            , textInput('age', 'Age (years)', placeholder = '40 to 100')
                            , selectInput('Sex', 'Sex, M = Male, F = Female', choices = c('M', 'F')) 
                            , selectInput('RACE', 'Race', choices = c('AmIndian', 'Asian', 'Black', 'Hawaiian', 'White'))
                            , selectInput('Tobacco', 'Smoking History', choices = c('Never', 'Passive', 'Quit', 'Yes'))
                            # 
                  
                           ),
              
              
              mainPanel(
                  actionButton("goButton", "Calculate CT Age"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
                  br(),
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] Pickhardt PJ, Garrett JW, and Kattan MW. ",a(' A Calculator to Estimate CT-Adjusted Age', href='http://www.google'),". @add paper citation information and also doi")),
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
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;")," | ",
 a("Source Code", 
   href = "https://github.com/ClevelandClinicQHS/", 
   style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
 ),
                    style = "text-align: center;"),
                  img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;"))))