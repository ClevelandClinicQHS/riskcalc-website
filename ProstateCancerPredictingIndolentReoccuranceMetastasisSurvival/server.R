predict.10yr.ccrp <- expression({
    if (prepsa > 0.4 & prepsa < 61 & Agex > 32 & Agex < 88){
        lp = 1.0034901 * (allGleason %in% c('4+1', '4+2', '4+3', '4+4', '4+5', '5+1', '5+2', '5+3', '5+4', '5+5')) + 
            0.82784363 * (allGleason %in% c('2+4', '2+5', '3+4', '3+5', '4+4', '4+5', '5+4', '5+5')) + 
            0.022147732 * prepsa + 
            0.5520105 * (cStage  == "T1C") - 
            0.05961104 * (cStage  == "T2A") + 
            0.80599007 * (cStage  == "T2B") + 
            1.05441 * (cStage  == "T2C") + 
            1.8360111 * (cStage  == "T3") - 
            0.00069928007 * Agex - 
            0.16939096 * (0) - 
            0.00010641441 * max(0 - 8, 0)**3 + 
            0.00027667748 * max(0 - 16, 0)**3 - 
            0.00017026306 * max(0 - 21, 0)**3
        paste(ifelse(round(0.998997 ** exp(lp) * 100, 0) < 1, "<1", 
                     ifelse(round(0.998997 ** exp(lp) * 100, 0) > 99, ">99", 
                            round(0.998997 ** exp(lp) * 100, 0))), "%")
    } else {
        'NA'
    }
})
predict.10yr.ccww <- expression({
    if (Agex > 43 & Agex < 77 & allGleason != '2+4' & allGleason != '4+1' & allGleason != '4+2'){
        lp = -3.4499215 + 
            0.27018563 *  ( cStage == 'T2A' ) + 
            0.27018563 *  ( cStage == 'T2B' ) + 
            0.27018563 *  ( cStage == 'T2C' ) + 
            0.57434614 *  ( cStage == 'T3A' ) + 
            0.57434614 *  ( cStage == 'T3B' ) + 
            0.57434614 *  ( cStage == 'T3C' ) - 
            0.080128454 * ( DxType == 'TURP') + 
            0.0052574876 * fCancer + 
            0.0056132526 * prepsa + 
            0.037925763 * Agex + 
            0.36574079 * (wwHormtx == 'Yes') +
            0.0027935291 * (allGleason == '4+3') + 
            0.46195895 * ( allGleason == '4+4') -
            0.15354714 * ( allGleason == '1+1') -
            0.15354714 * ( allGleason == '1+2') -
            0.15354714 * ( allGleason == '1+3') -
            0.15354714 * ( allGleason == '2+1') -
            0.15354714 * ( allGleason == '2+2') -
            0.15354714 * ( allGleason == '2+3') -
            0.15354714 * ( allGleason == '3+1') -
            0.15354714 * ( allGleason == '3+2') -
            0.15354714 * ( allGleason == '3+3') +
            1.2758902 * (allGleason == '2+5') +
            1.2758902 * (allGleason == '3+5') +
            1.2758902 * (allGleason == '4+5') +
            1.2758902 * (allGleason == '5+1') +
            1.2758902 * (allGleason == '5+2') +
            1.2758902 * (allGleason == '5+3') +
            1.2758902 * (allGleason == '5+4') +
            1.2758902 * (allGleason == '5+5')
        paste(ifelse(round(0.745022 ** exp(lp) * 100, 0) < 1, "<1", ifelse(round(0.745022 ** exp(lp) * 100, 0) > 99, ">99", round(0.745022 ** exp(lp) * 100, 0))), "%")
    } else {
        'NA'
    }
})
predict.10yr.rf3d <- expression({
    lp = 4.6985885 +
        0.1565064 * prepsa -
        0.0003298792 * max(prepsa - 0.7605, 0)**3 +
        0.0004538588 * max(prepsa - 7.3, 0)**3 -
        0.0001239796 * max(prepsa - 24.7, 0)**3 +
        0.28891432 * (cStage == "T2A") +
        0.52082767 * (cStage == "T2B") +
        0.7077829 * (cStage == "T2C") +
        0.57041908 * (cStage == "T3A") +
        1.2125269 * (cStage == "T3B") +
        1.0670943 * (cStage == "T3C") +
        0.16981384 * bg -
        0.0011397817 * max(bg - 5, 0)**3 +
        0.003419345 * max(bg - 7, 0)**3 -
        0.0022795633 * max(bg - 8, 0)**3 -
        0.2411674 * (wwHormtx == "Yes") -
        0.0009868808 * (dose100) +
        5.6350038e-10 * max((dose100) - 7020, 0)**3 -
        1.6905011e-09 * max((dose100) - 8100, 0)**3 +
        1.1270008e-09 * max((dose100) - 8640, 0)**3
    paste(ifelse(round(0.6197818**exp(lp) *100, 0) < 1, "<1", ifelse(round(0.6197818**exp(lp) *100, 0) > 99, ">99", round(0.6197818**exp(lp) *100, 0))), "%")
})
predict.5yr.rf3d <- expression({
    if (prepsa > 0 & prepsa < 561 & cStage != 'T1A' & cStage != 'T1B') {
        lp = 4.6985885 +
            0.1565064 * prepsa -
            0.0003298792 * max(prepsa - 0.7605, 0)**3 +
            0.0004538588 * max(prepsa - 7.3, 0)**3 -
            0.0001239796 * max(prepsa - 24.7, 0)**3 +
            0.28891432 * (cStage == 'T2A') +
            0.52082767 * (cStage == 'T2B') +
            0.7077829 * (cStage == 'T2C') +
            0.57041908 * (cStage == 'T3A') +
            1.2125269 * (cStage == 'T3B') +
            1.0670943 * (cStage == 'T3C') +
            0.16981384 * bg -
            0.0011397817 * max(bg - 5, 0)**3 +
            0.003419345 * max(bg - 7, 0)**3 -
            0.0022795633 * max(bg - 8, 0)**3 -
            0.2411674 * (wwHormtx == 'Yes') -
            0.0009868808 * (dose100) +
            5.6350038e-10 * max((dose100) - 7020, 0)**3 -
            1.6905011e-09 * max((dose100) - 8100, 0)**3 +
            1.1270008e-09 * max((dose100) - 8640, 0)**3
        paste(ifelse(round(0.7883817 ** exp(lp) * 100, 0) < 1, "<1", ifelse(round(0.7883817 ** exp(lp) * 100, 0) > 99, ">99", round(0.7883817 ** exp(lp) * 100, 0))), "%")
    } else {
        'NA'
    }
})
predict.5y.rfrp <- expression({
    lp = -1.547257 + 
        0.31586672 * log(prepsa) - 
        0.028514161 * max(log(prepsa) - 0.18255172, 0)**3 + 
        1.5861474 * max(log(prepsa) - 1.5260563, 0)**3 - 
        3.4262086 * max(log(prepsa) - 1.9169226, 0)**3 + 
        2.1286971 * max(log(prepsa) - 2.3608539, 0)**3 - 
        0.26012179 * max(log(prepsa) - 3.3565481, 0)**3 - 
        0.7022366 * (cStage == 'T1C') - 
        0.40668754 * (cStage == 'T2A') + 
        0.22358978 * (cStage == 'T2B') + 
        0.021192631 * (cStage == 'T2C') + 
        0.7597205 * (cStage == 'T3A') + 
        0.71327666 * (allGleason == '1+3') + 
        0.71327666 * (allGleason == '2+3') + 
        0.80371467 * (allGleason == '3+1') + 
        0.80371467 * (allGleason == '3+2') + 
        0.77753355 * (allGleason == '3+3') + 
        1.4273016 * (allGleason == '2+4') + 
        1.4273016 * (allGleason == '2+5') + 
        1.4273016 * (allGleason == '3+4') + 
        1.4273016 * (allGleason == '3+5') + 
        1.4957297 * (allGleason == '4+1') + 
        1.4957297 * (allGleason == '4+2') + 
        1.4957297 * (allGleason == '4+3') + 
        1.4957297 * (allGleason == '4+4') + 
        1.4957297 * (allGleason == '4+5') + 
        1.4957297 * (allGleason == '5+1') + 
        1.4957297 * (allGleason == '5+2') + 
        1.4957297 * (allGleason == '5+3') + 
        1.4957297 * (allGleason == '5+4') + 
        1.4957297 * (allGleason == '5+5')
    paste(ifelse(round(0.7800056 ** exp(lp) * 100, 0) < 1, "<1", ifelse(round(0.7800056 ** exp(lp) * 100, 0) > 99, ">99", round(0.7800056 ** exp(lp) * 100, 0))), "%")
})
predict.10yr.rfrp <- expression({
    if (is.na(experience)) {
        coeff = 219.96689 +
            0.1823754 *prepsa -
            0.0011556537 * max(prepsa - 3.82, 0)**3 +
            0.001449652 * max(prepsa - 7, 0)**3 -
            0.0002939983 * max(prepsa - 19.5, 0)**3 +
            0.32509621 * (cStage == "T2A") +
            0.51418586 * (cStage == "T2B") +
            0.61368122 * (cStage == "T2C") +
            0.98322682 * (cStage == "T3A") +
            0.32458373 * bg +
            0.034110957 * max(bg - 5, 0)**3 -
            0.068221914 * max(bg - 6, 0)**3 +
            0.034110957 * max(bg - 7, 0)**3 -
            0.11205722 * 2005 +
            0.00075287246 * max(2005 - 1992, 0)**3 -
            0.0015057449 * max(2005 - 1997, 0)**3 +
            0.00075287246 * max(2005 - 2002, 0)**3
        paste(ifelse(round(0.8204934**exp(coeff) * 100, 0) < 1, "<1", ifelse(round(0.8204934**exp(coeff) * 100, 0) > 99, ">99", round(0.8204934**exp(coeff) * 100, 0))), "%")
    } else{
        coeff = 181.04454 +
            0.17269419 *prepsa -
            0.0010830441 * max(prepsa - 3.82, 0)**3 +
            0.0013585705 * max(prepsa - 7, 0)**3 -
            0.00027552642 * max(prepsa - 19.5, 0)**3 +
            0.29837268 * (cStage == "T2A") +
            0.49782693 * (cStage == "T2B") +
            0.60926092 * (cStage == "T2C") +
            1.0809441 * (cStage == "T3A") -
            0.091766694 * 2005 +
            0.00074336197 * max(2005 - 1992, 0)**3 -
            0.0014867239 * max(2005 - 1997, 0)**3 +
            0.00074336197 * max(2005 - 2002, 0)**3 -
            0.0035042414 *experience +
            0.00000006238945 * max(experience - 12, 0)**3 -
            0.000000097561906 * max(experience - 94, 0)**3 +
            0.000000037810123 * max(experience - 259, 0)**3 -
            0.0000000027653502 * max(experience - 565, 0)**3 +
            0.00000000012768218 * max(experience - 1501.75, 0)**3 +
            0.1030431 * bg +
            0.16870912 * max(bg - 5, 0)**3 -
            0.49008241 * max(bg - 6, 0)**3 +
            0.47403745 * max(bg - 7, 0)**3 -
            0.15266417 * max(bg - 8, 0)**3
        paste(ifelse(round(0.8263859**exp(coeff) * 100, 0) < 1, "<1", ifelse(round(0.8263859**exp(coeff) * 100, 0) > 99, ">99", round(0.8263859**exp(coeff) * 100, 0))), "%")
    }
})
predict.5yr.pm3d <- expression({
    if (prepsa > 0 & prepsa < 561 & cStage != 'T1A' & cStage != 'T1B') {
        lp = 0.082864745 * log(prepsa) +
            0.055537863 * max(log(prepsa) - 1.458615, 0)**3 -
            0.091092347 * max(log(prepsa) - 2.2082744, 0)**3 +
            0.035554484 * max(log(prepsa) - 3.3792795, 0)**3 -
            0.10662157 * (cStage == 'T2A') +
            0.50942232 * (cStage == 'T2B') +
            0.7489749 * (cStage == 'T2C') +
            1.2236686 * (cStage == 'T3A') +
            1.2413654 * (cStage == 'T3B') +
            1.6874357 * (cStage == 'T3C') +
            0.0062029045 * bg +
            0.035335069 * max(bg - 5, 0)**3 -
            0.053002604 * max(bg - 6, 0)**3 +
            0.017667535 * max(bg - 8, 0)**3 -
            0.00031644862 * Agex +
            1.3389403e-06 * max(Agex - 59, 0)**3 -
            3.251712e-06 * max(Agex - 69, 0)**3 +
            1.9127718e-06 * max(Agex - 76, 0)**3
        paste(round((1 - 0.9702835 ** exp(lp)) * 100, 0), "%")
    } else {
        'NA'        
    }
})
predict.36mo.rp <- expression({
    if (cStage != 'T1A'& cStage != 'T1B' & cStage != 'T3B' & cStage != 'T3C' &Agex > 35 & Agex < 78 & as.character(allGleason) %in% c('2+3', '3+3', '3+5','4+4','5+5','3+4','4+3','4+5')){
        lp = 0.60626985 +
            0.043284256 * prepsa -
            0.0024825047 * max(prepsa - 2.822, 0)**3 +
            0.00373105 * max(prepsa - 5.39, 0)**3 -
            0.0012485453 * max(prepsa - 10.496, 0)**3 -
            0.22683476 * (cStage == 'T2A') +
            0.09194425 * (cStage == 'T2B') -
            0.28769306 * (cStage == 'T2C') -
            0.91084568 * (cStage == 'T3A') -
            0.71478114 * (PreTxEF == 'Normal full') -
            0.71478114 * (PreTxEF == 'Normal but decreased') * 2 -
            0.30282737 * (allGleason == '3+4') -
            0.30282737 * (allGleason == '3+5') -
            0.31284937 * (allGleason == '4+3') -
            0.82813045 * (allGleason == '4+4') -
            0.82813045 * (allGleason == '4+5') -
            0.82813045 * (allGleason == '5+5') +
            (0.10435973 * 36) -
            4.0497004e-05 * max(36 - 6, 0)**3 +
            6.4795206e-05 * max(36 - 24, 0)**3 -
            2.4298202e-05 * max(36 - 54, 0)**3 -
            0.0364062 * Agex -
            0.00014885488 * max(Agex - 48.56, 0)**3 +
            0.00031407727 * max(Agex - 58.17, 0)**3 -
            0.00016522239 * max(Agex - 66.828, 0)**3
        paste(round(100.0/(1.0 + exp(-lp)), 0), "%")
    } else{
        'NA'
    }
})
predict.ind.rp <- expression({
    if (prepsa > 0&prepsa < 20 &cStage != 'T1A'& cStage != 'T1B' & cStage != 'T2B'&cStage != 'T2C'&cStage != 'T3A'&cStage != 'T3B'&cStage != 'T3C' & as.character(allGleason) %in% c('2+2', '2+3', '3+2','3+3')) {
        lp = -0.51558795 -
            1.0218963 * log(prepsa) -
            0.08358935 * max(log(prepsa) - 1.1631508, 0)**3 +
            0.1834116 * max(log(prepsa) - 1.9021075, 0)**3 -
            0.09982225 * max(log(prepsa) - 2.5208965, 0)**3 +
            0.13098492 * (cStage == 'T2A') -
            0.28458676 * (allGleason == '3+2') -
            0.28458676 * (allGleason == '3+3') -
            0.21430889 * (allGleason == '2+3') -
            0.21430889 * (allGleason == '3+3') +
            0.016324903 * usvol +
            2.7713105e-06 * max(usvol - 25, 0)**3 -
            4.149215e-06 * max(usvol - 41, 0)**3 +
            1.3779045e-06 * max(usvol - 73.18, 0)**3 -
            0.56609826 * log(totalca) -
            0.045581669 * max(log(totalca) + 0.54728994, 0)**3 +
            0.11078316 * max(log(totalca) - 1.1474025, 0)**3 -
            0.06520149 * max(log(totalca) - 2.3321439, 0)**3 +
            0.015508954 * totalneg
        paste(round(100.0/(1.0 + exp(-lp)), 0), "%")
    } else {
        'NA'
    }
})


