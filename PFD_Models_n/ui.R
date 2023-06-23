library(shiny)

shinyUI(navbarPage(h4("PFD Models:", style = "color:ForestGreen"),
                   tabPanel(h4("Before Delivery"),
                            headerPanel(h1("12 and 20 Year Risk of Pelvic Floor Disorders", style = "color:ForestGreen")),
                            sidebarLayout(
                              sidebarPanel(
                                h3("Risk Factors", style="color:ForestGreen"),
                                
                                h5("Maternal Age at Delivery", style="color:ForestGreen"),
                                sliderInput("Age.b", NULL, min=14, max=34, value=28),
                                
                                h5("Number of Previous Births", style = "color:ForestGreen"),
                                numericInput('parity_b', NULL, NULL, min=0, max=10),
                                
                                h5("Maternal Pre-Pregnancy Weight", style = "color:ForestGreen"),
                                numericInput('PrepregWeight_b', "(kilograms)", NULL, min=38, max=130),
                                h6("or"),
                                numericInput('PrepregWeight_lb_b', "(pounds)", NULL, min=83, 286),
                                
                                h5("Maternal Height", style="color:ForestGreen"),
                                numericInput('height.b', "(centimeters)", NULL, min=120, max=190),
                                h6("or"),
                                numericInput('height.ft.b', "(feet)", NULL, min=3, max=7),
                                numericInput('height.in.b', "(inches)", NULL, min=0, max=12),
                                
                                h5("Estimated Infant Birthweight", style = "color:ForestGreen"),
                                numericInput('BirthWeight.b', "(grams)", NULL, min=370, max=6000),
                                h6("or"),
                                numericInput('BirthWeight.p.b', "(pounds)", NULL, min=0, max=14),
                                numericInput('BirthWeight.o.b', "(ounces)", NULL, min=0, max=211),
                                
                                h5("Estimated Infant Head Circumference", style = "color:ForestGreen"),
                                numericInput('circumference.b', "(centimeters)", NULL, min=0, max=60),
                                
                                h5("Family History of POP", style="color:ForestGreen"),
                                selectInput("FH.POP.b", NULL, choices=list("No", "Yes")),
                                
                                h5("Family History of UI", style="color:ForestGreen"),
                                selectInput("FH.UI.b", NULL, choices=list("No", "Yes")),
                                
                                h5("Family History of FI", style="color:ForestGreen"),
                                selectInput("FH.FI.b", NULL, choices=list("No", "Yes")),
                                
                                h5("Pre-Pregnancy UI", style="color:ForestGreen"),
                                selectInput("uiprepreg.b", NULL, choices=list("No", "Yes")),
                                
                                h5("UI During Pregnancy", style="color:ForestGreen"),
                                selectInput("uiduringpreg.b", NULL, choices=list("No", "Yes"))
                              ),
                              mainPanel(
                                h2("Before Delivery", style = "color:Blue", align="center"),
                                h3("12-Year Risk for Women with Multiple Births"),
                                plotOutput("pred1", height="700px"),
                                h3("20-Year Risk for Women with First Birth"),
                                conditionalPanel(condition = "input.parity_b < 1",
                                                 plotOutput("pred1.5", height="700px")
                                  ),
                                conditionalPanel(condition = "input.parity_b >= 1",
                                                 h5("Not applicable for women who had previous births", style="color:Red")
                                  )
                                
                              )
                            )
                   ),
                   tabPanel(h4("After Delivery"),
                            headerPanel(h1("12 and 20 Year Risk of Pelvic Floor Disorders", style = "color:ForestGreen")),
                            sidebarLayout(
                              sidebarPanel(
                                h3("Risk Factors", style="color:ForestGreen"),
                                
                                h5("Maternal Age of Delivery", style="color:ForestGreen"),
                                sliderInput("Age", NULL, min=14, max=34, value=28),
                                
                                h5("Number of Previous Births", style = "color:ForestGreen"),
                                numericInput('parity', NULL, NULL, min=0, max=10),
                                
                                h5("Maternal Pre-Pregnancy Weight", style = "color:ForestGreen"),
                                numericInput('PrepregWeight', "(kilograms)", NULL, min=38, max=130),
                                h6("or"),
                                numericInput('PrepregWeight.lb', "(pounds)", NULL, min=83, max=286),
                                
                                h5("Maternal Height", style="color:ForestGreen"),
                                numericInput('height', "(centimeters)", NULL, min=120, max=190),
                                h6("or"),
                                numericInput('height.ft', "(feet)", NULL, min=3, max=7),
                                numericInput('height.in', "(inches)", NULL, min=0, max=12),
                                
                                h5("Infant Birthweight", style = "color:ForestGreen"),
                                numericInput('BirthWeight', "(grams)", NULL, min=370, max=6000),
                                h6("or"),
                                numericInput('BirthWeight.p', "(pounds)", NULL, min=0, max=14),
                                numericInput('BirthWeight.o', "(ounces)", NULL, min=13, max=60),
                                
                                h5("Infant Head Circumference", style = "color:ForestGreen"),
                                numericInput('circumference', "(centimeters)", NULL, min=0, max=60),
                                
                                h5("Family History of POP", style="color:ForestGreen"),
                                selectInput("FH.POP", NULL, choices=list("No", "Yes")),
                                
                                h5("Family History of UI", style="color:ForestGreen"),
                                selectInput("FH.UI", NULL, choices=list("No", "Yes")),
                                
                                h5("Family History of FI", style="color:ForestGreen"),
                                selectInput("FH.FI", NULL, choices=list("No", "Yes")),
                                
                                h5("Pre-Pregnancy UI", style="color:ForestGreen"),
                                selectInput("uiprepreg", NULL, choices=list("No", "Yes")),
                                
                                h5("UI During Pregnancy", style="color:ForestGreen"),
                                selectInput("uiduringpreg", NULL, choices=list("No", "Yes")),
                                
                                h5("Route of Delivery", style = "color:ForestGreen"),
                                selectInput('delmode2', NULL, choices=list("Vaginal", "C-Section")),
                                
                                h5("Epidural Used During Labor", style = "color:ForestGreen"),
                                selectInput('epidural', NULL, choices=list("No", "Yes")),
                                
                                h5("Episiotomy Performed", style = "color:ForestGreen"),
                                selectInput('Episiotomy', NULL, choices=list("No", "Yes")),
                                
                                h5("Induction Performed", style = "color:ForestGreen"),
                                selectInput('induction', NULL, choices=list("No", "Yes")),
                                
                                h5("2nd, 3rd, or 4th Degree Perineal Laceration Occurred", style = "color:ForestGreen"),
                                selectInput('Laceration', NULL, choices=list("No", "Yes")),
                                
                                h5("Twins", style="color:ForestGreen"),
                                selectInput("multiple", NULL, choices=list("No", "Yes")),
                                
                                h5("Time in Second Stage", style = "color:ForestGreen"),
                                numericInput('stage2', "(minutes)", NULL, min=0, max=500)
                                ),
                              mainPanel(
                                h2("After Delivery", style = "color:Blue", align="center"),
                                h3("12-Year Risk for Women with Multiple Births"),
                                plotOutput("pred2", height="700px"),
                                h3("20-Year Risk for Women with First Birth"),
                                
                                conditionalPanel(condition = "input.parity < 1",
                                                 plotOutput("pred2.5", height="700px")
                                ),
                                conditionalPanel(condition = "input.parity >= 1",
                                                 h5("Not applicable for women who had previous births", style="color:Red")
                                )
                                
                                )
                              )
                   )
))     