predict.preoperative <- expression({
    lp = -1.6954213 - 
        0.0030837064 * AGE + 
        0.000024996554 * max(AGE - 39, 0)**3 - 
        0.00004374397 * max(AGE - 54, 0)**3 + 
        0.000018747416 * max(AGE - 74, 0)**3 + 
        0.043612275 * BMI + 
        0.00023919832 * max(BMI - 21.8, 0)**3 - 
        0.00042191926 * max(BMI - 27.3, 0)**3 + 
        0.00018272094 * max(BMI - 34.5, 0)**3 + 
        0.36048989 * NEOCHEMO
    1 - 0.6936943 ** exp(lp)
})

predict.within6 <- expression({
    lp = -2.1241237 + 
        0.0019777438 * AGE + 
        0.000025418142 * max(AGE - 39, 0)**3 - 
        0.000044481749 * max(AGE - 54, 0)**3 + 
        0.000019063607 * max(AGE - 74, 0)**3 + 
        0.065103153 * BMI + 
        0.0001355579 * max(BMI - 21.8, 0)**3 - 
        0.00023910907 * max(BMI - 27.3, 0)**3 + 
        0.00010355117 * max(BMI - 34.5, 0)**3 + 
        0.18302761 * NEOCHEMO + 
        0.56516671 * (AXILLARYLEVEL == "I-II and III") - 
        1.043021 * (RXTLOCATION1 == "No RXT or Breast or Chest Wall")
    1 - 0.7193179 ** exp(lp)
})

predict.after6 <- expression({
    lp = -1.3435044 - 
        0.0072631313 * AGE + 
        0.000022761596 * max(AGE - 39, 0)**3 - 
        0.000039832793 * max(AGE - 54, 0)**3 + 
        0.000017071197 * max(AGE - 74, 0)**3 + 
        0.062663863 * BMI + 
        0.000039726 * max(BMI - 21.8, 0)**3 - 
        0.00007007225 * max(BMI - 27.3, 0)**3 + 
        0.00003034625 * max(BMI - 34.5, 0)**3 + 
        0.11949068 * NEOCHEMO + 
        0.37699075 * (AXILLARYLEVEL == "I-II and III") - 
        1.2494203 * (RXTLOCATION1 == "No RXT or Breast or Chest Wall") + 
        0.33283853 * (SEROMA == "Yes") + 
        2.1517696 * (EARLYEDEMA == "Yes")
    1 - 0.7460854 ** exp(lp)
})

shinyServer(function(input, output) {
    observe({
        if (input$time == "Preoperative") {
            shinyjs::hide(id = "display1", anim = TRUE)
            shinyjs::hide(id = "display2", anim = TRUE)
        } else if (input$time == "Within 6 months after surgery") {
            shinyjs::show(id = "display1", anim = TRUE)
            shinyjs::hide(id = "display2", anim = TRUE)
        } else if (input$time == "6 months or more after surgery") {
            shinyjs::show(id = "display1", anim = TRUE)
            shinyjs::show(id = "display2", anim = TRUE)
        }
    })
    
    # Return the requested dataset
    data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$AGE)) & as.numeric(input$AGE)>=20& as.numeric(input$AGE)<=90, 'Please input a valid Age'))
        AGE= as.numeric(input$AGE)
        validate(need(!is.na(as.numeric(input$WEIGHT)) & as.numeric(input$WEIGHT)>=40& as.numeric(input$WEIGHT)<=150, 'Please input a valid Weight'))
        WEIGHT= as.numeric(input$WEIGHT)
        validate(need(!is.na(as.numeric(input$HEIGHT)) & as.numeric(input$HEIGHT)>=1.5& as.numeric(input$HEIGHT)<=2.5, 'Please input a valid Height'))
        HEIGHT= as.numeric(input$HEIGHT)
        validate(need(!is.na(as.numeric(input$NEOCHEMO)) & as.numeric(input$NEOCHEMO)>=0& as.numeric(input$HEIGHT)<=10, 'Please input a valid "Number of cycles of neo- or adjuvant chemotherapy infusions in ipsilateral arm"'))
        NEOCHEMO= as.numeric(input$NEOCHEMO)
        AXILLARYLEVEL = factor(input$AXILLARYLEVEL, levels = c('I-II', 'I-II and III'))
        RXTLOCATION1 = factor(input$RXTLOCATION1, levels = c('Include Lymph Node Basin', 'No RXT or Breast or Chest Wall'))
        SEROMA = factor(input$SEROMA, levels = c('No', 'Yes'))
        EARLYEDEMA = factor(input$EARLYEDEMA, levels = c('No', 'Yes'))
        data <- data.frame(AGE = AGE,
                           WEIGHT = WEIGHT,
                           HEIGHT = HEIGHT,
                           NEOCHEMO = NEOCHEMO,
                           AXILLARYLEVEL = AXILLARYLEVEL,
                           RXTLOCATION1 = RXTLOCATION1,
                           SEROMA = SEROMA,
                           EARLYEDEMA = EARLYEDEMA
                           )
        data$BMI = data$WEIGHT / (data$HEIGHT * data$HEIGHT)
        data})
    
    
    # Generate a summary of the dataset
    output$result <- renderDataTable({
        data = data()
        risk = 0
        if (input$time == "Preoperative") {
            risk = round(eval(predict.preoperative, data) * 100, 1)
        } else if (input$time == "Within 6 months after surgery") {
            risk = round(eval(predict.within6, data) * 100, 1)
        } else if (input$time == "6 months or more after surgery") {
            risk = round(eval(predict.after6, data) * 100, 1)
        }
        risk = paste(ifelse(risk < 1, "<1", ifelse(risk > 99, ">99", risk)), "%")
        
        res = data.frame(Result = c("Predicted 5-year lymphedema probability"),
                         Probability = c(risk))
        res}, options = list(
            pageLength = 10,
            lengthMenu = 0,
            searching = 0,
            info = 0,
            paging = 0,
            initComplete = I(
                "function(settings, json) {
            $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});}"
            )))
    
})
