
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(
  fluidPage(    
    # include CSS
    includeCSS("riskcalc.css"),
    
    # Google Analytics
    JS_google_analytics,
    
    # Get user language
    JS_get_language,
    
    # Link to switch language between English and Spanish
    actionLink("lang", langSwitch("Switch to Spanish","Switch to English"),
               "primary","",icon = icon("gear")),
    tags$head(tags$link(rel="shortcut icon", href="../assets/icons/favicon.ico", type="image/x-icon")),
    tags$head(tags$link(rel="apple-touch-icon", href="../assets/icons/apple-touch-icon.png", type="image/x-icon")),
    
    
#     progressInit(),
    conditionalPanel(
      condition="!input.goButton",
      langSwitch(disclaimer_en,disclaimer_sp),
      br(),
      actionButton("goButton", 
                   div(langSwitch("Continue to Calculator","Continuar a la Calculadora")),
                   "primary","primary"),
      br(),br(),br(),
      
      #HTML("<span class = 'reference-text'>Reference: Ankerst DP, Hoefler J, Bock S, Goodman PJ, Vickers A, Hernandez J, Sokoll LJ, Sanda MG, Wei JT, Leach RJ, Thompson IM. The Prostate Cancer Prevention Trial Risk Calculator 2.0 for the prediction of low- versus high-grade prostate cancer. Urology 83(6): 1362-7, 2014.
      #     </span><p>"),
      br(),
      HTML("<footer> <p>Copyright © 2006 - 2018 UT Health San Antonio</p>
     </footer>")),
    
    
    conditionalPanel(
      condition="input.goButton",
      conditionalPanel(
        condition="true",
        navbarPage(title = "PCPT Risk Calculator",inverse = T,footer = HTML("<br><footer>Copyright © 2006 - 2018 UT Health San Antonio</footer>"),
                   tabPanel(langSwitch("Home","Inicio"),
                            
                            # Sidebar
                            sidebarLayout(
                              sidebarPanel(
                                h2(langSwitch("Characteristics","Características")),
                                selectInput("race", langSwitch("Race","Raza"), selectize = F,
                                            choices = c("","African American", "Caucasian", "Hispanic", "Other")),
                                numericInput("age", langSwitch("Age","Edad"), NA, min = 55.0, max = 90.0),
                                numericInput("psa", langSwitch("PSA [ng/ml]","Nivel de PSA [ng/ml]"), NA, min = 0, max = 50),
                                conditionalPanel("(input.famhist_avail%2) & (input.race=='Caucasian' | input.race=='Caucásico')",
                                                 selectInput("FDR_PC_less60", langSwitch("First degree relatives with prostate cancer younger than 60",
                                                                                         "Miembros de familia con cáncer de próstata diagnosticados antes de los 60 años de edad ")
                                                             ,selectize = F, choices = c("", "No", "Yes, one", "Yes, two or more")),
                                                 selectInput("FDR_PC_60", langSwitch("First degree relatives with prostate cancer older than 60",
                                                                                     "Miembros de familia con cáncer de próstata diagnosticados a los 60 años de edad o más"),
                                                             selectize = F,choices = c("", "No", "Yes, one", "Yes, two or more")),
                                                 selectInput("FDR_BC", langSwitch("First degree relatives with breast cancer","Miembros de familia con cáncer de mama "),
                                                             selectize = F,choices = c("", "No", "Yes, at least one")),
                                                 selectInput("SDR", langSwitch("Second degree relatives with prostate cancer", "Parientes con cáncer de próstata"),selectize = F,
                                                             choices = c("", "No", "Yes, at least one"))
                                ),
                                conditionalPanel("!((input.famhist_avail%2) & (input.race=='Caucasian' | input.race=='Caucásico'))",
                                                 selectInput("famhist", langSwitch("Family History of Prostate Cancer","Historia familiar de Cáncer de Próstata"),selectize = F,
                                                             choices = c("", "Yes", "No", "Do not know"))
                                ),
                                selectInput("dre", langSwitch("Digital rectal examination","Examen Rectal Digital"), selectize = F,
                                            choices = c("", "Abnormal", "Normal", "Not performed or not sure")),
                                selectInput("priobiop", langSwitch("Prior biopsy","Biopsia Prostática Previa"), selectize = F,
                                            choices = c("", "Never had a prior biopsy", "Prior negative biopsy", "Not sure")),
                                
                                # Percent free PSA available?            
                                checkboxInput("fpsa_avail", langSwitch("Percent free PSA available?","Porcentaje de PSA libre disponible?"),value=FALSE),
                                conditionalPanel("input.fpsa_avail",
                                                 numericInput("fpsa", langSwitch("Percent free PSA", "Porcentaje de PSA libre"), NA, min = 5, max = 75)),
                                # PSA3?
                                #conditionalPanel("!(input.fpsa_avail)",
                                checkboxInput("pca3_avail", langSwitch("PCA3 available?","PCA3 disponible?"),value=FALSE),#),
                                conditionalPanel("(input.pca3_avail)",
                                                 numericInput("pca_3", langSwitch("PCA3", "PCA3"), NA, min = 0.3, max = 332.5)),
                                                 
                                # PSA3 and T2ERG?
                                #conditionalPanel("!(input.fpsa_avail)",
                                checkboxInput("pca3_t2erg_avail", langSwitch("T2:ERG available?","T2:ERG disponible?"),value=FALSE),#),
                                conditionalPanel("input.pca3_t2erg_avail",
                                                 numericInput("t_2erg", langSwitch("T2ERG", "T2ERG"), NA, min = 0.0, max = 6031.6)),
                                                 
                                conditionalPanel("(input.snp_avail%2) & (input.race=='Caucasian' | input.race=='Caucásico')",
                                selectizeInput(
                                  'snps', 'Select up to 5 SNPs and their number of risk alleles', choices = snpdat$SNP,
                                  multiple = TRUE, options = list(maxItems = 5)),
                                uiOutput("snpsui")  
                                ),
                             
                                br(),
                                
                                
                                actionButton("calcRisk",langSwitch("Calculate Risk","Calcular el riesgo"),"primary",c("btn-large", "meheh")),
                                uiOutput("switchTab2"),
                                
                                # Some tooltips for the input fields
                                bsPopover(id = "age",title= "Age", content = tooltip_age_en, placement = "right", trigger = "hover"),
                                bsPopover(id = "psa", title = "PSA", content = tooltip_psa_en, placement = "right", trigger = "hover"),
                                bsPopover(id = "famhist", title = "Family Histpry", content = tooltip_famhist_en, placement = "right", trigger = "hover"),
                                bsPopover(id = "dre", title = "DRE", content = tooltip_dre_en, placement = "right", trigger = "hover"),
                                bsPopover(id = "priobiop", title ="Prior Biopsy", content = tooltip_priobiop_en, placement = "right", trigger = "hover"),
                                bsPopover(id = "fpsa", title = "Percent free PSA", content = tooltip_fpsa_en, placement = "right", trigger = "hover"),
                                # TODO
                                bsPopover(id = "FDR_PC_less60", title = "Detailed Family History", content = tooltip_FDR_PC_less60_en, placement = "right", trigger = "hover"),
                                bsPopover(id = "FDR_PC_60", title = "Detailed Family History", content = tooltip_FDR_PC_60_en, placement = "right", trigger = "hover"),
                                bsPopover(id = "FDR_BC", title = "Detailed Family History", content = tooltip_FDR_BC_en, placement = "right", trigger = "hover"),
                                bsPopover(id = "SDR", title = "Detailed Family History", content = tooltip_SDR_en, placement = "right", trigger = "hover")
                                
                              ),
                              
                              # Main panel with results
                              mainPanel(
                                tabsetPanel(
                                  tabPanel(langSwitch("Result","Resultado"),
                                           conditionalPanel(
                                             condition="input.calcRisk",
                                             h1(langSwitch("Risk of prostate cancer if biopsy were to be performed", 
                                                           "El riesgo de cáncer de la próstata si se procediera con una biopsia")),
                                             htmlOutput("smile_en",inline = T),
                                             #span(langSwitch("Please consult your physician concerning these results.", 
                                             #                 "Por favor, consulte con su médico acerca de estos resultados. ")),
                                             #br(),
                                             #span(langSwitch("Click","Haga")),actionLink("videoLink",langSwitch("here","“clic”"),inline=T),
                                             #span(langSwitch("to watch a video overview of these results.",
                                             #                "aquí para ver una presentación en video de estos resultados.")),
                                             br(),br(),
                                             conditionalPanel(
                                               condition="input.race=='Caucasian' | input.race=='Caucásico'",
                                               span(famhistSwitch (langSwitch("If you are Caucasian, click", "Si usted es de origen cáucaso, haga"),langSwitch("Click", "Haga")),
                                                    actionLink("famhist_avail", langSwitch("here", "“clic”")), inline = T), 
                                               langSwitch(span(famhistSwitch("for a new update to the PCPTRC that incorporates detailed family history into a risk of prostate cancer calculation.", "to go back to the original calculator."), inline=T),
                                                          span(famhistSwitch("aquí para una actualización del PCPTRC la cual incorpora un historial de familia detallado en el cálculo de su riesgo de cáncer de próstata.  ", 
                                                                             langSwitch("to go back to the original calculator.","aquí para volver a la calculadora originales.")), inline=T))
                                             ),
                                             br(),
                                             conditionalPanel(
                                               condition="input.race=='Caucasian' | input.race=='Caucásico'",
                                              span(
                                                span(snpSwitch (langSwitch("If you are Caucasian, click", "If you are Caucasian, click"),langSwitch("Click", "Click")),
                                                  actionLink("snp_avail", langSwitch("here", "here")), inline = T), 
                                             langSwitch(span(snpSwitch("for a research calculator that allows the incorporation of up to five single-nucleotide polymorphisms (SNP).", "to go back to the original calculator."), inline=T),
                                                        span(snpSwitch("for a research calculator that allows the incorporation of up to five single-nucleotide polymorphisms (SNP).", "to go back to the original calculator."), inline=T))
                                             )),
                         
                                             br(),br(),
                                             HTML("<a href='https://makelivesbetter.uthscsa.edu/sslpage.aspx?pid=543' target='_blank'><button id='donate' type='button' class='btn action-button btn-info info'>
                                                    Make a Gift to Support Prostate Cancer Research</button> </a>")
                                           )                                   
                                           
                                  ),
                                  
                                  #tabPanel(langSwitch("Video","Vídeo"), 
                                  #         # JS-Script for video play
                                  #         JS_video,
                                  #         
                                  #         h1(langSwitch("Explanation of the results","Explicación de los resultados")),
                                  #         HTML("<iframe width='640' height='480'
                                  #          src='https://www.youtube.com/embed/LZC1erZV5Gc'>
                                  #          </iframe>")
                                  #),
                                  
                                  tabPanel(langSwitch("More Information","Más información"),
                                           langSwitch(info_en,info_sp)
                                  )
                                )
                              )
                            )),
                   #tabPanel(langSwitch("News","Noticias"),
                   #         h1("News"),
                   #         news_en,
                   #         br(),br()),
                   tabPanel(langSwitch("Map","Mapa"),
                            stats_en),
                   # tabPanel(langSwitch("About","Sobre"),
                   #          about_en)
                   # tabPanel("PCPTRC 1.0 code",
                   # pcptrc1.0_en
                   # )   
                   navbarMenu("Add to phone",
                              tabPanel(title = HTML("<a href='https://support.apple.com/guide/iphone/bookmark-favorite-webpages-iph42ab2f3a7/ios#iph4f9a47bbc' target='_blank'>iOS (Safari)</li>")),
                              tabPanel(title = HTML("<a href='https://www.cnet.com/tech/mobile/adding-one-touch-bookmarks-to-your-androids-home-screen/' target='_blank'>Android</li>"))
                   )
        )
      )
    )
    
  )
)


