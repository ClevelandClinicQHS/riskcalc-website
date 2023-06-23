require(shiny)
require(rms)



load("data/fit.marx.hs.RObj")
load("data/fit.marx.btb.RObj")



#KOOS QOL
KOOS.QOL.both.pred <- expression({
  lp <- 81.098626 + 3.7577562 * (ethnic2 == "White") - 0.47976872 * 
    BMI - 2.6703069 * (spinj == "Basketball") - 2.1006368 * 
    (spinj == "Soccer") - 8.5830792 * (spinj == "Other") - 
    3.5565042 * (lax == "Yes") + 0.20110863 * KOOS.KRQOL.t0;
  lp
  })

IKDC.both.pred <- expression({
  lp <- 91.08896 - 3.6787211 * (sex == "Female") - 0.47584703 * BMI - 
    0.45615178 * (spinj == "Basketball") + 1.1489889 * (spinj == "Soccer") - 3.4747423 * (spinj == "Other") - 1.6495232 * 
    (lax == "Yes") + 0.1566749 * IKDC.raw.t0;
})

Recur.Rupture.btb.pred <- expression({
  lp <- 0.96356939 - 0.32211709 * AGE - 0.073322305 * BMI + 0.47162187 * (lax == "Yes") + 0.24879159 * MARX.t0;
  1/(1+exp(-lp))
})

Recur.Rupture.hs.pred <- expression({
  lp <- 2.0819015 - 0.23335406 * AGE;
  1/(1+exp(-lp))
})




ACL.PredPlot <- function(MARX.btb, MARX.hs, KOOS.QOL.btb, KOOS.QOL.hs, IKDC.btb, IKDC.hs, RECUR.ACL.btb, RECUR.ACL.hs){
  par(mar=c(40,1,1,1))
  plot(1, 1, type="n", xaxt="n", yaxt="n", xlab="", ylab="", xaxs = "i", yaxs="i")
  abline(h = c(1.1, 0.85))
  abline(v = c(0.8, 0.92, 1.04, 1.16, 1.28))
  text(0.7, 0.975, "BTB", cex=1.2, font=2)
  text(0.7, 0.725, "Hamstring", cex=1.2, font=2)
  text(0.86, 1.25, "MARX", cex=1, font=2)
  text(0.98, 1.25, "KOOS QOL", cex=1, font=2)
  text(1.1, 1.25, "KOOS \nSports & Rec", cex=1, font=2)
  text(1.22, 1.25, "IKDC", cex=1, font=2)
  text(1.34, 1.25, "Recurrent \nACL Rupture", cex=1, font=2)
  
  rect(0.8, 0.85, 0.92, 1.1, col=ifelse((MARX.btb - MARX.hs) >= 4, "Light Green", ifelse((MARX.btb - MARX.hs) <= -4, "Red", "Yellow3")))
  text(0.86, 0.975, MARX.btb, cex=1.2)
  rect(0.8, 0.6, 0.92, 0.85, col=ifelse((MARX.hs - MARX.btb) >= 4, "Light Green", ifelse((MARX.hs - MARX.btb) <= -4, "Red", "Yellow3")))  
  text(0.86, 0.725, MARX.hs, cex=1.2)
  
  rect(0.92, 0.85, 1.04, 1.1, col=ifelse((KOOS.QOL.btb - KOOS.QOL.hs) >= 5, "Light Green", ifelse((KOOS.QOL.btb - KOOS.QOL.hs) <= -5, "Red", "Yellow3")))
  text(0.98, 0.975, KOOS.QOL.btb, cex=1.2)
  rect(0.92, 0.6, 1.04, 0.85, col=ifelse((KOOS.QOL.hs - KOOS.QOL.btb) >= 5, "Light Green", ifelse((KOOS.QOL.hs - KOOS.QOL.btb) <= -5, "Red", "Yellow3")))  
  text(0.98, 0.725, KOOS.QOL.hs, cex=1.2)
  
  rect(1.04, 0.85, 1.16, 1.1, col="Yellow3")
  text(1.1, 0.975, "81.3", cex=1.2)
  rect(1.04, 0.6, 1.16, 0.85, col="Yellow3")  
  text(1.1, 0.725, "82.1", cex=1.2)
  
  rect(1.16, 0.85, 1.28, 1.1, col="Yellow3")
  text(1.22, 0.975, IKDC.btb, cex=1.2)
  rect(1.16, 0.6, 1.28, 0.85, col="Yellow3")  
  text(1.22, 0.725, IKDC.hs, cex=1.2)
  
  rect(1.28, 0.85, 1.4, 1.1, col=ifelse(RECUR.ACL.btb > RECUR.ACL.hs, "Light Green", ifelse(RECUR.ACL.hs > RECUR.ACL.btb, "Red", "Yellow3")))
  text(1.34, 0.975, paste(ifelse(RECUR.ACL.btb < 1, "<1", RECUR.ACL.btb), "%", spe=""), cex=1.2)
  rect(1.28, 0.6, 1.4, 0.85, col=ifelse(RECUR.ACL.hs > RECUR.ACL.btb, "Light Green", ifelse(RECUR.ACL.btb > RECUR.ACL.hs, "Red", "Yellow3")))  
  text(1.34, 0.725, paste(ifelse(RECUR.ACL.hs < 1, "<1", RECUR.ACL.hs), "%", spe=""), cex=1.2)
}




shinyServer(function(input, output) {
  get_newdata <- reactive({
   new_df <- data.frame( AGE = input$AGE,
                         sex = factor(input$sex, levels=c("Female", "Male")),
                         ethnic2 = factor(input$ethnic2, levels=c("White", "Black/Other")),
                         spinj = factor(input$spinj, levels=c("Football", "Basketball", "Soccer", "Other")),
                         level1 = factor(input$level1, levels=c("Rec", "HS/College")),
                         lax = factor(input$lax, levels=c("Yes", "No")),
                         KOOS.KRQOL.t0 = input$KOOS.KRQOL.t0,
                         IKDC.raw.t0 = input$IKDC.raw.t0,
                         MARX.t0 = input$MARX.t0,
                         height = input$height,
                         weight = input$weight
   )
   new_df$BMI <- with(new_df, ((weight * 703)/(height*height)))
   new_df
   
  })
  
  # MARX.btb.pred <- reactive({
  #   round(predict(fit.marx.btb, newdata = get_newdata(), type="mean"), 0)
  # })
  
  
  
  # 
  output$P.Plot <- renderPlot({
    new.dat <- get_newdata()
    KOOS.QOL.both.pred.out <- round(eval(KOOS.QOL.both.pred, envir = new.dat), 1)
    
    IKDC.both.pred.out <- round(eval(IKDC.both.pred, envir = new.dat), 1)
    
    Recur.Rupture.btb.pred.out <- round(eval(Recur.Rupture.btb.pred, envir = new.dat), 3)*100
    
    Recur.Rupture.hs.pred.out <- round(eval(Recur.Rupture.hs.pred, envir = new.dat), 3)*100
      
    MARX.btb.pred.out <- round(predict(fit.marx.btb, newdata = new.dat, type="mean"), 0)
    
    MARX.hs.pred.out <- round(predict(fit.marx.hs, newdata = new.dat, type="mean"), 0)
    
    
    ACL.PredPlot(MARX.btb.pred.out, MARX.hs.pred.out, KOOS.QOL.both.pred.out, KOOS.QOL.both.pred.out, IKDC.both.pred.out, IKDC.both.pred.out, Recur.Rupture.btb.pred.out, Recur.Rupture.hs.pred.out)
  })
})