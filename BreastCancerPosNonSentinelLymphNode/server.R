formula <- expression({
    if (frozen == "No"){
        lp = -1.9172939 + 0.12956905 * (NucGrade == "II") + 
            0.44787713 * (NucGrade == "III") + 
            0.31607567 * (NucGrade == "Lobular") + 
            0.5339103 * (LVI == "Yes") + 
            0.46502525 * (Multifocal == "Yes") + 
            0.32842313 * (ERTest == "Positive") - 
            0.51384939 * sqrt(NumNegSLN) + 
            0.45134016 * NumSLNPos + 
            0.2795463 * Pathsize - 
            1.643732 * (MethDetect == "IHC") - 
            1.4013584 * (MethDetect== "Serial HE")
    } else {
        lp = -1.6299934 + 
            0.016638798 * (NucGrade == "II") + 
            0.25185701 * (NucGrade == "III") + 
            0.16006933 * (NucGrade == "Lobular") +
            0.55069459 * (LVI == "Yes") + 
            0.38980159 * (Multifocal == "Yes") + 
            0.42761534 * (ERTest == "Positive") - 
            0.53764351 * sqrt(NumNegSLN) + 
            0.40448376 * NumSLNPos + 
            0.28089088 * Pathsize -
            2.0534416 * (MethDetect == "IHC") - 
            1.1318931 * (MethDetect == "Routine") - 
            1.4713101 * (MethDetect == "Serial HE")
    }
    100 / (1 + exp(-lp))
})
library(shiny)
shinyServer(function(input, output, session){
    data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$NumNegSLN))& as.numeric(input$NumNegSLN)>=0& as.numeric(input$NumNegSLN)<=14, 'Please input a valid NumNegSLN'))
        NumNegSLN= as.numeric(input$NumNegSLN)
        validate(need(!is.na(as.numeric(input$NumSLNPos))& as.numeric(input$NumSLNPos)>=1& as.numeric(input$NumSLNPos)<=7, 'Please input a valid NumSLNPos'))
        NumSLNPos= as.numeric(input$NumSLNPos)
        MethDetect = factor(input$MethDetect, levels = c('IHC', 'Serial HE', 'Routine', 'Frozen'))
        validate(need(!is.na(as.numeric(input$Pathsize))& as.numeric(input$Pathsize)>=0.1& as.numeric(input$Pathsize)<=9, 'Please input a valid Pathsize'))
        Pathsize= as.numeric(input$Pathsize)
        frozen = factor(input$frozen, levels = c("No", "Yes"))
        NucGrade = factor(input$NucGrade, levels = c('I', 'II', 'III', 'Lobular'))
        LVI = factor(input$LVI, levels = c('No', 'Yes'))
        Multifocal = factor(input$Multifocal, levels = c('No', 'Yes'))
        ERTest = factor(input$ERTest, levels = c('Negative', 'Positive'))
        data <- data.frame(
            frozen = frozen,
            NumNegSLN = NumNegSLN,
            NumSLNPos = NumSLNPos,
            MethDetect = MethDetect,
            Pathsize = Pathsize,
            NucGrade = NucGrade,
            LVI = LVI,
            Multifocal = Multifocal,
            ERTest = ERTest)
        data})
    
    observe({
        if (input$frozen == "Yes") {newchoices = c('IHC', 'Serial HE', 'Routine', 'Frozen')}
        else {newchoices = c('IHC', 'Serial HE', 'Routine')}
        updateSelectizeInput(session, "MethDetect", choices = newchoices, selected = "IHC")
    })
    
    output$result <- renderDataTable({data = data()
    prob = paste(ifelse(round(eval(formula, data)) < 1, "<1", ifelse(round(eval(formula, data)) > 99, ">99", round(eval(formula, data)))), "%")
    res = data.frame(Result = c("Risk Percentage of Additional non-SLN Metastases"),
                     Probility = c(prob))
    
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
