predict.gleason <- expression({
    lp <- 3.221123+
        0.031917083*AgeYr + 
        0.000010592461*max(AgeYr - 51.459178,0)**3 - 
        0.000021670958*max(AgeYr - 60.052055,0)**3 + 
        0.000011078497*max(AgeYr - 68.267945,0)**3 + 
        0.056278337*(Race=="Other") - 
        0.069232971*(Race=="Caucasian") + 
        0.28423768*(AbDRE=="Yes") - 
        0.011194514*TV + 
        0.25980174*(ClinStage=="T2") - 
        4.3474858*(ClinStage=="T3") -
        0.16290121* NumBiopsies+ 
        0.18235114*PSA - 
        0.0039800264*max(PSA - 3.556,0)**3 + 
        0.0055858641*max(PSA - 5.6,0)**3 - 
        0.0016058377*max(PSA - 10.666,0)**3-
        0.0046974162*Cores + 
        0.039625635*PosCores + 
        0.0046249761*MaxPerc - 
        1.7539852*G2 + 
        0.34593921*(PerInv=="Yes") - 
        0.47848052*(Inflam=="Yes") - 
        0.085422312*(PINHist=="Yes") + 
        0.20135521*(AtypiaHist=="Yes")
    100/(1+exp(-lp))
})
library(shiny)
shinyServer(function(input, output){
    data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$AgeYr))& as.numeric(input$AgeYr)>=0, 'Please input a valid AgeYr'))
        AgeYr= as.numeric(input$AgeYr)
        Race = factor(input$Race, levels = c('Caucasian', 'African American', 'Other'))
        AbDRE = factor(input$AbDRE, levels = c('No', 'Yes'))
        validate(need(!is.na(as.numeric(input$TV))& as.numeric(input$TV)>=0, 'Please input a valid TV'))
        TV= as.numeric(input$TV)
        ClinStage = factor(input$ClinStage, levels = c('T1C', 'T2', 'T3'))
        validate(need(!is.na(as.numeric(input$NumBiopsies))& as.numeric(input$NumBiopsies)>=0, 'Please input a valid NumBiopsies'))
        NumBiopsies= as.numeric(input$NumBiopsies)
        validate(need(!is.na(as.numeric(input$PSA))& as.numeric(input$PSA)>=0, 'Please input a valid PSA'))
        PSA= as.numeric(input$PSA)
        validate(need(!is.na(as.numeric(input$Cores))& as.numeric(input$Cores)>=0, 'Please input a valid Cores'))
        Cores= as.numeric(input$Cores)
        validate(need(!is.na(as.numeric(input$PosCores))& as.numeric(input$PosCores)>=0, 'Please input a valid PosCores'))
        PosCores= as.numeric(input$PosCores)
        validate(need(!is.na(as.numeric(input$MaxPerc))& as.numeric(input$MaxPerc)>=0& as.numeric(input$MaxPerc)<=100, 'Please input a valid MaxPerc'))
        MaxPerc= as.numeric(input$MaxPerc)
        G2 = as.numeric(as.character(input$G2))
        PerInv = factor(input$PerInv, levels = c('No', 'Yes'))
        Inflam = factor(input$Inflam, levels = c('No', 'Yes'))
        PINHist = factor(input$PINHist, levels = c('No', 'Yes'))
        AtypiaHist = factor(input$AtypiaHist, levels = c('No', 'Yes'))
        data <- data.frame(AgeYr = AgeYr,
                           Race = Race,
                           AbDRE = AbDRE,
                           TV = TV,
                           ClinStage = ClinStage,
                           NumBiopsies = NumBiopsies,
                           PSA = PSA,
                           Cores = Cores,
                           PosCores = PosCores,
                           MaxPerc = MaxPerc,
                           G2 = G2,
                           PerInv = PerInv,
                           Inflam = Inflam,
                           PINHist = PINHist,
                           AtypiaHist = AtypiaHist)
        data})
    output$result <- renderDataTable({data = data()
    gleason <- paste(ifelse(round(eval(predict.gleason, data), 0) < 1, "<1", ifelse(round(eval(predict.gleason, data), 0) > 99, ">99", round(eval(predict.gleason, data), 0))), "%")
    res = data.frame(Result = c("Likelihood of Increased Pathologic Gleason Score"), Probability = c(gleason))
    
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
