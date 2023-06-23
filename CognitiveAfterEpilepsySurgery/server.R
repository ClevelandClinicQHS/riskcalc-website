# Clinically relevant naming decline (decline of ≥ 5 raw score points on Boston Naming Test)”
predict.model1 <- expression({
    lp = -3.802 + 0.048 * age1 + 2.644 * (surgery == "Dominant") + 
        0.015 * age2 + 0.367 * (sex == "Female") - 0.049 * education
    100 / (1+exp(-lp))
})

# Moderate/severe naming decline (decline of ≥ 11 raw score points on Boston Naming Test)
predict.model2 <- expression({
    lp = -6.545 + 0.045 * age1 + 2.772 * (surgery == "Dominant") + 
        0.03 * bnt
    100 / (1+exp(-lp))
})

# Logical Memory delayed: clinically relevant decline (decline of >= 3 scaled score points)
predict.model3 <- expression({
    lp = -2.123 + 0.357 * lm + 1.339 * (surgery == "Dominant") - 0.256 * education
    100 / (1+exp(-lp))
})

# Verbal Paired Associates delayed: clinically relevant decline (decline of ≥ 3 scaled score points)
predict.model4 <- expression({
    lp = -3.398 + 0.310 * vpa + 1.663 * (surgery == "Dominant") - 0.145 * education
    100 / (1+exp(-lp))
})

# Rey Auditory Verbal Learning Test delayed: clinically relevant decline (decline of ≥ 4 raw points)
predict.model5 <- expression({
    lp = -7.068 + .246 * avlt + 2.635 * (surgery == "Dominant") + 2.160 * (hippocampus == "To Be Resected")
    100 / (1+exp(-lp))
})

shinyServer(function(input, output, session){
    
    observeEvent({list(input$age1, input$age2, input$vpa, input$hippocampus, input$surgery,
                       input$sex, input$education, input$education2, input$bnt, input$lm)},
                 {
                     shinyjs::hide("result_panel")
                 })
    
    observeEvent(input$goButton, {shinyjs::show('result_panel')})
    # input
    data <- eventReactive(input$goButton, {

        # validate the inputs
        shiny::validate(need(!is.na(input$age1) & input$age1>=0 & input$age1 <=60, 'Please input a valid Age at recurrent seizure onset'))
        shiny::validate(need(!is.na(input$age2) & input$age2>=16 & input$age2 <=75, 'Please input a valid Age at time of surgery'))
        shiny::validate(need(is.na(input$bnt) | (!is.na(input$bnt) & input$bnt>=20 & input$bnt <=60), 'Please input a valid Boston Naming Test Raw Score'))
        shiny::validate(need(is.na(input$lm) | (!is.na(input$lm) & input$lm>=1 & input$lm <=17), 'Please input a valid Preop Logical Memory (delayed) scaled score'))
        shiny::validate(need(is.na(input$avlt) | (!is.na(input$avlt) & input$avlt>=1 & input$avlt <=15), 'Please input a valid Preop Rey AVLT (delayed) scaled score'))
        shiny::validate(need(is.na(input$vpa) | (!is.na(input$vpa) & input$vpa>=1 & input$vpa <=20), 'Please input a valid Preop Verbal Paired Associates (delayed) scaled score'))
        shiny::validate(need(is.na(input$education2) | (input$education2>=2& input$education2<=12), 'Please input a valid Education in year'))
        shiny::validate(need(!is.na(input$bnt)|!is.na(input$lm)|!is.na(input$avlt)|!is.na(input$vpa), 'Please input at least one valid test score'))
        
        # clean inputs
        age1 = input$age1
        surgery = input$surgery
        age2 = input$age2
        sex = input$sex
        education = ifelse(input$education == "Less than completed high school", input$education2,
                           ifelse(input$education == "High School Diploma", 12,
                                  ifelse(input$education == "Associate’s Degree", 14,
                                         ifelse(input$education == "Bachelor's Degree", 16,
                                                ifelse(input$education == "Master's Degree", 18,
                                                       ifelse(input$education == "Juris Doctor", 19, 20))))))
        bnt = input$bnt
        avlt = input$avlt
        lm = input$lm
        vpa = input$vpa
        hippocampus = input$hippocampus
        
        # create data frame from input
        data <- data.frame(age1 = age1,
                           surgery = surgery,
                           age2 = age2,
                           sex = sex,
                           education = education,
                           bnt = bnt,
                           lm = lm,
                           avlt = avlt,
                           vpa = vpa,
                           hippocampus = hippocampus)
        data})
    
    # output table
    output$result <- DT::renderDataTable({
        data = data()
        prob.model1 = round(eval(predict.model1, data), 0)
        prob.model1 = ifelse(prob.model1 < 1, "<1", ifelse(prob.model1 > 99, ">99%", paste(prob.model1, "%", sep="")))
        prob.model2 = round(eval(predict.model2, data), 0)
        prob.model2 = ifelse(prob.model2 < 1, "<1", ifelse(prob.model2 > 99, ">99%", paste(prob.model2, "%", sep="")))
        prob.model3 = round(eval(predict.model3, data), 0)
        prob.model3 = ifelse(prob.model3 < 1, "<1", ifelse(prob.model3 > 99, ">99%", paste(prob.model3, "%", sep="")))
        prob.model4 = round(eval(predict.model4, data), 0)
        prob.model4 = ifelse(prob.model4 < 1, "<1", ifelse(prob.model4 > 99, ">99%", paste(prob.model4, "%", sep="")))
        prob.model5 = round(eval(predict.model5, data), 0)
        prob.model5 = ifelse(prob.model5 < 1, "<1", ifelse(prob.model5 > 99, ">99%", paste(prob.model5, "%", sep="")))
        print(c(prob.model1, prob.model2, prob.model3, prob.model4, prob.model5))

        res = NULL
        if (!is.na(input$bnt)) {
            res = data.frame(Result = c("Clinically relevant naming decline (decline of ≥ 5 raw score points on Boston Naming Test)",
                                        "Moderate/severe naming decline (decline of ≥ 11 raw score points on Boston Naming Test)"),
                             Probability = c(prob.model1, prob.model2))
        }
        
        if (!is.na(input$lm)) {
            res = rbind(res, 
                        data.frame(Result=c("Logical Memory delayed: clinically relevant decline (decline of ≥ 3 scaled score points)"),
                                   Probability = c(prob.model3)))
        }
        if (!is.na(input$vpa)) {
            res = rbind(res, 
                        data.frame(Result=c("Verbal Paired Associates delayed: clinically relevant decline (decline of ≥ 3 scaled score points)"),
                                   Probability = c(prob.model4)))
        }
        
        if (!is.na(input$avlt)) {
            res = rbind(res,
                        data.frame(Result = "Rey Auditory Verbal Learning Test delayed: clinically relevant decline (decline of ≥ 4 raw points)",
                                   Probability = prob.model5))
        }
        
        res
    }, options = list(
        pageLength = 10,
        lengthMenu = 0,
        
        searching = 0,
        processing = 0,
        info = 0,
        paging = 0,
        initComplete = I(
            "function(settings, json) {
                    $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
            }")))
})
