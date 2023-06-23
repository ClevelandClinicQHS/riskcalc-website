predict.vte <- expression({
    lp = -7.337+ 
    (CHF=='Yes') * 1.883 + 
    (Paraplegia == 'Yes') * 1.743 + 
    (Return_to_Operating_Room == "Yes") * 1.631+ 
    (Dyspnea_at_Rest == "Yes") * 1.375 + 
    (Non_Gastric_Band_Surgery == 'Yes') * 0.893 + 
    (Age=="Yes") * 0.67 + 
    (Gender == "Male")*0.655 +
    (BMI == 'Yes') * 0.516 + 
    (Length_of_Stay == "Yes")*0.455+ 
    (Operation_Time == "Yes") * 0.451
    100/(1+exp(-lp))
})
        library(shiny)
        shinyServer(function(input, output){
            data <- eventReactive(input$goButton, {
        Gender = factor(input$Gender, levels = c('Male', 'Female'))
        Age = factor(input$Age, levels = c('No', 'Yes'))
        BMI = factor(input$BMI, levels = c('No', 'Yes'))
CHF = factor(input$CHF, levels = c('No', 'Yes'))
Dyspnea_at_Rest = factor(input$Dyspnea_at_Rest, levels = c('No', 'Yes'))
Paraplegia = factor(input$Paraplegia, levels = c('No', 'Yes'))
Non_Gastric_Band_Surgery = factor(input$Non_Gastric_Band_Surgery, levels = c('No', 'Yes'))
Operation_Time= factor(input$Operation_Time, levels = c('No', 'Yes'))
Return_to_Operating_Room = factor(input$Return_to_Operating_Room, levels = c('No', 'Yes'))
Length_of_Stay= factor(input$Length_of_Stay, levels = c('No', 'Yes'))
data <- data.frame(Gender = Gender,
Age = Age,
BMI = BMI,
CHF = CHF,
Dyspnea_at_Rest = Dyspnea_at_Rest,
Paraplegia = Paraplegia,
Non_Gastric_Band_Surgery = Non_Gastric_Band_Surgery,
Operation_Time = Operation_Time,
Return_to_Operating_Room = Return_to_Operating_Room,
Length_of_Stay = Length_of_Stay)
data})
output$result <- renderDataTable({data = data()
prob.vte = paste(ifelse(round(eval(predict.vte, data), 2) < 0.01, "<0.01", ifelse(round(eval(predict.vte, data), 2) > 99.99, ">99.99", round(eval(predict.vte, data), 2))), "%")
res = data.frame(Result = c("The predicted probability of thirty-day post-discharge VTE", "*Calculated risk >0.4% is an indication of extended VTE prophylaxis after hospital discharge"),
                 Probability = c(prob.vte, ""))

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
        