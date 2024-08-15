# Created: 2024-07-22
# Author: Alex Zajichek
# Project: Risk of dying from prostate cancer
# Description: Contains the app server

shinyServer(function(input, output, session){
  
  ## Site navigation with buttons
  
  # Directions -> Life expectancy
  observeEvent(
    input$start, {
      updateTabsetPanel(
        session,
        inputId = "main",
        selected = "life_expectancy"
      )
    }
  )
  
  # Life expectancy -> Prostate cancer
  observeEvent(
    input$nextPage1, {
      updateTabsetPanel(
        session,
        inputId = "main",
        selected = "prostate_cancer"
      )
    }
  )
  
  # Prostate cancer -> Results
  observeEvent(
    input$nextPage2, {
      updateTabsetPanel(
        session,
        inputId = "main",
        selected = "results"
      )
    }
  )
  
  # Pre-op BCR
  preop_bcr <-
    reactive({
      
      # Get the linear predictor
      lp <-
        6.89129254 +
        
        # Grade
        -1.00336248 * (input$s5_q5 == "3+4") +
        -2.13598293 * (input$s5_q5 == "4+3") +
        -2.67572871 * (input$s5_q5 == "8") +
        -2.96947204 * (input$s5_q5 %in% c("9", "10")) +
        
        # Stage
        -0.41919179 * (input$s5_q2 == "T2A: tumor in half or less than half of one of the prostate lobes") +
        -0.93241185 * (input$s5_q2 == "T2B: tumor in more than half of one lobe, but not both") +
        -0.7776788 * (input$s5_q2 == "T2C: tumor in both lobes but within prostatic capsule") +
        -1.20656131 * (input$s5_q2 %in% c("T3: tumor has spread through the prostatic capsule", "T4: tumor invaded other nearby structures")) +
        
        # Age
        -0.00667038 * input$s5_q1 +
        
        # PSA
        -0.42086984 * input$s5_q6 +
        0.00325414 * 
        (
          max(input$s5_q6 - 0.2, 0)^3 - 
            max(input$s5_q6 - 7.33, 0)^3 * ((307 - 0.2) / (307 - 7.33)) +
            max(input$s5_q6 - 307, 0)^3 * ((7.33 - 0.2) / (307 - 7.33))
        ) +
        -0.00890319 * 
        (
          max(input$s5_q6 - 4.8, 0)^3 -
            max(input$s5_q6 - 7.33, 0)^3 * ((307 - 4.8) / (307 - 7.33)) +
            max(input$s5_q6 - 307, 0)^3 * ((7.33 - 4.8) / (307 - 7.33))
        )
      
      # Compute the 15 year risk
      1 / (1 + (15 * exp(-lp))^1.11545625)
      
    })
  
  # Indicate if disqualified
  gets_prediction <-
    reactive({
      
      # Cannot have N1 or M1
      if(input$s5_q3 == "I have metastatic disease M1" || input$s5_q4 == "I have cancer in my lymph nodes N1") {
        
        FALSE
        
      } else {
        
        TRUE
        
      }
      
    })
  
  # Adjusted age value
  adjusted_age <-
    reactive({
      
      # Get the age value
      age_value <-
        filter(
          age_lookup,
          Age == input$s5_q1
        )$Value
      
      # Compute the adjusted age value
      (1 - age_value) / age_value
      
    })
  
  ## Comorbidities
  
  # Cholesterol
  high_ldl <- 
    reactive({
      
      # Default value
      value <- FALSE
      
      # Check response
      if(!is.null(input$s4_q2)) {
        
        if(input$s4_q2 == "High (>270 mg/dL)") {
          
          # Append conditions 
          health_conditions$string <- c(isolate(health_conditions$string), "High LDL")
          
          value <- TRUE
          
        }
        
      }
      
      value
      
      
    }) # ASKS ABOUT TOTAL!!!!!
  
  low_hdl <- 
    reactive({
      
      # Default value
      value <- FALSE
      
      # Check response
      if(!is.null(input$s4_q3)) {
        
        if(input$s4_q3 == "Extremely Low (<20 mg/dL)") {
          
          # Append conditions 
          health_conditions$string <- c(isolate(health_conditions$string), "Low LDL")
          
          value <- TRUE
          
        }
        
      }
      
      value
      
    })
  
  # Angina
  angina <- 
    reactive({
      
      # Default value
      value <- 1
      
      # Check conditions
      if(!is.null(input$s1_q1a)) {
        
        if(input$s1_q1a == "Yes") {
          
          # Append conditions 
          health_conditions$string <- c(isolate(health_conditions$string), "Angina")
          
          # High LDL
          if(high_ldl()) {
            
            # Low LDL
            if(low_hdl()) {
              
              value <- get_OR("OddsRatios_Angina_CH_15")
              
            } else {
              
              value <- get_OR("OddsRatios_Angina_C_15")
              
            }
            
          } else {
            
            # Low LDL
            if(low_hdl()) {
              
              value <- get_OR("OddsRatios_Angina_H_15")
              
            } else {
              
              value <- get_OR("OddsRatios_Angina_15")
              
            }
            
          }
          
        }
        
      }
      
      value
      
    })
  
  # Heart Attack
  heart_attack <-
    reactive({
      
      # Default value
      value <- 1
      
      # Check conditions
      if(!is.null(input$s1_q1d)) {
        
        if(input$s1_q1d == "Yes") {
          
          # Append conditions 
          health_conditions$string <- c(isolate(health_conditions$string), "Heart Attack")
          
          # High LDL
          if(high_ldl()) {
            
            # Low LDL
            if(low_hdl()) {
              
              value <- get_OR("OddsRatios_Heart_CH_15")
              
            } else {
              
              value <- get_OR("OddsRatios_Heart_C_15")
              
            }
            
          } else {
            
            # Low LDL
            if(low_hdl()) {
              
              value <- get_OR("OddsRatios_Heart_H_15")
              
            } else {
              
              value <- get_OR("OddsRatios_Heart_15")
              
            }
            
          }
          
        }
        
      }
      
      value
      
    })
  
  # CHF
  chf <-
    reactive({
      
      # Default value
      value <- 1
      
      # Check condition
      if(!is.null(input$s1_q1c )) {
        
        if(input$s1_q1c == "Yes") {
          
          # Append conditions 
          health_conditions$string <- c(isolate(health_conditions$string), "CHF")
          
          value <- get_OR("OddsRatios_CHF_15")
          
        }
        
      }
      
      value
      
    })
  
  # Aortic stenosis
  aortic_stenosis <- 
    reactive({
      
      # Default value
      value <- 1
      
      # Check conditions
      if(!is.null(input$s1_q1e)) {
        
        if(input$s1_q1e == "Yes") {
          
          # Append conditions 
          health_conditions$string <- c(isolate(health_conditions$string), "Aortic stenosis")
          
          # High LDL
          if(high_ldl()) {
            
            # Low LDL
            if(low_hdl()) {
              
              value <- get_OR("OddsRatios_Aortic_CH_15")
              
            } else {
              
              value <- get_OR("OddsRatios_Aortic_C_15")
              
            }
            
          } else {
            
            # Low LDL
            if(low_hdl()) {
              
              value <- get_OR("OddsRatios_Aortic_H_15")
              
            } else {
              
              value <- get_OR("OddsRatios_Aortic_15")
              
            }
            
          }
          
        }
        
      }
      
      value
      
    })
  
  # Atrial fibrillation
  afib <- 
    reactive({
      
      # Default value
      value <- 1
      
      # Check condition
      if(!is.null(input$s1_q1f)) {
        
        if(input$s1_q1f == "Yes") {
          
          # Append conditions 
          health_conditions$string <- c(isolate(health_conditions$string), "AFib")
          
          value <- get_OR("OddsRatios_Atrial_15")
          
        }
        
      }
      
      value
      
    })
  
  # Abdominal aortic aneurysm (NOT A QUESTION!!!!)
  aaa <- 
    reactive({
      
      # Default value
      value <- 1
      
      # Check condition
      if(!is.null(input$s3_q1)) {
        
        if(input$s3_q1 == "Yes") {
          
          # Append conditions 
          health_conditions$string <- c(isolate(health_conditions$string), "Abdominal aortic aneurysm")
          
          value <- get_OR("OddsRatios_AAA_15")
          
        }
        
      }
      
      value
      
    })
  
  # Diabetes
  diabetes <- 
    reactive({
      
      # Default value
      value <- 1
      
      # Check conditions
      if(!is.null(input$s4_q6)) {
        
        if(input$s4_q6 == "Yes") {
          
          # Append conditions 
          health_conditions$string <- c(isolate(health_conditions$string), "Diabetes")
          
          if(!is.null(input$s4_q6a)) {
            
            if(input$s4_q6a == "0-5 years ago") {
              
              value <- get_OR("OddsRatios_DIA_0_5_15")
              
            } else if(input$s4_q6a == "6-10 years ago") {
              
              value <- get_OR("OddsRatios_DIA_6_10_15")
              
            } else if(input$s4_q6a == "11-20 years ago") {
              
              value <- get_OR("OddsRatios_DIA_11_20_15")
              
            } else if(input$s4_q6a == ">20 years ago") {
              
              value <- get_OR("OddsRatios_DIA_21_15")
              
            }
            
          }
          
        }
        
      }
      
      value
      
    })
  
  # Peripheral vascular disease
  pvd <-
    reactive({
      
      # Default value
      value <- 1
      
      # Check conditions
      if(!is.null(input$s3_q2)) {
        
        if(input$s3_q2 == "Yes") {
          
          # Append conditions 
          health_conditions$string <- c(isolate(health_conditions$string), "PVD")
          
          # High LDL
          if(high_ldl()) {
            
            # Low LDL
            if(low_hdl()) {
              
              value <- get_OR("OddsRatios_PVD_CH_15")
              
            } else {
              
              value <- get_OR("OddsRatios_PVD_C_15")
              
            }
            
          } else {
            
            # Low LDL
            if(low_hdl()) {
              
              value <- get_OR("OddsRatios_PVD_H_15")
              
            } else {
              
              value <- get_OR("OddsRatios_PVD_15")
              
            }
            
          }
          
        }
        
      }
      
      value
      
    })
  
  # Deep vein thrombosis
  dvt <-
    reactive({
      
      # Default value
      value <- 1
      
      # Check conditions
      if(!is.null(input$s3_q3)) {
        
        if(input$s3_q3 == "Yes") {
          
          # Append conditions 
          health_conditions$string <- c(isolate(health_conditions$string), "DVT")
          
          # High LDL
          if(high_ldl()) {
            
            # Low LDL
            if(low_hdl()) {
              
              value <- get_OR("OddsRatios_DVT_CH_15")
              
            } else {
              
              value <- get_OR("OddsRatios_DVT_C_15")
              
            }
            
          } else {
            
            # Low LDL
            if(low_hdl()) {
              
              value <- get_OR("OddsRatios_DVT_H_15")
              
            } else {
              
              value <- get_OR("OddsRatios_DVT_15")
              
            }
            
          }
          
        }
        
      }
      
      value
      
    })
  
  # Pulmonary embolism
  pe <- 
    reactive({
      
      # Default value
      value <- 1
      
      # Check conditions
      if(!is.null(input$s3_q4)) {
        
        if(input$s3_q4 == "Yes") {
          
          # Append conditions 
          health_conditions$string <- c(isolate(health_conditions$string), "Pulmonary embolism")
          
          # High LDL
          if(high_ldl()) {
            
            # Low LDL
            if(low_hdl()) {
              
              value <- get_OR("OddsRatios_PE_CH_15")
              
            } else {
              
              value <- get_OR("OddsRatios_PE_C_15")
              
            }
            
          } else {
            
            # Low LDL
            if(low_hdl()) {
              
              value <- get_OR("OddsRatios_PE_H_15")
              
            } else {
              
              value <- get_OR("OddsRatios_PE_15")
              
            }
            
          }
          
        }
        
      }
      
      value
      
    })
  
  # TIA
  tia <- 
    reactive({
      
      # Default value
      value <- 1
      
      # Check condition
      if(!is.null(input$s4_q7)) {
        
        if(input$s4_q7 == "Yes") {
          
          # Append conditions 
          health_conditions$string <- c(isolate(health_conditions$string), "TIA")
          
          value <- get_OR("OddsRatios_TIA_15")
          
        }
        
      }
      
      value
      
    })
  
  # Stroke (QUESTION ABOUT MULTI CHECK!!!!)
  stroke <- 
    reactive({
      
      # Default value
      value <- 1
      
      # Check conditions
      if(!is.null(input$s4_q8)) {
        
        if(input$s4_q8 == "Yes") {
          
          # Append conditions 
          health_conditions$string <- c(isolate(health_conditions$string), "Stroke")
          
          if(("Bleeding" %in% input$s4_q8a) | ("Unknown" %in% input$s4_q8a)) {
            
            value <- get_OR("OddsRatios_Hemo_15")
            
          } else if("Blood clot" %in% input$s4_q8a) {
            
            value <- get_OR("OddsRatios_Clot_15")
            
          }
          
        }
        
      }
      
      value
      
    })
  
  # Asthma
  asthma <- 
    reactive({
      
      # Default value
      value <- 1
      
      # Check conditions
      if(!is.null(input$s2_q1)) {
        
        if(input$s2_q1 == "Yes") {
          
          # Append conditions 
          health_conditions$string <- c(isolate(health_conditions$string), "Asthma")
          
          if(!is.null(input$s2_q1a)) {
            
            if(input$s2_q1a == "Mild = does not interfere with daily activities") {
              
              value <- get_OR("OddsRatios_AsthmaMild_15")
              
            } else if(input$s2_q1a == "Moderate = some interference") {
              
              value <- get_OR("OddsRatios_AsthmaMod_15")
              
            } else if(input$s2_q1a == "Severe = major impact") {
              
              value <- get_OR("OddsRatios_AsthmaSev_15")
              
            }
            
          }
          
        }
        
      }
      
      value
      
    })
  
  # Hypertension
  hypertension <- 
    reactive({
      
      # Default value
      value <- 1
      
      # Check conditions
      if(!is.null(input$s4_q4) & !is.null(input$s4_q5)) {
        
        if(input$s4_q4 == "High (>=160 mm Hg)") {
          
          if(input$s4_q5 == "High (>= 100 mm Hg)") {
            
            # Append conditions 
            health_conditions$string <- c(isolate(health_conditions$string), "Hypertension")
            
            value <- get_OR("OddsRatios_HypHigh_15")
            
          } else {
            
            value <- get_OR("OddsRatios_HypOther_15")
            
          }
          
        } else {
          
          value <- get_OR("OddsRatios_HypOther_15")
          
        }
        
      }
      
      value
      
    })
  
  # Smoker status
  smoker_status <- 
    reactive({
      
      # Default value
      value <- 1
      
      # Check conditions
      if(!is.null(input$s4_q1)) {
        
        if(input$s4_q1 == "Yes") {
          
          # Append conditions 
          health_conditions$string <- c(isolate(health_conditions$string), "Smoking more than 100 cigarettes")
          
          if(!is.null(input$s4_q1a)) {
            
            if(input$s4_q1a == "Yes") {
              
              value <- get_OR("OddsRatios_Curr_15")
              
            } else if(input$s4_q1a == "No") {
              
              value <- get_OR("OddsRatios_Former_15")
              
            }
            
          }
          
        }
        
      }
      
      value
      
    })
  
  # Comorbidity factor (product of comorbidities)
  comorbidity_factor <- 
    reactive({
      
      angina() *
        heart_attack() *
        chf() *
        aortic_stenosis() *
        afib() *
        aaa() *
        diabetes() *
        pvd() *
        dvt() *
        pe() *
        tia() *
        stroke() *
        asthma() *
        hypertension() * 
        smoker_status()
      
    })
  
  ## Risk estimates
  
  # Other cause mortality
  other_cause <-
    reactive({
      
      1 - 
        (
          1 - 
            (
              (
                comorbidity_factor() * adjusted_age()
              ) /
                (
                  1 + comorbidity_factor() * adjusted_age()
                )
            )
        )
      
    })
  
  # Untreated PS mortality (unadjusted)
  untreated_pca_mortality_unadjusted <- 
    reactive({
      
      untreated_pca_lookup$Value[untreated_pca_lookup$PreOpBCR == round(100 * (1 - preop_bcr()))]
      
    })
  
  # Treated PS mortality (unadjusted)
  treated_pca_mortality_unadjusted <- 
    reactive({
      
      treated_pca_lookup$Value[treated_pca_lookup$PreOpBCR == round(100 * (1 - preop_bcr()))]
      
    })
  
  # Comorbidity mortality (adjusted)
  comorbidity_mortality_adjusted <- 
    reactive({
      
      # Compute the lambdas
      lambda_oc <- -log(1 - other_cause()) / 15
      lambda_untrt <- -log(1 - untreated_pca_mortality_unadjusted()) / 15
      
      # Risk
      lambda_oc / (lambda_untrt + lambda_oc) * (1 - exp(-(lambda_untrt + lambda_oc) * 15))
      
    })
  
  # Untreated PS mortality (adjusted)
  untreated_pca_mortality_adjusted <- 
    reactive({
      
      # Compute the lambdas
      lambda_oc <- -log(1 - other_cause()) / 15
      lambda_untrt <- -log(1 - untreated_pca_mortality_unadjusted()) / 15
      
      # Risk
      lambda_untrt / (lambda_untrt + lambda_oc) * (1 - exp(-(lambda_untrt + lambda_oc) * 15))
      
    })
  
  # Treated PS mortality (adjusted)
  treated_pca_mortality_adjusted <- 
    reactive({
      
      # Compute the lambdas
      lambda_oc <- -log(1 - other_cause()) / 15
      lambda_trt <- -log(1 - treated_pca_mortality_unadjusted()) / 15
      
      # Risk
      lambda_trt / (lambda_trt + lambda_oc) * (1 - exp(-(lambda_trt + lambda_oc) * 15))
      
    })
  
  # Current survival
  current_survival <- 
    reactive({
      
      1 - (comorbidity_mortality_adjusted() + untreated_pca_mortality_adjusted())
      
    })
  
  # Increated survival due to PS treatment
  increated_survival <-
    reactive({
      
      untreated_pca_mortality_adjusted() - treated_pca_mortality_adjusted()
      
    })
  
  # Get the current risk set
  risk_set <-
    reactive({
      
      # Compute the number of men for each color
      death_ps <- round(100 * untreated_pca_mortality_adjusted())
      death_other <- round(100 * comorbidity_mortality_adjusted())
      death_trt <- round(100 * increated_survival())
      no_death <- round(100 * current_survival())
      
      if((no_death + death_ps + death_other) < 100) {
        no_death <- no_death + (100 - (no_death + death_ps + death_other))
      } else if((no_death + death_ps + death_other) > 100) {
        no_death <- no_death - ((no_death + death_ps + death_other) - 100)
      }
        
      
      list(death_ps = death_ps, death_other = death_other, no_death = no_death, death_trt = death_trt)
      
    })
  
  # Make the text output
  output$label_no_death <- renderUI({HTML(paste0("<p><strong><span style = 'font-size:24px; color: #7f7f7f'>", risk_set()$no_death,"%<br></span></strong><span style='font-size:14px; color: #7f7f7f'>men would have lived</span></p>"))})
  output$label_death_ps <- renderUI({HTML(paste0("<p><strong><span style = 'font-size:24px; color: #c00000'>", risk_set()$death_ps,"%<br></span></strong><span style='font-size:14px; color: #7f7f7f'>men would have died of untreated prostate cancer</span><br><strong><span style='font-size:14px; color: #c00000'>", risk_set()$death_trt, "% men would have lived with getting the treatments</span></strong></p>"))})
  output$label_death_other <- renderUI({HTML(paste0("<p><strong><span style = 'font-size:24px; color: #215f9a'>", risk_set()$death_other,"%<br></span></strong><span style='font-size:14px; color: #7f7f7f'>men would have died of other causes</span></p>"))})

  # Make the people plot
  output$people <-
    renderPlot({
      
      # Data set
      temp_dat <-
        data.frame(
          row = c(rep(1, 25), rep(2, 25), rep(3, 25), rep(4, 25)),
          col = rep(1:25, 4),
          image = c(rep("www/man_alive.png", risk_set()$no_death), rep("www/man_dead_ps.png", risk_set()$death_ps - risk_set()$death_trt), rep("www/man_dead_ps_trt.png", risk_set()$death_trt), rep("www/man_dead_other.png", risk_set()$death_other))
        )
      
      # Make the plot
      temp_plot <-
        ggplot(temp_dat) + 
        geom_image(
          aes(
            x = col,
            y = 5 - row,
            image = image
          ),
          size = .03
        ) +
        theme(
          panel.background = element_blank(),
          axis.title = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          plot.margin = unit(c(-10, 0, -3, 0), "cm")
        ) +
        coord_cartesian(ylim = c(-3, 8)) 
      
      temp_plot
      
    }, height = 600, width = 800)
  
  # Lists of conditions
  health_conditions <- reactiveValues(string = c())
  output$list_of_health_conditions <-
    renderUI({HTML(paste0("<p>", paste(health_conditions$string, collapse = ", "), "</p>"))})
  
  # List of PS factors
  ps_factors <- 
    reactive({
      
      paste(
        na.omit(
          c(
            paste0("Age: ", input$s5_q1),
            ifelse(input$s5_q2 == "", NA_character_, paste0("T Stage: ", input$s5_q2)),
            ifelse(input$s5_q3 == "", NA_character_, paste0("M Stage: ", input$s5_q3)),
            ifelse(input$s5_q4 == "", NA_character_, paste0("N Stage: ", input$s5_q4)),
            ifelse(input$s5_q5 == "", NA_character_, paste0("Grade: ", input$s5_q5)),
            paste0("PSA: ", input$s5_q6)
          )
        ),
        collapse = ", "
      )
  
    })
  output$list_of_ps_factors <-
    renderUI({HTML(paste0("<p>", ps_factors(), "</p>"))})
  
})