
predict.weightloss <- expression({
    lp <- 0.93011091 - 
        0.010453436 * Age - 0.37554101 * (sex == "Male") + 0.24555704 * 
        (Race == "Other") + 1.045709 * (Race == "White") - 0.048470029 * 
        NumberOfComorbidities - 0.59009414 * (T2D == "Yes") - 0.51358293 * 
        (SmokingStatus == "Smoker") + 0.021282721 * BMI
    lp
})


library(shiny)
shinyServer(function(input, output){
    output$heightControls <- renderUI({
        placeholder = ifelse(input$height_unit == 'inch', '47 to 98 inch', '1.2 to 2.5 m')
        textInput("height", NULL, placeholder = placeholder)
    })
    
    output$weightControls <- renderUI({
        placeholder = ifelse(input$weight_unit == 'pound', '110 to 550 lb', '50 to 250 kg')
        textInput("weight", NULL, placeholder = placeholder)
    })
    
    data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$Age))& as.numeric(input$Age)>=18& as.numeric(input$Age)<=90, 'Please input a valid Age'))
        Age= as.numeric(input$Age)
        sex = factor(input$sex, levels = c('Female', 'Male'))
        Race = factor(input$Race, levels = c('White', 'Black', 'Other'))
        NumberOfComorbidities = length(input$NumberOfComorbidities)
        T2D = factor(input$T2D, levels = c('No', 'Yes'))
        SmokingStatus = factor(input$SmokingStatus, levels = c("None Smoker", 'Smoker'))
        validate(need(!is.na(as.numeric(input$height)), 'Please input a valid Height'))
        validate(need(!is.na(as.numeric(input$weight)), 'Please input a valid Weight'))
        Height = ifelse(input$height_unit == 'meter', as.numeric(input$height), as.numeric(input$height)/39.37)
        validate(need(Height >= 1.19 & Height <= 2.5, 'Please input a valid Height'))
        Weight = ifelse(input$weight_unit == 'kg', as.numeric(input$weight), as.numeric(input$weight)/2.205)
        validate(need(Weight >= 49 & Height <= 250, 'Please input a valid Weight'))
        BMI = Weight / (Height * Height)

        data <- data.frame(Age = Age,
                           sex = sex,
                           Race = Race,
                           NumberOfComorbidities = NumberOfComorbidities,
                           T2D = T2D,
                           SmokingStatus = SmokingStatus,
                           BMI = BMI)
        data})
    
    output$result <- renderDataTable({data = data()
    
    weightloss.Lorcaserin <- eval(predict.weightloss, data)
    Weightloss.Phentermine_Hydrochloride = weightloss.Lorcaserin + 2.0079498
    Weightloss.Phentermine_Topiramate = weightloss.Lorcaserin + 1.8899326
    Weightloss.Bupropion = weightloss.Lorcaserin + 0.91667333
    
    res = data.frame(Result = c("12-Weeks Weight Loss (in %)"),
                     `Phentermine Hydrochloride` = paste(round(Weightloss.Phentermine_Hydrochloride, 1), "%"),
                     `Phentermine-Topiramate` = paste(round(Weightloss.Phentermine_Topiramate, 1), "%"),
                     `Bupropion-Naltrexone` = paste(round(Weightloss.Bupropion, 1), "%"))
    
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
