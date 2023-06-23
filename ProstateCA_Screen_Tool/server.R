require(shiny)
require(rms)



## High Grade Cancer Model
HG.Ca.fit <- expression({
  lp <- -6.1732052 + 0.047828342 * AGEDX + 0.22236244 * PSA - 0.0015790018 * max(PSA - 2.907, 0)**3 + 0.0022255092 * max(PSA - 6.42, 0)**3 - 0.0006465074 * max(PSA - 15, 0)**3 - 
      1.4366907 * PSARAT + 0.16289502 * (FH == "Yes") - 0.085984115 * AUA + 0.00026693577 * max(AUA, 0)**3 - 0.00043680399 * max(AUA - 7, 0)**3 + 0.00016986822 * max(AUA - 18, 0)**3 - 
      0.14585145 * (EBC == "Caucasian") - 0.57885908 * (EBC == "Other") + 0.91485035 * (DRE == "Yes");
  1/(1+exp(-lp))
})

survival.fit <- expression({
  lp <-  -4.4962873 + 0.072871041 * AGEDX + 0.33885557 * (maritalstat == "unmarried") + 0.27680321 * (maritalstat == "widowed") + 0.12710794 * (employstat == "retired") - 0.41845402 * (employstat == "unemployed") + 
      0.17721428 * (SMOKER == "Yes") - 0.00237673 * CHOLESTEROL - 0.020649657 * BMI + 0.0018331838 * PSA - 0.6340964 * (BLADDERCA == "Yes") + 0.24541757 * (ANGINA == "Yes") - 0.30237718 * (CABG == "Yes") + 
      0.094296714 * Charlson;
  0.5155559^(exp(lp))
})

