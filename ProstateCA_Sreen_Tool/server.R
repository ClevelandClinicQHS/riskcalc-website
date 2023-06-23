require(shiny)
require(rms)

load("data/Prostate.Plot.RObj")
load("data/fit1.RObj")
load("data/Survival_Model.RObj")
load("data/Charlson.Index.RObj")

shinyServer(function(input, output) {
  get_newdata <- reactive({
    new_df <- data.frame(AGEDX = input$AGEDX, PSA = input$PSA, PSARAT = input$PSARAT, FH = factor(input$FH, levels = c("No", "Yes")), 
                         AUA = input$AUA, EBC = factor(input$EBC, levels = c("Black", "Caucasian", "Other")), 
                         DRE = factor(input$DRE, levels = c("No", "Yes")), maritalstat = factor(input$maritalstat, levels = c("married", "unmarried", "widowed")),
                         employstat = factor(input$employstat, levels = c("employed", "retired", "unemployed")),
                         SMOKER = factor(input$SMOKER, levels = c("no", "yes")), CHOLESTEROL = input$CHOLESTEROL, BMI = input$BMI, 
                         BLADDERCA = factor(input$BLADDERCA, levels = c("no", "yes")), ANGINA = factor(input$ANGINA, levels = c("no", "yes")), CABG = factor(input$CABG, levels = c("no", "yes")),
                         MI = factor(input$MI, levels = c(FALSE, TRUE)), CHF = factor(input$CHF, levels = c(FALSE, TRUE)),
                         PVOD = factor(input$PVOD, levels = c(FALSE, TRUE)), CVA = factor(input$CVA, levels = c(FALSE, TRUE)), DEMENTIA = factor(input$DEMENTIA, levels = c(FALSE, TRUE)),
                         COPD = factor(input$COPD, levels = c(FALSE, TRUE)), COLLVASC = factor(input$COLLVASC, levels = c(FALSE, TRUE)), ULCER = factor(input$ULCER, levels = c(FALSE, TRUE)),
                         MILDLIVER = factor(input$MILDLIVER, levels = c(FALSE, TRUE)), DIABETES = factor(input$DIABETES, levels = c(FALSE, TRUE)), HEMIPLEGIA = factor(input$HEMIPLEGIA, levels = c(FALSE, TRUE)),
                         MODSEVRENAL = factor(input$MODSEVRENAL, levels = c(FALSE, TRUE)), DIABENDORGAN = factor(input$DIABENDORGAN, levels = c(FALSE, TRUE)),
                         OTHERTUMOR = factor(input$OTHERTUMOR, levels = c(FALSE, TRUE)), LEUKEMIA = factor(input$LEUKEMIA, levels = c(FALSE, TRUE)), LYMPHOMA = factor(input$LYMPHOMA, levels = c(FALSE, TRUE)), 
                         MODSEVLIVER = factor(input$MODSEVLIVER, levels = c(FALSE, TRUE)), METASTATIC = factor(input$METASTATIC, levels = c(FALSE, TRUE)), AIDS = factor(input$AIDS, levels = c(FALSE, TRUE))
                         
    )
    new_df$Charlson <- Charlson.Index(new_df)
    new_df
  })
  
  pred1 <- reactive({
    round(0.5155559^exp(predict(fit2.step, newdat=get_newdata()))*100, 2)
  })
  
  pred2 <- reactive({
    round((plogis(predict(fit1, newdata = get_newdata())))*100, 2)
  })
  
  output$table <- renderTable({
    tab <- matrix( c(paste(pred1(), "%", sep=""),
                     paste(pred2(), "%", sep="")
    ), nrow = 2
    )
    rownames(tab) <- c("Survival", "Probability of High Grade Cancer")
    colnames(tab) <- "Probability"
    tab
  })
  
  output$P.Plot <- renderPlot({
    Prostate.Plot(pred1(), pred2())
  })
  
  output$Pred1.text <- renderText({
    predict.1.percent <- paste(pred1(), "%", sep="")
    paste("10 Year Survival:", predict.1.percent)
  })
  output$Pred2.text <- renderText({
    predict.2.percent <- paste(pred2(), "%", sep="")
    paste("Probability of High Grade Cancer:", predict.2.percent)
  })
})
