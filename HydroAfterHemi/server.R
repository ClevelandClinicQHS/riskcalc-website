# Created: 2024-01-04
# Author: Alex Zajichek
# Project: Predicting hydrocephalus after hemispherectomy
# Description: Contains the app server

shinyServer(function(input, output, session){
  
  # Clear results when inputs change
  observeEvent(
    {list(input$age, input$sex, input$surgery_date, input$onset_age, input$brain_volume_pre, input$brain_volume_post, input$technique, input$previous_surgery, input$sagittal, input$complications, input$blood_loss, input$infection, input$aseptic_meningitis, input$evd)},
    {
      shinyjs::hide("result_panel")
    }
  )
  
  # Show the results when the button is pressed
  observeEvent(input$goButton, {shinyjs::show("result_panel")})
  
  ## Compute calculated values
  
  # Age at surgery
  age_at_surgery <- 
    reactive({
      
      # Ensure an age is entered
      validate(need(!is.na(input$age), "Please input the current age."))
      validate(need(!is.na(input$surgery_date), "Please input the date of surgery."))
      
      # Compute the years since surgery
      years_since_surgery <- round(as.numeric(difftime(Sys.Date(), input$surgery_date, units = "days")) / 365.25)
      
      # Now compute the age at surgery
      surgery_age <- input$age - years_since_surgery
      
      # Ensure it is in the appropriate range
      validate(need(surgery_age >= 0 & surgery_age <= 21, "Age at surgery must be between 0 and 21 years."))
      
      surgery_age
      
    })
  
  # Percent of life with epilepsy
  life_with_epilepsy <-
    reactive({
      
      # Ensure the onset age is <= current age
      validate(need(!is.na(input$onset_age), "Please input the age at seizure onset."))
      validate(need(input$onset_age <= age_at_surgery(), "Age at seizure onset must be less than or equal to the age at surgery."))
      
      (age_at_surgery() - input$onset_age) / age_at_surgery()
      
    })
  
  # Percent of brain resected
  brain_resected <-
    reactive({
      
      # Ensure valid entries
      validate(need(!is.na(input$brain_volume_pre) & !is.na(input$brain_volume_post), "Please enter pre/post op brain volumes."))
      validate(need(input$brain_volume_post <= input$brain_volume_pre, "Post-op brain volume must be less than or equal to the pre-op volume."))
      
      (input$brain_volume_pre - input$brain_volume_post) / input$brain_volume_pre
      
    })
  
  # Get the data set
  data <- 
    eventReactive(
      input$goButton, 
      {
        # Make the input data frame
        data.frame(
          Sex = input$sex,
          Age = age_at_surgery(),
          PercentOfLifeWithEpilepsy = life_with_epilepsy(),
          PreOpBrainVolume = input$brain_volume_pre,
          PercentOfBrainResected = brain_resected(),
          Technique = input$technique,
          PreviousSurgery = ifelse(input$previous_surgery, "Yes", "No"),
          SagittalSinusDisruption = ifelse(input$sagittal, "Yes", "No"),
          SurgicalComplications = ifelse(input$complications, "Yes", "No"),
          BloodLoss = ifelse(input$blood_loss, "Yes", "No"),
          Infection = ifelse(input$infection, "Yes", "No"),
          AsepticMeningitis = ifelse(input$aseptic_meningitis, "Yes", "No"),
          EVD = ifelse(input$evd, "Yes", "No")
        )
        
      }
    )
  
  # Make result table
  output$result <-
    DT::renderDataTable({
      
      # Compute the risk
      risk <- 1 - exp(-base_haz1 * exp(predict(prod_model$Model, newdata = data())))
      
      data.frame(
        Result = "Risk of hydrocephalus within 1-year of surgery",
        Value = paste0(round(risk * 100, 2), "%")
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