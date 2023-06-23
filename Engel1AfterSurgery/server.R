predict.engel1 <- expression({
    lp <- 1.9798356 - 0.02804257 * Epilepsy_duration + 3.2053666e-05 * 
        max(Epilepsy_duration - 3.7983333, 0)**3 - 4.4833601e-05 * 
        max(Epilepsy_duration - 14.5, 0)**3 + 1.2779935e-05 * 
        max(Epilepsy_duration - 41.341111, 0)**3 - 0.42167206 * 
        (Gender == "Male") - 0.77962222 * (GTC == "Yes") - 1.2005187 * 
        (MRI == "Normal") - 0.68812154 * (Expected_Epilepsy_Localization == 
                                             "Temporal") - 0.25289455 * (EEG == "No interictal discharge") - 
        0.45585918 * (EEG == "Unilateral interictal discharge") + 
        0.46773492 * (MRI == "Normal") * (Expected_Epilepsy_Localization == 
                                             "Temporal") + (MRI == "Normal") * (1.7653263 * (EEG == 
                                                                                                "No interictal discharge") + 0.33621264 * (EEG == "Unilateral interictal discharge")) + 
        (Expected_Epilepsy_Localization == "Temporal") * (0.58954114 * 
                                                             (EEG == "No interictal discharge") + 1.0535929 * 
                                                             (EEG == "Unilateral interictal discharge")) - 2.8377561 * 
        (MRI == "Normal") * (Expected_Epilepsy_Localization == 
                                "Temporal") * (EEG == "No interictal discharge") + 0.17377016 * 
        (MRI == "Normal") * (Expected_Epilepsy_Localization == 
                                "Temporal") * (EEG == "Unilateral interictal discharge")
    1/(1+exp(-lp))
})


shinyServer(function(input, output, session){
    
    data <- reactive({
        validate(need((!is.na(as.numeric(input$Epilepsy_duration))& as.numeric(input$Epilepsy_duration)>=0& as.numeric(input$Epilepsy_duration)<=60), 'Please input a valid Epilepsy duration'))

        Epilepsy_duration = as.numeric(input$Epilepsy_duration)
        Gender = input$Gender
        GTC = input$GTC
        MRI = input$MRI
        Expected_Epilepsy_Localization = input$Expected_Epilepsy_Localization
        EEG = input$EEG
        
        data <- data.frame(
            Epilepsy_duration = Epilepsy_duration,
            Gender = Gender,
            GTC = GTC,
            MRI = MRI,
            Expected_Epilepsy_Localization = Expected_Epilepsy_Localization,
            EEG = EEG
        )
        data})
    
    
    output$result <- DT::renderDataTable({
        data = data()
        pred = eval(predict.engel1, envir = data)
        class = ifelse(pred <= .508, "ESOP Class I", ifelse(pred <= 0.609, "ESOP Class II", "ESOP Class III"))
        pred = ifelse(pred<0.001, "<0.1%", ifelse(pred>0.999, ">99.9%", paste(round(pred*100,1),"%",sep="")))
        
        res = data.frame("Outcome" = c("Predicted Probability of Engel 1 at 2 years", "ESOP Class"), 
                         "Result" = c(pred, class))
        
        res}, options = list(
            pageLength = 10,
            lengthMenu = 0,
            processing = 0,
            searching = 0,
            info = 0,
            paging = 0,
            initComplete = I(
                "function(settings, json) {
                    $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
            }")))
})
