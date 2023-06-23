require(shiny)



#####MI
## Intensive
fit <- expression({
  pt <- 5.2566923 * (ASIA_Preop_Score2 == "C") + 7.9909696 * (ASIA_Preop_Score2 == "D") + 11.565452 * (ASIA_Preop_Score2 == "E") - 0.015235607 * Preop_Pain_Duration - 0.90722991 * (Osteomyelitis == "Yes") - 0.99837215 * (Prior_spinal_surgery == "Yes") + 1.407682 * (COPD == "Yes") - 0.9187711 * (Paresis == "Yes") - 0.015155241 * Admission_Age + 0.55480288 * (High_blood_pressure == "Yes") - 0.5762731 * (DM == "Yes");
  pt
})


plot.1 <- function(pt.a, pt.b, pt.c, pt.d, pt.e){
  plot(0, type="n", xaxt="n",yaxt="n",bty="n", xlab="", ylab="", ylim=c(0, 1.4), xlim=c(0,1.1), xaxs = "i", yaxs="i")#
  #A
  rect(0, 0.6, pt.a, 1, col="Red")
  #B
  rect(pt.a, 0.6, pt.a+pt.b, 1, col="salmon")
  #C
  rect(pt.a+pt.b, 0.6, (pt.a+pt.b)+pt.c, 1, col="gold")
  #D
  rect(pt.a+pt.b+pt.c, 0.6, (pt.a+pt.b+pt.c)+pt.d, 1, col="yellowgreen")
  #E
  rect(pt.a+pt.b+pt.c+pt.d, 0.6, (pt.a+pt.b+pt.c+pt.d)+pt.e, 1, col="green")

  points(0.1, 1.39, pch=15, cex=3, col="Red")
  text(0.15, 1.385, paste("Postoperative Predischarge AIS Score: A = ", ifelse(round(100*pt.a, 1) == 0, "<0.1%" ,paste(round(100*pt.a, 1), "%", sep="")), sep=" "), cex=1.5, pos = 4)
  points(0.1, 1.34, pch=15, cex=3, col="salmon")
  text(0.15, 1.339, paste("Postoperative Predischarge AIS Score: B = ", ifelse(round(100*pt.b, 1) == 0, "<0.1%" ,paste(round(100*pt.b, 1), "%", sep="")), sep=" "), cex=1.5, pos = 4)
  points(0.1, 1.29, pch=15, cex=3, col="gold")
  text(0.15, 1.289, paste("Postoperative Predischarge AIS Score: C = ", ifelse(round(100*pt.c, 1) == 0, "<0.1%" ,paste(round(100*pt.c, 1), "%", sep="")), sep=" "), cex=1.5, pos = 4)
  points(0.1, 1.24, pch=15, cex=3, col="yellowgreen")
  text(0.15, 1.239, paste("Postoperative Predischarge AIS Score: D = ", ifelse(round(100*pt.d, 1) == 0, "<0.1%" ,paste(round(100*pt.d, 1), "%", sep="")), sep=" "), cex=1.5, pos = 4)
  points(0.1, 1.19, pch=15, cex=3, col="green")
  text(0.15, 1.189, paste("Postoperative Predischarge AIS Score: E = ", ifelse(round(100*pt.e, 1) == 0, "<0.1%" ,paste(round(100*pt.e, 1), "%", sep="")), sep=" "), cex=1.5, pos = 4)
}



shinyServer(function(input, output) {
  get_newdata <- reactive({
    new_df <- data.frame(
      ASIA_Preop_Score2    = factor(input$ASIA_Preop_Score2, levels = c("A/B", "C", "D", "E")),
      Preop_Pain_Duration  = input$Preop_Pain_Duration,
      Osteomyelitis        = factor(input$Osteomyelitis, levels = c("Yes", "No")),
      Prior_spinal_surgery = factor(input$Prior_spinal_surgery, levels = c("Yes", "No")),
      COPD                 = factor(input$COPD, levels = c("Yes", "No")),
      Paresis              = factor(input$Paresis, levels = c("Yes", "No")),
      Admission_Age        = input$Admission_Age,
      High_blood_pressure  = factor(input$High_blood_pressure, levels = c("Yes", "No")),
      DM                   = factor(input$DM, levels = c("Yes", "No"))
    )
    new_df
  })

  output$pred1 <- renderPlot({
    new.dat <- get_newdata()
    pt <- eval(fit, envir = new.dat)

    pt.a <- 1-(1/(1+exp(-(2.8465+pt))))
    pt.b <- (1/(1+exp(-(2.8465+pt))))-(1/(1+exp(-(0.7184+pt))))
    pt.c <- (1/(1+exp(-(0.7184+pt))))-(1/(1+exp(-(-2.9760+pt))))
    pt.d <- (1/(1+exp(-(-2.9760+pt))))-(1/(1+exp(-(-7.3030+pt))))
    pt.e <- (1/(1+exp(-(-7.3030+pt))))
    plot.1(pt.a, pt.b, pt.c, pt.d, pt.e)
})


})