require(shiny)



rp <- expression({
  lp <- 1.0034901 * (allGleason == '4+1') + 1.0034901 *  (allGleason == '4+2') + 1.0034901 *  (allGleason == '4+3') +  1.0034901 *  (allGleason == '4+4') + 1.0034901 *  (allGleason == '4+5') +  1.0034901 *  (allGleason == '5+1') + 1.0034901 *  (allGleason == '5+2') + 1.0034901 *  (allGleason == '5+3') + 1.0034901 *  (allGleason == '5+4') + 1.0034901 *  (allGleason == '5+5') + 0.82784363 * (allGleason == '2+4') + 0.82784363 * (allGleason == '2+5') + 0.82784363 * (allGleason == '3+4') + 0.82784363 * (allGleason == '3+5') + 0.82784363 * (allGleason == '4+4') + 0.82784363 * (allGleason == '4+5') + 0.82784363 * (allGleason == '5+4') + 0.82784363 * (allGleason == '5+5') + 
    0.022147732 * prepsa + 0.5520105 *  (cStage == 'T1C') - 0.05961104 * (cStage == 'T2A') + 0.80599007 * (cStage == 'T2B') + 1.05441 *    (cStage == 'T2C') + 1.8360111 *  (cStage == 'T3A') + 1.8360111 *  (cStage == 'T3B') + 1.8360111 *  (cStage == 'T3C') - 
    0.00069928007 * AGEDX - 0.16939096 * (22) - 0.00010641441 * max((22) - 8, 0)**3 + 0.00027667748 * max((22) - 16, 0)**3 - 0.00017026306 * max((22) - 21, 0)**3 ;
  0.9591711 ^ exp(lp) 
})

ww <- expression({
  lp <- -3.4499215 + 
    0.27018563 *  ( cStage == 'T2A' ) + 0.27018563 *  ( cStage == 'T2B' ) + 0.27018563 *  ( cStage == 'T2C' ) + 0.57434614 *  ( cStage == 'T3A' ) + 0.57434614 *  ( cStage == 'T3B' ) + 0.57434614 *  ( cStage == 'T3C' ) - 
    0.080128454 * 0 + 0.0052574876 * fCancer + 0.0056132526 * prepsa + 0.037925763 * AGEDX + 0.36574079 * (wwHormtx == 'Yes') +
    0.0027935291 * (allGleason == '4+3') + 0.46195895 * ( allGleason == '4+4') - 0.15354714 * ( allGleason == '1+1') - 0.15354714 * ( allGleason == '1+2') - 0.15354714 * ( allGleason == '1+3') - 0.15354714 * ( allGleason == '2+1') - 0.15354714 * ( allGleason == '2+2') - 0.15354714 * ( allGleason == '2+3') - 0.15354714 * ( allGleason == '3+1') - 0.15354714 * ( allGleason == '3+2') - 0.15354714 * ( allGleason == '3+3') + 1.2758902 * (allGleason == '2+5') + 1.2758902 * (allGleason == '3+5') + 1.2758902 * (allGleason == '4+5') + 1.2758902 * (allGleason == '5+1') + 1.2758902 * (allGleason == '5+2') + 1.2758902 * (allGleason == '5+3') + 1.2758902 * (allGleason == '5+4') + 1.2758902 * (allGleason == '5+5');
  0.745022 ^ exp(lp) 
  })

surv.fit <- expression({
  lp <- -4.4962873 + 0.072871041 * AGEDX + 0.33885557 * (maritalstat == "Unmarried") + 0.27680321 * (maritalstat == "Widowed") + 0.12710794 * (employstat == "Retired") - 0.41845402 * (employstat == "Unemployed") + 
    0.17721428 * (SMOKER == "Yes") - 0.00237673 * CHOLESTEROL - 0.020649657 * BMI + 0.0018331838 * prepsa - 0.6340964 * (BLADDERCA == "Yes") + 0.24541757 * (ANGINA == "Yes") - 0.30237718 * (CABG == "Yes") + 0.094296714 * Charlson;
  0.5155559^(exp(lp))
})


