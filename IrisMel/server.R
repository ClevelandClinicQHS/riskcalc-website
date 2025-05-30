#---% Generated by riskcalc: feel free to edit or 'Run App' %---
server <-
  
  # Define the server
  function(input, output, session) {
    
    # Make a reactive input data frame
    newdat <-
      eventReactive(
        input$run_calculator, {
          
          tibble(
            quadrant_cats = input$quadrant,
            lbd = input$lbd,
            height = input$height,
            color_cats = "Melanotic",
            margins = "Sharp",
            pigment_dispersion = as.numeric(input$pigment_dispersion),
            vascularity_cats = as.numeric(input$feeder_intrinsic),
            iris_location = input$iris_location,
            ectropion_correctopia = as.numeric(input$ectropion_corectopia),
            angle_cbd = as.numeric(input$angle_cbd)
          ) %>%
            # Need to specify all levels for the factor variables
            mutate(
              quadrant_cats = factor(quadrant_cats, levels = c("Inferior-temporal", 
                                                               "Superior-nasal",    
                                                               "Superior-temporal", 
                                                               "Inferior-nasal")),
              color_cats = factor(color_cats, levels = c("Melanotic", 
                                                         "Partial", 
                                                         "Amelanotic")),
              margins = factor(margins, levels = c("Not defined", 
                                                   "Sharp", 
                                                   "Feathery")),
              iris_location = factor(iris_location, levels = c("Peripheral", 
                                                               "Pupillary", 
                                                               "Central", 
                                                               "Pan iris"))
            )
          
        })
    
    # Get predictions
    pred_mel = reactive({
      predict(
        object = fit1, 
        data = newdat())
    })
    
    # Show result
    output$result <-
      renderDataTable(
        {
          
          # Make the data frame containing results
          data.frame(Result = "Predicted probability of melanoma", Value = paste0(round(pred_mel()*100, 1), "%"))
          
        },
        options =
          list(
            pageLength = 10,
            lengthMenu = 0,
            searching = 0,
            info = 0,
            paging = 0,
            initComplete =
              DT::JS(
                "function(settings, json) {
                    $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
                  }"
              )
          ),
        rownames = FALSE
      )
    
  }
