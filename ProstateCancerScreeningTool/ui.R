library(shiny)
library(shinythemes)
library(shinyBS)

actionButton <- function(inputId, label, btn.style = "" , css.class = "") {
    if ( btn.style %in% c("primary","info","success","warning","danger","inverse","link")) {
        btn.css.class <- paste("btn",btn.style,sep="-")
    } else btn.css.class = ""
    
    tags$button(id=inputId, type="button", class=paste("btn action-button",btn.css.class,css.class,collapse=" "), label)
}  


fluidPage(theme = shinytheme("spacelab"),
          titlePanel("Prostate Cancer Screening Tool"),
          
          hr(),
          
          sidebarLayout(
              sidebarPanel(width=5,
                           shinyjs::useShinyjs(),
                           id = "side-panel",
                           selectizeInput("q1", 
                                          "What is your age?",
                                          choices = c("", ">= 70 (0)"="a0", "65-69 (3)"="b3", "55-64 (2)"="c2", "40-54 (1)"="d1", "<40 (0)"="e0")),
                           uiOutput('warning_q1'),
                           selectizeInput("q2", multiple = TRUE, 
                                          "What is your race or ethnicity? Select all that apply",
                                          choices = c("White/Caucasian (1)"="a1", "Black/African-American (3)"="b3", "Asian/Pacific Islander (0)"="c0", "Native American/Alaskan Native (0)"="d0", "Hispanic (0)"="e0"),
                                          options = list('plugins' = list('remove_button'), 'create' = FALSE, 'persist' = FALSE)),
                           uiOutput('warning_q2'),
                           selectizeInput("q3", multiple = TRUE,
                                          "Did any of your family members have prostate cancer? More than one answer may apply",
                                          choices = c("My father had prostate cancer (1)"="a1", "My brother had prostate cancer (2)"="b2", "More than one family member had prostate cancer (1)"="c1", "I do not have a family history of prostate cancer (0)"="d0", "I don't know about my family history of prostate cancer (0)"="e0"),
                                          options = list('plugins' = list('remove_button'), 'create' = FALSE, 'persist' = FALSE)),
                           uiOutput('warning_q3'),
                           selectizeInput("q4",
                                          "If you have had a digital rectal exam, what was the result?",
                                          choices = c("", "I don't know the results (1)"="a1", "No previous digital rectal exam (1)"="b1", "Normal digital rectal exam (0)"="c0", "Abnormal digital rectal exam (3)"="d3")),
                           uiOutput('warning_q4'),
                           selectizeInput("q5",
                                          "If you have had previous prostate-specific antigen (PSA) level what was the result?",
                                          choices = c("", "I don't know (1)"="a1", "No previous PSA (1)"="b1", "PSA < 1.0 (0)"="c0", "PSA 1.0-3.0 (2)"="d2", "PSA > 3.0 (3)"="e3")),
                           uiOutput('warning_q5'),
                           selectizeInput("q6",
                                          "How would you rate your health?",
                                          choices = c("", "My health is excellent (3)"="a3", "My health is very good (2)"="b2", "My health is good (1)"="c1", "My health is poor (0)"="d0")),
                           uiOutput('warning_q6'),
                           selectizeInput("q7",
                                          "If you were to have problems with incontinence (leakage) of urine, how much would this bother you?",
                                          choices = c("", "Not at all (3)"="a3", "Somewhat (2)"="b2", "Very much (1)"='c1', "Extremely (0)"="d0")),
                           uiOutput('warning_q7'),
                           selectizeInput("q8",
                                          "How importantant is your sex life and maintaining ability to have an erection?",
                                          choices = c("", "Not important (3)"="a3", "Somewhat important (2)"='b2', "Very important (1)"="c1", "Extremely important (0)"="d0")),
                           uiOutput('warning_q8'),
                           selectizeInput("q9",
                                          "Are you concerned about having or developing prostate cancer?",
                                          choices = c("", "No, I am not concerned about having or developing prostate cancer (0)"='a0', "I am a little concerned I may have or may develop prostate cancre (1)"='b1', "I am very concerned I may have or may develop prostate cancer (2)"='c2', "I am extremely concerned I may have or may develop prostate cancer (3)"="d3")),
                           uiOutput('warning_q9'),
                           
                           br(),
                           
                           actionButton("calcScore", "Calculate Score", "button", c("btn", "btn-primary")),
                           actionButton("clean", "Clean", "button", c("btn", "btn-secondary")),
                           
                           bsPopover(id = "q3", title="Family members", content = 'Family members related by birth, not by marriage only. Skip "More than one family member had prostate cancer (1)" if father or brother had prostate cancer', placement = "top", trigger = "focus")
              ),
              
              mainPanel(width=7,
                        tabsetPanel(
                            tabPanel("Result",
                                     h1(htmlOutput("score")),
                                     br(),
                                     uiOutput('plot'),
                                     br(),
                                     h3("References"),
                                     h4('Misra-Hebert AD, Hom G, Klein EA, Bauman JM, Gupta N, Ji X, Stephenson AJ, Jones JS, and Kattan MW. "Testing of a Tool for Prostate Cancer Screening Discussions in Primary Care." Frontiers in Oncology 8 (2018). doi:', 
                                        a('10.3389/fonc.2018.00238.', href = 'https://doi.org/10.3389/fonc.2018.00238')),
                                     h4('Misra-Hebert AD, Kattan MW. Prostate Cancer Screening: A Brief Tool to Incorporate Patient Preferences in a Clinical Encounter. Front Oncol. 2016 Nov 4;6:235. eCollection 2016. doi: ',
                                        a('10.3389/fonc.2016.00235', href = 'https://doi.org/10.3389/fonc.2016.00235'))
                        )
              )
          )
))