subplot <- function(fun, x, y=NULL, size=c(1,1), vadj=0.5, hadj=0.5,
                    inset=c(0,0), type=c('plt','fig'), pars=NULL){
  
  #  old.par <- par(no.readonly=TRUE)
  
  type <- match.arg(type)
  old.par <- par( c(type, 'usr', names(pars) ) )
  on.exit(par(old.par))
  
  if(missing(x)) x <- locator(2)
  
  if(is.character(x)) {
    if(length(inset) == 1) inset <- rep(inset,2)
    x.char <- x
    tmp <- par('usr')
    x <- (tmp[1]+tmp[2])/2
    y <- (tmp[3]+tmp[4])/2
    
    if( length(grep('left',x.char, ignore.case=TRUE))) {
      x <- tmp[1] + inset[1]*(tmp[2]-tmp[1])
      if(missing(hadj)) hadj <- 0
    }
    if( length(grep('right',x.char, ignore.case=TRUE))) {
      x <- tmp[2] - inset[1]*(tmp[2]-tmp[1])
      if(missing(hadj)) hadj <- 1
    }
    if( length(grep('top',x.char, ignore.case=TRUE))) {
      y <- tmp[4] - inset[2]*(tmp[4]-tmp[3])
      if(missing(vadj)) vadj <- 1
    }
    if( length(grep('bottom',x.char, ignore.case=TRUE))) {
      y <- tmp[3] + inset[2]*(tmp[4]-tmp[3])
      if(missing(vadj)) vadj <- 0
    }
  }
  
  xy <- xy.coords(x,y)
  
  if(length(xy$x) != 2){
    pin <- par('pin')
    #   tmp <- cnvrt.coords(xy$x[1],xy$y[1],'usr')$plt
    tmpx <- grconvertX( xy$x[1], to='npc' )
    tmpy <- grconvertY( xy$y[1], to='npc' )
    
    x <- c( tmpx - hadj*size[1]/pin[1],
            tmpx + (1-hadj)*size[1]/pin[1] )
    y <- c( tmpy - vadj*size[2]/pin[2],
            tmpy + (1-vadj)*size[2]/pin[2] )
    
    #   xy <- cnvrt.coords(x,y,'plt')$fig
    xyx <- grconvertX(x, from='npc', to='nfc')
    xyy <- grconvertY(y, from='npc', to='nfc')
  } else {
    #    xy <- cnvrt.coords(xy,,'usr')$fig
    xyx <- grconvertX(x, to='nfc')
    xyy <- grconvertY(y, to='nfc')
  }
  
  par(pars)
  if(type=='fig'){
    xyx <- grconvertX(xyx, from='nfc', to='ndc')
    xyy <- grconvertY(xyy, from='nfc', to='ndc')
    par(fig=c(xyx,xyy), new=TRUE)
  } else {
    par(plt=c(xyx,xyy), new=TRUE)
  }
  fun
  tmp.par <- par(no.readonly=TRUE)
  
  return(invisible(tmp.par))
}



