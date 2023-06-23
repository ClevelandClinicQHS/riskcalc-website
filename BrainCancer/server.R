formula.6month <- expression({
    lp = -1.0294178 + 0.13940245 * (SiteHistology == "BO") + 
        0.16869785 * (SiteHistology == "LA") + 
        0.34689335 * (SiteHistology == "LL") + 
        0.37202065 * (SiteHistology == "LO") + 
        0.39161893 * (SiteHistology == "LSM") + 
        0.58907131 * (SiteHistology == "LSQ") + 
        0.11217987 * (SiteHistology == "OA") + 
        0.48398784 * (SiteHistology == "OG") + 
        0.35622365 * (SiteHistology == "OR") + 
        0.30783296 * (SiteHistology == "OSQ") + 
        0.33424084 * (SiteHistology == "SMM") + 
        0.37304125 * (SiteHistology == "OO") + 
        0.29861618 * (PStatus == "Tumor uncontrolled") + 
        0.36100642 * (MetsSpread == "Brain & other sites") + 
        0.0039444646 * AgeYr + 
        0.000018186285 * max(AgeYr - 44, 0)**3 - 
        0.00003917046 * max(AgeYr - 59, 0)**3 + 
        0.000020984175 * max(AgeYr - 72, 0)**3 + 
        0.1598307 * (KPS == "<70") + 
        0.17246759 * (Lesions == "multiple")
    100 * 0.385617 ** exp(lp)
})
formular.12month <- expression({
    lp <- -1.0294178 + 0.13940245 * (SiteHistology == "BO") + 
        0.16869785 * (SiteHistology == "LA") + 
        0.34689335 * (SiteHistology == "LL") + 
        0.37202065 * (SiteHistology == "LO") + 
        0.39161893 * (SiteHistology == "LSM") + 
        0.58907131 * (SiteHistology == "LSQ") + 
        0.11217987 * (SiteHistology == "OA") + 
        0.48398784 * (SiteHistology == "OG") + 
        0.35622365 * (SiteHistology == "OR") + 
        0.30783296 * (SiteHistology == "OSQ") + 
        0.33424084 * (SiteHistology == "SMM") + 
        0.37304125 * (SiteHistology == "OO") + 
        0.29861618 * (PStatus == "Tumor uncontrolled") +
        0.36100642 * (MetsSpread == "Brain & other sites") +
        0.0039444646 * AgeYr + 
        0.000018186285 * max(AgeYr - 44, 0)**3 - 
        0.00003917046 * max(AgeYr - 59, 0)**3 + 
        0.000020984175 * max(AgeYr - 72, 0)**3 + 
        0.1598307 * (KPS == "<70") + 
        0.17246759 * (Lesions == "multiple")
    100 * 0.1725347 ** exp(lp)
})
        library(shiny)
        shinyServer(function(input, output){
            data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$AgeYr))& as.numeric(input$AgeYr)>=10& as.numeric(input$AgeYr)<=90, 'Please input a valid AgeYr'))
AgeYr= as.numeric(input$AgeYr)
KPS = factor(input$KPS, levels = c('<70', '>=70'))
MetsSpread = factor(input$MetsSpread, levels = c('Brain alone', 'Brain & other sites'))
Lesions = factor(input$Lesions, levels = c('single', 'multiple'))
SiteHistology = factor(input$SiteHistology, levels = c('BA', 'BO', 'LA', 'LL', 'LO', 'LSM', 'LSQ', 'OA', 'OG', 'OR', 'OSQ', 'SMM', 'OO'))
PStatus = factor(input$PStatus, levels = c('Tumor controlled', 'Tumor uncontrolled'))
data <- data.frame(AgeYr = AgeYr,
KPS = KPS,
MetsSpread = MetsSpread,
Lesions = Lesions,
SiteHistology = SiteHistology,
PStatus = PStatus)
data})
output$result <- renderDataTable({data = data()
prob1 <- eval(formula.6month, data)
prob2 <- eval(formular.12month, data)
res = data.frame(Result = c("Predicted 6-month survival probability", "Predicted 12-month survival probability"),
                 Probability = c(paste(ifelse(round(prob1, 0) < 1, "<1", ifelse(round(prob1, 0) > 99, ">99", round(prob1, 0))), "%"), paste(ifelse(round(prob2, 0) < 1, "<1", ifelse(round(prob2, 0) > 99, ">99", round(prob2, 0))), "%")))

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
        