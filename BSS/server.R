predict.intubation.yes.primary <- expression({
    lp = 1.9959529 - 0.036889839 * Weight..kg. + 0.13560424 * (Comorbid == "Yes") + 0.15972092 * Time.from.Hospital.Admission.to.ICU.Admission - 
        0.1114488 * max(Time.from.Hospital.Admission.to.ICU.Admission - 0.01, 0)**3 + 
        0.12408732 * max(Time.from.Hospital.Admission.to.ICU.Admission - 0.23, 0)**3 - 
        0.012638524 * max(Time.from.Hospital.Admission.to.ICU.Admission - 2.17, 0)**3 - 0.0023321221 * High.HR + 3.6966233e-07 * 
        max(High.HR - 130, 0)**3 - 1.2014026e-06 * max(High.HR - 184, 0)**3 + 8.3174023e-07 * max(High.HR - 208, 0)**3 + 
        0.0027873642 * Low.HR - 7.159136e-07 * max(Low.HR - 98, 0)**3 + 1.3806905e-06 * max(Low.HR - 124, 0)**3 - 
        6.6477692e-07 * max(Low.HR - 152, 0)**3 - 0.0019094509 * High.RR + 1.9546105e-06 * max(High.RR - 30, 0)**3 - 
        3.2576841e-06 * max(High.RR - 52, 0)**3 + 1.3030736e-06 * max(High.RR - 85, 0)**3 - 
        0.0011397272 * High.T + 0.016677747 * max(High.T - 36.9, 0)**3 - 0.025658073 * max(High.T - 37.6, 0)**3 + 
        0.0089803254 * max(High.T - 38.9, 0)**3 + 0.072416186 * 
        (Low.PH.factor == "Abnormal") + 0.0040877382 * Highest.PCO2
    exp(lp) - 1
})

predict.intubation.yes.secondary <- expression({
    lp = 2.6640851 - 0.030996834 * Weight..kg. + 0.1623894 * (Comorbid == "Yes") + 0.17578254 * Time.from.Hospital.Admission.to.ICU.Admission - 
        0.12624968 * max(Time.from.Hospital.Admission.to.ICU.Admission - 0.01, 0)**3 + 
        0.14056665 * max(Time.from.Hospital.Admission.to.ICU.Admission - 0.23, 0)**3 - 
        0.014316974 * max(Time.from.Hospital.Admission.to.ICU.Admission - 2.17, 0)**3 - 
        0.0020638418 * High.HR + 3.6849538e-07 * max(High.HR - 130, 0)**3 - 
        1.19761e-06 * max(High.HR - 184, 0)**3 + 8.2911461e-07 * max(High.HR - 208, 0)**3 + 
        0.0013753077 * Low.HR - 3.4492083e-07 * max(Low.HR - 98, 0)**3 + 
        6.6520445e-07 * max(Low.HR - 124, 0)**3 - 
        3.2028362e-07 * max(Low.HR - 152, 0)**3 - 0.0015924939 * High.RR + 
        1.6955017e-06 * max(High.RR - 30, 0)**3 - 2.8258361e-06 * max(High.RR - 52, 0)**3 + 
        1.1303345e-06 * max(High.RR - 85, 0)**3 - 0.012051598 * High.T + 
        0.019588961 * max(High.T - 36.9, 0)**3 - 0.030136863 * max(High.T - 37.6, 0)**3 + 
        0.010547902 * max(High.T - 38.9, 0)**3 + 0.060042164 * (Low.PH.factor == "Abnormal") + 0.0033880763 * Highest.PCO2
    exp(lp) - 1
})

