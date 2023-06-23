predict.mortality <- expression({
    res <- data.frame(yr5 = NA, yr10 = NA, yr15 = NA)
    if (is.na(PSADT)){
        res5yr = 1 - (0.9948184**exp(0.015665516 * AGEYr - 
                                         6.1788625e-05 * max(AGEYr - 52, 0)**3 + 
                                         0.00013902441 * max(AGEYr - 62, 0)**3 - 
                                         7.7235781e-05 * max(AGEYr - 70, 0)**3 - 
                                         0.0070272476 * 0 - 
                                         0.00022614896 * max(0 + 20, 0)**3 + 
                                         0.0005276809 * max(0 + 12, 0)**3 -
                                         0.00030153194 * max(0 + 6, 0)**3 - 
                                         0.19575735 * TIME_FAILURE + 
                                         0.0050977464 * max(TIME_FAILURE - 0.25833333, 0)**3 - 
                                         0.0067847704 * max(TIME_FAILURE - 2.175, 0)**3 + 
                                         0.001687024 * max(TIME_FAILURE - 7.9666667, 0)**3 + 
                                         0.88408075 * min(REC_PSA, 20) - 
                                         0.19154029 * max(min(REC_PSA, 20) - 0.2, 0)**3 + 
                                         0.21101896 * max(min(REC_PSA, 20) - 0.56, 0)**3 - 
                                         0.019478673 * max(min(REC_PSA, 20) - 4.1, 0)**3 - 
                                         0.067191183 * PREOP_PSA + 
                                         0.00017472627 * max(PREOP_PSA - 4.148, 0)**3 - 
                                         0.00021916116 * max(PREOP_PSA - 8.1, 0)**3 + 
                                         4.4434891e-05 * max(PREOP_PSA - 23.64, 0)**3 + 
                                         0.9225297 * (RP_GLSN_New == "3+4") + 
                                         0.93713312 * (RP_GLSN_New == "4+3") + 
                                         1.2011357 * (RP_GLSN_New == "8") + 
                                         1.6656093 * (RP_GLSN_New == "9") +
                                         0.53018017 * (ECE == "Present") - 
                                         0.062705917 * (MARGINS == "Positive") + 
                                         0.62161688 * (SVI == "Present") + 
                                         0.12221677 * (NUM_LN_POS_New == "Positive")))
        res10yr = 1-(0.9837605**exp(0.015665516 * AGEYr - 
                                        6.1788625e-05 * max(AGEYr - 52, 0)**3 + 
                                        0.00013902441 * max(AGEYr - 62, 0)**3 - 
                                        7.7235781e-05 * max(AGEYr - 70, 0)**3 - 
                                        0.0070272476 * 0 - 
                                        0.00022614896 * max(0 + 20, 0)**3 + 
                                        0.0005276809 * max(0 + 12, 0)**3 - 
                                        0.00030153194 * max(0 + 6, 0)**3 -  
                                        0.19575735 * TIME_FAILURE + 
                                        0.0050977464 * max(TIME_FAILURE - 0.25833333, 0)**3 - 
                                        0.0067847704 * max(TIME_FAILURE - 2.175, 0)**3 + 
                                        0.001687024 * max(TIME_FAILURE - 7.9666667, 0)**3 + 
                                        0.88408075 * min(REC_PSA, 20) - 
                                        0.19154029 * max(min(REC_PSA, 20) - 0.2, 0)**3 + 
                                        0.21101896 * max(min(REC_PSA, 20) - 0.56, 0)**3 - 
                                        0.019478673 * max(min(REC_PSA, 20) - 4.1, 0)**3 - 
                                        0.067191183 * PREOP_PSA + 
                                        0.00017472627 * max(PREOP_PSA - 4.148, 0)**3 - 
                                        0.00021916116 * max(PREOP_PSA - 8.1, 0)**3 + 
                                        4.4434891e-05 * max(PREOP_PSA - 23.64, 0)**3 + 
                                        0.9225297 * (RP_GLSN_New == "3+4") + 
                                        0.93713312 * (RP_GLSN_New == "4+3") + 
                                        1.2011357 * (RP_GLSN_New == "8") + 
                                        1.6656093 * (RP_GLSN_New == "9") +
                                        0.53018017 * (ECE == "Present") - 
                                        0.062705917 * (MARGINS == "Positive") + 
                                        0.62161688 * (SVI == "Present") + 
                                        0.12221677 * (NUM_LN_POS_New == "Positive")))
        res15yr = 1-(0.9710129**exp(0.015665516 * AGEYr - 
                                        6.1788625e-05 * max(AGEYr - 52, 0)**3 + 
                                        0.00013902441 * max(AGEYr - 62, 0)**3 - 
                                        7.7235781e-05 * max(AGEYr - 70, 0)**3 - 
                                        0.0070272476 * 0 - 
                                        0.00022614896 * max(0 + 20, 0)**3 + 
                                        0.0005276809 * max(0 + 12, 0)**3 - 
                                        0.00030153194 * max(0 + 6, 0)**3 - 
                                        0.19575735 * TIME_FAILURE + 
                                        0.0050977464 * max(TIME_FAILURE - 0.25833333, 0)**3 - 
                                        0.0067847704 * max(TIME_FAILURE - 2.175, 0)**3 + 
                                        0.001687024 * max(TIME_FAILURE - 7.9666667, 0)**3 + 
                                        0.88408075 * min(REC_PSA, 20) - 
                                        0.19154029 * max(min(REC_PSA, 20) - 0.2, 0)**3 + 
                                        0.21101896 * max(min(REC_PSA, 20) - 0.56, 0)**3 - 
                                        0.019478673 * max(min(REC_PSA, 20) - 4.1, 0)**3 - 
                                        0.067191183 * PREOP_PSA + 
                                        0.00017472627 * max(PREOP_PSA - 4.148, 0)**3 - 
                                        0.00021916116 * max(PREOP_PSA - 8.1, 0)**3 + 
                                        4.4434891e-05 * max(PREOP_PSA - 23.64, 0)**3 + 
                                        0.9225297 * (RP_GLSN_New == "3+4") + 
                                        0.93713312 * (RP_GLSN_New == "4+3") + 
                                        1.2011357 * (RP_GLSN_New == "8") + 
                                        1.6656093 * (RP_GLSN_New == "9") +
                                        0.53018017 * (ECE == "Present") - 
                                        0.062705917 * (MARGINS == "Positive") + 
                                        0.62161688 * (SVI == "Present") + 
                                        0.12221677 * (NUM_LN_POS_New == "Positive")))
    } else {
        res5yr = 1-(0.8982308**exp(-0.041859658 * AGEYr + 
                                       0.00013684103 * max(AGEYr - 53, 0)**3 - 
                                       0.00033232823 * max(AGEYr - 63, 0)**3 + 
                                       0.00019548719 * max(AGEYr - 70, 0)**3 - 
                                       0.067285939 * 0 + 
                                       0.00039401463 * max(0 + 21, 0)**3 - 
                                       0.00091936747 * max(0 + 13, 0)**3 + 
                                       0.00052535284 * max(0 + 7, 0)**3 + 
                                       0.00055743143 * TIME_FAILURE + 
                                       0.0014587674 * max(TIME_FAILURE - 0.61, 0)**3 - 
                                       0.0019954124 * max(TIME_FAILURE - 2.8583333, 0)**3 + 
                                       0.00053664501 * max(TIME_FAILURE - 8.97, 0)**3 - 
                                       0.11100033 * PSADT + 
                                       0.00018644558 * max(PSADT - 3, 0)**3 - 
                                       0.00024368764 * max(PSADT - 10, 0)**3 + 
                                       5.7242063e-05 * max(PSADT - 32.8, 0)**3 + 
                                       0.67802567 * min(REC_PSA, 20) - 
                                       0.16055363 * max(min(REC_PSA, 20) - 0.25, 0)**3 + 
                                       0.17762343 * max(min(REC_PSA, 20) - 0.6, 0)**3 - 
                                       0.017069797 * max(min(REC_PSA, 20) - 3.892, 0)**3 -
                                       0.10098806 * PREOP_PSA +
                                       0.00036162407 * max(PREOP_PSA - 4.2, 0)**3 - 
                                       0.00046029054 * max(PREOP_PSA - 8.5, 0)**3 + 
                                       9.8666466e-05 * max(PREOP_PSA - 24.26, 0)**3 + 
                                       0.56708509 * (RP_GLSN_New == "3+4") + 
                                       0.45585755 * (RP_GLSN_New == "4+3") + 
                                       0.70940336 * (RP_GLSN_New == "8") + 
                                       1.5113785 * (RP_GLSN_New == "9") + 
                                       0.29032458 * (ECE == "Present") - 
                                       0.0098008475 * (MARGINS == "Positive") + 
                                       0.97419957 * (SVI == "Present") + 
                                       0.34321528 * (NUM_LN_POS_New == "Positive")))
        res10yr = 1-(0.6720452**exp(-0.041859658 * AGEYr + 
                                        0.00013684103 * max(AGEYr - 53, 0)**3 - 
                                        0.00033232823 * max(AGEYr - 63, 0)**3 + 
                                        0.00019548719 * max(AGEYr - 70, 0)**3 - 
                                        0.067285939 * 0 + 
                                        0.00039401463 * max(0 + 21, 0)**3 - 
                                        0.00091936747 * max(0 + 13, 0)**3 + 
                                        0.00052535284 * max(0 + 7, 0)**3 +  
                                        0.00055743143 * TIME_FAILURE + 
                                        0.0014587674 * max(TIME_FAILURE - 0.61, 0)**3 - 
                                        0.0019954124 * max(TIME_FAILURE - 2.8583333, 0)**3 + 
                                        0.00053664501 * max(TIME_FAILURE - 8.97, 0)**3 - 
                                        0.11100033 * PSADT + 
                                        0.00018644558 * max(PSADT - 3, 0)**3 - 
                                        0.00024368764 * max(PSADT - 10, 0)**3 + 
                                        5.7242063e-05 * max(PSADT - 32.8, 0)**3 + 
                                        0.67802567 * min(REC_PSA, 20) - 
                                        0.16055363 * max(min(REC_PSA, 20) - 0.25, 0)**3 + 
                                        0.17762343 * max(min(REC_PSA, 20) - 0.6, 0)**3 - 
                                        0.017069797 * max(min(REC_PSA, 20) - 3.892, 0)**3 - 
                                        0.10098806 *  PREOP_PSA + 
                                        0.00036162407 * max(PREOP_PSA - 4.2, 0)**3 - 
                                        0.00046029054 * max(PREOP_PSA - 8.5, 0)**3 + 
                                        9.8666466e-05 * max(PREOP_PSA - 24.26, 0)**3 + 
                                        0.56708509 * (RP_GLSN_New == "3+4") + 
                                        0.45585755 * (RP_GLSN_New == "4+3") + 
                                        0.70940336 * (RP_GLSN_New == "8") + 
                                        1.5113785 * (RP_GLSN_New == "9") +
                                        0.29032458 * (ECE == "Present") - 
                                        0.0098008475 * (MARGINS == "Positive") + 
                                        0.97419957 * (SVI == "Present") + 
                                        0.34321528 * (NUM_LN_POS_New == "Positive")))
        res15yr = 1-(0.5353628**exp(-0.041859658 * AGEYr + 
                                        0.00013684103 * max(AGEYr - 53, 0)**3 - 
                                        0.00033232823 * max(AGEYr - 63, 0)**3 + 
                                        0.00019548719 * max(AGEYr - 70, 0)**3 - 
                                        0.067285939 * 0 + 
                                        0.00039401463 * max(0 + 21, 0)**3 - 
                                        0.00091936747 * max(0 + 13, 0)**3 + 
                                        0.00052535284 * max(0 + 7, 0)**3 +  
                                        0.00055743143 * TIME_FAILURE + 
                                        0.0014587674 * max(TIME_FAILURE - 0.61, 0)**3 - 
                                        0.0019954124 * max(TIME_FAILURE - 2.8583333, 0)**3 + 
                                        0.00053664501 * max(TIME_FAILURE - 8.97, 0)**3 - 
                                        0.11100033 * PSADT + 
                                        0.00018644558 * max(PSADT - 3, 0)**3 - 
                                        0.00024368764 * max(PSADT - 10, 0)**3 + 
                                        5.7242063e-05 * max(PSADT - 32.8, 0)**3 + 
                                        0.67802567 * min(REC_PSA, 20) - 
                                        0.16055363 * max(min(REC_PSA, 20) - 0.25, 0)**3 + 
                                        0.17762343 * max(min(REC_PSA, 20) - 0.6, 0)**3 - 
                                        0.017069797 * max(min(REC_PSA, 20) - 3.892, 0)**3 - 
                                        0.10098806 *  PREOP_PSA + 
                                        0.00036162407 * max(PREOP_PSA - 4.2, 0)**3 - 
                                        0.00046029054 * max(PREOP_PSA - 8.5, 0)**3 + 
                                        9.8666466e-05 * max(PREOP_PSA - 24.26, 0)**3 + 
                                        0.56708509 * (RP_GLSN_New == "3+4") + 
                                        0.45585755 * (RP_GLSN_New == "4+3") + 
                                        0.70940336 * (RP_GLSN_New == "8") + 
                                        1.5113785 * (RP_GLSN_New == "9") +
                                        0.29032458 * (ECE == "Present") - 
                                        0.0098008475 * (MARGINS == "Positive") + 
                                        0.97419957 * (SVI == "Present") + 
                                        0.34321528 * (NUM_LN_POS_New == "Positive")))
    }
    res$yr5 <- paste(ifelse(round(100 * res5yr, 0) < 1, "<1", ifelse(round(100 * res5yr, 0) > 99, ">99", round(100 * res5yr, 0))), "%")
    res$yr10 <- paste(ifelse(round(100 * res10yr, 0) < 1, "<1", ifelse(round(100 * res10yr, 0) > 99, ">99", round(100 * res10yr, 0))), "%")
    res$yr15 <- paste(ifelse(round(100 * res15yr, 0) < 1, "<1", ifelse(round(100 * res15yr, 0) > 99, ">99", round(100 * res15yr, 0))), "%")
    res
})

    
    shinyServer(function(input, output){
        data <- eventReactive(input$goButton, {
            validate(need(!is.na(as.numeric(input$AGEYr))& as.numeric(input$AGEYr)>=40& as.numeric(input$AGEYr)<=80, 'Please input a valid AGEYr'))
            AGEYr= as.numeric(input$AGEYr)
            validate(need(!is.na(as.numeric(input$TIME_FAILURE))& as.numeric(input$TIME_FAILURE)>=0& as.numeric(input$TIME_FAILURE)<=18, 'Please input a valid TIME_FAILURE'))
            TIME_FAILURE= as.numeric(input$TIME_FAILURE)
            validate(need(is.na(as.numeric(input$PSADT))|(!is.na(as.numeric(input$PSADT))& as.numeric(input$PSADT)>=0& as.numeric(input$PSADT)<=100), 'Please input a valid PSADT'))
            PSADT= ifelse(is.na(as.numeric(input$PSADT)), NA, as.numeric(input$PSADT))
            validate(need(!is.na(as.numeric(input$REC_PSA))& as.numeric(input$REC_PSA)>=0.2& as.numeric(input$REC_PSA)<=20, 'Please input a valid REC_PSA'))
            REC_PSA= as.numeric(input$REC_PSA)
            validate(need(!is.na(as.numeric(input$PREOP_PSA))& as.numeric(input$PREOP_PSA)>=0& as.numeric(input$PREOP_PSA)<=100, 'Please input a valid PREOP_PSA'))
            PREOP_PSA= as.numeric(input$PREOP_PSA)
            RP_GLSN_New = factor(input$RP_GLSN_New, levels = c('6', '3+4', '4+3', '8', '9'))
            ECE = factor(input$ECE, levels = c('Absent', 'Present'))
            MARGINS = factor(input$MARGINS, levels = c('Positive', 'Negative'))
            SVI = factor(input$SVI, levels = c('Absent', 'Present'))
            NUM_LN_POS_New = factor(input$NUM_LN_POS_New, levels = c('Positive', 'Negative'))
            data <- data.frame(AGEYr = AGEYr,
                               TIME_FAILURE = TIME_FAILURE,
                               PSADT = PSADT,
                               REC_PSA = REC_PSA,
                               PREOP_PSA = PREOP_PSA,
                               RP_GLSN_New = RP_GLSN_New,
                               ECE = ECE,
                               MARGINS = MARGINS,
                               SVI = SVI,
                               NUM_LN_POS_New = NUM_LN_POS_New)
            data})
        output$result <- renderDataTable({data = data()
        res <- eval(predict.mortality, data)
        res = data.frame(Result = c("5-year Prostate Cancer-Specific Death Probability","10-year Prostate Cancer-Specific Death Probability","15-year Prostate Cancer-Specific Death Probability"),
                         Probability = c(res$yr5, res$yr10, res$yr15))
        
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
    