Prostate.Plot <- function(pred1, pred2){
  x <- seq(1:100)
  y <- seq(1:100)
  lab <- c(0,5,10,25,50,100)
  if(pred1 < 50){
    plot(x, log(y+15), yaxt="n", ylim=rev(range(log(y+15))), xlab="10 Year Survival Probability",
         ylab="Probability of High Grade Prostate Cancer", type="n")
    axis(2, at=log(lab+15), labels=lab)
    rect(par("usr")[1], par("usr")[3], 50, par("usr")[4], col="Light Green")
    lines(c(50,104), c(log(5+15),log(5+15)))
    lines(c(50,104), c(log(10+15),log(10+15)))
    text(23, log(28+15), "Nothing Further", srt=90, cex=2.5)
    text(78, log(2+15), "Repeat in 2 Years", col="Gray", cex=1.5)
    text(78, log(7.5+15), "Repeat in 6 Months", col="Gray", cex=1.5)
    text(78, log(40+15), "Refer to Urologist", srt=90, cex=2, col="Gray")
    
    points(pred1, log(pred2+15), pch=19, cex=1)
    lines(c(pred1, pred1), c(110, log(pred2+15)), lty=2)
    lines(c(pred1, -4), c(log(pred2+15), log(pred2+15)), lty=2)
  } else {
    if(pred1 >= 50 & pred2 <= 5){
      plot(x, log(y+15), yaxt="n", ylim=rev(range(log(y+15))), xlab="10 Year Survival Probability",
           ylab="Probability of High Grade Prostate Cancer", type="n")
      axis(2, at=log(lab+15), labels=lab)
      rect(50, log(5+15), par("usr")[2], par("usr")[4], col="Pink")
      abline(v=50)
      lines(c(50,104), c(log(10+15),log(10+15)))
      text(23, log(28+15), "Nothing Further", srt=90, cex=2.5, col="Gray")
      text(78, log(2+15), "Repeat in 2 Years", cex=1.5)
      text(78, log(7.5+15), "Repeat in 6 Months", col="Gray", cex=1.5)
      text(78, log(40+15), "Refer to Urologist", srt=90, cex=2, col="Gray")
      
      points(pred1, log(pred2+15), pch=19, cex=1)
      lines(c(pred1, pred1), c(110, log(pred2+15)), lty=2)
      lines(c(pred1, -4), c(log(pred2+15), log(pred2+15)), lty=2)
    } else {
      if(pred1 >= 50 & pred2 > 5 & pred2 < 10){
        plot(x, log(y+15), yaxt="n", ylim=rev(range(log(y+15))), xlab="10 Year Survival Probability",
             ylab="Probability of High Grade Prostate Cancer", type="n")
        axis(2, at=log(lab+15), labels=lab)
        rect(50, log(10+15), par("usr")[2], log(5+15), col="Red")
        abline(v=50)
        text(23, log(28+15), "Nothing Further", srt=90, cex=2.5, col="Gray")
        text(78, log(2+15), "Repeat in 2 Years", col="Gray", cex=1.5)
        text(78, log(7.5+15), "Repeat in 6 Months", cex=1.5)
        text(78, log(40+15), "Refer to Urologist", srt=90, cex=2, col="Gray")
        
        points(pred1, log(pred2+15), pch=19, cex=1)
        lines(c(pred1, pred1), c(110, log(pred2+15)), lty=2)
        lines(c(pred1, -4), c(log(pred2+15), log(pred2+15)), lty=2)
      } else {
        plot(x, log(y+15), yaxt="n", ylim=rev(range(log(y+15))), xlab="10 Year Survival Probability",
             ylab="Probability of High Grade Prostate Cancer", type="n")
        axis(2, at=log(lab+15), labels=lab)
        rect(50, par("usr")[2], 104, log(10+15), col="Dark Red")
        abline(v=50)
        lines(c(50, 104), c(log(5+15),log(5+15)))
        text(23, log(28+15), "Nothing Further", srt=90, cex=2.5, col="Gray")
        text(78, log(2+15), "Repeat in 2 Years", col="Gray", cex=1.5)
        text(78, log(7.5+15), "Repeat in 6 Months", col="Gray", cex=1.5)
        text(78, log(40+15), "Refer to Urologist", srt=90, cex=2)
        
        points(pred1, log(pred2+15), pch=19, cex=1)
        lines(c(pred1, pred1), c(110, log(pred2+15)), lty=2)
        lines(c(pred1, -4), c(log(pred2+15), log(pred2+15)), lty=2)
      }
    }
  } 
}

