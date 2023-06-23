library(shiny)
library(shinyBS)
library(shinyjs)
library(shinythemes)


fluidPage(
  tags$head(tags$meta(`http-equiv`="refresh", content="0; URL=https://riskcalc.org/FreedomFromSeizureRecurrenceAfterSurgery/")),
  useShinyjs(),
  tags$script(HTML(
    'function myFunction() {
  var txt;
  if (confirm("This is a mailbox for reporting website errors to programmers for the risk calculator website.  If you have questions or concerns about a specific calculator, please use the calculator Author Contact Information found on the publication for that calculator.  Each calculator is documented by a specific publication with a corresponding author.")) {
    window.open("mailto:rcalcsupport@ccf.org");
  }
}'
  )),
  theme = shinytheme("flatly"),
  titlePanel('Clinical and EEG Prediction of Seizure Freedom at 2 years'),
  sidebarLayout(
    sidebarPanel(
      id = "sidebar",
      selectInput(
        'gtc',
        'Generalized Tonic-Clonic Seizures',
        choices = c("Absent", "Present")
      ),
      numericInput(
        'PreopMonthlyseizurefrequency',
        'Preoperative Monthly Seizure Frequency',
        value = 0,
        min = 0,
        max = 300
      ),
      bsTooltip("PreopMonthlyseizurefrequency", "Range: 0 - 300", "right", options = list(container = "body")),
      selectInput(
        'mts',
        'Pathological Cause',
        choices = c("Mesial Temporal Sclerosis", "Other")
      ),
      selectInput(
        'normalmri',
        'MRI Findings',
        choices = c("Normal", "Abnormal")
      ),
      selectInput(
        'nonlocal',
        'Seizure Localization',
        choices = c("Always localizable", "Sometimes non-localizable")
      ),
      selectInput(
        'bilateral',
        'Interictal Epileptiform Discharges',
        choices = c("Bilateral", "No Epileptiform Discharges", ">80% Unilateral")
      ),
      selectInput(
        'temporal',
        'Expected Lobe of Resection',
        choices = c("Temporal", "Other")
      )
    ),
    mainPanel(
      actionButton("goButton", "Run Calculator"),
      br(),
      br(),
      DT::dataTableOutput('result'),
      br(),
      # wellPanel(
      #   h3('Click Below for Calculator and Author Contact Information'),
      #   p(
      #     "Jehi L, Ji X, Milinovich A, Erzurum S, Rubin B, Gordon S, Young J, Kattan MW. ",
      #     a(
      #       "Individualizing risk prediction for positive COVID-19 testing: results from 11,672 patients. ",
      #       href = "https://www.ncbi.nlm.nih.gov/pubmed/32533957/"
      #     ),
      #     "Chest. 2020 Jun 10;. doi: 10.1016/j.chest.2020.05.580. [Epub ahead of print] PubMed PMID: 32533957."
      #   )
      # ),
      wellPanel(
        h3('Disclaimer'),
        p(
          "No Medical Advice. ALTHOUGH SOME CONTENT MAY BE PROVIDED BY INDIVIDUALS IN THE MEDICAL PROFESSION, YOU ACKNOWLEDGE THAT PROVISION OF SUCH CONTENT DOES NOT CREATE A MEDICAL PROFESSIONAL-PATIENT RELATIONSHIP AND DOES NOT CONSTITUTE AN OPINION, MEDICAL ADVICE, PROFESSIONAL DIAGNOSIS, SERVICE OR TREATMENT OF ANY CONDITION. Access to general information is provided for educational purposes only, through this site and links to other sites. Content is not recommended or endorsed by any doctor or healthcare provider. The information and Content provided are not substitutes for medical or professional care, and you should not use the information in place of a visit, call, consultation or the advice of your physician or other healthcare provider. You are liable or responsible for any advice, course of treatment, diagnosis or any other information, services or product obtained through this site."
        )
      ),
      p(
        a(
          "Homepage",
          href = "../",
          style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
        ),
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
      img(src = '../logo-ccf.png', style = "max-width:50%; max-height:100%;")
    )
  )
)
