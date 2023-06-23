require(shinythemes)
require(shinyjs)
require(dplyr)

fluidPage(theme = shinytheme("flatly"),
          useShinyjs(),
            tags$script(HTML(
    'function myFunction() {
  var txt;
  if (confirm("This is a mailbox for reporting website errors to programmers for the risk calculator website.  If you have questions or concerns about a specific calculator, please use the calculator Author Contact Information found on the publication for that calculator.  Each calculator is documented by a specific publication with a corresponding author.")) {
    window.open("mailto:rcalcsupport@ccf.org");
  }
}'
  )),
          
          titlePanel('BSS'),
          
          sidebarLayout(
              sidebarPanel(id = "sidebar",
                           textInput('Time.from.Hospital.Admission.to.ICU.Admission', "Time from Hospital Admission to ICU Admission (Days)", placeholder = '0 - 10'),
                           textInput('Weight..kg.', 'Weight (kg)', placeholder = '0 - 50'),
                           selectInput('Comorbid', 'Comorbid', choices = c("No", "Yes")),
                           selectInput('Young.Age', 'Young Age', choices = c("No", "Yes")),
                           selectInput('EarlyIntubation', 'Early Intubation', choices = c("No", "Yes")),
                           textInput('High.HR', 'High HR (Leave it empty if not measured)', placeholder = '50 - 300'),
                           textInput('Low.HR', 'Low HR (Leave it empty if not measured)', placeholder = '50 - 200'),
                           textInput('High.RR', 'High RR (Leave it empty if not measured)', placeholder = '10 - 100'),
                           textInput('High.T', 'High Temperature (Leave it empty if not measured)', placeholder = '35 - 42'),
                           textInput('Low.PH', 'Low pH (Leave it empty if not measured)', placeholder = '6.8 - 7.5'),
                           textInput('Highest.PCO2', 'Highest PCO2 (Leave it empty if not measured)', placeholder = '15 - 120')
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
                  # wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] José Luiz B. Bevilacqua, Michael W. Kattan, Yu Changhong, et al. ",a('Nomograms for Predicting the Risk of Arm Lymphedema after Axillary Dissection in Breast Cancer', href='https://link.springer.com/article/10.1245%2Fs10434-012-2290-x'),". Annals of Surgical Oncology, 2012, Volume 19, Number 8, Page 2580")),
                  wellPanel(h3('Disclaimer'),
                            p("No Medical Advice. ALTHOUGH SOME CONTENT MAY BE PROVIDED BY INDIVIDUALS IN THE MEDICAL PROFESSION, YOU ACKNOWLEDGE THAT PROVISION OF SUCH CONTENT DOES NOT CREATE A MEDICAL PROFESSIONAL-PATIENT RELATIONSHIP AND DOES NOT CONSTITUTE AN OPINION, MEDICAL ADVICE, PROFESSIONAL DIAGNOSIS, SERVICE OR TREATMENT OF ANY CONDITION. Access to general information is provided for educational purposes only, through this site and links to other sites. Content is not recommended or endorsed by any doctor or healthcare provider. The information and Content provided are not substitutes for medical or professional care, and you should not use the information in place of a visit, call, consultation or the advice of your physician or other healthcare provider. You are liable or responsible for any advice, course of treatment, diagnosis or any other information, services or product obtained through this site."))
                  # p(a("Homepage",
                  #     href = "../", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                  #     font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"), 
                  #   " | ",
                  #   a("Website Error Messages",
                  #     href = "javascript:myFunction()",
 
                  #     style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                  #     font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"), 
                  #   style = "text-align: center;"),
                  # img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;")
                 )
          )
)
