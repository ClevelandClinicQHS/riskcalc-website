require(shiny)
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

        titlePanel("Predicting Probability of goal attainment (A1C <8%) in 1 year for Type 2 Diabetes Patients with A1c >9%"),
        sidebarLayout(
            # Sidebar
            sidebarPanel(
                numericInput("Age", "Age (years)", min=18, max=100, value=18),
                selectInput("Race", "Race", choices=list("White", "Black", "Other")),
                selectInput("Ethnicity", "Ethnicity", choices=list("Hispanic Americans", "Not Hispanic or Latino", "Unknown")),
                selectInput("Insurance", "Insurance", choices=list("Medicare","Medicaid","Private Health Insurance","Other")),
                numericInput("A1c", "A1C (%)", min=9, max=50, value=9, step = 0.1),
                numericInput("TimeInDataBase", "Time in T2D Database (years)", min=0, max=30, value=0),
                numericInput("Encounters", "Number of completed primary care or endocrinology office visits in recent 2 years", min=0, max=50, value=0),
                selectInput("TZD", "TZD", choices=list("No", "Yes")),
                selectInput("GLP1", "GLP1", choices=list("No", "Yes")),
                selectInput("DPP4", "DPP4", choices=list("No", "Yes")),
                selectInput("Metform", " Metformin", choices=list("No", "Yes")),
                selectInput("SGLT2", "SGLT-2", choices=list("No", "Yes")),
                selectInput("Insulin2", "Insulin", choices=list("No", "Yes")),
                numericInput("Total.Number.Med", "Total Classes of diabetes medications", min=0, max=8, value=0),
                selectInput("Obesity", "History of Obesity", choices=list("No", "Yes")),
                selectInput("CKD", "History of Chronic Kidney Disease", choices=list("No", "Yes")),
                selectInput("Charlson.Index.Factor", "Charlson Index Score", choices=list("0", "1", "2", ">=3"))

            ),
            mainPanel(
                actionButton("goButton", "Run Calculator"),
                br(),
                hr(),
                tags$head(
                    tags$style(type="text/css", "tfoot {display:none;}")
                ),
                dataTableOutput('table'),
                br(),
                # wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] Nixon IJ, Ganly I, Hann LE, Lin O, Yu C, Brandt S, Shah JP, Shaha A, Kattan MW, Patel SG. ",a('Nomogram for predicting malignancy in thyroid nodules using clinical, biochemical, ultrasonographic, and cytologic features', href='http://www.sciencedirect.com/science/article/pii/S0039606010005222'),". Surgery. 2010 Dec;148(6):1120-7; discussion 1127-8. doi: 10.1016/j.surg.2010.09.030")),
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
                img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;"))
        ))
