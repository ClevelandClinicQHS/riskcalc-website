require(shiny)



######################################################################################################## Recurrent POP
##### Composite Definition
compo.recur.pop <- expression({
  lp <- -3.865593894 - 0.008328029*Age + 0.115135470*VPARITY + 0.194103440*(POPQ=="III") + 0.126835634*(POPQ=="IV") + 0.009238667*C + 0.134149936*BA + 0.162750979*GH - 0.491515204*(ANTERIORC=="Yes") - 0.464041386*(POSTERIORC=="Yes") + 0.322137174*(vault.type=="Colpocleisis") + 2.352238156*(vault.type=="SSLS") + 2.352238156*(vault.type=="USLS") + 2.352238156*(vault.type=="Other");
  1/(1+exp(-lp))
})
##### Bothersome buldge
bother.buldge <- expression({
  lp <- -3.83013166 - 0.01809518*Age +  0.69471070*(Race=="Other") + 0.01527602*(Race=="White") - 0.61639940*(CARDIAC=="Yes") + 0.25860935*(CMIRS_SUM) - 0.41807945*(POPQ=="III") - 0.55544684*(POPQ=="IV")  + 0.16225578*BA + 0.15783140*GH - 0.53982056*(ANTERIORC=="Yes") - 0.57070634*(POSTERIORC=="Yes") - 0.57911079*(uppergi=="Yes") - 1.07481279*(anticoag=="Yes") - 0.12730268*(vault.type=="Colpocleisis") + 2.17675970*(vault.type=="None") + 2.36861707*(vault.type=="SSLS") + 2.36861707*(vault.type=="USLS") + 2.36861707*(vault.type=="Other"); 
  1/(1+exp(-lp))
})
#####beyond the hymen
beyond.hymen <- expression({
  lp <- -4.4938309 + 0.1145393*VPARITY + 0.1773520*BA + 0.1675379*GH - 0.5675285*(ANTERIORC=="Yes") - 0.4032510*(POSTERIORC=="Yes") + 0.2052913*(vault.type=="Colpocleisis") + 1.6230972*(vault.type=="None") + 2.5096684*(vault.type=="SSLS") + 2.5096684*(vault.type=="USLS") + 2.5096684*(vault.type=="Other");
  1/(1+exp(-lp))
})

######################################################################################################## Serious Adverse Events
##### >=1 SAE
sae.1m <- expression({
  lp <- -1.60846879 + 0.01662076*Age - 0.76890489*(Race=="Other") - 0.29359844*(Race=="White") - 0.34067747*(ESTROGEN=="Yes") - 0.28326284*(VASCULAR=="Yes") + 0.12154874*CMIRS_SUM - 0.25295710*(HYSTOOP=="Yes") + 0.39070204*(anesthetics=="Regional") + 0.10114688*(SF36Q3=="Limited a lot") - 0.17045892*(SF36Q3=="Not limited at all") - 0.49122060*(lowergi=="Yes") - 1.16648796*(vault.type=="Colpocleisis") - 1.55947228*(vault.type=="None") - 0.09219276*(vault.type=="Other") - 0.91588990*(vault.type=="SSLS") - 0.95738405*(vault.type=="USLS");
  1/(1+exp(-lp))
})
##### >=1 Dindo
dindo.1m <- expression({
  lp <- -1.93676309 + 0.01317027*Age - 0.06301806*VPARITY - 0.40780767*(HYSTERECTOMY=="Yes") - 0.20629733*(ESTROGEN=="Yes") + 1.08874637*(TISSUE=="Yes") + 0.19764729*(CARDIAC=="Yes") - 0.31709537*(VASCULAR=="Yes") + 0.14394688*CMIRS_SUM + 0.43775235*(PRIORPOP=="Yes") + 0.22862447*(POPQ=="III") + 0.09068450*(POPQ=="IV") - 0.21093570*(ANTERIORC=="Yes") + 0.25005376*(POSTERIORC=="Yes") + 0.55422356*(ANTIURINE=="None") + 1.57184413*(ANTIURINE=="Other") + 0.20875545*(ANTIURINE=="Sling/TVT") - 0.58185581*(HYSTOOP=="Yes") + 0.36745952*(lifting=="More than once a week") + 0.36201163*(lifting=="Never") + 0.65837324*(lifting=="Once a week") + 0.24360413*(lifting=="Two to three times a month") - 0.38948234*(smoking.status=="Former") - 0.48366236*(smoking.status=="Never") - 0.42665412*(lowergi=="Yes") - 0.84469800*(vault.type=="Colpocleisis")  - 0.13099866*(vault.type=="None") + 0.88132028*(vault.type=="Other") - 0.37506657*(vault.type=="SSLS") - 0.40793024*(vault.type=="USLS"); 
  1/(1+exp(-lp))
})

