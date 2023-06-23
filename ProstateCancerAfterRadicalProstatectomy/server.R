predict.bfp <- expression({
    if (is.na(RTDose)) {
        lp = data.frame(yr5.free = "Not Applicable", yr10.free = "Not Applicable", yr5.cum = "Not Applicable", yr10.cum = "Not Applicable")
    } else {
        lp1 = 0.61629922 * (NADT == "No") + 
            0.68142769 * (Gleason == "G7") + 
            0.889343 * (Gleason == "G8") + 
            1.1329454 * (Gleason == "G9-10") + 
            0.27985075 * (ECE == "Yes") - 
            0.34214367 * (SM == "Positive") + 
            0.29990969 * (SVI == "Yes") + 
            0.63145578 * min(RTPSA, 2) - 
            0.21748355 * (RTDose >= 6600)
        lp2 = 0.34393019 * (NADT == "No") + 
            0.8514755 * (Gleason == "G7") + 
            1.1542012 * (Gleason == "G8") + 
            1.6840493 * (Gleason == "G9-10") + 
            0.1761536 * (ECE == "Yes") - 
            0.3696072 * (SM == "Positive") + 
            0.62810136 * (SVI == "Yes") + 
            0.8036252 * min(RTPSA, 2) - 
            0.031426658 * (RTDose >= 6600)
        lp = data.frame(yr5.free = paste(ifelse(round(100 * 0.8836072**exp(lp1), 0) < 1, "<1", ifelse(round(100 * 0.8836072**exp(lp1), 0) > 99, ">99", round(100 * 0.8836072**exp(lp1), 0))), "%"),
                        yr10.free = paste(ifelse(round(100 * 0.8324219**exp(lp1), 0) < 1, "<1", ifelse(round(100 * 0.8324219**exp(lp1), 0) > 99, ">99", round(100 * 0.8324219**exp(lp1), 0))), "%"),
                        yr5.cum = paste(ifelse(round( 100 - 100 * 0.985203**exp(lp2), 0) < 1, "<1", ifelse(round( 100 - 100 * 0.985203**exp(lp2), 0) > 99, ">99", round( 100 - 100 * 0.985203**exp(lp2), 0))), "%"),
                        yr10.cum = paste(ifelse(round( 100 - 100 * 0.9690733**exp(lp2), 0) < 1, "<1", ifelse(round( 100 - 100 * 0.9690733**exp(lp2), 0) > 99, ">99", round( 100 - 100 * 0.9690733**exp(lp2), 0))), "%"))
    }
    lp
})
predict.6y.free <- expression({
    if (is.na(PreOpPSA) | (LNI == "Unknown") | (RPPSANMA == "Unknown") | is.na(PSADT) | is.na(DFI) | is.na(RTDose)) {
        "Not Applicable"
    }
    else{
        lp = 3.07792686526318 -
            0.00858105668318854 * PreOpPSA +
            0.329304160315122 * (Gleason ==  "G7") +
            0.795806028756054 * (Gleason == "G8" | Gleason == "G9-10") +
            0.203023555713285 * (SVI == "Yes") +
            0.0329535051336598 * (ECE == "Yes") - 
            0.390341089147442 * (SM == "Positive") +
            0.628303674255468 * (LNI == "Yes") +
            0.029348266830082 * (RPPSANMA == "Yes") +
            0.000510195965582202 * DFI +
            0.653406201021881 * RTPSA -
            0.0656121433123849 * max(RTPSA - 0.4, 0)** 3 +
            0.0768142165608409 * max(RTPSA - 1.1, 0)**3 -
            0.011202073248456 *  max(RTPSA - 5.2, 0)**3 -
            0.100353863592623 * PSADT + 
            0.000345816712765306 * max(PSADT - 2.2014688, 0)**3 -
            0.000463949082201016 * max(PSADT - 6.9846675, 0)**3 +
            0.00011813236943571 * max(PSADT - 20.986842, 0)**3 -
            0.727513093318625 * (NADT == "Yes") -
            0.000509827724653327 * RTDose +
            6.4677758059172e-010 * max(RTDose - 6000, 0)**3 -
            1.2438030395995e-009 * max(RTDose - 6480, 0)**3 +
            0.9702545900774e-010 * max(RTDose - 7000, 0)**3 
        paste(ifelse(round(100 * 0.350445955991745 ** exp(lp), 0) < 1, "<1", ifelse(round(100 * 0.350445955991745 ** exp(lp), 0) > 99, ">99", round(100 * 0.350445955991745 ** exp(lp), 0))), "%")
    }
    
})
library(shiny)
shinyServer(function(input, output){
    data <- eventReactive(input$goButton, {
        validate(need(is.na(as.numeric(input$PreOpPSA))|!is.na(as.numeric(input$PreOpPSA))& as.numeric(input$PreOpPSA)>=0& as.numeric(input$PreOpPSA)<=100, 'Please input a valid PreOpPSA'))
        PreOpPSA= as.numeric(input$PreOpPSA)
        Gleason = factor(input$Gleason, levels = c('6 or lower', '7', '8', '9-10'))
        SVI = factor(input$SVI, levels = c('No', 'Yes'))
        ECE = factor(input$ECE, levels = c('No', 'Yes'))
        SM = factor(input$SM, levels = c('Negative', 'Positive'))
        LNI = factor(input$LNI, levels = c('Unknown', 'No', 'Yes'))
        RPPSANMA = factor(input$RPPSANMA, levels = c('Unknown', 'No', 'Yes'))
        validate(need(is.na(as.numeric(input$DFI))|!is.na(as.numeric(input$DFI))& as.numeric(input$DFI)>=0& as.numeric(input$DFI)<=60, 'Please input a valid DFI'))
        DFI= as.numeric(input$DFI)
        validate(need(!is.na(as.numeric(input$RTPSA))& as.numeric(input$RTPSA)>=0.2& as.numeric(input$RTPSA)<=20, 'Please input a valid RTPSA'))
        RTPSA= as.numeric(input$RTPSA)
        validate(need(is.na(as.numeric(input$PSADT))|!is.na(as.numeric(input$PSADT))& as.numeric(input$PSADT)>=0& as.numeric(input$PSADT)<=120, 'Please input a valid PSADT'))
        PSADT= as.numeric(input$PSADT)
        NADT = factor(input$NADT, levels = c('No', 'Yes'))
        validate(need(is.na(as.numeric(input$RTDose))|(!is.na(as.numeric(input$RTDose))& as.numeric(input$RTDose)>=5000& as.numeric(input$RTDose)<=7600), 'Please input a valid RTDose'))
        RTDose= as.numeric(input$RTDose)
        data <- data.frame(PreOpPSA = PreOpPSA,
                           Gleason = Gleason,
                           SVI = SVI,
                           ECE = ECE,
                           SM = SM,
                           LNI = LNI,
                           RPPSANMA = RPPSANMA,
                           DFI = DFI,
                           RTPSA = RTPSA,
                           PSADT = PSADT,
                           NADT = NADT,
                           RTDose = RTDose)
        data})
    
    output$result <- renderDataTable({data = data()
    prob = eval(predict.bfp, data)
    prob.5yr.free <- as.character(prob$yr5.free)
    prob.10yr.free <- as.character(prob$yr10.free)
    prob.5yr.cum <- as.character(prob$yr5.cum)
    prob.10yr.cum <- as.character(prob$yr10.cum)
    prob.6yr.free <- eval(predict.6y.free, data)
    res = data.frame(Result = c("5-year free from biochemical failure probability[1]", 
        "6-year free from biochemical failure probability[2]", 
        "10-year free from biochemical failure probability[1]", 
        "5-year cumulative incidence of metastasis[1]", 
        "10-year cumulative incidence of metastasis[1]"),
                     Probability = c(prob.5yr.free, prob.6yr.free, prob.10yr.free, prob.5yr.cum, prob.10yr.cum))
    
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
