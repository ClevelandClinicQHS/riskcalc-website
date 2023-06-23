predict.9yr.radical <- expression({
    if(is.na(experience)) {
        lp = 0.0001654477+ 
            (202.83959 + 0.11285247*psa - 
                 0.0007176516*max(psa - 3.82,0)**3 + 
                 0.00090022216*max(psa - 7,0)**3 - 
                 0.00018257057*max(psa - 19.5,0)**3 + 
                 0.59642794*(ece=="Yes") + 
                 0.59589714*(svi=="Yes") + 
                 0.60243109*(lni=="Positive") - 
                 0.10215648*yos + 
                 0.00079186048*max(yos - 1992,0)**3 - 
                 0.001583721*max(yos - 1997,0)**3 + 
                 0.00079186048*max(yos - 2002,0)**3 - 
                 0.70317261*((g1 + g2)<7) + 
                 0.74620056*((g1 + g2)>7) + 
                 0.64141743*(sm=="Positive"))
        }
    else {
        lp = 176.20178 + 0.11305183*psa - 
            0.00071917573*max(psa - 3.82,0)**3 + 
            0.00090213404*max(psa - 7,0)**3 - 
            0.00018295831*max(psa - 19.5,0)**3 + 
            0.60665663*(ece=="Yes") + 
            0.57593591*(svi=="Yes") + 
            0.61175895*(lni=="Positive") - 
            0.088692067*yos + 
            0.0007361173*max(yos - 1992,0)**3 - 
            0.0014722346*max(yos - 1997,0)**3 + 
            0.0007361173*max(yos - 2002,0)**3 - 
            0.0021259625*experience + 
            0.000000037180674*max(experience - 12,0)**3 - 
            0.000000056810061*max(experience - 94,0)**3 + 
            0.000000020239903*max(experience - 259,0)**3 - 
            0.00000000060708227*max(experience - 565,0)**3 - 
            0.0000000000034331356*max(experience - 1501.75,0)**3 - 
            0.70603936*((g1 + g2)<7) + 
            0.74134971*((g1 + g2)>7) + 
            0.60512098*(sm=='Positive')
    }
    0.8431596 ** exp(lp) * 100
})
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
predict.7yr.radical <- expression({
    lp = -3.3196459 +
        0.75250647 * log(psa) -
        0.064484062 * max(log(psa) - 0.40546511, 0)**3 +
        0.53855528 * max(log(psa) - 1.5475625, 0)**3 -
        1.1562808 * max(log(psa) - 1.9600948, 0)**3 +
        0.82313413 * max(log(psa) - 2.3643752, 0)**3 -
        0.14092453 * max(log(psa) - 3.4563167, 0)**3 -
        0.01980483 * (g1 + g2) +
        0.19708526 * max((g1 + g2) - 5, 0)**3 -
        0.5136459 * max((g1 + g2) - 6, 0)**3 +
        0.43603603 * max((g1 + g2) - 7, 0)**3 -
        0.11947539 * max((g1 + g2) - 8, 0)**3 +
        1.0466346 * (ecelev == "Inv.Capsule") +
        1.7564088 * (ecelev == "Focal") +
        1.9533814 * (ecelev == "Established") +
        1.1594884 * (sm == "Positive") +
        0.86096245 * (svi == "Yes") +
        0.93273528 * (lni == "Yes")
    0.8552918 ** exp(lp) * 100
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
predict.10yr.radical <- expression({
    lp <- 110.52302 -
        0.056105833 * (2003) +
        0.3931648 * (sm == "Positive") +
        0.8748934 * (ecelev == "Focal") +
        0.8748934 * (ecelev == "Established") +
        0.9425151 * (svi == "Yes") +
        0.43389123 * (lni == "Yes") +
        1.3792909 * (g1 > 3) +
        0.57039863 * (g2 > 3) -
        1.4998377 * (adjrt == "Yes") +
        0.39237805 * log(psa + 0.001) -
        0.032117287 * max(log(psa + 0.001) - 1.0650555, 0)**3 +
        0.059594821 * max(log(psa + 0.001) - 1.8407084, 0)**3 -
        0.027477534 * max(log(psa + 0.001) - 2.747335, 0)**3
    0.9076778 ** exp(lp) * 100
})
        library(shiny)
        shinyServer(function(input, output){
            data <- eventReactive(input$goButton, {
        adjrt = factor(input$adjrt, levels = c('No', 'Yes'))
validate(need(!is.na(as.numeric(input$d90))& as.numeric(input$d90)>0& as.numeric(input$d90)<280, 'Please input a valid d90'))
d90= as.numeric(input$d90)
isotopecha = factor(input$isotopecha, levels = c('N/A', 'I-125', 'Pd-103'))
ecelev = factor(input$ecelev, levels = c('None', 'Inv.Capsule', 'Focal', 'Established'))
stagecha = factor(input$stagecha, levels = c('T1c', 'T2a', 'T2b', 'T2c', 'T3'))
ece = factor(input$ece, levels = c('No', 'Yes'))
lni = factor(input$lni, levels = c('Negative', 'Positive'))
validate(need(!is.na(as.numeric(input$psa))& as.numeric(input$psa)>0& as.numeric(input$psa)<=100, 'Please input a valid psa'))
psa= as.numeric(input$psa)
g1 = as.numeric(as.character(input$g1))
g2 = as.numeric(as.character(input$g2))
svi = factor(input$svi, levels = c('No', 'Yes'))
experience= as.numeric(input$experience)
sm = factor(input$sm, levels = c('Negative', 'Positive'))
validate(need(!is.na(as.numeric(input$yos))& as.numeric(input$yos)>=1960& as.numeric(input$yos)<=2060, 'Please input a valid yos'))
yos= as.numeric(input$yos)
data <- data.frame(adjrt = adjrt,
d90 = d90,
isotopecha = isotopecha,
ecelev = ecelev,
stagecha = stagecha,
ece = ece,
lni = lni,
psa = psa,
g1 = g1,
g2 = g2,
svi = svi,
experience = experience,
sm = sm,
yos = yos)
data})
output$result <- renderDataTable({data = data()
prob.7yr.bra <- paste(round(eval(predict.7yr.brachytherapy, data), 2), "%")
prob.7yr.rad <- paste(round(eval(predict.7yr.radical, data), 2), "%")
prob.9yr.bra <- paste(round(eval(predict.9yr.brachytherapy, data), 2), "%")
prob.9yr.rad <- paste(round(eval(predict.9yr.radical, data), 2), "%")
prob.10yr <- paste(round(eval(predict.10yr.radical, data), 2), "%")
res = data.frame(Result = c("7-year Probability of freedom From Recurrence - Brachytherapy[3]",
    "7-year Probability of freedom From Recurrence - Radical Prostatectomy[1]",
    "9-year Probability of freedom From Recurrence - Brachytherapy[3]",
    "9-year Probability of freedom From Recurrence - Radical Prostatectomy[1,2]",
    "10-year Probability of freedom From Recurrence - Radical Prostatectomy[4]"),
                 Probability = c(prob.7yr.bra, prob.7yr.rad, prob.9yr.bra, prob.9yr.rad, prob.10yr))

                res}, options = list(
            iDisplayLength = 10,
            aLengthMenu = 0,
            aLengthChange = 0,
            bFilter = 0,
            bInfo = 0,
            bPaginate = 0,
                initComplete = I(
                    "function(settings, json) {
                    $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
            }")))
        })
        