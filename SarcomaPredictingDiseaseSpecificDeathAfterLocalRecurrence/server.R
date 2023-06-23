predict.1yr <- expression({
    lp <- 1- (0.9779854   ^   exp  (0.024251435 * SurgAge - 
                                        0.0000052683762 * max(SurgAge - 27.80384, 0)**3 + 
                                        0.000013633246 * max(SurgAge - 57.8137,0)**3 - 
                                        0.0000083648697 * max(SurgAge - 76.71456, 0)**3 +  
                                        1.3331259 * (Size == ">10 cm") + 
                                        0.74191358 * (Size == "5-10 cm") - 
                                        0.96882638 * (Grade == "Low") - 
                                        0.25283017 * (Depth == "Superficial") - 
                                        0.96487627 * (Site == "Lower Extremity") -  
                                        0.45219689 * (Site == "Retro-Intraabdominal") - 
                                        0.55362894 * (Site == "Thoracic/Trunk") - 
                                        1.0460627 * (Site == "Upper Extremity") -     
                                        0.19709084 * (Site == "Visceral") + 
                                        1.256304 * (Histo == "Leiomyosarcoma") + 
                                        0.86376689 * (Histo == "Liposarcoma") + 
                                        0.84095501 * (Histo == "MFH") + 
                                        2.0887329 * (Histo == "MPNT") + 
                                        1.2993295 * (Histo == "Other") + 
                                        1.7930444 * (Histo == "Synovial")))
})
predict.2yr <- expression({
    lp <- 1- ( 0.9512977   ^   exp  (0.024251435 * SurgAge - 
                                         0.0000052683762 * max(SurgAge - 27.80384, 0)**3 + 
                                         0.000013633246 * max(SurgAge - 57.8137,0)**3 - 
                                         0.0000083648697 * max(SurgAge - 76.71456, 0)**3 + 
                                         1.3331259 * (Size == ">10 cm") + 
                                         0.74191358 * (Size == "5-10 cm") - 
                                         0.96882638 * (Grade == "Low") - 
                                         0.25283017 * (Depth == "Superficial") - 
                                         0.96487627 * (Site == "Lower Extremity") -       
                                         0.45219689 * (Site == "Retro-Intraabdominal") - 
                                         0.55362894 * (Site ==       "Thoracic/Trunk") - 
                                         1.0460627 * (Site == "Upper Extremity") - 
                                         0.19709084 * (Site == "Visceral") + 
                                         1.256304 * (Histo == "Leiomyosarcoma") + 
                                         0.86376689 * (Histo == "Liposarcoma") + 
                                         0.84095501 * (Histo == "MFH") + 
                                         2.0887329 * (Histo == "MPNT") + 
                                         1.2993295 * (Histo == "Other") + 
                                         1.7930444 * (Histo == "Synovial")))
})
predict.3yr <- expression({
    lp <- 1- (0.9390208   ^   exp  (0.024251435 * SurgAge - 
                                        0.0000052683762 * max(SurgAge - 27.80384, 0)**3 + 
                                        0.000013633246 * max(SurgAge - 57.8137, 0)**3 - 
                                        0.0000083648697 * max(SurgAge - 76.71456, 0)**3 + 
                                        1.3331259 * (Size == ">10 cm") + 
                                        0.74191358 * (Size == "5-10 cm") - 
                                        0.96882638 * (Grade == "Low") - 
                                        0.25283017 * (Depth == "Superficial") - 
                                        0.96487627 * (Site == "Lower Extremity") - 
                                        0.45219689 * (Site == "Retro-Intraabdominal") - 
                                        0.55362894 * (Site == "Thoracic/Trunk") - 
                                        1.0460627 * (Site == "Upper Extremity") -       
                                        0.19709084 * (Site == "Visceral") + 
                                        1.256304 * (Histo == "Leiomyosarcoma") + 
                                        0.86376689 * (Histo == "Liposarcoma") + 
                                        0.84095501 * (Histo == "MFH") + 
                                        2.0887329 * (Histo == "MPNT") + 
                                        1.2993295 * (Histo == "Other") + 
                                        1.7930444 * (Histo == "Synovial")))
})
library(shiny)
shinyServer(function(input, output){
    data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$SurgAge))& as.numeric(input$SurgAge)>=17& as.numeric(input$SurgAge)<=89.5, 'Please input a valid SurgAge'))
        SurgAge= as.numeric(input$SurgAge)
        Depth = factor(input$Depth, levels = c('Superficial', 'Deep'))
        Grade = factor(input$Grade, levels = c('Low', 'High'))
        Histo = factor(input$Histo, levels = c('Leiomyosarcoma', 'Liposarcoma', 'MFH', 'MPNT', 'Synovial', 'Fibrosarcoma', 'Other'))
        Site = factor(input$Site, levels = c('Head and Neck', 'Upper Extremity', 'Lower Extremity', 'Retro-Intraabdominal', 'Thoracic/Trunk', 'Visceral'))
        Size = factor(input$Size, levels = c('<=5 cm', '5-10 cm', '>10 cm'))
        data <- data.frame(SurgAge = SurgAge,
                           Depth = Depth,
                           Grade = Grade,
                           Histo = Histo,
                           Site = Site,
                           Size = Size)
        data})
    output$result <- renderDataTable({data = data()
    prob.1yr <- paste(ifelse(round(eval(predict.1yr, data) * 100, 0) < 1, "<1", ifelse(round(eval(predict.1yr, data) * 100, 0) > 99, ">99", round(eval(predict.1yr, data) * 100, 0))), "%")
    prob.2yr <- paste(ifelse(round(eval(predict.2yr, data) * 100, 0) < 1, "<1", ifelse(round(eval(predict.2yr, data) * 100, 0) > 99, ">99", round(eval(predict.2yr, data) * 100, 0))), "%")
    prob.3yr <- paste(ifelse(round(eval(predict.3yr, data) * 100, 0) < 1, "<1", ifelse(round(eval(predict.3yr, data) * 100, 0) > 99, ">99", round(eval(predict.3yr, data) * 100, 0))), "%")
    res = data.frame(Result = c("1-year Risk","2-year Risk","3-year Risk"),
                     Probability = c(prob.1yr, prob.2yr, prob.3yr))
    
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
