formula <- expression({
    lp <- 7.9491618 - 0.073058077 * AgeYr + 
        2.9163452e-05 * max(AgeYr - 26, 0)**3 - 
        6.3473395e-05 * max(AgeYr - 46, 0)**3 + 
        3.4309943e-05 * max(AgeYr - 63, 0)**3 + 
        0.0021764733 * (Gender == "Male") -
        0.47432747 * (RaceCat == "Other") - 
        0.72377599 * (RaceCat == "Caucasian") + 
        0.0093278904 * BMI - 
        0.0081412457 * DonAge +         
        0.14684553 * (DonGender == "Male") - 
        0.28900131 * (DonRaceCat == "Other") - 
        0.21934148 * (DonRaceCat == "Caucasian") + 
        0.0015240266 * DonBMI - 
        1.0118529 * DonCreat + 
        3.9561283 * max(DonCreat - 0.7, 0)**3 - 
        7.9122565 * max(DonCreat - 0.9, 0)**3 + 
        3.9561283 * max(DonCreat - 1.1, 0)**3 - 
        0.17050747 * (DonProcec == "open") + 
        0.22878411 * HLAMis - 
        0.0071563372 * max(HLAMis, 0)**3 + 
        0.017890843 * max(HLAMis - 3, 0)**3 - 
        0.010734506 * max(HLAMis - 5, 0)**3 - 
        0.1715663 * (Diaggrpc == "Glomerulonephritis") -         
        0.086449449 * (Diaggrpc == "Other") + 
        0.52049392 * (Diaggrpc == "Retransplant") + 
        0.15784972 * (IMDeple == "Yes") - 
        0.092968362 * (IMIL2 == "Yes") - 
        0.055830165 * (IMAza == "Yes") -
        0.009007037 * (IMMyco == "Yes") - 
        0.20815706 * (IMRapa == "Yes") - 
        0.22407661 * (IMCalci == "Yes") - 
        0.079294598 * (Dial1wk == "Yes") + 
        0.50344023 * (TrtRej6 == "Yes") -         
        0.072419169 * GFRPo6 + 
        3.1648034e-05 * max(GFRPo6 - 35.823616, 0)**3 - 
        5.5773253e-05 * max(GFRPo6 - 54.434648, 0)**3 + 
        2.4125219e-05 * max(GFRPo6 - 78.849042, 0)**3
    100 * 0.9328354 ** exp(lp)
})
        library(shiny)
        shinyServer(function(input, output){
            data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$AgeYr))& as.numeric(input$AgeYr)>=30& as.numeric(input$AgeYr)<=90, 'Please input a valid AgeYr'))
AgeYr= as.numeric(input$AgeYr)
Gender = factor(input$Gender, levels = c('Male', 'Female'))
RaceCat = factor(input$RaceCat, levels = c('Caucasian', 'African-American', 'Other'))
validate(need(!is.na(as.numeric(input$BMI))& as.numeric(input$BMI)>=15& as.numeric(input$BMI)<=50, 'Please input a valid BMI'))
BMI= as.numeric(input$BMI)
validate(need(!is.na(as.numeric(input$DonAge))& as.numeric(input$DonAge)>=30& as.numeric(input$DonAge)<=60, 'Please input a valid DonAge'))
DonAge= as.numeric(input$DonAge)
DonGender = factor(input$DonGender, levels = c('Male', 'Female'))
DonRaceCat = factor(input$DonRaceCat, levels = c('Caucasian', 'African-American', 'Other'))
validate(need(!is.na(as.numeric(input$DonBMI))& as.numeric(input$DonBMI)>=20& as.numeric(input$DonBMI)<=40, 'Please input a valid DonBMI'))
DonBMI= as.numeric(input$DonBMI)
validate(need(!is.na(as.numeric(input$DonCreat))& as.numeric(input$DonCreat)>=0.1& as.numeric(input$DonCreat)<=2, 'Please input a valid DonCreat'))
DonCreat= as.numeric(input$DonCreat)
DonProcec = factor(input$DonProcec, levels = c('Open', 'Laparoscopic'))
validate(need(!is.na(as.numeric(input$HLAMis))& as.numeric(input$HLAMis)>=0& as.numeric(input$HLAMis)<=6, 'Please input a valid HLAMis'))
HLAMis= as.numeric(input$HLAMis)
Diaggrpc = factor(input$Diaggrpc, levels = c('Glomerulonephritis', 'Other', 'Retransplant', 'Diabetes'))
IMDeple = factor(input$IMDeple, levels = c('No', 'Yes'))
IMIL2 = factor(input$IMIL2, levels = c('No', 'Yes'))
IMAza = factor(input$IMAza, levels = c('No', 'Yes'))
IMMyco = factor(input$IMMyco, levels = c('No', 'Yes'))
IMRapa = factor(input$IMRapa, levels = c('No', 'Yes'))
IMCalci = factor(input$IMCalci, levels = c('No', 'Yes'))
Dial1wk = factor(input$Dial1wk, levels = c('No', 'Yes'))
TrtRej6 = factor(input$TrtRej6, levels = c('No', 'Yes'))
validate(need(!is.na(as.numeric(input$GFRPo6))& as.numeric(input$GFRPo6)>=1.5& as.numeric(input$GFRPo6)<=551, 'Please input a valid GFRPo6'))
GFRPo6= as.numeric(input$GFRPo6)
data <- data.frame(AgeYr = AgeYr,
Gender = Gender,
RaceCat = RaceCat,
BMI = BMI,
DonAge = DonAge,
DonGender = DonGender,
DonRaceCat = DonRaceCat,
DonBMI = DonBMI,
DonCreat = DonCreat,
DonProcec = DonProcec,
HLAMis = HLAMis,
Diaggrpc = Diaggrpc,
IMDeple = IMDeple,
IMIL2 = IMIL2,
IMAza = IMAza,
IMMyco = IMMyco,
IMRapa = IMRapa,
IMCalci = IMCalci,
Dial1wk = Dial1wk,
TrtRej6 = TrtRej6,
GFRPo6 = GFRPo6)
data})
output$result <- renderDataTable({data = data()
prob = eval(formula, data)
res = data.frame(Result = c("Percent Chance of Graft Survival (at 5-Years post-Transplant)"), Probability = c(ifelse(round(prob, 2) < 1, "<1", ifelse(round(prob, 2) > 99, ">99", round(prob, 2)))))

                res}, options = list(
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
        