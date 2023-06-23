#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyjs)
library(gt)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    useShinyjs(),
    tags$script(HTML(
        'function myFunction() {
  var txt;
  if (confirm("This is a mailbox for reporting website errors to programmers for the risk calculator website.  If you have questions or concerns about a specific calculator, please use the calculator Author Contact Information found on the publication for that calculator.  Each calculator is documented by a specific publication with a corresponding author.")) {
    window.open("mailto:rcalcsupport@ccf.org");
  }
}'
    )),
  # Application title
  titlePanel("Outcomes Predictor after Mastectomy with N1 Breast Cancer"),
  
  fluidRow(column(width = 12,
                  p("This predictor is applicable to women with breast cancer who have upfront mastectomy, have a <=5cm tumor, and 1, 2, or 3 positive lymph nodes. Based on a combination of patient, disease, and treatment characteristics, the 5-year and 10-year predicted risks of local recurrence, distant recurrence, overall recurrence, and breast cancer mortality are calculated."),
                    strong("Note that 'optimal systemic therapy' includes endocrine therapy for patients with ER+ or PR+ disease, trastuzumab for patients with HER2+ disease, and chemotherapy for patients with ER- and PR- disease."),
                  HTML("<br><br><br>")
  )
  ),
  
  fluidRow(
    column(width = 4,
           sliderInput(
             inputId= "age_at_diagnosis",
             label = "Age at diagnosis (years)",
             min = 20,
             max = 90,
             value = 55,
             step = 1),
           
           sliderInput(
             inputId = "pathologic_tumor_size_cm",
             label = "Pathologic tumor size (cm)",
             min = 0,
             max = 5,
             value = 3,
             step = 0.1),
           
           sliderInput(
             inputId = "number_ln_sampled",
             label = "Number of lymph nodes sampled",
             min = 1,
             max = 40,
             value = 12,
             step = 1),
           
           selectInput(
             inputId = "number_ln_positive",
             label = "Number of positive lymph nodes",
             choices = list("1", "2", "3")
           ),
           
           selectInput(
             inputId = "grade_bin",
             label = "Grade",
             choices = list("I/II", "III")
           ),
           
           selectInput(
             inputId = "lvi",
             label = "Lymphovascular invasion",
             choices = list("No", "Yes")
           ),
           
           selectInput(
             inputId = "er_pr",
             label = "ER/PR status",
             choices = list("ER+ or PR+", "ER- and PR-")
           ),
           
           selectInput(
             inputId = "her2_status",
             label = "HER2 status",
             choices = list("Negative", "Positive")
           ),
           
           selectInput(
             inputId = "tumor_quadrant_bin",
             label = "Tumor location",
             choices = list("Inner", "Other")
           ),
           
           selectInput(
             inputId = "optimal_systemic_therapy",
             label = "Optimal systemic therapy",
             choices = list("No", "Yes")
           )),
    
    column(width = 8,
           align = "center",
           gt_output("predTab"),
           br(),
           plotOutput("predPlot"),
           br(),
           wellPanel(h3('Reference'),p("Sittenfeld, S., Zabor, E. C., Hamilton, S. N., Kuerer, H. M., El-Tamer, M., Naoum, G. E., Truong, P. T., Nichol, A., Smith, B. D., Woodward, W. A., Moo, T. A., Powell, S. N., Shah, C. S., Taghian, A. G., Abu-Gheida, I., & Tendulkar, R. D. (2022). A multi-institutional prediction model to estimate the risk of recurrence and mortality after mastectomy for T1-2N1 breast cancer. Cancer, 128(16), 3057–3066. https://doi.org/10.1002/cncr.34352")),
           wellPanel(h3('Disclaimer'),
                     p("No Medical Advice. ALTHOUGH SOME CONTENT MAY BE PROVIDED BY INDIVIDUALS IN THE MEDICAL PROFESSION, YOU ACKNOWLEDGE THAT PROVISION OF SUCH CONTENT DOES NOT CREATE A MEDICAL PROFESSIONAL-PATIENT RELATIONSHIP AND DOES NOT CONSTITUTE AN OPINION, MEDICAL ADVICE, PROFESSIONAL DIAGNOSIS, SERVICE OR TREATMENT OF ANY CONDITION. Access to general information is provided for educational purposes only, through this site and links to other sites. Content is not recommended or endorsed by any doctor or healthcare provider. The information and Content provided are not substitutes for medical or professional care, and you should not use the information in place of a visit, call, consultation or the advice of your physician or other healthcare provider. You are liable or responsible for any advice, course of treatment, diagnosis or any other information, services or product obtained through this site.")),
           p(a("Homepage",
               href = "../", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                                   font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
             " | ",
             a(
                 "Website Error Messages",
                 href = "javascript:myFunction()",
                 #href = "mailto:rcalcsupport@ccf.org",
                 style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
             ),
             style = "text-align: center;"
           ),
           img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;")
    )
  )
))