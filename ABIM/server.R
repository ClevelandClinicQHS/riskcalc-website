predict.abim <- expression({
    lp <- -45.501642 + 
    0.45950421 * IT3 + 
    0.17471223 * IT2 + 
    0.24046891 * IT1 - 
    1.0711728 * Call6
    1/(1+exp(-lp)) * 100
})

library(shiny)
shinyServer(function(input, output) {
    data <- eventReactive(input$goButton, {
        IT1 = input$IT1
        IT2 = input$IT2
        IT3 = input$IT3
        Call6 = input$Call6
        data <- data.frame(
            IT1 = IT1,
            IT2 = IT2,
            IT3 = IT3,
            Call6 = Call6
        )
        data
    })
    output$result <- renderDataTable({
        data = data()
        prob.abim <- ifelse(eval(predict.abim, data) < 1, "<1%", 
                     ifelse(eval(predict.abim, data) > 99, ">99%", 
                     paste(round(eval(predict.abim, data), 0), "%", sep = "")))
        res = data.frame(
            Result = c(
                "Probability of passing the American Board of Internal Medicine (ABIM) certifying examination"
            ),
            Prediction = c(
                prob.abim
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
