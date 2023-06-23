#Created: 2019-08-21
#Author: Alex Zajichek
#Project: Sparing or resecting the hippocampus
#Description: Carries out the functionality of the application

#Load packages
require(shiny)
require(shinythemes)
require(DT)
require(dplyr)

function(input, output, session) {
  
  #Compute risks
  preop <-
    reactive(
      {
        tibble(
          Spared =
            -0.59790341*(input$mri == "Abnormal") +
            0.46544472*(input$side == "Non-dominant") +
            -0.02841177*input$age +
            0.07207140*(input$age - input$duration)
        ) %>%
          mutate(
            Resected =
              Spared +
              -0.53608535 + #Main effect
              -1.17566251*(input$side == "Non-dominant") +
              0.03906362*input$age +
              -0.06634345*(input$age - input$duration)
          ) %>%
          
          #Convert to survival risk
          mutate_all(
            list(
              ~
                exp(-0.80903974)^exp(.) #1-year survival
            )
          )
        
      }
    )
  
  postop <-
    reactive(
      {
        tibble(
          Spared =
            1.73259444*(input$acuteseizures == "Yes") +
            -0.75456307*(input$mri == "Abnormal") +
            0.80194568*(input$side == "Non-dominant") +
            -0.80745423*(input$pathology == "Abnormal") +
            -0.01918398*input$age +
            0.04941476*(input$age - input$duration) +
            0.61966497*(input$gender == "Male")
        ) %>%
          mutate(
            Resected =
              Spared +
              -1.16634464 + #Main effect
              -1.61024074*(input$side == "Non-dominant") +
              1.43243216*(input$pathology == "Abnormal") +
              0.02978050*input$age +
              -0.03507803*(input$age - input$duration)
          ) %>%
          
          #Convert to survival risk
          mutate_all(
            list(
              ~
                exp(-0.662438903)^exp(.) #1-year survival
            )
          )
      }
    )
  
  #Naming decline
  naming <-
    reactive(
      {
        
        #Get linear predictor
        lp <- 
          -3.802 +
          0.048*(input$age - input$duration) +
          2.644*(input$side == "Dominant") +
          0.015*input$age +
          0.367*(input$gender == "Female") +
          -0.049*input$education
        
        #Compute risk
        1 / (1 + exp(-lp))
        
      }
    )
  
  #Make table react to button
  showTable <-
    eventReactive(
      input$run,
      {
        
        #Check for valid inputs
        shiny::validate(
          need(
            expr = input$age >= input$duration,
            message = "Age of epilepsy onset must be less than current age"
          )
        )
        
        #Get table
        if(input$postop) {
          
          table1 <- postop()
          
        } else {
          
          table1 <- preop()
          
        }
        
        list(
          table1,
          tibble(
            `Risk (%)` = naming()
          )
        )
        
      }
    )
  
  output$table <-
    renderDataTable({
      
      showTable()[[1]] %>%
        mutate_all(
          list(
            ~
              paste0(round(.*100, 1), "%")
          )
        ) %>%
        tidyr::gather(
          key = "Treatment",
          value = "Chance of seizure freedom 1-year after surgery (%)"
        ) %>%
        datatable(
          options = 
            list(
              searching = FALSE,
              paging = FALSE,
              columnDefs = list(list(className = "dt-center", targets = "_all")),
              info = FALSE
            ),
          rownames = FALSE,
          escape = F
        )
      
    })
  
  output$table2 <-
    renderDataTable({
      
      showTable()[[2]] %>%
        mutate_all(
          list(
            ~
              paste0(round(.*100, 1), "%")
          )
        ) %>%
        datatable(
          options = 
            list(
              searching = FALSE,
              paging = FALSE,
              columnDefs = list(list(className = "dt-center", targets = "_all", width = "25px")),
              info = FALSE
            ),
          rownames = FALSE,
          escape = F
        )
      
    })
  
}