shinyServer(function(input, output, session){
  
  # Clear results when inputs change
  observeEvent(
    {list(input$age, input$sex, input$surgery_date, input$onset_age, input$brain_volume_pre, input$brain_volume_post)},
    {
      shinyjs::hide("result_panel")
    }
  )
  
  # Show the results when the button is pressed
  observeEvent(input$goButton, {shinyjs::show("result_panel")})
  
  # Get the data set
  data <- 
    eventReactive(
      input$goButton, 
      {
        # Make the input data frame
        data.frame(
          L1BMDmultiHU = input$L1BMDmultiHU,
          AbdominalAgatston = input$AbdominalAgatston,
          L3SATArea = input$L3SATArea,
          L3VATMedianHU = input$L3VATMedianHU,
          L3VATSATRatio = input$L3VATSATRatio,
          KidneyVolume = input$KidneyVolume,
          L3MuscleArea = input$L3MuscleArea,
          L3MuscleMeanHU = input$L3MuscleMeanHU
        )
        
      }
    )
  
  # Make result table
  output$result <-
    DT::renderDataTable({
      
      # Compute the risk
      risk <- 1 - exp(-base_haz10 *  exp(predict(ct.fit2, newdata = data())))
      
      data.frame(
        Result = "10-year risk of death",
        Value = paste0(round(risk * 100, 1), "%")
      )
    },
    options = 
      list(
        pageLength = 10,
        lengthMenu = 0,
        searching = 0,
        processing = 0,
        info = 0,
        paging = 0,
        initComplete = DT::JS(
          "function(settings, json) {
                    $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
            }")
      ),
    rownames = FALSE
    )
  
})