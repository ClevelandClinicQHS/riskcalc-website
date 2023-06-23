predict.right = expression({
    7 * (Right_A ** 2 + (Right_A * Right_B) + Right_B ** 2) / (3.1416 * 12) + 
        7 * (Right_B ** 2 + (Right_B * Right_C) + Right_C ** 2) / (3.1416 * 12) + 
        7 * (Right_C ** 2 + (Right_C * Right_D) + Right_D ** 2) / (3.1416 * 12) + 
        7 * (Right_D ** 2 + (Right_D * Right_E) + Right_E ** 2) / (3.1416 * 12) + 
        7 * (Right_E ** 2 + (Right_E * Right_F) + Right_F ** 2) / (3.1416 * 12)
})

predict.left = expression({
    7 * (Left_A ** 2 + (Left_A * Left_B) + Left_B ** 2) / (3.1416 * 12) + 
        7 * (Left_B ** 2 + (Left_B * Left_C) + Left_C ** 2) / (3.1416 * 12) + 
        7 * (Left_C ** 2 + (Left_C * Left_D) + Left_D ** 2) / (3.1416 * 12) + 
        7 * (Left_D ** 2 + (Left_D * Left_E) + Left_E ** 2) / (3.1416 * 12) + 
        7 * (Left_E ** 2 + (Left_E * Left_F) + Left_F ** 2) / (3.1416 * 12)
})

shinyServer(function(input, output) {
    # Return the requested dataset
    data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$Left_A))& as.numeric(input$Left_A)>0, 'Please input a valid left arm point A'))
        validate(need(!is.na(as.numeric(input$Left_B))& as.numeric(input$Left_B)>0, 'Please input a valid left arm point B'))
        validate(need(!is.na(as.numeric(input$Left_C))& as.numeric(input$Left_C)>0, 'Please input a valid left arm point C'))
        validate(need(!is.na(as.numeric(input$Left_D))& as.numeric(input$Left_D)>0, 'Please input a valid left arm point D'))
        validate(need(!is.na(as.numeric(input$Left_E))& as.numeric(input$Left_E)>0, 'Please input a valid left arm point E'))
        validate(need(!is.na(as.numeric(input$Left_F))& as.numeric(input$Left_F)>0, 'Please input a valid left arm point F'))
        validate(need(!is.na(as.numeric(input$Right_A))& as.numeric(input$Right_A)>0, 'Please input a valid right arm point A'))
        validate(need(!is.na(as.numeric(input$Right_B))& as.numeric(input$Right_B)>0, 'Please input a valid right arm point B'))
        validate(need(!is.na(as.numeric(input$Right_C))& as.numeric(input$Right_C)>0, 'Please input a valid right arm point C'))
        validate(need(!is.na(as.numeric(input$Right_D))& as.numeric(input$Right_D)>0, 'Please input a valid right arm point D'))
        validate(need(!is.na(as.numeric(input$Right_E))& as.numeric(input$Right_E)>0, 'Please input a valid right arm point E'))
        validate(need(!is.na(as.numeric(input$Right_F))& as.numeric(input$Right_F)>0, 'Please input a valid right arm point F'))
        
        data = data.frame(
            Left_A = as.numeric(input$Left_A),
            Left_B = as.numeric(input$Left_B),
            Left_C = as.numeric(input$Left_C),
            Left_D = as.numeric(input$Left_D),
            Left_E = as.numeric(input$Left_E),
            Left_F = as.numeric(input$Left_F),
            Right_A = as.numeric(input$Right_A),
            Right_B = as.numeric(input$Right_B),
            Right_C = as.numeric(input$Right_C),
            Right_D = as.numeric(input$Right_D),
            Right_E = as.numeric(input$Right_E),
            Right_F = as.numeric(input$Right_F)
        )
        data})
    
    
    # Generate a summary of the dataset
    output$result <- renderDataTable({
        data = data()
        left = round(eval(expr = predict.left, envir = data), 1)
        right = round(eval(expr = predict.right, envir = data), 1)
        diff = abs(left - right)
        res = data.frame(Result = c("Left side arm volume (cm<sup>3</sup>)", "Right side arm volume (cm<sup>3</sup>)", "Absolute difference volumes between both arms (cm<sup>3</sup>)"),
                         Volume = c(left, right, diff))
        res}, escape = F,
        options = list(
            pageLength = 10,
            lengthMenu = 0,
            searching = 0,
            info = 0,
            paging = 0,
            initComplete = I(
                "function(settings, json) {
            $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});}"
            )))

})
