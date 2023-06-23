
require(shinythemes)
fluidPage(theme = shinytheme("flatly"),

          titlePanel('Prostate Cancer Active Surveillance: Predict 1-yr, 5-yr and 10-yr Outcome'),
          sidebarLayout(
              sidebarPanel(id = "sidebar",
                           sliderInput('age', 'Age (year)', min = 40, max = 80, step = 1, value = 40),
                           # sliderInput('Year.Of.Diagnosis', 'Year of diagnosis', min = 1990, max= 2015, step = 1, value = 2000),
                           sliderInput('psa', 'PSA', min  = 0, max = 30 , step = 0.1, value = 2),
                           sliderInput('nr_cores_ca', 'Number of cores with prostate cancer', min = 1, max = 30, step = 1, value = 1),
                           selectInput('gl_grade', 'Gleason score', choices = c('6 or lower', '3+4', '4+3'))),
              mainPanel(
                  wellPanel(
                      tags$head(
                          tags$style(type="text/css", "tfoot {display:none;}")
                      ),
                      DT::dataTableOutput('result'),
                      br(),
                      plotOutput("plot")
                  ),
                  br(),
                  wellPanel(h3('Disclaimer'),
                            p("No Medical Advice. ALTHOUGH SOME CONTENT MAY BE PROVIDED BY INDIVIDUALS IN THE MEDICAL PROFESSION, YOU ACKNOWLEDGE THAT PROVISION OF SUCH CONTENT DOES NOT CREATE A MEDICAL PROFESSIONAL-PATIENT RELATIONSHIP AND DOES NOT CONSTITUTE AN OPINION, MEDICAL ADVICE, PROFESSIONAL DIAGNOSIS, SERVICE OR TREATMENT OF ANY CONDITION. Access to general information is provided for educational purposes only, through this site and links to other sites. Content is not recommended or endorsed by any doctor or healthcare provider. The information and Content provided are not substitutes for medical or professional care, and you should not use the information in place of a visit, call, consultation or the advice of your physician or other healthcare provider. You are liable or responsible for any advice, course of treatment, diagnosis or any other information, services or product obtained through this site."))
                  )))