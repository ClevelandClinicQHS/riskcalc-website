predict.5yr <- expression({
    lp <- -1.7686247 + 
        0.014563065 * SurgAge +  
        0.000020997108 * max(SurgAge - 44, 0)**3 -  
        0.000043394022 * max(SurgAge - 60, 0)**3 + 
        0.000022396915 * max(SurgAge - 75, 0)**3 - 
        0.053519323 * (TumorGrade == "3") -  
        0.18814327 * (TumorHist == "Yes") + 
        0.00063621499 * PreOpPlatelet + 
        0.57912923 * (Ascites == "Yes") +  
        0.5518022 * (ResidDiam == "1-2 cm") - 
        0.3062644 * (ResidDiam == '<0.5 cm') + 
        0.6219986 * (ResidDiam == '>2 cm') - 
        0.54064543 * (ResidDiam == 'No Gross Residual')
    100 * 0.4284861 ^ exp(lp)
})
        library(shiny)
        shinyServer(function(input, output){
            data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$SurgAge))& as.numeric(input$SurgAge)>=22& as.numeric(input$SurgAge)<=87, 'Please input a valid SurgAge'))
SurgAge= as.numeric(input$SurgAge)
TumorGrade = factor(input$TumorGrade, levels = c('1-2', '3'))
TumorHist = factor(input$TumorHist, levels = c('Yes', 'No'))
validate(need(!is.na(as.numeric(input$PreOpPlatelet))& as.numeric(input$PreOpPlatelet)>=113& as.numeric(input$PreOpPlatelet)<=1078, 'Please input a valid PreOpPlatelet'))
PreOpPlatelet= as.numeric(input$PreOpPlatelet)
Ascites = factor(input$Ascites, levels = c('No', 'Yes'))
ResidDiam = factor(input$ResidDiam, levels = c('No Gross Residual', '<0.5 cm', '0.5-1 cm', '1-2 cm', '>2 cm'))
data <- data.frame(SurgAge = SurgAge,
TumorGrade = TumorGrade,
TumorHist = TumorHist,
PreOpPlatelet = PreOpPlatelet,
Ascites = Ascites,
ResidDiam = ResidDiam)
data})
output$result <- renderDataTable({data = data()
yr5 <- paste(ifelse(round(eval(predict.5yr, data), 0) < 1, "<1", ifelse(round(eval(predict.5yr, data), 0) > 99, ">99", round(eval(predict.5yr, data), 0))), "%")
res = data.frame(Result = c("5-Year Survival Percentage"), Probability = c(yr5))

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
        