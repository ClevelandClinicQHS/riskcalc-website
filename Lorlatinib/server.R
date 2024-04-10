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
        validate(need(!is.na(input$age) & as.numeric(input$age) >= 18 & as.numeric(input$age) <= 100, "Please input a valid age."))
        
        # Make the input data frame
        data.frame(
          age = as.numeric(input$age),
          sex = input$sex == "Male",
          race = input$race == "Asian",
          ethnicity = input$ethnicity == "Other Ethnicity",
          metastasis = input$metastasis == "Yes",
          smoking = input$smoking == "Current/Former",
          ecog = input$ecog == "1 or 2"
        )
        
      }
    )
  output$temp <- renderTable({
    data()
    })
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
              HTML("<p>Progression-free survival<sup>a</sup></p>"),
              HTML("<p>Central Nervous System (CNS) Effects<sup>b+</sup></p>"),
              HTML("<p>Hyperlipidemia<sup>c</sup></p>"),
              HTML("<p>Weight Gain<sup>b</sup></p>"),
              HTML("<p>Edema<sup>b</sup></p>"),
              HTML("<p>Peripheral Neuropathy<sup>b</sup></p>"),
              HTML("<p>Any G3/G4 Event<sup>b</sup></p>")
            ),
          Estimate = 
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
      
      # Make conditional output
      temp_results$Estimate <- with(temp_results, ifelse(Estimate > .999, ">99.9%", ifelse(Estimate < 0.001, "<0.1%", paste0(sprintf("%.1f", 100*Estimate), "%"))))
      
      # Format the table
      DT::datatable(
        temp_results,
        caption =
          tags$caption(
            style="caption-side: bottom; text-align: left; margin: 8px 0; font-size: 14px",
            HTML("<p>5-year survival<sup>a</sup>,&nbsp&nbsp5-year risk<sup>b</sup>,&nbsp&nbsp1-year risk<sup>c</sup>;&nbsp&nbsp CNS effects include speech, psychotic, cognitive, and mood<sup>+</sup></p>")
          ),
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
            }"),
            columnDefs = list(list(className = 'dt-center', targets = 1))
          ),
        rownames = FALSE,
        escape= FALSE
      )
    }
    )
  
})