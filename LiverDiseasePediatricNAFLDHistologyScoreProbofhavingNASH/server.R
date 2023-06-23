predict.nafld <- expression({
    lp <- -8.4227+2.5006*Steatosis+3.5112*Ballooning+3.4263*Inflammation+0.8651*PortInfl
    100/(1+exp(-lp))
})
        library(shiny)
        shinyServer(function(input, output){
            data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$Steatosis))& as.numeric(input$Steatosis)>=0& as.numeric(input$Steatosis)<=3, 'Please input a valid Steatosis'))
Steatosis= as.numeric(input$Steatosis)
validate(need(!is.na(as.numeric(input$Ballooning))& as.numeric(input$Ballooning)>=0& as.numeric(input$Ballooning)<=2, 'Please input a valid Ballooning'))
Ballooning= as.numeric(input$Ballooning)
validate(need(!is.na(as.numeric(input$Inflammation))& as.numeric(input$Inflammation)>=0& as.numeric(input$Inflammation)<=3, 'Please input a valid Inflammation'))
Inflammation= as.numeric(input$Inflammation)
validate(need(!is.na(as.numeric(input$PortInfl))& as.numeric(input$PortInfl)>=0& as.numeric(input$PortInfl)<=2, 'Please input a valid PortInfl'))
PortInfl= as.numeric(input$PortInfl)
data <- data.frame(Steatosis = Steatosis,
Ballooning = Ballooning,
Inflammation = Inflammation,
PortInfl = PortInfl)
data})
output$result <- renderDataTable({data = data()
nafld <- paste(ifelse(round(eval(predict.nafld, data), 0) < 1, "<1", ifelse(round(eval(predict.nafld, data), 0) > 99, ">99", round(eval(predict.nafld, data), 0))), "%")
res = data.frame(Result = c("Pediatric NAFLD histological score"),
                 Probability = c(nafld))

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
        