Prostate.Plot <- function(pred1, pred2, pred3){
  x <- seq(1:100)
  y <- seq(1:100)
  x1 <- y1 <- seq(0,1,length.out=100)
  tmp <- expand.grid(x1=x1,y1=y1)
  z1 <- matrix( tmp$x1 + tmp$y1, 100 )
  
  plot(x, y, axes = F, frame.plot = T, xlab="10 Year Survival Probability", ylab="Absolute Value of 10-Year Survival for Radical Prostatectomy – Watchful Waiting", ylim=c(0,40), xlim=c(30,100), type="n")
  axis(2, at=c(0, 10, 20, 30, 40))
  axis(1, at=c(40, 50, 60, 70, 80, 90, 100))
  subplot( image(x1,y1,z1, col=rainbow(100, s = 1, v = 1, start = 0, end = 2/6, alpha = 1), axes=FALSE, xlab='',
                 ylab=''), c(27.2,102.6), c(-1.6,41.5 ))
  
  text(85, 35, "Consider RP", cex=2)
  text(50, 7.5, "Avoid RP", cex=2)
  
  rect(40, 0, 42, ((13/979)*100), col="Blue")
  rect(42, 0, 44, ((28/979)*100), col="Blue")
  rect(44, 0, 46, ((21/979)*100), col="Blue")
  rect(46, 0, 48, ((27/979)*100), col="Blue")
  rect(48, 0, 50, ((10/979)*100), col="Blue")
  rect(50, 0, 52, ((26/979)*100), col="Blue")
  rect(52, 0, 54, ((24/979)*100), col="Blue")
  rect(54, 0, 56, ((25/979)*100), col="Blue")
  rect(56, 0, 58, ((28/979)*100), col="Blue")
  rect(58, 0, 60, ((37/979)*100), col="Blue")
  rect(60, 0, 62, ((32/979)*100), col="Blue")
  rect(62, 0, 64, ((39/979)*100), col="Blue")
  rect(64, 0, 66, ((44/979)*100), col="Blue")
  rect(66, 0, 68, ((38/979)*100), col="Blue")
  rect(68, 0, 70, ((24/979)*100), col="Blue")
  rect(70, 0, 72, ((39/979)*100), col="Blue")
  rect(72, 0, 74, ((34/979)*100), col="Blue")
  rect(74, 0, 76, ((32/979)*100), col="Blue")
  rect(76, 0, 78, ((36/979)*100), col="Blue")
  rect(78, 0, 80, ((39/979)*100), col="Blue")
  rect(80, 0, 82, ((28/979)*100), col="Blue")
  rect(82, 0, 84, ((20/979)*100), col="Blue")
  rect(84, 0, 86, ((29/979)*100), col="Blue")
  rect(86, 0, 88, ((10/979)*100), col="Blue")
  rect(88, 0, 90, ((11/979)*100), col="Blue")
  rect(90, 0, 92, ((4/979)*100), col="Blue")
  rect(92, 0, 94, ((2/979)*100), col="Blue")
  
  rect(30, 0, 30+(((9/306)*100)/2), 2, col="Orange")
  rect(30, 2, 30+(((10/306)*100)/2), 4, col="Orange")
  rect(30, 4, 30+(((39/306)*100)/2), 6, col="Orange")
  rect(30, 6, 30+(((40/306)*100)/2), 8, col="Orange")
  rect(30, 8, 30+(((49/306)*100)/2), 10, col="Orange")
  rect(30, 10, 30+(((23/306)*100)/2), 12, col="Orange")
  rect(30, 12, 30+(((31/306)*100)/2), 14, col="Orange")
  rect(30, 14, 30+(((16/306)*100)/2), 16, col="Orange")
  rect(30, 16, 30+(((16/306)*100)/2), 18, col="Orange")
  rect(30, 18, 30+(((11/306)*100)/2), 20, col="Orange")
  rect(30, 20, 30+(((8/306)*100)/2), 22, col="Orange")
  rect(30, 22, 30+(((9/306)*100)/2), 24, col="Orange")
  rect(30, 24, 30+(((11/306)*100)/2), 26, col="Orange")
  rect(30, 26, 30+(((3/306)*100)/2), 28, col="Orange")
  rect(30, 28, 30+(((5/306)*100)/2), 30, col="Orange")
  rect(30, 30, 30+(((2/306)*100)/2), 32, col="Orange")
  rect(30, 32, 30+(((3/306)*100)/2), 34, col="Orange")
  rect(30, 34, 30+(((3/306)*100)/2), 36, col="Orange")
  rect(30, 36, 30+(((3/306)*100)/2), 38, col="Orange")
  rect(30, 38, 30+(((3/306)*100)/2), 40, col="Orange")

  abs.diff <- ifelse(abs(pred2-pred3) > 40, 40, abs(pred2-pred3))
  pred1 <- ifelse(pred1 < 40, 40, pred1)
  points(pred1, abs.diff, pch=19, cex=1)
  lines(c(pred1, pred1), c(-3, abs.diff), lty=2)
  lines(c(-4, pred1), c(abs.diff, abs.diff), lty=2)
}






