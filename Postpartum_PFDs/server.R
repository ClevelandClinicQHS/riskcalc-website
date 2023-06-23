require(shiny)



##12 year models(ProLong)
#POP
ProLong.POP <- expression({
  lp <- 3.6704111 - 0.051616431 * Age - 0.024607221 * height + 0.39187625 * 
    (FH.POP == "Yes") + 0.71890992 * (uiprepreg == "Yes") + 0.69477538 * 
    (uiduringpreg == "Yes") + 0.67552437 * (multiple == "Yes");
  1/(1+exp(-lp))
})
#Bothersome POP
ProLong.BotherPOP <- expression({
  lp <- -0.84881965 + 0.30298427 * parity - 0.099076614 * Age + 0.41423317 * 
    (epidural == "Yes") + 0.49379033 * (FH.POP == "Yes") + 
    0.60189619 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
#Treatment for POP
ProLong.TreatPOP <- expression({
  lp <- -9.4268 + 0.13760704 * Age + 0.023535813 * PrepregWeight + 
    0.97815416 * (FH.POP == "Yes");
  1/(1+exp(-lp))
})
#Composite of POP
ProLong.CompoPOP <- expression({
  lp <- 1.4753588 + 0.2648621 * parity - 0.041074238 * Age + 0.017934193 * 
    PrepregWeight - 0.028700515 * height + 0.39052387 * (epidural == "Yes") + 0.62005308 * (FH.POP == "Yes") + 0.35206667 * 
    (Episiotomy == "Yes") + 0.58143251 * (uiprepreg == "Yes") + 0.41506412 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
#UI
ProLong.UI <- expression({
  lp <- -1.138814 - 0.11167835 * parity + 0.024421446 * Age + 0.34983546 * 
    (delmode2 == "Vaginal") + 0.49471109 * (FH.POP == "Yes") + 
    1.7905902 * (uiprepreg == "Yes") + 1.4188088 * (uiduringpreg == "Yes") + 0.21478367 * (induction == "Yes");
  1/(1+exp(-lp))
})
#Bothersome UI
ProLong.BotherUI <- expression({
  lp <- 4.322554 - 0.029647732 * Age + 0.029708808 * PrepregWeight - 
    0.032065916 * height + 0.20354882 * (delmode2 == "Vaginal") + 
    0.32883851 * (FH.POP == "Yes") + 0.85481062 * (uiprepreg == "Yes") + 
    0.7612477 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
#Treatment for UI
ProLong.TreatUI <- expression({
  lp <- -5.4079895 + 0.040235677 * Age - 0.38844371 * (Laceration == "Yes") + 1.1803848 * (delmode2 == "Vaginal") + 0.39694055 * 
    (epidural == "Yes") + 1.5029574 * (uiprepreg == "Yes") + 0.0027861086 * stage2;
  1/(1+exp(-lp))
})
#Composite of UI
ProLong.CompoUI <- expression({
  lp <- 4.4970952 - 0.028309627 * Age + 0.029325068 * PrepregWeight - 
    0.03281012 * height + 0.26079761 * (delmode2 == "Vaginal") + 
    0.23834741 * (FH.POP == "Yes") + 1.0285458 * (uiprepreg == "Yes") + 
    0.72079281 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
#Bothersome FI
ProLong.BotherFI <- expression({
  lp <- -0.97826291 + 0.14038045 * parity + 0.018898669 * Age + 0.024061393 * 
    PrepregWeight - 0.020607582 * height + 0.27248232 * (Episiotomy == "Yes") + 0.56624466 * (uiprepreg == "Yes");
  1/(1+exp(-lp))
})
#Treatment for FI
ProLong.TreatFI <- expression({
  lp <- -2.7107826 + 0.029075201 * PrepregWeight - 0.63118183 * Bwt.height + 
    0.52507969 * (epidural == "Yes");
  1/(1+exp(-lp))
})
#Composite of FI
ProLong.CompoFI <- expression({
  lp <- -3.6579308 + 0.19351297 * parity + 0.021572269 * PrepregWeight + 
    0.34971088 * (Episiotomy == "Yes") + 0.56058433 * (uiprepreg == "Yes") + 
    0.3157898 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
#Bothersome PFD
ProLong.BotherPFD <- expression({
  lp <- 4.0280976 + 0.14079446 * parity - 0.022280642 * Age + 0.030815584 * 
    PrepregWeight - 0.030233071 * height + 0.35362122 * (FH.POP == "Yes") + 0.19577765 * (Episiotomy == "Yes") + 0.72978868 * 
    (uiprepreg == "Yes") + 0.49989498 * (uiduringpreg == "Yes") + 0.0013982891 * stage2;
  1/(1+exp(-lp))
})
#Treatment for PFD
ProLong.TreatPFD <- expression({
  lp <- -0.69193707 + 0.037740734 * Age + 0.020991164 * PrepregWeight - 
    0.036886936 * height + 0.00034762508 * BirthWeight + 
    0.61265529 * (delmode2 == "Vaginal") + 0.56956987 * (epidural == "Yes") + 0.26427208 * (Episiotomy == "Yes") + 1.2773287 * 
    (uiprepreg == "Yes") + 0.40237679 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
#Composite of PFD
ProLong.CompoPFD <- expression({
  lp <- 4.9015979 - 0.034357102 * Age + 0.031234078 * PrepregWeight - 
    0.033708959 * height + 0.32924907 * (delmode2 == "Vaginal") + 
    0.21920569 * (epidural == "Yes") + 0.2966308 * (FH.POP == "Yes") + 0.83860881 * (uiprepreg == "Yes") + 0.54973194 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
#Bothersome 2 PFD
ProLong.Bother2PFD <- expression({
  lp <- 7.1198964 + 0.29984304 * parity - 0.045353056 * Age + 0.030488196 * 
    PrepregWeight - 0.042636768 * height - 0.084991316 * 
    circumference + 0.2735331 * (uiprepreg == "Yes") + 0.411249 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
#Treatment for 2 PFD
ProLong.Treat2PFD <- expression({
  lp <- -0.36021966 + 0.17032048 * Age - 0.07165287 * height + 0.00054246756 * 
    BirthWeight + 1.0001059 * (FH.POP == "Yes");
  1/(1+exp(-lp))
})
#Composite of 2 PFD
ProLong.Compo2PFD <- expression({
  lp <- 7.5353671 + 0.31212625 * parity - 0.025689542 * Age + 0.03354305 * 
    PrepregWeight - 0.050092713 * height - 0.082711844 * 
    circumference + 0.2026665 * (epidural == "Yes") + 0.14887655 * 
    (FH.POP == "Yes") + 0.2957437 * (Episiotomy == "Yes") + 
    0.33044583 * (uiprepreg == "Yes") + 0.23861612 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})

#20 year models (SwePop)
#POP
SwePop.POP <- expression({
  lp <- 0.086362341 + 0.0060559079 * PrepregWeight - 0.034477462 * 
    height + 0.00014501143 * BirthWeight + 0.04097377 * circumference + 
    1.1274898 * (delmode2 == "Vaginal") + 0.84095709 * (FH.POP == "Yes") + 0.38807919 * (FH.UI == "Yes") + 0.2897172 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})
#Bothersome POP
SwePop.BotherPOP <- expression({
  lp <- -5.8856757 + 0.00031454699 * BirthWeight + 1.5174002 * (delmode2 == "Vaginal") + 1.3759935 * (FH.POP == "Yes") + 0.52465413 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})
#Treatment for POP
SwePop.TreatPOP <- expression({
  lp <- -8.0593804 - 0.016445836 * PrepregWeight + 0.0012433252 * 
    BirthWeight - 0.35347233 * (epidural == "Yes") + 1.9355939 * 
    (FH.POP == "Yes") - 0.83242282 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})
#Composite of POP
SwePop.CompoPOP <- expression({
  lp <- -1.1221432 - 0.78035428 * Bwt.height + 0.15777475 * max(Bwt.height - 3.9608802, 0)**3 - 0.25894256 * max(Bwt.height - 4.7428571, 0)**3 + 0.10116781 * max(Bwt.height - 5.9623776, 0)**3 + 
    1.6483109 * (delmode2 == "Vaginal") + 1.5199717 * (FH.POP == "Yes") + 0.34329192 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})
#UI
SwePop.UI <- expression({
  lp <- 0.50742374 + 0.021776637 * Age + 0.020681185 * PrepregWeight - 
    0.024102771 * height + 0.57223284 * (delmode2 == "Vaginal") - 
    0.14044898 * (FH.POP == "Yes") + 1.6086467 * (FH.UI == "Yes") + 0.2548407 * (FH.FI == "Yes") - 0.1282564 * (Episiotomy == "Yes");
  1/(1+exp(-lp))
})
#Bothersome UI
SwePop.BotherUI <- expression({
  lp <- -1.0734901 + 0.019893706 * PrepregWeight - 0.020191772 * 
    height + 0.50231621 * (delmode2 == "Vaginal") + 0.21258875 * 
    (epidural == "Yes") + 0.29124933 * (FH.POP == "Yes") + 
    1.0368519 * (FH.UI == "Yes") - 0.35131066 * (Episiotomy == "Yes");
  1/(1+exp(-lp))
})
#Treatment for UI
SwePop.TreatUI <- expression({
  lp <- -6.3562271 + 0.01316452 * PrepregWeight + 0.00026999295 * 
    BirthWeight + 0.65414949 * (delmode2 == "Vaginal") + 
    1.245927 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})
#Composite of UI
SwePop.CompoUI <- expression({
  lp <- -4.0110612 + 0.015989521 * PrepregWeight + 0.56140066 * (delmode2 == "Vaginal") + 1.1958132 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})
#Bothersome FI
SwePop.BotherFI <- expression({
  lp <- -3.3923702 - 0.050965286 * Age + 0.01780414 * PrepregWeight + 
    0.45803695 * (FH.UI == "Yes") + 0.97236577 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})
#Treatment for FI
SwePop.TreatFI <- expression({
  lp <- -4.5783096 + 0.011875551 * PrepregWeight - 0.81098586 * (delmode2 == "Vaginal") + 0.45771166 * (epidural == "Yes") + 1.03147 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})
#Composite of FI
SwePop.CompoFI <- expression({
  lp <- 1.7131302 - 0.032862984 * Age + 0.020384123 * PrepregWeight - 
    0.032826392 * height + 0.21085962 * (epidural == "Yes") + 
    0.33371373 * (FH.UI == "Yes") + 1.0046374 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})
#Bothersome PFD
SwePop.BotherPFD <- expression({
  lp <- 1.3858103 + 0.019026201 * PrepregWeight - 0.032591202 * height + 
    0.82051575 * (delmode2 == "Vaginal") + 0.49967725 * (FH.POP == "Yes") + 0.84170987 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})
#Treatment for PFD
SwePop.TreatPFD <- expression({
  lp <- -5.2253295 + 0.020816636 * Age + 0.00037726673 * BirthWeight + 
    0.32358398 * (delmode2 == "Vaginal") + 0.32872024 * (FH.POP == "Yes") + 0.54356831 * (FH.UI == "Yes") + 0.26959435 * 
    (FH.FI == "Yes") - 0.44915949 * (Episiotomy == "Yes");
  1/(1+exp(-lp))
})
#Composite of PFD
SwePop.CompoPFD <- expression({
  lp <- -1.2740402 + 0.012101119 * PrepregWeight - 0.53269414 * Bwt.height + 
    0.12074765 * max(Bwt.height - 3.9608802, 0)**3 - 0.19817306 * 
    max(Bwt.height - 4.7428571, 0)**3 + 0.077425415 * max(Bwt.height - 5.9623776, 0)**3 + 0.91846484 * (delmode2 == "Vaginal") + 
    0.6372069 * (FH.POP == "Yes") + 0.92517171 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})
#Bothersome 2 PFD
SwePop.Bother2PFD <- expression({
  lp <- -1.4692333 + 0.016348049 * PrepregWeight - 0.23244733 * Bwt.height - 
    0.10083104 * circumference + 0.7604179 * (delmode2 == "Vaginal") + 1.15577 * (FH.POP == "Yes") + 0.74324133 * 
    (FH.UI == "Yes") + 0.92684933 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})
#Treatment for 2 PFD
SwePop.Treat2PFD <- expression({
  lp <- -8.5583616 + 0.00068873972 * BirthWeight + 1.111058 * (FH.UI == "Yes") + 0.70532879 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})
#Treatment for 2 PFD
SwePop.Compo2PFD <- expression({
  lp <- 2.2198667 + 0.015544052 * PrepregWeight - 0.84132303 * Bwt.height + 
    0.1694497 * max(Bwt.height - 3.9608802, 0)**3 - 0.27810368 * 
    max(Bwt.height - 4.7428571, 0)**3 + 0.10865398 * max(Bwt.height - 5.9623776, 0)**3 - 0.11773453 * circumference + 0.75828506 * 
    (delmode2 == "Vaginal") + 1.0101912 * (FH.POP == "Yes") + 
    0.75205969 * (FH.UI == "Yes") + 0.64388282 * (FH.FI == "Yes") - 0.67299847 * (Episiotomy == "Yes");
  1/(1+exp(-lp))
})

PostpardumPlot <- function(pred.pop.any, pred.ui.any, pred.pop.bother, pred.ui.bother, pred.fi.bother, pred.pfd.bother, pred.2pfd.bother, pred.pop.treat, pred.ui.treat, pred.fi.treat, pred.pfd.treat, pred.2pfd.treat, pred.pop.compo, pred.ui.compo, pred.fi.compo, pred.pfd.compo, pred.2pfd.compo){
  par(mar=c(15,1,1,1))
  plot(1, 1, type="n", xaxt="n", yaxt="n", xlab="", ylab="", xaxs = "i", yaxs="i")
  abline(h = c(0.73, 0.86, 0.99, 1.12, 1.25))
  abline(v = c(0.86, 0.995, 1.13, 1.265))
  text(0.73, 1.325, "Outcomes", cex=1.2, font=2)
  text(0.925, 1.325, "Any", cex=1.2, font=2)
  text(1.06, 1.325, "Bothersome", cex=1.2, font=2)
  text(1.195, 1.325, "Treatment", cex=1.2, font=2)
  text(1.33, 1.325, "Composite\n of\n Bothersome\n or Treatment", cex=1.2, font=2)
  text(0.73, 1.185, "Pelvic Organ Prolapse", cex=1.2, font=2)
  text(0.73, 1.055, "Urinary Incontinence", cex=1.2, font=2)
  text(0.73, 0.925, "Fecal Incontinence", cex=1.2, font=2)
  text(0.73, 0.795, "Any Pelvic Floor Disorder", cex=1.2, font=2)
  text(0.73, 0.665, "Two or More Pelvic Floor\n Disorders", cex=1.2, font=2)
  
  #any pop
  text(0.9275, 1.185, ifelse(pred.pop.any < 0.0006, "<0.1%", ifelse(pred.pop.any > 0.9994, ">99.9%", paste(round(pred.pop.any*100, 1), "%", sep=""))), cex=2)
  #any UI
  text(0.9275, 1.055, ifelse(pred.ui.any < 0.0006, "<0.1%", ifelse(pred.ui.any > 0.9994, ">99.9%", paste(round(pred.ui.any*100, 1), "%", sep=""))), cex=2)
  #any FI
  text(0.9275, 0.925, "N/A", cex=2)
  #any PFD
  text(0.9275, 0.795, "N/A", cex=2)
  #any 2 or more PFD
  text(0.9275, 0.665, "N/A", cex=2)
  #Bothersome pop
  text(1.0625, 1.185, ifelse(pred.pop.bother < 0.0006, "<0.1%", ifelse(pred.pop.bother > 0.9994, ">99.9%", paste(round(pred.pop.bother*100, 1), "%", sep=""))), cex=2)
  #Bothersome UI
  text(1.0625, 1.055, ifelse(pred.ui.bother < 0.0006, "<0.1%", ifelse(pred.ui.bother > 0.9994, ">99.9%", paste(round(pred.ui.bother*100, 1), "%", sep=""))), cex=2)
  #Bothersome FI
  text(1.0625, 0.925, ifelse(pred.fi.bother < 0.0006, "<0.1%", ifelse(pred.fi.bother > 0.9994, ">99.9%", paste(round(pred.fi.bother*100, 1), "%", sep=""))), cex=2)
  #Bothersome PFD
  text(1.0625, 0.795, ifelse(pred.pfd.bother < 0.0006, "<0.1%", ifelse(pred.pfd.bother > 0.9994, ">99.9%", paste(round(pred.pfd.bother*100, 1), "%", sep=""))), cex=2)
  #Bothersome 2 or more PFD
  text(1.0625, 0.665, ifelse(pred.2pfd.bother < 0.0006, "<0.1%", ifelse(pred.2pfd.bother > 0.9994, ">99.9%", paste(round(pred.2pfd.bother*100, 1), "%", sep=""))), cex=2)
  #Treatment for pop
  text(1.1975, 1.185, ifelse(pred.pop.treat < 0.0006, "<0.1%", ifelse(pred.pop.treat > 0.9994, ">99.9%", paste(round(pred.pop.treat*100, 1), "%", sep=""))), cex=2)
  #Treatment for UI
  text(1.1975, 1.055, ifelse(pred.ui.treat < 0.0006, "<0.1%", ifelse(pred.ui.treat > 0.9994, ">99.9%", paste(round(pred.ui.treat*100, 1), "%", sep=""))), cex=2)
  #Treatment for FI
  text(1.1975, 0.925, ifelse(pred.fi.treat < 0.0006, "<0.1%", ifelse(pred.fi.treat > 0.9994, ">99.9%", paste(round(pred.fi.treat*100, 1), "%", sep=""))), cex=2)
  #Treatment for PFD
  text(1.1975, 0.795, ifelse(pred.pfd.treat < 0.0006, "<0.1%", ifelse(pred.pfd.treat > 0.9994, ">99.9%", paste(round(pred.pfd.treat*100, 1), "%", sep=""))), cex=2)
  #Treatment for 2 or more PFD
  text(1.1975, 0.665, ifelse(pred.2pfd.treat < 0.0006, "<0.1%", ifelse(pred.2pfd.treat > 0.9994, ">99.9%", paste(round(pred.2pfd.treat*100, 1), "%", sep=""))), cex=2)
  #Composite pop
  text(1.3325, 1.185, ifelse(pred.pop.compo < 0.0006, "<0.1%", ifelse(pred.pop.compo > 0.9994, ">99.9%", paste(round(pred.pop.compo*100, 1), "%", sep=""))), cex=2)
  #Composite of UI
  text(1.3325, 1.055, ifelse(pred.ui.compo < 0.0006, "<0.1%", ifelse(pred.ui.compo > 0.9994, ">99.9%", paste(round(pred.ui.compo*100, 1), "%", sep=""))), cex=2)
  #Composite of FI
  text(1.3325, 0.925, ifelse(pred.fi.compo < 0.0006, "<0.1%", ifelse(pred.fi.compo > 0.9994, ">99.9%", paste(round(pred.fi.compo*100, 1), "%", sep=""))), cex=2)
  #Composite of PFD
  text(1.3325, 0.795, ifelse(pred.pfd.compo < 0.0006, "<0.1%", ifelse(pred.pfd.compo > 0.9994, ">99.9%", paste(round(pred.pfd.compo*100, 1), "%", sep=""))), cex=2)
  #Composite of 2 or more PFD
  text(1.3325, 0.665, ifelse(pred.2pfd.compo < 0.0006, "<0.1%", ifelse(pred.2pfd.compo > 0.9994, ">99.9%", paste(round(pred.2pfd.compo*100, 1), "%", sep=""))), cex=2)
}



shinyServer(function(input, output) {
  get_newdata <- reactive({
    new_df <- data.frame(Age = input$Age, 
                         parity = input$parity,
                         PrepregWeight = input$PrepregWeight,
                         PrepregWeight.b = input$PrepregWeight.b,
                         height = input$height,
                         height.ft = input$height.ft,
                         height.in = input$height.in,
                         BirthWeight = input$BirthWeight,
                         BirthWeight.p = input$BirthWeight.p,
                         BirthWeight.o = input$BirthWeight.o,
                         circumference = input$circumference,
                         epidural = factor(input$epidural, levels = c("Yes", "No")),
                         Episiotomy = factor(input$Episiotomy, levels = c("Yes", "No")),
                         induction = factor(input$induction, levels = c("Yes", "No")),
                         Laceration = factor(input$Laceration, levels = c("Yes", "No")),
                         delmode2 = factor(input$delmode2, levels = c("Vaginal", "C-Section")),
                         FH.POP = factor(input$FH.POP, levels = c("Yes", "No")), 
                         FH.UI = factor(input$FH.UI, levels = c("Yes", "No")), 
                         FH.FI = factor(input$FH.FI, levels = c("Yes", "No")), 
                         uiprepreg = factor(input$uiprepreg, levels = c("Yes", "No")), 
                         uiduringpreg = factor(input$uiduringpreg, levels = c("Yes", "No")), 
                         multiple = factor(input$multiple, levels = c("Yes", "No")),
                         stage2 = input$stage2
                         
    )
    new_df$PrepregWeight <- with(new_df, ifelse(PrepregWeight == 0 | is.na(PrepregWeight) == T, PrepregWeight.b*0.453592, PrepregWeight))
    new_df$height <- with(new_df, ifelse(height == 0 | is.na(height) == T, (height.ft*12 + ifelse(is.na(height.in) == T, 0, height.in))*2.54, height))
    new_df$BirthWeight <- with(new_df, ifelse(BirthWeight == 0 | is.na(BirthWeight) == T, (BirthWeight.p*16 + ifelse(is.na(BirthWeight.o) == T, 0, BirthWeight.o))/0.035274, BirthWeight))
    new_df$Bwt.height <- with(new_df, (height/BirthWeight)*100)
    new_df
    
  })
  
  output$prediction <- renderPlot({
    new.dat <- get_newdata()
    pred.ProLong.POP <- eval(ProLong.POP , envir = new.dat)
    pred.ProLong.BotherPOP <- eval(ProLong.BotherPOP, envir = new.dat)
    pred.ProLong.TreatPOP <- eval(ProLong.TreatPOP, envir = new.dat)
    pred.ProLong.CompoPOP <- eval(ProLong.CompoPOP, envir = new.dat)
    pred.ProLong.UI <- eval(ProLong.UI, envir = new.dat)
    pred.ProLong.BotherUI <- eval(ProLong.BotherUI, envir = new.dat)
    pred.ProLong.TreatUI <- eval(ProLong.TreatUI, envir = new.dat)
    pred.ProLong.CompoUI <- eval(ProLong.CompoUI, envir = new.dat)
    pred.ProLong.BotherFI <- eval(ProLong.BotherFI, envir = new.dat)
    pred.ProLong.TreatFI <- eval(ProLong.TreatFI, envir = new.dat)
    pred.ProLong.CompoFI <- eval(ProLong.CompoFI, envir = new.dat)
    pred.ProLong.BotherPFD <- eval(ProLong.BotherPFD, envir = new.dat)
    pred.ProLong.TreatPFD <- eval(ProLong.TreatPFD, envir = new.dat)
    pred.ProLong.CompoPFD <- eval(ProLong.CompoPFD, envir = new.dat)
    pred.ProLong.Bother2PFD <- eval(ProLong.Bother2PFD, envir = new.dat)
    pred.ProLong.Treat2PFD <- eval(ProLong.Treat2PFD, envir = new.dat)
    pred.ProLong.Compo2PFD <- eval(ProLong.Compo2PFD, envir = new.dat)
            
    PostpardumPlot(pred.ProLong.POP, pred.ProLong.UI, pred.ProLong.BotherPOP, pred.ProLong.BotherUI, pred.ProLong.BotherFI, pred.ProLong.BotherPFD, pred.ProLong.Bother2PFD, pred.ProLong.TreatPOP, pred.ProLong.TreatUI, pred.ProLong.TreatFI, pred.ProLong.TreatPFD, pred.ProLong.Treat2PFD, pred.ProLong.CompoPOP, pred.ProLong.CompoUI, pred.ProLong.CompoFI, pred.ProLong.CompoPFD, pred.ProLong.Compo2PFD)
  })
  
  output$prediction2 <- renderPlot({
    new.dat <- get_newdata()
    pred.SwePop.POP <- eval(SwePop.POP, envir = new.dat)
    pred.SwePop.BotherPOP <- eval(SwePop.BotherPOP, envir = new.dat)
    pred.SwePop.TreatPOP <- eval(SwePop.TreatPOP, envir = new.dat)
    pred.SwePop.CompoPOP <- eval(SwePop.CompoPOP, envir = new.dat)
    pred.SwePop.UI <- eval(SwePop.UI, envir = new.dat)
    pred.SwePop.BotherUI <- eval(SwePop.BotherUI, envir = new.dat)
    pred.SwePop.TreatUI <- eval(SwePop.TreatUI, envir = new.dat)
    pred.SwePop.CompoUI <- eval(SwePop.CompoUI, envir = new.dat)
    pred.SwePop.BotherFI <- eval(SwePop.BotherFI, envir = new.dat)
    pred.SwePop.TreatFI <- eval(SwePop.TreatFI, envir = new.dat)
    pred.SwePop.CompoFI <- eval(SwePop.CompoFI, envir = new.dat)
    pred.SwePop.BotherPFD <- eval(SwePop.BotherPFD, envir = new.dat)
    pred.SwePop.TreatPFD <- eval(SwePop.TreatPFD, envir = new.dat)
    pred.SwePop.CompoPFD <- eval(SwePop.CompoPFD, envir = new.dat)
    pred.SwePop.Bother2PFD <- eval(SwePop.Bother2PFD, envir = new.dat)
    pred.SwePop.Treat2PFD <- eval(SwePop.Treat2PFD, envir = new.dat)
    pred.SwePop.Compo2PFD <- eval(SwePop.Compo2PFD, envir = new.dat)
    
    PostpardumPlot(pred.SwePop.POP, pred.SwePop.UI, pred.SwePop.BotherPOP, pred.SwePop.BotherUI, pred.SwePop.BotherFI, pred.SwePop.BotherPFD, pred.SwePop.Bother2PFD, pred.SwePop.TreatPOP, pred.SwePop.TreatUI, pred.SwePop.TreatFI, pred.SwePop.TreatPFD, pred.SwePop.Treat2PFD, pred.SwePop.CompoPOP, pred.SwePop.CompoUI, pred.SwePop.CompoFI, pred.SwePop.CompoPFD, pred.SwePop.Compo2PFD)
  })
})