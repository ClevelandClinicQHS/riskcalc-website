predict.risk <- expression({
    lp <- -0.085926217 + 0.94823667 * MildHypo.Code - 0.39935646 * 
        n + 0.001516956 * max(n - 6, 0)**3 - 0.002275434 * max(n - 
        12, 0)**3 + 0.00075847801 * max(n - 24, 0)**3 - 0.46754445 * 
        HbA1c + 0.37412025 * max(HbA1c - 6, 0)**3 - 0.7482405 * 
        max(HbA1c - 6.5, 0)**3 + 0.37412025 * max(HbA1c - 7, 
        0)**3 - 0.49700651 * Sulf + 0.31533117 * Insulin - 0.36476501 * 
        Metform - 0.013662477 * Age + 0.51490043 * (Race == "Black") + 
        0.049326432 * (Race == "Other") - 0.030654789 * BMI + 
        0.8244032 * Hx.CardioVasular + 0.88519856 * Hx.CHF + 
        1.2490526 * Hx.Other.Psych + 1.0020249 * Hx.Dementia + 
        0.72713516 * Hx.CKD
    #print(lp)
    1/(1+exp(-lp))
})


library(shiny)
shinyServer(function(input, output){
    # observeEvent(input$add_med, {
    #     insertUI(
    #         selector = "#placeholder_med",
    #         # where = "beforeBegin",
    #         ui =tags$div(
    #             fluidRow(
    #                 column(12,
    #                        selectizeInput('Medication', label = h5("Diabetes medications"), 
    #                                       choices = c("Insulin", "SULF", "DPP4", "Metformin"), multiple = TRUE,
    #                                       options = list(placeholder = "Select All That Apply", onInitialize = I('function() { this.setValue(""); }')))
    #                 )
    #             ) 
    #         )
    #     )
    # })
    # 
    # observeEvent(input$add_comorbidity, {
    #     insertUI(
    #         selector = "#placeholder_comorbidity",
    #         # where = "beforeBegin",
    #         ui =tags$div(
    #             fluidRow(
    #                 column(12,
    #                        selectizeInput('Comorbidity', label = h5("Comorbidity"), 
    #                                       choices = c("Cardiovascular Disorder", "CKD", "Depression", "Cognitive Disorders", "Dementia", "Alcohol abuse", "Other Psychiatric"), multiple = TRUE,
    #                                       options = list(placeholder = "Select All That Apply", onInitialize = I('function() { this.setValue(""); }')))
    #                 )
    #             ) 
    #         )
    #     )
    # })
    # 
    data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$n))& as.numeric(input$n)>=0, 'Please input a valid length of time'))
        n = as.numeric(input$n) / 3
        validate(need(!is.na(as.numeric(input$HbA1c))& as.numeric(input$HbA1c)>=0 & as.numeric(input$HbA1c)<=20, 'Please input a valid A1c'))
        HbA1c = as.numeric(input$HbA1c)
        validate(need(!is.na(as.numeric(input$Age))& as.numeric(input$Age)>=18& as.numeric(input$Age)<=80, 'Please input a valid Age'))
        Age = as.numeric(input$Age)
        Race = factor(input$Race, levels = c('White', 'Black', 'Other'))
        validate(need(!is.na(as.numeric(input$BMI))& as.numeric(input$BMI) > 15& as.numeric(input$BMI) <= 60, 'Please input a valid BMI'))
        BMI = as.numeric(input$BMI)
        MildHypo.Code = ifelse(input$MildHypo.Code == 'Yes', 1, 0)
        Insulin = ifelse("Insulin" %in% input$Medication, 1, 0)
        Sulf = ifelse("Sulfonylurea" %in% input$Medication, 1, 0)
        Metform = ifelse("Metformin" %in% input$Medication, 1, 0)
        Hx.Cognitive.Disorders = ifelse("Cognitive Disorders" %in% input$Comorbidity, 1, 0)
        Hx.CardioVasular = ifelse("Cardiovascular Disorder" %in% input$Comorbidity, 1, 0)
        Hx.CHF = ifelse("Heart Failure" %in% input$Comorbidity, 1, 0)
        Hx.CKD = ifelse("CKD" %in% input$Comorbidity, 1, 0)
        Hx.Depression = ifelse("Depression" %in% input$Comorbidity, 1, 0)
        Hx.Dementia = ifelse("Dementia" %in% input$Comorbidity, 1, 0)
        Hx.Alcohol = ifelse("Alcohol abuse" %in% input$Comorbidity, 1, 0)
        Hx.Other.Psych = ifelse("Other Psychiatric" %in% input$Comorbidity, 1, 0)
        
        data <- data.frame(
            n = n,
            HbA1c = HbA1c,
            Age = Age,
            Race = Race,
            BMI = BMI,
            Insulin = Insulin,
            Metform = Metform,
            Sulf = Sulf,
            MildHypo.Code = MildHypo.Code,
            Hx.Cognitive.Disorders = Hx.Cognitive.Disorders,
            Hx.CardioVasular = Hx.CardioVasular,
            Hx.CHF = Hx.CHF,
            Hx.CKD = Hx.CKD,
            Hx.Depression = Hx.Depression,
            Hx.Dementia = Hx.Dementia,
            Hx.Alcohol = Hx.Alcohol,
            Hx.Other.Psych = Hx.Other.Psych)
        data})
    
    output$result <- renderDataTable({
        data = data()
        prob <- round(eval(predict.risk, data) * 100, 1)
        #print(prob)
        prob <- ifelse(prob > 1, paste(prob, "% (high risk)"), paste(prob, "%"))
        res = data.frame(Result = c("3-month risk of severe hypoglycemia"),
                         Probability = c(prob))
        
        res}, options = list(
        pageLength = 10,
        lengthMenu = 0,
        
        searching = 0,
        info = 0,
        paging = 0,
        initComplete = I(
            "function(settings, json) {
                    $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
            }")))
})
