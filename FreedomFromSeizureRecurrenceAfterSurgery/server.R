predict.seizure <- expression({
    lp <- -1.0013748 + 
        0.17147954 * (Gender == "Male") +
        0.030591547 * Time_Between_Onset_Surgery + 
        0.01426345 * Preop_Seizure_Freq - 
        5.6841122e-06 * max(Preop_Seizure_Freq - 1, 0)**3 + 
        6.0393692e-06 * max(Preop_Seizure_Freq - 8, 0)**3 - 
        3.5525701e-07 * max(Preop_Seizure_Freq - 120, 0)**3 + 
        0.2493218 * (GTC == "Yes") +
        0.30567553 * (Type_of_Surgery == "Posterior Quadrant Resection") +
        0.69716419 * (Type_of_Surgery == "Temporal Lobectomy") -
        0.18501013 * (Pathology == "Mesial Temporal Sclerosis (MTS)") + 
        0.22943359 * (Pathology == "Other") -
        0.11752082 * (Pathology == "Stroke") - 
        0.1937336 * (Pathology == "Tumor") +
        Time_Between_Onset_Surgery * (-0.012484291 * (Type_of_Surgery == "Posterior Quadrant Resection") - 0.03446819 * (Type_of_Surgery == "Temporal Lobectomy"))
})
predict.engel <- expression({
    lp <- 0.18730607 - 
        0.00015509726 * Preop_Seizure_Freq + 
        0.31145558 * (GTC == "Yes") -
        0.17091902 * (Type_of_Surgery == "Posterior Quadrant Resection") -
        0.47992667 * (Type_of_Surgery == "Temporal Lobectomy") -
        0.34591101 * (Pathology == "Mesial Temporal Sclerosis (MTS)") + 
        0.15970739 * (Pathology == "Other") +
        0.029226894 * (Pathology == "Stroke") - 
        0.29697953 * (Pathology == "Tumor") + 
        Preop_Seizure_Freq * (0.00038221492 * (Type_of_Surgery == "Posterior Quadrant Resection") + 0.0028974716 * (Type_of_Surgery == "Temporal Lobectomy"))
})
pred_test <- expression({
    lp <- 0.7551 * (GTC == "Yes") + 
        0.0011 * Preop_Seizure_Freq - 
        0.3278 * (Pathology == "Mesial Temporal Sclerosis (MTS)") +
        -0.0218 * (normalmri == "Normal") + 
        0.4283 * (nonlocal == "Sometimes non-localizable") +
        -0.1314 * (bilateral == "Bilateral") +  
        -1.2614 * (bilateral == "No Epileptiform Discharges") +
        -0.4442 * (Type_of_Surgery == "Temporal Lobectomy") + 
        0.6571 * (Type_of_Surgery == "Temporal Lobectomy") * (bilateral == "Bilateral") + 
        -0.3739 * (normalmri == "Normal") * (bilateral == "Bilateral") +
        1.1084 * (Type_of_Surgery == "Temporal Lobectomy") * (bilateral == "No Epileptiform Discharges") + 
        0.4832 * (normalmri == "Normal") * (bilateral == "No Epileptiform Discharges") 
    exp(-0.39 * exp(lp))
})

