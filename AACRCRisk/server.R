
library(shiny)
library(rms) 
library(dplyr)
library(shinyWidgets)
library(shinyBS) 
library(shinythemes) 
library(shinyjs)

load("model1.RData") 
composite <- mod 

load("model2.RData") 
aa <- mod                   

load("model3.RData")
crc <- mod

function(input, output) {
    
    ## composite 
    # input
    data1 <- eventReactive(input$click1, {
        # validate the inputs
        shiny::validate(need(!is.na(input$bmi) & input$bmi >= 12.84 & input$bmi <=59.97, 'Please input a value within range, otherwise, the prediction will be less precise'))

        # clean inputs
        bmi = input$bmi 
        sex = input$sex 
        race1 = input$race1 
        ethnic = input$ethnic  
        smoking = input$smoking 
        alcohol = input$alcohol 
        diabetes = input$diabetes 
        hpl = input$hpl 
        crc_history = input$crc_history 
        asa = input$asa
        
        # create data frame from input
        data <- data.frame(BMI = as.numeric(as.character(bmi)),  
                           Sexclassification = factor(sex, levels = c("Female","Male")),  
                           Race = factor(race1, levels = c("Black","White","Other")),  
                           Ethnic = factor(ethnic, levels = c("Not Hispanic","Hispanic")), 
                           smoking = factor(smoking, levels = c("Never","Ever")), 
                           alcohol = factor(alcohol, levels = c("Never","Ever")), 
                           Diabetes1 = factor(diabetes, levels = c("No","Yes")), 
                           HPL1 = factor(hpl, levels = c("No","Yes")), 
                           CRC_history = factor(crc_history, levels = c("No","Yes")), 
                           ASA = factor(asa, levels = c("No","Yes")) 
                           ) 
        data})
    
    # output table
    output$result1 <- DT::renderDataTable({
        data = data1() 
        prob.model1 = predict(composite, newdata = data, se.fit = TRUE, type = "response")      
        res = data.frame(Result = c("Prediction of risk of Advanced Adenoma or CRC"),
                         Probability = c(paste(round(prob.model1$fit*100,2),"% " ##, "[",round((prob.model1$fit-prob.model1$se.fit*1.96)*100,2),"%, ",round((prob.model1$fit+prob.model1$se.fit*1.96)*100,2),"%]"
                                               ,sep = "")))
        res
    }, options = list(
        pageLength = 10,
        lengthMenu = 0,
        
        searching = 0,
        processing = 0,
        info = 0,
        paging = 0,
        initComplete = I(
            "function(settings, json) {
                    $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
            }")))
    
    ## advanced adenoma 
    # input
    data2 <- eventReactive(input$click2, {
        # validate the inputs
        shiny::validate(need(!is.na(input$bmi2) & input$bmi2 >= 12.84 & input$bmi2 <=59.97, 'Please input a value within range, otherwise, the prediction will be less precise'))
        
        # clean inputs
        bmi = input$bmi2 
        sex = input$sex2 
        race1 = input$race2 
        ethnic = input$ethnic2  
        smoking = input$smoking2 
        alcohol = input$alcohol2 
        diabetes = input$diabetes2 
        hpl = input$hpl2 
        crc_history = input$crc_history2 
        asa = input$asa2 
        
        # create data frame from input
        data <- data.frame(BMI = as.numeric(as.character(bmi)),  
                           Sexclassification = factor(sex, levels = c("Female","Male")),  
                           Race = factor(race1, levels = c("Black","White","Other")),  
                           Ethnic = factor(ethnic, levels = c("Not Hispanic","Hispanic")), 
                           smoking = factor(smoking, levels = c("Never","Ever")), 
                           alcohol = factor(alcohol, levels = c("Never","Ever")), 
                           Diabetes1 = factor(diabetes, levels = c("No","Yes")), 
                           HPL1 = factor(hpl, levels = c("No","Yes")), 
                           CRC_history = factor(crc_history, levels = c("No","Yes")), 
                           ASA = factor(asa, levels = c("No","Yes")) 
        ) 
        data})
    
    # output table
    output$result2 <- DT::renderDataTable({
        data = data2()
        prob.model2 = predict(aa, newdata = data, se.fit = TRUE, type = "response")      
        res = data.frame(Result = c("Prediction of risk of Advanced Adenoma"),
                         Probability = c(paste(round(prob.model2$fit*100,2),"% " ##,"[",round((prob.model2$fit-prob.model2$se.fit*1.96)*100,2),"%, ",round((prob.model2$fit+prob.model2$se.fit*1.96)*100,2),"%]"
                                               ,sep = "")))
        res
    }, options = list(
        pageLength = 10,
        lengthMenu = 0,
        
        searching = 0,
        processing = 0,
        info = 0,
        paging = 0,
        initComplete = I(
            "function(settings, json) {
                    $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
            }")))  
    
    ## CRC                   
    # input
    data3 <- eventReactive(input$click3, {
        # validate the inputs
        ## shiny::validate(need(!is.na(input$bmi2) & input$bmi2 >= 12.84 & input$bmi2 <=59.97, 'Please input a value within range, otherwise, the prediction will be less precise'))
        
        # clean inputs
        diabetes = input$diabetes3  
        crc_history = input$crc_history3 
        reason = input$reason3 
        
        # create data frame from input
        data <- data.frame(Diabetes1 = factor(diabetes, levels = c("No","Yes")), 
                            CRC_history = factor(crc_history, levels = c("No","Yes")), 
                            REASON = factor(reason, levels = c("Low Risk","High Risk")) 
        ) 
        data})
    
    # output table
    output$result3 <- DT::renderDataTable({
        data = data3()
        prob.model3 = predict(crc, newdata = data, se.fit = TRUE, type = "response")      
        res = data.frame(Result = c("Prediction of risk of CRC"),
                         Probability = c(paste(round(prob.model3$fit*100,2),"% " ##,"[",round((prob.model3$fit-prob.model3$se.fit*1.96)*100,2),"%, ",round((prob.model3$fit+prob.model3$se.fit*1.96)*100,2),"%]"
                                               ,sep = "")))
        res
    }, options = list(
        pageLength = 10,
        lengthMenu = 0,
        
        searching = 0,
        processing = 0,
        info = 0,
        paging = 0,
        initComplete = I(
            "function(settings, json) {
                    $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
            }"))) 
    
}







