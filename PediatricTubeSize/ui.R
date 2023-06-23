library(shinydashboard)

dashboardPage(
    skin = 'green',
    
    dashboardHeader(
        title = "Pediatric Respiratory Therapy",
        titleWidth = 300
    ),
    
    dashboardSidebar(
        width = 300,
        sidebarMenu(
            menuItem(tabName = "PICU", text = "Pediatric Calculations", icon = icon("user-md")),
            menuItem(tabName = "NICU", text = "Neonatal Calculations", icon = icon("child")),
            menuItem(tabName = "clinicalcal", text = "Clinical Calculations", icon = icon("plus-square")),
            menuItem(tabName = 'cylinder', text = 'Cylinder Duration', icon = icon("medkit"))
        )
    ),
    
    dashboardBody(
        tags$head(tags$style(HTML('.table-striped > tbody > tr:nth-child(2n+1) > td, .table-striped > tbody > tr:nth-child(2n+1) > th {
            background-color: #d7f3fa;
        }'))),
            
        tabItems(
            # Clinical calculation ------------------------------------------------
            tabItem(
                tabName = "clinicalcal",
                fluidRow(
                    box(
                        title = "Clinical Calculations",
                        status = 'primary',
                        collapsible = TRUE,
                        collapsed = FALSE,
                        # solidHeader = TRUE,
                        width = 12,
                        box(
                            #title = "OI Calculation",
                            status = 'info',
                            width = 6,
                            column(
                                width = 6, 
                                numericInput("MAP", "MAP: ", 20, min = 0, max = 100),
                                numericInput("FiO2", HTML("FiO<sub>2</sub>: "), 100, min = 0, max = 1000)
                            ),
                            column(
                                width = 6,
                                numericInput("PaO2", HTML("PaO<sub>2</sub>: "), 50, min = 0, max= 100)
                            ),
                            column(
                                width = 12,
                                align = "center",
                                valueBox(div(uiOutput("OICalculation"), style = "font-size:80%"), tags$p("OI Calculation", style='font-size:120%'), width = 12, color = 'aqua')
                            )
                        ),
                        box(
                            # title = "MAP Calculation",
                            status = 'info',
                            # solidHeader = TRUE,
                            width = 6,
                            column(
                                width = 6, 
                                numericInput("Freq", "Freq: ", 35, min = 0, max = 100),
                                numericInput("Ti", "Ti: ", 0.5, min = 0, max = 10, step = 0.1)
                            ),
                            column(
                                width = 6,
                                numericInput("PIP", 'PIP: ', 35, min = 0, max= 100),
                                numericInput("PEEP", 'PEEP: ', 8, min = 0, max= 100)
                            ),
                            column(
                                width = 12,
                                align = "center",
                                valueBox(div(uiOutput("MAPCalculation"), style = "font-size:80%"), tags$p("MAP Calculation", style='font-size:120%'), width = 12, color = 'aqua')
                            )
                        )
                    )
                )),
            # PICU calculation ----------------------------------------------------
            tabItem(
                tabName = "PICU",
                fluidRow(
                    box(
                        title = "PICU Airway/Ventilation Calculations",
                        status = 'primary',
                        collapsible = TRUE,
                        # solidHeader = TRUE,
                        width = 12,
                        fluidRow(
                            column(
                                width = 6, 
                                numericInput("Age", "Age/years: ", 4, min = 0, max = 100)
                            ),
                            column(
                                width = 6,
                                numericInput("Weight", "Weight/kg: ", 20, min = 0, max = 100)
                            )
                        ),
                        column(
                            width = 6,
                            box(
                                status = 'info',
                                title = "Information",
                                solidHeader = T,
                                width = 12,
                                tableOutput('PICUInfo')
                            )
                        ),
                        column(
                            width = 6,
                            box(
                                status = 'info',
                                title = "Vent Settings",
                                solidHeader = T,
                                width = 12,
                                tableOutput('PICUVent')
                            )
                        )
                    ),
                    box(
                        title = "Continuous Aerosol Treatment Calculations",
                        width = 12,
                        status = 'primary',
                        collapsible = TRUE,
                        column(
                            width = 6,
                            numericInput("albutoroldose", "Albuterol dose (mg/hour)", 15, min = 0, max = 1000)
                        ),
                        column(
                            width = 6,
                            numericInput('hour', "# of hours", 1, min = 0, max = 100, step = 0.5)
                        ),
                        box(
                            status = 'info',
                            width = 12,
                            tableOutput('aerosol')
                        )
                    )
                )   
            ),
            # NICU Airway and Ventilation Calculations ----------------------------
            tabItem(
                tabName = "NICU",
                fluidRow(
                    box(
                        title = "NICU Airway/Ventilation Calculations",
                        status = 'primary',
                        collapsible = TRUE,
                        # solidHeader = TRUE,
                        width = 12,
                        fluidRow(
                            column(
                                width = 6, 
                                numericInput("WeightNeo", "est. weight (grams): ", 500, min = 0, max = 10000)
                            ),
                            column(
                                width = 6,
                                numericInput("AgeNeo", "est. GA (weeks): ", 25, min = 0, max = 100)
                            )
                        ),
                        column(
                            width = 6,
                            box(
                                status = 'info',
                                title = "Information",
                                solidHeader = T,
                                width = 12,
                                tableOutput('NICUInfo')
                            )
                        ),
                        column(
                            width = 6,
                            box(
                                status = 'info',
                                title = "Vent settings",
                                solidHeader = T,
                                width = 12,
                                tableOutput('NICUVent')
                            )
                        )
                    )
                )
            ),
            # Cylinder Calculation Worksheet ----------------------------------
            tabItem(
                tabName = "cylinder",
                box(
                    title = "Cylinder Calculation Worksheet",
                    status = 'primary',
                    collapsible = TRUE,
                    # solidHeader = TRUE,
                    width = 12,
                    fluidRow(
                        column(
                            width = 6, 
                            numericInput("psig", "psig: ", 3600, min = 0, max = 10000)
                        ),
                        column(
                            width = 6,
                            numericInput("flow", "flow: ", 10, min = 0, max = 100)
                        )
                    ),
                    box(
                        status = 'info',
                        width = 12,
                        tableOutput('cylinder')
                    )
                ),
                box(
                    title = "Vapotherm Heliox Cylinder Duration ",
                    status = 'primary',
                    collapsible = TRUE,
                    # solidHeader = TRUE,
                    width = 12,
                    fluidRow(
                        column(
                            width = 6, 
                            numericInput("o2", HTML("O<sub>2</sub> Concentration (%): "), 21, min = 21, max = 100),
                            numericInput("vapo", "Vapotherm Flow (L/min): ", 4, min = 0, max = 40)
                        ),
                        column(
                            width = 6,
                            selectInput("CylinderType", "Cylinder Type: ", choices = c("T", "K")),
                            numericInput('CylinderPressure', "Cylinder Pressure (psi): ", 2000, min = 0, max = 2000)
                        )
                    ),
                    column(
                        width =  8,
                        offset = 2,
                        align = "center",
                        valueBox(
                            uiOutput('cylinderDuration'),
                            subtitle = "Cylinder duration time",
                            width = 12
                        )
                    )
                )
            ),
            # Vapotherm Heliox Cylinder Duration ------------------------------
            tabItem(
                tabName = "vapotherm"
            )
        )
    )
)
