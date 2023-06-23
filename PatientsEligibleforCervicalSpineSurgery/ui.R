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

          titlePanel('Predicting Postoperative Clinical and Quality-of-life Outcomes after Cervical Spine Surgery'),
          sidebarLayout(
              sidebarPanel(id = "sidebar",
                           textInput('Age', 'Age', placeholder = '10 - 99'),
                           selectInput('Race', 'Race', choices = c('Non-Black', 'Black')),
                           textInput('BMI', 'Body Mass Index (kg/m^2)', placeholder = '15 - 70'),
                           textInput('ZIP', 'ZIP code', placeholder = '1001 - 99999'),
                           selectInput('Smoking', 'Smoking Status', choices = c('Never', 'Former/Current')),
                           selectInput('NeckPain', 'Neck Pain', choices = c('No', 'Yes')),
                           selectInput('UENumbness', 'Arm Numbness', choices = c('No', 'Yes')),
                           selectInput('UEWeakness', 'Arm Weakness', choices = c('No', 'Yes')),
                           selectInput('herniation', 'Disc herniation', choices = c('No', 'Yes')),
                           selectInput('myelopathy', 'Myelopathy', choices = c('No', 'Yes')),
                           selectInput('spondylosis', 'Spondylosis', choices = c('No', 'Yes')),
                           selectInput('Surgery', 'Surgery', choices = c('ACF', 'PCF', "Post Decomp")),
                           textInput('Levels', 'Levels', placeholder = '2 - 6'),
                           selectInput('TerminalLevel', 'Terminal Level ', choices = c('No', 'Yes')),
                           selectInput('DM', 'Diabetes', choices = c('No', 'Yes')),
                           selectInput('Cancer', 'History of Cancer', choices = c('No', 'Yes')),
                           textInput('BaseEQ5D', 'Preoperative EQ-5D', placeholder = '-0.1 - 1.0'),
                           textInput('BasePHQ9', 'Preoperative PHQ-9', placeholder = '0 - 27'),
                           textInput('BasePDQ', 'Preoperative PDQ', placeholder = '0 - 150')),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  DT::dataTableOutput('result'),
                  br(),
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("Daniel Lubelski, Vincent Alentado, Amy S Nowacki, Michael Shriver, Kalil G Abdullah, Michael P Steinmetz, Edward C Benzel, Thomas E Mroz, ",a('Preoperative Nomograms Predict Patient-Specific Cervical Spine Surgery Clinical and Quality of Life Outcomes', href='https://academic.oup.com/neurosurgery/article/83/1/104/3897685'),", Neurosurgery, Volume 83, Issue 1, July 2018, Pages 104–113, https://doi.org/10.1093/neuros/nyx343")),
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