#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyBS)
library(shinyjs)
library(shinyWidgets)

# Define UI for application that draws a histogram
ui <- fluidPage(
    shinyjs::useShinyjs(),
    HTML("<head>
          <title>Phenotype prediction for Patients with COVID-19</title>
          </head>"),

    radioGroupButtons("cohort", "",
                 c("For Patients with COVID-19" = "Positive",
                   "For Hospitalized Patients with COVID-19" = "Hospitalized"),
                 status = "primary"),
    div(id="positive",
        # Application title
        h2("Phenotype prediction for Patients with COVID-19"),
        
        # Sidebar with a slider input for number of bins 
        fluidRow(
            column(3,
                   numericInput("Age1", "Age (years)", min = 0, max = 90, value = 20),
                   bsTooltip("Age1", "Range: 0 - 90", "bottom", options = list(container = "body")),
                   selectInput("Cough", "Cough", choices = c("No", "Yes")),
                   selectInput("Fever", "Fever", choices = c("No", "Yes")),
                   selectInput("Diarrhea", "Diarrhea", choices = c("No", "Yes")),
                   selectInput("Cancer1", "Cancer", choices = c("No", "Yes")),
                   selectInput("Diabetes", "Diabetes", choices = c("No", "Yes")),
                   selectInput("Hypertension", "Hypertension", choices = c("No", "Yes"))
            ),
            
            # Show a plot of the generated distribution
            column(9,
                   #actionButton("goButton", "Run Calculator"),
                   #br(),
                   #br(),
                   tags$head(tags$style(type = "text/css", "tfoot {display:none;}")),
                   DT::dataTableOutput('result1'),
                   br(),
                   uiOutput("TotalPoint1"),
                   br(),
                   wellPanel(HTML(
"<p>This calculator was based on a multivariable prediction model with seven predictors, including one demographic variable: patient’s age; three symptom variables: the presence of cough, the presence of fever, and the presence of diarrhea; three comorbidity variables: the presence of cancer, the presence of diabetes, and the presence of hypertension.
<br>
<br>
There are a total of seven latent class analysis-defined phenotypes of COVID-19 patients. See Wang et al. (2020) for the detailed features of the different phenotypes.
<br>
<br>
<br>
<b>Reference</b>: Wang, X., Jehi, L., Ji, X., and Mazzone, P. (2020). Phenotypes and Subphenotypes of Patients with COVID-19: a Latent Class Modeling Analysis.</p>
"))
            )
        )
    ),
    shinyjs::hidden(div(id="hospitalized",
    # Application title
    h2("Subphenotype prediction for hospitalized patients with COVID-19"),

    # Sidebar with a slider input for number of bins 
    fluidRow(
        column(3,
            numericInput("Age2", "Age (years)", min = 0, max = 90, value = 20),
            bsTooltip("Age2", "Range: 0 - 90", "bottom", options = list(container = "body")),
            selectInput("Cancer2", "Cancer/COPD/emphysema", choices = c("No", "Yes")),
            numericInput("on_admission_creatinine", "Creatinine on admission (mg/dL)", min = 0, max = 8.0, value = 0.8),
            bsTooltip("on_admission_creatinine", "Range: 0 - 8", "bottom", options = list(container = "body")),
            numericInput("on_admission_albumin", "Albumin on admission (g/dL)", min = 0, max = 6.0, value = 4),
            bsTooltip("on_admission_albumin", "Range: 0 -60", "bottom", options = list(container = "body")),
            numericInput("on_admission_crp", "CRP on admission (mg/L)", min = 0, max = 30.0, value = 6),
            bsTooltip("on_admission_crp", "Range: 0 - 30", "bottom", options = list(container = "body")),
            numericInput("on_admission_wbc", "WBC on admission (× 10^9/L)", min = 1, max = 20.0, value = 6),
            bsTooltip("on_admission_wbc", "Range: 1 - 20", "bottom", options = list(container = "body"))
        ),

        # Show a plot of the generated distribution
        column(9,
            #actionButton("goButton", "Run Calculator"),
            #br(),
            #br(),
            tags$head(tags$style(type = "text/css", "tfoot {display:none;}")),
            DT::dataTableOutput('result2'),
            br(),
            uiOutput("TotalPoint2"),
            br(),
            wellPanel(HTML(
"<p>This calculator was based on a multivariable prediction model with six predictors, including a patient’s age, the presence of cancer or COPD or emphysema, the values of creatinine, albumin, c-reactive protein (CRP), and white blood cell (WBC) count on hospital admission, respectively. 
<br>
<br>
There are a total of 5 latent class analysis-defined subphenotypes of hospitalized patients with COVID-19. See Wang et al. (2020) for the detailed features of the different subphenotypes.
<br>
<br>
<br>
<b>Reference</b>: Wang, X., Jehi, L., Ji, X., and Mazzone, P. (2020). Phenotypes and Subphenotypes of Patients with COVID-19: a Latent Class Modeling Analysis.</p>
"
            ))

        )
    )
    ))
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    observe({
        if (input$cohort == "Hospitalized") {
            shinyjs::hide("positive")
            shinyjs::show("hospitalized")
        } else {
            shinyjs::show("positive")
            shinyjs::hide("hospitalized")
        }
    })
    
    data1 = reactive({
        shiny::validate(
            need(input$Age1>=0&input$Age1<=90, "Range of Age: 0 - 90")
        )
        
        Age = input$Age1
        Cough = input$Cough == "Yes"
        Fever = input$Fever == "Yes"
        Diarrhea = input$Diarrhea == "Yes"
        Cancer = input$Cancer1 == "Yes"
        Diabetes = input$Diabetes == "Yes"
        Hypertension = input$Hypertension == "Yes"
        
        class1 = 1
        class2 = exp( -5.5424+0.0315*Age+5.1782*Cough+4.8064*Fever+5.1005*Diarrhea+1.0479*Cancer+0.3638*Diabetes- 2.0860*Hypertension)
        class3 = exp(-21.3162+0.1901*Age+7.7964*Cough+7.5948*Fever+9.3213*Diarrhea+4.6911*Cancer+4.7871*Diabetes+ 6.8704*Hypertension)
        class4 = exp(-15.0942+0.2521*Age-4.5124*Cough-3.6100*Fever-1.6678*Diarrhea+5.4551*Cancer+5.8950*Diabetes+ 7.7289*Hypertension)
        class5 = exp(-17.9495+0.2207*Age+5.3138*Cough+5.2159*Fever+5.3136*Diarrhea+5.7276*Cancer+6.1920*Diabetes+ 8.6777*Hypertension)
        class6 = exp(-24.1860+0.3213*Age-0.1428*Cough+0.5849*Fever+1.6091*Diarrhea+6.3748*Cancer+7.4306*Diabetes+10.6635*Hypertension)
        class7 = exp(-27.5427+0.3089*Age+5.8951*Cough+5.0167*Fever+6.8395*Diarrhea+6.3550*Cancer+6.9374*Diabetes+10.4799*Hypertension)
        
        c(class1, class2, class3, class4, class5, class6, class7) / (sum(class1, class2, class3, class4, class5, class6, class7))
    })
    
    output$TotalPoint1 = renderUI({
        res = data1()
        
        HTML(paste('<h4 style="color:black">The patient is belonged to the COVID-19 subphenotype <b style="color:darkred">class', as.character(which(res==max(res))), "</b>based on his/her highest posterior probability of belonging using latent class analysis.</h4>"))
    })
    
    output$result1 <- DT::renderDataTable({
        data = data1()
        data = pvalr(data, digits = 3)
        result = data.frame(Result = c("Class 1", "Class 2", "Class 3", "Class 4", "Class 5", "Class 6", "Class 7"),
                            Probability = c(data))
        result
    }, rownames= FALSE,
    options = list(
        pageLength = 10,
        lengthMenu = 0,
        searching = 0,
        info = 0,
        paging = 0,
        processing = 0,
        initComplete = I(
            "function(settings, json) {
                $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
}")))
    
    data2 = reactive({
        shiny::validate(
            need(input$Age2>=0&input$Age2<=90, "Range of Age: 0 - 90"),
            need(input$on_admission_creatinine>=0&input$on_admission_creatinine<=8, "Range of Creatinine: 0 - 8"),
            need(input$on_admission_albumin>=0&input$on_admission_albumin<=6, "Range of Albumin: 0 - 6"),
            need(input$on_admission_crp>=0&input$on_admission_crp<=30, "Range of CRP: 0 - 30"),
            need(input$on_admission_wbc>=1&input$on_admission_wbc<=20, "Range of WBC: 1 - 20")
        )
        
        Age = input$Age2
        Copd_cancer = input$Cancer2 == "Yes"
        on_admission_creatinine = input$on_admission_creatinine
        on_admission_albumin = input$on_admission_albumin
        on_admission_crp = input$on_admission_crp
        on_admission_wbc = input$on_admission_wbc
        
        on_admission_creatinine = ifelse(on_admission_creatinine == 0, log(0.001), log(on_admission_creatinine))
        #on_admission_albumin = ifelse(on_admission_albumin == 0, log(0.001), log(on_admission_albumin))
        on_admission_crp = ifelse(on_admission_crp == 0, log(0.001), log(on_admission_crp))
        on_admission_wbc = ifelse(on_admission_wbc == 0, log(0.001), log(on_admission_wbc))
        
        class1 = 1
        class2 = exp(12.6082+0.0720*Age+0.1718*Copd_cancer+2.9315*on_admission_creatinine-2.4793*on_admission_albumin+2.1420*on_admission_crp-3.9857*on_admission_wbc)
        class3 = exp( 7.8747+0.1178*Age+1.8594*Copd_cancer+3.3728*on_admission_creatinine-4.5045*on_admission_albumin+3.5480*on_admission_crp-0.4530*on_admission_wbc)
        class4 = exp( 7.7816+0.1974*Age+4.5036*Copd_cancer+4.8061*on_admission_creatinine-3.3239*on_admission_albumin+1.5221*on_admission_crp-3.9073*on_admission_wbc)
        class5 = exp(17.0976+0.1458*Age+4.1479*Copd_cancer+7.3295*on_admission_creatinine-6.6837*on_admission_albumin+2.1613*on_admission_crp-1.4890*on_admission_wbc)
        
        c(class1, class2, class3, class4, class5) / (sum(class1, class2, class3, class4, class5))
    })
    
    output$TotalPoint2 = renderUI({
        res = data2()
        
        HTML(paste('<h4 style="color:black">The patient is belonged to the COVID-19 subphenotype <b style="color:darkred">class', as.character(which(res==max(res))), "</b>based on his/her highest posterior probability of belonging using latent class analysis.</h4>"))
    })
    
    output$result2 <- DT::renderDataTable({
        data = data2()
        data = pvalr(data, digits = 3)
        result = data.frame(Result = c("Class 1", "Class 2", "Class 3", "Class 4", "Class 5"),
                            Probability = c(data))
        result
    }, rownames= FALSE,
    options = list(
        pageLength = 10,
        lengthMenu = 0,
        searching = 0,
        info = 0,
        paging = 0,
        processing = 0,
        initComplete = I(
            "function(settings, json) {
                $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
}")))
}


pvalr <- function(pvals, sig.limit = .001, digits = 3, html = FALSE) {
    
    roundr <- function(x, digits = 1) {
        res <- sprintf(paste0('%.', digits, 'f'), x)
        zzz <- paste0('0.', paste(rep('0', digits), collapse = ''))
        res[res == paste0('-', zzz)] <- zzz
        res
    }
    
    sapply(pvals, function(x, sig.limit) {
        if (x < sig.limit)
            if (html)
                return(sprintf('&lt; %s', format(sig.limit))) else
                    return(sprintf('< %s', format(sig.limit)))
        if (x > .1)
            return(roundr(x, digits = 2)) else
                return(roundr(x, digits = digits))
    }, sig.limit = sig.limit)
}
# Run the application 
shinyApp(ui = ui, server = server)
