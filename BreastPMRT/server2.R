#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(purrr)
library(ggplot2)
library(riskRegression)
library(prodlim)
library(tibble)
library(tidyr)

# Load the model fits from the server
load("PMRT_nomogram_v2_fgr_results_shiny.rda")


# helper functions
cloglog <- function(x) log(-log(1 - x))
inv_cloglog <- function(x) 1 - exp(-exp(x))


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Take the input variables and create a dataframe
  # Then create dummy variables for use in the model
  # Expand grid over both values of RT for plotting purposes
  newdat = reactive({
    
    expand.grid(
      rt = c("No", "Yes"),
      age_at_diagnosis = input$age_at_diagnosis,
      pathologic_tumor_size_cm = input$pathologic_tumor_size_cm,
      grade_bin = input$grade_bin,
      n_ln_pos_bin = ifelse(input$number_ln_positive %in% c(1, 2), "1/2", "3"),
      nodal_ratio = as.numeric(input$number_ln_positive) / input$number_ln_sampled,
      lvi = input$lvi,
      er_pr = input$er_pr,
      her2_status = input$her2_status,
      tumor_quadrant_bin = input$tumor_quadrant_bin,
      optimal_systemic_therapy = input$optimal_systemic_therapy
    ) %>% 
      mutate(
        rt_yes = ifelse(rt == "Yes", 1, 0),
        grade3 = ifelse(grade_bin == "III", 1, 0),
        number_ln_positive3 = ifelse(n_ln_pos_bin == "3", 1, 0),
        lvi_yes = ifelse(lvi == "Yes", 1, 0),
        er_pr_pos = ifelse(er_pr == "ER+ or PR+", 1, 0),
        her2_status_pos = ifelse(her2_status == "Positive", 1, 0),
        tumor_quadrant_inner = ifelse(tumor_quadrant_bin == "Inner", 1, 0),
        optimal_systemic_therapy_yes = ifelse(optimal_systemic_therapy == "Yes",1 , 0),
        # The old version of riskRegression that works in R 3.4.3 requires the time and event variables be in the dataset. It's okay if they are all set to 0, and I checked that this does not impact the predictions in any way.
        lr_yrs = 0,
        lr_cmp_event = 0,
        dm_yrs = 0,
        dm_cmp_event = 0,
        any_rcr_yrs = 0,
        any_rcr_cmp_event = 0,
        os_yrs = 0,
        bcm_cmp_event = 0
      )
    
  })
  
  
  # Get predictions for each of the model fits
  # Apply the complementary log-log transformation
  # Average the predictions
  # Then back transform the averaged predictions
  # Do this for each year between 0 and 20 years
  preds_lr = reactive({
    
    inv_cloglog(
      map(
        lr_fgr_shiny,
        ~predictRisk(
          object = .x,
          newdata = newdat(),
          times = seq(0, 10, 1),
          cause = 1
        )
      ) %>% 
        map(cloglog) %>% 
        reduce(`+`) / 20
    )
    
  })
  
  preds_dm = reactive({
    
    inv_cloglog(
      map(
        dm_fgr_shiny,
        ~predictRisk(
          object = .x,
          newdata = newdat(),
          times = seq(0, 10, 1),
          cause = 1
        )
      ) %>% 
        map(cloglog) %>% 
        reduce(`+`) / 30
    )
    
  })
  
  preds_any_rcr = reactive({
    
    inv_cloglog(
      map(
        any_rcr_fgr_shiny,
        ~predictRisk(
          object = .x,
          newdata = newdat(),
          times = seq(0, 10, 1),
          cause = 1
        )
      ) %>% 
        map(cloglog) %>% 
        reduce(`+`) / 30
    )
    
  })
  
  preds_bcm = reactive({
    
    inv_cloglog(
      map(
        bcm_fgr_shiny,
        ~predictRisk(
          object = .x,
          newdata = newdat(),
          times = seq(0, 10, 1),
          cause = 1
        )
      ) %>% 
        map(cloglog) %>% 
        reduce(`+`) / 20
    )
    
  })
  
  # Make a smoothed plot of the predictions separately for PMRT no and yes
  output$predPlot <- renderPlot({
    
    cbind(
      preds_lr(),
      preds_dm(),
      preds_any_rcr(),
      preds_bcm()
    ) %>% 
      t() %>% 
      as.data.frame() %>% 
      add_column(time = rep(seq(0, 10, 1), 4)) %>% 
      add_column(outcome = 
                   c(rep("Local recurrence", 11), 
                     rep("Distant recurrence", 11), 
                     rep("Any recurrence", 11), 
                     rep("Breast cancer mortality", 11))
      ) %>% 
      pivot_longer(cols = V1:V2,
                   names_to = "PMRT", 
                   names_prefix = "V",
                   values_to = "pred") %>% 
      mutate(PMRT = ifelse(PMRT == 1, "No", "Yes"),
             outcome = 
               forcats::fct_relevel(outcome, 
                                    "Local recurrence", 
                                    "Distant recurrence", 
                                    "Any recurrence", 
                                    "Breast cancer mortality")
      ) %>% 
      ggplot(aes(x = time, y = pred, color = PMRT)) + 
      geom_smooth(se = FALSE, method = "loess") +
      facet_wrap(~outcome) +
      theme_classic() +
      theme(legend.position = "bottom") +
      labs(y = "Predicted risk", 
           x = "Years from 6-months post-mastectomy") + 
      #scale_color_manual(values = ezfun::ccf_palette("contrast")) +
      ylim(c(0, 0.4)) + 
      scale_y_continuous(labels = scales::percent)
  })
  
  # Print a table of the 5-year and 10-year predictions
  output$predTab <- renderTable({
    
    cbind(
      preds_lr()[ifelse(input$rt == "No", 1, 2), c(6, 11)],
      preds_dm()[ifelse(input$rt == "No", 1, 2), c(6, 11)],
      preds_any_rcr()[ifelse(input$rt == "No", 1, 2), c(6, 11)],
      preds_bcm()[ifelse(input$rt == "No", 1, 2), c(6, 11)]
    ) %>% 
      t() %>% 
      as.data.frame() %>% 
      add_column(
        Outcome = 
          c(
            "Local recurrence", 
            "Distant recurrence",
            "Overall recurrence",
            "Breast cancer mortality"
          )
      ) %>% 
      select(Outcome, V1, V2) %>% 
      mutate(V1 = paste0(round(V1*100, 1), "%"),
             V2 = paste0(round(V2*100, 1), "%")) %>% 
      rename("5 years" = V1,
             "10 years" = V2)
    
  },
  
  digits = 3
  
  )
  
})