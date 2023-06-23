formula.urinary <- expression({
    if (LabDeliv=="Yes"){
        lp <- 0.73669749 - 
            0.16168673 * LaborDuration + 
            0.019693294 * max(LaborDuration - 0.38333333, 0)**3 - 
            0.028914757 * max(LaborDuration - 1.3666667, 0)**3 + 
            0.009221463 * max(LaborDuration - 3.4666667, 0)**3 + 
            0.27702873 * (PrePregUI == "Rarely") + 
            1.4833269 * (PrePregUI == "Sometimes") + 
            1.822776 * (AnteUI == "Often") + 
            0.47485691 *(AnteUI == "Rarely") + 
            1.3184012 * (AnteUI == "Sometimes") - 
            0.54911332 * (DeliveryType == "Cesarean (other)") +        
            0.24370869 * (DeliveryType == "Vaginal (forceps)") + 
            0.38475273 * (DeliveryType == "Vaginal (spontaneous)") - 
            0.21066812 * (DeliveryType == "Vaginal (vacuum)") - 
            0.16179702 * (Episiotomy == "Yes") + 
            0.37144217 * (PerinealLaceration == "2nd") + 
            0.69387896 * (PerinealLaceration == "3rd") + 
            1.2552572 * (PerinealLaceration == "4th") + 
            0.91093714 * (PerinealLaceration == "Complete 3rd") +  
            0.40071399 * (PerinealLaceration == "No") + 
            0.3794608 * (PerinealLaceration == "Partial 3rd") - 
            0.00057006677 * FetalBirthweight + 
            4.7845454e-10 *  max(FetalBirthweight - 2893, 0)**3 - 
            8.9190578e-10 * max(FetalBirthweight - 3440, 0)**3 + 
            4.1345124e-10 * max(FetalBirthweight - 4073, 0)**3 + 
            0.0045150018 * FetalCircumference - 
            0.0020895264 * max(FetalCircumference - 32, 0)**3 + 
            0.0041790528 * max(FetalCircumference - 34, 0)**3 - 
            0.0020895264 *  max(FetalCircumference - 36, 0)**3 - 
            0.11981902 * (FetalHeadPos == "Yes") - 
            0.99211886 * (Race == "Black") - 
            0.8891163 * (Race == "White") + 
            0.060315638 * PrePregBMI + 
            0.010876624 *  PreDelivBMI - 
            0.074781503 * AgeYr + 
            0.00019714128 *  max(AgeYr - 19.307324, 0)**3 - 
            0.00039590567 * max(AgeYr - 27.353867, 0)**3 + 
            0.0001987644 * max(AgeYr - 35.334702, 0)**3
        }
    else {
        lp <- -0.45112196 - 
            1.1313696 * (Race == "Black") - 
            1.0597182 * (Race == "White") + 
            0.32765287 * (PrePregUI == "Rarely") + 
            1.5322522 * (PrePregUI == "Sometimes") + 
            2.0296313 * (AnteUI == "Often") + 
            0.41522307 * (AnteUI == "Rarely") + 
            1.2191473 * (AnteUI == "Sometimes") + 
            0.039895848 * PrePregBMI + 
            0.04123124 * PreDelivBMI - 
            0.084709734 * AgeYr + 
            0.00018642488 * max(AgeYr - 19.307324, 0)**3 - 
            0.00037929591 * max(AgeYr -      27.540041, 0)**3 + 
            0.00019287102 * max(AgeYr - 35.497604, 0)**3 - 
            0.029336494 * (PlannedDeliv == "Vaginal")
    }
    100/(1+exp(-lp))
})
formula.fecal <- expression({
    if (LabDeliv=="Yes")  {
        lp <- -9.4369216 -
            0.071997852 * LaborDuration + 
            0.0186394 * max(LaborDuration -        0.38333333, 0)**3 - 
            0.026207277 * max(LaborDuration - 1.2833333,         0)**3 + 
            0.0075678768 * max(LaborDuration - 3.5, 0)**3 - 
            1.1371764 *         (PrePregUI == "Rarely") + 
            1.1417891 * (PrePregUI == "Sometimes") +         
            0.36026338 * (AnteUI == "Often") + 
            0.59086094 * (AnteUI ==        "Rarely") + 
            1.213443 * (AnteUI == "Sometimes") + 
            0.16082542 *         (DeliveryType == "Cesarean (other)") + 
            1.2850026 * (DeliveryType ==         "Vaginal (forceps)") + 
            1.0881135 * (DeliveryType == "Vaginal (spontaneous)") +         
            1.5169477 * (DeliveryType == "Vaginal (vacuum)") + 
            0.11731541 *         (Episiotomy == "Yes") + 
            0.060402723 * (PerinealLaceration == "2nd") +        
            0.89008304 * (PerinealLaceration == "3rd") + 
            1.1826699 * (PerinealLaceration ==         "4th") + 
            0.8771876 * (PerinealLaceration == "Complete 3rd") + 
            1.2476861 *         (PerinealLaceration == "No") + 
            0.59814912 * (PerinealLaceration == "Partial 3rd") +        
            0.00032133165 * FetalBirthweight - 
            3.8114489e-10 * max(FetalBirthweight -         2910, 0)**3 + 
            6.9846458e-10 * max(FetalBirthweight - 3437, 0)**3 -         
            3.1731968e-10 * max(FetalBirthweight - 4070, 0)**3 + 
            0.050734348 *        FetalCircumference - 
            0.0020435455 * max(FetalCircumference - 32, 0)**3 + 
            0.004087091 *         max(FetalCircumference - 34, 0)**3 - 
            0.0020435455 * max(FetalCircumference - 36,         0)**3 - 
            0.23979945 * (FetalHeadPos == "Yes") - 
            1.2887574 * (Race ==         "Black") - 
            0.56205163 * (Race == "White") + 
            0.074223406 *         PrePregBMI + 
            0.0064332305 * PreDelivBMI + 
            0.041701659 *         AgeYr + 
            4.4951069e-05 * max(AgeYr - 19.370294, 0)**3 - 
            9.0695391e-05 *         max(AgeYr - 27.422313, 0)**3 + 
            4.5744323e-05 * max(AgeYr -         35.334702, 0)**3
    } else {
            lp <- -6.0602533 - 
                1.3306754 * (Race == "Black") - 
                0.45631852 *        (Race == "White") - 
                1.305753 * (PrePregUI == "Rarely") +         
                1.1480257 * (PrePregUI == "Sometimes") + 
                0.17333387 *         (AnteUI == "Often") + 
                0.5144649 * (AnteUI == "Rarely") +         
                1.1608139 * (AnteUI == "Sometimes") + 
                0.035040759 * PrePregBMI +         
                0.026753232 * PreDelivBMI + 
                0.062884042 * AgeYr - 
                8.0975984e-05 *         max(AgeYr - 19.307324, 0)**3 + 
                0.00016475193 * max(AgeYr -         27.540041, 0)**3 - 
                8.3775945e-05 * max(AgeYr - 35.497604,        0)**3 + 
                0.97116522 * (PlannedDeliv == "Vaginal")
    }
    100/(1+exp(-lp))
})
        library(shiny)
        shinyServer(function(input, output){
            data <- eventReactive(input$goButton, {
        Race = factor(input$Race, levels = c('Black', 'White', 'Asian', 'Unknown'))
PrePregUI = factor(input$PrePregUI, levels = c('Sometimes', 'Rarely', 'Never', 'Unknown'))
AnteUI = factor(input$AnteUI, levels = c('Often', 'Sometimes', 'Rarely', 'Never', 'Unknown'))
validate(need(!is.na(as.numeric(input$PrePregBMI))& as.numeric(input$PrePregBMI)>=0, 'Please input a valid PrePregBMI'))
PrePregBMI= as.numeric(input$PrePregBMI)
validate(need(!is.na(as.numeric(input$PreDelivBMI))& as.numeric(input$PreDelivBMI)>=0, 'Please input a valid PreDelivBMI'))
PreDelivBMI= as.numeric(input$PreDelivBMI)
PlannedDeliv = factor(input$PlannedDeliv, levels = c('Vaginal', 'Cesarean'))
validate(need(!is.na(as.numeric(input$AgeYr))& as.numeric(input$AgeYr)>=0, 'Please input a valid AgeYr'))
AgeYr= as.numeric(input$AgeYr)
LabDeliv = factor(input$LabDeliv, levels = c('No', 'Yes'))
if (LabDeliv == "Yes") {
    validate(need(!is.na(as.numeric(input$LaborDuration))& as.numeric(input$LaborDuration)>=0, 'Please input a valid LaborDuration'))
    validate(need(!is.na(as.numeric(input$FetalBirthweight))& as.numeric(input$FetalBirthweight)>=0, 'Please input a valid FetalBirthweight'))
    validate(need(!is.na(as.numeric(input$FetalCircumference))& as.numeric(input$FetalCircumference)>=0, 'Please input a valid FetalCircumference'))
}
LaborDuration= as.numeric(input$LaborDuration)
DeliveryType = factor(input$DeliveryType, levels = c('Cesarean (other)', 'Vaginal (forceps)', 'Vaginal (spontaneous)', 'Vaginal (vacuum)', 'Cesarean (elective)', 'Unknown'))
Episiotomy = factor(input$Episiotomy, levels = c('Yes', 'No', 'Unknown'))
PerinealLaceration = factor(input$PerinealLaceration, levels = c('No', '1st degree', '2nd degree', 'Partial 3rd degree', 'Complete 3rd degree', '3rd degree', '4th degree', 'Unknown'))
FetalBirthweight= as.numeric(input$FetalBirthweight)
FetalCircumference= as.numeric(input$FetalCircumference)
FetalHeadPos = factor(input$FetalHeadPos, levels = c('Yes', 'No', 'Unknown'))
data <- data.frame(Race = Race,
PrePregUI = PrePregUI,
AnteUI = AnteUI,
PrePregBMI = PrePregBMI,
PreDelivBMI = PreDelivBMI,
PlannedDeliv = PlannedDeliv,
AgeYr = AgeYr,
LabDeliv = LabDeliv,
LaborDuration = LaborDuration,
DeliveryType = DeliveryType,
Episiotomy = Episiotomy,
PerinealLaceration = PerinealLaceration,
FetalBirthweight = FetalBirthweight,
FetalCircumference = FetalCircumference,
FetalHeadPos = FetalHeadPos)
data})
output$result <- renderDataTable({data = data()
prob.fecal = eval(formula.fecal, data)
prob.urinary = eval(formula.urinary, data)
res = data.frame(Result = c("Fecal Incontinence","Urinary Incontinence"),
                 Probability = c(paste(ifelse(round(prob.fecal, 0) < 1, "<1", ifelse(round(prob.fecal, 0) > 99, ">99", round(prob.fecal, 0))), "%"), paste(ifelse(round(prob.urinary, 0) < 1, "<1", ifelse(round(prob.urinary, 0) > 99, ">99", round(prob.urinary, 0))), "%")))

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
        