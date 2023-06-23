formula <- expression({
    lp <- -4.9148047 + 
        0.13838326 * (SurgSite == "Rectum") + 
        0.09374104 * (SurgSite == "Small Bowel") + 
        0.29043037 * (Smoke == "Yes") - 
        0.14486527 * (ASAClass == "2 Mild Systemic Disease") - 
        0.07190024 * (ASAClass == "3 Severe Systemic Disease") + 
        0.30259262 * (ASAClass == "4-5 Life Threatening Disease or Moribund")  + 
        0.41619888 * (WoundClass == "3 Contaminated") + 
        0.56611095 * (WoundClass == "4 Dirty/Infected") - 
        0.0096272136 * AgeYr + 
        2.7931253e-06 * max(AgeYr - 38, 0)**3 - 
        6.0052194e-06 * max(AgeYr - 61, 0)**3 + 
        3.2120941e-06 * max(AgeYr - 81, 0)**3 + 
        0.02001738 * BMI - 
        0.0001089196 * max(BMI - 20.714476, 0)**3 + 
        0.00018428974 * max(BMI - 26.885108, 0)**3 - 
        7.5370141e-05 * max(BMI - 35.802469, 0)**3 + 
        0.11079002 * Creatinine + 
        0.053617398 * max(Creatinine - 0.6, 0)**3 - 
        0.093830446 * max(Creatinine - 0.9, 0)**3 + 
        0.040213048 * max(Creatinine - 1.3, 0)**3 - 
        0.045255438 * Albumin - 
        0.027168055 * max(Albumin - 3, 0)**3 + 
        0.072448146 * max(Albumin - 4, 0)**3 - 
        0.045280091 * max(Albumin - 4.6, 0)**3 + 
        0.0027972297 * (Gender == "Male") + 
        0.34546569 * (Transfusion == "Yes") + 
        0.0094421184 * OpTime - 
        1.5572552e-07 * max(OpTime - 70, 0)**3 + 
        2.4520959e-07 * max(OpTime - 147, 0)**3 - 
        8.9484069e-08 * max(OpTime - 281, 0)**3  - 
        0.1939685 * (Diabetes2 == "No") + 
        0.21978942 * (Steroid == "Yes") + 
        0.60902516 * (Proper30 == "Yes") + 
        0.18529725 * (Radio == "Yes")  - 
        0.26984456 * (Technique == "Laparoscopic")
    100 / (1+exp(-lp))
})
        library(shiny)
        shinyServer(function(input, output){
            data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$AgeYr))& as.numeric(input$AgeYr)>=18& as.numeric(input$AgeYr)<=90, 'Please input a valid AgeYr'))
AgeYr= as.numeric(input$AgeYr)
Gender = factor(input$Gender, levels = c('Male', 'Female'))
validate(need(!is.na(as.numeric(input$BMI))& as.numeric(input$BMI)>=15& as.numeric(input$BMI)<=50, 'Please input a valid BMI'))
BMI= as.numeric(input$BMI)
Smoke = factor(input$Smoke, levels = c('No', 'Yes'))
SurgSite = factor(input$SurgSite, levels = c('Rectum', 'Small Bowel', 'Colon'))
ASAClass = factor(input$ASAClass, levels = c('1 Normal', '2 Mild Systemic Disease', '3 Severe Systemic Disease', '4-5 Life Threatening Disease or Moribund'))
WoundClass = factor(input$WoundClass, levels = c('1-2 Clean-Clean/Contaminated', '3 Contaminated', '4 Dirty/Infected'))
Diabetes2 = factor(input$Diabetes2, levels = c('No', 'Yes'))
Steroid = factor(input$Steroid, levels = c('No', 'Yes'))
Proper30 = factor(input$Proper30, levels = c('No', 'Yes'))
Radio = factor(input$Radio, levels = c('No', 'Yes'))
Technique = factor(input$Technique, levels = c('Open', 'Laparoscopic'))
validate(need(!is.na(as.numeric(input$Creatinine))& as.numeric(input$Creatinine)>=0.1& as.numeric(input$Creatinine)<=6, 'Please input a valid Creatinine'))
Creatinine= as.numeric(input$Creatinine)
validate(need(!is.na(as.numeric(input$Albumin))& as.numeric(input$Albumin)>=1& as.numeric(input$Albumin)<=6, 'Please input a valid Albumin'))
Albumin= as.numeric(input$Albumin)
Transfusion = factor(input$Transfusion, levels = c('No', 'Yes'))
validate(need(!is.na(as.numeric(input$OpTime))& as.numeric(input$OpTime)>=0& as.numeric(input$OpTime)<=540, 'Please input a valid OpTime'))
OpTime= as.numeric(input$OpTime)
data <- data.frame(AgeYr = AgeYr,
Gender = Gender,
BMI = BMI,
Smoke = Smoke,
SurgSite = SurgSite,
ASAClass = ASAClass,
WoundClass = WoundClass,
Diabetes2 = Diabetes2,
Steroid = Steroid,
Proper30 = Proper30,
Radio = Radio,
Technique = Technique,
Creatinine = Creatinine,
Albumin = Albumin,
Transfusion = Transfusion,
OpTime = OpTime)
data})
output$result <- renderDataTable({data = data()
prob <- eval(formula, data)
res = data.frame(Result = c("30-Day Percent Chance of Organ Space Surgical Site Infection"),
                 Probability = c(paste(ifelse(round(prob, 0) < 1, "<1", ifelse(round(prob, 0) > 99, ">99", round(prob, 0))), "%")))

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
        