library(shiny)
shinyServer(function(input, output){
    data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$Agex))& as.numeric(input$Agex)>=0, 'Please input a valid Agex'))
        Agex= as.numeric(input$Agex)
        allGleason = factor(input$allGleason, levels = c('1+1', '1+2', '1+3', '2+1', '2+2', '2+3', '2+4', '2+5', '3+1', '3+2', '3+3', '3+4', '3+5', '4+1', '4+2', '4+3', '4+4', '4+5', '5+1', '5+2', '5+3', '5+4', '5+5'))
        cStage = factor(input$cStage, levels = c('T1A', 'T1B', 'T1C', 'T2A', 'T2B', 'T2C', 'T3A', 'T3B', 'T3C'))
        validate(need(is.na(as.numeric(input$experience)) |(!is.na(as.numeric(input$experience))& as.numeric(input$experience)>=0& as.numeric(input$experience)<=2000), 'Please input a valid experience'))
        experience= ifelse(is.na(as.numeric(input$experience)), NA, as.numeric(input$experience))
        DxType = factor(input$DxType, levels = c('TURP', 'Needle Biopsy'))
        validate(need(!is.na(as.numeric(input$totalneg))& as.numeric(input$totalneg)>=0, 'Please input a valid totalneg'))
        totalneg= as.numeric(input$totalneg)
        validate(need(!is.na(as.numeric(input$totalca))& as.numeric(input$totalca)>=0, 'Please input a valid totalca'))
        totalca= as.numeric(input$totalca)
        wwHormtx = factor(input$wwHormtx, levels = c('No', 'Yes'))
        validate(need(!is.na(as.numeric(input$fCancer))& as.numeric(input$fCancer)>=0& as.numeric(input$fCancer)<=100, 'Please input a valid fCancer'))
        fCancer= as.numeric(input$fCancer)
        validate(need(!is.na(as.numeric(input$perbx))& as.numeric(input$perbx)>=0& as.numeric(input$perbx)<=100, 'Please input a valid perbx'))
        perbx= as.numeric(input$perbx)
        PreTxEF = factor(input$PreTxEF, levels = c('Normal full', 'Normal but decreased'))
        validate(need(!is.na(as.numeric(input$prepsa))& as.numeric(input$prepsa)>=0& as.numeric(input$prepsa)<=50, 'Please input a valid prepsa'))
        prepsa= as.numeric(input$prepsa)
        validate(need(!is.na(as.numeric(input$dose100))& as.numeric(input$dose100)>=6400& as.numeric(input$dose100)<=8600, 'Please input a valid dose100'))
        dose100= as.numeric(input$dose100)
        validate(need(!is.na(as.numeric(input$usvol))& as.numeric(input$usvol)>=0& as.numeric(input$usvol)<=200, 'Please input a valid usvol'))
        usvol= as.numeric(input$usvol)
        bg = as.numeric(substr(as.character(allGleason), 1, 1)) + as.numeric(substr(as.character(allGleason), 3, 3))
        data <- data.frame(Agex = Agex,
                           allGleason = allGleason,
                           cStage = cStage,
                           experience = experience,
                           DxType = DxType,
                           totalneg = totalneg,
                           totalca = totalca,
                           wwHormtx = wwHormtx,
                           fCancer = fCancer,
                           perbx = perbx,
                           PreTxEF = PreTxEF,
                           prepsa = prepsa,
                           dose100 = dose100,
                           usvol = usvol,
                           bg = bg)
        data})
    output$result <- renderDataTable({data = data()
    prob.10yr.rfrp <- eval(predict.10yr.rfrp, data)
    prob.5yr.rfrp <- eval(predict.5y.rfrp, data)
    prob.10yr.rf3d <- eval(predict.10yr.rf3d, data)
    prob.5yr.rf3d <- eval(predict.5yr.rf3d, data)
    prob.5yr.pm3d <- eval(predict.5yr.pm3d, data)
    prob.10yr.ccrp <- eval(predict.10yr.ccrp, data)
    prob.10yr.ccww <- eval(predict.10yr.ccww, data)
    prob.36mon <- eval(predict.36mo.rp, data)
    prob.ind <- eval(predict.ind.rp, data)
    res = data.frame(Result = c("10-Year Recurrence-Free Percentage - Radical Prostatectomy[8]",
                                "5-Year Recurrence-Free Percentage[4]",
                                "10-Year Recurrence-Free Percentage - 3D-CRT[5]",
                                "5-Year Recurrence-Free Percentage - 3D-CRT[5]",
                                "5-Year Percentage of Metastasis - 3D-CRT[3]",
                                "10-Year Cancer-Specific Survival Percentage - Radical Prostatectomy[1]",
                                "10-Year Cancer-Specific Survival Percentage - Watchful Waiting[6]",
                                "36-Month Percentage of Attaining Trifecta - Radical Prostatectomy[7]",
                                "Indolent Prostate Cancer Percentage - Radical Prostatectomy[2]"),
                     Probability = c(prob.10yr.rfrp,
                                     prob.5yr.rfrp,
                                     prob.10yr.rf3d,
                                     prob.5yr.rf3d,
                                     prob.5yr.pm3d,
                                     prob.10yr.ccrp,
                                     prob.10yr.ccww,
                                     prob.36mon,
                                     prob.ind))
    
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
