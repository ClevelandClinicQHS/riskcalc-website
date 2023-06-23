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
          
          titlePanel('Predicting Postoperative Clinical and Quality-of-life Outcomes after Lumbar Spine Surgery'),
          sidebarLayout(
              sidebarPanel(id = "sidebar",
                           textInput('Age', 'Age in years', placeholder = '10 - 99'),
                           selectInput('Race', 'Race', choices = c('Caucasian', 'Non-Caucasian')),
                           selectInput('Married', 'Married', choices = c('No', 'Yes')),
                           textInput('BMI', 'Body Mass Index (kg/m^2)', placeholder = '15 - 70'),
                           textInput('CCI', 'Charlson Comorbidity Index', placeholder = '0 - 30'),
                           textInput('Symptom.Duration', 'Symptom Duration in months', placeholder = '0 - 200'),
                           selectInput('Foraminal.Stenosis', 'Foraminal Stenosis ', choices = c('No', 'Yes')),
                           selectInput('Spinal.Stenosis', 'Spinal Stenosis', choices = c('No', 'Yes')),
                           selectInput('Herniation', 'Disc herniation', choices = c('No', 'Yes')),
                           selectInput('Spondylosis', 'Spondylolisthesis', choices = c('No', 'Yes')),
                           selectInput('Radiculopathy', 'Radiculopathy', choices = c('No', 'Yes')),
                           selectInput('ALIF', 'ALIF', choices = c('No', 'Yes')),
                           selectInput('PLIF.TLIF', 'PLIF/TLIF', choices = c('No', 'Yes')),
                           selectInput('Posterolateral', 'Posterolateral Fusion', choices = c('No', 'Yes')),
                           selectInput('Decompression', 'Decompression', choices = c('No', 'Yes')),
                           textInput('Levels', 'Number of Levels', placeholder = '1 - 14'),
                           textInput('BaseEQ5D', 'Preoperative EQ-5D (optional)', placeholder = '-0.1 - 1.0'),
                           textInput('BasePDQ', 'Preoperative PDQ (optional)', placeholder = '0 - 150')
                           ),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  DT::dataTableOutput('result'),
                  br(),
                  #wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("Daniel Lubelski, Vincent Alentado, Amy S Nowacki, Michael Shriver, Kalil G Abdullah, Michael P Steinmetz, Edward C Benzel, Thomas E Mroz, ",a('Preoperative Nomograms Predict Patient-Specific Cervical Spine Surgery Clinical and Quality of Life Outcomes', href='https://academic.oup.com/neurosurgery/article/83/1/104/3897685'),", Neurosurgery, Volume 83, Issue 1, July 2018, Pages 104–113, https://doi.org/10.1093/neuros/nyx343")),
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