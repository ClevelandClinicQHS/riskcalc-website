formula <- expression({
    lp <- -1.2510727 + 
        0.1008462 * (Gender == "Male") - 
        0.0032465751 * AgeYr + 
        1.5636899e-05 * max(AgeYr - 44.531691, 0)**3 - 
        3.8886085e-05 * max(AgeYr - 62.778919, 0)**3 + 
        2.3249186e-05 * max(AgeYr -75.051608, 0)**3 + 
        0.07378188 * (SiteColonCa == "Rectum") - 
        0.0018825555 * DFI - 
        6.1963058e-07 * max(DFI - 1.0526316,0)**3 + 
        9.030324e-07 * max(DFI - 14.358553, 0)**3 - 
        2.8340182e-07 * max(DFI - 43.450658, 0)**3 + 
        0.0047229868 * PreOpCEA - 
        4.2571122e-07 * max(PreOpCEA - 1.9, 0)**3 + 
        4.509579e-07 * max(PreOpCEA - 16.4, 0)**3 - 
        2.5246678e-08 * max(PreOpCEA - 260.9, 0)**3 + 
        0.18477796 * L1Num - 
        0.012374755 * max(L1Num - 1, 0)**3 + 
        0.016499674 * max(L1Num - 2, 0)**3 - 
        0.0041249184 * max(L1Num - 5, 0)**3 + 
        0.16196123 * SizeLargestMet -         
        0.0031986188 * max(SizeLargestMet - 1.96, 0)**3 + 
        0.0045842553 * max(SizeLargestMet - 4.1, 0)**3 - 
        0.0013856365 * max(SizeLargestMet - 9.04, 0)**3 + 
        0.10401778 * (BilatSC == "Yes") - 
        0.17925238 * (LobeOrMore == "Yes") + 
        0.3924501 * (NodalStatus == "1") + 
        0.56209452 * (NodalStatus == "2")
    100 * 0.2616181 ** exp(lp)
})
        library(shiny)
        shinyServer(function(input, output){
            data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$AgeYr))& as.numeric(input$AgeYr)>=19& as.numeric(input$AgeYr)<=87, 'Please input a valid AgeYr'))
AgeYr= as.numeric(input$AgeYr)
Gender = factor(input$Gender, levels = c('Male', 'Female'))
SiteColonCa = factor(input$SiteColonCa, levels = c('Rectum', 'Colon'))
validate(need(!is.na(as.numeric(input$DFI))& as.numeric(input$DFI)>=0& as.numeric(input$DFI)<=152, 'Please input a valid DFI'))
DFI= as.numeric(input$DFI)
validate(need(!is.na(as.numeric(input$PreOpCEA))& as.numeric(input$PreOpCEA)>=0& as.numeric(input$PreOpCEA)<=16400, 'Please input a valid PreOpCEA'))
PreOpCEA= as.numeric(input$PreOpCEA)
validate(need(!is.na(as.numeric(input$L1Num))& as.numeric(input$L1Num)>=0& as.numeric(input$L1Num)<=20, 'Please input a valid L1Num'))
L1Num= as.numeric(input$L1Num)
validate(need(!is.na(as.numeric(input$SizeLargestMet))& as.numeric(input$SizeLargestMet)>=0& as.numeric(input$SizeLargestMet)<=55, 'Please input a valid SizeLargestMet'))
SizeLargestMet= as.numeric(input$SizeLargestMet)
NodalStatus = factor(input$NodalStatus, levels = c('0', '1', '2'))
BilatSC = factor(input$BilatSC, levels = c('Yes', 'No'))
LobeOrMore = factor(input$LobeOrMore, levels = c('Yes', 'No'))
data <- data.frame(AgeYr = AgeYr,
Gender = Gender,
SiteColonCa = SiteColonCa,
DFI = DFI,
PreOpCEA = PreOpCEA,
L1Num = L1Num,
SizeLargestMet = SizeLargestMet,
NodalStatus = NodalStatus,
BilatSC = BilatSC,
LobeOrMore = LobeOrMore)
data})
output$result <- renderDataTable({data = data()
prob = eval(formula, data)
res = data.frame(Result = c("Percentage of 96-Month Disease Specific Survival"), Probability = c(paste(ifelse(round(prob, 0) < 1, "<1", ifelse(round(prob, 0) > 99, ">99", round(prob, 0))), "%")))

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
        