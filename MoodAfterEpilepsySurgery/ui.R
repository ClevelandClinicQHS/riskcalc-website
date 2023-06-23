
library(shiny)
library(shinyBS)
library(shinyjs)
library(shinythemes)

# input tips
tooltip_surgery = "Patients should be classified as dominant or nondominant based on available fMRI or Wada testing. For right-handed individuals without a language lateralization procedure, left=dominant, right=nondominant. This model should not be used to calculate risk in left-handed patients without a language lateralization procedure or those with symmetric bilateral language representation on fMRI or Wada."
tooltip_history = "Includes any psychiatric history (current or past), such as mood, personality, dysphoria, psychosis, ADHD/ADD, chronic pain, substance use disorder, and conversion disorders."
tooltip_mcd = "MCD includes focal cortical dysplasia, gray matter heterotopia, polymicrogyria, and schizencephaly."

fluidPage(
    tags$head(tags$meta(`http-equiv`="refresh", content="0; URL=https://riskcalc.org/CognitiveAndMoodAfterEpilepsySurgery/")),
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
    titlePanel('Predicting mood decline after temporal lobe epilepsy surgery'),
    sidebarLayout(
        sidebarPanel(id = "sidebar",
                     selectInput('history', 'Psychiatric history', choices = c('No', "Yes")),
                     selectInput('surgery', 'Side of surgery', choices = c('Non-Dominant', "Dominant")),
                     numericInput("fas", "Preop F-A-S raw score", NA, min = 3.0, max = 79.0),
                     selectInput('relation', 'Relationship status at preop testing', 
                                 choices = c('Single', 'In Relationship', 'Married', 'Divorced', 'Widowed')),
                     numericInput("age", "Age at preop testing", NA, min = 16.0, max = 78.0),
                     selectInput('mcd', 'Malformation of cortical development', choices = c('Absent', "Present")),
                     
                     # tip message
                     bsTooltip(id = 'age', title = "Range: 16 - 78", placement = "right", trigger = "hover", options = list(container = "body")),
                     bsTooltip(id = 'fas', title = "Range: 3 - 79", placement = "right", trigger = "hover", options = list(container = "body")),
                     bsTooltip(id = "surgery", title = tooltip_surgery, placement = "right", trigger = "hover", options = list(container = "body")),
                     bsTooltip(id = "history", title = tooltip_history, placement = "right", trigger = "hover", options = list(container = "body")),
                     bsTooltip(id = "mcd", title = tooltip_mcd, placement = "right", trigger = "hover", options = list(container = "body"))
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
            wellPanel(h3('Reference'),p("Doherty, C., Nowacki, A., McAndrews, M.P., Bandari, P., McDonald, C.R., Reyes, A., Kim, M., Hamberger, M., Najm, I.M., Bingaman, W., Jehi, L., & Busch, R.M. (2021). ",a('Predicting mood decline following temporal lobe epilepsy surgery in adults.', href='https://onlinelibrary.wiley.com/doi/abs/10.1111/epi.16800?af=R')," Epilepsia, 62(2): 450-459. PMID: 33464568.")),
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
)