######################################################################################################## Health Utilities
##### Minimally important increase
mii <- expression({
  lp <- 3.657809132 - 0.025338110*Age - 0.812743909*log(BMI) - 1.114088584*(TISSUE=="Yes") - 0.092876197*CMIRS_SUM - 0.040392460*C + 0.056584624*BP + 0.092670108*GH - 0.207267674*(ANTIURINE=="None") - 1.749010583*(ANTIURINE=="Other") - 0.006526823*(ANTIURINE=="Sling/TVT") + 0.605486052*(anesthetics=="Regional") + 0.240755271*(SF36Q3=="Limited a lot") - 0.911408699*(SF36Q3=="Not limited at all") + 0.607584291*(smoking.status=="Former") + 0.406157454*(smoking.status=="Never") + 0.092143954*(vault.type=="Colpocleisis") + 0.651159705*(vault.type=="None") + 0.506270471*(vault.type=="Other") + 0.580777250*(vault.type=="SSLS") + 0.533863356*(vault.type=="USLS");
  1/(1+exp(-lp))
})
##### Minimally important decrease
mid <- expression({
  lp <- 0.38421256 + 0.02053196*Age - 0.80584727*(Race=="Other") - 0.64527157*(Race=="White") - 0.71719622*log(BMI) + 0.08971418*CMIRS_SUM - 0.06659387*BA + 0.03840789*C + 0.26255283*(HYSTOOP=="Yes") + 0.21543098*(lifting=="More than once a week") + 0.15420917*(lifting=="Never") + 0.24033736*(lifting=="Once a week") + 0.58988241*(lifting=="Two to three times a month") - 0.45705040*(SF36Q3=="Limited a lot") + 1.11037330*(SF36Q3=="Not limited at all") - 0.62355285*(smoking.status=="Former") - 0.41626054*(smoking.status=="Never") - 0.31586105*(lowergi=="Yes") + 0.17225135*(vault.type=="Colpocleisis") - 0.17332282*(vault.type=="None") - 0.16395403*(vault.type=="Other") - 0.15106182*(vault.type=="SSLS") - 0.05417677*(vault.type=="USLS");
  1/(1+exp(-lp))
})


pred.plot <- function(pred.recur.pop, pred.bulge, pred.hymen, pred.sae, pred.dindo, pred.mii, pred.mid, vault.type){
  plot(1, 1, type="n", xaxt="n", yaxt="n", xlab="", ylab="", xaxs = "i", yaxs="i")# xaxt="n", yaxt="n", 
  abline(h = c(1.3, 1.2, 1.1, 1.0, 0.9, 0.8, 0.7))
  abline(v = 0.95)
  text(0.775, 1.35, "Outcomes", cex=2, font=2)
  text(1.175, 1.35, "Predicted\n Probability", cex=2, font=2)
  text(0.775, 1.25, "Recurrence of POPQ points\n beyond the hymen, bothersome\n bulge, or any POP reoperations", cex=1.1, font=2)
  text(0.775, 1.15, "Bothersome Vaginal Bulge", cex=1.1, font=2)
  text(0.775, 1.05, "Prolapse Below the\n Vaginal Hymen", cex=1.1, font=2)
  text(0.775, 0.95, "One or more\n Serious Adverse Events", cex=1.1, font=2)
  text(0.775, 0.85, "One or more\n Dindo Grade 3 Complications", cex=1.1, font=2)
  text(0.775, 0.75, "Overall Health\n Status Improves", cex=1.1, font=2)
  text(0.775, 0.65, "Overall Health\n Status Worsens", cex=1.1, font=2)
  
  text(1, 1.25, ifelse(vault.type == "None", "NA", paste(round(pred.recur.pop*100, 1), "%", sep="")), cex=1.2, font=2)
  if(vault.type == "None"){
    rect(1.05, 1.205, 1.395, 1.295, col="light gray")
  } else {
    rect(1.05, 1.205, 1.395, 1.295, col="light gray")
    rect(1.05, 1.205, 1.05+(0.345*pred.recur.pop), 1.295, col="Red")
  }
  
  text(1, 1.15, paste(round(pred.bulge*100, 1), "%", sep=""), cex=1.2, font=2)
  rect(1.05, 1.105, 1.395, 1.195, col="light gray")
  rect(1.05, 1.105, 1.05+(0.345*pred.bulge), 1.195, col="Red")
  
  text(1, 1.05, paste(round(pred.hymen*100, 1), "%", sep=""), cex=1.2, font=2)
  rect(1.05, 1.005, 1.395, 1.095, col="light gray")
  rect(1.05, 1.005, 1.05+(0.345*pred.hymen), 1.095, col="Red")
  
  text(1, 0.95, paste(round(pred.sae*100, 1), "%", sep=""), cex=1.2, font=2)
  rect(1.05, 0.905, 1.395, 0.995, col="light gray")
  rect(1.05, 0.905, 1.05+(0.345*pred.sae), 0.995, col="Red")
  
  text(1, 0.85, paste(round(pred.dindo*100, 1), "%", sep=""), cex=1.2, font=2)
  rect(1.05, 0.805, 1.395, 0.895, col="light gray")
  rect(1.05, 0.805, 1.05+(0.345*pred.dindo), 0.895, col="Red")
  
  text(1, 0.75, paste(round(pred.mii*100, 1), "%", sep=""), cex=1.2, font=2)
  rect(1.05, 0.705, 1.395, 0.795, col="light gray")
  rect(1.05, 0.705, 1.05+(0.345*pred.mii), 0.795, col="Red")
  
  text(1, 0.65, paste(round(pred.mid*100, 1), "%", sep=""), cex=1.2, font=2)
  rect(1.05, 0.605, 1.395, 0.695, col="light gray")
  rect(1.05, 0.605, 1.05+(0.345*pred.mid), 0.695, col="Red")
}



