require(shiny)



#####MI
## Intensive
fit <- expression({
  lp = 2.4987677 + 0.0092097916 * Age - 0.2273386 * (Race == "Black") -
      0.14223977 * (Race == "Other") + 0.32997441 * (Ethnicity == "Not Hispanic or Latino") +
      0.40820991 * (Ethnicity == "Unknown") - 0.24814156 * (Insurance == "Medicaid") +
      0.022675067 * (Insurance == "Private Health Insurance") -
      0.35518594 * (Insurance == "Other") - 0.42745606 * A1c +
      0.040505263 * max(A1c - 9.2, 0)**3 - 0.056707368 * max(A1c - 10.2, 0)**3 +
      0.016202105 * max(A1c - 12.7, 0)**3 - 0.1224515 * TimeInDataBase +
      0.0022374867 * max(TimeInDataBase - 0.53935661, 0)**3 -
      0.0031453049 * max(TimeInDataBase - 2.934976, 0)**3 +
      0.00090781824 * max(TimeInDataBase - 8.8394251, 0)**3 +
      0.12592332 * Encounters - 0.00089328868 *
      max(Encounters - 1, 0)**3 + 0.001339933 * max(Encounters - 5, 0)**3 -
      0.00044664434 * max(Encounters - 13, 0)**3 +
      0.23520784 * DPP4 + 0.35535532 * TZD + 0.41371423 * Metform -
      0.19241342 * SGLT2 - 0.13530686 * Obesity + 0.22112866 *
      CKD - 0.3814295 * Insulin2 + 0.20862169 * GLP1 + 0.06749231 *
      (Charlson.Index.Factor == "1") - 0.12180291 * (Charlson.Index.Factor == "2") -
      0.010771912 * (Charlson.Index.Factor == ">==3") -
      0.25591612 * Total.Number.Med + 0.38690348 * SGLT2 *
      Obesity - 0.88619482 * SGLT2 * CKD
  1 / (1 + exp(-lp))
})


shinyServer(function(input, output) {
  get_newdata <- eventReactive(input$goButton, {
    new_df <- data.frame(
      Age=input$Age,
      Race = input$Race,
      Ethnicity = input$Ethnicity,
      Insurance = input$Insurance,
      A1c = input$A1c,
      TimeInDataBase = input$TimeInDataBase,
      Encounters = input$Encounters,
      GLP1 = ifelse(input$GLP1 == "No", 0, 1),
      DPP4 = ifelse(input$DPP4 == "No", 0, 1),
      TZD = ifelse(input$TZD == "No", 0, 1),
      Metform = ifelse(input$Metform == "No", 0, 1),
      SGLT2 = ifelse(input$SGLT2 == "No", 0, 1),
      Insulin2 = ifelse(input$Insulin2 == "No", 0, 1),
      Obesity = ifelse(input$Obesity == "No", 0, 1),
      CKD = ifelse(input$CKD == "No", 0, 1),
      Total.Number.Med = input$Total.Number.Med,
      Charlson.Index.Factor = input$Charlson.Index.Factor
    )
    new_df
  })

  output$table <- renderDataTable({
    new.dat <- get_newdata()
    pt <- eval(fit, envir = new.dat)

    data.frame('Outcome' = c("Probability of goal attainment"),
               'Probability' = paste(round(pt*100, 1), "%", sep=''))

}, options = list(
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
