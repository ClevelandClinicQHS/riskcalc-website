formula <- expression({
    lp <- exp(-exp((log(7)- (8.3107521 - 0.76246522 * (Smoking == "Ex Smoker") - 
                                 0.5912926 *        (Smoking == "Active") + 
                                 0.079269152 * Pouch2Clinic -        
                                 0.32409261 * (BaselinePouchDx == "Irritable pouchitis (IPS)") - 
                                 0.85136696 *         (BaselinePouchDx == "Active pouchitis") - 
                                 2.7347704 * (BaselinePouchDx ==         "Refrac pouchitis") - 
                                 2.9246199 * (BaselinePouchDx == "Crohns disease (CD)") - 
                                 3.3838821 *         (BaselinePouchDx == "Cuffitis") - 
                                 4.0721854 * (BaselinePouchDx ==         "Surgical complications") - 
                                 0.30874864 * (PreOpBioTx == "Yes") - 
                                 2.6431145 *         (PostOpBioTx == "Yes")))/1.574224))
})
        library(shiny)
        shinyServer(function(input, output){
            data <- eventReactive(input$goButton, {
        Smoking = factor(input$Smoking, levels = c('No', 'Ex Smoker', 'Active'))
validate(need(!is.na(as.numeric(input$Pouch2Clinic))& as.numeric(input$Pouch2Clinic)>=0& as.numeric(input$Pouch2Clinic)<=40, 'Please input a valid Pouch2Clinic'))
Pouch2Clinic= as.numeric(input$Pouch2Clinic)
BaselinePouchDx = factor(input$BaselinePouchDx, levels = c('Normal', 'Irritable pouchitis (IPS)', 'Active pouchitis', 'Refrac pouchitis', 'Crohns disease (CD)', 'Cuffitis', 'Surgical complications'))
PreOpBioTx = factor(input$PreOpBioTx, levels = c('None', 'Yes'))
PostOpBioTx = factor(input$PostOpBioTx, levels = c('Yes', 'None'))
data <- data.frame(Smoking = Smoking,
Pouch2Clinic = Pouch2Clinic,
BaselinePouchDx = BaselinePouchDx,
PreOpBioTx = PreOpBioTx,
PostOpBioTx = PostOpBioTx)
data})
output$result <- renderDataTable({data = data()
prob = eval(formula, data)
res = data.frame(Result = c("Predicted 7-year pouch retention probability"), Probability = c(paste(ifelse(round(prob * 100, 0) < 1, "<1", ifelse(round(prob * 100, 0) > 99, ">99", round(prob * 100, 0))), "%")))

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
        