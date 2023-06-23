
require(shinythemes)
library(shinyBS)

fluidPage(theme = shinytheme("flatly"),

          titlePanel('Anti-obesity Medications  - Predicting 12-Weeks Weight loss'),
          hr(),
          sidebarLayout(
              sidebarPanel(id = "sidebar",
                           textInput('Age', 'Age (Years)', placeholder = '18 - 90'),
                           selectInput('sex', 'Sex', choices = c('Female', 'Male')),
                           selectInput('Race', 'Race', choices = c('White', 'Black', 'Other')),
                           selectizeInput("NumberOfComorbidities", multiple = TRUE,
                                          "Obesity-related comorbidities (more than one answer may apply)",
                                          choices = c("Aortic aneurysm and dissection",
                                                      "Arterial embolism and thrombosis",
                                                      "Atheroembolism",
                                                      "Atherosclerosis",
                                                      "Carpal tunnel syndrome",
                                                      "Cerebrovascular diseases",
                                                      "Cholecystitis",
                                                      "Cholelithiasis",
                                                      "Chronic venous hypertension (idiopathic)",
                                                      "Disorders of lipoprotein metabolism and other lipidemias",
                                                      "Eating disorders",
                                                      "Fatty (change of) liver, not elsewhere classified",
                                                      "Gastro-esophageal reflux disease",
                                                      "Heart failure",
                                                      "Hypertensive diseases",
                                                      "Ischemic heart diseases",
                                                      "Major depressive disorder, recurrent",
                                                      "Major depressive disorder, single episode",
                                                      "Nonalcoholic steatohepatitis (NASH)",
                                                      "Osteoarthritis",
                                                      "Other anxiety disorders",
                                                      "Other hypothyroidism",
                                                      "Other pulmonary heart diseases",
                                                      "Other venous embolism and thrombosis",
                                                      "Persistent mood [affective] disorders",
                                                      "Phlebitis and thrombophlebitis",
                                                      "Polycystic ovarian syndrome",
                                                      "Pulmonary embolism",
                                                      "Sleep apnea",
                                                      "Type 2 diabetes mellitus",
                                                      "Varicose veins of lower extremities",
                                                      "Venous insufficiency (chronic) (peripheral)"),
                                          options = list('plugins' = list('remove_button'), 'create' = FALSE, 'persist' = FALSE)),
                           selectInput('T2D', "Type 2 diabetes", choices = c("No", "Yes")),
                           selectInput("SmokingStatus", "Smoking Status", choices = c("None Smoker", "Smoker")),
                           radioButtons("height_unit", "Height", c("Inch" = "inch","Meter" = "meter"), inline = T),
                           uiOutput("heightControls"),
                           radioButtons("weight_unit", "Weight", c("Pound" = "pound","Kilogram" = "kg"), inline = T),
                           uiOutput("weightControls")
                           
                           ),
              mainPanel(
                  tabsetPanel(
                      tabPanel("Result",
                               br(),
                               actionButton("goButton", "Run Calculator"),
                               br(),
                               hr(),
                               tags$head(
                                   tags$style(type="text/css", "tfoot {display:none;}")
                               ),
                               dataTableOutput('result'),
                               br(),
                               img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;")),
                      tabPanel("More Info",
                               br(),
                               p("This calculator can be used to help obese patients assess the estimated weight loss after taking 12 consecutive weeks of a prescription for either phentermine hydrochloride, phentermine-topiramate, bupropion naltrexone, or lorcaserin."))
                  ))))