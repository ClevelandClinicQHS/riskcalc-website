predict.liver <- expression({
    lp <- -1.1931836 - 
        0.034482195 * Karnofsky_Score + 
        0.029689078 * age + 
        0.000037817252 * max(age - 42, 0)**3 - 
        0.000082510367 * max(age - 55, 0)**3 + 
        0.000044693116 * max(age - 66, 0)**3 + 
        2.3277348 * INR - 
        2.6743728 * max(INR - 1.1, 0)**3 + 
        3.8205326 * max(INR - 1.4, 0)**3 - 
        1.1461598 * max(INR - 2.1, 0)**3 + 
        0.92019636 * Serum_Creatinine - 
        0.52644474 * max(Serum_Creatinine - 0.7, 0)**3 + 
        0.60165113 * max(Serum_Creatinine - 1, 0)**3 - 
        0.075206391 * max(Serum_Creatinine - 3.1, 0)**3 + 
        0.53761446 * (History_Diabetes == "Yes") - 
        0.10969875 * Bilirubin + 
        0.0010745634 * max(Bilirubin - 1, 0)**3 - 
        0.0012248977 * max(Bilirubin - 3.3, 0)**3 + 
        0.0001503343 * max(Bilirubin - 19.74, 0)**3 - 
        0.60712218 * Albumin + 
        0.18528165 * max(Albumin - 2.1, 0)**3 - 
        0.34997646 * max(Albumin - 2.9, 0)**3 + 
        0.1646948 * max(Albumin - 3.8, 0)**3 - 
        0.067877556 * BMI + 
        0.00036666299 * max(BMI - 22, 0)**3 - 
        0.00061110498 * max(BMI - 28, 0)**3 + 
        0.00024444199 * max(BMI - 37, 0)**3 + 
        0.9883279 * (Renal_Dialysis == "Yes") - 
        0.32916729 * (Sex == "Male")
    100/(1+exp(-lp))
})
        library(shiny)
        shinyServer(function(input, output){
            data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$Karnofsky_Score))& as.numeric(input$Karnofsky_Score)>=10& as.numeric(input$Karnofsky_Score)<=90, 'Please input a valid Karnofsky_Score'))
Karnofsky_Score= as.numeric(input$Karnofsky_Score)
validate(need(!is.na(as.numeric(input$age))& as.numeric(input$age)>=20& as.numeric(input$age)<=80, 'Please input a valid age'))
age= as.numeric(input$age)
validate(need(!is.na(as.numeric(input$INR))& as.numeric(input$INR)>=0& as.numeric(input$INR)<=10, 'Please input a valid INR'))
INR= as.numeric(input$INR)
validate(need(!is.na(as.numeric(input$Serum_Creatinine))& as.numeric(input$Serum_Creatinine)>=0& as.numeric(input$Serum_Creatinine)<=10, 'Please input a valid Serum_Creatinine'))
Serum_Creatinine= as.numeric(input$Serum_Creatinine)
History_Diabetes = factor(input$History_Diabetes, levels = c('No', 'Yes'))
validate(need(!is.na(as.numeric(input$Bilirubin))& as.numeric(input$Bilirubin)>=0& as.numeric(input$Bilirubin)<=65, 'Please input a valid Bilirubin'))
Bilirubin= as.numeric(input$Bilirubin)
validate(need(!is.na(as.numeric(input$Albumin))& as.numeric(input$Albumin)>=1& as.numeric(input$Albumin)<=7, 'Please input a valid Albumin'))
Albumin= as.numeric(input$Albumin)
validate(need(!is.na(as.numeric(input$BMI))& as.numeric(input$BMI)>=15& as.numeric(input$BMI)<=55, 'Please input a valid BMI'))
BMI= as.numeric(input$BMI)
Renal_Dialysis = factor(input$Renal_Dialysis, levels = c('No', 'Yes'))
Sex = factor(input$Sex, levels = c('Female', 'Male'))
data <- data.frame(Karnofsky_Score = Karnofsky_Score,
age = age,
INR = INR,
Serum_Creatinine = Serum_Creatinine,
History_Diabetes = History_Diabetes,
Bilirubin = Bilirubin,
Albumin = Albumin,
BMI = BMI,
Renal_Dialysis = Renal_Dialysis,
Sex = Sex)
data})
output$result <- renderDataTable({data = data()
liver <- paste(ifelse(round(eval(predict.liver, data), 0) < 1, "<1", ifelse(round(eval(predict.liver, data), 0) > 99, ">99", round(eval(predict.liver, data), 0))), "%")
res = data.frame(Result = c("Predicted Probability of Discharging to Extended Care Facility (ECF)"),
                 Probability = c(liver))

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
        