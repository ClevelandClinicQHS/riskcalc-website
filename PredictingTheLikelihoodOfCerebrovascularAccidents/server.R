predict.cva <- expression({
    lp <- -7.4211868 + 
        0.040482656 * age - 
        0.000013818711 * max(age -48, 0)**3 + 
        0.000029479918 * max(age - 65, 0)**3 - 
        0.000015661206 * max(age - 80, 0)**3 + 
        0.33191507 * (Gender_Female == "Yes") +
        0.082391008 * (hypertension == "Yes") - 
        0.44670986 * (Disorder_Lipid_Metabolism == "Yes") + 
        0.22111703 * (Peripheral_and_Viceral_Atherosclerosis == "Yes") + 
        1.5146781 * (Occlusion_Stenosis_Precerebral_Arteries == "Yes") + 
        1.6330864 * (Ill_Defined_Cerebrovascular_Disease == "Yes") + 
        0.42027377 * (Congestive_Heart_Failure == "Yes") + 
        0.25811733 * (Aortic_Valve_Disorder == "Yes") + 
        0.60064812 * (Acute_Myocardial_Infarction == "Yes") - 
        0.86635225 * (Coronary_Atherosclerosis == "Yes") +
        0.50429617 * (Atrial_Fibrillation_Flutter == "Yes") + 
        1.0339901 * (Head_Migraine == "Yes") + 
        0.62699893 * (SLE_Connective_Tissue_Disease == "Yes")
    100/(1+exp(-lp))
})
        library(shiny)
        shinyServer(function(input, output){
            data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$age))& as.numeric(input$age)>=20& as.numeric(input$age)<=80, 'Please input a valid age'))
age= as.numeric(input$age)
Gender_Female = factor(input$Gender_Female, levels = c('No', 'Yes'))
hypertension = factor(input$hypertension, levels = c('No', 'Yes'))
Disorder_Lipid_Metabolism = factor(input$Disorder_Lipid_Metabolism, levels = c('No', 'Yes'))
Peripheral_and_Viceral_Atherosclerosis = factor(input$Peripheral_and_Viceral_Atherosclerosis, levels = c('No', 'Yes'))
Occlusion_Stenosis_Precerebral_Arteries = factor(input$Occlusion_Stenosis_Precerebral_Arteries, levels = c('No', 'Yes'))
Ill_Defined_Cerebrovascular_Disease = factor(input$Ill_Defined_Cerebrovascular_Disease, levels = c('No', 'Yes'))
Congestive_Heart_Failure = factor(input$Congestive_Heart_Failure, levels = c('No', 'Yes'))
Aortic_Valve_Disorder = factor(input$Aortic_Valve_Disorder, levels = c('No', 'Yes'))
Acute_Myocardial_Infarction = factor(input$Acute_Myocardial_Infarction, levels = c('No', 'Yes'))
Coronary_Atherosclerosis = factor(input$Coronary_Atherosclerosis, levels = c('No', 'Yes'))
Atrial_Fibrillation_Flutter = factor(input$Atrial_Fibrillation_Flutter, levels = c('No', 'Yes'))
Head_Migraine = factor(input$Head_Migraine, levels = c('No', 'Yes'))
SLE_Connective_Tissue_Disease = factor(input$SLE_Connective_Tissue_Disease, levels = c('No', 'Yes'))
data <- data.frame(age = age,
Gender_Female = Gender_Female,
hypertension = hypertension,
Disorder_Lipid_Metabolism = Disorder_Lipid_Metabolism,
Peripheral_and_Viceral_Atherosclerosis = Peripheral_and_Viceral_Atherosclerosis,
Occlusion_Stenosis_Precerebral_Arteries = Occlusion_Stenosis_Precerebral_Arteries,
Ill_Defined_Cerebrovascular_Disease = Ill_Defined_Cerebrovascular_Disease,
Congestive_Heart_Failure = Congestive_Heart_Failure,
Aortic_Valve_Disorder = Aortic_Valve_Disorder,
Acute_Myocardial_Infarction = Acute_Myocardial_Infarction,
Coronary_Atherosclerosis = Coronary_Atherosclerosis,
Atrial_Fibrillation_Flutter = Atrial_Fibrillation_Flutter,
Head_Migraine = Head_Migraine,
SLE_Connective_Tissue_Disease = SLE_Connective_Tissue_Disease)
data})
output$result <- renderDataTable({data = data()
cva <- paste(ifelse(round(eval(predict.cva, data), 0) < 1, "<1", ifelse(round(eval(predict.cva, data), 0) > 99, ">99", round(eval(predict.cva, data), 0))), "%")
res = data.frame(Result = c("Predicted Probability of Acute Cerebrovascular Accidents (CVA)"),
                 Probability = c(cva))

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
        