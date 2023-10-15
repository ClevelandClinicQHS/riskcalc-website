library(shiny)
library(DT)
library(shinyWidgets)
library(shinyjs)
predict.risk.MMVT <- expression({
  lp <- 1-0.8292047^exp(
    (-0.0128423)*agey +
    (0.642427)*(sex=="Male") +
    (0.3555537)*(race=="Black") +
    (-0.0329191)*(race=="Asian") +
    (-1.101491)*(race=="Hispanic White") +
    (0.1841201)*(mbeat3=="Atrial fibrillation or flutter") +
    (-0.0784277)*(mbeat3=="Ventricular pacing") +
    (-0.0117005)*(nyha=="Class II") +
    (0.0617539)*(nyha=="Class III") +
    (-0.1384314)*(nyha=="Class IV") +
    (0.0195001)*(htn=="Yes") +
    (-0.3357045)*(diabetes=="Yes") +
    (0.1916414)*(cva=="Yes") +
    (0.1431075)*(af=="Yes") +
    (0.3926207)*(bb_usage=="Yes") +
    (-0.0400565)*(aa_usage=="Yes") +
    (0.1712816)*(ACEI=="Yes") +
    (-0.0808202)*(ARB=="Yes") +
    (0.0611445)*(manufacturer=="Guidant/Boston Scientific") +
    (0.0868808)*(manufacturer=="St. Jude/Abbott") +
    (-0.3785418)*(manufacturer=="Biotronic") +
    (-0.5682829)*(icd_type=="CRT-D") +
    (-0.0183015)*(vt_zone_bpm) +
    (0.006698)*(vf_zone_bpm) +
    (-0.0020546)*(HRbpm) +
    (-0.4848996)*(progr=="Delayed Therapy") +
    (0.4362893)*(PVCany=="Yes") +
    (-0.0024555)*QTch +
    (-0.0047178)*(revascularization=="Yes") +
    (0.2801921)*(mi=="Yes") +
    (0.2703983)*(ccbs=="No") +
    (-0.100866)*(aldosteroneAnt=="Yes") +
    (-0.0057973)*bun +
    (0.3181229)*(atp=="ON") +
    (0.0003906)*areaQRSTAngle_deg +
    (0.0042101)*areaSVGElevation_deg +
    (-0.0111469)*areaSVG_mVms +
    (-0.0005657)*SAIQRST +
    (-0.0331425)*exact_lvef +
    (0.0057114)*QRSduration_ms +
    (0.0001473)*aSVGaz +
    (-0.004982)*egfr
    )
})


predict.risk.PVT <- expression({
  lp <- 1-0.948173^exp(
    (-0.0211415)*agey +
    (0.2210484)*(sex=="Male") +
    (0.504096)*(race=="Black") +
    (-0.6964255)*(race=="Asian") +
    (-0.3193676)*(race=="Hispanic White") +
    (0.0754162)*(mbeat3=="Atrial fibrillation or flutter") +
    (-0.5178345)*(mbeat3=="Ventricular pacing") +
    (0.2393885)*(nyha=="Class II") +
    (0.3612647)*(nyha=="Class III") +
    (-0.4772228)*(nyha=="Class IV") +
    (-0.1242515)*(htn=="Yes") +
    (-0.0630586)*(diabetes=="Yes") +
    (0.1438454)*(cva=="Yes") +
    (-0.2664736)*(af=="Yes") +
    (0.0175594)*(bb_usage=="Yes") +
    (-0.1181918)*(aa_usage=="Yes") +
    (0.5629074)*(ACEI=="Yes") +
    (0.3957049)*(ARB=="Yes") +
    (-0.6454476)*(manufacturer=="Guidant/Boston Scientific") +
    (-0.3333583)*(manufacturer=="St. Jude/Abbott") +
    (-0.484375)*(manufacturer=="Biotronic") +
    (0.0794924)*(icd_type=="CRT-D") +
    (-0.0063632)*(vt_zone_bpm) +
    (-0.0039332)*(vf_zone_bpm) +
    (0.0083998)*(HRbpm) +
    (-0.3043527)*(progr=="Delayed Therapy") +
    (-0.199185)*(PVCany=="Yes") +
    (-0.0013268)*QTch +
    (0.6714189)*(revascularization=="Yes") +
    (-0.5214695)*(mi=="Yes") +
    (0.1061675)*(ccbs=="No") +
    (0.5387356)*(aldosteroneAnt=="Yes") +
    (0.0011206)*bun +
    (-0.3799037)*(atp=="ON") +
    (0.0003658)*areaQRSTAngle_deg +
    (0.0000436)*areaSVGElevation_deg +
    (-0.0171541)*areaSVG_mVms +
    (0.0026684)*SAIQRST +
    (0.0132368)*exact_lvef +
    (-0.0010798)*QRSduration_ms +
    (-0.0007186)*aSVGaz +
    (-0.0045197)*egfr
  )
})

