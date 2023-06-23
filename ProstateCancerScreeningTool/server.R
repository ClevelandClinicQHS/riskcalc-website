shinyServer(function(input, output, session) {
    v <- reactiveValues(calc = FALSE)
    
    data = reactive({
        input$calcScore
        q1 = as.numeric(gsub(".*?([0-9]+).*", "\\1", input$q1))
        q2 = max(as.numeric(gsub(".*?([0-9]+).*", "\\1", input$q2)))
        q3 = sum(as.numeric(gsub(".*?([0-9]+).*", "\\1", input$q3)))
        q4 = as.numeric(gsub(".*?([0-9]+).*", "\\1", input$q4))
        q5 = as.numeric(gsub(".*?([0-9]+).*", "\\1", input$q5))
        q6 = as.numeric(gsub(".*?([0-9]+).*", "\\1", input$q6))
        q7 = as.numeric(gsub(".*?([0-9]+).*", "\\1", input$q7))
        q8 = as.numeric(gsub(".*?([0-9]+).*", "\\1", input$q8))
        q9 = as.numeric(gsub(".*?([0-9]+).*", "\\1", input$q9))
        score = sum(c(q1, q2, q3, q4, q5, q6, q7, q8, q9))
        score
    })
    
    observeEvent(input$calcScore, {
        v$calc = TRUE
    })
    
    output$warning_q1 <- renderUI({
        if(v$calc & input$q1==""){
            return(p("Please select an answer", style = "color:red"))
        }
    })
    
    output$warning_q2 <- renderUI({
        if(v$calc & is.null(input$q2)){
            return(p("Please select an answer", style = "color:red"))
        }
    })
    
    output$warning_q3 <- renderUI({
        if(v$calc & is.null(input$q3)){
            return(p("Please select an answer", style = "color:red"))
        } else if (input$calcScore & c('c1') %in% input$q3 & any(c("a1", "b2") %in% input$q3)) {
            return(p('Skip "More than one family member had prostate cancer (1)" if father or brother had prostate cancer', style = "color:red"))
        } else if (input$calcScore & (any(c("d0", "e0") %in% input$q3) & any(c("a1", "b2", "c1") %in% input$q3))) {
            return(p('Please select a correct answer', style = "color:red"))
        }
    })
    
    output$warning_q4 <- renderUI({
        if(v$calc & input$q4==""){
            return(p("Please select an answer", style = "color:red"))
        }
    })
    
    output$warning_q5 <- renderUI({
        if(v$calc & input$q5==""){
            return(p("Please select an answer", style = "color:red"))
        }
    })
    
    output$warning_q6 <- renderUI({
        if(v$calc & input$q6==""){
            return(p("Please select an answer", style = "color:red"))
        }
    })
    
    output$warning_q7 <- renderUI({
        if(v$calc & input$q7==""){
            return(p("Please select an answer", style = "color:red"))
        }
    })
    
    output$warning_q8 <- renderUI({
        if(v$calc & input$q8==""){
            return(p("Please select an answer", style = "color:red"))
        }
    })
    
    output$warning_q9 <- renderUI({
        if(v$calc & input$q9==""){
            return(p("Please select an answer", style = "color:red"))
        }
    })
    
    output$score <- renderText({
        if(v$calc & input$q1!="" & !is.null(input$q2) & !is.null(input$q3) & 
           !(c('c1') %in% input$q3 & any(c("a1", "b2") %in% input$q3)) & !(any(c("d0", "e0") %in% input$q3) & any(c("a1", "b2", "c1") %in% input$q3)) & 
           input$q4!="" & input$q5!="" & input$q6!="" & input$q7!="" & input$q8!="" & input$q9!="") {
            score = data()
            paste('<b>Your score is <span style="color:red">', score, "</span></b>")
        }
    })
    
    output$plot <- renderUI({
        if(v$calc & input$q1!="" & !is.null(input$q2) & !is.null(input$q3) & 
           !(c('c1') %in% input$q3 & any(c("a1", "b2") %in% input$q3)) & !(any(c("d0", "e0") %in% input$q3) & any(c("a1", "b2", "c1") %in% input$q3)) & 
           input$q4!="" & input$q5!="" & input$q6!="" & input$q7!="" & input$q8!="" & input$q9!=""){
            return(img(src="plot.jpg", width="90%"))
        }
    })

    observeEvent(input$clean, {
        v$calc = FALSE
        shinyjs::reset("side-panel")
    })
})