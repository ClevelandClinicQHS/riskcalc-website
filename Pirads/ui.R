library(shiny)

fluidPage(
    ### DEVELOPMENT INDICATION
    h3("Awaiting External Validation", style = "text-align: center; background-color: tomato; color: black"),  
  
    # Link to switch language between English and German
    actionLink("lang", langSwitch("Switch to German", "Switch to English"),
               #"primary","primary",
               icon = icon("world")),
    
    # Before seeing the calculator create disclaimer
        #conditionalPanel(condition="!input.goButton",#langSwitch(disclaimer_eng,disclaimer_ger),br(),
        #                 actionButton("goButton",div(langSwitch("Continue to Calculator","Weiter zum Risk Tool")),"primary","primary"),
        #br(),br(),br(), HTML("<footer> <p>Copyright © 2023 TUM</p></footer>")),
    
    # Create Sidebar to enter values
    conditionalPanel(
        condition="!input.goButton",
        conditionalPanel(
            condition="true",
            navbarPage(title = "TUM Risk Calculator (beta)",inverse = T,
                       footer = langSwitch(HTML("<br><footer>Here, <b>clinically significant prostate cancer (csPCa)</b> is defined as ISUP>2.<br><br>Clinically significant prostate cancer requiring active treatment may also be present in the case of ISUP 2 prostate cancer.</footer><br><footer>Copyright © 2023 TUM</footer>"),
                                           HTML("<br><footer>Die Definition von <b>klinisches signifikantes Prostatakarzinom (csPCa)</b> lautet in diesem Fall: ISUP>2.<br><br>Auch beim ISUP-2-Prostatakrebs kann ein klinisch bedeutsamer Prostatakrebs vorliegen, der einer aktiven Behandlung bedarf.</footer><br><footer>Copyright © 2023 TUM</footer>")),
                       tabPanel(langSwitch("Home","Home"),
                                sidebarLayout(
                                    sidebarPanel(
                                    h2(langSwitch("Characteristics","Charakteristiken")),
                                    # specify characteristics of patients that need to be entered
                                    numericInput("Age", langSwitch("Age","Alter"), NA, min = 55, max = 90),
                                    numericInput("PSA", "PSA [ng/ml]", NA, min = 0, max = 100),
                                    numericInput("Volume", langSwitch("Prostate volume [ml]","Prostata Volumen [ml]"), NA, min = 0, max = 100),
                                    checkboxInput("dpsa_avail", langSwitch("PSA density available?","PSA Dichte verfügbar?"),value=FALSE),
                                    conditionalPanel("input.dpsa_avail",numericInput("dpsa", langSwitch("PSA density","PSA Dichte"), NA, min = 0, max = 10)),
                                    selectInput("PIRADS", langSwitch("Pi-RADS score","Pi-RADS Level"), NA, selectize = F,choices = c("",1:5)),
                                    selectInput("priobiop", langSwitch("Prior prostate biopsy","Vorherige Prostatabiopsie"), selectize = F, choices = c("","Never had a prior biopsy", "Prior negative biopsy", "Prior positive biopsy")),
                                #    selectInput("priobiop", langSwitch("Prior biopsy","Vorherige negative Biopsie"), selectize = F, choices = langSwitch(c("","Never had a prior biopsy", "Prior negative biopsy", "Prior positive biopsy"),c("","Keine vorherige Prostate Biopsie", "Vorherige negative Prostate Biopsie", "Vorherige positive Prostate Biopsie"))),
                                    
                                    br(),
            
                                actionButton("calcRisk",langSwitch("Calculate Risk","Risiko berechnen"),"primary",c("btn-large", "meheh")),
                                uiOutput("switchTab2")),
        
                                # Main panel with results
                                mainPanel(
                                    tabPanel("Result",
                                                 conditionalPanel(
                                                     condition="input.calcRisk",
                                                     h2(langSwitch("Risk of csPCa diagnosis\nif biopsy were to be performed","Risiko einer csPCa Diagnose\nfalls eine Biopsie durchgeführt würde")),
                                                     htmlOutput("smile_en",inline = T),
                                                     br()
                                                 )
                                    )
                                )
                            ))
                       ,
                       tabPanel(langSwitch("About","Impressum"),langSwitch(about_eng,about_ger)),
                       tabPanel(langSwitch("Further information","Weitere Informationen"),langSwitch(info_eng,info_ger)),
                       tabPanel(langSwitch("Riskfactors","Risikofaktoren"),langSwitch(factors_eng,factors_ger))
                       #tabPanel(langSwitch("Further information","Weitere Informationen"),langSwitch(info_eng,info_ger))
                          
                    )
                )
            ) 
    
)

