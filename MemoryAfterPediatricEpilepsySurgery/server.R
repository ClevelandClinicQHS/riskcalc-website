
fit1 <- expression({
    lp =  -1.2461697 - 0.95219496 * (surgdomrec == "Non-Dominant") -
        0.38986133 * (surgdomrec == "Undetermined") - 1.0031768 *
        (orsite == "Temporal") + 0.23114585 * stdel1ss
    100 / (1+exp(-lp))
})

fit2 <- expression({
    lp =  -0.014702211 - 0.047655589 * fsiqcomb1 + 0.36615733 * wpld1ss
    100 / (1+exp(-lp))
})

fit3 <- expression({
    lp =  -2.4152156 - 1.4999516 * (orsite == "Temporal") + 0.29762972 * facde1ss
    100 / (1+exp(-lp))
})

shinyServer(function(input, output){
    # input
    data <- eventReactive(input$goButton, {
        # validate the inputs
        validate(need(!is.na(input$stdel1ss) & input$stdel1ss>=0 & input$stdel1ss <=19, 'Please input a valid Preoperative stories delayed memory score'))
        validate(need(!is.na(input$fsiqcomb1) & input$fsiqcomb1>=40 & input$fsiqcomb1 <=160, 'Please input a valid Preoperative FSIQ'))
        validate(need(!is.na(input$wpld1ss) & input$wpld1ss>=0 & input$wpld1ss <=19, 'Please input a valid Preoperative Word Pair Long Delay Score'))
        validate(need(!is.na(input$facde1ss) & input$facde1ss>=0 & input$facde1ss <=19, 'Please input a valid Preoperative Faces Delayed Score'))
        
        # clean inputs
        surgdomrec = input$surgdomrec
        orsite = input$orsite
        stdel1ss = input$stdel1ss
        fsiqcomb1 = input$fsiqcomb1
        wpld1ss = input$wpld1ss
        facde1ss = input$facde1ss
        
        # create data frame from input
        data <- data.frame(surgdomrec = surgdomrec,
                           orsite = orsite,
                           stdel1ss = stdel1ss,
                           fsiqcomb1 = fsiqcomb1,
                           wpld1ss = wpld1ss,
                           facde1ss = facde1ss)
        data})
    
    # output table
    output$result <- DT::renderDataTable({
        data = data()
        prob.model1 = round(eval(fit1, data), 0)
        prob.model1 = ifelse(prob.model1 < 1, "<1", ifelse(prob.model1 > 99, ">99%", paste(prob.model1, "%", sep="")))
        prob.model2 = round(eval(fit2, data), 0)
        prob.model2 = ifelse(prob.model2 < 1, "<1", ifelse(prob.model2 > 99, ">99%", paste(prob.model2, "%", sep="")))
        prob.model3 = round(eval(fit3, data), 0)
        prob.model3 = ifelse(prob.model3 < 1, "<1", ifelse(prob.model3 > 99, ">99%", paste(prob.model3, "%", sep="")))

        res = data.frame(Result = c("Probability of verbal memory decline using the CMS stories delayed subtest",
                                    "Probability of verbal memory decline using the CMS word pairs long delay subtest",                                    
                                    "Probability of visual memory decline using the CMS faces delayed subtest"),
                         Probability = c(prob.model1, prob.model2, prob.model3))
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
