predict.positive <- expression({
    lp = -3.9387973 - 0.0034288107 * AgeYr - 
        4.9345273e-06 * max(AgeYr - 33, 0)**3 + 
        1.0609234e-05 * max(AgeYr - 56, 0)**3 - 
        5.6747064e-06 * max(AgeYr - 76, 0)**3 - 
        0.50247535 * (Site =='Head / Neck') +          
        0.09587435 * (Site == "Trunk") + 
        0.88752778 * Thickness -          
        0.068841508 * max(Thickness - 0.9, 0)**3 + 
        0.08558674 * max(Thickness - 1.8, 0)**3 - 
        0.016745232 * max(Thickness - 5.5, 0)**3 + 
        0.77159127 * (Level == "4") + 
        0.53421698 * (Level == "5") + 
        0.5350161 * (ULC == "Yes")
    100/(1+exp(-lp))
})
        library(shiny)
        shinyServer(function(input, output){
            data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$AgeYr))& as.numeric(input$AgeYr)>=5& as.numeric(input$AgeYr)<=96, 'Please input a valid AgeYr'))
AgeYr= as.numeric(input$AgeYr)
Site = factor(input$Site, levels = c('Head / Neck', 'Trunk', 'Extremities'))
validate(need(!is.na(as.numeric(input$Thickness))& as.numeric(input$Thickness)>=0& as.numeric(input$Thickness)<=38, 'Please input a valid Thickness'))
Thickness= as.numeric(input$Thickness)
Level = factor(input$Level, levels = c('2/3', '4', '5'))
ULC = factor(input$ULC, levels = c('No', 'Yes'))
data <- data.frame(AgeYr = AgeYr,
Site = Site,
Thickness = Thickness,
Level = Level,
ULC = ULC)
data})
output$result <- renderDataTable({data = data()
chance = paste(ifelse(round(eval(predict.positive, data), 0) < 1, "<1", ifelse(round(eval(predict.positive, data), 0) > 99, ">99", round(eval(predict.positive, data), 0))), "%")
res = data.frame(Result = c("Percent Chance of Positive Sentinel Lymph Nodes"),
Probability = c(chance))
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
        