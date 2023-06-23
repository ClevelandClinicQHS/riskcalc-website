
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

          titlePanel('Predicting Graft Survival at 5-Years in Kidney Transplant Patients Using Pre-Transplant and 6-Month Info'),
          sidebarLayout(
              sidebarPanel(id = "sidebar"
                           ,
                           textInput('AgeYr', 'Recipient Age (Years)', placeholder = '30 - 90'),
                           selectInput('Gender', 'Recipient Gender', choices = c('Male', 'Female')),
                           selectInput('RaceCat', 'Recipient Race', choices = c('Caucasian', 'African-American', 'Other')),
                           textInput('BMI', 'Recipient BMI (kg/m2)', placeholder = '15 - 50'),
                           textInput('DonAge', 'Donor Age (Years)', placeholder = '30 - 60'),
                           selectInput('DonGender', 'Donor Gender', choices = c('Male', 'Female')),
                           selectInput('DonRaceCat', 'Donor Race', choices = c('Caucasian', 'African-American', 'Other')),
                           textInput('DonBMI', 'Donor BMI (kg/m2)', placeholder = '20 - 40'),
                           textInput('DonCreat', 'Donor Creatinine (mg/dL)', placeholder = '0.1 - 2'),
                           selectInput('DonProcec', 'Nephrectomy Type', choices = c('Open', 'Laparoscopic')),
                           textInput('HLAMis', 'HLA Mismatch', placeholder = '0 - 6'),
                           selectInput('Diaggrpc', 'Cause of Renal failure', choices = c('Glomerulonephritis', 'Other', 'Retransplant', 'Diabetes')),
                           selectInput('IMDeple', 'Depleting Antibodies Used?', choices = c('No', 'Yes')),
                           selectInput('IMIL2', 'IL2 Receptor Antibodies Used?', choices = c('No', 'Yes')),
                           selectInput('IMAza', 'Azathioprine Used?', choices = c('No', 'Yes')),
                           selectInput('IMMyco', 'Mycohphenolate Mofetil Used?', choices = c('No', 'Yes')),
                           selectInput('IMRapa', 'Rapamycin (Sirolimus) Used?', choices = c('No', 'Yes')),
                           selectInput('IMCalci', 'Calcineurin Inhibitor Used?', choices = c('No', 'Yes')),
                           selectInput('Dial1wk', 'Dialysis 1st Week Post-Tx', choices = c('No', 'Yes')),
                           selectInput('TrtRej6', 'Any Treated Rejection at 6 Months?', choices = c('No', 'Yes')),
                           textInput('GFRPo6', 'eGFR at 6 Months? (mL/min per 1.73m)', placeholder = '1.5 - 551')),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
                  br(),
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] Tiong HY, Goldfarb DA, Kattan MW, Alster JM, Thuita L, Yu C, Wee A, Poggio ED. ",a('Nomograms for predicting graft function and survival in living donor kidney transplantation based on the UNOS Registry', href='http://www.sciencedirect.com/science/article/pii/S0022534708030127'),". J Urol. 2009 Mar;181(3):1248-55. doi: 10.1016/j.juro.2008.10.164. Epub 2009 Jan 23")),
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