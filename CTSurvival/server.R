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
        
        # Make the data frame
        input_dat <- 
          data.frame(
            L1BMDmultiHU = as.numeric(input$L1BMDmultiHU),
            AbdominalAgatston = as.numeric(input$AbdominalAgatston),
            L3SATArea = as.numeric(input$L3SATArea),
            L3VATMedianHU = as.numeric(input$L3VATMedianHU),
            L3VATSATRatio = as.numeric(input$L3VATSATRatio),
            KidneyVolume = as.numeric(input$KidneyVolume),
            L3MuscleArea = as.numeric(input$L3MuscleArea),
            L3MuscleMeanHU = as.numeric(input$L3MuscleMeanHU)
          )
        
        # Ensure inputs fall in the correct range
        shiny::validate(
          need(!is.na(input_dat$L1BMDmultiHU) & input_dat$L1BMDmultiHU >= -50 & input_dat$L1BMDmultiHU <= 1200, "L1BMDmultiHU must be between -50 and 1200."),
          need(!is.na(input_dat$AbdominalAgatston) & input_dat$AbdominalAgatston >= 0 & input_dat$AbdominalAgatston <= 30000, "AbdominalAgatston must be between 0 and 30000."),
          need(!is.na(input_dat$L3SATArea) & input_dat$L3SATArea >= 0.1 & input_dat$L3SATArea <= 1000, "L3SATArea must be between 0.1 and 1000."),
          need(!is.na(input_dat$L3VATMedianHU) & input_dat$L3VATMedianHU >= -120 & input_dat$L3VATMedianHU <= -30, "L3VATMedianHU must be between -120 and -30."),
          need(!is.na(input_dat$L3VATSATRatio) & input_dat$L3VATSATRatio >= -1 & input_dat$L3VATSATRatio <= 4.5, "L3VATSATRatio must be between -1 and 4.5."),
          need(!is.na(input_dat$KidneyVolume), "Please enter a numeric value for KidneyVolume"),
          need(!is.na(input_dat$L3MuscleArea) & input_dat$L3MuscleArea >= 25 & input_dat$L3MuscleArea <= 500, "L3MuscleArea must be between 25 and 500."),
          need(!is.na(input_dat$L3MuscleMeanHU) & input_dat$L3MuscleMeanHU >= -50 & input_dat$L3MuscleMeanHU <= 200, "L3MuscleMeanHU must be between -50 and 200.")
        )
        
        # Return the data
        input_dat
        
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