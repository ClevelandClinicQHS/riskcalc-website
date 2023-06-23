pred_seizure <- expression({
  if (side == "Right") {
    lp = -1.1299881 + 0.10619708 * (sex == "Male") - 0.018622613 * 
      Epilepsy_duration - 0.010203882 * sz_freq_pre_op - 0.97516498 * 
      (Presence_of_GTC_seizures == "Yes") - 
      0.81700468 * (causes_of_seizures == "Other") - 
      0.080442055 * (causes_of_seizures == "Tumor") + 
      0.40488185 * (Type_of_surgery == "Amygdalohippocampectomy") - 
      0.56417989 * (Type_of_surgery == "TLY Sparing Mesial Structures") + 
      0.0751041 * (MRI == "Normal") + 0.013037822 * Entorhinal_Cortex_Right + 
      0.010566301 * Isthmus_Cingulate_Asymmetry - 0.016176163 * 
      Medial_Parietal_Left + 0.01069189 * Middle_Temporal_Right + 
      0.015422179 * Nucleus_Accumbens_Asymmetry + 0.019150411 * 
      Paracentral_Asymmetry + 0.011168333 * Parahippocampal_Right + 
      0.014252081 * Pericalcarine_Right - 0.011224414 * RAC_Left + 
      0.012915899 * TT_Right
  } else {
    lp = 2.3026147 - 0.1158022 * (sex == "Male") - 0.00036143035 * 
      Epilepsy_duration + 0.00033615709 * sz_freq_pre_op - 
      0.97802449 * (Presence_of_GTC_seizures == "Yes") - 1.3145919 * 
      (causes_of_seizures == "Other") - 
      0.3997491 * (causes_of_seizures == "Tumor") - 
      0.52064539 * (Type_of_surgery == "Amygdalohippocampectomy") + 
      0.57230762 * (Type_of_surgery == "TLY Sparing Mesial Structures") + 
      0.15135964 * (MRI == "Normal") - 0.0091806563 * Anterior_Cingulate_Asymmetry + 
      0.018890765 * Middle_Frontal_Right - 0.011314339 * Middle_Frontal_Asymmetry + 
      0.01456148 * Pallidum_Left + 0.0089888718 * Parahippocampal_Right - 
      0.011868264 * Premotor_Right - 0.010050323 * Putamen_Right + 
      0.0093090691 * VD_Asymmetry
  }
  exp(lp)/(1+exp(lp))
})

pred_engel = expression({
  if (side == "Right") {
    lp =  1.2756286 - 0.018941565 * sz_freq_pre_op - 
      0.32744517 * (Presence_of_GTC_seizures == "Yes") - 0.24559465 * (causes_of_seizures == "Other") + 
      0.80108812 * (causes_of_seizures == "Tumor") + 0.97874858 * 
      (Type_of_surgery == "Amygdalohippocampectomy") - 1.025925 * 
      (Type_of_surgery == "TLY Sparing Mesial Structures") + 
      0.054971893 * (MRI == "Normal") + 0.012605529 * Entorhinal_Cortex_Right - 
      0.006953792 * Inferior_Frontal_Right + 0.014123409 * 
      Pericalcarine_Left - 0.017361302 * Primary_Motor_Left - 
      0.013210062 * RAC_Left + 0.011928768 * Superior_Parietal_Asymmetry
  }
  else {
    lp = 1.49381 - 0.0019744544 * sz_freq_pre_op - 
      0.68188653 * (Presence_of_GTC_seizures == "Yes") - 
      1.26491 * (causes_of_seizures == "Other") + 
      0.72391971 * (causes_of_seizures == "Tumor") + 0.47235577 * 
      (Type_of_surgery == "Amygdalohippocampectomy") + 0.020628048 * 
      (Type_of_surgery == "TLY Sparing Mesial Structures") + 
      0.18749707 * (MRI == "Normal") - 0.016764994 * Middle_Frontal_Asymmetry - 
      0.010706833 * Putamen_Right + 0.0031994876 * Pallidum_Left - 
      0.0041048919 * Lateral_Orbitofrontal_Left + 0.010203196 * 
      CWMH_Asymmetry + 0.013895647 * Pars_Orbitalis_Right - 
      0.011494721 * Occipital_Lobe_Asymmetry + 0.0073351223 * 
      Medial_Parietal_Asymmetry + 0.0082468736 * Parahippocampal_Right + 
      0.01158956 * Inferior_Parietal_Asymmetry + 0.0083453747 * 
      TT_Left
  }
  exp(lp)/(1+exp(lp))
})