predict.intubation.no.primary <- expression({
    lp =  -2.0757244 - 0.023818786 * Weight..kg. + 0.1503274 * (Comorbid == "Yes") + 0.11879034 * Time.from.Hospital.Admission.to.ICU.Admission - 
        0.085557757 * max(Time.from.Hospital.Admission.to.ICU.Admission - 0.01, 0)**3 + 
        0.097176712 * max(Time.from.Hospital.Admission.to.ICU.Admission - 0.23, 0)**3 - 
        0.011618955 * max(Time.from.Hospital.Admission.to.ICU.Admission - 1.85, 0)**3 - 0.0034395603 * High.HR + 4.4392056e-07 * 
        max(High.HR - 130, 0)**3 - 1.2429776e-06 * max(High.HR - 175, 0)**3 + 
        7.9905701e-07 * max(High.HR - 200, 0)**3 - 0.00088990121 * Low.HR + 
        1.2974441e-06 * max(Low.HR - 101, 0)**3 - 2.4820671e-06 * max(Low.HR - 122, 0)**3 + 
        1.1846229e-06 * max(Low.HR - 145, 0)**3 + 0.0035470154 * High.RR + 
        1.1934782e-06 * max(High.RR - 38, 0)**3 - 2.4412054e-06 * 
        max(High.RR - 61, 0)**3 + 1.2477272e-06 * max(High.RR - 83, 0)**3 + 
        0.093230363 * High.T - 0.011961306 * max(High.T - 36.9, 0)**3 + 0.017481908 * max(High.T - 37.5, 0)**3 - 
        0.0055206026 * max(High.T - 38.8, 0)**3 + 0.092240982 * (Low.PH.factor == "Abnormal") + 0.0067734437 * Highest.PCO2
    exp(lp) - 1
})

predict.intubation.no.secondary <- expression({
    lp = -1.4683245 - 0.028457878 * Weight..kg. + 0.17759268 * (Comorbid == "Yes") + 
        0.16143399 * Time.from.Hospital.Admission.to.ICU.Admission - 
        0.10974286 * max(Time.from.Hospital.Admission.to.ICU.Admission - 0.01, 0)**3 + 
        0.12464621 * max(Time.from.Hospital.Admission.to.ICU.Admission - 0.23, 0)**3 - 
        0.014903352 * max(Time.from.Hospital.Admission.to.ICU.Admission - 1.85, 0)**3 - 0.0036453171 * High.HR + 5.4117287e-07 * 
        max(High.HR - 130, 0)**3 - 1.515284e-06 * max(High.HR - 175, 0)**3 + 
        9.7411116e-07 * max(High.HR - 200, 0)**3 - 0.0015153439 * Low.HR + 
        1.6862374e-06 * max(Low.HR - 101, 0)**3 - 3.2258455e-06 * max(Low.HR - 122, 0)**3 + 
        1.5396081e-06 * max(Low.HR - 145, 0)**3 + 0.0017999779 * High.RR + 1.8428793e-06 * max(High.RR - 38, 0)**3 - 3.7695259e-06 * 
        max(High.RR - 61, 0)**3 + 1.9266465e-06 * max(High.RR - 83, 0)**3 + 
        0.084997784 * High.T - 0.0090548217 * max(High.T - 36.9, 0)**3 + 
        0.01323397 * max(High.T - 37.5, 0)**3 - 0.0041791485 * max(High.T - 38.8, 0)**3 + 
        0.084421926 * (Low.PH.factor == "Abnormal") + 0.0073382869 * Highest.PCO2
    exp(lp) - 1
})

