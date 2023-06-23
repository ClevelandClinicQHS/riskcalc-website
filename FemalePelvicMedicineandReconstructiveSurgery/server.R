formula.with <- expression({
    if (StressTest == "Positive") {
        score = -2.9888276 - 
            0.025271306 * AGE_SURGERY +
            0.39411295 * sqrt(PARITY) + 
            0.94942361 * log(BMI) +
            0.4605713 * (LEAK == 'Positive') -
            1.8324541 * 1 +
            0.37542553 * (BPFDI19 == 'Yes') + 
            0.56222837 * (DIABETES == "Yes")
    } else{
        score = -2.7227561 - 
            0.023456878 * AGE_SURGERY +
            0.34720702 * sqrt(PARITY) +
            0.901963 * log(BMI) - 
            1.7734033 * 1 + 
            0.40231104 * (BPFDI19 == 'Yes') + 
            0.49554499 * (DIABETES == "Yes")
    }
            
    100/(1+exp(-score))
})
formula.wo <- expression({
    if (StressTest == "Positive") {
        score = -2.9888276 - 
            0.025271306 * AGE_SURGERY +
            0.39411295 * sqrt(PARITY) + 
            0.94942361 * log(BMI) +
            0.4605713 * (LEAK== 'Positive') +
            0.37542553 * (BPFDI19 == 'Yes') + 
            0.56222837 * (DIABETES == "Yes")
    } else{
        score = -2.7227561 - 
            0.023456878 * AGE_SURGERY +
            0.34720702 * sqrt(PARITY) +
            0.901963 * log(BMI) +
            0.40231104 * (BPFDI19 == 'Yes') + 
            0.49554499 * (DIABETES == "Yes")
    }
    
    100/(1+exp(-score))
})

        library(shiny)
        shinyServer(function(input, output){
            data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$AGE_SURGERY))& as.numeric(input$AGE_SURGERY)>=18& as.numeric(input$AGE_SURGERY)<=100, 'Please input a valid AGE_SURGERY'))
AGE_SURGERY= as.numeric(input$AGE_SURGERY)
validate(need(!is.na(as.numeric(input$BMI))& as.numeric(input$BMI)>=12& as.numeric(input$BMI)<=100, 'Please input a valid BMI'))
BMI= as.numeric(input$BMI)
validate(need(!is.na(as.numeric(input$PARITY))& as.numeric(input$PARITY)>=0& as.numeric(input$PARITY)<=12, 'Please input a valid PARITY'))
PARITY= as.numeric(input$PARITY)
DIABETES = factor(input$DIABETES, levels = c('No', 'Yes'))
BPFDI19 = factor(input$BPFDI19, levels = c('No', 'Yes'))
LEAK = factor(input$LEAK, levels = c('Preoperative Stress Test Result not available', 'Positive', 'Negative'))
if (LEAK == "Positive" | LEAK == "Negative") {
    StressTest = "Positive"
} else {
    StressTest = "Negative"
}
data <- data.frame(AGE_SURGERY = AGE_SURGERY,
BMI = BMI,
PARITY = PARITY,
DIABETES = DIABETES,
BPFDI19 = BPFDI19,
LEAK = LEAK,
StressTest = StressTest)
data})
output$result <- renderDataTable({data = data()
prob.with <- eval(formula.with, data)
prob.wo <- eval(formula.wo, data)
res = data.frame(Result = c("Risk of de novo Urinary Incontinence with a Continence Procedure","Risk of de novo Urinary Incontinence without a Continence Procedure"),
                 Probability = c(paste(ifelse(round(prob.with, 0) < 1, "<1", ifelse(round(prob.with, 0) > 99, ">99", round(prob.with, 0))), "%"), paste(ifelse(round(prob.wo, 0) < 1, "<1", ifelse(round(prob.wo, 0) > 99, ">99", round(prob.wo, 0))), "%")))

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
        