model = readRDS('model')

# Reference table
g1 <- "0 - 0.2"
g2 <- "0.2 - 0.4"
g3 <- "0.4 - 0.6"
g4 <- "0.6 - 0.8"
g5 <- "0.8 - 1"
rate1 <- c(43, 26, 5)
rate2 <- c(59, 33, 10)
rate3 <- c(57, 37, 17)
rate4 <- c(80, 62, 31)
rate5 <- c(82, 71, 47)
ratec1 <- c(76, 57, 31)
ratec2a <- c(61, 42, 16)
ratec2b <- c(45, 16, 8)

predict_response = function(newdata) {
    attribs <- match(names(model$tables), names(newdata))
    isnumeric <- sapply(newdata, is.numeric)
    islogical <- sapply(newdata, is.logical)
    newdata <- data.matrix(newdata)
    threshold = 0.001
    eps = 0
    L <- sapply(1:nrow(newdata), function(i) {
        ndata <- newdata[i, ]
        L <- log(model$apriori) + apply(log(sapply(seq_along(attribs),
                                                   function(v) {
                                                       nd <- ndata[attribs[v]]
                                                       if (is.na(nd)) rep(1, length(model$apriori)) else {
                                                           prob <- if (isnumeric[attribs[v]]) {
                                                               msd <- model$tables[[v]]
                                                               msd[, 2][msd[, 2] <= eps] <- threshold
                                                               dnorm(nd, msd[, 1], msd[, 2])
                                                           } else model$tables[[v]][, nd + islogical[attribs[v]]]
                                                           prob[prob <= eps] <- threshold
                                                           prob
                                                       }
                                                   })), 1, sum)
        ## Numerically unstable:
        ##            L <- exp(L)
        ##            L / sum(L)
        ## instead, we use:
        sapply(L, function(lp) {
            1/sum(exp(L - lp))
        })
    })
    round(t(L)[2], 3)
}