shinyServer(function(input, output) {
    # Return the requested dataset
    data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$Time.from.Hospital.Admission.to.ICU.Admission)) & as.numeric(input$Time.from.Hospital.Admission.to.ICU.Admission)>=0& as.numeric(input$Time.from.Hospital.Admission.to.ICU.Admission)<=10, 'Please input a valid Time'))
        Time.from.Hospital.Admission.to.ICU.Admission= as.numeric(input$Time.from.Hospital.Admission.to.ICU.Admission)
        validate(need(!is.na(as.numeric(input$Weight..kg.)) & as.numeric(input$Weight..kg.)>=0& as.numeric(input$Weight..kg.)<=50, 'Please input a valid Weight'))
        Weight..kg.= as.numeric(input$Weight..kg.)
        Young.Age = factor(input$Young.Age, levels = c('No', 'Yes'))
        Comorbid = factor(input$Comorbid, levels = c('No', 'Yes'))
        EarlyIntubation = factor(input$EarlyIntubation, levels = c('No', 'Yes'))
        validate(need(is.na(as.numeric(input$High.HR))| (!is.na(as.numeric(input$High.HR)) & as.numeric(input$High.HR)>=50& as.numeric(input$High.HR)<=300), 'Please input a valid High HR'))
        High.HR= as.numeric(input$High.HR)
        validate(need(is.na(as.numeric(input$Low.HR)) | (!is.na(as.numeric(input$Low.HR)) & as.numeric(input$Low.HR)>=50& as.numeric(input$Low.HR)<=200), 'Please input a valid Low HR'))
        Low.HR= as.numeric(input$Low.HR)
        validate(need(is.na(as.numeric(input$High.RR)) | (!is.na(as.numeric(input$High.RR)) & as.numeric(input$High.RR)>=10& as.numeric(input$High.RR)<=100), 'Please input a valid High RR'))
        High.RR= as.numeric(input$High.RR)
        validate(need(is.na(as.numeric(input$High.T)) | (!is.na(as.numeric(input$High.T)) & as.numeric(input$High.T)>=35& as.numeric(input$High.T)<=42), 'Please input a valid High Temperature'))
        High.T= as.numeric(input$High.T)
        validate(need(is.na(as.numeric(input$Low.PH)) | (!is.na(as.numeric(input$Low.PH)) & as.numeric(input$Low.PH)>=6.8& as.numeric(input$Low.PH)<=7.4), 'Please input a valid Low pH'))
        Low.PH= as.numeric(input$Low.PH)
        # Low.PH.factor <- factor(ifelse(Low.PH < 7.29,  "Abnormal", "Normal"), levels = c("Normal", "Abnormal"))
        validate(need(is.na(as.numeric(input$Highest.PCO2)) | (!is.na(as.numeric(input$Highest.PCO2)) & as.numeric(input$Highest.PCO2)>=15& as.numeric(input$Highest.PCO2)<=120), 'Please input a valid Highest PCO2'))
        Highest.PCO2= as.numeric(input$Highest.PCO2)
        data <- data.frame(Time.from.Hospital.Admission.to.ICU.Admission = Time.from.Hospital.Admission.to.ICU.Admission,
                           Weight..kg. = Weight..kg.,
                           Comorbid = Comorbid,
                           Young.Age = Young.Age,
                           EarlyIntubation = EarlyIntubation,
                           High.HR = High.HR,
                           Low.HR = Low.HR,
                           High.RR = High.RR,
                           High.T = High.T,
                           Low.PH = Low.PH,
                           Highest.PCO2 = Highest.PCO2
                           )
        data <- data %>% 
            mutate(High.HR = case_when(Young.Age == "Yes" & is.na(High.HR)                      ~ 130,
                                       Young.Age == "No"  & is.na(High.HR)                      ~ 105,
                                       TRUE                                                     ~ as.double(High.HR)),
                   Low.HR = case_when(Young.Age == "Yes" & is.na(Low.HR)                        ~ 130,
                                      Young.Age == "No"  & is.na(Low.HR)                        ~ 105,
                                      TRUE                                                      ~ as.double(Low.HR)),
                   High.RR = case_when(Young.Age == "Yes" & is.na(High.RR)                      ~ 45,
                                       Young.Age == "No" & is.na(High.RR)                       ~ 30,
                                       High.RR > 100                                            ~ 100,
                                       TRUE                                                     ~ as.double(High.RR)),
                   High.T = ifelse(is.na(High.T), 37, High.T),
                   Low.PH = ifelse(is.na(Low.PH), 7.40, Low.PH),
                   Low.PH = ifelse(Low.PH < 6.8, 6.8, Low.PH),
                   Low.PH = ifelse(Low.PH > 7.5, 7.5, Low.PH),
                   Low.PH.factor = factor(ifelse(Low.PH < 7.29,  "Abnormal", "Normal"), levels = c("Normal", "Abnormal")),
                   Highest.PCO2 = ifelse(is.na(Highest.PCO2), 40, Highest.PCO2),
                   Highest.PCO2 = ifelse(Highest.PCO2 > 120, 120, Highest.PCO2))
        data})
    
    
    # Generate a summary of the dataset
    output$result <- renderDataTable({
        data = data()
        risk1 = 0
        risk2 = 0
        if (data$EarlyIntubation == "Yes") {
            risk1 = round(eval(predict.intubation.yes.primary, data), 1)
            risk2 = round(eval(predict.intubation.yes.secondary, data), 1)
        } else {
            risk1 = round(eval(predict.intubation.no.primary, data), 1)
            risk2 = round(eval(predict.intubation.no.secondary, data), 1)
        }
        risk1 = paste(risk1, "days")
        risk2 = paste(risk2, "days")
        
        res = data.frame(Result = c("Predicted Primary Outcome", "Predicted Secondary Outcome"),
                         Probability = c(risk1, risk2))
        res}, options = list(
            pageLength = 10,
            lengthMenu = 0,
            searching = 0,
            info = 0,
            paging = 0,
            initComplete = I(
                "function(settings, json) {
            $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});}"
            )))
    
})
