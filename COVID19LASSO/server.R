pred_test <- expression({
    lp = 2.8165999 + 0.02986201 * age + 0.63634676 * (Race == "Black") - 
        0.57600943 * (Race == "Asian") + 0.018625505 * (Race == "Other") + 
        0.56629523 * (Gender == "Male") - 0.25212307 * 
        (Ethnicity == "Non-Hispanic") - 0.3702556 * (Ethnicity == "Unknown") - 
        0.67255882 * Cough - 0.29033439 * Expose_to_covid_19 + 
        0.32490216 * Family_covid_19 + 0.23696299 * Fever + 0.22248906 * 
        Flu_like_symptoms - 0.65277402 * Sob + 0.82863393 * Loss_of_appetite - 
        1.1208952 * Vomiting + 0.47566003 * Recent_Travel - 1.5339437 * 
        (Smoking == "Current Smoker") - 0.2706538 * (Smoking == "Former Smoker") - 
        0.23177221 * Copd_emphysema - 0.1053961 * 
        Asthma - 0.08806883 * Diabetes - 0.15879486 * Hypertension - 
        0.11538955 * Coronary_artery_disease - 0.26939017 * Heart_failure - 
        0.26967074 * Cancer - 0.48500876 * Immunosuppressive_treatment + 
        0.65835511 * Multiple_sclerosis - 0.176703 * Connective_tissue_disease - 
        0.1078241 * Ibd - 0.24595847 * Immunosuppressive_disease - 
        0.092602525 * Flu_shot - 0.51058174 * Pneumovax_shot - 
        0.0069643833 * pre_testing_platelets + 5.0070898e-09 * 
        max(pre_testing_platelets - 193, 0)**3 - 9.3651123e-09 * 
        max(pre_testing_platelets - 240, 0)**3 + 4.3580226e-09 * 
        max(pre_testing_platelets - 294, 0)**3 - 0.0001859846 * 
        pre_testing_ast - 0.018181876 * pre_testing_bun - 0.052190236 * 
        pre_testing_chloride + 0.13094923 * pre_testing_creatinine + 
        0.056328491 * pre_testing_hematocrit - 0.3763826 * pre_testing_potassium - 
        0.28092207 * nsaids - 0.25737753 * steroids - 0.38394549 * 
        carvedilol - 0.1090133 * ace_inhibitor + 0.18486577 * 
        arb - 0.35666858 * paroxetine - 0.63302334 * melatonin - 
        0.72536365 * colchicine
    1/(1+exp(-lp))
})

`%notin%` <- Negate(`%in%`)

