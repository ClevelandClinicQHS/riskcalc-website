library(stringr)
require(shinythemes)
fluidPage(theme = shinytheme("flatly"),
    tags$script(HTML(
    'function myFunction() {
  var txt;
  if (confirm("This is a mailbox for reporting website errors to programmers for the risk calculator website.  If you have questions or concerns about a specific calculator, please use the calculator Author Contact Information found on the publication for that calculator.  Each calculator is documented by a specific publication with a corresponding author.")) {
    window.open("mailto:rcalcsupport@ccf.org");
  }
}'
  )),

          titlePanel('Diabetes - Predicting 5-Year Morbidity and Mortality Risk'),
          sidebarLayout(
              sidebarPanel(id = "sidebar"
                           ,
                           textInput('Age', 'Age (Years)', placeholder = '40 - 85'),
                           selectInput('Gender', 'Gender', choices = c('Female', 'Male')),
                           selectInput('Ethnicity', 'Race', choices = c('White', 'Black', 'Other')),
                           textInput('Creatinine', 'Serum Creatinine (mg/dL)', placeholder = '0.1 - 4.5'),
                           textInput('LDL', 'Low density Lipoprotein (mg/dL)', placeholder = '60 - 500'),
                           textInput('HDL', 'High density Lipoprotein (mg/dL)', placeholder = '20 - 100'),
                           textInput('Triglycerides', 'Triglycerides (mg/dL)', placeholder = '50 - 500'),
                           textInput('Weight', 'Weight in pounds', placeholder = '75 - 500'),
                           textInput('Height', 'Height in inches', placeholder = '50 - 82'),
                           textInput('HbA1c', 'Hemoglobin A1c (%)', placeholder = '4.5 - 13'),
                           selectInput('CHF', 'History of Heart Failure?', choices = c('No', 'Yes')),
                           selectInput('Smoking_Status', 'Smoking Status', choices = c('No', 'Yes', 'Quit')),
                           textInput('BPSystolic', 'Systolic Blood Pressure (mmHg)', placeholder = '60 - 200'),
                           textInput('BPDiastolic', 'Diastolic Blood Pressure (mmHg)', placeholder = '40 - 140'),
                           selectInput('Insulin', 'Insulin', choices = c('No', 'Yes')),
                           selectInput('Plavix', 'Clopidogrel', choices = c('No', 'Yes')),
                           selectInput('Aspirin', 'Aspirin', choices = c('No', 'Yes')),
                           selectInput('Cholesterol_Med', 'Cholesterol Med', choices = c('No', 'Yes')),
                           selectInput('New_Diabetes', 'New Diabetic', choices = c('No', 'Yes')),
                           textInput('income', 'Household income (USD)', placeholder = '0 - 500000'),
                           selectInput('CAD', 'History of Heart Disease?', choices = c('No', 'Yes')),
                           selectInput('warfarin', 'Warfarin', choices = c('No', 'Yes')),
                           selectInput('ACEI_ARB', 'ACE Inhibitor or ARB', choices = c('No', 'Yes'))),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
                  br(),
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] Wells BJ, Roth R, Nowacki AS, Arrigain S, Yu C, Rosenkrans WA, Jr, Kattan MW. ",
                                              a('Prediction of morbidity and mortality in patients with type 2 diabetes.', 
                                                href='https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3685323/'),
                                              " PeerJ. 2013;1:e87.")),
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
                    style = "text-align: center;"),
                  img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;"))))