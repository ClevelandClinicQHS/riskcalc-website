# Define probability score
dm2nfs <- function(age, htn, ckd, antihpl, plt, ast){
  lp <- 7 + 0.0329 * ((age^2)/100) - 0.4249 * (htn == "Yes") + 0.7041 * (ckd == "Yes") - 0.4190 * (antihpl == "Yes") - 1.3766 * log(plt) - 0.3093 * (100/ast)
  
  round((exp(lp)/(1+exp(lp)))*100, digits = 1)
}

# Define server logic required to generate score
shinyServer(function(input, output) {
    
    output$result <- renderDataTable({
        result = data.frame(
            Result = "DLFS",
            Probability = paste(dm2nfs(input$age, input$htn, input$ckd, input$antihpl, input$plt, input$ast), "%", sep = "")
        ) 
        result
    }, options = list(
        pageLength = 5,
        lengthMenu = 0,
        searching = FALSE,
        info = 0,
        paging = 0,
        processing = 0,
        initComplete = I(
            "function(settings, json) {
                    $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
            }")))
})