server = function(input, output, session){

  data <- eventReactive(input$goButton,{
    side = input$side
    sex = input$sex
    Epilepsy_duration = input$Epilepsy_duration
    sz_freq_pre_op = input$sz_freq_pre_op
    Presence_of_GTC_seizures = input$Presence_of_GTC_seizures
    causes_of_seizures = input$causes_of_seizures
    Type_of_surgery = input$Type_of_surgery
    MRI = input$MRI
    Entorhinal_Cortex_Right = input$Entorhinal_Cortex_Right
    Isthmus_Cingulate_Asymmetry = input$Isthmus_Cingulate_Asymmetry
    Medial_Parietal_Left = input$Medial_Parietal_Left
    Middle_Temporal_Right = input$Middle_Temporal_Right
    Nucleus_Accumbens_Asymmetry = input$Nucleus_Accumbens_Asymmetry
    Paracentral_Asymmetry = input$Paracentral_Asymmetry
    Parahippocampal_Right = input$Parahippocampal_Right
    Pericalcarine_Right = input$Pericalcarine_Right
    RAC_Left = input$RAC_Left
    TT_Right = input$TT_Right
    Anterior_Cingulate_Asymmetry = input$Anterior_Cingulate_Asymmetry
    Middle_Frontal_Right = input$Middle_Frontal_Right
    Middle_Frontal_Asymmetry = input$Middle_Frontal_Asymmetry
    Pallidum_Left = input$Pallidum_Left
    Premotor_Right = input$Premotor_Right
    Putamen_Right = input$Putamen_Right
    VD_Asymmetry = input$VD_Asymmetry
    Entorhinal_Cortex_Right = input$Entorhinal_Cortex_Right
    Inferior_Frontal_Right = input$Inferior_Frontal_Right
    Pericalcarine_Left = input$Pericalcarine_Left
    Primary_Motor_Left = input$Primary_Motor_Left
    RAC_Left = input$RAC_Left
    Superior_Parietal_Asymmetry = input$Superior_Parietal_Asymmetry
    Putamen_Right = input$Putamen_Right
    Lateral_Orbitofrontal_Left = input$Lateral_Orbitofrontal_Left
    CWMH_Asymmetry = input$CWMH_Asymmetry
    Pars_Orbitalis_Right = input$Pars_Orbitalis_Right
    Occipital_Lobe_Asymmetry = input$Occipital_Lobe_Asymmetry
    Medial_Parietal_Asymmetry = input$Medial_Parietal_Asymmetry
    Inferior_Parietal_Asymmetry = input$Inferior_Parietal_Asymmetry
    TT_Left = input$TT_Left
    
    data <- data.frame(
      side = side,
      sex = sex,
      Epilepsy_duration = Epilepsy_duration,
      sz_freq_pre_op = sz_freq_pre_op,
      Presence_of_GTC_seizures = Presence_of_GTC_seizures,
      causes_of_seizures = causes_of_seizures,
      Type_of_surgery = Type_of_surgery,
      MRI = MRI,
      Entorhinal_Cortex_Right = Entorhinal_Cortex_Right,
      Isthmus_Cingulate_Asymmetry = Isthmus_Cingulate_Asymmetry,
      Medial_Parietal_Left = Medial_Parietal_Left,
      Middle_Temporal_Right = Middle_Temporal_Right,
      Nucleus_Accumbens_Asymmetry = Nucleus_Accumbens_Asymmetry,
      Paracentral_Asymmetry = Paracentral_Asymmetry,
      Parahippocampal_Right = Parahippocampal_Right,
      Pericalcarine_Right = Pericalcarine_Right,
      RAC_Left = RAC_Left,
      TT_Right = TT_Right,
      Anterior_Cingulate_Asymmetry = Anterior_Cingulate_Asymmetry,
      Middle_Frontal_Right = Middle_Frontal_Right,
      Middle_Frontal_Asymmetry = Middle_Frontal_Asymmetry,
      Pallidum_Left = Pallidum_Left,
      Premotor_Right = Premotor_Right,
      Putamen_Right = Putamen_Right,
      VD_Asymmetry = VD_Asymmetry,
      Entorhinal_Cortex_Right = Entorhinal_Cortex_Right,
      Inferior_Frontal_Right = Inferior_Frontal_Right,
      Pericalcarine_Left = Pericalcarine_Left,
      Primary_Motor_Left = Primary_Motor_Left,
      RAC_Left = RAC_Left,
      Superior_Parietal_Asymmetry = Superior_Parietal_Asymmetry,
      Putamen_Right = Putamen_Right,
      Lateral_Orbitofrontal_Left = Lateral_Orbitofrontal_Left,
      CWMH_Asymmetry = CWMH_Asymmetry,
      Pars_Orbitalis_Right = Pars_Orbitalis_Right,
      Occipital_Lobe_Asymmetry = Occipital_Lobe_Asymmetry,
      Medial_Parietal_Asymmetry = Medial_Parietal_Asymmetry,
      Inferior_Parietal_Asymmetry = Inferior_Parietal_Asymmetry,
      TT_Left = TT_Left
    )
    data
  })
  
  output$result <- DT::renderDataTable({
    data = data()
    pred.outcome1 = eval(pred_seizure, envir = data)
    pred.outcome2 = eval(pred_engel, envir = data)
    
    pred.outcome1 = ifelse(pred.outcome1<0.001, "<0.1%", ifelse(pred.outcome1>0.999, ">99.9%", paste(round(pred.outcome1*100,1),"%",sep="")))
    pred.outcome2 = ifelse(pred.outcome2<0.001, "<0.1%", ifelse(pred.outcome2>0.999, ">99.9%", paste(round(pred.outcome2*100,1),"%",sep="")))
    
    result = data.frame(Result = c("Predicted probability of Seizure free", "Predicted probability of Engel I"),
                        Probability = c(pred.outcome1, pred.outcome2))
    result
  }, rownames= FALSE,
  options = list(
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
}