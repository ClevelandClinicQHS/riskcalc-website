library(pmsampsize)
function(input, output, session) {
    useShinyjs(html = TRUE)
  
    design <- reactiveVal("Introduction")
    
    observeEvent(input$design,{
        if (input$design=="Introduction") {
            shinyjs::show(id="introduction")
            shinyjs::hide(id="outcome_rct")
            shinyjs::hide(id="outcome_cc")
            shinyjs::hide(id="outcome_cohort")
            shinyjs::hide(id="outcome_cross")
            shinyjs::hide(id="outcome_survey")
            shinyjs::hide(id="outcome_pm")
            shinyjs::hide(id="outcome_auc")
        }
        if (input$design %in% c("NonInferiority", "Superiority", "Equivalence", "Equality")) {
            shinyjs::hide(id="introduction")
            shinyjs::show(id="outcome_rct")
            shinyjs::hide(id="outcome_cc")
            shinyjs::hide(id="outcome_cohort")
            shinyjs::hide(id="outcome_cross")
            shinyjs::hide(id="outcome_survey")
            shinyjs::hide(id="outcome_pm")
            shinyjs::hide(id="outcome_auc")
        }
        if (input$design == "CaseControl") {
            shinyjs::hide(id="introduction")
            shinyjs::hide(id="outcome_rct")
            shinyjs::show(id="outcome_cc")
            shinyjs::hide(id="outcome_cohort")
            shinyjs::hide(id="outcome_cross")
            shinyjs::hide(id="outcome_survey")
            shinyjs::hide(id="outcome_pm")
            shinyjs::hide(id="outcome_auc")
        }
        if (input$design == "Cohort") {
            shinyjs::hide(id="introduction")
            shinyjs::hide(id="outcome_rct")
            shinyjs::hide(id="outcome_cc")
            shinyjs::show(id="outcome_cohort")
            shinyjs::hide(id="outcome_cross")
            shinyjs::hide(id="outcome_survey")
            shinyjs::hide(id="outcome_pm")
            shinyjs::hide(id="outcome_auc")
        }
        if (input$design == "CrossSectional") {
            shinyjs::hide(id="introduction")
            shinyjs::hide(id="outcome_rct")
            shinyjs::hide(id="outcome_cc")
            shinyjs::hide(id="outcome_cohort")
            shinyjs::show(id="outcome_cross")
            shinyjs::hide(id="outcome_survey")
            shinyjs::hide(id="outcome_pm")
            shinyjs::hide(id="outcome_auc")
        }
        if (input$design == "Survey") {
            shinyjs::hide(id="introduction")
            shinyjs::hide(id="outcome_rct")
            shinyjs::hide(id="outcome_cc")
            shinyjs::hide(id="outcome_cohort")
            shinyjs::hide(id="outcome_cross")
            shinyjs::show(id="outcome_survey")
            shinyjs::hide(id="outcome_pm")
            shinyjs::hide(id="outcome_auc")
        }
        if (input$design == "PredictionModel") {
            shinyjs::hide(id="introduction")
            shinyjs::hide(id="outcome_rct")
            shinyjs::hide(id="outcome_cc")
            shinyjs::hide(id="outcome_cohort")
            shinyjs::hide(id="outcome_cross")
            shinyjs::hide(id="outcome_survey")
            shinyjs::show(id="outcome_pm")
            shinyjs::hide(id="outcome_auc")
        }
        if (input$design == "TwoAUC") {
            shinyjs::hide(id="introduction")
            shinyjs::hide(id="outcome_rct")
            shinyjs::hide(id="outcome_cc")
            shinyjs::hide(id="outcome_cohort")
            shinyjs::hide(id="outcome_cross")
            shinyjs::hide(id="outcome_survey")
            shinyjs::hide(id="outcome_pm")
            shinyjs::show(id="outcome_auc")
        }
        if(input$design=="Introduction") {
            shinyjs::hide(id="run-tab")
            shinyjs::hide(id="DesignTitle")
        } else {
            shinyjs::show(id="run-tab")
            shinyjs::show(id="DesignTitle")
        }
        if(!is.null(input$design)) {
            design(input$design)
        }
    })
    
    output$summary <- renderUI({
        d = design()
        if (d == "NonInferiority") {
            h1("Non-inferiority Trial (One-Sided)")
        } else if (d == "Superiority") {
            h1("Superiority Trial (One-Sided)")
        } else if (d == "Equivalence") {
            h1("Equivalence Trial") 
        } else if (d == "Equality") {
              h1("Equality Trial")
        } else if (d=="CaseControl") {
            h1("Case-control Study")
        } else if (d=="Cohort") {
            h1("Cohort Study")
        } else if (d=="CrossSectional") {
            h1("Cross-sectional Study")
        } else if (d=="Survey") {
            h1("Survey (Cross-sectional)")
        } else if (d=="PredictionModel") {
            HTML(paste("<h1>Prediction Model</h1><br>",
                       '<p>In observational analytical studies (cross-sectional, case-control, and cohort studies),<br>',
                       'investigators may want to build clinical predictive models.<br>',
                       'This online calculator is to help investigators calculate the sample required for developing<br>',
                       'a clinical prediction model that aims to predict outcomes in individuals,<br>',
                       'to inform diagnosis or prognosis in healthcare.</p>',sep=""))
        } else if (d=="TwoAUC") {
            h1("Comparison of the AUC with a null hypothesis value")
        }
    })
    
    output$example1 <- renderUI({
        d = design()
        if (d == "NonInferiority") {
            withMathJax(p('Suppose that the pharmaceutical company is interested in establishing non-inferiority of the test drug as compared to the active control agent. We assume that the non-inferiority margin is chosen to be 5% (i.e., \\(\\delta = 0.05 \\)). Also, suppose the true difference in mean LDL between treatment groups is 0 (i.e., \\(d = 0\\)) and the standard deviation is 10% (i.e., \\(SD = 0.1\\)). For achieving an 80% power (i.e., \\(1-\\beta = 0.8\\)) at the 5% level of significance (i.e., \\(\\alpha = 0.025\\)) with equal allocation (i.e., \\(k = 1\\)), the sample size for treatment agents and the active control are \\(
                          63\\) and \\(63\\), respectively.'))
        } else if (d == "Superiority") {
            withMathJax(p('Suppose that the pharmaceutical company is interested in establishing superiority of the test drug as compared to the active control agent. We assume that the superiority margin is chosen to be 0.05 (i.e., \\( \\delta = 0.05 \\)). Also, suppose the true difference in mean LDL between treatment groups is 0 (i.e., \\(d = 0\\)) and the standard deviation is 10% (i.e., \\(SD = 0.1\\)). For achieving an 80% power (i.e., \\(1-\\beta = 0.8\\)) at the 5% level of significance (i.e., \\(\\alpha = 0.025\\)) with equal allocation (i.e., \\(k = 1\\)), the sample size for treatment agents and the active control are \\(63\\) and \\(63\\), respectively.'))
        } else if (d == "Equivalence") {
            withMathJax(p('Suppose that the pharmaceutical company is interested in establishing equivalence of the test drug as compared to the active control agent. We assume that the equivalence margin is chosen to be 5% (i.e., \\(\\delta = 0.05 \\)). Also, suppose the true difference in mean LDL between treatment groups is 0% (i.e., \\(d = 0\\)) and the standard deviation is 10% (i.e., \\(SD = 0.1\\)). For achieving an 80% power (i.e., \\(1-\\beta = 0.8\\)) at the 5% level of significance (i.e., \\(\\alpha = 0.05\\)) with equal allocation (i.e., \\(k = 1\\)), the sample size for treatment agents and the active control are \\(69\\) and \\(69\\), respectively.'))
        } else if (d == "Equality") {
          withMathJax(p('Suppose that the pharmaceutical company is interested in establishing equality of the test drug as compared to the active control agent. We suppose that a diﬀerence of 5% (i.e., \\(d = 0.05 \\)) in percent change of LDL is considered of clinically meaningful diﬀerence and the standard deviation is 10% (i.e., \\(SD = 0.1\\)). For achieving an 80% power (i.e., \\(1-\\beta = 0.8\\)) at the 5% level of significance (i.e., \\(\\alpha = 0.05\\)) with equal allocation (i.e., \\(k = 1\\)), the sample size for treatment agents and the active control are \\(63\\) and \\(63\\), respectively.'))
        }
    })
    
    output$example2 <- renderUI({
        d = design()
        if (d == "NonInferiority") {
            withMathJax(p('Suppose it is of interest to establish non-inferiority of the test drugs compared to the active control agent. The non-inferiority margin is chosen to be 10% (i.e., \\( \\delta  = 0.1 \\)). Also, suppose the true mean cure rates of the treatment agents and the active control are 85% (i.e., \\(p_T  = 0.85\\)) and 65% (i.e., \\(p_C  = 0.65\\)) , respectively. For achieving an 80% power (i.e., \\(1-\\beta = 0.8\\)) at the 5% level of significance (i.e., \\(\\alpha = 0.05\\)) with equal allocation (i.e., \\(k = 1\\)), the sample size for treatment agents and the active control are \\(25\\) and \\(25\\), respectively.'),
                        p('Suppose it is of interest to establish non-inferiority of the test compound and a standard therapy for prevention of relapse in subjects with schizophrenia and schizoaffective disorders. The estimated the odds ratio between the test compound and a standard therapy is 0.7 (i.e., \\( OR = 0.7 \\)). Based on the results from a previous study, 50% of subjects receiving the standard therapy experienced relapse after the treatment (i.e., \\(p_C = 0.5\\)). Assume that 10% is considered as a clinically important non-inferiority margin for log-scale relative risk (i.e., \\( H_0: \\log (OR) \\leq -\\delta, \\delta = 0.1\\)). For achieving an 80% power (i.e., \\(1-\\beta = 0.8\\)) at the 5% level of significance (i.e., \\(\\alpha = 0.05\\)) with equal allocation (i.e., \\(k = 1\\)), the sample size for treatment agents and the active control are \\(763\\) and \\(763\\), respectively.'))
        } else if (d == "Superiority") {
            withMathJax(p('Suppose it is of interest to establish superiority of the test drugs compared to the active control agent. Assume the superiority margin is 5% (i.e., \\( \\delta  = 0.05 \\)). Also, suppose the true mean cure rates of the treatment agents and the active control are 85% (i.e., \\(p_T  = 0.85\\)) and 65% (i.e., \\(p_C  = 0.65\\)) , respectively. For achieving an 80% power (i.e., \\(1-\\beta = 0.8\\)) at the 5% level of significance (i.e., \\(\\alpha = 0.05\\)) with equal allocation (i.e., \\(k = 1\\)), the sample size for treatment agents and the active control are \\(98\\) and \\(98\\), respectively.'),
                        p('Suppose it is of interest to establish superiority of the test compound and a standard therapy for prevention of relapse in subjects with schizophrenia and schizoaffective disorders. The estimated the odds ratio between the test compound and a standard therapy is 2 (i.e., \\( OR = 2 \\)). Based on the results from a previous study, 25% of subjects receiving the standard therapy experienced relapse after the treatment (i.e., \\(p_C = 0.25\\)). Assume that 20% is considered as a clinically important superiority margin for log-scale relative risk (i.e., \\( H_0: \\log (OR) \\leq \\delta, \\delta = 0.2\\)). For achieving an 80% power (i.e., \\(1-\\beta = 0.8\\)) at the 5% level of significance (i.e., \\(\\alpha = 0.05\\)) with equal allocation (i.e., \\(k = 1\\)), the sample size for treatment agents and the active control are \\(242\\) and \\(242\\), respectively.'))
        } else if (d == "Equivalence") {
            withMathJax(p('Suppose it is of interest to establish equivalence of the test drugs compared to the active control agent. Assume the equivalence margin is 0% (i.e., \\( H_0: |p_T - p_C| >= 0, \\delta  = 0.0 \\)). Also, suppose the true mean cure rates of the treatment agents and the active control are 85% (i.e., \\(p_T  = 0.85\\)) and 65% (i.e., \\(p_C  = 0.65\\)) , respectively. For achieving an 80% power (i.e., \\(1-\\beta = 0.8\\)) at the 5% level of significance (i.e., \\(\\alpha = 0.05\\)) with equal allocation (i.e., \\(k = 1\\)), the sample size for treatment agents and the active control are \\(55\\) and \\(55\\), respectively.'),
                        p('Suppose it is of interest to establish equivalence of the test compound and a standard therapy for prevention of relapse in subjects with schizophrenia and schizoaffective disorders. The estimated the odds ratio between the test compound and a standard therapy is 2 (i.e., \\( OR = 2 \\)). Based on the results from a previous study, 25% of subjects receiving the standard therapy experienced relapse after the treatment (i.e., \\(p_C = 0.25\\)). The hypotheses of interest is \\( H_0: OR = 1 \\), so the equivalence margin is 0%, (i.e., \\( \\delta = 0 \\)). For achieving an 80% power (i.e., \\(1-\\beta = 0.8\\)) at the 5% level of significance (i.e., \\(\\alpha = 0.05\\)) with equal allocation (i.e., \\(k = 1\\)), the sample size for treatment agents and the active control are \\(170\\) and \\(170\\), respectively.'))
        } else if (d == "Equality") {
          withMathJax(p('Suppose it is of interest to establish equality of the test drugs compared to the active control agent. Suppose a diﬀerence of 20% (i.e., \\( H_0: |p_T - p_C| = 0.2 \\)) in clinical response of cure is considered of clinically meaningful diﬀerence between the two agents and the true mean cure rates of the treatment agents and the active control are 85% (i.e., \\(p_T  = 0.85\\)) and 65% (i.e., \\(p_C  = 0.65\\)) , respectively. For achieving an 80% power (i.e., \\(1-\\beta = 0.8\\)) at the 5% level of significance (i.e., \\(\\alpha = 0.05\\)) with equal allocation (i.e., \\(k = 1\\)), the sample size for treatment agents and the active control are \\(70\\) and \\(70\\), respectively.'),
                      p('Suppose it is of interest to establish equality of the test compound and a standard therapy for prevention of relapse in subjects with schizophrenia and schizoaffective disorders. Suppose the odds ratio between the test compound and a standard therapy is 2 (i.e., \\( OR = 2 \\)). Based on the results from a previous study, 25% of subjects receiving the standard therapy experienced relapse after the treatment (i.e., \\(p_C = 0.25\\)). For achieving an 80% power (i.e., \\(1-\\beta = 0.8\\)) at the 5% level of significance (i.e., \\(\\alpha = 0.05\\)) with equal allocation (i.e., \\(k = 1\\)), the sample size for treatment agents and the active control are \\(156\\) and \\(156\\), respectively.'))
        }
    })
    
    output$example3 <- renderUI({
        d = design()
        if (d == "NonInferiority") {
            withMathJax(p('Suppose that the pharmaceutical company is interested in establishing non-inferiority of the test drug as compared to the active control agent. The company conducts a study with 1 year accrual time period (period of time that patients are entering the study, \\(T_a = 1\\)) and 1 year follow-up time period (period of time after accrual has ended before the final analysis is conducted, \\(T_b=1\\)). Assume the hazard for the control group is a constant risk over time at 2 (i.e., \\(\\lambda_C = 2\\)) and the hazard for the treatment group is a constant risk over time at 1 (i.e., \\(\\lambda_T = 1\\)). We assume that the non-inferiority margin is chosen to be 0.3 (i.e., \\( H_0: \\log (HR) \\leq -\\delta, \\delta = 0.3\\)). For achieving an 80% power (i.e., \\(1-\\beta = 0.8\\)) at the 2.5% level of significance (i.e., \\(\\alpha = 0.025\\)) with equal allocation (i.e., \\(k = 1\\)), the sample size for treatment agents and the active control are \\(19\\) and \\(19\\), respectively.'))
        } else if (d == "Superiority") {
            withMathJax(p('Suppose that the pharmaceutical company is interested in establishing superiority of the test drug as compared to the active control agent. The company conducts a study with 1 year accrual time period (period of time that patients are entering the study, \\(T_a = 1\\)) and 1 year follow-up time period (period of time after accrual has ended before the final analysis is conducted, \\(T_b=1\\)). Assume the hazard for the control group is a constant risk over time at 2 (i.e., \\(\\lambda_C = 2\\)) and the hazard for the treatment group is a constant risk over time at 1 (i.e., \\(\\lambda_T = 1\\)). We assume that the superiority margin is chosen to be 0.3 (i.e., \\( H_0: \\log (HR) \\leq \\delta, \\delta = 0.3\\)). For achieving an 80% power (i.e., \\(1-\\beta = 0.8\\)) at the 2.5% level of significance (i.e., \\(\\alpha = 0.025\\)) with equal allocation (i.e., \\(k = 1\\)), the sample size for treatment agents and the active control are \\(120\\) and \\(120\\), respectively.'))
        } else if (d == "Equivalence") {
            withMathJax(p('Suppose that the pharmaceutical company is interested in establishing equivalence of the test drug as compared to the active control agent. The company conducts a study with 1 year accrual time period (period of time that patients are entering the study, \\(T_a = 1\\)) and 1 year follow-up time period (period of time after accrual has ended before the final analysis is conducted, \\(T_b=1\\)). Assume the hazard for the control group is a constant risk over time at 1 (i.e., \\(\\lambda_C = 1\\)) and the hazard for the treatment group is a constant risk over time at 1 (i.e., \\(\\lambda_T = 1\\)). The hypotheses of interest is \\( H_0: HR = 1.65 \\), so the equivalence margin is 50%, (i.e., \\( \\delta = 0.5 \\)). For achieving an 80% power (i.e., \\(1-\\beta = 0.8\\)) at the 5% level of significance (i.e., \\(\\alpha = 0.05\\)) with equal allocation (i.e., \\(k = 1\\)), the sample size for treatment agents and the active control are \\(90\\) and \\(90\\), respectively.'))
        } else if (d == "Equality") {
          withMathJax(p('Suppose that the pharmaceutical company is interested in establishing equality of the test drug as compared to the active control agent. The company conducts a study with 1 year accrual time period (period of time that patients are entering the study, \\(T_a = 1\\)) and 1 year follow-up time period (period of time after accrual has ended before the final analysis is conducted, \\(T_b=1\\)). Assume the hazard for the control group is a constant risk over time at 2 (i.e., \\(\\lambda_C = 2\\)) and the hazard for the treatment group is a constant risk over time at 1 (i.e., \\(\\lambda_T = 1\\)). For achieving an 80% power (i.e., \\(1-\\beta = 0.8\\)) at the 5% level of significance (i.e., \\(\\alpha = 0.05\\)) with equal allocation (i.e., \\(k = 1\\)), the sample size for treatment agents and the active control are \\(39\\) and \\(39\\), respectively.'))
        }
    })
    
    observeEvent(input$rctDesign,
                 {
                     showNavPane(input$rctDesign)
                 })
    observeEvent(input$ccDesign,
                 {
                     showNavPane(input$ccDesign)
                 })
    observeEvent(input$cohortDesign,
                 {
                     showNavPane(input$cohortDesign)
                 })
    observeEvent(input$independentDesign,
                 {
                     showNavPane(input$independentDesign)
                 })
    observeEvent(input$crossDesign,
                 {
                     showNavPane(input$crossDesign)
                 })
    observeEvent(input$surveyDesign,
                 {
                     showNavPane(input$surveyDesign)
                 })
    observeEvent(input$pmDesign,
                 {
                     showNavPane(input$pmDesign)
                 })

    rct_mean_values <- reactiveValues(
        lastUpdated = NULL
    )
    observe({
        lapply(c("rct_mean_treat", "rct_mean_control"), function(x) {
            observe({
                input[[x]]
                rct_mean_values$lastUpdated <- x
            })
        })
    })
    
    observeEvent(input$radiobar1, {
        if (input$radiobar1 == "proportion") {
            shinyjs::show("rctProportion")
            shinyjs::hide("rctOR")
        } else {
            shinyjs::hide("rctProportion")
            shinyjs::show("rctOR")
        }
    })
    
    observeEvent(input$radiobar2, {
        if (input$radiobar2 == "known") {
            shinyjs::show("known")
            shinyjs::hide("unknown")
        } else {
            shinyjs::hide("known")
            shinyjs::show("unknown")
        }
    })
    
    observeEvent(input$radiobar3, {
        if (input$radiobar3 == "ccproportion") {
            shinyjs::show("ccproportion")
            shinyjs::hide("ccor")
        } else {
            shinyjs::hide("ccproportion")
            shinyjs::show("ccor")
        }
    })
    
    observeEvent(input$radiobar7, {
        if (input$radiobar7 == "ccmproportion") {
            shinyjs::show("ccmproportion")
            shinyjs::hide("ccmor")
        } else {
            shinyjs::hide("ccmproportion")
            shinyjs::show("ccmor")
        }
    })
    
    observeEvent(input$radiobar4, {
        if (input$radiobar4 == "cohortproportion") {
            shinyjs::show("cohortproportion")
            shinyjs::hide("cohortrr")
        } else {
            shinyjs::hide("cohortproportion")
            shinyjs::show("cohortrr")
        }
    })
    
    observeEvent(input$radiobar8, {
        if (input$radiobar8 == "cohortpproportion") {
            shinyjs::show("cohortpproportion")
            shinyjs::hide("cohortprr")
        } else {
            shinyjs::hide("cohortpproportion")
            shinyjs::show("cohortprr")
        }
    })
    
    observeEvent(input$radiobar5, {
        if (input$radiobar5 == "known") {
            shinyjs::show("cohortknown")
            shinyjs::hide("cohortunknown")
        } else {
            shinyjs::hide("cohortknown")
            shinyjs::show("cohortunknown")
        }
    })
    
    observeEvent(input$radiobar6, {
        if (input$radiobar6 == "crossproportion") {
            shinyjs::show("crossproportion-p")
            shinyjs::hide("crossrr-p")
        } else {
            shinyjs::hide("crossproportion-p")
            shinyjs::show("crossrr-p")
        }
    })
    
    v = reactiveValues(res = NULL)
    
    observeEvent(input$run,{
        if (design() %in% c("NonInferiority", "Superiority", "Equivalence", "Equality") & input$rctDesign=="continuous"){
          if (design() %in% c("NonInferiority", "Superiority", "Equivalence")){
            res = rct_continuous(diff=input$rct_mean_diff, delta=input$rct_delta_c, sd=input$rct_sd, 
                                 r=input$r_rct_c, power=input$beta_rct_c, alpha=input$alpha_rct_c, drop_rate = input$dr_c/100, design=design())
            output_data = data.frame(
              V1 = c("Significance level", "Power (1-beta)", "Ratio of sample size, treat/control", "Allowable difference", "SD", "Margin", "Drop rate (%)", "Result", "Sample Size - Treat", "Sample Size - Control", "Total sample size"),
              V2 = c(input$alpha_rct_c, input$beta_rct_c, input$r_rct_c, input$rct_mean_diff, input$rct_sd, input$rct_delta_c, input$dr_c, "", res$n_treat, res$n_control, res$n_total)
            ) %>% 
              knitr::kable("html", escape = F, align=c("l", "c")) %>% 
              kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>% 
              row_spec(8, bold = T, background = "#EEF5DB") %>% 
              add_header_above(c("Sample size"=2), background = "#666666", color = "#ffffff")
          }
          # remove delta (margin) for Equality
          if (design() %in% c("Equality")){
            res = rct_continuous(diff=input$rct_mean_diff, sd=input$rct_sd, 
                                 r=input$r_rct_c, power=input$beta_rct_c, alpha=input$alpha_rct_c, drop_rate = input$dr_c/100, design=design())
            output_data = data.frame(
              V1 = c("Significance level", "Power (1-beta)", "Ratio of sample size, treat/control", "Allowable difference", "SD", "Drop rate (%)", "Result", "Sample Size - Treat", "Sample Size - Control", "Total sample size"),
              V2 = c(input$alpha_rct_c, input$beta_rct_c, input$r_rct_c, input$rct_mean_diff, input$rct_sd, input$dr_c, "", res$n_treat, res$n_control, res$n_total)
            ) %>% 
              knitr::kable("html", escape = F, align=c("l", "c")) %>% 
              kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>% 
              row_spec(7, bold = T, background = "#EEF5DB") %>% 
              add_header_above(c("Sample size"=2), background = "#666666", color = "#ffffff")
          }   
          
          # shape output for result rendering  
          output_data = gsub("</th></tr>.*</thead>","</thead>", output_data)
          v$res = output_data
        }
        if (design() %in% c("NonInferiority", "Superiority", "Equivalence", "Equality") & input$rctDesign=="dichotomous"){
            if (input$radiobar1 == "proportion") {
              if (design() %in% c("NonInferiority", "Superiority", "Equivalence")){
                res = rct_proportion(treat=input$rct_p_treat, control=input$rct_p_control,  
                                     delta=input$rct_delta_p, 
                                     r=input$r_rct_p, power=input$beta_rct_p, alpha=input$alpha_rct_p, drop_rate = input$dr_d/100, design=design())
                output_data = data.frame(
                  V1 = c("Significance level", "Power (1-beta)", "Ratio of sample size, treat/control", "Expected proportion in the treatment group", "Expected proportion in the control group","Margin", "Drop rate (%)", "Result", "Sample Size - Treat", "Sample Size - Control", "Total sample size"),
                  V2 = c(input$alpha_rct_p, input$beta_rct_p, input$r_rct_p, input$rct_p_treat, input$rct_p_control, input$rct_delta_p,input$dr_d, "", res$n_treat, res$n_control, res$n_total)
                ) %>%
                  knitr::kable("html", escape = F, align=c("l", "c")) %>% 
                  kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>% 
                  row_spec(8, bold = T, background = "#EEF5DB") %>% 
                  add_header_above(c("Sample size"=2), background = "#666666", color = "#ffffff")
              }
              
              # remove delta (margin) for Equality
              if (design() %in% c("Equality")){
                res = rct_proportion(treat=input$rct_p_treat, control=input$rct_p_control,  
                                     r=input$r_rct_p, power=input$beta_rct_p, alpha=input$alpha_rct_p, drop_rate = input$dr_d/100, design=design())
                output_data = data.frame(
                  V1 = c("Significance level", "Power (1-beta)", "Ratio of sample size, treat/control", "Expected proportion in the treatment group", "Expected proportion in the control group", "Drop rate (%)", "Result", "Sample Size - Treat", "Sample Size - Control", "Total sample size"),
                  V2 = c(input$alpha_rct_p, input$beta_rct_p, input$r_rct_p, input$rct_p_treat, input$rct_p_control, input$dr_d, "", res$n_treat, res$n_control, res$n_total)
                ) %>%
                  knitr::kable("html", escape = F, align=c("l", "c")) %>% 
                  kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>% 
                  row_spec(7, bold = T, background = "#EEF5DB") %>% 
                  add_header_above(c("Sample size"=2), background = "#666666", color = "#ffffff")
              }
              
              # reshape output for result rendering
              output_data = gsub("</th></tr>.*</thead>","</thead>", output_data)
              v$res = output_data
            } else {
              if (design() %in% c("NonInferiority", "Superiority", "Equivalence")){
                res = rct_proportion(OR = input$rct_p_or, control=input$rct_p_control2, 
                                     delta=input$rct_deltaexp_p, 
                                     r=input$r_rct_p, power=input$beta_rct_p, alpha=input$alpha_rct_p, drop_rate = input$dr_d/100, design=design())
                output_data = data.frame(
                  V1 = c("Significance level", "Power (1-beta)", "Ratio of sample size, treat/control", "Odds ratio","Margin in log-scale", "Result", "Sample Size - Treat", "Sample Size - Control", "Total sample size"),
                  V2 = c(input$alpha_rct_p, input$beta_rct_p, input$r_rct_p, input$rct_p_or, input$rct_deltaexp_p, "", res$n_treat, res$n_control, res$n_total)
                ) %>%
                  knitr::kable("html", escape = F, align=c("l", "c")) %>% 
                  kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>% 
                  row_spec(6, bold = T, background = "#EEF5DB") %>% 
                  add_header_above(c("Sample size"=2), background = "#666666", color = "#ffffff")
              }
              
              # remove delta (margin) for Equality
              if (design() %in% c("Equality")){
                res = rct_proportion(OR = input$rct_p_or, control=input$rct_p_control2, 
                                     r=input$r_rct_p, power=input$beta_rct_p, alpha=input$alpha_rct_p, drop_rate = input$dr_d/100, design=design())
                output_data = data.frame(
                  V1 = c("Significance level", "Power (1-beta)", "Ratio of sample size, treat/control", "Odds ratio", "Result", "Sample Size - Treat", "Sample Size - Control", "Total sample size"),
                  V2 = c(input$alpha_rct_p, input$beta_rct_p, input$r_rct_p, input$rct_p_or, "", res$n_treat, res$n_control, res$n_total)
                ) %>%
                  knitr::kable("html", escape = F, align=c("l", "c")) %>% 
                  kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>% 
                  row_spec(5, bold = T, background = "#EEF5DB") %>% 
                  add_header_above(c("Sample size"=2), background = "#666666", color = "#ffffff")
              }
              
                # reshape output for result rendering
                output_data = gsub("</th></tr>.*</thead>","</thead>", output_data)
                v$res = output_data
            }
        }
        if (design() %in% c("NonInferiority", "Superiority", "Equivalence", "Equality") & input$rctDesign=="tte") {
            if (input$radiobar2 == "known") {
              if (design() %in% c("NonInferiority", "Superiority", "Equivalence")){
                res = rct_survival(delta=input$rct_delta_s, ta=input$rct_s_timea, tb=input$rct_s_timeb, k=input$r_rct_s, power=input$beta_rct_s, alpha=input$alpha_rct_s, 
                                   mT=input$rct_s_treat, mC=input$rct_s_control,
                                   design=design())
              }
              # remove delta (margin) for Equality
              if (design() %in% c("Equality")){
                res = rct_survival(ta=input$rct_s_timea, tb=input$rct_s_timeb, k=input$r_rct_s, power=input$beta_rct_s, alpha=input$alpha_rct_s, 
                                   mT=input$rct_s_treat, mC=input$rct_s_control,
                                   design=design())
              }
            } else {
              if (design() %in% c("NonInferiority", "Superiority", "Equivalence")){
                res = rct_survival(delta=input$rct_delta_s, ta=input$rct_s_timea, tb=input$rct_s_timeb, k=input$r_rct_s, power=input$beta_rct_s, alpha=input$alpha_rct_s, 
                                   lambdaT=input$rct_s_lambdat, lambdaC=input$rct_s_lambdac,
                                   design=design())
              }
              # remove delta (margin) for Equality 
              if (design() %in% c("Equality")){
                res = rct_survival(ta=input$rct_s_timea, tb=input$rct_s_timeb, k=input$r_rct_s, power=input$beta_rct_s, alpha=input$alpha_rct_s, 
                                   lambdaT=input$rct_s_lambdat, lambdaC=input$rct_s_lambdac,
                                   design=design())
              } 
            }
          
          if (design() %in% c("NonInferiority", "Superiority", "Equivalence")){
            output_data = data.frame(
              V1 = c("Significance level", "Power (1-beta)", "Ratio of sample size, treat/control", 
                     "Margin", 
                     "Hazard for the treatment group", "Hazard for the control group", 
                     "Median survival time for the treatment group", "Median survival time for the control group",
                     "Probability of event for treatment", "Probability of event for control",
                     "Combined probability of event",
                     "Result", 
                     "Sample Size - Treat", "Sample Size - Control", "Total sample size"),
              V2 = c(input$alpha_rct_s, input$beta_rct_s, input$r_rct_s, 
                     input$rct_delta_s, 
                     round(res$lambdaT, 2), round(res$lambdaC, 2), 
                     round(res$mT, 2), round(res$mC, 2), 
                     round(res$Pr_treat, 2), round(res$Pr_control, 2),
                     round(res$Pr, 2), 
                     "", 
                     res$n_treat, res$n_control, res$n_total)
            ) %>% 
              knitr::kable("html", escape = F, align=c("l", "c")) %>% 
              kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>% 
              row_spec(12, bold = T, background = "#EEF5DB") %>% 
              add_header_above(c("Sample size"=2), background = "#666666", color = "#ffffff")
          }
          
          # remove delta (margin) for Equality 
          if (design() %in% c("Equality")){
            output_data = data.frame(
              V1 = c("Significance level", "Power (1-beta)", "Ratio of sample size, treat/control", 
                     "Hazard for the treatment group", "Hazard for the control group", 
                     "Median survival time for the treatment group", "Median survival time for the control group",
                     "Probability of event for treatment", "Probability of event for control",
                     "Combined probability of event",
                     "Result", 
                     "Sample Size - Treat", "Sample Size - Control", "Total sample size"),
              V2 = c(input$alpha_rct_s, input$beta_rct_s, input$r_rct_s, 
                     round(res$lambdaT, 2), round(res$lambdaC, 2), 
                     round(res$mT, 2), round(res$mC, 2), 
                     round(res$Pr_treat, 2), round(res$Pr_control, 2),
                     round(res$Pr, 2), 
                     "", 
                     res$n_treat, res$n_control, res$n_total)
            ) %>% 
              knitr::kable("html", escape = F, align=c("l", "c")) %>% 
              kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>% 
              row_spec(11, bold = T, background = "#EEF5DB") %>% 
              add_header_above(c("Sample size"=2), background = "#666666", color = "#ffffff")
          }
          
          # reshape output for result rendering
          output_data = gsub("</th></tr>.*</thead>","</thead>", output_data)
          v$res = output_data
        }
        if (design() == "CaseControl" & input$ccDesign=="unmatched") {
            twoside = ifelse(is.null(input$checkbox1), F, T)
            if (input$radiobar3=="ccproportion") {
                res = cc(p0=input$unmatched_p0, p1=input$unmatched_p1, r=input$r_unmatched, alpha=input$alpha_unmatched, power=input$beta_unmatched, two.side=twoside, design = "unmatched")
                output_data = data.frame(
                    V1 = c(ifelse(twoside, "2-side significance level", "1-side significance level"), "Power (1-beta)", "Ratio of sample size, control/case", "Probability of event in the control group", "Probability of event in the case group", "Result", "", "Sample Size - Case", "Sample Size - Control", "Total sample size"),
                    V2 = c(rep("", 6), "Fleiss", res$fless.case, res$fless.control, res$fless.case+ res$fless.control),
                    V3 = c(input$alpha_unmatched, input$beta_unmatched, input$r_unmatched, input$unmatched_p0, input$unmatched_p1, "", "Fleiss with correction for continuity", res$flesscc.case, res$flesscc.control, res$flesscc.case+res$flesscc.control)
                ) %>% 
                    knitr::kable("html", escape = F, align=c("l", "c", "c")) %>% 
                    kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>% 
                    row_spec(6, bold = T, background = "#EEF5DB") %>% 
                    row_spec(7, bold = T) %>% 
                    add_header_above(c("Sample size"=3), background = "#666666", color = "#ffffff")
                output_data = gsub("</th></tr>.*</thead>","</thead>", output_data)
                v$res = output_data
            } else {
                res = cc(OR =input$unmatched_or, r=input$r_unmatched, p0 = input$unmatched_p2, alpha=input$alpha_unmatched, power=input$beta_unmatched, two.side=twoside, design = "unmatched")
                output_data = data.frame(
                    V1 = c(ifelse(twoside, "2-side significance level", "1-side significance level"), "Power (1-beta)", "Ratio of sample size, control/case", "OR", "Result","", "Sample Size - Case", "Sample Size - Control", "Total sample size"),
                    V2 = c(rep("", 5), "Fleiss", res$fless.case, res$fless.control, res$fless.case+ res$fless.control),
                    V3 = c(input$alpha_unmatched, input$beta_unmatched, input$r_unmatched, input$unmatched_or, "", "Fleiss with correction for continuity", res$flesscc.case, res$flesscc.control, res$flesscc.case+res$flesscc.control)
                ) %>% 
                    knitr::kable("html", escape = F, align=c("l", "c", "c")) %>% 
                    kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>% 
                    row_spec(5, bold = T, background = "#EEF5DB") %>% 
                    row_spec(6, bold = T) %>% 
                    add_header_above(c("Sample size"=3), background = "#666666", color = "#ffffff")
                output_data = gsub("</th></tr>.*</thead>","</thead>", output_data)
                v$res = output_data
            }
        }
        if (design() == "CaseControl" & input$ccDesign=="matched") {
            twoside = ifelse(is.null(input$checkbox2), F, T)
            if (input$radiobar7=="ccmproportion") {
              res = cc(p0=input$matched_p0, p1=input$matched_p1, r=input$r_matched, rho = input$matched_rho, alpha=input$alpha_matched, power=input$beta_matched, two.side=twoside, design = "matched") 
              output_data = data.frame(
                V1 = c(ifelse(twoside, "2-side significance level", "1-side significance level"), "Power (1-beta)", "Ratio of sample size, control/case", "rho", "Probability of event in the control group", "Probability of event in the case group", "Result", "Sample Size - Case", "Sample Size - Control", "Total sample size"),
                V2 = c(input$alpha_matched, input$beta_matched, input$r_matched, input$matched_rho, input$matched_p0, input$matched_p1, "", res$n.case, res$n.control, res$n.case+res$n.control)
            ) %>% 
                knitr::kable("html", escape = F, align=c("l", "c", "c")) %>% 
                kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>% 
                row_spec(7, bold = T, background = "#EEF5DB") %>% 
                add_header_above(c("Sample size"=2), background = "#666666", color = "#ffffff")
            output_data = gsub("</th></tr>.*</thead>","</thead>", output_data)
            v$res = output_data
            } else {
              res = cc(OR =input$matched_or, r=input$r_matched, p0 = input$matched_p2, rho = input$matched_rho, alpha=input$alpha_matched, power=input$beta_matched, two.side=twoside, design = "matched") 
              output_data = data.frame(
                V1 = c(ifelse(twoside, "2-side significance level", "1-side significance level"), "Power (1-beta)", "Ratio of sample size, control/case", "rho", "OR", "Result", "Sample Size - Case", "Sample Size - Control", "Total sample size"),
                V2 = c(input$alpha_matched, input$beta_matched, input$r_matched, input$matched_rho, input$matched_or, "", res$n.case, res$n.control, res$n.case+res$n.control)
              ) %>% 
                knitr::kable("html", escape = F, align=c("l", "c", "c")) %>% 
                kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>% 
                row_spec(6, bold = T, background = "#EEF5DB") %>% 
                add_header_above(c("Sample size"=2), background = "#666666", color = "#ffffff")
              output_data = gsub("</th></tr>.*</thead>","</thead>", output_data)
              v$res = output_data
            }
        }
        if (design() == "Cohort" & input$cohortDesign=="independent" & input$independentDesign=="independentProportional") {
            twoside = ifelse(is.null(input$checkbox3), F, T)
            if (input$radiobar4=="cohortproportion") {
                res = cohort(p1=input$ind_p0, p2=input$ind_p1, r=input$r_ind, alpha=input$alpha_ind, power=input$beta_ind, two.side=twoside, drop_rate=input$dr_i/100, design = "independent")
                output_data = data.frame(
                    V1 = c(ifelse(twoside, "2-side significance level", "1-side significance level"), "Power (1-beta)", "Ratio of sample size, unexposed/exposed", "Probability of event in the unexposed group", "Probability of event in the exposed group", "Drop rate (%)", "Result", "", "Sample Size - Exposed", "Sample Size - Unexposed", "Total sample size"),
                    V2 = c(rep("", 7), "Fleiss", res$n_exposed, res$n_unexposed, res$n_exposed+res$n_unexposed),
                    V3 = c(input$alpha_ind, input$beta_ind, input$r_ind, input$ind_p0, input$ind_p1, input$dr_i, "", "Fleiss with correction for continuity", res$n_exposed_cc, res$n_unexposed_cc, res$n_exposed_cc+res$n_unexposed_cc)
                ) %>% 
                    knitr::kable("html", escape = F, align=c("l", "c", "c")) %>% 
                    kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>% 
                    row_spec(7, bold = T, background = "#EEF5DB") %>% 
                    row_spec(8, bold = T) %>% 
                    add_header_above(c("Sample size"=3), background = "#666666", color = "#ffffff")
                output_data = gsub("</th></tr>.*</thead>","</thead>", output_data)
                v$res = output_data
            } else {
                res = cohort(RR=input$ind_rr, p1=input$ind_p2, r=input$r_ind, alpha=input$alpha_ind, power=input$beta_ind, two.side=twoside, drop_rate=input$dr_i/100, design = "independent")
                output_data = data.frame(
                    V1 = c(ifelse(twoside, "2-side significance level", "1-side significance level"), "Power (1-beta)", "Ratio of sample size, unexposed/exposed", "Relatvie Risk (p1/p0)","Drop rate (%)", "Result","", "Sample Size - Exposed", "Sample Size - Unexposed", "Total sample size"),
                    V2 = c(rep("", 6), "Fleiss", res$n_exposed, res$n_unexposed, res$n_exposed+res$n_unexposed),
                    V3 = c(input$alpha_ind, input$beta_ind, input$r_ind, input$ind_rr,input$dr_i, "", "Fleiss with correction for continuity", res$n_exposed_cc, res$n_unexposed_cc, res$n_exposed_cc+res$n_unexposed_cc)
                ) %>% 
                    knitr::kable("html", escape = F, align=c("l", "c", "c")) %>% 
                    kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>% 
                    row_spec(6, bold = T, background = "#EEF5DB") %>% 
                    row_spec(7, bold = T) %>% 
                    add_header_above(c("Sample size"=3), background = "#666666", color = "#ffffff")
                output_data = gsub("</th></tr>.*</thead>","</thead>", output_data)
                v$res = output_data
            }
        }
        if (design() == "Cohort" & input$cohortDesign=="independent" & input$independentDesign=="independentContinuous") {
            twoside = ifelse(is.null(input$checkbox8), F, T)
            res = cross_sectional(p1=input$indc_m1, p2=input$indc_m2, variance=(input$sd_indc)^2, r=input$r_indc, alpha=input$alpha_indc, power=input$beta_indc, two.side=twoside, design = "continuous")
            output_data = data.frame(
                V1 = c(ifelse(twoside, "2-side significance level", "1-side significance level"), "Power (1-beta)", "Ratio of sample size, unexposed/exposed group", "Expected mean in unexposed group", "Expected mean in exposed group", "Population standard deviation", "Result", "Sample Size - unexposed group", "Sample Size - exposed group", "Total sample size"),
                V2 = c(input$alpha_indc, input$beta_indc, input$r_indc, input$indc_m1, input$indc_m2, input$sd_indc, "", res$n1, res$n2, res$n1+res$n2)
            ) %>% 
                knitr::kable("html", escape = F, align=c("l", "c")) %>% 
                kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>% 
                row_spec(7, bold = T, background = "#EEF5DB") %>% 
                add_header_above(c("Sample size"=2), background = "#666666", color = "#ffffff")
            output_data = gsub("</th></tr>.*</thead>","</thead>", output_data)
            v$res = output_data
        }
        if (design() == "Cohort" & input$cohortDesign=="paired") {
            twoside = ifelse(is.null(input$checkbox4), F, T)
            if (input$radiobar8=="cohortpproportion") {
                res=cohort(p1=input$cohort_pair_p0, p2=input$cohort_pair_p1, alpha=input$alpha_cohort_pair, power=input$beta_cohort_pair, two.side=twoside, drop_rate=input$dr_pair/100, design = "paired")
                output_data = data.frame(
                    V1 = c(ifelse(twoside, "2-side significance level", "1-side significance level"), "Power (1-beta)", "Probability of event in the exposed group", "Probability of event in the unexposed group", "Drop rate (%)", "Result", "Sample Size - Exposed", "Sample Size - Unexposed", "Total sample size"),
                    V2 = c(input$alpha_cohort_pair, input$beta_cohort_pair, input$cohort_pair_p0, input$cohort_pair_p1, input$dr_pair, "", res$n_exposed, res$n_unexposed, res$n_exposed+res$n_unexposed)
                ) %>% 
                    knitr::kable("html", escape = F, align=c("l", "c", "c")) %>% 
                    kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>% 
                    row_spec(6, bold = T, background = "#EEF5DB") %>% 
                    add_header_above(c("Sample size"=2), background = "#666666", color = "#ffffff")
                output_data = gsub("</th></tr>.*</thead>","</thead>", output_data)
                v$res = output_data
            } else {
                res=cohort(p1=input$cohort_pair_p2, RR=input$cohort_pair_rr, alpha=input$alpha_cohort_pair, power=input$beta_cohort_pair, two.side=twoside, drop_rate=input$dr_pair/100, design = "paired")
                output_data = data.frame(
                    V1 = c(ifelse(twoside, "2-side significance level", "1-side significance level"), "Power (1-beta)", "Relative risk", "Probability of event in the unexposed group", "Drop rate (%)", "Result", "Sample Size - Exposed", "Sample Size - Unexposed", "Total sample size"),
                    V2 = c(input$alpha_cohort_pair, input$beta_cohort_pair, input$cohort_pair_rr, input$cohort_pair_p2, input$dr_pair, "", res$n_exposed, res$n_unexposed, res$n_exposed+res$n_unexposed)
                ) %>% 
                    knitr::kable("html", escape = F, align=c("l", "c", "c")) %>% 
                    kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>% 
                    row_spec(6, bold = T, background = "#EEF5DB") %>% 
                    add_header_above(c("Sample size"=2), background = "#666666", color = "#ffffff")
                output_data = gsub("</th></tr>.*</thead>","</thead>", output_data)
                v$res = output_data
            }
        }
        if (design() == "Cohort" & input$cohortDesign=="cohorttte") {
            twoside = ifelse(is.null(input$checkbox5), F, T)
            if (input$radiobar5 == "known") {
                res = cohort_survival(p1=input$cohort_tte_p1, p2=input$cohort_tte_p2, HR=input$cohort_tte_hr, r=input$r_cohort_tte, alpha=input$alpha_cohort_tte, power=input$beta_cohort_tte, two.side=twoside)
            } else {
                res = cohort_survival(ta=input$cohort_tte_timea, tb=input$cohort_tte_timeb, HR=input$cohort_tte_hr, lambda=input$cohort_tte_lambda0, r=input$r_cohort_tte, alpha=input$alpha_cohort_tte, power=input$beta_cohort_tte, two.side=twoside)
            }
            output_data = data.frame(
                V1 = c(ifelse(twoside, "2-side significance level", "1-side significance level"), "Power (1-beta)", "Ratio of sample size, unexposed/exposed", "Hazard ratio", "Probability of event in the exposed group", "Probability of event in the unexposed group", "Result", "Sample Size - Exposed", "Sample Size - Unexposed", "Total sample size"),
                V2 = c(input$alpha_cohort_tte, input$beta_cohort_tte, input$r_cohort_tte, input$cohort_tte_hr, round(res$p2,3), round(res$p1,3), "", res$n_exposed, res$n_unexposed, res$n_exposed+res$n_unexposed)
            ) %>% 
                knitr::kable("html", escape = F, align=c("l", "c")) %>% 
                kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>% 
                row_spec(7, bold = T, background = "#EEF5DB") %>% 
                add_header_above(c("Sample size"=2), background = "#666666", color = "#ffffff")
            output_data = gsub("</th></tr>.*</thead>","</thead>", output_data)
            v$res = output_data
        }
        if (design() == "CrossSectional" & input$crossDesign=="crosscontinuous") {
            twoside = ifelse(is.null(input$checkbox6), F, T)
            res = cross_sectional(p1=input$cross_m1, p2=input$cross_m2, variance=(input$sd_cross)^2, r=input$r_cross, alpha=input$alpha_cross, power=input$beta_cross, two.side=twoside, design = "continuous")
            output_data = data.frame(
                V1 = c(ifelse(twoside, "2-side significance level", "1-side significance level"), "Power (1-beta)", "Ratio of sample size, first group/second group", "Expected mean in first group", "Expected mean in second group", "Population standard deviation", "Result", "Sample Size - first group", "Sample Size - second group", "Total sample size"),
                V2 = c(input$alpha_cross, input$beta_cross, input$r_cross, input$cross_m1, input$cross_m2, input$sd_cross, "", res$n1, res$n2, res$n1+res$n2)
            ) %>% 
                knitr::kable("html", escape = F, align=c("l", "c")) %>% 
                kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>% 
                row_spec(7, bold = T, background = "#EEF5DB") %>% 
                add_header_above(c("Sample size"=2), background = "#666666", color = "#ffffff")
            output_data = gsub("</th></tr>.*</thead>","</thead>", output_data)
            v$res = output_data
        }
        if (design() == "CrossSectional" & input$crossDesign=="crossproportion") {
            twoside = ifelse(is.null(input$checkbox7), F, T)
            if (input$radiobar6=="crossproportion") {
                res = cross_sectional(p1=input$cross_p1, p2=input$cross_p2, r=input$r_cross_p, alpha=input$alpha_cross_p, power=input$beta_cross_p, two.side=twoside, design = "proportion")
                output_data = data.frame(
                    V1 = c(ifelse(twoside, "2-side significance level", "1-side significance level"), "Power (1-beta)", "Ratio of sample size, first group/second group", "Probability of event in first group", "Probability of event in second group", "Result", "", "Sample Size - first group", "Sample Size - second group", "Total sample size"),
                    V2 = c(rep("", 6), "Fleiss", res$n1, res$n2, res$n1+res$n2),
                    V3 = c(input$alpha_cross_p, input$beta_cross_p, input$r_cross_p, input$cross_p1, input$cross_p2, "", "Fleiss with correction for continuity", res$n1_cc, res$n2_cc, res$n1_cc+res$n2_cc)
                ) %>% 
                    knitr::kable("html", escape = F, align=c("l", "c", "c")) %>% 
                    kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>% 
                    row_spec(6, bold = T, background = "#EEF5DB") %>% 
                    row_spec(7, bold = T) %>% 
                    add_header_above(c("Sample size"=3), background = "#666666", color = "#ffffff")
                output_data = gsub("</th></tr>.*</thead>","</thead>", output_data)
                v$res = output_data
            } else {
                res =cross_sectional(p2=input$cross_p3, RR=input$cross_rr, r=input$r_cross_p, alpha=input$alpha_cross_p, power=input$beta_cross_p, two.side=twoside, design = "proportion")
                output_data = data.frame(
                    V1 = c(ifelse(twoside, "2-side significance level", "1-side significance level"), "Power (1-beta)", "Ratio of sample size, first group/second group", "Relatvie Risk (p2/p1)", "Result","", "Sample Size - first group", "Sample Size - second group", "Total sample size"),
                    V2 = c(rep("", 5), "Fleiss", res$n1, res$n2, res$n1+res$n2),
                    V3 = c(input$alpha_cross_p, input$beta_cross_p, input$r_cross_p, input$cross_rr, "", "Fleiss with correction for continuity", res$n1_cc, res$n2_cc, res$n1_cc+res$n2_cc)
                ) %>% 
                    knitr::kable("html", escape = F, align=c("l", "c", "c")) %>% 
                    kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>% 
                    row_spec(5, bold = T, background = "#EEF5DB") %>% 
                    row_spec(6, bold = T) %>% 
                    add_header_above(c("Sample size"=3), background = "#666666", color = "#ffffff")
                output_data = gsub("</th></tr>.*</thead>","</thead>", output_data)
                v$res = output_data
            }
        }
        if (design() == "Survey" & input$surveyDesign=="surveycontinuous") {
            res = survey(v=input$survey_sd, d=input$survey_sd_d, alpha=input$alpha_survey_c, two.side=T, design="continuous")
            output_data = data.frame(
                V1 = c("2-side significance level", "SD", "d", "Result", "Total sample size"),
                V2 = c(input$alpha_survey_c, input$survey_sd, input$survey_sd_d, "", res$n)
            ) %>% 
                knitr::kable("html", escape = F, align=c("l", "c")) %>% 
                kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>% 
                row_spec(4, bold = T, background = "#EEF5DB") %>% 
                add_header_above(c("Sample size"=2), background = "#666666", color = "#ffffff")
            output_data = gsub("</th></tr>.*</thead>","</thead>", output_data)
            v$res = output_data
        }
        if (design() == "Survey" & input$surveyDesign=="surveyproportion") {
            res = survey(v=input$survey_p, d=input$survey_p_d, alpha=input$alpha_survey_p, two.side=T, design="proportion")
            output_data = data.frame(
                V1 = c("2-side significance level", "p", "d", "Result", "Total sample size"),
                V2 = c(input$alpha_survey_p, input$survey_p, input$survey_p_d, "", res$n)
            ) %>% 
                knitr::kable("html", escape = F, align=c("l", "c")) %>% 
                kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>% 
                row_spec(4, bold = T, background = "#EEF5DB") %>% 
                add_header_above(c("Sample size"=2), background = "#666666", color = "#ffffff")
            output_data = gsub("</th></tr>.*</thead>","</thead>", output_data)
            v$res = output_data
        }
        if (design() == "PredictionModel") {
            if (input$pmDesign == "binary_pm") {
                if (is.null(input$checkbox9)) {
                    mes = tryCatch(capture.output(pmsampsize('b', rsquared = input$rsquared_binary_pm, parameters = input$parameters_binary_pm, shrinkage = input$shrinkage_binary_pm, prevalence = input$prevalence_binary_pm)),
                                   error = function(e) {print(e)})
                } else {
                    mes = tryCatch(capture.output(pmsampsize('b', cstatistic = input$cstatistic_binary_pm, parameters = input$parameters_binary_pm, prevalence = input$prevalence_binary_pm)),
                                   error = function(e) {print(e)})
                }
                v$res = paste("<pre>", paste(mes, collapse = "<br/>"), "</pre>", sep="")
            }
            if (input$pmDesign == "time_to_event_pm") {
                mes = tryCatch(capture.output(pmsampsize('s', rsquared = input$rsquared_tte_pm, parameters = input$parameters_tte_pm, shrinkage = input$shrinkage_tte_pm, rate = input$rate_tte_pm, timepoint = input$timepoint_tte_pm, meanfup = input$meanfup_tte_pm)),
                               error = function(e) {print(e)})
                v$res = paste("<pre>", paste(mes, collapse = "<br/>"), "</pre>", sep="")
            }
            if (input$pmDesign == "continuous_pm") {
                mes = tryCatch(capture.output(pmsampsize('c', rsquared = input$rsquared_continuous_pm, parameters = input$parameters_continuous_pm, shrinkage = input$shrinkage_continuous_pm, intercept = input$intercept_continuous_pm, sd = input$sd_continuous_pm, mmoe = input$mmoe_continuous_pm)),
                               error = function(e) {print(e)})
                v$res = paste('<pre>', paste(mes, collapse = "<br/>"), "</pre>", sep="")
            }
        }
        if (design() == "TwoAUC") {
            res = auc(beta=input$auc_main_power, alpha=input$auc_main_alpha, theta=input$auc_main_auc1, theta0=input$auc_main_auc0, prevalence=input$auc_main_prevalence)
            output_data = data.frame(
                V1 = c("Number of positive cases", "Number of negative cases", "Total sample size"),
                V2 = c(res$ncase, res$ncontrol, res$ncase+res$ncontrol)
            ) %>% 
                knitr::kable("html", escape = F, align=c("l", "c")) %>% 
                kable_styling(bootstrap_options = c("striped", "hover"), full_width = F) %>% 
                #row_spec(4, bold = T, background = "#EEF5DB") %>% 
                add_header_above(c("Sample size"=2), background = "#666666", color = "#ffffff")
            output_data = gsub("</th></tr>.*</thead>","</thead>", output_data)
            v$res = output_data
        }
        shinyjs::show("tableOutput", anim = T)
        })
    
    output$summary_table <- renderText({
        v$res
    })

    observe({
        lapply(names(input)[names(input)!="run"], function(x) {
            observeEvent(input[[x]], {
                shinyjs::hide("tableOutput", anim = T)
                v$res = NULL
            })
        })
    })
}
