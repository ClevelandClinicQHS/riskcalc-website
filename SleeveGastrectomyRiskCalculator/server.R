predict.event <- expression({
    lp <- -3.497 + 
          0.487*(Diabetes == "Yes") + 
          0.0307*BMI + 
          0.517*(Gender == "Male") + 
          1.83*(History_CHF == "Yes") + 
          1.61*(Steriod_Use_Chronic_Condition == "Yes") + 
          0.451*(Preop_Serum_Total_Bilirubin_Level == "1") + 
          0.902*(Preop_Serum_Total_Bilirubin_Level == "2") + 
          1.353*(Preop_Serum_Total_Bilirubin_Level == "3") - 
          0.054*Preop_Hematocrit_Level
    100/(1+exp(-lp))
})
        library(shiny)
        shinyServer(function(input, output){
            data <- eventReactive(input$goButton, {
        Gender = factor(input$Gender, levels = c('Male', 'Female'))
validate(need(!is.na(as.numeric(input$BMI))& as.numeric(input$BMI)>=30& as.numeric(input$BMI)<=100, 'Please input a valid BMI'))
BMI= as.numeric(input$BMI)
Diabetes = factor(input$Diabetes, levels = c('No', 'Yes'))
History_CHF = factor(input$History_CHF, levels = c('No', 'Yes'))
Steriod_Use_Chronic_Condition = factor(input$Steriod_Use_Chronic_Condition, levels = c('No', 'Yes'))
validate(need(!is.na(as.numeric(input$Preop_Hematocrit_Level))& as.numeric(input$Preop_Hematocrit_Level)>=27& as.numeric(input$Preop_Hematocrit_Level)<=54, 'Please input a valid Preop_Hematocrit_Level'))
Preop_Hematocrit_Level= as.numeric(input$Preop_Hematocrit_Level)
Preop_Serum_Total_Bilirubin_Level = factor(input$Preop_Serum_Total_Bilirubin_Level, levels = c('0', '1', '2', '3'))
data <- data.frame(Gender = Gender,
BMI = BMI,
Diabetes = Diabetes,
History_CHF = History_CHF,
Steriod_Use_Chronic_Condition = Steriod_Use_Chronic_Condition,
Preop_Hematocrit_Level = Preop_Hematocrit_Level,
Preop_Serum_Total_Bilirubin_Level = Preop_Serum_Total_Bilirubin_Level)
data})
output$result <- renderDataTable({data = data()
prob.event <- paste(ifelse(round(eval(predict.event, data), 0) < 1, "<1", ifelse(round(eval(predict.event, data), 0) > 99, ">99", round(eval(predict.event, data), 0))), "%")
res = data.frame(Result = c("Estimated Probability of Serious Adverse Events"),
                 Probability  = c(prob.event))

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
        