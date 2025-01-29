
library(shiny)
library(shinyBS)
library(shinyjs)
library(shinythemes)

tooltip_surgdomrec = "Surgery side should be classified as dominant, undetermined, or nondominant based on available language lateralization procedure (fMRI or Wada). Classify as dominant if surgery is ipsilateral to the language dominant hemisphere and nondominant if contralateral to the language dominant hemisphere. Patients with bilateral asymmetric language representation should be considered language dominant on the side with greater representation (e.g., right>left or left>right). In right-handed individuals without a language lateralization procedure and aged ≥7 years, left-sided resections should be considered dominant and right-sided resections nondominant. Choose undetermined if patient is left-handed, ambidextrous, or <7 years old without a language lateralization procedure or has symmetric bilateral language representation on lateralization procedure."
tooltip_orsite = "Multilobar refers to temporal-plus resection and temporal to temporal-only resection"

# input tips
fluidPage(
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
    titlePanel('Predicts the probabilities of postoperative verbal and visual memory decline'),
    sidebarLayout(
        sidebarPanel(id = "sidebar",
                     selectInput('surgdomrec', 'Surgical dominance', choices = c('Non-Dominant', "Dominant", "Undetermined")),
                     selectInput('orsite', 'Surgical extent', choices = c('Temporal', "Multilobar")),
                     numericInput("stdel1ss", "Preoperative Stories Delayed scaled score", 0, min = 0, max = 19),
                     numericInput("fsiqcomb1", "Preoperative FSIQ standard score", 40, min = 40, max = 160),
                     numericInput("wpld1ss", "Preoperative Word Pairs Long Delayed scaled score", 0, min = 0, max = 19),
                     numericInput("facde1ss", "Preoperative Faces Delayed scaled score", 0, min = 0, max = 19),

                     
                     # tip message
                     bsTooltip(id = 'surgdomrec', title = tooltip_surgdomrec, placement = "right", trigger = "hover", options = list(container = "body")),
                     bsTooltip(id = 'orsite', title = tooltip_orsite, placement = "right", trigger = "hover", options = list(container = "body")),
                     bsTooltip(id = 'stdel1ss', title = "Range: 0 - 19", placement = "right", trigger = "hover", options = list(container = "body")),
                     bsTooltip(id = "fsiqcomb1", title = "Range: 40 - 160", placement = "right", trigger = "hover", options = list(container = "body")),
                     bsTooltip(id = "wpld1ss", title = "Range: 0 - 19", placement = "right", trigger = "hover", options = list(container = "body")),
                     bsTooltip(id = "facde1ss", title = "Range: 0 - 19", placement = "right", trigger = "hover", options = list(container = "body"))
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
            wellPanel(h3('Click Below for Calculator and Author Contact Information'),
                      p("Kaur, N., Nowacki, A.S., Lachhwani, D., Berl, M.M., Hamberger, M.J., Klaas, P., Bingaman, W. & Busch, R.M. (2023). ",a('Characterization and prediction of short-term outcomes in memory after temporal lobe resection in children with epilepsy.', href='https://pubmed.ncbi.nlm.nih.gov/36927884/')," Neurology, 100(18):e1878-1886.")),
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
              " | ",
              a("Source Code", 
                href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/MemoryAfterPediatricEpilepsySurgery", 
                style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
              ),
              style = "text-align: center;"
            ),
            img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;")
        )
    )
)