shinyServer(function(input, output) {
  get_newdata <- reactive({
    new_df <- data.frame(Age = input$Age, 
                         VPARITY = input$VPARITY,
                         POPQ = factor(input$POPQ, levels=c("II", "III", "IV")),
                         C = input$C,
                         BA = input$BA,
                         BP = input$BP,
                         GH = input$GH,
                         ANTERIORC = factor(input$ANTERIORC, levels = c("Yes", "No")),
                         POSTERIORC = factor(input$POSTERIORC, levels = c("Yes", "No")),
                         vault.type = factor(input$vault.type, levels = c("Abdominal sacral colpopexy", "Colpocleisis", "SSLS", "USLS", "Other", "None")),
                         Race = factor(input$Race, levels = c("White", "Black", "Other")),
                         CARDIAC = factor(input$CARDIAC, levels = c("Yes", "No")),
                         CMIRS_SUM = input$CMIRS_SUM,
                         uppergi = factor(input$uppergi, levels = c("Yes", "No")),
                         anticoag = factor(input$anticoag, levels = c("Yes", "No")),
                         ESTROGEN = factor(input$ESTROGEN, levels = c("Yes", "No")),
                         VASCULAR = factor(input$VASCULAR, levels = c("Yes", "No")),
                         HYSTOOP = factor(input$HYSTOOP, levels = c("Yes", "No")),
                         anesthetics = factor(input$anesthetics, levels = c("General", "Regional")),
                         SF36Q3 = factor(input$SF36Q3, levels = c("Limited a little", "Limited a lot", "Not limited at all")),
                         lowergi = factor(input$lowergi, levels = c("Yes", "No")),
                         HYSTERECTOMY = factor(input$HYSTERECTOMY, levels = c("Yes", "No")),
                         TISSUE = factor(input$TISSUE, levels = c("Yes", "No")),
                         PRIORPOP = factor(input$PRIORPOP, levels = c("Yes", "No")),
                         ANTIURINE = factor(input$ANTIURINE, levels = c("Burch", "None", "Other", "Sling/TVT")),
                         lifting = factor(input$lifting, levels = c("Less than or equal to once a month", "More than once a week", "Never", "Once a week", "Two to three times a month")),
                         smoking.status = factor(input$smoking.status, levels = c("Current", "Former", "Never")),
                         BMI = input$BMI
    )
    new_df
  })
  
  output$pred1 <- renderPlot({
    new.dat <- get_newdata()
    eval.recur.pop <- eval(compo.recur.pop, envir = new.dat)
    eval.bulge <- eval(bother.buldge, envir = new.dat)
    eval.hymen <- eval(beyond.hymen, envir = new.dat)
    eval.sae <- eval(sae.1m, envir = new.dat)
    eval.dindo <- eval(dindo.1m, envir = new.dat)
    eval.mii <- eval(mii, envir = new.dat)
    eval.mid <- eval(mid, envir = new.dat)
    
    pred.plot(eval.recur.pop, eval.bulge, eval.hymen, eval.sae, eval.dindo, eval.mii, eval.mid, input$vault.type)
  })
})  