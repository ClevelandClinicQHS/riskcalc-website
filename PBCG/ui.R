library(shiny)

shinyUI(
    fluidPage(
        # include CSS
        includeCSS("riskcalc.css"),
        # Google Analytics
        JS_google_analytics,
        tags$head(tags$link(rel="shortcut icon", href="../assets/icons/favicon.ico", type="image/x-icon")),
          tags$head(tags$link(rel="apple-touch-icon", href="../assets/icons/apple-touch-icon.png", type="image/x-icon")),
        
        navbarPage(
            title = "PBCG Risk Calculator", inverse = T,
            tabPanel("Home",
                     sidebarLayout(
                         sidebarPanel(
                             selectInput("race", "Race", choices = c("","African Ancestry", "Other")),
                             numericInput("age", "Age", NA, min = 40.0, max = 90.0),
                             numericInput("psa", "PSA [ng/ml]", NA, min = 2, max = 50),
                             selectInput("dre", "Digital rectal examination", selectize = F,
                                         choices = c("", "Abnormal", "Normal", "Not performed or not sure")),
                             selectInput("priobiop", "Prior biopsy", selectize = F,
                                         choices = c("", "Never had a prior biopsy", "Prior negative biopsy", "Not sure")),
                             selectInput("famhist", "Family History of Prostate Cancer", selectize = F,
                                         choices = c("", "Yes", "No", "Do not know")),
                             
                             actionButton("calcRisk","Calculate Risk", "primary",c("btn-large", "meheh")),
                             
                             # Some tooltips for the input fields
                             bsPopover(id = "age",title= "Age", content = tooltip_age_en, placement = "right", trigger = "hover", options = list(container = "body")),
                             bsPopover(id = "psa", title = "PSA", content = tooltip_psa_en, placement = "right", trigger = "hover", options = list(container = "body")),
                             bsPopover(id = "famhist", title = "Family History", content = tooltip_famhist_en, placement = "right", trigger = "hover", options = list(container = "body")),
                             bsPopover(id = "dre", title = "Digital rectal examination", content = tooltip_dre_en, placement = "right", trigger = "hover", options = list(container = "body")),
                             bsPopover(id = "priobiop", title ="Prior Biopsy", content = tooltip_priobiop_en, placement = "right", trigger = "hover", options = list(container = "body"))
                         ),
                         
                         mainPanel(
                             tabsetPanel(
                                 tabPanel("Result",
                                          br(),
                                          htmlOutput("smile_en",inline = T),
                                          HTML("<p>This risk calculator is for patients who have been deemed to be suitable candidates for biopsy by their urologist. 
                                               This means that, for instance, they have been evaluated to see if their PSA level is due to a disease other than cancer, 
                                               such having an enlarged prostate, a common problem in older men. 
                                               If you have not been evaluated by your urologist and told that you are a good candidate for biopsy, 
                                               the risk calculator will likely ovestimate your risk of having prostate cancer</p>")),
                                 tabPanel("More Information",
                                          info_en)
                             )
                         )
                     )   
            ),
            tabPanel("Map", stats_en),
            navbarMenu("Add to phone",
                       tabPanel(title = HTML("<a href='https://support.apple.com/guide/iphone/bookmark-favorite-webpages-iph42ab2f3a7/ios#iph4f9a47bbc' target='_blank'>iOS (Safari)</li>")),
                       tabPanel(title = HTML("<a href='https://www.cnet.com/tech/mobile/adding-one-touch-bookmarks-to-your-androids-home-screen/' target='_blank'>Android</li>"))
            )
        )
    )
)
