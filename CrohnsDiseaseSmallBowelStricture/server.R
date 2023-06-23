
library(shiny)
library(rms) 
library(dplyr)
library(shinyWidgets)
library(shinyBS) 
library(shinythemes) 
library(shinyjs)

load("model.RData")

function(input, output) {
    
    # input
    data <- eventReactive(input$click, {
        # validate the inputs
        shiny::validate(need(!is.na(input$dur) & input$dur>=0 & input$dur <=147, 'Please input a value within range, otherwise, the prediction will be less precise'))
        shiny::validate(need(!is.na(input$len) & input$len>=1 & input$len <=70, 'Please input a value within range, otherwise, the prediction will be less precise')) 
        shiny::validate(need(!is.na(input$max) & input$max>=2 & input$max <=17, 'Please input a value within range, otherwise, the prediction will be less precise')) 
        shiny::validate(need(!is.na(input$Ti) & input$Ti>=1 & input$Ti <= 48, 'Please input a value within range, otherwise, the prediction will be less precise'))
        
        # clean inputs
        biologics = input$bio 
        duration = input$dur 
        score1 = input$index1 
        score2 = input$index2 
        score3 = input$index3 
        score4 = input$index4 
        score5 = input$index5 
        score6 = input$index6 
        score7 = input$index7 
        length = input$len 
        maximum = input$max 
        time = input$Ti
        
        # create data frame from input
        data <- data.frame(biologicB = factor(biologics, levels = c("No","Yes")), 
                           DurStrictMon1 = as.numeric(as.character(duration)), 
                           obstructive = sum(c(score1 == "Yes", 
                                               score2 == "Yes", 
                                               score3 == "Yes", 
                                               score4 == "Yes", 
                                               score5 == "Yes", 
                                               score6 == "Yes", 
                                               score7 == "Yes")),
                           length = as.numeric(as.character(length)), 
                           maxwall = as.numeric(as.character(maximum)), 
                           time = as.numeric(as.character(time))) 
        data})
    
    # output table
    output$result <- DT::renderDataTable({
        data = data()
        prob.model1 = round(100-survest(model,data,times = data$time, conf.type = "log-log")$surv*100,1)
        res = data.frame(Result = c("Prediction of risk of intervention (surgery or endoscopic balloon dilation)"),
                         `Time Frame` = c(paste(data$time, "Months")), 
                         Probability = c(paste(prob.model1,"%",sep = "")))
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







