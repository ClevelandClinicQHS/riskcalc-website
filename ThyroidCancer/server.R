predict.risk <- expression({
    if(FNA=="Yes")  {
        lp <- -4.1344622 + 
            1.6756318 * TSHLevel - 
            0.25506442 * max(TSHLevel - 0.727,0)**3 + 
            0.36360543 * max(TSHLevel - 1.51, 0)**3 - 
            0.108541 *max(TSHLevel - 3.35, 0)**3 + 
            1.1633905 * (Shape == "Taller Than Wide") -
            0.25319891 * (Shape == "Variable") - 
            1.3178877 * (EchoTexture =="Isoechoic") - 
            0.24787542 * (EchoTexture == "Hypochoic") -
            0.45386779 * (Vascularity == "HYPOVASCULAR") - 
            0.89282795 * (Vascularity == "MIXED") + 
            2.8809623 * (Vascularity =="NONE") + 
            0.064782862 * (Vascularity == "PERINODULAR") + 
            3.5783113 * (Grooves == "Yes") + 
            1.9912877 * (Pseudoinclusions == "Yes") - 
            2.2016873 * (Cellularity == "HYPOCELLULAR") -
            0.69943441 * (Cellularity == "MODERATELY CELLULAR") + 
            1.3299117 * (Colloid == "Scant")
    } else {
        lp <- 0.6269187 - 
            0.024645684 * AgeYr + 
            0.000011437381 * max(AgeYr -35, 0)**3 - 
            0.000024078698 * max(AgeYr - 56, 0)**3 + 
            0.000012641316 * max(AgeYr - 75, 0)**3 + 
            0.7421743 * TSHLevel - 
            0.071237097 * max(TSHLevel - 0.512, 0)**3 + 
            0.12106041 * max(TSHLevel - 1.68, 0)**3 - 
            0.049823311 * max(TSHLevel - 3.35, 0)**3 + 
            2.1197096 * (Shape == "Taller Than Wide") + 
            0.33280487 *(Shape == "Variable") - 
            0.10210509 * (EchoTexture =="Isoechoic") + 
            0.96429735 * (EchoTexture == "Hypochoic") -
            0.39925198 * (Calcification == "Coarse") - 
            1.149165 *(Calcification == "None") - 
            0.21590623 * (Margin == "Well-defined") +       
            0.70562255 * (Vascularity == "HYPOVASCULAR") + 
            0.45790603 *(Vascularity == "MIXED") + 
            1.1472353 * (Vascularity == "NONE") + 
            0.38039146 * (Vascularity == "PERINODULAR") - 
            0.51141857 * TumorSize + 
            0.029171542 * max(TumorSize - 0.9, 0)**3 - 
            0.043757313 * max(TumorSize - 1.8, 0)**3 + 
            0.014585771 * max(TumorSize - 3.6, 0)**3
    }
    100/(1+exp(-lp))
})
library(shiny)
shinyServer(function(input, output){
    observe({
        if (input$FNA == "No") {
            shinyjs::show("fnaN")
            shinyjs::hide("fnaY")
        } else{
            shinyjs::show("fnaY")
            shinyjs::hide("fnaN")
        }
    })
    data <- eventReactive(input$goButton, {
        FNA = factor(input$FNA, levels = c('Yes', 'No'))
        validate(need(!is.na(as.numeric(input$TSHLevel))& as.numeric(input$TSHLevel)>=0, 'Please input a valid TSHLevel'))
        TSHLevel= as.numeric(input$TSHLevel)
        Shape = factor(input$Shape, levels = c('Taller Than Wide', 'Variable', 'Oval'))
        EchoTexture = factor(input$EchoTexture, levels = c('Isoechoic', 'Hypochoic', 'Mixed Cystic/Solid'))
        Vascularity = factor(input$Vascularity, levels = c('MIXED', 'HYPOVASCULAR', 'NONE', 'PERINODULAR', 'HYPERVASCULAR'))
        if (FNA == "No") {
            validate(need(!is.na(as.numeric(input$AgeYr))& as.numeric(input$AgeYr)>=10& as.numeric(input$AgeYr)<=90, 'Please input a valid AgeYr'))
            AgeYr= as.numeric(input$AgeYr)
            Calcification = factor(input$Calcification, levels = c('Coarse', 'None', 'Microscopic'))
            Margin = factor(input$Margin, levels = c('Not well-defined', 'Well-defined'))
            validate(need(!is.na(as.numeric(input$TumorSize))& as.numeric(input$TumorSize)>=0, 'Please input a valid TumorSize'))
            TumorSize= as.numeric(input$TumorSize)
            data = data.frame(FNA = FNA,
                              TSHLevel = TSHLevel,
                              Shape = Shape,
                              EchoTexture = EchoTexture,
                              Vascularity = Vascularity,
                              AgeYr = AgeYr,
                              Calcification = Calcification,
                              Margin = Margin,
                              TumorSize = TumorSize)
        } else {
            Grooves = factor(input$Grooves, levels = c('No', 'Yes'))
            Pseudoinclusions = factor(input$Pseudoinclusions, levels = c('No', 'Yes'))
            Cellularity = factor(input$Cellularity, levels = c('HYPOCELLULAR', 'MODERATELY CELLULAR', 'HYPERCELLULAR'))
            Colloid = factor(input$Colloid, levels = c('Abundant', 'Scant'))
            data = data.frame(FNA = FNA,
                              TSHLevel = TSHLevel,
                              Shape = Shape,
                              EchoTexture = EchoTexture,
                              Vascularity = Vascularity,
                              Grooves = Grooves,
                              Pseudoinclusions = Pseudoinclusions,
                              Cellularity = Cellularity,
                              Colloid = Colloid
            )
        }
        data})
    output$result <- renderDataTable({data = data()
    prob.risk = paste(ifelse(round(eval(predict.risk, data), 0) < 1, "<1", ifelse(round(eval(predict.risk, data), 0) > 99, ">99", round(eval(predict.risk, data), 0))), "%")
    res = data.frame(Result = c("Probability of Thyroid Cancer"),
                     Probability = c(prob.risk))
    
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
