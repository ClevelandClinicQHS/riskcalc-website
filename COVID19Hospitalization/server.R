pred_test <- expression({
    lp <- 12.85113 - 0.51871288 * (Race == "Black") - 
      1.077806 * (Race == "Other") - 0.69745925 * (Race == "White") + 
      0.93395357 * (Ethnicity == "Non-Hispanic") - 0.4468696 * (Ethnicity == "Unknown") + 
      0.25305089 * (Smoking == "Former Smoker") + 0.30894413 * (Smoking == "No") - 
      0.23377998 * (Smoking == "Unknown") + 0.048002434 * age - 
      8.6027579e-06 * max(age - 27.68345, 0)**3 + 1.7453099e-05 * max(age - 54.74313, 0)**3 - 
      8.8503415e-06 * max(age - 81.04583, 0)**3 - 0.0095874896 * MedianIncome + 1.6681469e-06 * 
      max(MedianIncome - 30.267, 0)**3 - 2.7228463e-06 * max(MedianIncome - 57.19505, 0)**3 + 
      1.0546994e-06 * max(MedianIncome - 99.78533, 0)**3 - 0.095706705 * BMI + 
      0.0016544301 * max(BMI - 24.97713, 0)**3 - 0.0024703471 * max(BMI - 28.59016, 0)**3 + 
      0.00081591698 * max(BMI - 35.91628, 0)**3 - 0.0068562873 * pre_testing_platelets + 
      0.037656721 * pre_testing_ast + 0.036517489 * pre_testing_bun - 0.13383138 * pre_testing_chloride - 
      0.55030649 * pre_testing_potassium - 0.24079956 * PopulationPerHousingUnit + 0.28248176 * (Gender == "Male") +
      0.21982317 * Fever + 0.53234307 * Fatigue + 0.98178605 * Sob + 0.048250559 * Diarrhea - 
      0.65373191 * Vomiting + 0.42924726 * Asthma + 0.64842344 * Diabetes + 
      0.30322603 * Hypertension + 0.36387004 * Immunosuppressive_treatment + 
      0.31535768 * Immunosuppressive_disease + 0.36250172 * nsaids
    1/(1+exp(-lp))
})