shinyServer(function(input, output, session){
    
    observeEvent({list(input$Time_Between_Onset_Surgery, input$Preop_Seizure_Freq, input$Gender, input$GTC, input$Pathology,
                      input$Type_of_Surgery, input$normalmri, input$bilateral, input$nonlocal, input$reset_input)},
                {
                    shinyjs::hide("result_panel")
                })

    observeEvent(input$goButton, {shinyjs::show('result_panel')})
    
    observeEvent(input$reset_input, {
        updateNumericInput(session, "Time_Between_Onset_Surgery", value = NA)
        updateNumericInput(session, "Preop_Seizure_Freq", value = 0)
        updateSelectInput(session, "Gender", selected="")
        updateSelectInput(session, "GTC", selected = "No")
        updateSelectInput(session, "Pathology", selected = 'Mesial Temporal Sclerosis (MTS)')
        updateSelectInput(session, "Type_of_Surgery", selected = 'Temporal Lobectomy')
        updateSelectInput(session, "normalmri", selected = '')
        updateSelectInput(session, "bilateral", selected = '')
        updateSelectInput(session, "nonlocal", selected = '')
    })
    
    data <- eventReactive(input$goButton, {
        validate(need(is.na(as.numeric(input$Time_Between_Onset_Surgery))|(!is.na(as.numeric(input$Time_Between_Onset_Surgery))& as.numeric(input$Time_Between_Onset_Surgery)>=0& as.numeric(input$Time_Between_Onset_Surgery)<=65), 'Please input a valid Epilepsy Duration at Time of Surgery (in Years)'))
        Time_Between_Onset_Surgery= as.numeric(input$Time_Between_Onset_Surgery)
        validate(need(!is.na(as.numeric(input$Preop_Seizure_Freq))& as.numeric(input$Preop_Seizure_Freq)>=0, 'Please input a valid Preoperative Seizure Frequency (per Month)'))
        Preop_Seizure_Freq= as.numeric(input$Preop_Seizure_Freq)
        Gender = input$Gender
        GTC = input$GTC
        Pathology = input$Pathology
        Type_of_Surgery = input$Type_of_Surgery
        normalmri = input$normalmri
        bilateral = input$bilateral
        nonlocal = input$nonlocal
        
        validate(need((!is.na(Time_Between_Onset_Surgery)&Gender!="")|(normalmri!=""&bilateral!=""&nonlocal!=""), 'Please input values into at least one section'))
        
        data <- data.frame(Time_Between_Onset_Surgery = Time_Between_Onset_Surgery,
                           Preop_Seizure_Freq = Preop_Seizure_Freq,
                           Gender = Gender,
                           GTC = GTC,
                           Pathology = Pathology,
                           Type_of_Surgery = Type_of_Surgery,
                           normalmri = normalmri,
                           bilateral = bilateral,
                           nonlocal = nonlocal)
        data})
    output$result <- DT::renderDataTable({
        data = data()
        prob.2yrSeizure <- 0.5657125 ** exp(eval(predict.seizure, data))
        prob.5yrSeizure <- 0.3983821 ** exp(eval(predict.seizure, data))
        prob.2yrEngel <- 0.6903864 ** exp(eval(predict.engel, data))
        prob.5yrEngel <- 0.615039 ** exp(eval(predict.engel, data))
        prob.2yrSeizure = ifelse(prob.2yrSeizure<0.001, "<0.1%", ifelse(prob.2yrSeizure>0.999, ">99.9%", paste(round(prob.2yrSeizure*100,1),"%",sep="")))
        prob.5yrSeizure = ifelse(prob.5yrSeizure<0.001, "<0.1%", ifelse(prob.5yrSeizure>0.999, ">99.9%", paste(round(prob.5yrSeizure*100,1),"%",sep="")))
        prob.2yrEngel = ifelse(prob.2yrEngel<0.001, "<0.1%", ifelse(prob.2yrEngel>0.999, ">99.9%", paste(round(prob.2yrEngel*100,1),"%",sep="")))
        prob.5yrEngel = ifelse(prob.5yrEngel<0.001, "<0.1%", ifelse(prob.5yrEngel>0.999, ">99.9%", paste(round(prob.5yrEngel*100,1),"%",sep="")))
        pred = eval(pred_test, envir = data)
        pred = ifelse(pred<0.001, "<0.1%", ifelse(pred>0.999, ">99.9%", paste(round(pred*100,1),"%",sep="")))
        res = NULL
        if (input$nonlocal!="" & input$normalmri!="" & input$bilateral!="") {
            res = data.frame(Result = "2-Year Probability of Seizure Freedom [2]",
                                   Probability = pred)
        } else if (!is.na(input$Time_Between_Onset_Surgery) & input$Gender!="") {
            res = data.frame(Result = c("2-Year Probability of Seizure Freedom [1]",
                                        "5-Year Probability of Seizure Freedom [1]"),
                             Probability = c(prob.2yrSeizure, prob.5yrSeizure))
        }
        res = rbind(res,
                    data.frame(Result = c(
                        "2-Year Probability for an Engel Score of 1 [1]",
                        "5-Year Probability for an Engel Score of 1 [1]"),
                        Probability = c(prob.2yrEngel, prob.5yrEngel)))
        
        res}, options = list(
            pageLength = 10,
            lengthMenu = 0,
            processing = 0,
            searching = 0,
            info = 0,
            paging = 0,
            initComplete = I(
                "function(settings, json) {
                    $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
            }")))
})
