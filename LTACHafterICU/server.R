predict.LTACH <- expression({
    lp <- 1/(1 + 1/exp(- 4.1390500 + 
                           0.019231393 * Age - 
                           0.11188302 * (Gender == "Male") - 
                           0.0088969237 * BMI + 
                           0.23525407 * log(0.1 + NUM_LOSbeforeICUadmit) - 
                           0.50410184 * (Adm_Site == "Floor/Operating Room") + 
                           0.52621103 * (Adm_Site == "SNF/LTAC/Hospital Transfer") + 
                           1.1514666 * (ICU_Category == "Coronary ICU") + 
                           1.5391627 * (ICU_Category == "Heart Failure ICU") + 
                           1.4192117 * (ICU_Category == "Medical ICU") + 
                           2.0039921 * (ICU_Category == "Neuro ICU") + 
                           1.253251 * (ICU_Category == "Surgical ICU") - 
                           0.72773274 * (Planned == "Planned") - 
                           0.003174152 * MAPDay0 + 
                           1.1582836 * (PressureUlcer == "Yes") + 
                           1.0364935 * (IntubationDay0 == "Yes") + 
                           0.0086950119 * FiO2Day0 + 
                           0.0010465772 * PaO2Day0 + 
                           0.082946601 * (DopaDay0 == "Yes") - 
                           0.19018683 * (DobutDay0 == "Yes") + 
                           0.11736612 * (EpineDay0 == "Yes") + 
                           0.61845182 * (NoraDay0 == "Yes") + 
                           0.66390256 * (DialysisDay0 == "Yes") + 
                           0.050277399 * CreatinineDay0 + 
                           0.0134312 * BilirubinDay0 - 
                           0.50171813 * AlbuminDay0 + 
                           0.00075880147 * PlateletsDay0))
})

library(shiny)
shinyServer(function(input, output){
    data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$Age))& as.numeric(input$Age)>=18& as.numeric(input$Age)<=100, 'Please input a valid Age'))
        Age = as.numeric(input$Age)
        Gender = factor(input$Gender, levels = c('Female', 'Male'))
        validate(need(!is.na(as.numeric(input$BMI))& as.numeric(input$BMI)>0& as.numeric(input$BMI)<=100, 'Please input a valid BMI'))
        BMI = as.numeric(input$BMI)
        validate(need(!is.na(as.numeric(input$NUM_LOSbeforeICUadmit))& as.numeric(input$NUM_LOSbeforeICUadmit)>=0& as.numeric(input$NUM_LOSbeforeICUadmit)<=60, 'Please input a valid Length of Stay prior to ICU'))
        NUM_LOSbeforeICUadmit = as.numeric(input$NUM_LOSbeforeICUadmit)
        Adm_Site = factor(input$Adm_Site, levels = c("Emergency Department", "Floor/Operating Room", "SNF/LTAC/Hospital Transfer"))
        ICU_Category = factor(input$ICU_Category, levels = c('Cardiovascular ICU', "Coronary ICU", "Heart Failure ICU", "Medical ICU", "Neuro ICU", "Surgical ICU"))
        Planned = factor(input$Planned, levels = c("Planned", "Unplanned"))
        validate(need(!is.na(as.numeric(input$MAPDay0))& as.numeric(input$MAPDay0)>0& as.numeric(input$MAPDay0)<=300, 'Please input a valid Mean Arterial Pressure'))
        MAPDay0 = as.numeric(input$MAPDay0)
        PressureUlcer = factor(input$PressureUlcer, levels = c("No", "Yes"))
        IntubationDay0 = factor(input$IntubationDay0, levels = c("No", "Yes"))
        validate(need(!is.na(as.numeric(input$FiO2Day0))& as.numeric(input$FiO2Day0)>=20& as.numeric(input$FiO2Day0)<=100, 'Please input a valid Fraction of Inspired Oxygen'))
        FiO2Day0 = as.numeric(input$FiO2Day0)
        validate(need(!is.na(as.numeric(input$PaO2Day0))& as.numeric(input$PaO2Day0)>=0& as.numeric(input$PaO2Day0)<=700, 'Please input a valid Arterial Blood Oxygen Tension'))
        PaO2Day0 = as.numeric(input$PaO2Day0)
        DopaDay0 = factor(input$DopaDay0, levels = c("No", "Yes"))
        DobutDay0 = factor(input$DobutDay0, levels = c("No", "Yes"))
        NoraDay0 = factor(input$NoraDay0, levels = c("No", "Yes"))
        EpineDay0 = factor(input$EpineDay0, levels = c("No", "Yes"))
        DialysisDay0 = factor(input$DialysisDay0, levels = c("No", "Yes"))
        validate(need(!is.na(as.numeric(input$CreatinineDay0))& as.numeric(input$CreatinineDay0)>=0& as.numeric(input$CreatinineDay0)<=200, 'Please input a valid Creatinine'))
        CreatinineDay0 = as.numeric(input$CreatinineDay0)
        validate(need(!is.na(as.numeric(input$BilirubinDay0))& as.numeric(input$BilirubinDay0)>=0& as.numeric(input$BilirubinDay0)<=100, 'Please input a valid Bilirubin'))
        BilirubinDay0 = as.numeric(input$BilirubinDay0)
        validate(need(!is.na(as.numeric(input$AlbuminDay0))& as.numeric(input$AlbuminDay0)>=0& as.numeric(input$AlbuminDay0)<=100, 'Please input a valid Albumin'))
        AlbuminDay0 = as.numeric(input$AlbuminDay0)
        validate(need(!is.na(as.numeric(input$PlateletsDay0))& as.numeric(input$PlateletsDay0)>=0& as.numeric(input$PlateletsDay0)<=1000, 'Please input a valid Platelets'))
        PlateletsDay0 = as.numeric(input$PlateletsDay0)
        data <- data.frame(Age = Age, 
                           Gender = Gender,
                           BMI = BMI,
                           NUM_LOSbeforeICUadmit = NUM_LOSbeforeICUadmit,
                           Adm_Site = Adm_Site,
                           ICU_Category = ICU_Category,
                           Planned = Planned,
                           MAPDay0 = MAPDay0,
                           PressureUlcer = PressureUlcer,
                           IntubationDay0 = IntubationDay0,
                           FiO2Day0 = FiO2Day0,
                           PaO2Day0 = PaO2Day0,
                           DopaDay0 = DopaDay0,
                           DobutDay0 = DobutDay0,
                           NoraDay0 = NoraDay0,
                           EpineDay0 = EpineDay0,
                           DialysisDay0 = DialysisDay0,
                           CreatinineDay0 = CreatinineDay0,
                           BilirubinDay0 = BilirubinDay0,
                           AlbuminDay0 = AlbuminDay0,
                           PlateletsDay0 = PlateletsDay0)
        data})
    
    output$result <- renderDataTable({
        data = data()
        LTACH = round(eval(predict.LTACH, data) * 100, 0)
        LTACH = ifelse(LTACH < 1, "< 1%", ifelse(LTACH > 99, "> 99%", paste(LTACH, "%")))
        res = data.frame(Result = c("Probability of discharge to LTACH"),
                         Probability = c(LTACH))
        res
    }, options = list(
        pageLength = 10,
        lengthMenu = 0,
        
        searching = 0,
        info = 0,
        paging = 0,
        initComplete = I(
            "function(settings, json) {
                    $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});}"
        )
    )
    )
})
