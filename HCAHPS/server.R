pred_test <- expression({
    lp <- 1.9294846 - 0.54965491 * (ClientID == "Ashtabula") + 0.82089191 * 
        (ClientID == "Avon") + 0.8468369 * (ClientID == "CC") + 
        0.094880059 * (ClientID == "Euclid") + 0.37784478 * (ClientID == 
                                                                "Fairview") + 0.079184623 * (ClientID == "Hillcrest") - 
        0.14857123 * (ClientID == "Lakewood") + 0.5556254 * (ClientID == 
                                                                "Lodi") - 0.03885025 * (ClientID == "Lutheran") - 0.25561352 * 
        (ClientID == "Marymount") - 0.048785826 * (ClientID == 
                                                      "Medina") - 0.15993203 * (ClientID == "South Pointe") + 
        0.61637536 * (ClientID == "Weston") + 0.0094316141 * 
        Age - 3.9364223e-06 * max(Age - 38, 0)**3 + 1.0825161e-05 * 
        max(Age - 66, 0)**3 - 6.8887391e-06 * max(Age - 82, 
                                                  0)**3 + 0.20463428 * (Gender == "Male") - 0.14073216 * 
        (Race == "Black race") - 0.017210754 * (Race == "Caucasian") + 
        0.039892179 * (Race == "Other") - 0.14907686 * (Ethnicity == 
                                                           "Not Hispanic or Latino") - 0.33806756 * (Ethnicity == 
                                                                                                         "Unknown") - 0.084263757 * (MaritalStatus == "Divorced state") - 
        0.098216088 * (MaritalStatus == "domestic partner") - 
        0.12463335 * (MaritalStatus == "Other") - 0.10193136 * 
        (MaritalStatus == "Unmarried person") - 0.12511198 * 
        (MaritalStatus == "Widow") + 0.019008943 * (Education == 
                                                       "4+ yrs college") + 0.17523818 * (Education == "8th grade or less") + 
        0.034581567 * (Education == "High school grad") + 0.017228985 * 
        (Education == "Other") - 0.0033403599 * (Education == 
                                                    "Some college") + 0.17320323 * (Education == "Some high school") + 
        0.065409398 * (Language == "Other") + 0.31899072 * (Language == 
                                                               "Spanish") - 0.13616182 * (Religion == "CATHOLIC") - 
        0.079646548 * (Religion == "CHRISTIAN") - 0.19766327 * 
        (Religion == "JEWISH") - 0.13685596 * (Religion == "LUTHERAN") + 
        0.023927887 * (Religion == "METHODIST") - 0.15032845 * 
        (Religion == "NONE") - 0.10051159 * (Religion == "Other") - 
        0.062855167 * (Religion == "PROTESTANT") - 0.0019547913 * 
        MedianIncome + 1.1145068e-07 * max(MedianIncome - 31.731, 
                                           0)**3 - 1.9049793e-07 * max(MedianIncome - 62.361, 0)**3 + 
        7.9047248e-08 * max(MedianIncome - 105.547, 0)**3 - 0.24979928 * 
        (AdmissionType == "Emergency Admission") - 0.16942055 * 
        (AdmissionType == "General Outpatient") - 0.18064036 * 
        (AdmissionType == "Hospital Admission, urgent, 48hr") - 
        0.16364135 * (AdmissionType == "Inpatient") - 0.14077214 * 
        (AdmissionType == "Other") - 1.0249864 * (OverallHealth == 
                                                     "Fair") - 0.85240052 * (OverallHealth == "Good") - 1.2074286 * 
        (OverallHealth == "Poor") - 0.52447738 * (OverallHealth == 
                                                     "Very Good") - 0.61965362 * (MentalHealth == "Fair") - 
        0.51729224 * (MentalHealth == "Good") - 0.71511283 * 
        (MentalHealth == "Poor") - 0.29781341 * (MentalHealth == 
                                                    "Very Good") + 0.028217567 * (AdmissionWeek == "Mon.") + 
        0.033112104 * (AdmissionWeek == "Tue.") + 0.014827756 * 
        (AdmissionWeek == "Wed.") - 0.0029100186 * (AdmissionWeek == 
                                                       "Thu.") - 0.021560672 * (AdmissionWeek == "Fri.") - 0.025409753 * 
        (AdmissionWeek == "Sat.") + 0.0063344286 * (DischargeWeek == 
                                                       "Mon.") + 0.036093229 * (DischargeWeek == "Tue.") + 0.022861417 * 
        (DischargeWeek == "Wed.") + 0.041241214 * (DischargeWeek == 
                                                      "Thu.") + 0.013606288 * (DischargeWeek == "Fri.") - 0.023149159 * 
        (DischargeWeek == "Sat.") + 0.0052994561 * AdmissionHour - 
        4.5024875e-05 * max(AdmissionHour - 4, 0)**3 + 9.567786e-05 * 
        max(AdmissionHour - 13, 0)**3 - 5.0652985e-05 * max(AdmissionHour - 
                                                                21, 0)**3 + 0.0081211885 * DischargeHour - 0.00072869272 * 
        max(DischargeHour - 11, 0)**3 + 0.0012752123 * max(DischargeHour - 
                                                               14, 0)**3 - 0.00054651954 * max(DischargeHour - 18, 0)**3
    1/(1+exp(-lp))
})

