
library(shiny)
library(shinyBS)
library(shinythemes)
library(shinyjs)

# input tips
tooltip_surgery = "Patients should be classified as dominant or nondominant based on available fMRI or Wada testing. For right-handed individuals without a language lateralization procedure, left=dominant, right=nondominant. This model should not be used to calculate risk in left-handed patients without a language lateralization procedure or those with symmetric bilateral language representation on fMRI or Wada."
tooltip_bnt = "Boston Naming Test raw score is based on 60-item version that includes the number of items spontaneously correct as well as those that were correct with a semantic cue."
tooltip_history = "Includes any psychiatric history (current or past), such as mood, personality, dysphoria, psychosis, ADHD/ADD, chronic pain, substance use disorder, and conversion disorders."
tooltip_mcd = "MCD includes focal cortical dysplasia, gray matter heterotopia, polymicrogyria, and schizencephaly."


fluidPage(shinyjs::useShinyjs(), theme = shinytheme("flatly"),
          tags$head(tags$link(rel="shortcut icon", href="../assets/icons/favicon.ico", type="image/x-icon")),
          tags$head(tags$link(rel="apple-touch-icon", href="../assets/icons/apple-touch-icon.png", type="image/x-icon")),
          titlePanel('Predicts the probabilities of postoperative declines in naming, verbal memory, and mood'),
          sidebarLayout(
              sidebarPanel(id = "sidebar",
                           numericInput("age1", "Age at seizure onset (in years)", NA, min = 0.0, max = 60.0),
                           selectInput('surgery', 'Side of surgery', choices = c('Non-Dominant', "Dominant")),
                           numericInput("age2", "Age at time of surgery (in years)", NA, min = 16.0, max = 75.0),
                           selectInput('sex', 'Sex', choices = c('Female', 'Male')),
                           selectInput('education', 'Highest level of education achieved', 
                                       choices = c("Less than completed high school", "High School Diploma", "Associate’s Degree",
                                                   "Bachelor's Degree", "Master's Degree", "Juris Doctor", "Doctoral Degree")),
                           # conditional input for patients with less than completed high school
                           conditionalPanel(
                               condition = "input.education == 'Less than completed high school'",
                               numericInput("education2", "Please input your education in years", NA, min=2, max=12)
                           ),
                           numericInput('bnt', 'Preop Boston Naming Test Raw Score', NA, min = 20, max = 60),
                           numericInput('lm', 'Preop WMS-III Logical Memory (delayed) scaled score', NA, min = 1, max = 17),
                           numericInput('vpa', 'Preop WMS-III Verbal Paired Associates (delayed) scaled score', NA, min = 1, max = 20),
                           numericInput('avlt', 'Preop Rey AVLT (delayed) raw score', NA, min = 0, max = 15),
                           selectInput('hippocampus', 'Hippocampus', choices = c("Not To Be Resected", "To Be Resected")),
                           selectInput('history', 'Psychiatric history', choices = c('No', "Yes")),
                           numericInput("fas", "Preop F-A-S raw score", NA, min = 3.0, max = 79.0),
                           selectInput('relation', 'Relationship status at preop testing', 
                                       choices = c('Single', 'In Relationship', 'Married', 'Divorced', 'Widowed')),
                           selectInput('mcd', 'Malformation of cortical development', choices = c('Absent', "Present")),
                           
                           # tip message
                           bsTooltip(id = 'age1', title = "Range: 0-60", placement = "right", trigger = "hover", options = list(container = "body")),
                           bsTooltip(id = 'age2', title = "Range: 16 - 75", placement = "right", trigger = "hover", options = list(container = "body")),
                           bsTooltip(id = 'education2', title = "Range: 2 - 12", placement = "right", trigger = "hover", options = list(container = "body")),
                           bsTooltip(id = "surgery", title = tooltip_surgery, placement = "right", trigger = "hover", options = list(container = "body")),
                           bsTooltip(id = "bnt", title = tooltip_bnt, placement = "right", trigger = "hover", options = list(container = "body")),
                           bsTooltip(id = "lm", title = "Range: 1 - 17", placement = "right", trigger = "hover", options = list(container = "body")),
                           bsTooltip(id = "avlt", title = "Range: 0 - 15", placement = "right", trigger = "hover", options = list(container = "body")),
                           bsTooltip(id = "vpa", title = "Range: 1 - 20", placement = "right", trigger = "hover", options = list(container = "body")),
                           bsTooltip(id = 'fas', title = "Range: 3 - 79", placement = "right", trigger = "hover", options = list(container = "body")),
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
                  
                  div(id = "result_panel", DT::dataTableOutput('result')),
                  br(),
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),
                            p("[1] Busch, R. M., Hogue, O., Kattan, M. W., Hamberger, M., Drane, D. L., Hermann, B., Kim, M., Ferguson, L., Bingaman, W., Gonzalez-Martinez, J., Najm, I. M., & Jehi, L. (2018). ",a('Nomograms to predict naming decline after temporal lobe surgery in adults with epilepsy.', href='https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6282231/')," Neurology, 97(3), e263-e274. PMID: 34011574."),
                            p("[2] Busch, R.M., Hogue, O., Miller, M., Ferguson, L., McAndrews, M.P., Hamberger, M., Kim, M., McDonald, C.R., Reyes, A., Drane, D.L., Hermann, B.P., Bingaman, W., Najm, I.M., Kattan, M.W., & Jehi, L. (2021). ", a("Nomograms to predict verbal memory decline after temporal lobe resection in adults with epilepsy.", href="https://pubmed.ncbi.nlm.nih.gov/34011574/"), " Neurology, 97(3), e263-e274. PMID: 34011574"),
                            p("[3] Doherty, C., Nowacki, A., McAndrews, M.P., Bandari, P., McDonald, C.R., Reyes, A., Kim, M., Hamberger, M., Najm, I.M., Bingaman, W., Jehi, L., & Busch, R.M. (2021). ",a('Predicting mood decline following temporal lobe epilepsy surgery in adults.', href='https://onlinelibrary.wiley.com/doi/abs/10.1111/epi.16800?af=R')," Epilepsia, 62(2): 450-459. PMID: 33464568.")),
                  wellPanel(h3('Disclaimer'),
                            p("No Medical Advice. ALTHOUGH SOME CONTENT MAY BE PROVIDED BY INDIVIDUALS IN THE MEDICAL PROFESSION, YOU ACKNOWLEDGE THAT PROVISION OF SUCH CONTENT DOES NOT CREATE A MEDICAL PROFESSIONAL-PATIENT RELATIONSHIP AND DOES NOT CONSTITUTE AN OPINION, MEDICAL ADVICE, PROFESSIONAL DIAGNOSIS, SERVICE OR TREATMENT OF ANY CONDITION. Access to general information is provided for educational purposes only, through this site and links to other sites. Content is not recommended or endorsed by any doctor or healthcare provider. The information and Content provided are not substitutes for medical or professional care, and you should not use the information in place of a visit, call, consultation or the advice of your physician or other healthcare provider. You are liable or responsible for any advice, course of treatment, diagnosis or any other information, services or product obtained through this site.")),
                            p(a("Homepage",
                                 href = "../", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                                   font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
                                 " | ",
                            a("Contact Us",
                            href = "mailto:rcalcsupport@ccf.org?body=Predicting%20cognitive%20outcomes%20after%20epilepsy%20surgery", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                            font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
                            " | ",
                            a("Add to phone (iOS Safari)", href="https://support.apple.com/guide/iphone/bookmark-favorite-webpages-iph42ab2f3a7/ios#iph4f9a47bbc", target="_blank", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
                            " | ", 
                            a("Add to phone (Android)", href="https://www.cnet.com/tech/mobile/adding-one-touch-bookmarks-to-your-androids-home-screen/", target="_blank", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
                            " | ",
                            a("Source Code", 
                              href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/CognitiveAndMoodAfterEpilepsySurgery", 
                              style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
                            ),
                            style = "text-align: center;"),
                            img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;")
                  )
            )
          )
