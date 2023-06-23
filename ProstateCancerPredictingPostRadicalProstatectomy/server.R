predict.7yr.radical <- expression({
    lp = -3.3196459 +
        0.75250647 * log(psa) -
        0.064484062 * max(log(psa) - 0.40546511, 0)**3 +
        0.53855528 * max(log(psa) - 1.5475625, 0)**3 -
        1.1562808 * max(log(psa) - 1.9600948, 0)**3 +
        0.82313413 * max(log(psa) - 2.3643752, 0)**3 -
        0.14092453 * max(log(psa) - 3.4563167, 0)**3 -
        0.01980483 * (g1 + g2) +
        0.19708526 * max((g1 + g2) - 5, 0)**3 -
        0.5136459 * max((g1 + g2) - 6, 0)**3 +
        0.43603603 * max((g1 + g2) - 7, 0)**3 -
        0.11947539 * max((g1 + g2) - 8, 0)**3 +
        1.0466346 * (ecelev == "Inv.Capsule") +
        1.7564088 * (ecelev == "Focal") +
        1.9533814 * (ecelev == "Established") +
        1.1594884 * (sm == "Positive") +
        0.86096245 * (svi == "Yes") +
        0.93273528 * (lni == "Positive")
    0.8552918 ** exp(lp) * 100
})
predict.10yr.radical <- expression({
    lp <- 110.52302 -
        0.056105833 * (2003) +
        0.3931648 * (sm == "Positive") +
        0.8748934 * (ecelev == "Focal") +
        0.8748934 * (ecelev == "Established") +
        0.9425151 * (svi == "Yes") +
        0.43389123 * (lni == "Positive") +
        1.3792909 * (g1 > 3) +
        0.57039863 * (g2 > 3) -
        1.4998377 * (adjrt == "Yes") +
        0.39237805 * log(psa + 0.001) -
        0.032117287 * max(log(psa + 0.001) - 1.0650555, 0)**3 +
        0.059594821 * max(log(psa + 0.001) - 1.8407084, 0)**3 -
        0.027477534 * max(log(psa + 0.001) - 2.747335, 0)**3
    0.9076778 ** exp(lp) * 100
})

predict.mortality <- expression({
    lp <- 0.0063398891 * psa - 
        0.000069168761 * max(psa - 3, 0)**3 + 
        0.000093815101 * max(psa - 6.1, 0)**3 - 
        0.00002464634 * max(psa - 14.8, 0)**3 - 
        0.0077471012 * AGE + 
        0.47568234 * (ece == "Yes") + 
        0.083074114 * (sm == "Positive") + 
        1.2931122 * (svi == "Yes") + 
        0.32968341 * (lni == "Positive") + 
        1.7559595 * (g1 == 4 | g1 == 5) + 
        1.2301273 * (g2 == 4 | g2 == 5)
    lp
})

library(shiny)
shinyServer(function(input, output){
    data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$AGE))& as.numeric(input$AGE)>=18& as.numeric(input$AGE)<=100, 'Please input a valid AGE'))
        AGE= as.numeric(input$AGE)
        adjrt = factor(input$adjrt, levels = c('No', 'Yes'))
        ecelev = factor(input$ecelev, levels = c('None', 'Inv.Capsule', 'Focal', 'Established'))
        stagecha = factor(input$stagecha, levels = c('T1c', 'T2a', 'T2b', 'T2c', 'T3'))
        ece = factor(input$ece, levels = c('No', 'Yes'))
        lni = factor(input$lni, levels = c('Negative', 'Positive'))
        validate(need(!is.na(as.numeric(input$psa))& as.numeric(input$psa)>0& as.numeric(input$psa)<=100, 'Please input a valid psa'))
        psa= as.numeric(input$psa)
        g1 = as.numeric(as.character(input$g1))
        g2 = as.numeric(as.character(input$g2))
        svi = factor(input$svi, levels = c('No', 'Yes'))
        sm = factor(input$sm, levels = c('Negative', 'Positive'))
        data <- data.frame(
            AGE = AGE,
            adjrt = adjrt,
            ecelev = ecelev,
            stagecha = stagecha,
            ece = ece,
            lni = lni,
            psa = psa,
            g1 = g1,
            g2 = g2,
            svi = svi,
            sm = sm)
        data})
    output$result <- renderDataTable({data = data()
    prob.7yr.rad <- paste(ifelse(round(eval(predict.7yr.radical, data), 0) < 1, "<1", ifelse(round(eval(predict.7yr.radical, data), 0) > 99, ">99", round(eval(predict.7yr.radical, data), 0))), "%")
    prob.10yr <- paste(ifelse(round(eval(predict.10yr.radical, data), 0) < 1, "<1", ifelse(round(eval(predict.10yr.radical, data), 0) > 99, ">99", round(eval(predict.10yr.radical, data), 0))), "%")
    mortality.10yr <- paste(round(100 * (1-0.9979952 ** exp(eval(predict.mortality, data))), 0), "%")
    mortality.15yr <- paste(round(100 * (1-0.9958054 ** exp(eval(predict.mortality, data))), 0), "%")
    res = data.frame(Result = c(
        "7-year Probability of freedom From Recurrence - Radical Prostatectomy[1]",
        "10-year Probability of freedom From Recurrence - Radical Prostatectomy[2]",
        "10-Year Prostate Cancer Specific Mortality[3]", 
        "15-Year Prostate Cancer Specific Mortality[3]"),
        Probability = c(prob.7yr.rad, prob.10yr, mortality.10yr, mortality.15yr))
    
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
