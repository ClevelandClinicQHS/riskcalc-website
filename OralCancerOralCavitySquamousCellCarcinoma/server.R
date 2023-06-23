predict.10yr <- expression({
    lp <-  1.3369771 - 0.090654322 * (Gender== "Male") + 
        0.0056273188 * AgeYr - 
        0.30542563 * (Tobacco == 'Yes (currently or previously)') - 
        0.48702055 * (Margins == "Negative") - 
        0.99936642 * (PathNStage == "N0") - 
        0.52841519 * (PathNStage == "N1") - 
        0.53375524 * (PathTStage == "T1") - 
        0.31332709 * (PathTStage == "T2") - 
        0.081519444 * (Grade == '1 (Well Diff)') - 
        0.065702803 * (Site == "Floor of Mouth") + 
        0.160716 * (Site == "Tongue") ;
    100 * 0.6288821 ** exp(lp)
})
        library(shiny)
        shinyServer(function(input, output){
            data <- eventReactive(input$goButton, {
        Gender = factor(input$Gender, levels = c('Male', 'Female'))
validate(need(!is.na(as.numeric(input$AgeYr))& as.numeric(input$AgeYr)>=14& as.numeric(input$AgeYr)<=94, 'Please input a valid AgeYr'))
AgeYr= as.numeric(input$AgeYr)
Tobacco = factor(input$Tobacco, levels = c('Yes (currently or previously)', 'No'))
Margins = factor(input$Margins, levels = c('Negative', 'Close/Positive'))
PathNStage = factor(input$PathNStage, levels = c('N0', 'N1', '>N1'))
PathTStage = factor(input$PathTStage, levels = c('T1', 'T2', '>T2'))
Grade = factor(input$Grade, levels = c('1 (Well Diff)', '2-3 (Mod/Poorly Diff)'))
Site = factor(input$Site, levels = c('Floor of Mouth', 'Tongue', 'Other'))
data <- data.frame(Gender = Gender,
AgeYr = AgeYr,
Tobacco = Tobacco,
Margins = Margins,
PathNStage = PathNStage,
PathTStage = PathTStage,
Grade = Grade,
Site = Site)
data})
output$result <- renderDataTable({data = data()
pred <- paste(ifelse(round(eval(predict.10yr, data), 0) < 1, "<1", ifelse(round(eval(predict.10yr, data), 0) > 99, ">99", round(eval(predict.10yr, data), 0))), "%")
res = data.frame(Result = c("Percentage of 5-Year Locoregional Recurrence-Free Survival"),
                 Probability = c(pred))

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
        