predict.men <- expression({
    61.610 - 2.134 * METs + 13.049 * CRI + 3.442 * AHRR + 2.561 * BB + 2.482 * NDCA
})

predict.women <- expression({
  63.637 - 1.861 * METs + 4.858 * CRI + 3.633 * AHRR + 1.316 * BB + 2.226 * NDCA
})

library(shiny)
shinyServer(function(input, output) {
    data <- eventReactive(input$goButton, {
        METs = input$METs
        if (input$EstimateCRI == FALSE) {
          CRI = input$CRI
        } else {
          if (input$predict_formula == "206 - 0.88 * Age") {
            predict_hr = 206 - 0.88 * input$Age
          } else {
            predict_hr = 164 - 0.7 * input$Age
          }
          CRI = (input$peak.hr - input$rest.hr) / (input$Age - predict_hr - input$rest.hr)
        }
        AHRR = ifelse(input$AHRR == "Yes", 1, 0)
        BB = ifelse(input$BB == "Yes", 1, 0)
        NDCA = ifelse(input$NDCA == "Yes", 1, 0)
        data = data.frame(
          METs = METs,
          CRI = CRI,
          AHRR = AHRR,
          BB = BB,
          NDCA = NDCA
        )
        data
    })
    
    output$result <- renderDataTable({
        data = data()
        pred.age <- ifelse(input$Gender == 'Male', eval(predict.men, data), eval(predict.women, data))
        pred.age = round(pred.age, 1)
        res = data.frame(
            Result = c(
                "Age based on stress testing exercise performance (A-BEST)"
            ),
            Estimation = c(
                pred.age
            )
        )
        res
    }, options = list(
            pageLength = 10,
            lengthMenu = 0,
            
            searching = 0,
            info = 0,
            paging = 0,
        initComplete = I(
            "function(settings, json) {
            $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
}"
)
        ))
})
