predict.5yr.formula <- expression({lp <- -2.3678975 + 
    0.227464 * (Gender == "Male") - 
    0.011606041 * AgeYr + 
    3.4469803e-05 * pmax(AgeYr - 48, 0)**3 - 
    8.4848746e-05 * pmax(AgeYr - 67, 0)**3 + 
    5.0378943e-05 * pmax(AgeYr - 80, 0)**3 + 
    0.23855249 * (PrimarySite == "Body or Middle One Third") + 
    0.7131089 * (PrimarySite == "Gastroesophageal Junction") + 
    0.14158861 * (PrimarySite == "Proximal or Upper One Third") - 
    0.19097534 * (Lauren == "Intestinal") - 
    0.075717935 * (Lauren == "Mixed") + 
    0.0097446167 * Size + 
    0.34360148 * NumPosNodes - 
    0.0096735309 * pmax(NumPosNodes, 0)**3 + 
    0.010640884 * pmax(NumPosNodes - 1, 0)**3 - 
    0.00096735309 * pmax(NumPosNodes - 11, 0)**3 - 
    0.047258944 * NumNegNodes + 
    4.5172072e-05 * pmax(NumNegNodes - 5, 0)**3 - 
    7.2275315e-05 * pmax(NumNegNodes - 17, 0)**3 + 
    2.7103243e-05 * pmax(NumNegNodes - 37, 0)**3 + 
    0.6913717 * Depth - 
    0.024435477 * pmax(Depth - 2, 0)**3 + 
    0.048870953 * pmax(Depth - 4, 0)**3 - 
    0.024435477 * pmax(Depth - 6, 0)**3;
100 * 0.579053^(exp(lp))})
predict.9yr.formula <- expression({lp <- -2.3678975 + 
    0.227464 * (Gender == "Male") - 
    0.011606041 * AgeYr + 
    3.4469803e-05 * pmax(AgeYr - 48, 0)**3 - 
    8.4848746e-05 * pmax(AgeYr - 67, 0)**3 + 
    5.0378943e-05 * pmax(AgeYr - 80, 0)**3 + 
    0.23855249 * (PrimarySite == "Body or Middle One Third") + 
    0.7131089 * (PrimarySite == "Gastroesophageal Junction") + 
    0.14158861 * (PrimarySite == "Proximal or Upper One Third") - 
    0.19097534 * (Lauren == "Intestinal") - 
    0.075717935 * (Lauren == "Mixed") + 
    0.0097446167 * Size + 
    0.34360148 * NumPosNodes - 
    0.0096735309 * pmax(NumPosNodes, 0)**3 + 
    0.010640884 * pmax(NumPosNodes - 1, 0)**3 - 
    0.00096735309 * pmax(NumPosNodes - 11, 0)**3 - 
    0.047258944 * NumNegNodes + 
    4.5172072e-05 * pmax(NumNegNodes - 5, 0)**3 - 
    7.2275315e-05 * pmax(NumNegNodes - 17, 0)**3 + 
    2.7103243e-05 * pmax(NumNegNodes - 37, 0)**3 + 
    0.6913717 * Depth - 
    0.024435477 * pmax(Depth - 2, 0)**3 + 
    0.048870953 * pmax(Depth - 4, 0)**3 - 
    0.024435477 * pmax(Depth - 6, 0)**3;
100 * 0.5089101^(exp(lp))})

library(shiny)
shinyServer(function(input, output){
    data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$AgeYr))& as.numeric(input$AgeYr)>=25& as.numeric(input$AgeYr)<=96, 'Please input a valid AgeYr'))
        AgeYr= as.numeric(input$AgeYr)
        Depth = factor(input$Depth, levels = c('Mucosa', 'Submucosa', 'Propia Muscularis', 'Subserosa', 'Suspected serosal invasion', 'Definite serosal invasion', 'Adjacent organ involvement'))
        Depth = as.numeric(Depth)
        Gender = factor(input$Gender, levels = c('Male', 'Female'))
        Lauren = factor(input$Lauren, levels = c('Intestinal', 'Mixed', 'Diffuse'))
        PrimarySite = factor(input$PrimarySite, levels = c('Body or Middle One Third', 'Gastroesophageal Junction', 'Proximal or Upper One Third', 'Antrum or Piloric'))
        validate(need(!is.na(as.numeric(input$NumNegNodes))& as.numeric(input$NumNegNodes)>=0& as.numeric(input$NumNegNodes)<=146, 'Please input a valid NumNegNodes'))
        NumNegNodes= as.numeric(input$NumNegNodes)
        validate(need(!is.na(as.numeric(input$NumPosNodes))& as.numeric(input$NumPosNodes)>=0& as.numeric(input$NumPosNodes)<=23, 'Please input a valid NumPosNodes'))
        NumPosNodes= as.numeric(input$NumPosNodes)
        validate(need(!is.na(as.numeric(input$Size))& as.numeric(input$Size)>=0.1& as.numeric(input$Size)<=21, 'Please input a valid Size'))
        Size= as.numeric(input$Size)
        data <- data.frame(AgeYr = AgeYr,
                           Depth = Depth,
                           Gender = Gender,
                           Lauren = Lauren,
                           PrimarySite = PrimarySite,
                           NumNegNodes = NumNegNodes,
                           NumPosNodes = NumPosNodes,
                           Size = Size)
        data})
    output$result <- renderDataTable({data = data()
    prob.5yr = eval(predict.5yr.formula, data)
    prob.9yr = eval(predict.9yr.formula, data)
    res = data.frame(Result = c("5-Year Disease-Specific Survival Percentage","9-Year Disease-Specific Survival Percentage"),
                     Probability = c(paste(ifelse(round(prob.5yr, 0) < 1, "<1", ifelse(round(prob.5yr, 0) > 99, ">99", round(prob.5yr, 0))), "%"), paste(ifelse(round(prob.9yr, 0) < 1, "<1", ifelse(round(prob.9yr, 0) > 99, ">99", round(prob.9yr, 0))), "%")))
    
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
