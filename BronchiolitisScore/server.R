library(dplyr)

# primary outcome, EarlyIntubation == Yes
fit12 = expression({
    lp = 0.23763378 - 0.032435667 * Weight + 0.17753318 * Comorbid + 
        0.0013300196 * Low.HR + 0.0029345491 * High.RR + 0.041279304 * 
        High.T + 0.0072311595 * Lowest.Bicarb + 0.0058522926 * 
        High.Blood.Urea.Nitrogen + 0.009206708 * Worst.Glascow.Coma.Score - 
        2.3947371 * Lowest.pH.Highest.PCO2
    exp(lp)

})
# secondary outcome, EarlyIntubation == Yes
fit14 = expression({
    lp = 0.85872367 - 0.024895754 * Weight + 0.20520599 * Comorbid + 
        0.027718482 * (Time.from.Hospital.Admission.to.ICU.Admission/24) + 
        0.0010230476 * Low.HR + 0.0019603409 * High.RR + 0.031566845 * 
        High.T + 0.0087612476 * Lowest.Bicarb + 0.0087072436 * 
        High.Blood.Urea.Nitrogen - 2.0771666 * Lowest.pH.Highest.PCO2
    exp(lp)
})


# primary outcome, EarlyIntubation == No
fit16 = expression({
    lp = 0.13495978 - 0.047569376 * Weight + 0.25634568 * Comorbid + 
        0.22836409 * (Time.from.Hospital.Admission.to.ICU.Admission/24) - 
        0.18261844 * max((Time.from.Hospital.Admission.to.ICU.Admission/24) - 0.01, 0)**3 + 
        0.2078864 * max((Time.from.Hospital.Admission.to.ICU.Admission/24) - 0.23, 0)**3 - 
        0.02526796 * max((Time.from.Hospital.Admission.to.ICU.Admission/24) - 1.82, 0)**3 - 
        0.0016863845 * High.HR + 0.00085414815 * 
        Low.HR + 0.0068569966 * High.RR + 0.097732914 * High.T + 
        0.068029788 * Low.T - 0.77680132 * Lowest.pH + 0.016001664 * 
        Highest.PCO2 - 0.0042005363 * Low.White.Blood.Cell.Count - 
        0.033464546 * Worst.Glascow.Coma.Score + 1.9659218 * 
        Lowest.pH.Highest.PCO2 - 0.04449575 * RSV.Positive
    exp(lp)
})
# secondary outcome, EarlyIntubation == No
fit18 = expression({
    lp = 0.095191442 - 0.052439594 * Weight + 0.28546333 * Comorbid + 
        0.27090746 * (Time.from.Hospital.Admission.to.ICU.Admission/24) - 
        0.21746335 * max((Time.from.Hospital.Admission.to.ICU.Admission/24) - 0.01, 0)**3 + 
        0.24755261 * max((Time.from.Hospital.Admission.to.ICU.Admission/24) - 0.23, 0)**3 - 
        0.030089268 * max((Time.from.Hospital.Admission.to.ICU.Admission/24) - 1.82, 0)**3 - 
        0.0013790465 * High.HR + 0.0058466384 * 
        High.RR + 0.098309095 * High.T + 0.052114058 * Low.T - 
        0.65914931 * Lowest.pH + 0.017029118 * Highest.PCO2 - 
        0.0013836526 * Low.White.Blood.Cell.Count - 
        0.034996026 * Worst.Glascow.Coma.Score + 1.9284903 * 
        Lowest.pH.Highest.PCO2 - 0.039102879 * RSV.Positive
    exp(lp)
})

# updated model
# primary outcome, EarlyIntubation == Yes
fit1 = expression({
  6.3045122 + 0.25786654 * Predicted.Primary.Outcome - 2.0296469 * FiO2 + 
    170.81713 * max(FiO2 - 0.3, 0)**3 - 256.22569 * max(FiO2 - 0.4, 0)**3 + 
    85.408565 * max(FiO2 - 0.6, 0)**3
})
# secondary outcome, EarlyIntubation == Yes
fit2 = expression({
  8.3205117 + 0.26259701 * Predicted.Secondary.Outcome - 5.4689925 * FiO2 + 
  199.09399 * max(FiO2 - 0.3, 0)**3 - 298.64099 * max(FiO2 - 0.4, 0)**3 + 
    99.546995 * max(FiO2 - 0.6, 0)**3
})
# primary outcome, EarlyIntubation == No
fit3 = expression({
  4.5178903 + 0.07626761 * Predicted.Primary.Outcome + 5.9116153 * FiO2 - 
    58.706744 * max(FiO2 - 0.25, 0)**3 + 82.189441 * max(FiO2 - 0.35, 0)**3 - 
    23.482698 * max(FiO2 - 0.6, 0)**3 - 0.043933433 * MINSpO2
})
# secondary outcome, EarlyIntubation == No
fit4 = expression({
  6.7164719 + 0.04685925 * Predicted.Secondary.Outcome + 6.1923681 * FiO2 - 
    65.714324 * max(FiO2 - 0.25, 0)**3 + 92.000054 * max(FiO2 - 0.35, 0)**3 - 
    26.28573 * max(FiO2 - 0.6, 0)**3 - 0.060235724 * MINSpO2
})

