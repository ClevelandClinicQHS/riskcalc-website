library(shiny)
InHosp <- expression({
            lp <- -1.032524 + 0.1167047 * MELD.AT.TXP - 0.05694881 * K.SCORE - 
                0.073470117 * Tbili - 0.80540626 * Rt.and.Left.Psoas.Vol + 
                0.28114957 * Rt.and.Left.Paraspinal.Vol
            1/(1+exp(-lp))
          })
Year1 <- expression({
            lp <- 0.56399106 + 0.94208333 * (SEX == "Male") - 0.077634819 * K.SCORE + 2.9091396e-05 * max(K.SCORE - 30, 0)**3 - 7.2728489e-05 * 
                max(K.SCORE - 60, 0)**3 + 4.3637093e-05 * max(K.SCORE - 80, 0)**3 + 0.89143482 * (DEPRESSION == "Yes") - 0.059622009 * 
                BMI - 2.0001908 * (LIVES.ALONE == "Yes") + 0.078153995 * 
                Right.Psoas.Density.Mean..HU. - 0.61730667 * Rt.and.Left.Psoas.Vol
            1/(1+exp(-lp))
         })
frailty <- expression({
             lp <- 0.29860715 - 0.49621956 * (SEX == "Male") + 0.048227203 * MELD.AT.TXP - 0.85209671 * (LOC.AT.TXP == "NOT HOSPITALIZED") + 
                 0.82546478 * (ENCEPH == "Yes") + 0.77595368 * (DEPRESSION == "Yes") - 0.050463966 * HCT + 0.506027 * (CAD == "Yes") + 
                 0.63422997 * (DM == "Yes") + 1.4157259 * (PVD == "Yes") + 1.4735288 * (PPH.HPS.WITH.HOME.O2 == "Yes") + 
                 0.67111387 * (HOSPITAL.ADMIT.6.MOS.PRIOR.TO.TXP == "Yes") - 0.11460589 * Rt.and.Left.Paraspinal.Vol 
             1/(1+exp(-lp))
           })
    
shinyServer(function(input, output){
    result <- reactive({
        new.dat <- data.frame(
            MELD.AT.TXP = input$meld,
            K.SCORE = input$kscore,
            Tbili = input$Tbili,
            Right.Psoas.Density.Mean..HU. = input$Right.Psoas.Density.Mean..HU.,
            Rt.and.Left.Psoas.Vol = input$Rt.and.Left.Psoas.Vol,
            BMI = input$bmi,
            Rt.and.Left.Paraspinal.Vol = input$Rt.and.Left.Paraspinal.Vol,
            SEX = factor(input$sex, levels = c("Male", "Female")),
            DEPRESSION = factor(input$depression, levels = c("Yes", "No")),
            LIVES.ALONE = factor(input$livealone, levels = c("Yes", "No")),
            LOC.AT.TXP = factor(input$loc, levels = c("NOT HOSPITALIZED", "HOSPITALIZED")),
            ENCEPH = factor(input$enceph, levels = c("Yes", "No")),
            HCT = input$hct,
            CAD = factor(input$cad, levels = c("Yes", "No")),
            DM = factor(input$dm, levels = c("Yes", "No")),
            PVD = factor(input$pvd, levels = c("Yes", "No")),
            PPH.HPS.WITH.HOME.O2 = factor(input$pph, levels = c("Yes", "No")),
            HOSPITAL.ADMIT.6.MOS.PRIOR.TO.TXP = factor(input$hosp, levels = c("Yes", "No"))
        )
        inhosp = eval(InHosp, envir= new.dat)
        year1 = eval(Year1, envir = new.dat)
        frailty = eval(frailty, envir = new.dat)
        risk.inhosp = ifelse(inhosp<0.0026, "Low Risk", ifelse(inhosp>0.0276, "High Risk", "Middle Risk"))
        risk.year1 = ifelse(year1 < 0.018, "Low Risk", ifelse(year1>0.0991, "High Risk", "Middle Risk"))
        risk.frailty = ifelse(frailty < 0.22, "Low Risk", ifelse(frailty > 0.56, "High Risk", "Middle Risk"))
        inhosp = paste(round(inhosp*100, 2), "%")
        year1 = paste(round(year1*100,2), "%")
        frailty = paste(round(frailty*100,2), "%")
        df = data.frame(Probability = c(inhosp, year1, frailty), Risk.level = c(risk.inhosp, risk.year1, risk.frailty), 
                        row.names = c("In Hospital Mortality", "One Year Mortality", "Frailty"))
        df
    })
    output$table <- renderTable({
        result()
    })
})