pred_test_dr = expression({
    lp = 2.2095533 + 0.075702413 * (ClientID == "Ashtabula") + 0.27034618 * 
        (ClientID == "Avon") + 0.2814981 * (ClientID == "CC") + 
        0.21662839 * (ClientID == "Euclid") + 0.12981298 * (ClientID == 
                                                               "Fairview") + 0.091651405 * (ClientID == "Hillcrest") - 
        0.043940825 * (ClientID == "Lakewood") - 0.19622835 * 
        (ClientID == "Lodi") + 0.14021144 * (ClientID == "Lutheran") + 
        0.12786323 * (ClientID == "Marymount") + 0.33754467 * 
        (ClientID == "Medina") + 0.061722075 * (ClientID == "South Pointe") + 
        0.25736006 * (ClientID == "Weston") + 0.0084101767 * 
        Age - 8.5333188e-06 * max(Age - 38, 0)**3 + 2.3466627e-05 * 
        max(Age - 66, 0)**3 - 1.4933308e-05 * max(Age - 82, 
                                                  0)**3 - 0.0074338073 * (Gender == "Male") + 0.085987642 * 
        (Race == "Black race") - 0.083600127 * (Race == "Caucasian") + 
        0.010685467 * (Race == "Other") - 0.24856053 * (Ethnicity == 
                                                           "Not Hispanic or Latino") - 0.41225464 * (Ethnicity == 
                                                                                                         "Unknown") - 0.091905859 * (MaritalStatus == "Divorced state") - 
        0.15509295 * (MaritalStatus == "domestic partner") - 
        0.10574965 * (MaritalStatus == "Other") - 0.16884432 * 
        (MaritalStatus == "Unmarried person") - 0.15610262 * 
        (MaritalStatus == "Widow") + 0.014741679 * (Education == 
                                                       "4+ yrs college") + 0.35829931 * (Education == "8th grade or less") + 
        0.2337763 * (Education == "High school grad") + 0.17020101 * 
        (Education == "Other") + 0.11732815 * (Education == "Some college") + 
        0.36085485 * (Education == "Some high school") + 0.013710132 * 
        (Language == "Other") + 0.15701886 * (Language == "Spanish") - 
        0.10100412 * (Religion == "CATHOLIC") - 0.14698229 * 
        (Religion == "CHRISTIAN") - 0.23833571 * (Religion == 
                                                     "JEWISH") - 0.17791963 * (Religion == "LUTHERAN") - 0.10555396 * 
        (Religion == "METHODIST") - 0.19834872 * (Religion == 
                                                     "NONE") - 0.1514602 * (Religion == "Other") - 0.18574947 * 
        (Religion == "PROTESTANT") - 0.00077671406 * MedianIncome + 
        3.1345175e-09 * max(MedianIncome - 31.731, 0)**3 - 5.357698e-09 * 
        max(MedianIncome - 62.361, 0)**3 + 2.2231805e-09 * max(MedianIncome - 
                                                                   105.547, 0)**3 - 0.29148185 * (AdmissionType == "Emergency Admission") - 
        0.23316755 * (AdmissionType == "General Outpatient") - 
        0.19876743 * (AdmissionType == "Hospital Admission, urgent, 48hr") - 
        0.22751095 * (AdmissionType == "Inpatient") - 0.10320879 * 
        (AdmissionType == "Other") - 0.97779199 * (OverallHealth == 
                                                      "Fair") - 0.72246121 * (OverallHealth == "Good") - 1.1446618 * 
        (OverallHealth == "Poor") - 0.40239121 * (OverallHealth == 
                                                     "Very Good") - 0.68734447 * (MentalHealth == "Fair") - 
        0.646424 * (MentalHealth == "Good") - 0.87185343 * (MentalHealth == 
                                                               "Poor") - 0.42298459 * (MentalHealth == "Very Good") + 
        0.13828228 * (AdmissionWeek == "Mon.") + 0.14612926 * 
        (AdmissionWeek == "Tue.") + 0.1386729 * (AdmissionWeek == 
                                                    "Wed.") + 0.11688213 * (AdmissionWeek == "Thu.") + 0.10146202 * 
        (AdmissionWeek == "Fri.") + 0.045950715 * (AdmissionWeek == 
                                                      "Sat.") - 0.016644402 * (DischargeWeek == "Mon.") - 0.010200035 * 
        (DischargeWeek == "Tue.") + 0.01601008 * (DischargeWeek == 
                                                     "Wed.") + 0.042388034 * (DischargeWeek == "Thu.") + 0.03663434 * 
        (DischargeWeek == "Fri.") + 0.036531019 * (DischargeWeek == 
                                                      "Sat.") + 0.0060440355 * AdmissionHour - 5.3908541e-05 * 
        max(AdmissionHour - 4, 0)**3 + 0.00011455565 * max(AdmissionHour - 
                                                               13, 0)**3 - 6.0647109e-05 * max(AdmissionHour - 21, 0)**3 - 
        0.020565244 * DischargeHour - 0.00020154829 * max(DischargeHour - 
                                                              11, 0)**3 + 0.00035270952 * max(DischargeHour - 14, 0)**3 - 
        0.00015116122 * max(DischargeHour - 18, 0)**3
    1/(1+exp(-lp))
})

