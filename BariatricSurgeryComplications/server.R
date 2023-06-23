#Created: 2019-10-09
#Author: Alex Zajichek
#Project: Individualized Diabetes Complications Risk Scores
#Description: Carries out the functionality of the application

function(input, output, session) {
  
  #Function to compute eGFR
  eGFR <- 
    reactive(
      {
        186 * as.numeric(input$creatinine)^-1.154 * as.numeric(input$age)^-0.203 * ifelse(input$race == "Black", 1.212, 1.0) * ifelse(input$gender == "Female", 0.742, 1.0)
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
                "ACEInhibitors",
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
            as.numeric(input$age) >= 18 & as.numeric(input$age) <= 80,
            "Age must be between 18 and 80 years."
          ),
          need(
            as.numeric(input$bmi) >= 30 & as.numeric(input$bmi) <= 100,
            "BMI must be between 30 and 100 kg/m^2"
          ),
          need(
            as.numeric(input$a1c) >= 5 & as.numeric(input$a1c) <= 14,
            "HbA1c must be between 5 and 14 %"
          ),
          need(
            as.numeric(input$diastolic) >= 60 & as.numeric(input$diastolic) <= 120,
            "Diastolic blood pressure must be between 60 and 120"
          ),
          need(
            as.numeric(input$systolic) >= 90 & as.numeric(input$systolic) <= 210,
            "Systolic blood pressure must be between 90 and 210"
          ),
          need(
            as.numeric(input$creatinine) >= 0.5 & as.numeric(input$creatinine) <= 10,
            "Creatinine must be between 0.5 and 10 mg/dL"
          ),
          need(
            as.numeric(input$triglyceride) >= 50 & as.numeric(input$triglyceride) <= 2000,
            "Triglyceride must be between 50 and 2000 mg/dL"
          )
        )
        
        temp_frame <-
          data.frame(
            Age = as.numeric(input$age),
            Gender = factor(input$gender, levels = c("Male", "Female")),
            Race = factor(input$race, levels = c("White", "Black", "Other")),
            BMI = as.numeric(input$bmi),
            SmokingStatus = factor(input$smoking, levels = c("Never", "Quit", "Current")),
            A1C = as.numeric(input$a1c),
            Diastolic = as.numeric(input$diastolic),
            Systolic = as.numeric(input$systolic),
            Triglyceride = as.numeric(input$triglyceride),
            eGFR = eGFR(),
            medical_history(),
            current_medications()
          )
        temp_frame
      }
    )
  
  #Get current risks
  current_regression_preds <-
    reactive(
      {
        regression_risks(prediction_frame())
      }
    )
  
  #Display text when button pressed
  output$footnote <-
    eventReactive(
      input$run,
      {
        "The IDC Risk Scores provide personalized evidence-based risk information for patients with type 2 diabetes and obesity about future risk of cardiovascular outcomes and death, based on current status of obesity, diabetes, and related cardiometabolic conditions, with and without metabolic surgery."
      }
    )
  output$footnote2 <-
    eventReactive(
      input$run,
      {
        "*For the risk of Cerebrovascular Disease, since predictive models were not accurate, the cumulative incidences at 10-years are shown."
      }
    )
  
  #Display only when button is pressed
  showTable <- 
    eventReactive(
      input$run,
      {
        
        #Show CVD only if CAD>=6 OR CHF>=10
        current_CHF <- ifelse("HX_CHF" %in% input$hx_list, NA, current_regression_preds() %>% filter(Model == "No surgery", Outcome == "CHF") %>% pull(Risk))
        current_CAD <- ifelse("HX_CAD" %in% input$hx_list, NA, current_regression_preds() %>% filter(Model == "No surgery", Outcome == "CAD") %>% pull(Risk))
        current_CVD <- ifelse("HX_CVD" %in% input$hx_list, NA, 0.077)
        
        if(is.na(current_CHF) & is.na(current_CAD)) {
          current_CVD <- NA
        } else if((!is.na(current_CHF) & current_CHF >= .1) | ((!is.na(current_CAD) & current_CAD >= .06))) {
          current_CVD <- current_CVD
        } else {
          current_CVD <- NA
        }
          
        
        data.frame(
          Outcome = 
            c(
              "Mortality (all-cause)",
              "Heart Failure",
              "Coronary Heart Disease",
              "Diabetic Kidney Disease",
              "Cerebrovascular Disease (Stroke)*"
            ),
          Yes =
            c(
              current_regression_preds() %>% filter(Model == "Surgery", Outcome == "Death") %>% pull(Risk),
              ifelse("HX_CHF" %in% input$hx_list, NA, current_regression_preds() %>% filter(Model == "Surgery", Outcome == "CHF") %>% pull(Risk)),
              ifelse("HX_CAD" %in% input$hx_list, NA, current_regression_preds() %>% filter(Model == "Surgery", Outcome == "CAD") %>% pull(Risk)),
              ifelse("HX_Nephropathy" %in% input$hx_list | eGFR() < 60 | "HX_Dialysis" %in% input$hx_list, NA, current_regression_preds() %>% filter(Model == "Surgery", Outcome == "Nephropathy") %>% pull(Risk)),
              ifelse("HX_CVD" %in% input$hx_list, NA, 0.041)
            ),
          No =
            c(
              current_regression_preds() %>% filter(Model == "No surgery", Outcome == "Death") %>% pull(Risk),
              current_CHF,  
              current_CAD,
              ifelse("HX_Nephropathy" %in% input$hx_list | eGFR() < 60 | "HX_Dialysis" %in% input$hx_list, NA, current_regression_preds() %>% filter(Model == "No surgery", Outcome == "Nephropathy") %>% pull(Risk)),
              current_CVD
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
            `Risk after metabolic and bariatric surgery (%)` = Yes
          )
      }
    )
  
  output$table1 <-
    renderDataTable(
      {
        showTable() %>%
          datatable(
            options = 
              list(
                searching = FALSE,
                paging = FALSE,
                columnDefs = list(list(className = "dt-left", targets = 0), list(className = "dt-center", targets = 1:2)),
                info = FALSE
              ),
            rownames = FALSE,
            escape = F
          )
      }
    )
  
  output$reference <-
    renderText(
      {
        "Reference"
      }
    )
  output$reference_text <-
    renderText(
      {
        "[1] Aminian A, Zajichek A, Arterburn DE, Wolski KE, Brethauer SA, Schauer PR, Kattan MW, Nissen SE. Association of Metabolic Surgery With Major Adverse Cardiovascular Outcomes in Patients With Type 2 Diabetes and Obesity. JAMA. 2019;322:1271-1282"
      }
    )
  output$reference_text2 <-
    renderText(
      {
        "[2] Aminian A, Zajichek A, Arterburn DE, Wolski KE, Brethauer SA, Schauer PR, Nissen SE, Kattan MW. Predicting 10-Year Risk of End-Organ Complications of Type 2 Diabetes With and Without Metabolic Surgery: A Machine Learning Approach. Diabetes Care. 2020 Feb 6. pii: dc192057. doi: 10.2337/dc19-2057"
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
  
}