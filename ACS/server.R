formula.1yr.mortality <- expression({
    lp = 7.5040541 - 
        0.75310818  * (ACS_Type == 'STEMI') + 
        0.060390267 * (ACS_Type == 'Unstable Angina') + 
        1.7246797 * (CabgPCIOtherStent == 'Other') + 
        1.1818947 * (CabgPCIOtherStent == 'PCI-Bare') + 
        1.0215117 * (CabgPCIOtherStent == 'PCI-Coated') + 
        1.4602413 * (CabgPCIOtherStent == 'PCI-No') + 
        0.23444783 * (NVesselsTreated) - 
        0.78549602 * (DischargedHome == 'Yes') + 
        0.40811129 * (Sex == 'Male') - 
        0.24448501 * (BaseHypercholesterolAny == 'Yes') + 
        0.36302939 * (BaseStroke == 'Yes') + 
        0.81208154 * (HospitalStroke == 'Yes') + 
        0.394642 * (BaseCHFAny == 'Yes') + 
        0.51127906 * (NewCHF == 'Yes') + 
        0.30980958 * (BaseRenalAnyCKDepi == 'Yes') + 
        0.28707472 * (BaseCOPDAny == 'Yes') - 
        0.37416103 * (ComboHospitalDischargePlavix2  == 'Yes') - 
        0.42562805 * (HospitalacuteBetaBlocker == 'Yes') + 
        0.014176347 * AgeonEDvisit + 
        6.3475756e-06 * max(AgeonEDvisit - 49.9, 0)**3 - 
        1.3261177e-05 * max(AgeonEDvisit - 67, 0)**3 + 
        6.9136015e-06 * max(AgeonEDvisit - 82.7, 0)**3 - 
        0.019390181   * Hospital_Int_Cath_LVEF + 
        2.0214663e-05 * max(Hospital_Int_Cath_LVEF - 30, 0)**3 - 
        6.064399e-05  * max(Hospital_Int_Cath_LVEF - 50, 0)**3 + 
        4.0429326e-05 * max(Hospital_Int_Cath_LVEF - 60, 0)**3 - 
        0.036693278  * HospitalPulse + 
        0.0027797222 * max( HospitalPulse - 94,0)**3 - 
        0.0069493056 * max(HospitalPulse - 97, 0)**3 + 
        0.0041695834 * max(HospitalPulse - 99, 0)**3 + 
        0.34619011 * log(MAX_TNT) - 
        0.0062505676 * max(log(MAX_TNT) + 4.6051702, 0)**3 + 
        0.012343362  * max(log(MAX_TNT) + 1.7719568, 0)**3 - 
        0.0060927944 * max(log(MAX_TNT) - 1.1346227, 0)**3 - 
        0.065931392 * ((Weight*0.4536)/(Height*0.0254)**2) + 
        0.00034277866 * max(((Weight*0.4536)/(Height*0.0254)**2) - 21.4, 0)**3 - 
        0.00056522013 * max(((Weight*0.4536)/(Height*0.0254)**2) - 27.5, 0)**3 + 
        0.00022244147 * max(((Weight*0.4536)/(Height*0.0254)**2) - 36.9, 0)**3 - 
        0.1672671 * BH_Albumin - 
        0.041257763 * max(BH_Albumin - 2.8, 0)**3 + 
        0.10314441 * max(BH_Albumin - 3.7, 0)**3 - 
        0.061886645 * max(BH_Albumin - 4.3, 0)**3 - 
        0.067996029 * hematocrit + 
        8.7539466e-05 * max(hematocrit - 27.9, 0)**3 - 
        0.00017003739 * max(hematocrit - 35.1, 0)**3 + 
        8.2497926e-05 * max(hematocrit - 42.74, 0)**3
    (1 - 0.921194 ** exp(lp)) * 100.0
})
formula.1yr.mortality.MI <- expression({
    lp = 4.4174323 - 
        0.52534844 * (ACS_Type == 'STEMI') - 
        0.056987206 * (ACS_Type == 'Unstable Angina') + 
        0.86291828 * (CabgPCIOtherStent == 'Other') + 
        0.74849116 * (CabgPCIOtherStent == 'PCI-Bare') + 
        0.73700758 * (CabgPCIOtherStent == 'PCI-Coated') + 
        0.66908082 * (CabgPCIOtherStent == 'PCI-No') + 
        0.075091288 * NVesselsStenosed50 - 
        0.56573023 * (DischargedHome == 'Yes') + 
        0.20692341 * (ETHNIC_GROUP_C == 'Black') + 
        0.046717782 * (ETHNIC_GROUP_C == 'Other') + 
        0.13018298 * (BaseSmoking == 'Yes') + 
        0.20196201 * (BaseDiabetesAny == 'Yes') - 
        0.20291909 * (BaseHypercholesterolAny == 'Yes') + 
        0.22305707 * (BaseStroke == 'Yes') + 
        0.20994407 * (BaseCHFAny == 'Yes') + 
        0.21270589 * (BaseRenalAnyCKDepi == 'Yes') + 
        0.24080111 * (BaseCOPDAny == 'Yes') - 
        0.23989657 * (HospitalacuteBetaBlocker == 'Yes') - 
        0.016277942 * Hospital_Int_Cath_LVEF + 
        6.4654389e-06 * max(Hospital_Int_Cath_LVEF - 30, 0)**3 - 
        1.9396317e-05 * max(Hospital_Int_Cath_LVEF - 50, 0)**3 + 
        1.2930878e-05 * max(Hospital_Int_Cath_LVEF - 60, 0)**3 - 
        0.003737345 * BH_LDL + 
        6.0079042e-07 * max(BH_LDL - 43, 0)**3 - 
        9.7369481e-07 * max(BH_LDL - 79, 0)**3 + 
        3.729044e-07 * max(BH_LDL - 137, 0)**3 + 
        0.29890196 * log(MAX_TNT) - 
        0.0048208728 * max(log(MAX_TNT) + 4.6051702, 0)**3 + 
        0.0095200599 * max(log(MAX_TNT) + 1.7719568, 0)**3 - 
        0.0046991871 * max(log(MAX_TNT) - 1.1346227, 0)**3 + 
        0.45097862 * BH_scr - 
        0.26105622 * max(BH_scr - 0.7, 0)**3 + 
        0.321591 * max(BH_scr - 1.02, 0)**3 - 
        0.060534776 * max(BH_scr - 2.4, 0)**3 - 
        0.045983971 * ((Weight*0.4536)/(Height*0.0254) ** 2) + 
        0.00018654928 * max(((Weight*0.4536)/(Height*0.0254) ** 2) - 21.4, 0)**3 - 
        0.00030760786 * max(((Weight*0.4536)/(Height*0.0254) ** 2) - 27.5, 0)**3 + 
        0.00012105858 * max(((Weight*0.4536)/(Height*0.0254) ** 2) - 36.9, 0)**3 - 
        0.1039557 * BH_Albumin - 
        0.015383925 * max(BH_Albumin - 2.8, 0)**3 + 
        0.038459813 * max(BH_Albumin - 3.7, 0)**3 - 
        0.023075888 * max(BH_Albumin - 4.3, 0)**3 - 
        0.045609034 * hematocrit + 
        6.499218e-05 * max(hematocrit - 27.9, 0)**3 - 
        0.00012624136 * max(hematocrit - 35.1, 0)**3 + 
        6.1249175e-05 * max(hematocrit - 42.74, 0)**3
    (1.0 - 0.7235229 **exp(lp)) * 100.0
})
formula.30days.mortality <- expression({
    lp = 2.5003086 + 
        1.4638715 * (CabgPCIOtherStent == 'Other') + 
        1.1279448 * (CabgPCIOtherStent == 'PCI-Bare') + 
        1.1392511 * (CabgPCIOtherStent == 'PCI-Coated') + 
        0.8065503 * (CabgPCIOtherStent == 'PCI-No') - 
        1.3259744 * (DischargedHome == 'Yes') + 
        0.60098001 * (Sex == 'Male') + 
        0.58458229 * (BaseRenalAnyCKDepi == 'Yes') - 
        0.67646354 * (ComboHospitalDischargePlavix2 == 'Yes') - 
        0.95657146 * (HospitalacuteGII_IIIb == 'Yes') + 
        0.016817035 * AgeonEDvisit + 
        1.7646084e-05 * max(AgeonEDvisit - 49.9, 0)**3 - 
        3.6865703e-05 * max(AgeonEDvisit - 67,0)**3 + 
        1.921962e-05 * max(AgeonEDvisit - 82.7, 0)**3 - 
        0.031359379 * BaseHDL + 
        2.7036727e-05 * max(BaseHDL - 28, 0)**3 - 
        4.5591344e-05 * max(BaseHDL - 42, 0)**3 + 
        1.8554617e-05 * max(BaseHDL - 62.4, 0)**3 + 
        0.41514617 * log(MAX_TNT) - 
        0.0048985744 * max(log(MAX_TNT) + 4.6051702, 0)**3 + 
        0.0096735018 * max(log(MAX_TNT) + 1.7719568, 0)**3 - 
        0.0047749274 * max(log(MAX_TNT) - 1.1346227, 0)**3 - 
        0.10593797 * ((Weight*0.4536)/(Height*0.0254) ** 2) + 
        0.00057784166 * max(((Weight*0.4536)/(Height*0.0254) ** 2)- 21.4, 0)**3 - 
        0.00095282402 * max(((Weight*0.4536)/(Height*0.0254) ** 2)- 27.5, 0)**3 + 
        0.00037498235 * max(((Weight*0.4536)/(Height*0.0254) ** 2)- 36.9, 0)**3 - 
        0.0054216582 * HospitalALT + 
        1.8473832e-06 * max(HospitalALT - 11, 0)**3 - 
        2.3277029e-06 * max(HospitalALT - 24, 0)**3 + 
        4.8031964e-07 * max(HospitalALT - 74, 0)**3 + 
        0.11117989 * BH_Albumin - 
        0.27018877 * max(BH_Albumin - 2.8, 0)**3 + 
        0.67547192 * max(BH_Albumin - 3.7, 0)**3 - 
        0.40528315 * max(BH_Albumin - 4.3, 0)**3 - 
        0.11456307 * hematocrit + 
        0.00072290116 * max(hematocrit - 27.9, 0)**3 - 
        0.0014041693 * max(hematocrit - 35.1, 0)**3 + 
        0.00068126811 * max(hematocrit - 42.74, 0)**3
    100.0/(1.0 + exp(-lp))
})
formula.30days.mortality.MI <- expression({
    lp = -2.202769 + 
        0.98507141 * (CabgPCIOtherStent == 'Other') + 
        1.0716783 * (CabgPCIOtherStent == 'PCI-Bare') + 
        1.1529328 * (CabgPCIOtherStent == 'PCI-Coated') + 
        1.0002661 * (CabgPCIOtherStent == 'PCI-No') - 
        1.0410311 * (DischargedHome == 'Yes')+ 
        0.26413368 * (BaseSmoking == 'Yes') + 
        0.31548569 * (BaseDiabetesAny == 'Yes')+ 
        0.34843894 * (BasePerVascDis == 'Yes') + 
        0.91037638 * (HospitalStroke == 'Yes') - 
        0.36037702 * (HospitalPlavixPreProc == 'Yes') - 
        0.21209348 * (HospitalacuteACEIARB == 'Yes') - 
        0.015700244 * Hospital_Int_Cath_LVEF + 
        4.5117758e-06 * max(Hospital_Int_Cath_LVEF - 30, 0)**3 - 
        1.3535327e-05 * max(Hospital_Int_Cath_LVEF - 50, 0)**3 + 
        9.0235515e-06 * max(Hospital_Int_Cath_LVEF - 60, 0)**3 - 
        0.0036638979 * BH_LDL + 
        7.716072e-07 * max(BH_LDL - 43, 0)**3 - 
        1.2505358e-06 * max(BH_LDL - 79, 0)**3 + 
        4.789286e-07 * max(BH_LDL - 137, 0)**3 + 
        0.0061825047 * HospitalPulse + 
        0.0021445166 * max(HospitalPulse - 94, 0)**3 - 
        0.0053612914 * max(HospitalPulse - 97, 0)**3 + 
        0.0032167748 * max(HospitalPulse - 99, 0)**3 + 
        0.16636978 * log(MAX_TNT) - 
        3.9351425e-05 * max(log(MAX_TNT) + 4.6051702, 0)**3 + 
        7.7709564e-05 * max(log(MAX_TNT) + 1.7719568, 0)**3 - 
        3.8358139e-05 * max(log(MAX_TNT) - 1.1346227, 0)**3 + 
        0.95757845 * BH_scr - 
        0.57131571 * max(BH_scr - 0.7, 0)**3 + 
        0.70379472 * max(BH_scr - 1.02, 0)**3 - 
        0.13247901 * max(BH_scr - 2.4, 0)**3 - 
        0.011994678 * HospitalALT + 
        4.5506647e-06 * max(HospitalALT - 11, 0)**3 - 
        5.7338376e-06 * max(HospitalALT - 24, 0)**3 + 
        1.1831728e-06 * max(HospitalALT - 74, 0)**3
    100.0 / (1.0 + exp(-lp))
})

