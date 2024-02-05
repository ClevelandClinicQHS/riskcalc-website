# Created: 2024-02-05
# Author: Alex Zajichek
# Project: GUKI Antibiotic Optimization
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
        validate(need(!is.na(input$age), "Please input a valid age."))
        
        # Make antibiotic list
        antibiotics <- 
          c(
            "Trimethoprim-Sulfamethoxazole Combination",
            "Nitrofurantoin",
            "Ciprofloxacin",
            "Cefazolin",
            "Ceftriaxone",
            "Ampicillin",
            "piperacillin-tazobactam combination",
            "Vancomycin",
            "cefepime",
            "meropenem",
            "Gentamicins"
          )
        
        # Make a data frame
        temp_dat <- 
          data.frame(
            Antibiotic = antibiotics,
            Susceptability = runif(length(antibiotics))
          )
        
        # Add the resistance probability
        temp_dat$Resistance <- 1 - temp_dat$Susceptability
        
        # Clean the format
        temp_dat$Susceptability <- round(temp_dat$Susceptability * 100, 1)
        temp_dat$Resistance <- round(temp_dat$Resistance * 100, 1)
        
        temp_dat
        
      }
    )
  
  # Make result table
  output$result <-
    DT::renderDataTable({
      data()
    },
    options = 
      list(
        pageLength = 100,
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