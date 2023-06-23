predict.mortality <- expression({
    lp <- 0.0063398891 * PSA - 
        0.000069168761 * max(PSA - 3, 0)**3 + 
        0.000093815101 * max(PSA - 6.1, 0)**3 - 
        0.00002464634 * max(PSA - 14.8, 0)**3 - 
        0.0077471012 * AGE - 
        0.47568234 * (ECE == "Yes") + 
        0.083074114 * (SMS == "Positive") + 
        1.2931122 * (SVI == "Yes") + 
        0.32968341 * (LNI == "Yes") + 
        1.7559595 * (G1 == "4" | G1 == "5") + 
        1.2301273 * (G2 == "4" | G2 == "5")
    lp
})
library(shiny)
shinyServer(function(input, output){
    data <- eventReactive(input$goButton, {
    validate(need(!is.na(as.numeric(input$AGE))& as.numeric(input$AGE)>=18& as.numeric(input$AGE)<=100, 'Please input a valid AGE'))
        AGE= as.numeric(input$AGE)
        validate(need(!is.na(as.numeric(input$PSA))& as.numeric(input$PSA)>=0, 'Please input a valid PSA'))
        PSA= as.numeric(input$PSA)
        ECE = factor(input$ECE, levels = c("No", "Yes"))
        SMS = factor(input$SMS, levels = c("Negative", "Positive"))
        SVI = factor(input$SVI, levels = c("No", "Yes"))
        LNI = factor(input$LNI, levels = c("No", "Yes"))
        G1 = factor(input$G1, levels = c('1', '2', '3', '4', '5'))
        G2 = factor(input$G2, levels = c('1', '2', '3', '4', '5'))
        data <- data.frame(AGE = AGE,
                           PSA = PSA,
                           ECE = ECE,
                           SMS = SMS,
                           SVI = SVI,
                           LNI = LNI,
                           G1 = G1,
                           G2 = G2)
        data})
    output$result <- renderDataTable({data = data()
    mortality.10yr <- paste(round(100 * (1-0.9979952 ** exp(eval(predict.mortality, data))), 0), "%")
    mortality.15yr <- paste(round(100 * (1-0.9958054 ** exp(eval(predict.mortality, data))), 0), "%")
    res = data.frame(Result = c("Predicted 10-Year Prostate Cancer Specific Mortality", "Predicted 15-Year Prostate Cancer Specific Mortality"), 
                     Probability = c(mortality.10yr, mortality.15yr))
    
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
