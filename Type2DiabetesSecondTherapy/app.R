library(shiny)
library(yonder)
library(shinyjs)
library(dplyr)
library(tidyr)
library(kableExtra)
library(ggradar)
library(radarchart)
source("./model.R")

medianincome = read.csv(file = "medianincome.csv", header = TRUE, colClasses = c("character", "numeric"))
adi = read.csv(file="adi.csv", header = T, colClasses = c("character", "numeric"))


ui <- container(
    useShinyjs(),
    tags$head(tags$link(rel="shortcut icon", href="../assets/icons/favicon.ico", type="image/x-icon")),
    tags$head(tags$link(rel="apple-touch-icon", href="../assets/icons/apple-touch-icon.png", type="image/x-icon")),
    h1("Decision-making tool of adding a second-line therapy to metformin for a patient with Type 2 DM") %>% margin(top=3, bottom=3),
    columns(
        column(
            width = c(md=4),
            card(
                header=navInput(
                    id = "tabs",
                    choices = c("Demographics", "Labs", "Medication history", "Medical history"),
                    values = c("Demographics", "Labs", "Medications", "Medical history"),
                    appearance = "pills", fill = TRUE
                ) %>% font(align="center", size = "lg", color = "white", weight = "bold") %>% 
                    display("flex") %>%
                    flex(wrap = TRUE),
                navContent(
                    navPane(
                        id="Demographics",
                        formGroup(label="Age (years)", textInput(id='Age', placeholder = "18-90")),
                        formGroup(label="Gender", selectInput(id="Gender", choices = c("Male", "Female"))),
                        formGroup(label="Race", selectInput(id='Race', choices = c("Caucasian", "Black", "Asian", "Other"))),
                        formGroup(label="Marital", selectInput(id='Marital', choices = c("Unmarried", "Divorced/Separated/Widow", "Married or domestic partner", "Other/Unknown"))),
                        formGroup(label="Insurance", selectInput(id='FinancialClass', c("Commercial", "Medicaid", "Medicare", "Other"))),
                        formGroup(label="ZIP code (optional)", textInput(id="zip", placeholder = "5 digits zip code")),
                        formGroup(label="Smoking history", selectInput(id='SmokingHistory', c("Never", "Current smoker", "Former smoker")))
                    ),
                    navPane(
                        id="Labs",
                        formGroup(label="HbA1c(%)", textInput(id='A1c', placeholder = "4-20")),
                        br(),
                        h6("Cholesterol levels (mg/dL)") %>% margin(bottom=1),
                        formRow(
                            formGroup(width=c(sm=6), label="LDL (mg/dL)", textInput(id='ldl', placeholder = "0 - 400")),
                            formGroup(width=c(sm=6), label="HDL (mg/dL)", textInput(id='hdl', placeholder = "0 - 400"))
                        ),
                        br(),
                        h6("Blood pressure (mm Hg)") %>% margin(bottom=1),
                        formRow(
                            formGroup(width=c(sm=6), label="Systolic", textInput(id='Systolic', placeholder = "70 - 240")),
                            formGroup(width=c(sm=6), label="Diastolic", textInput(id='Diastolic', placeholder = "60 - 140"))
                        ),
                        br(),
                        h6("Calculate Body Mass Index (BMI)") %>% margin(bottom=1),
                        radiobarInput(id="bmi_choice", choices = c("English", "Metric"), selected = "English") %>% margin(top=2, bottom=2) %>% background("grey") %>% font(weight="bold", color = "white"),
                        conditionalPanel(
                            condition = "input.bmi_choice == 'English'",
                            tags$div(
                                id="bmi_eng", 
                                p(id="height", "Height") %>% margin(top=1, bottom=1),
                                formRow(
                                    formGroup(width=c(sm=6), label=NULL, inline=T, groupTextInput(id='feet', right="feet")) %>% margin(0) %>% padding(right=0),
                                    formGroup(width=c(sm=6), label=NULL, inline=T, groupTextInput(id='inch', right="inches")) %>% margin(0) %>% padding(left=0)
                                ) %>% margin(top=-3, bottom=3),
                                formGroup(label="Weight", groupTextInput(id='lb', right="pounds"))
                            )
                        ),
                        conditionalPanel(
                            condition = "input.bmi_choice == 'Metric'",
                            tags$div(
                                id="bmi_metric", 
                                formGroup(label="Height", groupTextInput(id='meter', right="meters")),
                                formGroup(label="Weight", groupTextInput(id='kg', right="kilograms"))
                            )
                        )
                        
                    ),
                    navPane(
                        id="Medications",
                        formGroup(label="Minimum known time on Metformin (years)", textInput(id='TimeBetweenMetforminToSecond', placeholder = "0 - 10")),
                        formGroup(label="Statin", selectInput(id="Statin", choices = c("No", "Yes"))),
                        formGroup(label="Anti-Hypertension Medication during prior 1 year", 
                                  div(id='HTN.Med',
                                      shiny::selectizeInput(inputId="AntiHTN", label="", multiple=TRUE,selected = NULL,
                                                        options = list('plugins' = list('remove_button'),'create' = TRUE,'persist' = FALSE),
                                                        choices = c("Calcium Channel Blockers", "Methyldopa", "Beta Blockers", "Diuretics", "Clonidine", "AlphaBlockers", "Ace Inhibitors", "Mineralcorticoid Receptor Antagonists", "A2As", "ARBs"))
                                  ) %>% margin(top=-4))
                    ),
                    navPane(
                        id="Medical history",
                        formGroup(label="Heart disease", selectInput(id="HeartDisease", choices = c("No", "Yes"))),
                        formGroup(label="Heart failure", selectInput(id="HF", choices = c("No", "Yes"))),
                        formGroup(label="Dyslipidemia", selectInput(id="Dyslipidemia", choices = c("No", "Yes"))),
                        formGroup(label="Stroke", selectInput(id="Hx.stroke", choices = c("No", "Yes"))),
                        formGroup(label="Myocardial infarction", selectInput(id="Hx.MI", choices = c("No", "Yes"))),
                        formGroup(label="Hypertension", selectInput(id="Hx.HTN", choices = c("No", "Yes"))),
                        formGroup(label="History of Renal Impairment (2 times of eGFR <60)", selectInput(id="RF", choices = c("No", "Yes"))),
                        formGroup(label="Renal Failure", selectInput(id="Hx.RenalFailure", choices = c("No", "Yes")))
                    )
                )
            )
        ),
        column(
            width = c(md = 8),
            actionButton(inputId='run', label="Run Calculator") %>% background("indigo") %>% font(weight="bold", color = "white") %>% padding(top=2, bottom=2, left=3, right=3),
            #textOutput("print_choice"),
            card(
                header=p("Predicted 5-year risk of outcomes") %>% font(weight = "bold", align="center") %>% margin(top=0, bottom=0),
                shinyjs::hidden(div(id='running', img("busy.gif")) %>% font(align="center")),
                div(id='o', 
                    uiOutput("outcome"), 
                    chartJSRadarOutput("plot"))
            ) %>% margin(top = 3, bottom = 3),
            card(
                header = p("Disclaimer") %>% font(weight = "bold", align="center") %>% margin(top=0, bottom=0),
                p("No Medical Advice. ALTHOUGH SOME CONTENT MAY BE PROVIDED BY INDIVIDUALS IN THE MEDICAL PROFESSION, YOU ACKNOWLEDGE THAT PROVISION OF SUCH CONTENT DOES NOT CREATE A MEDICAL PROFESSIONAL-PATIENT RELATIONSHIP AND DOES NOT CONSTITUTE AN OPINION, MEDICAL ADVICE, PROFESSIONAL DIAGNOSIS, SERVICE OR TREATMENT OF ANY CONDITION. Access to general information is provided for educational purposes only, through this site and links to other sites. Content is not recommended or endorsed by any doctor or healthcare provider. The information and Content provided are not substitutes for medical or professional care, and you should not use the information in place of a visit, call, consultation or the advice of your physician or other healthcare provider. You are liable or responsible for any advice, course of treatment, diagnosis or any other information, services or product obtained through this site.")
            ) %>% margin(top = 3, bottom = 3),
            card(
                header = p("Reference") %>% font(weight = "bold", align="center") %>% margin(top=0, bottom=0),
                p("El Sanadi CE, Pantalone KM, Ji X, Kattan MW.", a("Development and Internal Validation of A Prediction Tool To Assist Clinicians Selecting Second-Line Therapy Following Metformin Monotherapy For Type 2 Diabetes.", href="https://pubmed.ncbi.nlm.nih.gov/33685669/"), "Endocr Pract. 2021 Apr;27(4):334-341. doi: 10.1016/j.eprac.2020.10.015. Epub 2020 Dec 15. PMID: 33685669.")
            ) %>% margin(top = 3, bottom = 3),
            p(
              a("Source Code", 
                href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/Type2DiabetesSecondTherapy", 
                style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
              ),
              style = "text-align: center;"
            )
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
    # left side nav pane toggle
    observeEvent(input$tabs, {
        showNavPane(input$tabs)
    })
    
    # bmi metric radiobutton
    # observeEvent(input$bmi_choice, {
    #     output$print_choice = renderText({input$bmi_choice})
    #     if (input$bmi_choice == "Metric"){
    #         shinyjs::hide(id = "bmi_eng")
    #         shinyjs::show(id = "bmi_metric")
    #     } else {
    #         shinyjs::show(id = "bmi_eng")
    #         shinyjs::hide(id = "bmi_metric")
    #     }
    # })
    
    # reactiveValues with output table 
    v = reactiveValues(res = NULL, rank=NULL, run = 0, dominated=NULL, chart = NULL)
    
    # hide outcome table if input changes
    observe({
        lapply(names(input)[names(input)!="run"], function(x) {
            observeEvent(input[[x]], {
                v$res=NULL
                v$rank = NULL
                v$run=0
                v$dominated = NULL
                shinyjs::hide("running")
                v$chart = NULL
            })
        })
    })
    observeEvent(input$run, {
        v$run=1
    })
    
    # calculate bmi
    bmi = reactive({
        if (input$bmi_choice == "English"){
            lb = as.numeric(regmatches(input$lb, regexpr("([0-9]*[.])?[0-9]+", input$lb)))
            feet = as.numeric(regmatches(input$feet, regexpr("([0-9]*[.])?[0-9]+", input$feet)))
            inch = as.numeric(regmatches(input$inch, regexpr("([0-9]*[.])?[0-9]+", input$inch)))

            feet = ifelse(length(is.na(feet))==0, 0, feet)
            inches = feet * 12 + ifelse(length(is.na(inch))==0, 0, inch)
            BMI = lb / (inches * inches) * 703
        } else if (input$bmi_choice == "Metric") {
            kg = as.numeric(regmatches(input$kg, regexpr("([0-9]*[.])?[0-9]+", input$kg)))
            meter = as.numeric(regmatches(input$meter, regexpr("([0-9]*[.])?[0-9]+", input$meter)))
            
            BMI = kg / (meter * meter)
        }
        validate(
            need(
                BMI > 10 & BMI < 60,
                paste("BMI must be between 0 and 60, current BMI is ", BMI)
            )
        )
        BMI
    })
    
    # get input data
    pred_data = reactive({
        validate(
            need(
                as.numeric(input$Age) >= 18 & as.numeric(input$Age) <= 90,
                "Age must be between 18 and 90 years."
            ),
            # need(
            #     nchar(input$zip) == 5 & !is.na(as.numeric(input$zip)),
            #     "Zip must be a 5-digits number."
            # ),
            # need(
            #     input$zip %in% adi$ZIP & input$zip %in% medianincome$ZIP,
            #     "Zip cannot be found from the 2013-2017 5-year American Community Survey (ACS)."
            # ),
            need(
                as.numeric(input$A1c) >= 4 & as.numeric(input$A1c) <= 20,
                "HbA1c must be between 4% and 20%"
            ),
            need(
                as.numeric(input$ldl) >= 0 & as.numeric(input$ldl) <= 400,
                "LDL must be between 0 and 400."
            ),
            need(
                as.numeric(input$hdl) >= 0 & as.numeric(input$hdl) <= 400,
                "HDL must be between 0 and 400."
            ),
            need(
                as.numeric(input$Systolic) >= 70 & as.numeric(input$Systolic) <= 240,
                "Systolic must be between 70 and 240."
            ),
            need(
                as.numeric(input$Diastolic) >= 60 & as.numeric(input$Diastolic) <= 140,
                "Diastolic must be between 60 and 140."
            ),
            need(
                as.numeric(input$TimeBetweenMetforminToSecond) >= 0 & as.numeric(input$TimeBetweenMetforminToSecond) <= 10,
                "Time from the initial Metformin must be between 0 and 10 years."
            )
        )
        if (input$bmi_choice == "English"){
            validate(
                need(
                    input$lb!="pounds",
                    "Weight is empty."
                ),
                need(
                    input$feet!="feet"|input$inch!="inches",
                    "Height is empty"
                )
            )
        } else {
            validate(
                need(
                    input$kg!="kilograms",
                    "Weight is empty."
                ),
                need(
                    input$meter!="meters",
                    "Height is empty"
                )
            )
        }
        Hx.HTN.Med = ifelse(is.null(input$AntiHTN), 0, length(input$AntiHTN))
        if (!is.null(input$zip)) {
            if (input$zip %in% adi$ZIP & input$zip %in% medianincome$ZIP) {
                MedianIncome = medianincome[medianincome$ZIP==input$zip,]$MedianIncome
                ADI = adi[adi$ZIP==input$zip,]$ADI
            } else {
                MedianIncome = 52665
                ADI = 99.3
            }
        } else {
            MedianIncome = 52665
            ADI = 99.3
        }
        temp_data = data.frame(
            Age = as.numeric(input$Age),
            Gender = input$Gender,
            Race = input$Race,
            Marital = input$Marital,
            FinancialClass = input$FinancialClass,
            SmokingHistory = input$SmokingHistory,
            A1c = as.numeric(input$A1c),
            LDL = as.numeric(input$ldl),
            HDL = as.numeric(input$hdl),
            Systolic = as.numeric(input$Systolic),
            Diastolic = as.numeric(input$Diastolic),
            TimeBetweenMetforminToSecond = as.numeric(input$TimeBetweenMetforminToSecond),
            Statin = ifelse(input$Statin=="Yes", 1, 0),
            HeartDisease = ifelse(input$HeartDisease=="Yes", 1, 0),
            HF = ifelse(input$HF=="Yes", 1, 0),
            Dyslipidemia = ifelse(input$Dyslipidemia=="Yes", 1, 0),
            Hx.Stroke = ifelse(input$Hx.stroke=="Yes", 1, 0),
            Hx.MI = ifelse(input$Hx.MI=="Yes", 1, 0),
            Hx.HTN = ifelse(input$Hx.HTN=="Yes"|Hx.HTN.Med>0, 1, 0),
            Hx.HTN.Med = Hx.HTN.Med,
            RF = ifelse(input$RF=="Yes", 1, 0),
            Hx.RenalFailure = ifelse(input$Hx.RenalFailure=="Yes", 1, 0),
            BMI = bmi(),
            MedianIncome = MedianIncome,
            ADI = ADI
            
        )
        temp_data
    })
    
    # calculate result
    output$outcome = renderText({
        if(v$run==1) {
            #shinyjs::show("running")
            pred_data = pred_data()
            if (nrow(pred_data) == 0) return()
            predicted_death = death(pred_data)
            predicted_stroke = stroke(pred_data)
            predicted_mi = mi(pred_data)
            predicted_htn = htn(pred_data)
            predicted_rf = rf(pred_data)
            output_data = data.frame(
                drug = c("DPP4","GLP1","SGLT2","SFU","TZD","Insulin"),
                death = c(as.character(predicted_death$df$dpp4),as.character(predicted_death$df$glp1),as.character(predicted_death$df$sglt2),as.character(predicted_death$df$sulf),as.character(predicted_death$df$thia),as.character(predicted_death$df$insulin)),
                #rank_death = c(predicted_death$rank_df$dpp4, predicted_death$rank_df$glp1, predicted_death$rank_df$sglt2,predicted_death$rank_df$sulf,predicted_death$rank_df$thia,predicted_death$rank_df$insulin),
                order_death = c(predicted_death$order_df$dpp4, predicted_death$order_df$glp1, predicted_death$order_df$sglt2,predicted_death$order_df$sulf,predicted_death$order_df$thia,predicted_death$order_df$insulin),
                stroke = c(as.character(predicted_stroke$df$dpp4),as.character(predicted_stroke$df$glp1),as.character(predicted_stroke$df$sglt2),as.character(predicted_stroke$df$sulf),as.character(predicted_stroke$df$thia),as.character(predicted_stroke$df$insulin)),
                #rank_stroke = c(predicted_stroke$rank_df$dpp4, predicted_stroke$rank_df$glp1, predicted_stroke$rank_df$sglt2,predicted_stroke$rank_df$sulf,predicted_stroke$rank_df$thia,predicted_stroke$rank_df$insulin),
                order_stroke = c(predicted_stroke$order_df$dpp4, predicted_stroke$order_df$glp1, predicted_stroke$order_df$sglt2,predicted_stroke$order_df$sulf,predicted_stroke$order_df$thia,predicted_stroke$order_df$insulin),
                mi = c(as.character(predicted_mi$df$dpp4),as.character(predicted_mi$df$glp1),as.character(predicted_mi$df$sglt2),as.character(predicted_mi$df$sulf),as.character(predicted_mi$df$thia),as.character(predicted_mi$df$insulin)),
                #rank_mi = c(predicted_mi$rank_df$dpp4, predicted_mi$rank_df$glp1, predicted_mi$rank_df$sglt2,predicted_mi$rank_df$sulf,predicted_mi$rank_df$thia,predicted_mi$rank_df$insulin),
                order_mi = c(predicted_mi$order_df$dpp4, predicted_mi$order_df$glp1, predicted_mi$order_df$sglt2,predicted_mi$order_df$sulf,predicted_mi$order_df$thia,predicted_mi$order_df$insulin),
                rf = c(as.character(predicted_rf$df$dpp4),as.character(predicted_rf$df$glp1),as.character(predicted_rf$df$sglt2),as.character(predicted_rf$df$sulf),as.character(predicted_rf$df$thia),as.character(predicted_rf$df$insulin)),
                #rank_rf = c(predicted_rf$rank_df$dpp4, predicted_rf$rank_df$glp1, predicted_rf$rank_df$sglt2,predicted_rf$rank_df$sulf,predicted_rf$rank_df$thia,predicted_rf$rank_df$insulin),
                order_rf = c(predicted_rf$order_df$dpp4, predicted_rf$order_df$glp1, predicted_rf$order_df$sglt2,predicted_rf$order_df$sulf,predicted_rf$order_df$thia,predicted_rf$order_df$insulin),
                htn = c(as.character(predicted_htn$df$dpp4),as.character(predicted_htn$df$glp1),as.character(predicted_htn$df$sglt2),as.character(predicted_htn$df$sulf),as.character(predicted_htn$df$thia),as.character(predicted_htn$df$insulin)),
                #rank_htn = c(predicted_htn$rank_df$dpp4, predicted_htn$rank_df$glp1, predicted_htn$rank_df$sglt2,predicted_htn$rank_df$sulf,predicted_htn$rank_df$thia,predicted_htn$rank_df$insulin),
                order_htn = c(predicted_htn$order_df$dpp4, predicted_htn$order_df$glp1, predicted_htn$order_df$sglt2,predicted_htn$order_df$sulf,predicted_htn$order_df$thia,predicted_htn$order_df$insulin),
                stringsAsFactors = F
            )
            output_data = output_data %>% 
                arrange(order_death, order_stroke, order_mi, order_rf, order_htn) 
            
            
            dominated = NULL;dominates=NULL
            for (i in c(6,5,4,3,2)) {
                for (j in c(1:(i-1))) {
                    if (all(output_data[i, c("order_death","order_stroke","order_mi","order_rf","order_htn")] >= output_data[j,c("order_death","order_stroke","order_mi","order_rf","order_htn")])) {
                        dominated = c(dominated, i+1)
                    }
                }
            }
            dominated = unique(dominated)
            if (output_data[1,c("order_death")] == min(output_data[,c("order_death")]) & output_data[1,c("order_stroke")] == min(output_data[,c("order_death")]) & output_data[1,c("order_mi")] == min(output_data[,c("order_mi")]) & output_data[1,c("order_rf")] == min(output_data[,c("order_rf")]) & output_data[1,c("order_htn")] == min(output_data[,c("order_htn")])) {
                dominates = 2
            }

            v$rank = output_data %>% select(drug,death,stroke,mi,rf,htn)
            v$dominated = dominated
            output_data = output_data %>% 
                # mutate(death = cell_spec(death, "html", background = factor(rank_death, c(5,4,3,2,1,0), c("#44970C", "#afa93a", "#FEE100", "#EC3017", "#cc0000", "#b60202"))),
                #        stroke = cell_spec(stroke, "html", background = factor(rank_stroke, c(5,4,3,2,1,0), c("#44970C", "#afa93a", "#FEE100", "#EC3017", "#cc0000", "#b60202"))),
                #        mi = cell_spec(mi, "html", background = factor(rank_mi, c(5,4,3,2,1,0), c("#44970C", "#afa93a", "#FEE100", "#EC3017", "#cc0000", "#b60202"))),
                #        rf = cell_spec(rf, "html", background = factor(rank_rf, c(5,4,3,2,1,0), c("#44970C", "#afa93a", "#FEE100", "#EC3017", "#cc0000", "#b60202"))),
                #        htn = cell_spec(htn, "html", background = factor(rank_htn, c(5,4,3,2,1,0), c("#44970C", "#afa93a", "#FEE100", "#EC3017", "#cc0000", "#b60202")))) %>% 
                select(drug, death, stroke, mi, rf, htn)
            rownames(output_data) = output_data$drug
            output_data$drug=NULL
            colnames(output_data) = c("Death", "Stroke", "MI", "Renal failure", "Hypertension")
            
            output_data = t(output_data) %>% 
                as.data.frame(., stringsAsFactors=F) %>% 
                knitr::kable("html", escape = F, align=c("l", "c", "c", "c", "c", "c", "c")) %>% 
                kable_styling(bootstrap_options = c("striped"), full_width = T, font_size =15) %>% 
                column_spec(1, bold = T) %>% 
                column_spec(dominated, color = "white", background = "black") %>% 
                footnote(general = "Drugs predicted to be inferior for all outcomes are displayed in gray shading in the table above and are also omitted from the spider plot displayed below.
                         DPP4: Dipeptidyl peptidase-4 inhibitor;
                         GLP1: Glucagon-like Peptide-1 agonist;
                         SGLT2: Sodium-Glucose Co-transporter 2 inhibitor;
                         SFU: Sulfonylurea; 
                         TZD: Thiazolidinedione;
                         Insulin: Insulin-Basal or Bolus or Mixed insulin")
            if (!is.null(dominates)) {
                output_data = output_data %>%                 
                    column_spec(dominates, background = "black")
            }
            v$res = output_data
        } 
        v$res
    })
    
    output$plot = renderChartJSRadar({
        if(v$run==1) {
            # delay(3000, validate(need(v$rank,"Please wait.")))
            rank_df = v$rank
            if (is.null(rank_df)) return()

            # rank_df = rank_df %>% 
            #     mutate(death = as.numeric(gsub("%", "", death)),
            #            stroke = as.numeric(gsub("%", "", stroke)),
            #            mi = as.numeric(gsub("%", "", mi)),
            #            rf = as.numeric(gsub("%", "", rf)),
            #            htn = as.numeric(gsub("%", "", htn))) %>% 
            #     filter(is.na(lag(death)) |
            #                (death < lag(death)) |
            #                (stroke < lag(stroke)) |
            #                (mi < lag(mi)) |
            #                (rf < lag(rf)) |
            #                (htn < lag(htn))) %>% 
            #     mutate(death =(death - min(death)),
            #            stroke = (stroke-min(stroke)),
            #            mi = (mi-min(mi)),
            #            rf = (rf-min(rf)),
            #            htn = (htn-min(htn))) %>% 
            #     mutate(death = case_when(is.na(death)~ 0,
            #                              death>5 ~ 5,
            #                              TRUE~death),
            #            stroke = case_when(is.na(stroke)~ 0,
            #                               stroke>5 ~ 5,
            #                               TRUE ~ stroke),
            #            mi = case_when(is.na(mi)~ 0,
            #                           mi > 5 ~ 5,
            #                           TRUE ~ mi),
            #            rf = case_when(is.na(rf)~0,
            #                           rf>5~5,
            #                           TRUE~rf),
            #            htn = case_when(is.na(htn)~ 0,
            #                            htn>5~5, 
            #                            TRUE ~htn))

            rank_df = rank_df %>% 
                mutate(death = as.numeric(gsub("<|%|>| ", "", death)),
                       stroke = as.numeric(gsub("<|%|>| ", "", stroke)),
                       mi = as.numeric(gsub("<|%|>| ", "", mi)),
                       rf = as.numeric(gsub("<|%|>| ", "", rf)),
                       htn = as.numeric(gsub("<|%|>| ", "", htn)))
            if (!is.null(v$dominated)) {
                rank_df = rank_df[setdiff(c(1:nrow(rank_df)),  (v$dominated-1)),]
            }
            colnames(rank_df) = c("Drug", "Death", "Stroke", "MI", "Renal failure", "HTN")

            a = t(rank_df[,c(2:6)])
            a = data.frame(a)
            colnames(a) = rank_df$Drug
            a$Label = c("Death", "Stroke", "MI", "Renal failure", "HTN")
            a = a[c(ncol(a), 1:nrow(rank_df))]
            shinyjs::hide("running")
            v$chart = chartJSRadar(a, showToolTipLabel=TRUE)
            #ggradar(rank_df, grid.min = 0, grid.max = max(rank_df[,c(2:ncol(rank_df))]), grid.mid = max(rank_df[,c(2:ncol(rank_df))])/2, values.radar = c('', '', ''))
        }
        v$chart
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
