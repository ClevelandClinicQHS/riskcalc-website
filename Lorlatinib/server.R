# Created: 2024-04-05
# Author: Alex Zajichek
# Project: Lorlatinib
# Description: Contains the app server

shinyServer(function(input, output, session){
  
  # Clear results when inputs change
  observeEvent(
    {list(input$age, input$sex, input$race, input$ethnicity, input$metastasis, input$smoking, input$ecog)},
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
        
        # Validate the age input
        validate(need(!is.na(input$age) & as.numeric(input$age) >= 0 & as.numeric(input$age) <= 100, "Please input a valid age."))
        
        # Make the input data frame
        data.frame(
          age = as.numeric(input$age),
          sex = input$sex == "Female",
          race = input$race == "White",
          ethnicity = input$ethnicity == "Not Hispanic or Latino",
          metastasis = input$metastasis == "No",
          smoking = input$smoking == "Never",
          ecog = input$ecog == "1 or 2"
        )
        
      }
    )
  
  # Make result table
  output$result <-
    DT::renderDataTable({
      
      # Get the prediction set
      pred_set <- data()
      
      # Make result table
      temp_results <-
        data.frame(
          Outcome = 
            c(
              "Progression",
              "CNS",
              "Hyperlipidemia",
              "Weight Gain",
              "Edema",
              "Peripheral Neuropathy",
              "Any G3/G4 Event"
            ),
          Risk = 
            c(
              with(pred_set, f_progression(age, sex, race, ethnicity, metastasis, smoking, ecog)),
              with(pred_set, f_cns(age, sex, race, ethnicity, metastasis, smoking, ecog)),
              with(pred_set, f_hyperlipidemia(age, sex, race, ethnicity, metastasis, smoking, ecog)),
              with(pred_set, f_weight(age, sex, race, ethnicity, metastasis, smoking, ecog)),
              with(pred_set, f_edema(age, sex, race, ethnicity, metastasis, smoking, ecog)),
              with(pred_set, f_peripheral(age, sex, race, ethnicity, metastasis, smoking, ecog)),
              with(pred_set, f_g3g4(age, sex, race, ethnicity, metastasis, smoking, ecog))
            )
        )
      
      # Format the table
      DT::formatPercentage(
        DT::datatable(
          temp_results,
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
        ), 
        columns = "Risk", 
        digits = 2
      )
    }
    )
  
})