library(shiny)
shinyServer(function(input, output){
    data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$AgeonEDvisit))& as.numeric(input$AgeonEDvisit)>=30& as.numeric(input$AgeonEDvisit)<=85, 'Please input a valid AgeonEDvisit'))
        AgeonEDvisit= as.numeric(input$AgeonEDvisit)
        validate(need(!is.na(as.numeric(input$Height))& as.numeric(input$Height)>=60& as.numeric(input$Height)<=80, 'Please input a valid Height'))
        Height= as.numeric(input$Height)
        validate(need(!is.na(as.numeric(input$Weight))& as.numeric(input$Weight)>=75& as.numeric(input$Weight)<=350, 'Please input a valid Weight'))
        Weight= as.numeric(input$Weight)
        Sex = factor(input$Sex, levels = c('Male', 'Female'))
        ETHNIC_GROUP_C = factor(input$ETHNIC_GROUP_C, levels = c('Black', 'White', 'Other'))
        ACS_Type = factor(input$ACS_Type, levels = c('STEMI', 'NSTEMI', 'Unstable Angina'))
        CabgPCIOtherStent = factor(input$CabgPCIOtherStent, levels = c('Other', 'PCI-Bare', 'PCI-Coated', 'PCI-No', 'CABG'))
        HospitalacuteBetaBlocker = factor(input$HospitalacuteBetaBlocker, levels = c('No', 'Yes'))
        HospitalPlavixPreProc = factor(input$HospitalPlavixPreProc, levels = c('No', 'Yes'))
        BaseSmoking = factor(input$BaseSmoking, levels = c('No', 'Yes'))
        ComboHospitalDischargePlavix2 = factor(input$ComboHospitalDischargePlavix2, levels = c('No', 'Yes'))
        DischargedHome = factor(input$DischargedHome, levels = c('No', 'Yes'))
        HospitalacuteGII_IIIb = factor(input$HospitalacuteGII_IIIb, levels = c('No', 'Yes'))
        BaseCHFAny = factor(input$BaseCHFAny, levels = c('No', 'Yes'))
        BaseRenalAnyCKDepi = factor(input$BaseRenalAnyCKDepi, levels = c('No', 'Yes'))
        BaseCOPDAny = factor(input$BaseCOPDAny, levels = c('No', 'Yes'))
        BaseDiabetesAny = factor(input$BaseDiabetesAny, levels = c('No', 'Yes'))
        BaseStroke = factor(input$BaseStroke, levels = c('No', 'Yes'))
        BasePerVascDis = factor(input$BasePerVascDis, levels = c('No', 'Yes'))
        BaseHypercholesterolAny = factor(input$BaseHypercholesterolAny, levels = c('No', 'Yes'))
        NewCHF = factor(input$NewCHF, levels = c('No', 'Yes'))
        HospitalStroke = factor(input$HospitalStroke, levels = c('No', 'Yes'))
        HospitalacuteACEIARB = factor(input$HospitalacuteACEIARB, levels = c('No', 'Yes'))
        validate(need(!is.na(as.numeric(input$BH_Albumin))& as.numeric(input$BH_Albumin)>=1& as.numeric(input$BH_Albumin)<=6, 'Please input a valid BH_Albumin'))
        BH_Albumin= as.numeric(input$BH_Albumin)
        validate(need(!is.na(as.numeric(input$HospitalALT))& as.numeric(input$HospitalALT)>=10& as.numeric(input$HospitalALT)<=500, 'Please input a valid HospitalALT'))
        HospitalALT= as.numeric(input$HospitalALT)
        validate(need(!is.na(as.numeric(input$BH_scr))& as.numeric(input$BH_scr)>=0.5& as.numeric(input$BH_scr)<=5, 'Please input a valid BH_scr'))
        BH_scr= as.numeric(input$BH_scr)
        validate(need(!is.na(as.numeric(input$BaseHDL))& as.numeric(input$BaseHDL)>=10& as.numeric(input$BaseHDL)<=80, 'Please input a valid BaseHDL'))
        BaseHDL= as.numeric(input$BaseHDL)
        validate(need(!is.na(as.numeric(input$hematocrit))& as.numeric(input$hematocrit)>=15& as.numeric(input$hematocrit)<=60, 'Please input a valid hematocrit'))
        hematocrit= as.numeric(input$hematocrit)
        validate(need(!is.na(as.numeric(input$BH_LDL))& as.numeric(input$BH_LDL)>=10& as.numeric(input$BH_LDL)<=80, 'Please input a valid BH_LDL'))
        BH_LDL= as.numeric(input$BH_LDL)
        validate(need(!is.na(as.numeric(input$HospitalPulse)), 'Please input a valid HospitalPulse'))
        HospitalPulse= as.numeric(input$HospitalPulse)
        validate(need(!is.na(as.numeric(input$Hospital_Int_Cath_LVEF))& as.numeric(input$Hospital_Int_Cath_LVEF)>=20& as.numeric(input$Hospital_Int_Cath_LVEF)<=70, 'Please input a valid Hospital_Int_Cath_LVEF'))
        Hospital_Int_Cath_LVEF= as.numeric(input$Hospital_Int_Cath_LVEF)
        validate(need(!is.na(as.numeric(input$MAX_TNT))& as.numeric(input$MAX_TNT)>=0.01& as.numeric(input$MAX_TNT)<=50, 'Please input a valid MAX_TNT'))
        MAX_TNT= as.numeric(input$MAX_TNT)
        validate(need(!is.na(as.numeric(input$NVesselsTreated))& as.numeric(input$NVesselsTreated)>=1& as.numeric(input$NVesselsTreated)<=4, 'Please input a valid NVesselsTreated'))
        NVesselsTreated= as.numeric(input$NVesselsTreated)
        validate(need(!is.na(as.numeric(input$NVesselsStenosed50))& as.numeric(input$NVesselsStenosed50)>=1& as.numeric(input$NVesselsStenosed50)<=4, 'Please input a valid NVesselsStenosed50'))
        NVesselsStenosed50= as.numeric(input$NVesselsStenosed50)
        data <- data.frame(AgeonEDvisit = AgeonEDvisit,
                           Height = Height,
                           Weight = Weight,
                           Sex = Sex,
                           ETHNIC_GROUP_C = ETHNIC_GROUP_C,
                           ACS_Type = ACS_Type,
                           CabgPCIOtherStent = CabgPCIOtherStent,
                           HospitalacuteBetaBlocker = HospitalacuteBetaBlocker,
                           HospitalPlavixPreProc = HospitalPlavixPreProc,
                           BaseSmoking = BaseSmoking,
                           ComboHospitalDischargePlavix2 = ComboHospitalDischargePlavix2,
                           DischargedHome = DischargedHome,
                           HospitalacuteGII_IIIb = HospitalacuteGII_IIIb,
                           BaseCHFAny = BaseCHFAny,
                           BaseRenalAnyCKDepi = BaseRenalAnyCKDepi,
                           BaseCOPDAny = BaseCOPDAny,
                           BaseDiabetesAny = BaseDiabetesAny,
                           BaseStroke = BaseStroke,
                           BasePerVascDis = BasePerVascDis,
                           BaseHypercholesterolAny = BaseHypercholesterolAny,
                           NewCHF = NewCHF,
                           HospitalStroke = HospitalStroke,
                           HospitalacuteACEIARB = HospitalacuteACEIARB,
                           BH_Albumin = BH_Albumin,
                           HospitalALT = HospitalALT,
                           BH_scr = BH_scr,
                           BaseHDL = BaseHDL,
                           hematocrit = hematocrit,
                           BH_LDL = BH_LDL,
                           HospitalPulse = HospitalPulse,
                           Hospital_Int_Cath_LVEF = Hospital_Int_Cath_LVEF,
                           MAX_TNT = MAX_TNT,
                           NVesselsTreated = NVesselsTreated,
                           NVesselsStenosed50 = NVesselsStenosed50)
        data})
    output$result <- renderDataTable({
        data = data()
        yr1.mortality = paste(ifelse(round(eval(formula.1yr.mortality, envir = data), 0) < 1, "<1", ifelse(round(eval(formula.1yr.mortality, envir = data), 0) > 99, ">99", round(eval(formula.1yr.mortality, envir = data), 0))), "%")
        yr1.mortality.MI = paste(ifelse(round(eval(formula.1yr.mortality.MI, envir = data), 0) < 1, "<1", ifelse(round(eval(formula.1yr.mortality.MI, envir = data), 0) > 99, ">99", round(eval(formula.1yr.mortality.MI, envir = data), 0))), "%")
        day30.mortality = paste(ifelse(round(eval(formula.30days.mortality, envir = data), 0) < 1, "<1", ifelse(round(eval(formula.30days.mortality, envir = data), 0) > 99, ">99", round(eval(formula.30days.mortality, envir = data), 0))), "%")
        day30.mortality.MI = paste(ifelse(round(eval(formula.30days.mortality.MI, envir = data), 0) < 1, "<1", ifelse(round(eval(formula.30days.mortality.MI, envir = data), 0) > 99, ">99", round(eval(formula.30days.mortality.MI, envir = data), 0))), "%")
        result = data.frame(Result = c("30 Day Risk of Mortality", "30 Day Risk of Mortality, Myocardial Infarction, or Revascularization", "1 Year Risk of Mortality", "1 Year Risk of Mortality, Myocardial Infarction, or Revascularization"),
                            Probability = c(day30.mortality, day30.mortality.MI, yr1.mortality, yr1.mortality.MI))
        result
        }, options = list(
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