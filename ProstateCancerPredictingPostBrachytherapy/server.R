predict.9yr.brachytherapy = expression({
    lp = 5.0278124 +
        0.12695674 * (stagecha == "T2a") +
        0.19156993 * (stagecha == "T2b") - 
        0.29752953 * (stagecha == "T2c") +
        0.31105987 * (stagecha == "T3") -
        0.19753883 * ((g1 + g2) == 6) +
        0.60291254 * ((g1 + g2) == 7) +
        1.0650089 * ((g1 + g2) == 8) +
        1.3952074 * ((g1 + g2) == 9) +
        1.3952074 * ((g1 + g2) == 10) -
        0.93804594 * (isotopecha == "Pd-103") -
        0.75038925 * (adjrt == "Yes") - 
        0.034888112 * d90 +
        0.0000028527619 * max(d90 - 105.77, 0)**3 -
        0.0000048043569 * max(d90 - 142.9444, 0)**3 +
        0.000001951595 * max(d90 - 197.28443, 0)**3 +
        0.10219127 * psa -
        0.0009270401 * max(psa - 4, 0)**3 +
        0.0012435904 * max(psa - 6.8000002, 0)**3 -
        0.0003165503 * max(psa - 15, 0)**3 -
        0.088670974 * (16) -
        0.00053383112 * max(16 - 3, 0)**3 +
        0.00093420445 * max(16 - 6, 0)**3 -
        0.00040037334 * max(16 - 10, 0)**3
    0.7817072 ** exp(lp) * 100
})

predict.7yr.brachytherapy <- expression({
    lp = 5.0278124 + 
        0.12695674 * (stagecha == "T2a") +
        0.19156993 * (stagecha == "T2b") -
        0.29752953 * (stagecha == "T2c") +
        0.31105987 * (stagecha == "T3") -
        0.19753883 * ((g1 + g2) == 6) +
        0.60291254 * ((g1 + g2) == 7) +
        1.0650089 * ((g1 + g2) == 8) + 
        1.3952074 * ((g1 + g2) == 9) +
        1.3952074 * ((g1 + g2) == 10) -
        0.93804594 * (isotopecha == "Pd-103") -
        0.75038925 * (adjrt == "Yes") -
        0.034888112 * d90 +
        0.0000028527619 * max(d90 - 105.77, 0)**3 -
        0.0000048043569 * max(d90 - 142.9444, 0)**3 +
        0.000001951595 * max(d90 - 197.28443, 0)**3 +
        0.10219127 * psa -
        0.0009270401 * max(psa - 4, 0)**3 +
        0.0012435904 * max(psa - 6.8000002, 0)**3 -
        0.0003165503 * max(psa - 15, 0)**3 -
        0.088670974 * (16) -
        0.00053383112 * max(16 - 3, 0)**3 +
        0.00093420445 * max(16 - 6, 0)**3 -
        0.00040037334 * max(16 - 10, 0)**3
    0.858472347259522 ** exp(lp) * 100
})

        library(shiny)
        shinyServer(function(input, output){
            data <- eventReactive(input$goButton, {
        adjrt = factor(input$adjrt, levels = c('No', 'Yes'))
validate(need(!is.na(as.numeric(input$d90))& as.numeric(input$d90)>0& as.numeric(input$d90)<280, 'Please input a valid d90'))
d90= as.numeric(input$d90)
isotopecha = factor(input$isotopecha, levels = c('N/A', 'I-125', 'Pd-103'))
stagecha = factor(input$stagecha, levels = c('T1c', 'T2a', 'T2b', 'T2c', 'T3'))
validate(need(!is.na(as.numeric(input$psa))& as.numeric(input$psa)>0& as.numeric(input$psa)<=100, 'Please input a valid psa'))
psa= as.numeric(input$psa)
g1 = as.numeric(as.character(input$g1))
g2 = as.numeric(as.character(input$g2))


data <- data.frame(adjrt = adjrt,
d90 = d90,
isotopecha = isotopecha,
stagecha = stagecha,
psa = psa,
g1 = g1,
g2 = g2)
data})
output$result <- renderDataTable({data = data()
prob.7yr.bra <- paste(ifelse(round(eval(predict.7yr.brachytherapy, data), 0) < 1, "<1", ifelse(round(eval(predict.7yr.brachytherapy, data), 0) > 99, ">99", round(eval(predict.7yr.brachytherapy, data), 0))), "%")
prob.9yr.bra <- paste(ifelse(round(eval(predict.9yr.brachytherapy, data), 0) < 1, "<1", ifelse(round(eval(predict.9yr.brachytherapy, data), 0) > 99, ">99", round(eval(predict.9yr.brachytherapy, data), 0))), "%")
res = data.frame(Result = c("7-year Probability of freedom From Recurrence - Brachytherapy",
    "9-year Probability of freedom From Recurrence - Brachytherapy"),
                 Probability = c(prob.7yr.bra, prob.9yr.bra))

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
        