pred_test <- expression({
  lp <- -6.8314047 + 0.95506387 * (Race == "Black") - 0.13615823 * 
    (Race == "Other") + 0.27706313 * (Race == "White") - 
    0.57047701 * (Ethnicity == "Non-Hispanic") - 0.48561286 * 
    (Ethnicity == "Unknown") + 1.1062719 * (Smoking == "Former Smoker") + 
    1.2742523 * (Smoking == "No") + 1.4887334 * (Smoking == "Unknown") + 
    0.039720118 * age - 6.0027158e-06 * max(age - 21.99281, 0)**3 + 1.1917031e-05 * max(age - 47.97014, 0)**3 - 
    5.9143153e-06 * max(age - 74.33575, 0)**3 - 0.0079035012 * 
    pre_testing_platelets + 5.1614672e-07 * max(pre_testing_platelets - 198, 0)**3 - 
    9.7619054e-07 * max(pre_testing_platelets - 239, 0)**3 + 4.6004382e-07 * max(pre_testing_platelets - 285, 0)**3 + 
    0.11621071 * pre_testing_ast - 0.0012138332 * 
    max(pre_testing_ast - 20, 0)**3 + 0.0024276664 * max(pre_testing_ast - 24, 0)**3 - 
    0.0012138332 * max(pre_testing_ast - 28, 0)**3 - 0.038364194 * pre_testing_chloride + 0.0049505418 * 
    pre_testing_creatinine + 0.042078588 * pre_testing_hematocrit - 
    0.13210575 * pre_testing_potassium + 0.33334605 * PopulationPerSqKm + 
    0.0086756173 * MedianIncome - 6.4128686e-07 * max(MedianIncome - 28.418, 0)**3 + 
    1.0668967e-06 * max(MedianIncome - 58.5, 0)**3 - 4.2560983e-07 * max(MedianIncome - 103.826, 0)**3 + 
    0.012286021 * BMI - 2.5859868e-05 * max(BMI - 22.33501, 0)**3 + 
    4.4969304e-05 * max(BMI - 28.53731, 0)**3 - 1.9109436e-05 * 
    max(BMI - 36.93058, 0)**3 + 0.50099021 * (Gender == "Male") + 
    0.58864438 * Cough + 0.32981944 * Expose_to_covid_19 + 
    0.64273098 * Family_covid_19 + 0.79436538 * Fever + 0.37271441 * 
    Fatigue - 0.14264686 * Sputum_production + 0.41643274 * 
    Flu_like_symptoms + 0.30767382 * Diarrhea + 0.55731252 * 
    Loss_of_appetite - 1.1005449 * Vomiting - 0.20225055 * 
    Asthma - 0.2915762 * Coronary_artery_disease - 0.087412581 * 
    Cancer - 0.031237669 * Immunosuppressive_treatment - 
    0.11542716 * Transplant_history - 0.3308003 * Connective_tissue_disease - 
    0.034007181 * Ibd - 0.45654051 * Flu_shot - 0.034966535 * 
    Pneumovax_shot - 0.11893737 * nsaids - 0.3790772 * steroids - 
    0.1129015 * carvedilol - 0.14115996 * ace_inhibitor + 
    0.073490518 * arb - 0.33749904 * melatonin
  p = 1/(1+exp(-lp))
  p = -2.600269 + 43.152139 * p
  1/(1+exp(-p))
})


