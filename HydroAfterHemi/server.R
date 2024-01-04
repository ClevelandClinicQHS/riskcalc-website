# Created: 2023-01-04
# Author: Alex Zajichek
# Project: Predicting hydrocephalus after hemispherectomy
# Description: Contains the app server

shinyServer(function(input, output, session){
  
  observeEvent(
    {list(input$onset_age)},
    {
      shinyjs::hide("result_panel")
    }
  )
  
  observeEvent(input$goButton, {shinyjs::show("result_panel")})
  
  # Get the data set
  data <- 
    eventReactive(
      input$goButton, 
      {
        # Validate the inputs
        validate(need(!is.na(input$onset_age) & input$onset_age >= 0 & input$onset_age <= 18, "Please input a valid age at seizure onset"))
        
        # Make a data frame
        data.frame(Result = "Probability of hydrocephalus (RANDOM NUMBER)", Probability = paste0(round(runif(1) * 100, 1), "%"))
      }
    )
  
  # Make result table
  output$result <-
    DT::renderDataTable({
      data()
    },
    options = 
      list(
        pageLength = 10,
        lengthMenu = 0,
        searching = 0,
        processing = 0,
        info = 0,
        paging = 0,
        initComplete = I(
          "function(settings, json) {
                    $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
            }")
      )
    )
  
})