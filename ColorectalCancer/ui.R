
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

          titlePanel('Colorectal Cancer - 10 year Predicted Risk Online (CRC-PRO)'),
          sidebarLayout(
              sidebarPanel(id = "sidebar"
                           ,
                           selectInput('Gender', 'Gender', choices = c('Male', 'Female')),
                           textInput('Weight', 'Weight (lb)', placeholder = '75 - 350'),
                           textInput('Height', 'Height (inches)', placeholder = '60 - 80'),
                           textInput('AgeYr', 'Age (years)', placeholder = '45 - 85'),
                           selectInput('Ethnicity', 'Ethnicity', choices = c('Hawaiian', 'Japanese', 'Latino', 'White', 'Black')),
                           textInput('PackYears', 'Pack Years of Smoking (years)', placeholder = '0 - 50'),
                           textInput('Alcohol', 'Average Number of Alcoholic Drinks (drinks per day)', placeholder = '0 - 12'),
                           textInput('YearsEdu', 'Years of Education (years)', placeholder = '6 - 20'),
                           selectInput('FamilyCRC', 'Family History of Colon Cancer', choices = c('No', 'Yes')),
                           selectInput('Aspirin', 'Regular Use of Aspirin', choices = c('No', 'Yes - Not Currently', 'Yes')),
                           selectInput('Multivitamin', 'Regular Use of Multivitamins', choices = c('No', 'Yes')),
                           selectInput('Diabetes', 'History of Diabetes', choices = c('No', 'Yes')),
                           selectInput('PainMed', 'Regular Use of NSAIDs', choices = c('No', 'Yes, but not currently', 'Yes, currently')),
                           selectInput('Estrogen', 'Have you used Estrogen?', choices = c('No', 'Yes, but not currently', 'Yes-currently')),
                           textInput('Activity', 'Hours of Moderate Physical Activity per Day (hours per day)', placeholder = '0 - 4'),
                           textInput('TotalMeat', 'Ounces of Red Meat Intake per Day (ounces per day)', placeholder = '0 - 5')),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
                  br(),
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] Wells BJ, Kattan MW, Cooper GS, Jackson L, Koroukian S. ",a('ColoRectal Cancer Predicted Risk Online (CRC-PRO) calculator using data from the Multi-Ethnic Cohort Study', href='http://www.jabfm.org/content/27/1/42.full'),". J Am Board Fam Med. 2014 Jan-Feb;27(1):42-55. doi: 10.3122/jabfm.2014.01.130040")),
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