# Clinically relevant naming decline (decline of ≥ 5 raw score points on Boston Naming Test)”
predict.model1 <- expression({
    lp = -3.318 + 1.010 * (history == "Yes") + 0.652 * (surgery == "Dominant") +
        0.036 * fas - 0.543 * (relation == "In Relationship") + 0.326 * (relation == 'Married') +
        1.09 * (relation == 'Divorced') - 1.228 * (relation == 'Widowed') - 0.021 * age +
        0.569 * (mcd == "Present")
    100 / (1+exp(-lp))
})

shinyServer(function(input, output){
    # input
    data <- eventReactive(input$goButton, {
        # validate the inputs
        validate(need(!is.na(input$age) & input$age>=16 & input$age <=78, 'Please input a valid Age at preop testing'))
        validate(need(!is.na(input$fas) & input$fas>=3 & input$fas <=79, 'Please input a valid Preop F-A-S raw score'))
        
        # clean inputs
        age = input$age
        surgery = input$surgery
        history = input$history
        fas = input$fas
        mcd = input$mcd
        relation = input$relation
        
        # create data frame from input
        data <- data.frame(age = age,
                           surgery = surgery,
                           history = history,
                           fas = fas,
                           mcd = mcd,
                           relation = relation)
        data})
    
    # output table
    output$result <- DT::renderDataTable({
        data = data()
        prob.model1 = round(eval(predict.model1, data), 0)
        prob.model1 = ifelse(prob.model1 < 1, "<1", ifelse(prob.model1 > 99, ">99%", paste(prob.model1, "%", sep="")))

        res = data.frame(Result = c("Clinically relevant mood decline (15% increase in Beck Depression Inventory-II score AND post-op BDI-II score > 11)"),
                         Probability = c(prob.model1))
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
