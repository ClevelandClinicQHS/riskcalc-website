predict.sunitinib <- expression({
    lp <- 0.3388702 - 
        0.02748987 * CCA + 
        0.24042927 * max(CCA - 8.409354, 0)**3 - 
        0.36485106 * max(CCA - 8.85273, 0)**3 + 
        0.1244218 * max(CCA - 9.7094976, 0)**3 + 
        0.077614676 * METSITE + 
        0.015960539 * max(METSITE - 1, 0)**3 - 
        0.022099208 * max(METSITE - 2, 0)**3 + 
        0.0061386689 * max(METSITE - 4.6, 0)**3 - 
        0.038316816 * (HGBGP == "< LLN") - 
        0.21801026 * (NEPGP == "Yes") - 
        0.055499944 * (LUNGGP == "Yes") + 
        0.36085405 * (LIVERGP == "Yes") + 
        0.17207478 * (ECOGGP == "1") + 
        0.5563908 * (THRGRP == "Yes") - 
        0.02268372 * Time + 
        1.0598676e-05 * max(Time - 1.3648352, 0)**3 - 
        1.2184664e-05 * max(Time - 10.549451, 0)**3 + 
        1.5859874e-06 * max(Time - 71.927473, 0)**3 - 
        0.14350256 * log(ALK) + 
        0.21451611 * max(log(ALK) + 0.84959936, 0)**3 -
        0.34687938 * max(log(ALK) + 0.42814791, 0)**3 + 
        0.13236327 * max(log(ALK)- 0.25488238, 0)**3 + 
        0.93346763 * log(LDHULN) - 
        0.85737664 * max(log(LDHULN) + 0.67661788, 0)**3 + 
        1.4804707 * max(log(LDHULN) + 0.3807725, 0)**3 - 
        0.62309406 * max(log(LDHULN) - 0.026310376, 0)**3
    0.4491438 ** exp(lp) * 100
})
predict.pazopanib <- expression({
    lp <- 1.6488989 + 
        0.30450913 * (neutrophil == ">= ULN") + 
        0.17821221 * ALK + 
        0.38240877 * (METBONYN == "Yes") - 
        0.0037702249 * Time - 
        0.43876756 * ALB_PLC
    0.416056 ** exp(lp) * 100
})
library(shiny)
shinyServer(function(input, output){
    data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$CCA))& as.numeric(input$CCA)>=7& as.numeric(input$CCA)<=14, 'Please input a valid CCA'))
        CCA= as.numeric(input$CCA)
        validate(need(!is.na(as.numeric(input$METSITE))& as.numeric(input$METSITE)>=1& as.numeric(input$METSITE)<=7, 'Please input a valid METSITE'))
        METSITE= as.numeric(input$METSITE)
        validate(need(!is.na(as.numeric(input$Time))& as.numeric(input$Time)>=0& as.numeric(input$Time)<=300, 'Please input a valid Time'))
        Time= as.numeric(input$Time)
        validate(need(!is.na(as.numeric(input$ALB_PLC))& as.numeric(input$ALB_PLC)>=0& as.numeric(input$ALB_PLC)<=6, 'Please input a valid ALB_PLC'))
        ALB_PLC= as.numeric(input$ALB_PLC)
        validate(need(!is.na(as.numeric(input$ALK))& as.numeric(input$ALK)>=0& as.numeric(input$ALK)<=6, 'Please input a valid ALK'))
        ALK= as.numeric(input$ALK)
        validate(need(!is.na(as.numeric(input$LDHULN))& as.numeric(input$LDHULN)>=0& as.numeric(input$LDHULN)<=8, 'Please input a valid LDHULN'))
        LDHULN= as.numeric(input$LDHULN)
        LUNGGP = factor(input$LUNGGP, levels = c('No', 'Yes'))
        LIVERGP = factor(input$LIVERGP, levels = c('No', 'Yes'))
        METBONYN = factor(input$METBONYN, levels = c('No', 'Yes'))
        NEPGP = factor(input$NEPGP, levels = c('No', 'Yes'))
        THRGRP = factor(input$THRGRP, levels = c('No', 'Yes'))
        ECOGGP = factor(input$ECOGGP, levels = c('0', '1'))
        neutrophil = factor(input$neutrophil, levels = c(">= ULN", "< ULN"))
        HGBGP = factor(input$HGBGP, levels = c(">= LLN", "< LLN"))
        data <- data.frame(CCA = CCA,
                           METSITE = METSITE,
                           Time = Time,
                           ALB_PLC = ALB_PLC,
                           ALK = ALK,
                           LDHULN = LDHULN,
                           LUNGGP = LUNGGP,
                           LIVERGP = LIVERGP,
                           METBONYN = METBONYN,
                           NEPGP = NEPGP,
                           THRGRP = THRGRP,
                           ECOGGP = ECOGGP,
                           neutrophil = neutrophil,
                           HGBGP = HGBGP)
        data})
    output$result <- renderDataTable({data = data()
    prob.sunitinib <- paste(ifelse(round(eval(predict.sunitinib, data), 0) < 1, "<1", ifelse(round(eval(predict.sunitinib, data), 0) > 99, ">99", round(eval(predict.sunitinib, data), 0))), "%")
    prob.pazopanib <- paste(ifelse(round(eval(predict.pazopanib, data), 0) < 1, "<1", ifelse(round(eval(predict.pazopanib, data), 0) > 99, ">99", round(eval(predict.pazopanib, data), 0))), "%")
    res = data.frame(Result = c("Predicted Probability of 12-Month Progression-Free Survival, Treated with Sunitinib [1]","Predicted Probability of 12-Month Progression-Free Survival, Treated with Pazopanib[2]"),
                     Probability = c(prob.sunitinib, prob.pazopanib))
    
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