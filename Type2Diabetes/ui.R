
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

          titlePanel('Diabetes - Predicting 6-Year Mortality Risk'),
          sidebarLayout(
              sidebarPanel(id = "sidebar"
                           ,
                           textInput('Age', 'Age (Years)', placeholder = '>=0'),
                           selectInput('Gender', 'Gender', choices = c('Female', 'Male')),
                           selectInput('Race', 'Race', choices = c('Caucasian', 'African-American', 'Asian', 'Others')),
                           textInput('Creatinine', 'Serum Creatinine (mg/dL)', placeholder = '0.1 - 5.0'),
                           selectInput('BaseTLCBypassCAD', 'History of Coronary Heart Disease?', choices = c('No', 'Yes')),
                           textInput('BaseHba1c', 'Hemoglobin A1c (%)', placeholder = '5 - 15'),
                           textInput('Base_BMI', 'Body Mass Index', placeholder = '15 - 60'),
                           selectInput('BaseHeartFailure', 'History of Congestive Heart Failure?', choices = c('No', 'Yes')),
                           textInput('BaseBPSystolic', 'Systolic Blood Pressure (mmHg)', placeholder = '60 - 200'),
                           textInput('BaseBPDiastolic', 'Diastolic Blood Pressure (mmHg)', placeholder = '50 - 120'),
                           textInput('BaseHDL', 'High density Lipoprotein (mg/dL)', placeholder = '5 - 100'),
                           textInput('BaseLDL', 'Low density Lipoprotein (mg/dL)', placeholder = '50 - 450'),
                           textInput('BaseTriglycerides', 'Triglycerides (mg/dL)', placeholder = '50 - 500'),
                           selectInput('BaseSmoke', 'Smoking Status', choices = c('No', 'Yes', 'Quit')),
                           selectInput('Medication', 'Medication Type', choices = c('Biguanide', 'Meglitinide', 'Thiazolidinedion', 'Sulfonylurea', 'Compare all of the Medications')),
                           selectInput('BaseInsulin', 'Insulin?', choices = c('No', 'Yes')),
                           selectInput('BaseACEInhibOrARB', 'ACE Inhibitor or ARB?', choices = c('No', 'Yes')),
                           selectInput('new_diabetes', 'New Diabetic?', choices = c('No', 'Yes')),
                           selectInput('BasePlavix', 'Clopidogrel?', choices = c('No', 'Yes')),
                           selectInput('BaseAspirin', 'Aspirin?', choices = c('No', 'Yes')),
                           selectInput('BaseCholLowervsLipid', 'Lipid Drug?', choices = c('No', 'Yes - After Lipid Panel', "Yes - Before Lipid Panel"))),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
                  br(),
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] Wells BJ, Jain A, Arrigain S, Yu C, Rosenkrans WA Jr, Kattan MW. ",a('Predicting 6-year mortality risk in patients with type 2 diabetes', href='http://care.diabetesjournals.org/content/31/12/2301.full.pdf'),". Diabetes Care. 2008 Dec;31(12):2301-6. doi: 10.2337/dc08-1047. Epub 2008 Sep 22")),
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