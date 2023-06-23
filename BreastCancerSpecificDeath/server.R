predict.mortality <- expression({
    lp = -2.5676344 - 0.0068672746 * AGE + 0.29445761 * (Multifocality=='Yes') + 
        0.29945423 * Size + 2.5805221 * (GRADE == "2") + 2.6121616 * 
        (GRADE == "3") + 3.1290942 * (GRADE == "Lobular") + 
        0.57521579 * (LVI == "Yes") + 1.1832101 * (Stain == "Pos IHC and H&E") - 0.10160287 * 
        (Stain == 'Negative IHC and H&E')
    1-0.8525088**exp(lp)
})

library(shiny)
shinyServer(function(input, output){
    data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$AGE))& as.numeric(input$AGE)>=25&as.numeric(input$AGE)<=80, 'Please input a valid Age'))
        AGE = as.numeric(input$AGE)
        Multifocality = factor(input$Multifocality, levels = c('No', 'Yes'))
        validate(need(!is.na(as.numeric(input$Size))& as.numeric(input$Size)>=0& as.numeric(input$Size)<=10, 'Please input a valid Creatinine'))
        Size = as.numeric(input$Size)
        GRADE = factor(input$GRADE, levels = c('1', '2', '3', 'Lobular'))
        LVI = factor(input$LVI, levels = c('No', 'Yes'))
        Stain = factor(input$Stain, levels = c('Negative IHC and H&E', 'Pos IHC only', "Pos IHC and H&E"))
        data <- data.frame(AGE = AGE,
                           Multifocality = Multifocality,
                           Size = Size,
                           GRADE = GRADE,
                           LVI= LVI,
                           Stain = Stain)
        data})
    output$result <- renderDataTable({data = data()
    prob <- paste(ifelse(round(eval(predict.mortality, data)*100, 0) < 1, "<1", ifelse(round(eval(predict.mortality, data)*100, 0) > 99, ">99", round(eval(predict.mortality, data)*100, 0))), "%")
    res = data.frame(Result = c("15-Year probability of breast cancer specific death"),
                     Probability = c(prob))
    
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
