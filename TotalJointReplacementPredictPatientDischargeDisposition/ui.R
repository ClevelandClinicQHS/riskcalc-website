
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

          titlePanel('Predicting Patient Discharge Disposition'),
          sidebarLayout(
              sidebarPanel(id = "sidebar"
                           ,
                           textInput('AgeYr', 'Age (years)', placeholder = '10 - 100'),
                           selectInput('Gender', 'Gender', choices = c('Male', 'Female')),
                           selectInput('Procedure', 'Type of Procedure', choices = c('Primary Total Hip Replacement', 'Primary Total Knee Replacement', 'Revision Total Hip Replacement', 'Revision Total Knee Replacement', 'Bilateral Total Knee Replacement')),
                           textInput('BMI', 'Body Mass Index (kg/m2)', placeholder = '15 - 55'),
                           selectInput('HeartDisease', 'History of Heart Disease', choices = c('No', 'Yes, active monitoring', 'Yes, no active monitoring')),
                           selectInput('Arthritis', 'History of Arthritis', choices = c('No', 'Yes')),
                           selectInput('COPD', 'History of Chronic Obstructive Pulmonary Disease', choices = c('No', 'Yes')),
                           selectInput('Diabetes', 'History of Diabetes', choices = c('No', 'Yes')),
                           selectInput('Hypertension', 'History of Hypertension', choices = c('No', 'Yes')),
                           selectInput('Infection', 'Infection-Caused Joint Revision?', choices = c('No', 'Yes')),
                           selectInput('PreOpAm', 'Pre-Operative Ambulatory Status', choices = c('Independent Community Distances', 'Impaired Community Distances', 'Impaired Home Distances', 'Minimal Ambulation or Wheelchair Bound')),
                           textInput('NumSteps', 'Number of Entry Steps', placeholder = '0 - 30'),
                           selectInput('BedLoc', 'Bedroom Location', choices = c('1st floor', '2nd floor')),
                           selectInput('BathLoc', 'Bathroom Location', choices = c('1st floor', '2nd floor')),
                           selectInput('Caregiver', 'Caregiver Assistance', choices = c('Consistent/Live in (5-7 d/wk)', 'Occasionally available (2-4 d/wk)', 'Inconsistent or None')),
                           selectInput('HomeLoc', 'Home Location', choices = c('Up to 150 miles', 'More than 150 miles'))),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
                  br(),
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] Barsoum WK, Murray TG, Klika AK, Green K, Miniaci SL, Wells BJ, Kattan MW. ",a('Predicting patient discharge disposition after total joint arthroplasty in the United States', href='http://www.sciencedirect.com/science/article/pii/S0883540309002563'),". J Arthroplasty. 2010 Sep;25(6):885-92. doi: 10.1016/j.arth.2009.06.022. Epub 2009 Sep 2")),
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
   href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/TotalJointReplacementPredictPatientDischargeDisposition", 
   style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
 ),
                    style = "text-align: center;"),
                  img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;"))))