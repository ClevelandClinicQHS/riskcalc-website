predict.1yr <- expression({
    lp <- 1 - pnorm((log(12)- (1.1210092 + 
                                   0.010887488 * AgeYr - 
                                   0.00001428584 * max(AgeYr - 56, 0)**3 + 
                                   0.00003174631 * max(AgeYr - 67, 0)**3 - 
                                   0.000017460471 * max(AgeYr - 76, 0)**3 + 
                                   0.021699824 * KPS + 
                                   0.0000071156976 * max(KPS - 70, 0)**3 - 
                                   0.000014231395 * max(KPS - 80, 0)**3 + 
                                   0.0000071156976 * max(KPS - 90, 0)**3 + 
                                   0.12130885 * HGB + 
                                   0.0017197215 * max(HGB - 9.78, 0)**3 - 
                                   0.0044712759 * max(HGB - 12.5, 0)**3 + 
                                   0.0027515544 * max(HGB - 14.2, 0)**3 + 
                                   0.008018538 * log(PSA +0.00001) + 
                                   0.00061135354 * max(log(PSA +0.00001) - 2.538198, 0)**3 - 
                                   0.0011463778 *max(log(PSA +0.00001) - 4.5685063, 0)**3 + 
                                   0.00053502427 * max(log(PSA +0.00001) - 6.8884687, 0)**3 - 
                                   0.59395878 * log(LDH) + 
                                   0.26774794 * max(log(LDH) - 4.9628446, 0)**3 - 
                                   0.39640554 * max(log(LDH) - 5.2678582, 0)**3 + 
                                   0.12865761 * max(log(LDH) - 5.9026185, 0)**3 - 
                                   0.26247814 * log(ALK) + 
                                   0.05124532 * max(log(ALK) - 4.2904594, 0)**3 - 
                                   0.077302339 * max(log(ALK) - 5.0937502, 0)**3 + 
                                   0.02605702 * max(log(ALK) - 6.6735507, 0)**3 + 
                                   0.48641327 * ALB - 
                                   0.427889 * max(ALB - 3.6, 0)**3 + 
                                   1.0697225 * max(ALB - 4.2, 0)**3 - 
                                   0.6418335 * max(ALB - 4.6, 0)**3))/exp(- 0.3669))
})
predict.2yr <- expression({
    lp <- 1 - pnorm((log(24)- (1.1210092 + 
                                   0.010887488 * AgeYr - 
                                   1.428584e-005 * max(AgeYr - 56, 0)**3 + 
                                   3.174631e-005 * max(AgeYr - 67, 0)**3 - 
                                   1.7460471e-005 * max(AgeYr - 76, 0)**3 + 
                                   0.021699824 * KPS + 
                                   7.1156976e-006 * max(KPS - 70, 0)**3 - 
                                   1.4231395e-005 * max(KPS - 80, 0)**3 + 
                                   7.1156976e-006 * max(KPS - 90, 0)**3 + 
                                   0.12130885 * HGB + 
                                   0.0017197215 * max(HGB - 9.78, 0)**3 - 
                                   0.0044712759 * max(HGB - 12.5, 0)**3 + 
                                   0.0027515544 * max(HGB - 14.2, 0)**3 + 
                                   0.008018538 * log(PSA +1e-005) + 
                                   0.00061135354 * max(log(PSA +1e-005) - 2.538198, 0)**3 - 
                                   0.0011463778 *max(log(PSA +1e-005) - 4.5685063, 0)**3 + 
                                   0.00053502427 * max(log(PSA +1e-005) - 6.8884687, 0)**3 - 
                                   0.59395878 * log(LDH) + 
                                   0.26774794 * max(log(LDH) - 4.9628446, 0)**3 - 
                                   0.39640554 * max(log(LDH) - 5.2678582, 0)**3 + 
                                   0.12865761 * max(log(LDH) - 5.9026185, 0)**3 - 
                                   0.26247814 * log(ALK) + 
                                   0.05124532 * max(log(ALK) - 4.2904594, 0)**3 - 
                                   0.077302339 * max(log(ALK) - 5.0937502, 0)**3 + 
                                   0.02605702 * max(log(ALK) - 6.6735507, 0)**3 + 
                                   0.48641327 * ALB - 
                                   0.427889 * max(ALB - 3.6, 0)**3 + 
                                   1.0697225 * max(ALB - 4.2, 0)**3 - 
                                   0.6418335 * max(ALB - 4.6, 0)**3))/exp(- 0.3669))
})
        library(shiny)
        shinyServer(function(input, output){
            data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$AgeYr))& as.numeric(input$AgeYr)>=44& as.numeric(input$AgeYr)<=85, 'Please input a valid AgeYr'))
AgeYr= as.numeric(input$AgeYr)
validate(need(!is.na(as.numeric(input$ALB))& as.numeric(input$ALB)>=2.6& as.numeric(input$ALB)<=5.2, 'Please input a valid ALB'))
ALB= as.numeric(input$ALB)
validate(need(!is.na(as.numeric(input$ALK))& as.numeric(input$ALK)>=18& as.numeric(input$ALK)<=3079, 'Please input a valid ALK'))
ALK= as.numeric(input$ALK)
validate(need(!is.na(as.numeric(input$HGB))& as.numeric(input$HGB)>=6.7& as.numeric(input$HGB)<=16.4, 'Please input a valid HGB'))
HGB= as.numeric(input$HGB)
validate(need(!is.na(as.numeric(input$KPS))& as.numeric(input$KPS)>=50& as.numeric(input$KPS)<=90, 'Please input a valid KPS'))
KPS= as.numeric(input$KPS)
validate(need(!is.na(as.numeric(input$LDH))& as.numeric(input$LDH)>=116& as.numeric(input$LDH)<=1955, 'Please input a valid LDH'))
LDH= as.numeric(input$LDH)
validate(need(!is.na(as.numeric(input$PSA))& as.numeric(input$PSA)>=0& as.numeric(input$PSA)<=8450, 'Please input a valid PSA'))
PSA= as.numeric(input$PSA)
data <- data.frame(AgeYr = AgeYr,
ALB = ALB,
ALK = ALK,
HGB = HGB,
KPS = KPS,
LDH = LDH,
PSA = PSA)
data})
output$result <- renderDataTable({data = data()
yr1 <- paste(ifelse(round(eval(predict.1yr, data)*100, 0) < 1, "<1", ifelse(round(eval(predict.1yr, data)*100, 0) > 99, ">99", round(eval(predict.1yr, data)*100, 0))), "%")
yr2 <- paste(ifelse(round(eval(predict.2yr, data)*100, 0) < 1, "<1", ifelse(round(eval(predict.2yr, data)*100, 0) > 99, ">99", round(eval(predict.2yr, data)*100, 0))), "%")
res = data.frame(Result = c("1-Year Survival Probability","2-Year Survival Probability"),
                 Probability = c(yr1, yr2))

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
        