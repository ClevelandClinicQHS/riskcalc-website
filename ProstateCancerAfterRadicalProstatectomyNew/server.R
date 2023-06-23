predict.bfp <- expression({
    0.61629922 * (NADT == "RT alone") + 
      0.68142769 * (Gleason == "7") + 
      0.889343 * (Gleason == "8") + 
      1.1329454 * (Gleason == "9-10") + 
      0.27985075 * (ECE == "Yes") - 
      0.34214367 * (SM == "Positive") + 
      0.29990969 * (SVI == "Yes") + 
      0.63145578 * min(PrePSA, 2) - 
      0.21748355 * (RTDose == ">= 6600")
})
predict.cim <- expression({
    0.34393019 * (NADT == "RT alone") + 
      0.8514755 * (Gleason == "7") + 
      1.1542012 * (Gleason == "8") + 
      1.6840493 * (Gleason == "9-10") + 
      0.1761536 * (ECE == "Yes") - 
      0.3696072 * (SM == "Positive") + 
      0.62810136 * (SVI == "Yes") + 
      0.8036252 * min(PrePSA, 2) - 
      0.031426658 * (RTDose == ">= 6600")
})
library(shiny)
shinyServer(function(input, output){
    data <- eventReactive(input$goButton, {
        NADT = factor(input$NADT, levels = c('RT alone', 'NC ADT'))
        Gleason = factor(input$Gleason, levels = c('6 or lower', '7', '8', '9-10'))
        ECE = factor(input$ECE, levels = c('No', 'Yes'))
        SM = factor(input$SM, levels = c('Negative', 'Positive'))
        SVI = factor(input$SVI, levels = c('No', 'Yes'))
        validate(need(!is.na(as.numeric(input$PrePSA))& as.numeric(input$PrePSA)>=0& as.numeric(input$PrePSA)<=2, 'Please input a valid PrePSA'))
        PrePSA= as.numeric(input$PrePSA)
        RTDose= factor(input$RTDose, levels = c('>= 6600', '< 6600'))
        data <- data.frame(PrePSA = PrePSA,
                           Gleason = Gleason,
                           SVI = SVI,
                           ECE = ECE,
                           SM = SM,
                           NADT = NADT,
                           RTDose = RTDose)
        data})
    
    output$result <- renderDataTable({data = data()
    prob.bfp = eval(predict.bfp, data)
    prob.5yr.free <- paste(ifelse(round(100 * 0.8836072** exp(prob.bfp), 0) < 1, "<1", ifelse(round(100 * 0.8836072** exp(prob.bfp), 0) > 99, ">99", round(100 * 0.8836072** exp(prob.bfp), 0))), "%")
    prob.10yr.free <- paste(ifelse(round(100 * 0.8324219**exp(prob.bfp), 0) < 1, "<1", ifelse(round(100 * 0.8324219**exp(prob.bfp), 0) > 99, ">99", round(100 * 0.8324219**exp(prob.bfp), 0))), "%")
    prob.cim = eval(predict.cim, data)
    prob.5yr.cum <- paste(ifelse(round(100 - 100 * 0.985203**exp(prob.cim), 0) < 1, "<1", ifelse(round(100 - 100 * 0.985203**exp(prob.cim), 0) > 99, ">99", round(100 - 100 * 0.985203**exp(prob.cim), 0))), "%")
    prob.10yr.cum <- paste(ifelse(round(100 - 100 * 0.9690733**exp(prob.cim), 0) < 1, "<1", ifelse(round(100 - 100 * 0.9690733**exp(prob.cim), 0) > 99, ">99", round(100 - 100 * 0.9690733**exp(prob.cim), 0))), "%")
    res = data.frame(Result = c("5-year free from biochemical failure probability", 
        "10-year free from biochemical failure probability", 
        "5-year cumulative incidence of metastasis", 
        "10-year cumulative incidence of metastasis"),
                     Probability = c(prob.5yr.free, prob.10yr.free, prob.5yr.cum, prob.10yr.cum))
    
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
