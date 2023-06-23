library(shiny)
library(shinyBS)
library(shinyjs)
library(shinythemes)

fluidPage(
  shinyjs::useShinyjs(), 
  theme = shinytheme("flatly"),
          tags$head(
            tags$style(HTML("hr {border-top: 1px solid #000000;}"))
          ),
    tags$script(HTML(
    'function myFunction() {
  var txt;
  if (confirm("This is a mailbox for reporting website errors to programmers for the risk calculator website.  If you have questions or concerns about a specific calculator, please use the calculator Author Contact Information found on the publication for that calculator.  Each calculator is documented by a specific publication with a corresponding author.")) {
    window.open("mailto:rcalcsupport@ccf.org");
  }
}'
  )),

          titlePanel('Predict recommend probability'),
          sidebarLayout(
              sidebarPanel(id = "sidebar",
                           selectInput('ClientID', 'Location', choices = c("CC", "Akron", "Ashtabula", "Avon", "Euclid", "Fairview", "Hillcrest", "Lakewood", "Lodi", "Lutheran", "Marymount", "Medina", "South Pointe", "Weston")),
                           numericInput('Age', 'Age', value = 18, min = 0, max = 90),
                           bsTooltip("Age", "Range: 0 - 90", "right", options = list(container = "body")),
                           selectInput("Gender", "Gender", choices = c("Female", "Male")),
                           selectInput("Race", "Race", choices = c("Asians", "Black race", "Caucasian", "Other")),
                           selectInput("Ethnicity", "Ethnicity", choices = c("Hispanic Americans", "Not Hispanic or Latino", "Unknown")),
                           selectInput("MaritalStatus", "MaritalStatus", choices = c("Currently Married", "Divorced state", "domestic partner", "Other", "Unmarried person", "Widow")),
                           selectInput("Language", "Language", choices = c("English", "Spanish", "Other")),
                           selectInput("Education", "Education", choices = c("8th grade or less", "Some high school", "High school grad", "Some college", "4-yr coll. grad.", "4+ yrs college", "Other")),
                           selectInput("Religion", "Religion", choices = c("BAPTIST", "CATHOLIC", "CHRISTIAN", "JEWISH", "LUTHERAN", "METHODIST", "PROTESTANT", "NONE", "Other")),
                           numericInput("MedianIncome", "Household Income (per $1000)", value = 50, min = 0, max = 250),
                           bsTooltip("MedianIncome", "Range: 0 - 250", "right", options = list(container = "body")),
                           selectInput("AdmissionType", "Admission Type", choices = c("Elective", "Emergency Admission", "General Outpatient", "Hospital Admission, urgent, 48hr", "Inpatient", "Other")),
                           selectInput("OverallHealth", "Overall Health", choices = c("Excellent", "Very Good", "Good", "Fair", "Poor")),
                           selectInput("MentalHealth", "MentalHealth", choices = c("Excellent", "Very Good", "Good", "Fair", "Poor")),
                           selectInput("AdmissionWeek", "Admission day of the week", choices = c("Sun.", "Mon.", "Tue.", "Wed.", "Thu.", "Fri.", "Sat.")),
                           selectInput("DischargeWeek", "Discharge day of the week", choices = c("Sun.", "Mon.", "Tue.", "Wed.", "Thu.", "Fri.", "Sat.")),
                           numericInput("AdmissionHour", "Admission Hour", value = 0, min = 0, max = 23),
                           numericInput("DischargeHour", "Discharge Hour", value = 0, min = 0, max = 23),
                           bsTooltip("AdmissionHour", "Range: 0 - 23", "right", options = list(container = "body")),
                           bsTooltip("DischargeHour", "Range: 0 - 23", "right", options = list(container = "body"))
                           
              ),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  div(id = "result_panel", DT::dataTableOutput('result')),
                  br(),
                  # wellPanel(h3('Click Below for Calculator and Author Contact Information'),
                  #           p("[1] Jehi L, Yardi R, Chagin K, Tassi L, Russo GL, Worrell G, Hu W, Cendes F, Morita M, Bartolomei F, Chauvel P, Najm I, Gonzalez-Martinez J, Bingaman W, Kattan MW ",a('Development and validation of nomograms to provide individualised predictions of seizure outcomes after epilepsy surgery: a retrospective analysis.', href='http://www.ncbi.nlm.nih.gov/pubmed/25638640'),". Lancet Neurol. 2015 Mar;14(3):283-90. doi: 10.1016/S1474-4422(14)70325-4. Epub 2015 Jan 29."),
                  #           p("[2] Improving the prediction of epilepsy surgery outcomes using basic scalp EEG findings")),
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