library(shiny)
shinyServer(function(input, output){
    data <- eventReactive(input$goButton, {
        # Standardization parameters
        ef_mn <- 23.1075
        ef_sd <- 9.0848
        lvedd_mn <- 6.0675
        lvedd_sd <- 1.0870
        qrsd_mn <- 158.0184
        qrsd_sd <- 28.8009
        nyha_mn <- 2.8919
        nyha_sd <- 0.4489
        
        # raw input
        ICM_in = input$ICM_in == 'ischemic'
        validate(need(!is.na(input$ef_in_raw) & as.numeric(input$ef_in_raw) >=0 & as.numeric(input$ef_in_raw) <= 100, "Please input a valid Left ventricular ejection fraction (0-100)"))
        ef_in_raw = as.numeric(input$ef_in_raw)
        validate(need(!is.na(input$lvedd_in_raw) & as.numeric(input$lvedd_in_raw) >= 0, "Please input a valid Left ventricular end-diastolic diameter"))
        lvedd_in_raw = as.numeric(input$lvedd_in_raw)
        gender_in = input$gender_in == 'Male'
        validate(need(!is.na(input$qrsd_in_raw) & as.numeric(input$qrsd_in_raw) >= 0, "Please input a valid QRS duration (continuous variable in milliseconds, infinite range)"))
        qrsd_in_raw = as.numeric(input$qrsd_in_raw)
        AF_in = input$AF_in == 'Yes'
        validate(need(!is.na(input$nyha_in_raw) & as.numeric(input$nyha_in_raw) >= 0 & as.numeric(input$nyha_in_raw) <= 4, "Please input a valid NYHA heart failure classification"))
        nyha_in_raw = as.numeric(input$nyha_in_raw)
        epi_in = input$epi_in == "Yes"
        morph_in = input$morph_in
        
        ef_in <- (ef_in_raw - ef_mn)/ef_sd
        qrsd_in <- (qrsd_in_raw - qrsd_mn)/qrsd_sd
        nyha_in <- (nyha_in_raw - nyha_mn)/nyha_sd
        lvedd_in <- (lvedd_in_raw - lvedd_mn)/lvedd_sd
        LBBB_in <- FALSE
        RBBB_in <- FALSE
        IVCD_in <- FALSE
        PACE_in <- FALSE
        if(input$morph_in == "LBBB")
            LBBB_in <- TRUE
        if(input$morph_in == "RBBB")
            RBBB_in <- TRUE
        if(input$morph_in == "IVCD")
            IVCD_in <- TRUE
        if(input$morph_in == "RV-paced")
            PACE_in <- TRUE
        
        data <- data.frame(ICM_in, ef_in, lvedd_in, gender_in, qrsd_in, LBBB_in, PACE_in, RBBB_in, IVCD_in, AF_in, nyha_in, epi_in)
        names(data) <- c("V1", "V2", "V3", "V4", "V5", "V6", "V7", "V8", "V9", "V10", "V11", "V12")
        
        # Estimate 2013 ACCF/AHA Heart Failure Guidelines
        class <- FALSE
        if (morph_in == "LBBB" & qrsd_in_raw >= 150 & ef_in_raw <= 35 & nyha_in_raw >= 2)
            class <- "Class I"
        if ((ef_in_raw <= 35 & (morph_in == "RBBB" | morph_in == "IVCD") & qrsd_in_raw >= 150 & nyha_in_raw >= 3) |
            (ef_in_raw <= 35 & morph_in == "LBBB" & qrsd_in_raw < 150 & qrsd_in_raw >= 120 & nyha_in_raw >= 2) |
            (ef_in_raw <= 35 & morph_in == "RV-paced"))
            class <- "Class IIa"
        if ((ef_in_raw <= 35 & (morph_in == "RBBB" | morph_in == "IVCD")  & qrsd_in_raw < 150 & qrsd_in_raw >= 120 & nyha_in_raw >= 3) |
            (ef_in_raw <= 35 &  (morph_in == "RBBB" | morph_in == "IVCD")  & qrsd_in_raw >= 150 & nyha_in_raw == 2) |
            (ef_in_raw <= 30 & ICM_in == TRUE & morph_in == "LBBB" & qrsd_in_raw >= 150 & nyha_in_raw == 1))
            class <- "Class IIb"
        
        list(data = data, class = class)})
    
    output$result <- renderUI({
        data_list = data()
        response_score = predict_response(data_list[['data']])
        class = data_list[['class']]
        
        ########### Format a final additional output message ################
        if (response_score <= .2)
        {g <- g1
        rate <- rate1}
        if (response_score >.2 & response_score <=.4)
        {g <- g2
        rate <- rate2}
        if (response_score >.4 & response_score <=.6)
        {g <- g3
        rate <- rate3}
        if (response_score >.6 & response_score <=.8)
        {g <- g4
        rate <- rate4}
        if (response_score >.8)
        {g <- g5
        rate <- rate5}
        
        if (class == "Class I")
            ratec <- ratec1
        if (class == "Class IIa")
            ratec <- ratec2a
        if (class == "Class IIb")
            ratec <- ratec2b
        
        
        if (class!=FALSE)  
        {Message <- paste("<p>Based on input parameters, this patient is most likely to meet 2013 ACCF/AHA",class, "criteria. ",
                          class, " patients had the following response rates:<br>
5% LVEF improvement: ",toString(ratec[1]),"%<br>
10% LVEF improvement: ",toString(ratec[2]),"%<br>
20% LVEF improvement: ",toString(ratec[3]),"%<br><br>

The CRT response score may offer more accurate prediction of outcomes.<br>
Based on input parameters, this patient has a CRT response score of ", toString(response_score),
                          ". Patients with a response score between ", g ," had the following response rates:<br>
5% LVEF improvement: ",toString(rate[1]),"%<br>
10% LVEF improvement: ",toString(rate[2]),"%<br>
20% LVEF improvement: ",toString(rate[3]),"%.<br>
<br>
                          This response score calculator was created using a Naïve Bayes classifier. The model was developed and cross-validated from a training cohort of 470 CRT patients (235 from Johns Hopkins Hospital and 235 from the Cleveland Clinic).<br>
                          Based on the user’s input parameters, the calculator outputs whether the patient meets 2013 ACCF/AHA Class I, IIa, or IIb criteria, and provides the corresponding echocardiographic response rates observed in a separate testing cohort of 455 CRT patients from the Cleveland Clinic. <br>
                          The calculator then provides the Machine Learning Response Score generated by the Naïve Bayes classifier and provides the echocardiographic response rates observed in the testing cohort of 455 CRT patients from the Cleveland Clinic who fell into the corresponding bin of the Machine Learning Response Score. Rates were observed in the Machine Learning Response Score bins of: 0-0.2, 0.2-0.4, 0.6-0.8, 0.8-1.<br>
                          Manuscript pending, link to manuscript to follow.</p>")}
        
        if (class==FALSE)  
        {Message <- paste("<p>Based on input parameters, this patient most likely does not meet 2013 ACCF/AHA Class I, IIa, or IIb criteria.<br><br>
                  
The CRT response score may offer more accurate prediction of outcomes.<br>
Based on input parameters, this patient has a CRT response score of ", toString(response_score),
                          ". Patients with a response score between ", g ," had the following response rates:<br>
5% LVEF improvement: ",toString(rate[1]),"%<br>
10% LVEF improvement: ",toString(rate[2]),"%<br>
20% LVEF improvement: ",toString(rate[3]),"%.<br>
<br>
This response score calculator was created using a Naïve Bayes classifier. The model was developed and cross-validated from a training cohort of 470 CRT patients (235 from Johns Hopkins Hospital and 235 from the Cleveland Clinic).<br>
Based on the user’s input parameters, the calculator outputs whether the patient meets 2013 ACCF/AHA Class I, IIa, or IIb criteria, and provides the corresponding echocardiographic response rates observed in a separate testing cohort of 455 CRT patients from the Cleveland Clinic. <br>
The calculator then provides the Machine Learning Response Score generated by the Naïve Bayes classifier and provides the echocardiographic response rates observed in the testing cohort of 455 CRT patients from the Cleveland Clinic who fell into the corresponding bin of the Machine Learning Response Score. Rates were observed in the Machine Learning Response Score bins of: 0-0.2, 0.2-0.4, 0.6-0.8, 0.8-1.<br>
Manuscript pending, link to manuscript to follow.</p>")}
        
        HTML(Message)
    })
})