library(shiny)
shinyServer(function(input, output){
  data <- eventReactive(input$goButton, {
    validate(need(!is.na(as.numeric(input$agey))& as.numeric(input$agey)>=18& as.numeric(input$agey)<=100, 'Please input a valid Age.'))
    agey= as.numeric(input$agey)
    sex = factor(input$sex, levels = c('Female', 'Male'))
    race = factor(input$race, levels = c('Non-Hispanic White','Hispanic White', 'Black','Asian'))
    htn = factor(input$htn, levels = c('No', 'Yes'))
    diabetes = factor(input$diabetes, levels = c('No', 'Yes'))
    cva=factor(input$cva, levels = c('No', 'Yes'))
    af= factor(input$af, levels = c('No', 'Yes'))
    mi = factor(input$mi, levels = c('No', 'Yes'))
    revascularization = factor(input$revascularization, levels = c('No', 'Yes'))
    nyha = factor(input$nyha, levels = c('Class I','Class II', 'Class III','Class IV'))
    validate(need(!is.na(as.numeric(input$exact_lvef))& as.numeric(input$exact_lvef)>=7 & as.numeric(input$exact_lvef)<=54, 'Please input a valid Left Ventricular Ejection Fraction (%).'))
    exact_lvef= as.numeric(input$exact_lvef)
    validate(need(!is.na(as.numeric(input$bun))& as.numeric(input$bun)>=2 & as.numeric(input$bun)<=51, 'Please input a valid BUN (mg/dL).'))
    bun= as.numeric(input$bun)
    validate(need(!is.na(as.numeric(input$egfr))& as.numeric(input$egfr)>=0.5 & as.numeric(input$egfr)<=121, 'Please input a valid eGFR CKD-EPI (mL/min/1.73 m^2.'))
    egfr= as.numeric(input$egfr)
    bb_usage = factor(input$bb_usage, levels = c('No', 'Yes'))
    aa_usage = factor(input$aa_usage, levels = c('No', 'Yes'))
    ACEI = factor(input$ACEI, levels = c('No', 'Yes'))
    ARB = factor(input$ARB, levels = c('No', 'Yes'))
    ccbs = factor(input$ccbs, levels = c('No', 'Yes'))
    aldosteroneAnt=factor(input$aldosteroneAnt, levels = c('No', 'Yes'))
    manufacturer=factor(input$manufacturer, levels =  c('Medtronic', 'Guidant/Boston Scientific','St. Jude/Abbott',"Biotronic"))
    icd_type=factor(input$icd_type, levels =  c('ICD/S-ICD', 'CRT-D'))
    atp = factor(input$atp, levels = c('OFF', 'ON'))
    progr = factor(input$progr, levels = c('Historic Convention', 'Delayed Therapy'))
    validate(need(!is.na(as.numeric(input$vt_zone_bpm))& as.numeric(input$vt_zone_bpm)>=105 & as.numeric(input$vt_zone_bpm)<=190, 'Please input a valid VT zone cut-off (bpm).'))
    vt_zone_bpm= as.numeric(input$vt_zone_bpm)
    validate(need(!is.na(as.numeric(input$vf_zone_bpm))& as.numeric(input$vf_zone_bpm)>=188 & as.numeric(input$vf_zone_bpm)<=300, 'Please input a valid VF zone cut-off (bpm).'))
    vf_zone_bpm= as.numeric(input$vf_zone_bpm)
    mbeat3=factor(input$mbeat3, levels = c('Normal sinus','Atrial fibrillation or flutter','Ventricular pacing'))
    validate(need(!is.na(as.numeric(input$HRbpm))& as.numeric(input$HRbpm)>=38 & as.numeric(input$HRbpm)<=148, 'Please input a valid Heart rate (bpm).'))
    HRbpm= as.numeric(input$HRbpm)
    PVCany = factor(input$PVCany, levels = c('No', 'Yes'))
    validate(need(!is.na(as.numeric(input$QTch))& as.numeric(input$QTch)>=382 & as.numeric(input$QTch)<=535, 'Please input a valid Hodges-corrected QT interval (ms).'))
    QTch= as.numeric(input$QTch)
    validate(need(!is.na(as.numeric(input$QRSduration_ms))& as.numeric(input$QRSduration_ms)>=50 & as.numeric(input$QRSduration_ms)<=230, 'Please input a valid QRS duration (ms).'))
    QRSduration_ms= as.numeric(input$QRSduration_ms)
    validate(need(!is.na(as.numeric(input$areaQRSTAngle_deg))& as.numeric(input$areaQRSTAngle_deg)>=2 & as.numeric(input$areaQRSTAngle_deg)<=179, 'Please input a valid Spatial QRS-T angle (degrees).'))
    areaQRSTAngle_deg= as.numeric(input$areaQRSTAngle_deg)
    validate(need(!is.na(as.numeric(input$areaSVGElevation_deg))& as.numeric(input$areaSVGElevation_deg)>=3 & as.numeric(input$areaSVGElevation_deg)<=177, 'Please input a valid Spatial Ventricular Gradient Elevation (degrees).'))
    areaSVGElevation_deg=as.numeric(input$areaSVGElevation_deg)
    validate(need(!is.na(as.numeric(input$aSVGaz))& as.numeric(input$aSVGaz)>=(-179) & as.numeric(input$aSVGaz)<=(+179), 'Please input a valid Spatial Ventricular Gradient Azimuth (degrees).'))
    aSVGaz=as.numeric(input$aSVGaz)
    validate(need(!is.na(as.numeric(input$areaSVG_mVms))& as.numeric(input$areaSVG_mVms)>=1 & as.numeric(input$areaSVG_mVms)<=312, 'Please input a valid Spatial Ventricular Gradient magnitude (mVms).'))
    areaSVG_mVms=as.numeric(input$areaSVG_mVms)
    validate(need(!is.na(as.numeric(input$SAIQRST))& as.numeric(input$SAIQRST)>=34 & as.numeric(input$SAIQRST)<=824, 'Please input a valid Sum Absolute QRST integral (mVms).'))
    SAIQRST=as.numeric(input$SAIQRST)
    
    data <- data.frame(agey = agey,
                       sex = sex,
                       race = race,
                       htn = htn,
                       diabetes = diabetes,
                       cva=cva,
                       af= af,
                       mi = mi,
                       revascularization =revascularization,
                       nyha = nyha,
                       exact_lvef= exact_lvef,
                       bun = bun,
                       egfr= egfr,
                       bb_usage = bb_usage,
                       aa_usage = aa_usage,
                       ACEI = ACEI,
                       ARB = ARB,
                       ccbs = ccbs,
                       aldosteroneAnt=aldosteroneAnt,
                       manufacturer=manufacturer,
                       icd_type=icd_type,
                       atp = atp,
                       progr = progr,
                       vt_zone_bpm= vt_zone_bpm,
                       vf_zone_bpm= vf_zone_bpm,
                       mbeat3=mbeat3,
                       HRbpm=HRbpm,
                       PVCany =PVCany,
                       QTch= QTch,
                       QRSduration_ms=QRSduration_ms,
                       areaQRSTAngle_deg= areaQRSTAngle_deg,
                       areaSVGElevation_deg= areaSVGElevation_deg,
                       aSVGaz=aSVGaz,
                       areaSVG_mVms=areaSVG_mVms,
                       SAIQRST=SAIQRST)
  data})
  
  output$result <- DT::renderDataTable({
    data_df = data()
    
    
    pred1 = eval(predict.risk.MMVT, envir = data_df)
    pred1 = paste(round(pred1 * 100, 1), "%", sep='')
    
    pred2 = eval(predict.risk.PVT, envir = data_df)
    pred2 = paste(round(pred2 * 100, 1), "%", sep='')
    
    res = data.frame(Result = c("Probability of MMVT","Probability of PVT/VF"),
                     Probability = c(pred1,pred2))
    
    res}, options = list(
      pageLength = 10,
      lengthMenu = 0,
      
      searching = 0,
      info = 0,
      paging = 0,
      processing = 0,
      initComplete = I(
        "function(settings, json) {
                    $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
            }")))
})