shinyServer(function(input, output, session){
    
    data <- eventReactive(input$goButton, {
        validate(need((!is.na(as.numeric(input$Age))& as.numeric(input$Age)>=0& as.numeric(input$Age)<=90), 'Please input a valid Age'))
        validate(need((!is.na(as.numeric(input$MedianIncome))& as.numeric(input$MedianIncome)>=0& as.numeric(input$MedianIncome)<=250), 'Please input a valid Income'))
        validate(need((!is.na(as.numeric(input$AdmissionHour))& as.numeric(input$AdmissionHour)>=0& as.numeric(input$AdmissionHour)<=24), 'Please input a valid Admission hour'))
        validate(need((!is.na(as.numeric(input$DischargeHour))& as.numeric(input$DischargeHour)>=0& as.numeric(input$DischargeHour)<=24), 'Please input a valid Discharge hour'))
        Age= as.numeric(input$Age)
        MedianIncome= as.numeric(input$MedianIncome)
        AdmissionHour= as.numeric(input$AdmissionHour)
        DischargeHour= as.numeric(input$DischargeHour)
        ClientID = input$ClientID
        Gender = input$Gender
        Race = input$Race
        Ethnicity = input$Ethnicity
        MaritalStatus = input$MaritalStatus
        Language = input$Language
        Education = input$Education
        Religion = input$Religion
        AdmissionType = input$AdmissionType
        OverallHealth = input$OverallHealth
        MentalHealth = input$MentalHealth
        AdmissionWeek = input$AdmissionWeek
        DischargeWeek = input$DischargeWeek
        
        # validate(need((!is.na(Time_Between_Onset_Surgery)&Gender!="")|(normalmri!=""&bilateral!=""&nonlocal!=""), 'Please input values into at least one section'))
        
        data <- data.frame(
            Age = Age,
            MedianIncome = MedianIncome,
            DischargeHour = DischargeHour,
            ClientID = ClientID,
            AdmissionHour = AdmissionHour,
            Gender = Gender,
            Race = Race,
            Ethnicity = Ethnicity,
            MaritalStatus = MaritalStatus,
            Language = Language,
            Education = Education,
            Religion = Religion,
            AdmissionType = AdmissionType,
            OverallHealth = OverallHealth,
            MentalHealth = MentalHealth,
            AdmissionWeek = AdmissionWeek,
            DischargeWeek = DischargeWeek
        )
        data})

    
    output$result <- DT::renderDataTable({
        data = data()
        pred = eval(pred_test, envir = data)
        pred = ifelse(pred<0.001, "<0.1%", ifelse(pred>0.999, ">99.9%", paste(round(pred*100,1),"%",sep="")))
        pred2 = eval(pred_test_dr, envir = data)
        pred2 = ifelse(pred2<0.001, "<0.1%", ifelse(pred2>0.999, ">99.9%", paste(round(pred2*100,1),"%",sep="")))

        res = data.frame("Outcome" = c("Would Recommend", "Best Dr. Communication"), 
                         "Probabily" = c(pred, pred2))
        
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
