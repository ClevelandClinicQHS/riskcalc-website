predict.high <- expression({
    lp <- 1*(1- (0.5875453   ^   exp (-0.12440647 - 
                                          0.73661411 * (Size == "<=5") + 
                                          0.43366449 *(Size == ">10") - 
                                          0.48941318 * (Depth == "Superficial") - 
                                          0.92503872 * (Site == "Lower Extremity") - 
                                          0.36490333 * (Site == "Retro-Intraabdominal") - 
                                          0.50206697 * (Site ==  "Thoracic or Trunk") - 
                                          1.0290006 * (Site == "Upper Extremity") - 
                                          0.57383052 * (Site == "Visceral") - 
                                          1.1026615 * (Histo == "Fibrosarcoma") - 
                                          0.095052484 * (Histo == "Leiomyosarcoma") - 
                                          0.44073869 * (Histo == "Liposarcoma") - 
                                          0.24425099 * (Histo == "MFH") + 
                                          0.56271564 * (Histo == "MPNT") + 
                                          0.081272466 * (Histo == "Synovial") + 
                                          0.29697501 * log(AgeYr) + 
                                          0.4606532 *  max(log(AgeYr) - 3.2833593, 0)**3 - 
                                          1.2313568 * max(log(AgeYr) - 3.925628, 0)**3 + 
                                          0.77070362 * max(log(AgeYr) - 4.3095151, 0)**3)))
})
predict.low <- expression({
    lp <- 1*(1- (0.8373887    ^    exp(-0.12440647 - 
                                           0.73661411 * (Size == "<=5") + 
                                           0.43366449 * (Size == ">10") - 
                                           0.48941318 * (Depth == "Superficial") - 
                                           0.92503872 * (Site == "Lower Extremity") - 
                                           0.36490333 * (Site == "Retro-Intraabdominal") - 
                                           0.50206697 * (Site =="Thoracic or Trunk") - 
                                           1.0290006 * (Site == "Upper Extremity") - 
                                           0.57383052 * (Site == "Visceral") - 
                                           1.1026615 * (Histo == "Fibrosarcoma") - 
                                           0.095052484 * (Histo == "Leiomyosarcoma") -  
                                           0.44073869 * (Histo == "Liposarcoma") - 
                                           0.24425099 * (Histo == "MFH") + 
                                           0.56271564 * (Histo == "MPNT") + 
                                           0.081272466 * (Histo == "Synovial") + 
                                           0.29697501 * log(AgeYr) + 
                                           0.4606532 * max(log(AgeYr) - 3.2833593, 0)**3 - 
                                           1.2313568 * max(log(AgeYr) - 3.925628,0)**3 + 
                                           0.77070362 * max(log(AgeYr) - 4.3095151, 0)**3)))
})
        library(shiny)
        shinyServer(function(input, output){
            data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$AgeYr))& as.numeric(input$AgeYr)>=10& as.numeric(input$AgeYr)<=100, 'Please input a valid AgeYr'))
AgeYr= as.numeric(input$AgeYr)
Size = factor(input$Size, levels = c('<=5', '5-10', '>10'))
Depth = factor(input$Depth, levels = c('Superficial', 'Deep'))
Site = factor(input$Site, levels = c('Head & Neck', 'Upper Extremity', 'Lower Extremity', 'Retro-Intraabdominal', 'Thoracic or Trunk', 'Visceral'))
Histo = factor(input$Histo, levels = c('Fibrosarcoma', 'Leiomyosarcoma', 'Liposarcoma', 'MFH', 'MPNT', 'Synovial', 'Other'))
data <- data.frame(AgeYr = AgeYr,
Size = Size,
Depth = Depth,
Site = Site,
Histo = Histo)
data})
output$result <- renderDataTable({data = data()
prob.high <- paste(ifelse(round(eval(predict.high, data) * 100, 0) < 1, "<1", ifelse(round(eval(predict.high, data) * 100, 0) > 99, ">99", round(eval(predict.high, data) * 100, 0))), "%")
prob.low <- paste(ifelse(round(eval(predict.low, data) * 100, 0) < 1, "<1", ifelse(round(eval(predict.low, data) * 100, 0) > 99, ">99", round(eval(predict.low, data) * 100, 0))), "%")
res = data.frame(Result = c("Probability of Sarcoma-Specific Death at 12 years if tumor grade is low (well-differentiated/less likely to spread)","Probability of Sarcoma-Specific Death at 12 years if tumor grade is high (less differentiated/more like to spread)"),
                 Probability = c(prob.low, prob.high))

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
        