shinyServer(function(input, output) {
  get_newdata <- reactive({
    new_df <- data.frame(AGEDX = input$AGEDX, 
                         PSA = input$PSA, 
                         PSARAT = input$PSARAT, 
                         FH = factor(input$FH, levels = c("No", "Yes")), 
                         AUA = input$AUA, 
                         EBC = factor(input$EBC, levels = c("Black", "Caucasian", "Other")), 
                         DRE = factor(input$DRE, levels = c("No", "Yes")), 
                         maritalstat = factor(input$maritalstat, levels = c("married", "unmarried", "widowed")),
                         employstat = factor(input$employstat, levels = c("employed", "retired", "unemployed")),
                         SMOKER = factor(input$SMOKER, levels = c("No", "Yes")), 
                         CHOLESTEROL = input$CHOLESTEROL, 
                         BMI = input$BMI, 
                         BLADDERCA = factor(input$BLADDERCA, levels = c("No", "Yes")), 
                         ANGINA = factor(input$ANGINA, levels = c("No", "Yes")), 
                         CABG = factor(input$CABG, levels = c("No", "Yes")),
                         MI = factor(input$MI, levels = c(FALSE, TRUE)), 
                         CHF = factor(input$CHF, levels = c(FALSE, TRUE)),
                         PVOD = factor(input$PVOD, levels = c(FALSE, TRUE)), 
                         CVA = factor(input$CVA, levels = c(FALSE, TRUE)), 
                         DEMENTIA = factor(input$DEMENTIA, levels = c(FALSE, TRUE)),
                         COPD = factor(input$COPD, levels = c(FALSE, TRUE)), 
                         COLLVASC = factor(input$COLLVASC, levels = c(FALSE, TRUE)), 
                         ULCER = factor(input$ULCER, levels = c(FALSE, TRUE)),
                         MILDLIVER = factor(input$MILDLIVER, levels = c(FALSE, TRUE)), 
                         DIABETES = factor(input$DIABETES, levels = c(FALSE, TRUE)), 
                         HEMIPLEGIA = factor(input$HEMIPLEGIA, levels = c(FALSE, TRUE)),
                         MODSEVRENAL = factor(input$MODSEVRENAL, levels = c(FALSE, TRUE)), 
                         DIABENDORGAN = factor(input$DIABENDORGAN, levels = c(FALSE, TRUE)),
                         OTHERTUMOR = factor(input$OTHERTUMOR, levels = c(FALSE, TRUE)), 
                         LEUKEMIA = factor(input$LEUKEMIA, levels = c(FALSE, TRUE)), 
                         LYMPHOMA = factor(input$LYMPHOMA, levels = c(FALSE, TRUE)), 
                         MODSEVLIVER = factor(input$MODSEVLIVER, levels = c(FALSE, TRUE)), 
                         METASTATIC = factor(input$METASTATIC, levels = c(FALSE, TRUE)), 
                         AIDS = factor(input$AIDS, levels = c(FALSE, TRUE))
                         
    )
    new_df$Charlson <- with(new_df, ifelse(MI == TRUE, 1, 0) +
             ifelse(CHF == TRUE, 1, 0) +
             ifelse(PVOD == TRUE, 1, 0) +
             ifelse(CVA == TRUE, 1, 0) +
             ifelse(DEMENTIA == TRUE, 1, 0) + 
             ifelse(COPD == TRUE, 1, 0) +
             ifelse(COLLVASC == TRUE, 1, 0) + 
             ifelse(ULCER == TRUE, 1, 0) + 
             ifelse(MILDLIVER == TRUE, 1, 0) +
             ifelse(DIABETES == TRUE, 1, 0) +
             ifelse(HEMIPLEGIA == TRUE, 2, 0) +
             ifelse(MODSEVRENAL == TRUE, 2, 0) +
             ifelse(DIABENDORGAN == TRUE, 2, 0) +
             ifelse(OTHERTUMOR == TRUE, 2, 0) +
             ifelse(LEUKEMIA == TRUE, 2, 0) + 
             ifelse(LYMPHOMA == TRUE, 2, 0) +
             ifelse(MODSEVLIVER == TRUE, 3, 0) + 
             ifelse(METASTATIC == TRUE, 6, 0) +
             ifelse(AIDS == TRUE, 6, 0)) 
    pred1 <- eval(survival.fit, envir = new_df)
    pred2 <- eval(HG.Ca.fit, envir = new_df)
    print(paste(pred1, pred2))
    c(pred1, pred2)
  })
  

  output$P.Plot <- renderPlot({
    new.dat <- get_newdata()
    Prostate.Plot(new.dat[1]*100, new.dat[2]*100)
  })
  
  output$Pred1.text <- renderText({
    new.dat <- get_newdata()
    predict.1.percent <- paste(ifelse(round(new.dat[1]*100, 0) < 1, "<1", ifelse(round(new.dat[1]*100, 0) > 99, ">99", round(new.dat[1]*100, 0))), "%", sep="")
    paste("10 Year Survival:", predict.1.percent)
  })
  output$Pred2.text <- renderText({
    new.dat <- get_newdata()
    predict.2.percent <- paste(ifelse(round(new.dat[2]*100, 0) < 1, "<1", ifelse(round(new.dat[2]*100, 0) > 99, ">99", round(new.dat[2]*100, 0))), "%", sep="")
    paste("Probability of High Grade Cancer:", predict.2.percent)
  })
})
