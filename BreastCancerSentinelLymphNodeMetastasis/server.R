formula <- expression({
    if (ERTest == 'Unknown' | PRTest == 'Unknown') {
        lp <- -1.7706893 - 
            0.017088875 * AgeYr + 
            1.082246 * Pathsize - 
            0.1273547 * max(Pathsize - 0.4, 0)**3 + 
            0.20572683 * max(Pathsize - 1.2, 0)**3 - 
            0.078372126 * max(Pathsize - 2.5, 0)**3 - 
            1.3461993 * (SpecType == "Yes") - 
            0.51855285 * (TLOC == "UIQ") + 
            1.0963894 * (LVInv == "Yes") + 
            0.68125062 * (MultFoca == "Yes") + 
            0.43237318 * (Nuclob == "2") + 
            0.37142705 * (Nuclob == "3") + 
            0.53752449 * (Nuclob == "Lobular")
    } else{
        lp <- -1.9225802 - 
            0.020094234 * AgeYr + 
            0.96206237 * Pathsize - 
            0.097371798 * max(Pathsize - 0.4, 0)**3 + 
            0.15729291 * max(Pathsize - 1.2, 0)**3 - 
            0.059921107 * max(Pathsize - 2.5, 0)**3 - 
            1.1041418 * (SpecType == "Yes") - 
            0.57111338 * (TLOC == "UIQ") + 
            1.0678237 * (LVInv == "Yes") + 
            0.67785136 * (MultFoca == "Yes") + 
            0.4218666 * (Nuclob == "2") + 
            0.53501732 * (Nuclob == "3") + 
            0.61645327 * (Nuclob == "Lobular") + 
            0.34489695 * (ERTest == "Positive") + 
            0.24891617 * (PRTest == "Positive")                            
    }
    100/(1+exp(-lp))
})

library(shiny)
shinyServer(function(input, output){
    data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$AgeYr))& as.numeric(input$AgeYr)>=20& as.numeric(input$AgeYr)<=91, 'Please input a valid AgeYr'))
        AgeYr= as.numeric(input$AgeYr)
        validate(need(!is.na(as.numeric(input$Pathsize))& as.numeric(input$Pathsize)>=0.1& as.numeric(input$Pathsize)<=11, 'Please input a valid Pathsize'))
        Pathsize= as.numeric(input$Pathsize)
        TLOC = factor(input$TLOC, levels = c('UIQ', 'Other Quadrant(s)'))
        SpecType = factor(input$SpecType, levels = c('No', 'Yes'))
        Nuclob = factor(input$Nuclob, levels = c('1', '2', '3', 'Lobular'))
        LVInv = factor(input$LVInv, levels = c('No', 'Yes'))
        MultFoca = factor(input$MultFoca, levels = c('No', 'Yes'))
        ERTest = factor(input$ERTest, levels = c('Negative', 'Positive', 'Unknown'))
        PRTest = factor(input$PRTest, levels = c('Negative', 'Positive', 'Unknown'))
        data <- data.frame(AgeYr = AgeYr,
                           Pathsize = Pathsize,
                           TLOC = TLOC,
                           SpecType = SpecType,
                           Nuclob = Nuclob,
                           LVInv = LVInv,
                           MultFoca = MultFoca,
                           ERTest = ERTest,
                           PRTest = PRTest)
        data})
    output$result <- renderDataTable({
        data = data()
        prob = eval(formula, data)
        res = data.frame(Result = c("Risk Percentage of Sentinel Lymph Node Metastases"), Probability = c(ifelse(round(prob, 2) < 1, "<1", ifelse(round(prob, 2) > 99, ">99", round(prob, 2)))))
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
