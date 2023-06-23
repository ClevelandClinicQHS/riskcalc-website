library(shiny)
library(DT, lib.loc = "/home/ubuntu/R/x86_64-pc-linux-gnu-library/3.2/yaml/libs")
library(dplyr)


    
shinyServer(function(input, output, session) {
    
    data <- reactive({
        invalidateLater(1000*60, session)
        load(".RData")
        df
    })
    
    output$table <- DT::renderDataTable(DT::datatable({
        data()
    }, filter = "top", selection = "multiple", rownames = F, extensions = 'ColVis', 
    options = list(autoWidth = TRUE, dom = 'C<"clear">lfrtip',
                   colVis = list(activate = 'mouseover'))))
    
    output$downloadData <- downloadHandler(
        filename = "demo.csv",
        content = function(file) {
            s = input$table_rows_all
            write.csv(data()[s, ,drop = F], file)
        }
    )
    
    summary <- reactive({
        s <- input$table_rows_all
        dat <- data()[s, , drop = F]
        if (input$sex == "Yes"){
            grp = group_by(dat, gender)
            summary = summarise(grp, mean = mean(bmi), sd = sd(bmi))
        } else {
            summary = summarise(dat, mean = mean(bmi), sd = sd(bmi))
        }
    })
    
    output$summary <- DT::renderDataTable(DT::datatable({
        summary()
    }))
    
    output$downloadSummary <- downloadHandler(
        filename = "demo_summary.csv",
        content = function(file) {
            s = input$table_rows_all
            write.csv(summary(), file)
        }
    )
    
})

   