library(shiny)
shinyServer(function(input, output, session){
    
    data <- eventReactive(input$goButton, {
        age = input$age
        Gender = input$Gender
        Race = input$Race
        Ethnicity = input$Ethnicity
        #Fatigue = ifelse("Fatigue" %in% input$risk, T, F)
        Cough = ifelse("Cough" %in% input$risk, T, F)  
        Family_covid_19 = ifelse("Family_covid_19" %in% input$risk, T, F) 
        Expose_to_covid_19 = ifelse("Expose_to_covid_19" %in% input$risk, T, F) 
        Fever = ifelse("Fever" %in% input$risk, T, F)
        Flu_like_symptoms = ifelse("Flu_like_symptoms" %in% input$risk, T, F)
        Sob = ifelse("Sob" %in% input$risk, T, F)
        Loss_of_appetite = ifelse("Loss_of_appetite" %in% input$risk, T, F)  
        Vomiting = ifelse("Vomiting" %in% input$risk, T, F)
        Recent_Travel = ifelse("Recent_Travel" %in% input$risk, T, F)
        Smoking = input$Smoking
        #Transplant_history = ifelse("Transplant_history" %in% input$comorbiditiesU, "Unknown", ifelse("Transplant_history" %in% input$comorbidities, "Yes", "No"))
        Copd_emphysema = ifelse("Copd_emphysema" %in% input$comorbidities, T, F)
        Asthma = ifelse("Asthma" %in% input$comorbidities, T, F)
        Diabetes = ifelse("Diabetes" %in% input$comorbidities, T, F)
        Hypertension = ifelse("Hypertension" %in% input$comorbidities, T, F)
        Coronary_artery_disease = ifelse("Coronary_artery_disease" %in% input$comorbidities, T, F)
        Heart_failure = ifelse("Heart_failure" %in% input$comorbidities, T, F)
        Cancer = ifelse("Cancer" %in% input$comorbidities, T, F)
        Immunosuppressive_treatment = ifelse("Immunosuppressive_treatment" %in% input$comorbidities, T, F)
        Multiple_sclerosis = ifelse("Multiple_sclerosis" %in% input$comorbidities, T, F)
        Connective_tissue_disease = ifelse("Connective_tissue_disease" %in% input$comorbidities, T, F)
        Ibd = ifelse("Ibd" %in% input$comorbidities, T, F)
        Immunosuppressive_disease = ifelse("Immunosuppressive_disease" %in% input$comorbidities, T, F)
        Flu_shot = ifelse(input$flu_shot=="Yes", T, F)
        Pneumovax_shot = ifelse(input$pneumovax_shot=="Yes", T, F)
        nsaids = ifelse("nsaids" %in% input$medications, T, F) 
        steroids = ifelse("steroids" %in% input$medications, T, F) 
        carvedilol = ifelse("carvedilol" %in% input$medications, T, F) 
        paroxetine = ifelse("paroxetine" %in% input$medications, T, F) 
        melatonin = ifelse("melatonin" %in% input$medications, T, F)
        ace_inhibitor = ifelse("ace_inhibitor" %in% input$medications, T, F)  
        arb = ifelse("arb" %in% input$medications, T, F)  
        colchicine = ifelse("colchicine" %in% input$medications, T, F) 
        validate(
            need(input$pre_testing_platelets>=150&input$pre_testing_platelets<=400, 'Platelets range: 150 - 400 k/uL'),
            need(input$pre_testing_bun>=7&input$pre_testing_bun<=21, 'BUN range: 7 - 21 mg/dL'),
            need(input$pre_testing_chloride>=97&input$pre_testing_chloride<=105, 'Chloride range: 97 - 105 mg/dL'),
            need(input$pre_testing_creatinine>=0.58&input$pre_testing_creatinine<=0.96, 'Creatinine range: 0.58 - 0.96 mg/dL'),
            need(input$pre_testing_hematocrit>=36&input$pre_testing_hematocrit<=46, 'Hematocrit range: 36 - 46 %'),
            need(input$pre_testing_ast>=0&input$pre_testing_ast<=200, 'AST range: 0 - 200'),
            need(input$pre_testing_potassium>=2&input$pre_testing_potassium<=9, 'Potassium range: 2 - 9')
        )
        pre_testing_platelets = ifelse(input$platelets, input$pre_testing_platelets, 238)   
        pre_testing_bun = ifelse(input$bun, input$pre_testing_bun, 14)         
        pre_testing_chloride = ifelse(input$chloride, input$pre_testing_chloride, 101)    
        pre_testing_potassium = ifelse(input$potassium, input$pre_testing_potassium, 4)
        pre_testing_hematocrit = ifelse(input$hematocrit, input$pre_testing_hematocrit, 38.7) 
        pre_testing_creatinine = ifelse(input$creatinine, input$pre_testing_creatinine, 0.85)
        pre_testing_ast = ifelse(input$ast, input$pre_testing_ast, 23)

        data <- data.frame(
            age = age,
            Gender = Gender,
            Race = Race,
            Ethnicity = Ethnicity,
            Cough = Cough,
            Family_covid_19 = Family_covid_19,
            Expose_to_covid_19 = Expose_to_covid_19,
            Fever = Fever,
            Flu_like_symptoms = Flu_like_symptoms,
            Sob = Sob,
            Loss_of_appetite = Loss_of_appetite,
            Vomiting = Vomiting,
            Recent_Travel = Recent_Travel,
            Smoking = Smoking,
            Copd_emphysema = Copd_emphysema, 
            Asthma = Asthma, 
            Diabetes = Diabetes, 
            Hypertension = Hypertension, 
            Coronary_artery_disease = Coronary_artery_disease, 
            Heart_failure = Heart_failure, 
            Cancer = Cancer, 
            Immunosuppressive_treatment = Immunosuppressive_treatment, 
            Multiple_sclerosis = Multiple_sclerosis, 
            Connective_tissue_disease = Connective_tissue_disease, 
            Ibd = Ibd, 
            Immunosuppressive_disease = Immunosuppressive_disease, 
            Flu_shot = Flu_shot, 
            Pneumovax_shot = Pneumovax_shot,
            nsaids = nsaids,
            steroids = steroids,
            carvedilol = carvedilol,
            paroxetine = paroxetine,
            melatonin = melatonin,
            ace_inhibitor = ace_inhibitor,
            arb = arb,
            colchicine = colchicine,
            pre_testing_platelets = pre_testing_platelets,
            pre_testing_bun = pre_testing_bun,
            pre_testing_chloride = pre_testing_chloride,
            pre_testing_potassium = pre_testing_potassium,
            pre_testing_hematocrit = pre_testing_hematocrit,
            pre_testing_creatinine = pre_testing_creatinine,
            pre_testing_ast = pre_testing_ast
        )
        data})
    output$result <- DT::renderDataTable({
        data = data()
        pred = eval(pred_test, envir = data)
        result = data.frame(Result = c("Predicted probability"),
                            Probability = c(paste(round(pred*100, 2), "%", sep="")))
        result
        }, options = list(
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
    })