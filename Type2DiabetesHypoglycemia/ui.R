
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

          titlePanel('Type 2 Diabetes - Predicting 3-month Severe Hypoglycemia Risk'),
          # conditionalPanel(
          #     condition = "output.T2D",
          #     selectInput("keto", "Ketoacidosis: ICD9 250.10 or 250.12 anytime/anywhere?", c("No", "Yes"))
          # ),
          fluidRow(
              column(4, 
                     wellPanel(
                         selectInput('MildHypo.Code', 'History of Non-Severe Hypoglycemia in prior 3 months', choices = c('No', 'Yes')),
                         textInput('n', 'Months since first Non-Severe Hypoglycemia', placeholder = '>=0'),
                         textInput('Age', 'Age (Years)', placeholder = '18 - 80'),
                         selectInput('Race', 'Race', choices = c('White', 'Black', 'Other')),
                         textInput('BMI', 'Body Mass Index', placeholder = '15 - 60'),
                         textInput('HbA1c', 'Most Recent Hemoglobin A1c(%)', placeholder = '0 - 20')
                     ),
                     wellPanel(
                         selectizeInput('Medication', label = c("Diabetes medications"), 
                                        choices = c("Insulin", "Sulfonylurea", "Metformin", "DPP4", 'Other'), multiple = TRUE,
                                        options = list(placeholder = "Select All That Apply", onInitialize = I('function() { this.setValue(""); }')))
                         # actionButton("add_med", "Add new medication history"),
                         # tags$div(id = 'placeholder_med')
                     ),
                     wellPanel(
                         selectizeInput('Comorbidity', label = c("Comorbidity"), 
                                        choices = c("Cardiovascular Disorder", "Heart Failure", "CKD", "Depression", "Cognitive Disorders", "Dementia", "Alcohol abuse", "Other Psychiatric"), multiple = TRUE,
                                        options = list(placeholder = "Select All That Apply", onInitialize = I('function() { this.setValue(""); }')))
                         # actionButton("add_comorbidity", "Add new comorditiy history"),
                         # tags$div(id = 'placeholder_comorbidity')
                     )
              ),
          column(8,
                 actionButton("goButton", "Run Calculator"),
                 br(),
                 hr(),
                 tags$head(
                     tags$style(type="text/css", "tfoot {display:none;}")
                 ),
                 dataTableOutput('result'),
                 br(),
                 # wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] Wells BJ, Jain A, Arrigain S, Yu C, Rosenkrans WA Jr, Kattan MW. ",a('Predicting 6-year mortality risk in patients with type 2 diabetes', href='http://care.diabetesjournals.org/content/31/12/2301.full.pdf'),". Diabetes Care. 2008 Dec;31(12):2301-6. doi: 10.2337/dc08-1047. Epub 2008 Sep 22")),
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