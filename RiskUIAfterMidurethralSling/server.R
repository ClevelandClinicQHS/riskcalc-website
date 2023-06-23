predict.adverse <- expression({
    if(Dynamic == "Yes"){
        lp <- -1.7072086 + 
            0.44203089 * (ABD_pain == "Yes") - 
            0.45602172 * (BA == ">= +1") + 
            0.83588298 * (Frustration == "Yes") + 
            0.32847132 * (Menopause != "Pre") + 
            0.6984433 * (Other_surg == "Yes") + 
            0.24824694 * (VPARITY == "1") - 
            0.010015804 * (VPARITY == "2") - 
            0.23113108 * (VPARITY == "3") - 
            0.1019479 * (VPARITY == ">=4") - 
            0.53676793 * (Race == "Caucasian") - 
            0.50481702 * (Urge_leak == "Yes") - 
            0.0043811202 * Val_pressure + 
            0.002324214 * Vol_mcc - 
            0.45618846 * (Type_of_surgery == "Transobturator")
    } else {
        lp <- -0.8263678 + 
            0.47389243 * (ABD_pain == "Yes") - 
            0.51216968 * (BA == ">= +1") + 
            0.34055724 * (CX == ">= +1") - 
            0.26641775 * (Freq_urine == "Yes") + 
            0.72973011 * (Frustration == "Yes") + 
            0.35096892 * (Menopause != "Pre") + 
            0.74176541 * (Other_surg == "Yes") + 
            0.23722571 * (VPARITY == "1") + 
            0.001434942 * (VPARITY == "2") - 
            0.31077963 * (VPARITY == "3") - 
            0.071975466 * (VPARITY == ">=4") - 
            0.19126162 * (Prior_pelv_surg == "Yes") + 
            0.22594172 * (Recreation_actv == "Yes") - 
            0.49806101 * (Race == "Caucasian") + 
            0.24520468 * (Pre_med_treat == "Yes") - 
            0.005427944 * ((((Physical_leak + Small_leak)/2))*(100/3)) - 
            0.51453235 * (Urge_leak == "Yes") + 
            0.0073918207 * Max_fl_nif - 
            0.45899279 * (Type_of_surgery == "Transobturator")}
    100/(1+exp(-lp))
})
predict.bothersome <- expression({
    if(Dynamic == "Yes"){
        lp <- -8.5869716 + 
            0.059171921 * AgeYr - 
            0.34113915 * (BA == ">= +1") + 
            0.56499506 * (Dull_pelvic == "Yes") + 
            0.33912903 * (Emotional_health == "Yes") + 
            0.95548585 * (Entertainment_actv == "Yes") + 
            0.66039245 * (Freq_urine == "Yes") - 
            0.61018249 * (Incom_blad == "Yes") - 
            1.1698209 * (Menopause != "Pre") - 
            0.17953471 * (VPARITY == "1") + 
            0.37613663 * (VPARITY == "2") + 
            0.081987257 * (VPARITY == "3") - 
            0.68658323 * (VPARITY == ">=4") - 
            0.93179747 * (Recreation_actv == "Yes") + 
            0.85110882 * (Race == "Caucasian") + 
            0.058465431 * ((((Physical_leak + Small_leak)/2))*(100/3)) - 
            2.1994953e-05 * max(((((Physical_leak + Small_leak)/2))*(100/3)) - 50, 0)**3 + 
            6.598486e-05 * max(((((Physical_leak + Small_leak)/2))*(100/3)) - 83.333333, 0)**3 - 
            4.3989906e-05 * max(((((Physical_leak + Small_leak)/2))*(100/3)) - 100, 0)**3 - 
            0.43050142 * (Urge_leak == "Yes") + 
            0.27557038 * (Type_of_surgery == "Transobturator")
    } else {
        lp <- -5.9854008 + 
            0.053028346 * AgeYr - 
            0.37380853 * (BA == ">= +1") + 
            0.53353016 * (Dull_pelvic == "Yes") + 
            0.3692464 * (Emotional_health == "Yes") + 
            0.92367637 * (Entertainment_actv == "Yes") + 
            0.64469527 * (Freq_urine == "Yes") - 
            0.59797119 * (Incom_blad == "Yes") - 
            1.1071408 * (Menopause != "Pre") - 
            0.26838491 * (VPARITY == "1") + 
            0.38688864 * (VPARITY == "2") - 
            0.017119324 * (VPARITY == "3") - 
            0.60594335 * (VPARITY == ">=4") - 
            0.85501289 * (Recreation_actv == "Yes") + 
            0.96056042 * (Race == "Caucasian") + 
            0.013485801 * ((((Physical_leak + Small_leak)/2))*(100/3)) - 
            0.32097855 * (Urge_leak == "Yes") + 
            0.30138059 * (Type_of_surgery == "Transobturator")}
    100/(1+exp(-lp))
})
predict.urge <- expression({
    if(Dynamic == "Yes"){
        lp <- -3.3811702 - 
            0.57370214 * (ABD_pain == "Yes") + 
            0.81993558 * (CX == ">= +1") + 
            0.62295443 * (Dull_pelvic == "Yes") + 
            0.506766 * (Emotional_health == "Yes") - 
            0.67723104 * (Incom_blad == "Yes") + 
            0.023461521 * Max_fl_nif + 
            0.15329527 * (VPARITY == "1") + 
            0.41073941 * (VPARITY == "2") - 
            0.35320019 * (VPARITY == "3") + 
            0.08812968 * (VPARITY == ">=4") + 
            0.53569961 * (Pre_med_treat == "Yes") + 
            1.3297058 * (Urge_leak == "Yes") - 
            0.0052323425 * Val_pressure + 
            0.0023631723 * Vol_mcc + 
            0.0088247844 * (((Physical_leak + Small_leak)/2) * (100/3))
    } else {
        lp <- -3.7886576 - 
            0.54782757 * (ABD_pain == "Yes") + 
            0.0099270743 * AgeYr + 
            0.76897489 * (CX == ">= +1") + 
            0.62819628 * (Dull_pelvic == "Yes") + 
            0.51487297 * (Emotional_health == "Yes") - 
            0.68829878 * (Incom_blad == "Yes") + 
            0.19344087 * (VPARITY == "1") + 
            0.45052425 * (VPARITY == "2") - 
            0.35886724 * (VPARITY == "3") + 
            0.12664611 * (VPARITY == ">=4") - 
            0.38603101 * (Prior_pelv_surg == "Yes") + 
            0.40664624 * (Race == "Caucasian") + 
            0.59335618 * (Pre_med_treat == "Yes") + 
            0.010188662 * (((Physical_leak + Small_leak)/2) * (100/3)) + 
            1.2455216 * (Urge_leak == "Yes") + 
            0.025612831 * Max_fl_nif}
    100/(1+exp(-lp))
})
predict.stress <- expression({
    if(Dynamic == "Yes"){
        lp <- -5.2973041 + 
            0.064818451 * AgeYr + 
            0.52778847 * (Emotional_health == "Yes") + 
            0.55857955 * (Entertainment_actv == "Yes") - 
            0.58114566 * (Menopause != "Pre") + 
            0.014015592 * Max_fl_nif - 
            0.98627465 * (Other_surg == "Yes") - 
            0.088251261 * (VPARITY == "1") + 
            0.20892695 * (VPARITY == "2") + 
            0.26844549 * (VPARITY == "3") - 
            0.32243254 * (VPARITY == ">=4") + 
            0.42812457 * (Prior_pelv_surg == "Yes") - 
            0.50200554 * (Recreation_actv == "Yes") + 
            0.0094570982 * (((Physical_leak + Small_leak)/2) * (100/3)) - 
            0.0045708734 * Val_pressure - 
            0.0014606711 * Vol_mcc + 
            0.49774875 * (Type_of_surgery == "Transobturator")
    } else {
        lp <- -6.6071971 + 
            0.066271605 * AgeYr - 
            0.51928916 * (BA == ">= +1") + 
            0.37245092 * (CX == ">= +1") + 
            0.56635597 * (Emotional_health == "Yes") + 
            0.59374864 * (Entertainment_actv == "Yes") + 
            0.35048201 * (Freq_urine == "Yes") - 
            0.18984108 * (Incom_blad == "Yes") - 
            0.60047908 * (Menopause != "Pre") - 
            0.86579238 * (Other_surg == "Yes") - 
            0.10949461 * (VPARITY == "1") + 
            0.20825057 * (VPARITY == "2") + 
            0.21606073 * (VPARITY == "3") - 
            0.24411543 * (VPARITY == ">=4") + 
            0.35251254 * (Prior_pelv_surg == "Yes") - 
            0.74356716 * (Recreation_actv == "Yes") + 
            0.37560304 * (Race == "Caucasian") + 
            0.3865138 * (Pre_med_treat == "Yes") + 
            0.0081516225 * (((Physical_leak + Small_leak)/2) * (100/3))  + 
            0.011087057 * Max_fl_nif + 
            0.47709645 * (Type_of_surgery == "Transobturator")}
    100 / (1 + exp(-lp))
})
library(shiny)
shinyServer(function(input, output){
    observe({
        if (input$Dynamic == "Yes") {
            shinyjs::show(id = "display", anim = TRUE)
        } else {
            shinyjs::hide(id = "display", anim = TRUE)
        }
    })
    data <- eventReactive(input$goButton, {
        Dynamic = factor(input$Dynamic, levels = c('Yes', 'No'))
        validate(need(!is.na(as.numeric(input$AgeYr))& as.numeric(input$AgeYr)>=18& as.numeric(input$AgeYr)<=100, 'Please input a valid AgeYr'))
        AgeYr= as.numeric(input$AgeYr)
        Race = factor(input$Race, levels = c('Caucasian', 'Other'))
        VPARITY = factor(input$VPARITY, levels = c('0', '1', '2', '3', '>=4'))
        Menopause = factor(input$Menopause, levels = c('Pre', 'Peri', 'Post'))
        BA = factor(input$BA, levels = c('< +1', '>= +1'))
        CX = factor(input$CX, levels = c('< +1', '>= +1'))
        Prior_pelv_surg = factor(input$Prior_pelv_surg, levels = c('Yes', 'No'))
        Pre_med_treat = factor(input$Pre_med_treat, levels = c('Yes', 'No'))
        Physical_leak = ifelse(input$Physical_leak == 'No'|input$Physical_leak == 'Yes - Not at All Bothersome', 0, ifelse(input$Physical_leak == 'Yes - Slightly Bothersome', 1, ifelse(input$Physical_leak == 'Yes - Moderately Bothersome', 2, ifelse(input$Physical_leak == 'Yes - Greatly Bothersome', 3, NA))))
        Small_leak = ifelse(input$Small_leak == 'No'|input$Small_leak == 'Yes - Not at All Bothersome', 0, ifelse(input$Small_leak == 'Yes - Slightly Bothersome', 1, ifelse(input$Small_leak == 'Yes - Moderately Bothersome', 2, ifelse(input$Small_leak == 'Yes - Greatly Bothersome', 3, NA))))
        Incom_blad = factor(input$Incom_blad, levels = c('Yes', 'No'))
        Urge_leak = factor(input$Urge_leak, levels = c('Yes', 'No'))
        ABD_pain = factor(input$ABD_pain, levels = c('Yes', 'No'))
        Dull_pelvic = factor(input$Dull_pelvic, levels = c('Yes', 'No'))
        Freq_urine = factor(input$Freq_urine, levels = c('Yes', 'No'))
        Entertainment_actv = factor(input$Entertainment_actv, levels = c('Yes', 'No'))
        Emotional_health = factor(input$Emotional_health, levels = c('Yes', 'No'))
        Recreation_actv = factor(input$Recreation_actv, levels = c('Yes', 'No'))
        Frustration = factor(input$Frustration, levels = c('Yes', 'No'))
        validate(need(!is.na(as.numeric(input$Max_fl_nif))& as.numeric(input$Max_fl_nif)>=0, 'Please input a valid Max_fl_nif'))
        Max_fl_nif= as.numeric(input$Max_fl_nif)
        if (Dynamic == "Yes") {
            validate(need(!is.na(as.numeric(input$Vol_mcc))& as.numeric(input$Vol_mcc)>=0, 'Please input a valid Vol_mcc'))
            validate(need(!is.na(as.numeric(input$Val_pressure))& as.numeric(input$Val_pressure)>=0, 'Please input a valid Val_pressure'))
        }
        Vol_mcc= as.numeric(input$Vol_mcc)
        Val_pressure= as.numeric(input$Val_pressure)
        Other_surg = factor(input$Other_surg, levels = c('Yes', 'No'))
        Type_of_surgery = factor(input$Type_of_surgery, levels = c('Retropubic', 'Transobturator'))
        data <- data.frame(Dynamic = Dynamic,
                           AgeYr = AgeYr,
                           Race = Race,
                           VPARITY = VPARITY,
                           Menopause = Menopause,
                           BA = BA,
                           CX = CX,
                           Prior_pelv_surg = Prior_pelv_surg,
                           Pre_med_treat = Pre_med_treat,
                           Physical_leak = Physical_leak,
                           Small_leak = Small_leak,
                           Incom_blad = Incom_blad,
                           Urge_leak = Urge_leak,
                           ABD_pain = ABD_pain,
                           Dull_pelvic = Dull_pelvic,
                           Freq_urine = Freq_urine,
                           Entertainment_actv = Entertainment_actv,
                           Emotional_health = Emotional_health,
                           Recreation_actv = Recreation_actv,
                           Frustration = Frustration,
                           Max_fl_nif = Max_fl_nif,
                           Vol_mcc = Vol_mcc,
                           Val_pressure = Val_pressure,
                           Other_surg = Other_surg,
                           Type_of_surgery = Type_of_surgery)
        data})
    output$result <- renderDataTable({data = data()
    prob.adverse <- paste(ifelse(round(eval(predict.adverse, data), 0) < 1, "<1", ifelse(round(eval(predict.adverse, data), 0) > 99, ">99", round(eval(predict.adverse, data), 0))), "%")
    prob.bother <- paste(ifelse(round(eval(predict.bothersome, data), 0) < 1, "<1", ifelse(round(eval(predict.bothersome, data), 0) > 99, ">99", round(eval(predict.bothersome, data), 0))), "%")
    prob.urge <- paste(ifelse(round(eval(predict.urge, data), 0) < 1, "<1", ifelse(round(eval(predict.urge, data), 0) > 99, ">99", round(eval(predict.urge, data), 0))), "%")
    prob.stress <- paste(ifelse(round(eval(predict.stress, data), 0) < 1, "<1", ifelse(round(eval(predict.stress, data), 0) > 99, ">99", round(eval(predict.stress, data), 0))), "%")
    res = data.frame(Result = c("Risk of Any Adverse Event","Risk of Bothersome Stress Urinary Incontinence (SUI)","Risk of Bothersome Urgency Urinary Incontinence (UUI)","Risk of a Positive Stress Test"),
                     Probability = c(prob.adverse, prob.bother, prob.urge, prob.stress))
    
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