server = function(input, output, session){
  # data <- eventReactive(input$goButton, {
  #     
  #     data})
  # 
  
  observeEvent(input$goButton, {
    shinyjs::show("result_panel")
  })
  
  observeEvent({list(input$age,input$Gender,input$Race, input$Ethnicity, input$medications, 
                     input$BMI, input$geo, input$ZIP, 
                     input$risk, input$comorbidities,
                     input$Smoking, #input$flu_shot,input$pneumovax_shot,
                     input$platelets, input$pre_testing_platelets,
                     input$chloride, input$pre_testing_chloride,
                     input$bun, input$pre_testing_bun,
                     input$creatinine, input$pre_testing_creatinine,
                     input$ast, input$pre_testing_ast,
                     input$hematocrit, input$pre_testing_hematocrit,
                     input$potassium, input$pre_testing_potassium)},
               {
                 shinyjs::hide("result_panel")
               })
  
  data <- eventReactive(input$goButton,{
    age = input$age
    Race = input$Race
    Ethnicity = input$Ethnicity
    Gender = input$Gender
    Smoking = input$Smoking
    BMI = input$BMI
    if (input$geo == T & input$ZIP %in% zip_data$ZIP) {
      MedianIncome = zip_data$MedianIncome[zip_data$ZIP == input$ZIP] / 1000
      PopulationPerSqKm = log10(zip_data$PopulationPerSqKm[zip_data$ZIP == input$ZIP]+1)
      PopulationPerHousingUnit = zip_data$PopulationPerHousingUnit[zip_data$ZIP == input$ZIP]
    } else {
      MedianIncome = 56.101
      PopulationPerSqKm = 3.065953
      PopulationPerHousingUnit = 2.28
    }
    #Expose_to_covid_19 = ifelse("Expose_to_covid_19" %in% input$risk, T, F) 
    #Family_covid_19 = ifelse("Family_covid_19" %in% input$risk, T, F) 
    #Cough = ifelse("Cough" %in% input$risk, T, F)  
    Fever = ifelse("Fever" %in% input$risk, T, F)  
    Fatigue = ifelse("Fatigue" %in% input$risk, T, F)  
    #Sputum_production = ifelse("Sputum_production" %in% input$risk, T, F)  
    #Flu_like_symptoms = ifelse("Flu_like_symptoms" %in% input$risk, T, F)  
    Sob = ifelse("Sob" %in% input$risk, T, F)
    Diarrhea = ifelse("Diarrhea" %in% input$risk, T, F)
    #Loss_of_appetite = ifelse("Loss_of_appetite" %in% input$risk, T, F)  
    Vomiting = ifelse("Vomiting" %in% input$risk, T, F)
    #Copd_emphysema = ifelse("Copd_emphysema" %in% input$comorbidities, T, F)
    Asthma = ifelse("Asthma" %in% input$comorbidities, T, F)
    Hypertension = ifelse("Hypertension" %in% input$comorbidities, T, F)
    Diabetes = ifelse("Diabetes" %in% input$comorbidities, T, F)
    #Transplant_history = ifelse("Transplant_history" %in% input$comorbidities, T, F)
    #Multiple_sclerosis = ifelse("Multiple_sclerosis" %in% input$comorbidities, T, F)
    #Ibd = ifelse("Ibd" %in% input$comorbidities, T, F)
    Immunosuppressive_disease = ifelse("Immunosuppressive_disease" %in% input$comorbidities, T, F)
    #Flu_shot = ifelse(input$flu_shot=="Yes", T, F)
    #Pneumovax_shot = ifelse(input$pneumovax_shot=="Yes", T, F)
    Immunosuppressive_treatment = ifelse("Immunosuppressive_treatment" %in% input$medications, T, F)
    nsaids = ifelse("nsaids" %in% input$medications, T, F) 
    #steroids = ifelse("steroids" %in% input$medications, T, F) 
    #carvedilol = ifelse("carvedilol" %in% input$medications, T, F) 
    #ace_inhibitor = ifelse("ace_inhibitor" %in% input$medications, T, F) 
    #arb = ifelse("arb" %in% input$medications, T, F) 
    #melatonin = ifelse("melatonin" %in% input$medications, T, F)
    #colchicine = ifelse("colchicine" %in% input$medications, T, F) 
    validate(
      need(input$pre_testing_platelets>=100&input$pre_testing_platelets<=500, 'Platelets range: 100 - 500 k/uL'),
      need(input$pre_testing_ast>=0&input$pre_testing_ast<=200, 'AST range: 0 - 200'),
      need(input$pre_testing_bun>=0&input$pre_testing_bun<=60, 'BUN range: 0 - 60'),
      need(input$pre_testing_chloride>=97&input$pre_testing_chloride<=105, 'Chloride range: 97 - 105 mg/dL'),
      #need(input$pre_testing_creatinine>=0.58&input$pre_testing_creatinine<=0.96, 'Creatinine range: 0.58 - 0.96 mg/dL'),
      #need(input$pre_testing_hematocrit>=36&input$pre_testing_hematocrit<=46, 'Hematocrit range: 36 - 46 %'),
      need(input$pre_testing_potassium>=2&input$pre_testing_potassium<=9, 'Potassium range: 2 - 9')
    )
    pre_testing_platelets = ifelse(input$platelets, input$pre_testing_platelets, 238)   
    pre_testing_ast = ifelse(input$ast, input$pre_testing_ast, 23)
    pre_testing_bun = ifelse(input$bun, input$pre_testing_bun, 16)
    pre_testing_chloride = ifelse(input$chloride, input$pre_testing_chloride, 101)    
    #pre_testing_creatinine = ifelse(input$creatinine, input$pre_testing_creatinine, 0.85)
    #pre_testing_hematocrit = ifelse(input$hematocrit, input$pre_testing_hematocrit, 38.7) 
    pre_testing_potassium = ifelse(input$potassium, input$pre_testing_potassium, 4)
    
    data <- data.frame(
      age = age,
      Race = Race,
      Ethnicity = Ethnicity,
      Gender = Gender,
      Smoking = Smoking,
      BMI = BMI,
      MedianIncome = MedianIncome,
      PopulationPerSqKm = PopulationPerSqKm,
      PopulationPerHousingUnit = PopulationPerHousingUnit,
      #Expose_to_covid_19 = Expose_to_covid_19,
      #Family_covid_19 = Family_covid_19,
      #Cough = Cough,
      Fever = Fever,
      Fatigue = Fatigue,
      #Sputum_production = Sputum_production,
      #Flu_like_symptoms = Flu_like_symptoms,
      Sob = Sob,
      Diarrhea = Diarrhea,
      #Loss_of_appetite = Loss_of_appetite,
      Vomiting = Vomiting,
      #Copd_emphysema = Copd_emphysema,
      Asthma = Asthma,
      Hypertension = Hypertension,
      Diabetes = Diabetes,
      #Transplant_history = Transplant_history,
      #Multiple_sclerosis = Multiple_sclerosis,
      #Ibd = Ibd,
      #Flu_shot = Flu_shot,
      #Pneumovax_shot = Pneumovax_shot,
      Immunosuppressive_disease = Immunosuppressive_disease,
      Immunosuppressive_treatment = Immunosuppressive_treatment,
      nsaids = nsaids,
      #steroids = steroids,
      #carvedilol = carvedilol,
      #ace_inhibitor = ace_inhibitor,
      #arb = arb,
      #melatonin = melatonin,
      pre_testing_platelets = pre_testing_platelets,
      pre_testing_ast = pre_testing_ast,
      pre_testing_bun = pre_testing_bun,
      pre_testing_chloride = pre_testing_chloride,
      #pre_testing_creatinine = pre_testing_creatinine,
      #pre_testing_hematocrit = pre_testing_hematocrit,
      pre_testing_potassium = pre_testing_potassium
    )
    print(data)
    data
  })
  
    output$result <- DT::renderDataTable({
        data = data()
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