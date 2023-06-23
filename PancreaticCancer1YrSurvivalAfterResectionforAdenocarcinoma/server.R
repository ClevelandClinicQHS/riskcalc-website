predict.score <- expression({
    score = -1.1733872 - 
        0.0018564703 * SurgAge + 
        0.052203014 * (Gender == "Male") + 
        0.14916275 * (PortVein == "Yes") + 
        0.90746165 * (Splenectomy == "Yes") + 
        0.06340785 * (MarginResec == "Positive") - 
        0.75934357 * (Head == "Other") + 
        0.31532231 * (Diff == "Poor") - 
        0.20496646 * (Diff == "Well") + 
        0.3177352 * (PostMargin == "Positive") + 
        0.23051721 * NumPosNodes - 
        0.014400166 * max(NumPosNodes, 0)**3 +        
        0.018000207 * max(NumPosNodes - 1, 0)**3 - 
        0.0036000415 * max(NumPosNodes - 5, 0)**3 - 
        0.0017790967 * NumNegNodes +         
        0.22200163 * (BackPain == "Yes")  - 
        0.53691787 * (TStage == "2") -         
        0.38735092 * (TStage == "3") + 
        0.3867342 * (TStage == "4") + 
        0.04259022 * (WeightLoss == "Yes") + 
        0.43940983 * MaxPathAxis -         
        0.039121714 * max(MaxPathAxis - 2, 0)**3 + 
        0.059533043 * max(MaxPathAxis - 3.2, 0)**3 - 
        0.020411329 * max(MaxPathAxis - 5.5, 0)**3
    exp(score)
})
        library(shiny)
        shinyServer(function(input, output){
            data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$SurgAge))& as.numeric(input$SurgAge)>=33& as.numeric(input$SurgAge)<=89, 'Please input a valid SurgAge'))
SurgAge= as.numeric(input$SurgAge)
BackPain = factor(input$BackPain, levels = c('Yes', 'No'))
Gender = factor(input$Gender, levels = c('Male', 'Female'))
MarginResec = factor(input$MarginResec, levels = c('Negative', 'Positive'))
validate(need(!is.na(as.numeric(input$MaxPathAxis))& as.numeric(input$MaxPathAxis)>=0.1& as.numeric(input$MaxPathAxis)<=16, 'Please input a valid MaxPathAxis'))
MaxPathAxis= as.numeric(input$MaxPathAxis)
validate(need(!is.na(as.numeric(input$NumNegNodes))& as.numeric(input$NumNegNodes)>=0& as.numeric(input$NumNegNodes)<=83, 'Please input a valid NumNegNodes'))
NumNegNodes= as.numeric(input$NumNegNodes)
validate(need(!is.na(as.numeric(input$NumPosNodes))& as.numeric(input$NumPosNodes)>=0& as.numeric(input$NumPosNodes)<=39, 'Please input a valid NumPosNodes'))
NumPosNodes= as.numeric(input$NumPosNodes)
PortVein = factor(input$PortVein, levels = c('No', 'Yes'))
PostMargin = factor(input$PostMargin, levels = c('Negative', 'Positive'))
Head = factor(input$Head, levels = c('Head', 'Other'))
Splenectomy = factor(input$Splenectomy, levels = c('No', 'Yes'))
Diff = factor(input$Diff, levels = c('Poor', 'Moderate', 'Well'))
TStage = factor(input$TStage, levels = c('1', '2', '3', '4'))
WeightLoss = factor(input$WeightLoss, levels = c('Yes', 'No'))
data <- data.frame(SurgAge = SurgAge,
BackPain = BackPain,
Gender = Gender,
MarginResec = MarginResec,
MaxPathAxis = MaxPathAxis,
NumNegNodes = NumNegNodes,
NumPosNodes = NumPosNodes,
PortVein = PortVein,
PostMargin = PostMargin,
Head = Head,
Splenectomy = Splenectomy,
Diff = Diff,
TStage = TStage,
WeightLoss = WeightLoss)
data})
output$result <- renderDataTable({data = data()
m12<- paste(ifelse(round(100 * 0.6775 ** eval(predict.score, data), 0) < 1, "<1", ifelse(round(100 * 0.6775 ** eval(predict.score, data), 0) > 99, ">99", round(100 * 0.6775 ** eval(predict.score, data), 0))), "%")
m24<- paste(ifelse(round(100 * 0.3457804 ** eval(predict.score, data), 0) < 1, "<1", ifelse(round(100 * 0.3457804 ** eval(predict.score, data), 0) > 99, ">99", round(100 * 0.3457804 ** eval(predict.score, data), 0))), "%")
m36<- paste(ifelse(round(100 * 0.1976732 ** eval(predict.score, data), 0) < 1, "<1", ifelse(round(100 * 0.1976732 ** eval(predict.score, data), 0) > 99, ">99", round(100 * 0.1976732 ** eval(predict.score, data), 0))), "%")
res = data.frame(Result = c("12-Month Disease-Specific Survival Percentage","24-Month Disease-Specific Survival Percentage","36-Month Disease-Specific Survival Percentage"),
                 Probability = c(m12, m24, m36))

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
        