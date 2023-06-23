predict.clinic <- expression({
    if (cNGroup == "Unknown"){
        "This outcome is NOT valid for patients without clinical node stage" }
    else {
        lp <- -0.67502896 + 
            0.53435016 * (TumorThickness == "> 5 mm") -
            0.40358476 * (GrowthPattern == "Vertical") + 
            0.27178222 * (Grade == "G2") + 
            0.67128568 * (Grade == "G3") +
            0.87341508 * (EmbGroup == "Present") + 
            0.52020417 * (CCI == "Present") + 
            0.25742673 * (CSI == "Present") + 
            0.080707106 * (UrethraInfiltr == "Present") - 
            0.45156525 * (cNGroup == "cN0")
        paste(ifelse(round(100 * 0.6285482 ** exp(lp), 0) < 1, "<1", ifelse(round(100 * 0.6285482 ** exp(lp), 0) > 99, ">99", round(100 * 0.6285482 ** exp(lp), 0))), "%")
    }
})
predict.pathological <- expression({
    if (pNGroup =="Unknown"){
        "This outcome is NOT valid for patients without pathological node stage" 
    } else {
        lp <- -0.8419186 + 
            0.64678231 * (TumorThickness == "> 5 mm") -         
            0.33288515 * (GrowthPattern == "Vertical") + 
            0.29044127 * (Grade == "G2") + 
            0.72318854 * (Grade == "G3") +         
            0.8842326 * (EmbGroup == "Present") + 
            0.51391439 * (CCI == "Present") + 
            0.39200427 * (CSI == "Present") + 
            0.1473861 * (UrethraInfiltr == "Present") - 
            1.896495 * (pNGroup ==         "pN0") + 
            0.14768735 * (pNGroup == "pNx")
        paste(ifelse(round(100 * 0.6792758 ** exp(lp), 0) < 1, "<1", ifelse(round(100 * 0.6792758 ** exp(lp), 0) > 99, ">99", round(100 * 0.6792758 ** exp(lp), 0))), "%")
    }
})
predict.lymph <- expression({
    if (cNGroup == "Unknown"){
        "This outcome is NOT valid for patients without clinical node stage" 
    } else {
        lp <- -1.3122196 + 
            0.25042191 * (TumorThickness == "> 5 mm") -         
            0.87376479 * (GrowthPattern == "Vertical") + 
            1.2195938 * (Grade == "G2") + 
            0.98284005 * (Grade == "G3") +         
            2.7395909 * (EmbGroup == "Present") + 
            0.56742958 * (CCI == "Present") + 
            0.83256568 * (CSI == "Present") + 
            0.43638067 * (UrethraInfiltr == "Present") - 
            1.8145322 * (cNGroup =="cN0")
        paste(round(100/(1+exp(-lp)), 0), "%")
    }
})
library(shiny)
shinyServer(function(input, output){
    data <- eventReactive(input$goButton, {
        EmbGroup = factor(input$EmbGroup, levels = c('Absent', 'Present'))
        GrowthPattern = factor(input$GrowthPattern, levels = c('Superficial', 'Vertical'))
        CCI = factor(input$CCI, levels = c('Absent', 'Present'))
        CSI = factor(input$CSI, levels = c('Absent', 'Present'))
        cNGroup = factor(input$cNGroup, levels = c('Unknown', 'cN0', 'cN+'))
        pNGroup = factor(input$pNGroup, levels = c('Unknown', 'pN0', 'pN+', 'pNx'))
        Grade = factor(input$Grade, levels = c('G1', 'G2', 'G3'))
        TumorThickness = factor(input$TumorThickness, levels = c('> 5 mm', '<= 5 mm'))
        UrethraInfiltr = factor(input$UrethraInfiltr, levels = c('Absent', 'Present'))
        data <- data.frame(EmbGroup = EmbGroup,
                           GrowthPattern = GrowthPattern,
                           CCI = CCI,
                           CSI = CSI,
                           cNGroup = cNGroup,
                           pNGroup = pNGroup,
                           Grade = Grade,
                           TumorThickness = TumorThickness,
                           UrethraInfiltr = UrethraInfiltr)
        data})
    output$result <- renderDataTable({data = data()
    clinic <- eval(predict.clinic, data)
    pathological <- eval(predict.pathological, data)
    lymph <- eval(predict.lymph, data)
    res = data.frame(Result = c("5-Year Cancer-Specific Survival Percentage (using clinical stage)[1]","5-Year Cancer-Specific Survival Percentage (using pathological stage)[1]","Percent Chance of Lymph Node Involvement (using clinical stage)[2]"),
                     Probability = c(clinic, pathological, lymph))
    
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
