predict_func = expression({
    lp = -0.386 + 1.56*CVP+3.496*lactate-4.831*ICD+3.544*LVEF
    100 / (1+exp(-lp))
})

shinyServer(function(input, output, session){
    
    data <- reactive({
        CVP = input$CVP == "Yes"
        lactate = input$lactate == "Yes"
        ICD = input$ICD == "Yes"
        LVEF = input$LVEF == "Yes"
        
        data <- data.frame(
            CVP = CVP,
            lactate = lactate,
            ICD = ICD,
            LVEF = LVEF
        )
        data})
    
    # output table
    output$result <- DT::renderDataTable({
        data = data()
        prob.model1 = eval(predict_func, data)
        res.model1 = ifelse(prob.model1 > 61.8, "Yes", "No")
        prob.model1 = round(prob.model1, 0)
        prob.model1 = ifelse(prob.model1 < 1, "<1", ifelse(prob.model1 > 99, ">99%", paste(prob.model1, "%", sep="")))
        
        
        res = data.frame(Outcome = c("FLIC-score",
                                     "Occurrence of ES-induced CS"),
                         Prediction = c(prob.model1, res.model1))
        
        
        res
    }, options = list(
        pageLength = 10,
        lengthMenu = 0,
        
        searching = 0,
        processing = 0,
        info = 0,
        paging = 0,
        initComplete = I(
            "function(settings, json) {
                    $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
            }")))
})
