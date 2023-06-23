library(countreg)
library(rms)
library(shiny)
validate = shiny::validate

load("modelV2.RData")

shinyServer(function(input, output){
  data <- eventReactive(input$goButton, {
    validate(need(!is.na(as.numeric(input$Age))& as.numeric(input$Age)>=0, 'Please input a valid Age'))
    Age_initial.form = as.numeric(input$Age)
    validate(need(!is.na(as.numeric(input$T.Pre))&& as.numeric(input$T.Pre)>=0, 'Please input a valid Testosterone'))
    T.Pre= as.numeric(input$T.Pre)
    validate(need(!is.na(as.numeric(input$LH.Pre))& as.numeric(input$LH.Pre)>=0, 'Please input a valid LH'))
    LH.Pre= as.numeric(input$LH.Pre)
    validate(need(!is.na(as.numeric(input$FSH.Pre))& as.numeric(input$FSH.Pre)>=0, 'Please input a valid FSH'))
    FSH.Pre= as.numeric(input$FSH.Pre)
    validate(need(!is.na(as.numeric(input$Volume.Pre))& as.numeric(input$Volume.Pre)>=0, 'Please input a valid Semen Volume'))
    Volume.Pre= as.numeric(input$Volume.Pre)
    validate(need(!is.na(as.numeric(input$Motility.Pre))& as.numeric(input$Motility.Pre)>=0, 'Please input a valid Motility'))
    Motility.Pre= as.numeric(input$Motility.Pre)
    validate(need(!is.na(as.numeric(input$SpermConc.Pre))& as.numeric(input$SpermConc.Pre)>=0, 'Please input a valid Sperm Concentration'))
    SpermConc.Pre= as.numeric(input$SpermConc.Pre)
    TMC.Pre = SpermConc.Pre * Motility.Pre * Volume.Pre / 100
    data <- data.frame(Age_initial.form = Age_initial.form,
                       T.Pre = T.Pre,
                       LH.Pre = LH.Pre,
                       FSH.Pre = FSH.Pre,
                       Volume.Pre = Volume.Pre,
                       Motility.Pre = Motility.Pre,
                       SpermConc.Pre = SpermConc.Pre,
                       TMC.Pre = TMC.Pre
                       )
    data$Motility.Pre.0 = ifelse(data$Motility.Pre > 0, T, F)
    data$SpermConc.Pre.0 = ifelse(data$SpermConc.Pre > 0, T, F)
    data})
  
  output$result <- DT::renderDataTable(DT::datatable({
    data = data()
    pred_SpermConc_0 = predict(f.SpermConc, data, type = 'zero')
    pred_SpermConc = predict(f.SpermConc, data)
    pred_SpermConc_cutoff = predict(f.SpermConc.cutoff, data, type = 'response')
    pred_motility_0 = predict(f.Motility, data, type = 'zero')
    pred_motility = predict(f.Motility, data)
    pred_testosterone = predict(f.Testosterone, data, type = "link", se.fit = TRUE)
    pred_testosterone_cutoff = predict(f.Testosterone.cutoff, data, type = 'response')
    pred_LH = exp(predict(f.LH, data, interval = 'pred'))
    pred_FSH = exp(predict(f.FSH, data, interval = 'pred'))
    pred_Volume = exp(predict(f.SemenVolume, data, interval = 'pred'))
    pred_tmc = as.numeric(pred_SpermConc) * as.numeric(pred_motility) * as.numeric(pred_Volume[1]) / 100
    pred_tmc_5 = predict(f.TMC.5, data, type = 'response')
    pred_tmc_9 = predict(f.TMC.9, data, type = 'response')

    res = data.frame(Outcome = c("Testosterone", 
                                  "Testosterone > 10", 
                                  "LH", 
                                  "FSH", 
                                  "Semen Volume", 
                                  "Sperm Motility = 0%", 
                                  "Sperm Motility (%)", 
                                  "Sperm Concentration = 0", 
                                  "Sperm Concentration", 
                                  "Sperm Concentration > 15", 
                                  "Total motile count", 
                                  "Total motile count > 5", 
                                  "Total motile count > 9"),
                     `Post Therapy with clomiphene citrate in 3 months` = c(
                       paste0(round(f.Testosterone$family$linkinv(pred_testosterone$fit), 1), " (95% CI:", round(f.Testosterone$family$linkinv(pred_testosterone$fit + 1.96 * abs(pred_testosterone$se.fit)), 1), ",", round(f.Testosterone$family$linkinv(pred_testosterone$fit - 1.96 * abs(pred_testosterone$se.fit)), 1), ")"),
                       paste0(round(pred_testosterone_cutoff * 100, 1), "%", sep=""),
                       paste0(round(pred_LH[1], 1), " (95% CI: ", round(pred_LH[2], 1), ",", round(pred_LH[3], 1), ")"),
                       paste0(round(pred_FSH[1], 1), " (95% CI: ", round(pred_FSH[2], 1), ",", round(pred_FSH[3], 1), ")"),
                       paste0(round(pred_Volume[1], 1), " (95% CI: ", round(pred_Volume[2], 1), ",", round(pred_Volume[3], 1), ")"),
                       paste0(round(pred_motility_0 * 100, 1), "%", sep=""),
                       paste0(round(pred_motility, 1)),
                       paste0(round(pred_SpermConc_0 * 100, 1), "%", sep=""),
                       paste0(round(pred_SpermConc, 1)),
                       paste0(round(pred_SpermConc_cutoff * 100, 1), "%", sep=""),
                       paste0(round(pred_tmc, 1)),
                       paste0(round(pred_tmc_5 * 100, 1), "%", sep=""),
                       paste0(round(pred_tmc_9 * 100, 1), "%", sep="")
                       ))
    colnames(res) = c("Outcome", "Post Therapy with clomiphene citrate in 3 months")

    res
    
  }, options = list(
    pageLength = 15,
    lengthMenu = 0,
    
    searching = 0,
    info = 0,
    paging = 0,
    processing = 0,
    initComplete = I(
      "function(settings, json) {
                    $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
            }"))))
})
