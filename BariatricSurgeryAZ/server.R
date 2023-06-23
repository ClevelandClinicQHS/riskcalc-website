#Created: 2019-05-13
#Author: Alex Zajichek
#Project: Individualized Diabetes Complications Risk Scores
#Description: Carries out the functionality of the application

function(input, output, session) {
  useShinyjs(html = TRUE)
  #Function to compute eGFR
  eGFR <- 
    reactive(
      {
        186 * input$creatinine^-1.154 * input$age^-0.203 * ifelse(input$race == "Black", 1.212, 1.0) * ifelse(input$gender == "Female", 0.742, 1.0)
      }
    )
  
  #Gather current medical history
  medical_history <-
    reactive(
      {
        
        #Make default frame
        temp_dat <-
          data.frame(
            Variable = 
              paste0(
                "HX_",
                c(
                  "CAD",
                  "CVD",
                  "COPD",
                  "DiabeticNeuropathy",
                  "Dialysis",
                  "Dyslipidemia",
                  "CHF",
                  "Nephropathy",
                  "Hypertension",
                  "PAD"
                )
              )
          )
        
        #Change status
        temp_dat$Value <- ifelse(temp_dat$Variable %in% input$hx_list, "Yes", "No")
        
        #Spread to columns
        tidyr::spread(
          temp_dat,
          key = "Variable",
          value = "Value"
        ) %>%
          dplyr::mutate_all(
            factor,
            levels =
              c(
                "No",
                "Yes"
              )
          )
        
      }
    )
  
  #Gather current medication list
  current_medications <-
    reactive(
      {
        
        #Make default frame
        temp_dat <-
          data.frame(
            Variable = 
              c(
                "ACEInhibitorsARBS",
                "OtherAntihypertensives",
                "Aspirin",
                "CholesterolLowering",
                "Insulin",
                "NonInsulinDiabetesMedication",
                "Warfarin"
              )
          )
        
        #Change status
        temp_dat$Value <- ifelse(temp_dat$Variable %in% input$med_list, "Yes", "No")
        
        #Spread to columns
        tidyr::spread(
          temp_dat,
          key = "Variable",
          value = "Value"
        ) %>%
          dplyr::mutate_all(
            factor,
            levels =
              c(
                "No",
                "Yes"
              )
          )
        
      }
    )
  
  #Make a frame of current prediction data
  prediction_frame <-
    reactive(
      {
        
        #Check for valid values
        validate(
          need(
            input$age >= 18 & input$age <= 80,
            "Age must be between 18 and 80 years."
          )
        )

        temp_frame <-
          data.frame(
            Age = input$age,
            Gender = factor(input$gender, levels = c("Male", "Female")),
            Race = factor(input$race, levels = c("White", "Black", "Other")),
            BMI = input$bmi,
            SmokingStatus = factor(input$smoking, levels = c("Never", "Quit", "Current")),
            A1C = input$a1c,
            Diastolic = input$diastolic,
            Systolic = input$systolic,
            Triglyceride = input$triglyceride,
            eGFR = eGFR(),
            medical_history(),
            current_medications()
          )
      }
    )
  
  v = reactiveValues(data = NULL)

  observeEvent(
    input$run,
    {
      shinyjs::show(id="running")
      shinyjs::hide(id="outcome")
      shinyjs::disable(id="run")
      shinyjs::disable(id="tabs")
      prediction_frame = prediction_frame()
      preds = regression_risks(prediction_frame)
      v$data = data.frame(
        Outcome = 
          c(
            "All-cause mortality",
            "Coronary artery disease",
            "Heart failure",
            "Cerebrovascular disease",
            "Nephropathy"
          ),
        Yes =
          c(
            preds %>% filter(Model == "Surgery", Outcome == "Death") %>% pull(Risk),
            ifelse("HX_CAD" %in% input$hx_list, NA, preds %>% filter(Model == "Surgery", Outcome == "CAD") %>% pull(Risk)),
            ifelse("HX_CHF" %in% input$hx_list, NA, preds %>% filter(Model == "Surgery", Outcome == "CHF") %>% pull(Risk)),
            ifelse("HX_CVD" %in% input$hx_list, NA, predict_cvd_rf_10year(prediction_frame)),
            ifelse("HX_Nephropathy" %in% input$hx_list, NA, preds %>% filter(Model == "Surgery", Outcome == "Nephropathy") %>% pull(Risk))
          ),
        No =
          c(
            preds %>% filter(Model == "No surgery", Outcome == "Death") %>% pull(Risk),
            ifelse("HX_CAD" %in% input$hx_list, NA, preds %>% filter(Model == "No surgery", Outcome == "CAD") %>% pull(Risk)),
            ifelse("HX_CHF" %in% input$hx_list, NA, preds %>% filter(Model == "No surgery", Outcome == "CHF") %>% pull(Risk)),  
            ifelse("HX_CVD" %in% input$hx_list, NA, preds %>% filter(Model == "No surgery", Outcome == "CVD") %>% pull(Risk)),
            ifelse("HX_Nephropathy" %in% input$hx_list | eGFR() < 60 | "HX_Dialysis" %in% input$hx_list, NA, preds %>% filter(Model == "No surgery", Outcome == "Nephropathy") %>% pull(Risk))
          )
      ) %>%
        na.omit %>%
        mutate(
          Yes = 
            case_when(
              Yes > No ~ paste0("<p>", round(Yes*100, 1), "&#x2191;</p>"),
              TRUE ~ paste0("<p>", round(Yes*100, 1), "&#x2193;</p>")
            ),
          No = as.character(round(No*100, 1))
        ) %>%
        select(
          Complication = Outcome,
          `Current risk (%)` = No,
          `Risk after bariatric surgery (%)` = Yes
        )
      shinyjs::hide("running")
      shinyjs::show("outcome")
      shinyjs::enable(id="run")
      shinyjs::enable(id="tabs")
    }
  )

  output$table1 <-
    DT::renderDataTable(
      {
        if (is.null(v$data)) return()
        
        isolate({output = v$data %>%
          datatable(
            options = 
              list(
                searching = FALSE,
                paging = FALSE,
                columnDefs = list(list(className = "dt-center", targets = "_all")),
                info = FALSE
              ),
            rownames = FALSE,
            escape = F
          )})
        
        return(output)
      }
    )
  
  output$reference <-
    renderText(
      {
        "Reference"
      }
    )
  output$disclaimer <-
    renderText(
      {
        "Disclaimer"
      }
    )
  output$disclaimer_text <-
    renderText(
      {
        "No Medical Advice. ALTHOUGH SOME CONTENT MAY BE PROVIDED BY INDIVIDUALS IN THE MEDICAL PROFESSION, YOU ACKNOWLEDGE THAT PROVISION OF SUCH CONTENT DOES NOT CREATE A MEDICAL PROFESSIONAL-PATIENT RELATIONSHIP AND DOES NOT CONSTITUTE AN OPINION, MEDICAL ADVICE, PROFESSIONAL DIAGNOSIS, SERVICE OR TREATMENT OF ANY CONDITION. Access to general information is provided for educational purposes only, through this site and links to other sites. Content is not recommended or endorsed by any doctor or healthcare provider. The information and Content provided are not substitutes for medical or professional care, and you should not use the information in place of a visit, call, consultation or the advice of your physician or other healthcare provider. You are liable or responsible for any advice, course of treatment, diagnosis or any other information, services or product obtained through this site."
      }
    )
  
  observeEvent(input$tabs, {
    showNavPane(input$tabs)
  })
}