server = function(input, output, session){
  # data <- eventReactive(input$goButton, {
  #     
  #     data})
  # 
  
  observeEvent(input$goButton, {
    
    if (input$age <3 | input$age > 60 | 
        (!is.null(input$risk) & any(c("Expose_to_covid_19", "Flu_like_symptoms", 'Cough', "Fever") %in% input$risk)) |
        (!is.null(input$comorbidities) & any(c("Cancer", "Diabetes", "Coronary_artery_disease","Heart_failure","Asthma", "Transplant_history") %in% input$comorbidities)) |
        (!is.null(input$medications) & any(c("Immunosuppressive_treatment") %in% input$medications))) {
      shinyjs::show("result_panel")
      shinyjs::hide("thankyou")
      shinyjs::hide("followup_panel")
    } else {
      shinyjs::hide("result_panel")
      shinyjs::hide("thankyou")
      shinyjs::show("followup_panel")
    }
  })
  observeEvent(input$submit, {
    if ("9" %notin% input$followup) {
      shinyjs::show("result_panel")
      shinyjs::hide("thankyou")
      shinyjs::hide("followup_panel")
    } else {
      shinyjs::hide("result_panel")
      shinyjs::show("thankyou")
      shinyjs::hide("followup_panel")
    }
  })
  
  observeEvent({list(input$age,input$Gender,input$Race, input$Ethnicity, input$medications, 
                     input$BMI, input$geo, input$ZIP, 
                     input$risk, input$comorbidities,
                     input$Smoking, input$flu_shot,input$pneumovax_shot,
                     input$platelets, input$pre_testing_platelets,
                     input$chloride, input$pre_testing_chloride,
                     #input$bun, input$pre_testing_bun,
                     input$creatinine, input$pre_testing_creatinine,
                     input$ast, input$pre_testing_ast,
                     input$hematocrit, input$pre_testing_hematocrit,
                     input$potassium, input$pre_testing_potassium)},
               {
                 shinyjs::hide("result_panel")
                 shinyjs::hide("followup_panel")
                 shinyjs::hide("thankyou")
               })
  
  data <- eventReactive(input$goButton,{
    age = input$age
    Race = input$Race
    Ethnicity = input$Ethnicity
    Gender = input$Gender
    Smoking = input$Smoking
    BMI = input$BMI
    if (input$geo == 1 & input$ZIP %in% zip_data$ZIP) {
      MedianIncome = zip_data$MedianIncome[zip_data$ZIP == input$ZIP] / 1000
      PopulationPerSqKm = log10(zip_data$PopulationPerSqKm[zip_data$ZIP == input$ZIP]+1)
    } else if (input$geo == 2 & input$GEOID %in% tract_data$GEOID) {
      MedianIncome = tract_data$MedianIncome[tract_data$GEOID == input$GEOID] / 1000
      PopulationPerSqKm = log10(tract_data$PopulationPerSqKm[tract_data$GEOID == input$GEOID]+1)
    } else {
      MedianIncome = 56.101
      PopulationPerSqKm = 3.065953
    }
    Expose_to_covid_19 = ifelse(!is.null(input$risk) & "Expose_to_covid_19" %in% input$risk, T, F) 
    Family_covid_19 = ifelse(!is.null(input$risk) & "Family_covid_19" %in% input$risk, T, F) 
    Cough = ifelse(!is.null(input$risk) & "Cough" %in% input$risk, T, F)  
    Fever = ifelse(!is.null(input$risk) & "Fever" %in% input$risk, T, F)  
    Fatigue = ifelse(!is.null(input$risk) & "Fatigue" %in% input$risk, T, F)  
    Sputum_production = ifelse(!is.null(input$risk) & "Sputum_production" %in% input$risk, T, F)  
    Flu_like_symptoms = ifelse(!is.null(input$risk) & "Flu_like_symptoms" %in% input$risk, T, F)  
    #Sob = ifelse(!is.null(input$risk) & "Sob" %in% input$risk, T, F)
    Diarrhea = ifelse(!is.null(input$risk) & "Diarrhea" %in% input$risk, T, F)
    Loss_of_appetite = ifelse(!is.null(input$risk) & "Loss_of_appetite" %in% input$risk, T, F)  
    Vomiting = ifelse(!is.null(input$risk) & "Vomiting" %in% input$risk, T, F)
    #Copd_emphysema = ifelse(!is.null(input$comorbidities) & "Copd_emphysema" %in% input$comorbidities, T, F)
    Asthma = ifelse(!is.null(input$comorbidities) & "Asthma" %in% input$comorbidities, T, F)
    Hypertension = ifelse(!is.null(input$comorbidities) & "Hypertension" %in% input$comorbidities, T, F)
    Diabetes = ifelse(!is.null(input$comorbidities) & "Diabetes" %in% input$comorbidities, T, F)
    Transplant_history = ifelse(!is.null(input$comorbidities) & "Transplant_history" %in% input$comorbidities, T, F)
    Coronary_artery_disease = ifelse(!is.null(input$comorbidities) & "Coronary_artery_disease" %in% input$comorbidities, T, F)
    Cancer = ifelse(!is.null(input$comorbidities) & "Cancer" %in% input$comorbidities, T, F)
    Multiple_sclerosis = ifelse(!is.null(input$comorbidities) & "Multiple_sclerosis" %in% input$comorbidities, T, F)
    Connective_tissue_disease = ifelse(!is.null(input$comorbidities) & "Connective_tissue_disease" %in% input$comorbidities, T, F)
    Immunosuppressive_disease = ifelse(!is.null(input$comorbidities) & "Immunosuppressive_disease" %in% input$comorbidities, T, F)
    Ibd = ifelse(!is.null(input$comorbidities) & "Ibd" %in% input$comorbidities, T, F)
    Immunosuppressive_disease = ifelse(!is.null(input$comorbidities) & "Immunosuppressive_disease" %in% input$comorbidities, T, F)
    Flu_shot = ifelse(input$flu_shot=="Yes", T, F)
    Pneumovax_shot = ifelse(input$pneumovax_shot=="Yes", T, F)
    Immunosuppressive_treatment = ifelse(!is.null(input$medications) & "Immunosuppressive_treatment" %in% input$medications, T, F)
    nsaids = ifelse(!is.null(input$medications) & "nsaids" %in% input$medications, T, F) 
    steroids = ifelse(!is.null(input$medications) & "steroids" %in% input$medications, T, F) 
    carvedilol = ifelse(!is.null(input$medications) & "carvedilol" %in% input$medications, T, F) 
    ace_inhibitor = ifelse(!is.null(input$medications) & "ace_inhibitor" %in% input$medications, T, F) 
    arb = ifelse(!is.null(input$medications) & "arb" %in% input$medications, T, F) 
    melatonin = ifelse(!is.null(input$medications) & "melatonin" %in% input$medications, T, F)
    #colchicine = ifelse(!is.null(input$medications) & "colchicine" %in% input$medications, T, F) 
    validate(
      need(input$pre_testing_platelets>=100&input$pre_testing_platelets<=500, 'Platelets range: 100 - 500 k/uL'),
      need(input$pre_testing_ast>=0&input$pre_testing_ast<=200, 'AST range: 0 - 200'),
      #need(input$pre_testing_bun>=0&input$pre_testing_bun<=60, 'BUN range: 0 - 60'),
      need(input$pre_testing_chloride>=97&input$pre_testing_chloride<=105, 'Chloride range: 97 - 105 mg/dL'),
      need(input$pre_testing_creatinine>=0.58&input$pre_testing_creatinine<=0.96, 'Creatinine range: 0.58 - 0.96 mg/dL'),
      need(input$pre_testing_hematocrit>=36&input$pre_testing_hematocrit<=46, 'Hematocrit range: 36 - 46 %'),
      need(input$pre_testing_potassium>=2&input$pre_testing_potassium<=9, 'Potassium range: 2 - 9')
    )
    pre_testing_platelets = ifelse(input$platelets, input$pre_testing_platelets, 238)   
    pre_testing_ast = ifelse(input$ast, input$pre_testing_ast, 23)
    #pre_testing_bun = ifelse(input$bun, input$pre_testing_bun, 16)
    pre_testing_chloride = ifelse(input$chloride, input$pre_testing_chloride, 101)    
    pre_testing_potassium = ifelse(input$potassium, input$pre_testing_potassium, 4)
    pre_testing_hematocrit = ifelse(input$hematocrit, input$pre_testing_hematocrit, 38.7) 
    pre_testing_creatinine = ifelse(input$creatinine, input$pre_testing_creatinine, 0.85)
    
    data <- data.frame(
      age = age,
      Race = Race,
      Ethnicity = Ethnicity,
      Gender = Gender,
      Smoking = Smoking,
      BMI = BMI,
      MedianIncome = MedianIncome,
      PopulationPerSqKm = PopulationPerSqKm,
      Expose_to_covid_19 = Expose_to_covid_19,
      Family_covid_19 = Family_covid_19,
      Cough = Cough,
      Fever = Fever,
      Fatigue = Fatigue,
      Sputum_production = Sputum_production,
      Flu_like_symptoms = Flu_like_symptoms,
      #Sob = Sob,
      Diarrhea = Diarrhea,
      Loss_of_appetite = Loss_of_appetite,
      Vomiting = Vomiting,
      #Copd_emphysema = Copd_emphysema,
      Asthma = Asthma,
      Hypertension = Hypertension,
      Diabetes = Diabetes,
      Transplant_history = Transplant_history,
      Coronary_artery_disease = Coronary_artery_disease,
      Cancer = Cancer,
      Multiple_sclerosis = Multiple_sclerosis,
      Connective_tissue_disease = Connective_tissue_disease,
      Immunosuppressive_disease = Immunosuppressive_disease,
      Ibd = Ibd,
      Flu_shot = Flu_shot,
      Pneumovax_shot = Pneumovax_shot,
      Immunosuppressive_treatment = Immunosuppressive_treatment,
      nsaids = nsaids,
      steroids = steroids,
      carvedilol = carvedilol,
      ace_inhibitor = ace_inhibitor,
      arb = arb,
      melatonin = melatonin,
      pre_testing_platelets = pre_testing_platelets,
      pre_testing_chloride = pre_testing_chloride,
      #pre_testing_bun = pre_testing_bun,
      pre_testing_potassium = pre_testing_potassium,
      pre_testing_hematocrit = pre_testing_hematocrit,
      pre_testing_creatinine = pre_testing_creatinine,
      pre_testing_ast = pre_testing_ast
    )
    data
  })
  
  output$result <- DT::renderDataTable({
    data = data()
    print(data)
    pred = eval(pred_test, envir = data)
    
    pred = ifelse(pred<0.001, "<0.1%", ifelse(pred>0.999, ">99.9%", paste(round(pred*100,1),"%",sep="")))
    result = data.frame(Result = c("Predicted probability"),
                        Probability = c(pred))
    result
  }, rownames= FALSE,
  options = list(
    pageLength = 10,
    lengthMenu = 0,
    searching = 0,
    info = 0,
    paging = 0,
    processing = 0,
    initComplete = I(
      "function(settings, json) {
                $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
}")))
}