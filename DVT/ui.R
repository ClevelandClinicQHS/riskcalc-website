library(shiny)

dropdownButton <- function(label = "", status = c("default", "primary", "success", "info", "warning", "danger"), ..., width = NULL) {
    
    status <- match.arg(status)
    # dropdown button content
    html_ul <- list(
        class = "dropdown-menu",
        style = if (!is.null(width)) 
            paste0("width: ", validateCssUnit(width), ";"),
        lapply(X = list(...), FUN = tags$li, style = "margin-left: 10px; margin-right: 10px;")
    )
    # dropdown button apparence
    html_button <- list(
        class = paste0("btn btn-", status," dropdown-toggle"),
        type = "button", 
        `data-toggle` = "dropdown"
    )
    html_button <- c(html_button, list(label))
    html_button <- c(html_button, list(tags$span(class = "caret")))
    # final result
    tags$div(
        class = "dropdown",
        do.call(tags$button, html_button),
        do.call(tags$ul, html_ul),
        tags$script(
            "$('.dropdown-menu').click(function(e) {
            e.stopPropagation();
});")
  )
}


library(shiny)
shinyUI(fluidPage(
    h1("Probability of Acquiring VTE at PICU"),

    sidebarLayout(
        sidebarPanel(
            selectInput("Age", "Age", c("<1 Month - 23 Month", "2 Years - 12 Years", "13 Years - 18 Years")),
            selectInput("Race", "Race", c("White", "Black", "Other")),
            selectInput("Airway.InvasiveVentilation", "Mechanical Ventilation", c("No", "Yes")),
            br(),
            dropdownButton(label = "Central Lines", status = "default", width = 300,
                checkboxGroupInput("checkGroup1", 
                               label = "select central lines", 
                               choices = list("Peripheral Central/PICC" = "picc",
                                              "Broviac/Hickman Type Tunneled Central Venous Catheter" = "broviac",
                                              "Hemodialysis/ plasmapheresis Catheter" = "hemodialysis",
                                              "Percutaneous Central Venous Catheter" = "percutaneous",
                                              "Transthoracic Catheter(Non PA)" = "transthoracic",
                                              "Umbilical venous catheter" = "umbilical"),
                               selected = NULL)),
            br(),
            dropdownButton(label = "Post Operative", status = "default", width = 300,
                           checkboxGroupInput("checkGroup2",
                                              label = "select surgery procedures",
                                              choices = list(
                                                  "Cardiac Surgery: Congenital Defect Repair" = "CardiacSurgery.CongenitalDefectRepair",
                                                  "Cardiac Surgery: Miscellaneous" = "CardiacSurgery.Miscellaneous",
                                                  "Cardiorespiratory Support" = "CardiorespiratorySupport",
                                                  "Neuro Surgery" = "Neuro.Neurosurgical",
                                                  "Plastic Surgery" = "PlasticSurgery",
                                                  "Thoracic Surgery" = "ThoracicSurgery",
                                                  "Transplant Surgery" = "TransplantSurgery",
                                                  "Otorhinolaryngology" = "Otorhinolaryngology",
                                                  "Other Surgery" = "Surgical.Other"
                                              ),
                                              selected = NULL)),
            br(),
            dropdownButton(label = "Cardiac Catheterization", status = "default", width = 300,
                           checkboxGroupInput("checkGroup3",
                                              label = "select cardiac catheterization",
                                              choices = list(
                                                  "Cardiac Catheterization: Diagnostic" = "CardiacCatheterization.Diagnostic",
                                                  "Cardiac Catheterization: Therapeutic" = "CardiacCatheterization.Therapeutic"
                                              ),
                                              selected = NULL)),
            br(),
            dropdownButton(label = "Primary Admitting Diagnosis", status = "default", width = 300,
                           checkboxGroupInput("checkGroup4",
                                              label = "select primay admitting diagnosis",
                                              choices = list(
                                                  "Cardiovascular" = "Cardiovascular_primary",
                                                  "Endocrinologic" = "Endocrinologic_primary",
                                                  "Gastrointestinal" = "Gastrointestinal_primary",
                                                  "Genetic" = "Genetic_primary",
                                                  "Hematologic" = "Hematologic_primary",
                                                  "Immunologic" = "Immunologic_primary",
                                                  "Injury Poisoning Adverse Effects" = "Injury.Poisoning.Adverse.Effects_primary",
                                                  "Neurologic" = "Neurologic_primary",
                                                  "Oncologic" = "Oncologic_primary",
                                                  "Orthopedic" = "Orthopedic_primary",
                                                  "Renal Genitourinary" = "Renal.Genitourinary_primary",
                                                  "Transplant" = "Transplant_primary"
                                              ),
                                              selected = NULL)),
            br(),
            dropdownButton(label = "Medical History", status = "default", width = 300,
                           checkboxGroupInput("checkGroup5",
                                              label = "select medical history",
                                              choices = list(
                                                  "Cardiovascular" = "Cardiovascular_history",
                                                  "Dermatologic" = "Dermatologic_history",
                                                  "Endocrinologic" = "Endocrinologic_history",
                                                  "Gastrointestinal" = "Gastrointestinal_history",
                                                  "Genetic" = "Genetic_history",
                                                  "Hematologic" = "Hematologic_history",
                                                  "Immunologic" = "Immunologic_history",
                                                  "Infectious" = "Infectious_history",
                                                  "Metabolic" = "Metabolic_history",
                                                  "Orthopedic" = "Orthopedic_history",
                                                  "Psychiatric" = "Psychiatric_history",
                                                  "Respiratory" = "Respiratory_history",
                                                  "Transplant" = "Transplant_history"
                                              ),
                                              selected = NULL))
            
        ),
        
        mainPanel(
            h1("Result:"),
            h3(textOutput("text")),
            plotOutput("plot", width = '450px')
        )
    )
))