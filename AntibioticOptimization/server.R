# Created: 2024-02-05
# Author: Alex Zajichek
# Project: GUKI Antibiotic Optimization
# Description: Contains the app server

shinyServer(function(input, output, session){
  
  # Hide the results when the age is changed/removed
  observeEvent(
    {list(input$age)},
    {
      shinyjs::hide("result_panel")
    }
  )
  
  # Show the results when the button is pressed
  observeEvent(input$goButton, {shinyjs::show("result_panel")})
  
  # Get the input data set
  data <- 
    eventReactive(
      input$goButton, 
      {
        # Validate the inputs
        validate(need(!is.na(input$age) & input$age >= 18, "Please enter an age 18 years or older."))
        
        # Make a data frame
        data.frame(
          AnyOrganism_DaysSincePreviousResistance = as.factor(input$days_since_resistance),
          DepartmentSpecialty = as.factor(input$specialty),
          Facility = as.factor(input$facility),
          ORGANISM_HX_112283007 = as.factor(input$hx_ecoli),
          CollectionMethod = as.factor(input$collection),
          LivingArrangement = as.factor(input$living_arrangement),
          MobilityStatus = as.factor(input$mobility),
          Age = input$age,
          Sex = as.factor(input$sex),
          Ampicillin_HX = as.factor(input$hx_ampicillin),
          Cefazolin_HX = as.factor(input$hx_cefazolin),
          cefepime_HX = as.factor(input$hx_cefepime),
          Ceftriaxone_HX = as.factor(input$hx_ceftriaxone),
          Ciprofloxacin_HX = as.factor(input$hx_ciprofloxacin),
          Gentamicins_HX = as.factor(input$hx_gentamicins),
          meropenem_HX = as.factor(input$hx_meropenem),
          Nitrofurantoin_HX = as.factor(input$hx_nitrofurantoin),
          piperacillin_tazobactam_combination_HX = as.factor(input$hx_piperacillin),
          Trimethoprim_Sulfamethoxazole_Combination_HX = as.factor(input$hx_trimethoprim),
          Vancomycin_HX = as.factor(input$hx_vancomycin)
        )
        
      }
    )
  
  # Make result table
  output$result <-
    DT::renderDataTable({
      
      # Get the predicted values for each antibiotic
      temp_pred <- get_predictions(data())
      
      # Make the data table
      temp_dt <- 
        DT::datatable(
          temp_pred,
          options = 
            list(
              pageLength = 100,
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
      
      # Convert to percentage
      DT::formatPercentage(temp_dt, columns = c("Susceptibility", "Resistance"))
      
    })
  
})