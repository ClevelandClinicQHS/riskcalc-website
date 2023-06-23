library(shiny)

shinyUI(
    fluidPage(
        # include CSS
        includeCSS("riskcalc.css"),
        # Google Analytics
        JS_google_analytics,
        
        navbarPage(
            title = "Kidney cancer upstaging risk calculator", inverse = T,
            tabPanel("Home",
                     sidebarLayout(
                         sidebarPanel(
                             numericInput("Age", "Age [years]", NA, min = 18.0, max = 100.0),
                             numericInput("BMI", "BMI [kg/m^2]", NA, min = 14, max = 75),
                             numericInput("Preopsize", "Pre-operative size [cm]", NA, min = 0.5, max = 7, step = 0.5),
                             selectInput("Diabetes", "Diabetes", selectize = F,
                                         choices = c("No", "Yes")),
                             selectInput("Sex", "Sex", choices = c("Female", "Male")),
                             selectInput("Surgery", "Intended surgery type", selectize = F,
                                         choices = c("Partial", "Radical")),
                             
                             actionButton("calcRisk","Calculate Risk", "primary",c("btn-large", "meheh")),
                             
                             # Some tooltips for the input fields
                             bsPopover(id = "Age",title= "Age", content = tooltip_age_en, placement = "right", trigger = "hover", options = list(container = "body")),
                             bsPopover(id = "BMI", title = "BMI", content = tooltip_bmi_en, placement = "right", trigger = "hover", options = list(container = "body")),
                             bsPopover(id = "Preopsize",title= "Pre-operative size", content = tooltip_preopsize_en, placement = "right", trigger = "hover", options = list(container = "body"))
                         ),
                         
                         mainPanel(
                             tabsetPanel(
                                 tabPanel("Result",
                                          br(),
                                          htmlOutput("smile_en",inline = T),
                                          HTML("<p></p>"),
                                          HTML('<h3>Preamble</h3>
              <p>This risk calculator is intended for patients who have had a detection of a Stage 1 clinically localized kidney tumor with no evidence of metastasis (i.e. spread). The tumor is characterized based on either computed tomography (CT) or magnetic resonance imaging (MRI) scans; typically these studies are contrast-enhanced. In addition, the calculator applies to those kidney tumors which are believed to represent a primary tumor arising from the parenchyma (or body) of the kidney. In other words, if this kidney tumor is believed to originate from the urothelium, or ‘renal pelvis’, then this calculator is not applicable. Similarly, if the kidney tumor is felt to represent metastasis (i.e. spread from another cancer elsewhere in the body) then this should not be utilized. The determination of the ‘Intended surgery’ is based on the overall impression of the surgeon who will perform the procedure after a thorough assessment of the history, physical examination, laboratory values, and cross-sectional imaging (i.e. CT or MRI).</p>
              <p>For detailed description of the variables included in the calculator, click on the "More information" tab.</p>
')),
                                 tabPanel("More Information",
                                          info_en)
                             )
                         )
                     )   
            )
            #tabPanel("Map", stats_en)
        )
    )
)