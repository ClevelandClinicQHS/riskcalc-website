predict.clinic <- expression({
    lp <- -2.1288904 + 1.43616 * (TwoTeamSling == "Yes") + 0.93789648 * 
      (AnteriorRepair == "Yes") - 0.98813894 * (Sacro == "Yes") + 
      0.46144741 * (VaginalHysterectomy == "Yes") + 0.94950715 * 
      (DM == "Yes") + 0.24679968 * OtherComorbidities
    res = 1/(1+exp(-lp)) * 100
    paste(ifelse(res<0.1, "<0.1", ifelse(res > 99.9, ">99.9", round(res,1))), "%", sep="")
})

library(shiny)
shinyServer(function(input, output){
    data <- eventReactive(input$goButton, {

        data <- data.frame(TwoTeamSling = input$TwoTeamSling,
                           AnteriorRepair = input$AnteriorRepair,
                           Sacro = input$Sacro,
                           VaginalHysterectomy = input$VaginalHysterectomy,
                           DM = input$DM,
                           OtherComorbidities = as.numeric(as.character(input$OtherComorbidities)))
        data})
    
    output$result <- DT::renderDataTable({
      data = data()
      pred = eval(predict.clinic, data)
    res = data.frame(Result = c("Probability of post-operative urinary retention"),
                     Probability = c(pred))
    
    res}, options = list(
            pageLength = 10,
            lengthMenu = 0,
            
            searching = 0,
            info = 0,
            processing = 0,
            paging = 0,
        initComplete = I(
            "function(settings, json) {
                    $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
            }")))
})