server <- function(input, output) {
    
    getData <- reactive({
        inFile <- input$file1
        if (is.null(input$file1))
            return(NULL)
        read.csv(inFile$datapath, header=TRUE, sep=input$sep, quote=input$quote, colClasses = "character")
    })
    
    observeEvent(input$file1,{
        inFile<<-getData()
    })
    
    
    make_prediction <- reactive({
        if(is.null(input$file1)) return(NULL)
        data = getData()

        new_data = data %>% 
            mutate(n = row_number()) %>% 
            mutate(Comorbid = ifelse(Comorbid == "1", 1, 0),
                   #Comorbid = factor(Comorbid, levels = c("No", "Yes")),
                   EarlyIntubation = ifelse(EarlyIntubation == "1", "Yes", "No"),
                   #EarlyIntubation = factor(EarlyIntubation, levels = c("No", "Yes")),
                   Time.from.Hospital.Admission.to.ICU.Admission = as.numeric(Time.from.Hospital.Admission.to.ICU.Admission),
                   High.HR = as.numeric(High.HR),
                   Low.HR = as.numeric(Low.HR),
                   High.RR = as.numeric(High.RR),
                   High.T = as.numeric(High.T),
                   Low.T = as.numeric(Low.T),
                   Lowest.pH = as.numeric(Lowest.pH),
                   Highest.PCO2 = as.numeric(Highest.PCO2),
                   Lowest.Bicarb = as.numeric(Lowest.Bicarb),
                   High.Blood.Urea.Nitrogen = as.numeric(High.Blood.Urea.Nitrogen),
                   Worst.Glascow.Coma.Score = as.numeric(Worst.Glascow.Coma.Score),
                   RSV.Positive = as.numeric(RSV.Positive),
                   Low.White.Blood.Cell.Count = as.numeric(Low.White.Blood.Cell.Count),
                   Weight = as.numeric(Weight)) %>% 
            mutate(Time.from.Hospital.Admission.to.ICU.Admission = ifelse(Time.from.Hospital.Admission.to.ICU.Admission < 0, 0, Time.from.Hospital.Admission.to.ICU.Admission),
                   Lowest.pH.Highest.PCO2 = Lowest.pH / Highest.PCO2)
        if ("FiO2" %in% names(data) & "MINSpO2" %in% names(data)) {
          new_data = new_data %>% 
            mutate(FiO2 = as.numeric(FiO2),
                   MINSpO2 = as.numeric(MINSpO2))
        }
        
        new_data_yes = new_data %>% filter(EarlyIntubation == "Yes")
        new_data_yes$Predicted.Primary.Outcome = sapply(1:nrow(new_data_yes), function(x) eval(fit12, envir = new_data_yes[x,]))
        new_data_yes$Predicted.Secondary.Outcome = sapply(1:nrow(new_data_yes), function(x) eval(fit14, envir = new_data_yes[x,]))
        new_data_no = new_data %>% filter(EarlyIntubation == "No")
        new_data_no$Predicted.Primary.Outcome = sapply(1:nrow(new_data_no), function(x) eval(fit16, envir = new_data_no[x,]))
        new_data_no$Predicted.Secondary.Outcome = sapply(1:nrow(new_data_no), function(x) eval(fit18, envir = new_data_no[x,]))
        if ("FiO2" %in% names(data) & "MINSpO2" %in% names(data)) {
          new_data_yes$Predicted.Primary.Outcome.Update = sapply(1:nrow(new_data_yes), function(x) eval(fit1, envir = new_data_yes[x,]))
          new_data_yes$Predicted.Secondary.Outcome.Update = sapply(1:nrow(new_data_yes), function(x) eval(fit2, envir = new_data_yes[x,]))
          new_data_no$Predicted.Primary.Outcome.Update = sapply(1:nrow(new_data_no), function(x) eval(fit3, envir = new_data_no[x,]))
          new_data_no$Predicted.Secondary.Outcome.Update = sapply(1:nrow(new_data_no), function(x) eval(fit4, envir = new_data_no[x,]))
        }
        new_data_pred = rbind(new_data_no, new_data_yes)
        new_data_pred %>% arrange(n) %>% select(-n)
        
        
    })
    
    output$downloadData <- downloadHandler(
        
        filename = function() { 
            'prediction.csv'
        },
        
        content = function(file) {
            
            write.csv(make_prediction(), file, row.names = FALSE)
            
        })
    
}