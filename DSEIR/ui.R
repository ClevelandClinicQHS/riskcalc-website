library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(plotly)


ui <- dashboardPage(
  dashboardHeader(
    title =
      span(
        "Dynamic SEIR model for COVID-19 with multiple clinical stages",
        style = "color: #c6c8c8; font-size: 28px;font-weight:bold;"
      ),
    titleWidth = '100%'
  ),
  dashboardSidebar(
    width = 400,
    chooseSliderSkin('Nice', color = "#112446"),
    setSliderColor(rep("#f08122", 100), c(1:100)),
    #setSliderColor(c(rep("#b2df8a", 3)), sliderId=c(8,9,10)),
    h4("Set clinical parameters", style='font-style:italic;'),
    sliderInput(
      "DurIncub",
      "Average duration of incubation period",
      0,
      20,
      6.65,
      step = 0.5,
      post = " days"
    ),
    sliderInput(
      "DurMild",
      "Average duration from symptoms to hospital admission",
      0,
      20,
      14.47,
      step = 0.5,
      post = " days"
    ),
    sliderInput(
      "DurSevere",
      "Average duration from hospital admission to critical care",
      0,
      20,
      6.53,
      step = 0.5,
      post = " days"
    ),
    sliderInput(
      "DurICU",
      "Average duration from ICU admission to recover or die ",
      0,
      15,
      3.27,
      step = 0.5,
      post = " days"
    ),
    hr(),
    h4("Set related rates", style='font-style:italic;'),
    sliderInput("beta1", div(p(
      "Transmission rate (beta_m)"
    )), 0, 0.5, 0.0579, step = 0.001),
    sliderInput("beta2", div(p(
      "Transmission rate (beta_E)"
    )), 0, 2, 0.3495, step = 0.01),
    sliderInput("p1", div(p(
      "Rate of transfer (p_s)"
    )), 0, 0.1, 0.0002, step = 0.005),
    sliderInput("p2", div(p(
      "Rate of transfer (p_c)"
    )), 0, 0.2, 0.1009, step = 0.005),
    sliderInput("q1", div(p("Death rate (q_s)")), 0, 0.05, 0.0039, step =
                  0.001),
    sliderInput("q2", div(p("Death rate (q_c)")), 0, 0.25, 0.1745, step =
                  0.005),
    sliderInput("delta", div(p(
      "Rate of transfer (delta)"
    )), 0, 0.001, 1.35e-8, step = 1e-6),
    sliderInput("proportion", div(
      p(
        "Proportion of exposed individuals directly infected to severe infections"
      )
    ), 0, 1, 0.2242, step = 0.005),
    hr(),
    h4("Set simulation values", style='font-style:italic;'),
    sliderInput("LogN", div(p(
      "Total population size (log10)"
    )), 1, 9, 3, step = 0.1),
    htmlOutput("N"),
    br(),
    numericInput(
      "InitInf",
      "Initial numeber of infected indivials:",
      value = 1,
      min = 1,
      step = 1
    ),
    sliderInput(
      "Tmax",
      div(p("Maximum time")),
      0,
      1000,
      300,
      step = 10,
      post = " days"
    ),
    actionButton("reset", "Reset all")
    
  ),
  dashboardBody(
    tags$head(tags$style(
      HTML(
        '
        .content-wrapper { height: 4100px !important;}

        /* logo */
        .skin-blue .main-header .logo {
                              background-color: #0078bf;
                              }

        /* logo when hovered */
        .skin-blue .main-header .logo:hover {
                              background-color: #0078bf;
                              }

        /* navbar (rest of the header) */
        .skin-blue .main-header .navbar {
                              background-color: #0078bf;
                              }

        /* main sidebar */
        .skin-blue .main-sidebar {
                              background-color: #384d5f;
                              }

        /* active selected tab in the sidebarmenu */
        .skin-blue .main-sidebar .sidebar .sidebar-menu .active a{
                              background-color: #384d5f;
                              }

        /* other links in the sidebarmenu */
        .skin-blue .main-sidebar .sidebar .sidebar-menu a{
                              background-color: #384d5f;
                              color: #ffffff;
                              }

        /* other links in the sidebarmenu when hovered */
         .skin-blue .main-sidebar .sidebar .sidebar-menu a:hover{
                              background-color: #384d5f;
                              }
        /* toggle button when hovered  */
         .skin-blue .main-header .navbar .sidebar-toggle:hover{
                              background-color: #384d5f;
         }

        .navbar-default {
            background-color: #d3dee8 !important;
            color: black;
        }

	      .control-label {
		        font-size: 18px;
	      }

	      .irs-grid-text { font-size: 12pt; }
        .irs-min { font-size: 12pt; }
        .irs-max { font-size: 12pt; }

        .irs-single { font-size: 12pt; }
        .shiny-bound-input {font-size: 12pt;}
        .navbar .nav > li {font-size: 18pt;}
                              '
      )
    )),
    navbarPage(
      "Output:",
      
      tabPanel("Model", br(),
               fluidRow(
                 column(
                   12,
                   plotOutput("plot4", height = 340),
                   withMathJax(),
                   includeMarkdown("DSEIR.Rmd"),
                   #h3("Equations"),br(),
                   #helpText('An irrational number \\(\\sqrt{2}\\) and a fraction $$1-\\frac{1}{2}$$, $$a$$'),
                   #includeMarkdown("SEIR.Rmd"),
                   h3("Parameters of model"),
                   p(
                     HTML(
                       "These parameters can be changed using the sliders in the other tabs. The values in this table represent the current values chosen via the sliders."
                     )
                   ),
                   tableOutput("ParameterTable"),
                   br(),
                   br()
                 )
               )),
      
      tabPanel("Capacity",
               fluidPage(
                 fluidRow(
                   h3("COVID-19 Cases vs Healthcare Capacity"),
                   p(
                     HTML(
                       "Simulate predicted COVID-19 cases vs the capacity of the healthcare system to care for them. The care required depends on disease severity individuals with 'severe' patients require hospitalization and individuals with 'critical' symptoms often require ICU-level care and mechanical ventilation."
                     )
                   ),
                   plotlyOutput("plotCap"),
                   br(),
                   br(),
                   radioButtons(
                     "yscaleCap",
                     "Y axis scale:",
                     choices = list("Linear" = "linear", "Log10" = "log"),
                     inline = TRUE
                   ),
                   wellPanel(
                     h4(div(p(
                       "<em>Set healthcare capacity</em>"
                     ))),
                     p(
                       HTML(
                         " The default values are for the U.S. and details of their sources are given in the 'Default parameters' tab."
                       )
                     ),
                     #Sliders for hospital capacity are reactive, since they take in default values from a file, so they are defined in the server file.
                     fluidRow(
                       p(HTML(" <b> All hospital beds: </b>")),
                       column(width = 6,
                              uiOutput("HospBedper")),
                       column(width = 6,
                              uiOutput("HospBedOcc")),
                       p(HTML(" <b> ICU beds: </b>")),
                       column(width = 6,
                              uiOutput("ICUBedper")),
                       column(width = 6,
                              uiOutput("ICUBedOcc")),
                       column(width = 12,
                              uiOutput("IncFluOcc")),
                       p(HTML(" <b> Mechanical ventilators: </b>")),
                       column(width = 4,
                              uiOutput("ConvVentCap")),
                       column(width = 4,
                              uiOutput("ContVentCap")),
                       column(width = 4,
                              uiOutput("CrisisVentCap"))
                     )
                   ),
                   wellPanel(
                     h4(div(
                       p("<em>Set intervention parameters</em>")
                     )),
                     selectInput(
                       "VarShowCap",
                       label = "Select variable to show:",
                       choices = c(
                         "Critical Infections (I3) vs ICU beds" = "I3bed",
                         "Critical Infections (I3) vs ventilator capacity" = "I3mv",
                         "Severe + Critical Infections (I2+I3) vs Hospital Beds" = "Hosp",
                         "All symptomatic cases (I1+I2+I3) vs Hospital Beds" = "CasesCap"
                       ),
                       selected = c("Hosp")
                     ),
                     numericInput(
                       "Tint1C",
                       "Start time of Intervention 1 (days):",
                       value = 10,
                       min = 0,
                       step = 10
                     ),
                     numericInput(
                       "Tint2C",
                       "Start time of Intervention 2 (days):",
                       value = 30,
                       min = 0,
                       step = 10
                     ),
                     p(
                       HTML(
                         "<b>Intervention type: reducing transmission. </b> Transmission from exposed and mild infection individuals can be reduced if appropriate and effective interventions have been implemented, for example via social distancing (for exposed individuals) or quarantining in the community (for those with mild infection)."
                       )
                     ),
                     sliderInput(
                       "s1C",
                       "Reduction in transmission rate (beta_m and beta_E) after the implementation of Intervention 1 ",
                       0,
                       100,
                       10,
                       pre = "%",
                       step = 1,
                       animate = TRUE
                     ),
                     sliderInput(
                       "s2C",
                       "Reduction in transmission rate (beta_m and beta_E) after the implementation of Intervention 2  ",
                       0,
                       100,
                       50,
                       pre = "%",
                       step = 1,
                       animate = TRUE
                     ),
                     #sliderInput("s3C", "Reduction in transmission rate (critical infections) ", 0, 100, 0, pre="%",step=1, animate=TRUE),
                     radioButtons(
                       "RoundOneCap",
                       "Round values to nearest integar post-intervention?",
                       choices = list("True" = "True", "False" = "False"),
                       inline = TRUE
                     )
                   ),
                   p(
                     HTML(
                       "<b>User instructions:</b> The graph shows the expected numbers of individuals over time who are infected, recovered, susceptible, or dead over time, with and without an intervention. Infected individuals first pass through an exposed/incubation stage where they are asymptomatic but infectious, and then move into a symptomatic and infectious stage classified by the clinical status of infection (mild, severe, or critical). A more detailed description of the model is provided in the 'Model' tab. The population size, initial condition, and parameter values used to simulate the spread of infection can be specified through the sliders located in the left-hand panel. Default slider values are equal to estimates described in the 'Default parameters' tab. The strength and timing of the interventions are controlled by the sliders below the plot. The default setting is that the start time of intervention 1 should be earlier than that of intervention 2. If the slider sets time 1 later than time 2, the simulation result of the default setting will be displayed. If the two time points are the same, the simulation results displayed use a larger proportion of decline. To reset default values, click on the <em>Reset all</em> button located on the bottom of the panel. The plot is interactive: Hover over it to get values, double-click a curve in the legend to isolate it, or single-click to remove it. Dragging over a range allows zooming."
                     )
                   )
                 )
               )),
      
      tabPanel("Intervention",
               fluidPage(
                 fluidRow(
                   h3("Reduction in predicted COVID-19 after intervention"),
                   p(
                     HTML(
                       "Simulate the change in the time course of COVID-10 cases after applying an intervention."
                     )
                   ),
                   plotlyOutput("plotInt"),
                   br(),
                   br(),
                   radioButtons(
                     "yscaleInt",
                     "Y axis scale:",
                     choices = list("Linear" = "linear", "Log10" = "log"),
                     inline = TRUE
                   ),
                   wellPanel(
                     h4(div(
                       p("<em>Set intervention parameters</em>")
                     )),
                     selectInput(
                       "VarShowInt",
                       label = "Select variable to show:",
                       choices = c(
                         "Suceptible (S)" = "S",
                         "Exposed (E)" = "E",
                         "Mild Infections (I1)" = "I1",
                         "Severe Infections (I2)" = "I2",
                         "Critical Infections (I3)" = "I3",
                         "Recovered (R)" = "R",
                         "Population (N)" = "N",
                         "All infected (E+I1+I2+I3)" = "Inf",
                         "All symptomatic (I1+I2+I3)" = "Cases",
                         "All hospitalized (I2+I3)" = "Hosp"
                       ),
                       selected = c("Cases")
                     ),
                     numericInput(
                       "Tint1",
                       "Start time of Intervention 1 (days):",
                       value = 10,
                       min = 0,
                       step = 10
                     ),
                     numericInput(
                       "Tint2",
                       "Start time of Intervention 2 (days):",
                       value = 30,
                       min = 0,
                       step = 10
                     ),
                     p(
                       HTML(
                         "<b>Intervention type: reducing transmission. </b> Transmission from exposed and mild infection individuals can be reduced if appropriate and effective interventions have been implemented, for example via social distancing (for exposed individuals) or quarantining in the community (for those with mild infection)."
                       )
                     ),
                     sliderInput(
                       "s1",
                       "Reduction in transmission rate (beta_m and beta_E) after the implementation of intervention 1 ",
                       0,
                       100,
                       10,
                       pre = "%",
                       step = 1,
                       animate = TRUE
                     ),
                     sliderInput(
                       "s2",
                       "Reduction in transmission rate (beta_m and beta_E) after the implementation of intervention 2",
                       0,
                       100,
                       50,
                       pre = "%",
                       step = 1,
                       animate = TRUE
                     ),
                     #sliderInput("s3", "Reduction in transmission rate from critical infections", 0, 100, 0, pre="%",step=1, animate=TRUE),
                     radioButtons(
                       "RoundOne",
                       "Round values to nearest integar post-intervention?",
                       choices = list("True" = "True", "False" = "False"),
                       inline = TRUE
                     )
                   ),
                   p(
                     HTML(
                       "<b>User instructions:</b> The graph shows the expected numbers of individuals over time who are infected, recovered, susceptible, or dead over time, with and without an intervention. Infected individuals first pass through an exposed/incubation stage where they are asymptomatic but infectious, and then move into a symptomatic and infectious stage classified by the clinical status of infection (mild, severe, or critical). A more detailed description of the model is provided in the 'Model' tab. The population size, initial condition, and parameter values used to simulate the spread of infection can be specified through the sliders located in the left-hand panel. Default slider values are equal to estimates described in the 'Default parameters' tab. The strength and timing of the interventions are controlled by the sliders below the plot. The default setting is that the start time of intervention 1 should be earlier than that of intervention 2. If the slider sets time 1 later than time 2, the simulation result of the default setting will be displayed. If the two time points are the same, the simulation results displayed use a larger proportion of decline. To reset default values, click on the <em>Reset all</em> button located on the bottom of the panel. The plot is interactive: Hover over it to get values, double-click a curve in the legend to isolate it, or single-click to remove it. Dragging over a range allows zooming."
                     )
                   )
                 )
               )),
      
      tabPanel("Spread",
               fluidPage(
                 fluidRow(
                   h3("Predicted COVID-19 cases by clinical outcome"),
                   p(
                     HTML(
                       "Simulate the natural course of a COVID-19 epidemic in a single population without any interventions."
                     )
                   ),
                   
                   plotlyOutput("plot0"),
                   br(),
                   radioButtons(
                     "yscale",
                     "Y axis scale:",
                     choices = list("Linear" = "linear", "Log10" = "log"),
                     inline = TRUE
                   ),
                   p(
                     HTML(
                       "<b>User instructions:</b> The graph shows the expected numbers of individuals over time who are susceptible, exposed, infected, recovered or dead over time. Infected individuals first pass through an exposed/incubation stage where they are asymptomatic but infectious, and then move into a symptomatic and infection stage classified by the clinical status of infection (mild, severe, or critical). A more detailed description of the model is provided in the 'Model' tab. The population size, initial condition, and parameter values used to simulate the spread of infection can be specified through the sliders located in the left-hand panel. Default slider values are equal to estimates described in the 'Default parameters' tab. To reset default values, click on the <em>Reset all</em> button located on the bottom of the panel. The plot is interactive: Hover over it to get values, double-click a curve in the legend to isolate it, or single-click to remove it. Dragging over a range allows zooming."
                     )
                   ),
                   p(
                     HTML(
                       "<b>Tips:</b> If there is an abnormal curve in the graph (such as the curve R which represents the recovered individuals shows some negative values), it means that the clinical parameters and related rates specified through the sliders located in the left-hand panel no longer meet the relationships introduced in the subsection of 'Relating clinical observations to model parameters' in 'Model' tab."
                     )
                   )
                   
                 )
               )),
      
      
      tabPanel("Default parameters",
               fluidPage(br(),
                         uiOutput("parameterDesc")))
    )
    
  )
  
)
