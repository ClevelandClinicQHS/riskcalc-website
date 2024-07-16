
library(shiny)


shinyServer(function(input, output){
  

  data <- eventReactive(input$goButton, {
    
    validate(need(!is.na(as.numeric(input$age))& as.numeric(input$age)>=40& as.numeric(input$age)<=100, 'Please input a valid Age'))
    validate(need(!is.na(as.numeric(input$L1BMDmultiHU))& as.numeric(input$L1BMDmultiHU)>=-50& as.numeric(input$L1BMDmultiHU)<=1200, 'Please input a valid value for L1BMD multi HU'))
    validate(need(!is.na(as.numeric(input$L1BMDsingleHU))& as.numeric(input$L1BMDsingleHU)>=-50& as.numeric(input$L1BMDsingleHU)<=1200, 'Please input a valid value for L1BMD single HU'))
    validate(need(!is.na(as.numeric(input$AbdominalAgatston))& as.numeric(input$AbdominalAgatston)>=0& as.numeric(input$AbdominalAgatston)<=30000, 'Please input a valid Abdominal Agaston'))
    validate(need(!is.na(as.numeric(input$L3SATArea))& as.numeric(input$L3SATArea)>=0.1& as.numeric(input$L3SATArea)<=1000, 'Please input a valid value for L3SAT Area'))
    validate(need(!is.na(as.numeric(input$L3TATArea))& as.numeric(input$L3TATArea)>=0.1& as.numeric(input$L3TATArea)<=1500, 'Please input a valid value for L3TAT Area'))
    validate(need(!is.na(as.numeric(input$L3VATMedianHU))& as.numeric(input$L3VATMedianHU)>=-120& as.numeric(input$L3VATMedianHU)<=-30, 'Please input a valid value for L3VAT Median HU'))
    validate(need(!is.na(as.numeric(input$L3VATSATRatio))& as.numeric(input$L3VATSATRatio)>=-1& as.numeric(input$L3VATSATRatio)<=4.5, 'Please input a valid value for L3VATSAT Ratio'))
    validate(need(!is.na(as.numeric(input$KidneyVolume))& as.numeric(input$KidneyVolume)>=0& as.numeric(input$KidneyVolume)<=1600, 'Please input a valid value for Kidney Volume'))
    validate(need(!is.na(as.numeric(input$L3MuscleArea))& as.numeric(input$L3MuscleArea)>=25& as.numeric(input$L3MuscleArea)<=500, 'Please input a valid value for L3 Muscle Area'))
    validate(need(!is.na(as.numeric(input$L3MuscleMeanHU))& as.numeric(input$L3MuscleMeanHU)>=-50& as.numeric(input$L3MuscleMeanHU)<=200, 'Please input a valid value for L3 Muscle Mean HU'))
    validate(need(!is.na(as.numeric(input$SpleenVolume))& as.numeric(input$SpleenVolume)>=0& as.numeric(input$SpleenVolume)<=6000, 'Please input a valid value for Spleen Volume'))
    

    age = as.numeric(input$age)
    Sex = factor(input$Sex, levels = c('M', 'F'))
    RACE = factor(input$RACE, levels = c('AmIndian', 'Asian', "Black", "Hawaiian",  "White"))
    Tobacco = factor(input$Tobacco, levels = c('Never', 'Passive', 'Quit', 'Yes'))  
    L1BMDmultiHU = as.numeric(input$L1BMDmultiHU)
    L1BMDsingleHU = as.numeric(input$L1BMDsingleHU)
    AbdominalAgatston = as.numeric(input$AbdominalAgatston)
    L3SATArea = as.numeric(input$L3SATArea)
    L3TATArea = as.numeric(input$L3TATArea)
    L3VATMedianHU = as.numeric(input$L3VATMedianHU)
    L3VATSATRatio = as.numeric(input$L3VATSATRatio)
    KidneyVolume = as.numeric(input$KidneyVolume)
    L3MuscleArea = as.numeric(input$L3MuscleArea)
    L3MuscleMeanHU = as.numeric(input$L3MuscleMeanHU)
    SpleenVolume = as.numeric(input$SpleenVolume)

    

    data <- data.frame(
                       age = age,
                       Sex = Sex, 
                       RACE = RACE, 
                       Tobacco = Tobacco, 
                       L1BMDmultiHU = L1BMDmultiHU ,
                       L1BMDsingleHU = L1BMDsingleHU ,
                       AbdominalAgatston = AbdominalAgatston ,
                       L3SATArea = L3SATArea ,
                       L3TATArea = L3TATArea ,
                       L3VATMedianHU = L3VATMedianHU ,
                       L3VATSATRatio = L3VATSATRatio ,
                       KidneyVolume =  L3VATSATRatio ,
                       L3MuscleArea = L3MuscleArea ,
                       L3MuscleMeanHU = L3MuscleMeanHU,
                       SpleenVolume = SpleenVolume
                       )
    data})    
            
        
           
  output$result <- renderDataTable({
    

    data = data()  
    temp.dat  <-data.frame(data)
    temp.dat2 = rbind(temp.dat, temp.dat)
    
    
if (input$ct_contrast == "No") {    


    temp.dat2$surv_prob_model2 = pec::predictSurvProb(models$model2, temp.dat2, times = 10 * 365)  
    

    
    new_df = data.frame(age = rep(temp.dat2$age[1],2),
                        Sex = rep(temp.dat2$Sex[1],2),
                        Tobacco = rep(temp.dat2$Tobacco[1],2),
                        RACE = rep(temp.dat2$RACE[1],2))
    
    
    surv_prob = pec::predictSurvProb(models$model1, newdata=new_df, times = 10 * 365)[1]
    
    while (abs(surv_prob - temp.dat2$surv_prob_model2[1])>0.01 & abs(temp.dat2$age[1]-new_df$age[1])<20) {
      if ((models$model1$coefficients['age']>0 & temp.dat2$surv_prob_model2[1]>surv_prob) |
          (models$model1$coefficients['age']<0 & temp.dat2$surv_prob_model2[1]<surv_prob)) {
        new_df$age = new_df$age + 0.01
      } else {
        new_df$age = new_df$age - 0.01
      }
      surv_prob = pec::predictSurvProb(models$model1, new_df, times = 10 * 365)[1]
    }

    
    temp.dat2$newage[1] = new_df$age[1]
    temp.dat2$surv_prob_model1[1] = surv_prob
    temp.dat2<-temp.dat2[1,]
    
    
} 
    
    else {
  

  temp.dat2$surv_prob_model2.con = pec::predictSurvProb(models$model2.con, temp.dat2, times = 10 * 365)  
      
  new_df = data.frame(age = rep(temp.dat2$age[1],2),
                          Sex = rep(temp.dat2$Sex[1],2),
                          Tobacco = rep(temp.dat2$Tobacco[1],2),
                          RACE = rep(temp.dat2$RACE[1],2))
      
 
  # --- make predictions, model type = contrast
  surv_prob = pec::predictSurvProb(models$model1.con, newdata=new_df, times = 10 * 365)[1]
  
 
  while (abs(surv_prob - temp.dat2$surv_prob_model2.con[1])>0.01 & abs(temp.dat2$age[1]-new_df$age[1])<20) {
    if ((models$model1.con$coefficients['age']>0 & temp.dat2$surv_prob_model2.con[1]>surv_prob) |
        (models$model1.con$coefficients['age']<0 & temp.dat2$surv_prob_model2.con[1]<surv_prob)) {
      new_df$age = new_df$age + 0.01
    } else {
      new_df$age = new_df$age - 0.01
    }
    surv_prob = pec::predictSurvProb(models$model1.con, new_df, times = 10 * 365)[1]
  }
  
  
  
  temp.dat2$newage[1] = new_df$age[1]
  temp.dat2$surv_prob_model1[1] = surv_prob
  temp.dat2<-temp.dat2[1,]
  
  
  
} 
    
    
    
    prob1 <- temp.dat2$age
    prob2 <- temp.dat2$newage
    
    
    res = data.frame(
      Result = c("Calculated from Birth Year", "CT Estimation"),
      
      Age = c(paste(ifelse(round(prob1, 0) < 1, "<1", ifelse(round(prob1, 0) > 99, ">99", round(prob1, 0))), " Years"), paste(ifelse(round(prob2, 0) < 1, "<1", ifelse(round(prob2, 0) > 99, ">99", round(prob2, 0))), " Years"))
                )
                
            res}, 
            options = list(
            pageLength = 10,
            lengthMenu = 0,
            searching = 0,
            info = 0,
            paging = 0,
                initComplete = I(
                    "function(settings, json) {
                    $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
            }")))
        })
        