shinyServer(function(input, output) {
  get_newdata <- reactive({
    new_df <- data.frame(AGEDX = input$AGEDX,
                         prepsa = input$prepsa,
                         allGleason = factor(input$allGleason, levels = c("1+1", "1+2", "1+3", "2+1", "2+2", "2+3", "2+4", "2+5", "3+1", "3+2", "3+3", "3+4", "4+1", "4+2", "4+4", "4+5", "5+4", "5+5")),
                         cStage = factor(input$cStage, levels = c("T1A", "T1B", "T1C", "T2A", "T2B", "T2C", "T3A", "T3B", "T3C")), 
                         fCancer = input$fCancer,
                         wwHormtx = factor(input$wwHormtx, levels = c("Yes", "No")),
                         maritalstat = factor(input$maritalstat, levels = c("Unmarried", "Widowed", "Married")),
                         employstat = factor(input$employstat, levels = c("Retired", "Unemployed", "Employed")),
                         SMOKER = factor(input$SMOKER, levels = c("Yes", "No")),
                         CHOLESTEROL = input$CHOLESTEROL,
                         BMI = input$BMI,
                         BLADDERCA = factor(input$BLADDERCA, levels = c("Yes", "No")),
                         ANGINA = factor(input$ANGINA, levels = c("Yes", "No")),
                         CABG = factor(input$CABG, levels = c("Yes", "No")),
                         MI = factor(input$MI, levels = c(TRUE, FALSE)),
                         CHF = factor(input$CHF, levels = c(TRUE, FALSE)),
                         PVOD = factor(input$PVOD, levels = c(TRUE, FALSE)),
                         CVA = factor(input$CVA, levels = c(TRUE, FALSE)),
                         DEMENTIA = factor(input$DEMENTIA, levels = c(TRUE, FALSE)),
                         COPD = factor(input$COPD, levels = c(TRUE, FALSE)),
                         COLLVASC = factor(input$COLLVASC, levels = c(TRUE, FALSE)),
                         ULCER = factor(input$ULCER, levels = c(TRUE, FALSE)),
                         MILDLIVER = factor(input$MILDLIVER, levels = c(TRUE, FALSE)),
                         DIABETES = factor(input$DIABETES, levels = c(TRUE, FALSE)),
                         HEMIPLEGIA = factor(input$HEMIPLEGIA, levels = c(TRUE, FALSE)),
                         MODSEVRENAL = factor(input$MODSEVRENAL, levels = c(TRUE, FALSE)),
                         DIABENDORGAN = factor(input$DIABENDORGAN, levels = c(TRUE, FALSE)),
                         OTHERTUMOR = factor(input$OTHERTUMOR, levels = c(TRUE, FALSE)),
                         LEUKEMIA = factor(input$LEUKEMIA, levels = c(TRUE, FALSE)),
                         LYMPHOMA = factor(input$LYMPHOMA, levels = c(TRUE, FALSE)),
                         MODSEVLIVER = factor(input$MODSEVLIVER, levels = c(TRUE, FALSE)),
                         METASTATIC = factor(input$METASTATIC, levels = c(TRUE, FALSE)),
                         AIDS = factor(input$AIDS, levels = c(TRUE, FALSE))
                         )
    new_df$Charlson <- with(new_df, ifelse(MI == TRUE, 1, 0) + ifelse(CHF == TRUE, 1, 0) + ifelse(PVOD == TRUE, 1, 0) + ifelse(CVA == TRUE, 1, 0) +
                                    ifelse(DEMENTIA == TRUE, 1, 0) + ifelse(COPD == TRUE, 1, 0) + ifelse(COLLVASC == TRUE, 1, 0) + 
                                    ifelse(ULCER == TRUE, 1, 0) + ifelse(MILDLIVER == TRUE, 1, 0) + ifelse(DIABETES == TRUE, 1, 0) +
                                    ifelse(HEMIPLEGIA == TRUE, 2, 0) + ifelse(MODSEVRENAL == TRUE, 2, 0) + ifelse(DIABENDORGAN == TRUE, 2, 0) +
                                    ifelse(OTHERTUMOR == TRUE, 2, 0) + ifelse(LEUKEMIA == TRUE, 2, 0) + ifelse(LYMPHOMA == TRUE, 2, 0) +
                                    ifelse(MODSEVLIVER == TRUE, 3, 0) + ifelse(METASTATIC == TRUE, 6, 0) + ifelse(AIDS == TRUE, 6, 0))
    new_df
  })
  
  output$surv.text <- renderText({
    new.dat <- get_newdata()
    pred3 <- eval(surv.fit, envir = new.dat)
    predict.1.percent <- paste(round(pred3*100, 0), "%", sep="")
    paste("10-Year Survival[1]:", ifelse(predict.1.percent < 40, "<40%", predict.1.percent))
  })
  
  output$rp.text <- renderText({
    new.dat <- get_newdata()
    pred4 <- eval(rp, envir = new.dat)
    predict.2.percent <- ifelse(round(pred4*100, 0) < 1, "<1%", ifelse(round(pred4*100, 0) > 99, ">99%", paste(round(pred4*100, 0), "%", sep="")))
    paste("10-Year Cancer-Specific Survival Percentage - Radical Prostatectomy[2]:", predict.2.percent)
  })
  
  output$ww.text <- renderText({
    new.dat <- get_newdata()
    pred5 <- eval(ww, envir = new.dat)
    predict.3.percent <- ifelse(round(pred5*100, 0) < 1, "<1%", ifelse(round(pred5*100, 0) > 99, ">99%", paste(round(pred5*100, 0), "%", sep="")))
    #paste(round(pred5*100, 0), "%", sep="")
    paste("10-Year Cancer-Specific Survival Percentage - Watchful Waiting[3]:", predict.3.percent)
  })
  
  output$pred.plot <- renderPlot({
    new.dat <- get_newdata()
    pred.surv <- eval(surv.fit, envir = new.dat)
    pred.rp <- eval(rp, envir = new.dat)
    pred.ww <- eval(ww, envir = new.dat)
    
    Prostate.Plot(pred.surv*100, pred.rp*100, pred.ww*100)
  })
})