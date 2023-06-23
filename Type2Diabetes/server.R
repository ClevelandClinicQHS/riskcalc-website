predict.mortality <- expression({
    lp <- 0.56028683 - 
        0.021961828 * (186 * (Creatinine  ^  -1.154) * (Age ^ -0.203) * (0.742 ^     (Gender=="Female")) * (1.21 ^ (Race=="African-American"))) + 
        0.000009732539 * max((186 *    (Creatinine  ^  -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Race==    "African-American"))) -46.833457, 0)**3 - 
        0.000045100515 * max((186 * (Creatinine  ^     -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Race=="African-American"))) -     80.684806, 0)**3 + 
        0.000035367976 * max((186 * (Creatinine  ^  -1.154) * (Age ^ -0.203) *    (0.742 ^ (Gender=="Female")) * (1.21 ^ (Race=="African-American"))) - 90, 0)**3 + 
        0.063715362 *     Age - 
        0.0000018675819 * max(Age - 43.4, 0)**3 + 
        0.000003965865 * max(Age - 62.5, 0)**3 -     
        0.0000020982832 * max(Age - 79.5, 0)**3 + 
        3.194722 * (Medication == "Meglitinide") + 
        1.8032859 *     (Medication == "Sulfonylurea") + 
        2.4109024 * (Medication == "Thiazolidinedion") + 
        0.17656434 * (Gender ==     "Male") + 
        0.20445682 * (Race == "Caucasian") + 
        0.052486652 * (BaseTLCBypassCAD ==    "Yes") - 
        0.06023489 * BaseHba1c + 
        0.0053108385 * max(BaseHba1c - 5.8, 0)**3 - 
        0.0076343303 *    max(BaseHba1c - 7.2, 0)**3 + 
        0.0023234918 * max(BaseHba1c - 10.4, 0)**3 - 
        0.035835843 *     Base_BMI + 
        0.00014369089 * max(Base_BMI - 24.2, 0)**3 - 
        0.00023430677 * max(Base_BMI -    31.2, 0)**3 + 
        0.00009061588 * max(Base_BMI - 42.3, 0)**3 + 
        0.45815991 * (BaseHeartFailure ==     "Yes") - 
        0.011122308 * BaseBPSystolic + 
        0.0000041090369 * max(BaseBPSystolic - 110, 0)**    3 - 
        0.0000073375659 * max(BaseBPSystolic - 132, 0)**3 + 
        0.000003228529 * max(BaseBPSystolic -     160, 0)**3 - 
        0.012728125 * BaseBPDiastolic + 
        0.0000069679611 * max(BaseBPDiastolic -     60, 0)**3 - 
        0.000017419903 * max(BaseBPDiastolic - 78, 0)**3 + 
        0.000010451942 *     max(BaseBPDiastolic - 90, 0)**3 - 
        0.0044097136 * BaseHDL + 
        0.0000074199161 * max(BaseHDL -     31, 0)**3 - 
        0.000012242862 * max(BaseHDL - 44, 0)**3 + 
        0.0000048229455 * max(BaseHDL -     64, 0)**3 - 
        0.0036138813 * BaseLDL + 
        0.00000039506801 * max(BaseLDL - 63, 0)**3 -     
        0.00000069502705 * max(BaseLDL - 104, 0)**3 + 
        0.00000029995904 * max(BaseLDL - 158, 0)**    3 - 
        0.00073776518 * BaseTriglycerides + 
        0.000000013045819 * max(BaseTriglycerides -     78, 0)**3 - 
        0.000000018510037 * max(BaseTriglycerides - 158, 0)**3 + 
        0.0000000054642176 *     max(BaseTriglycerides - 349, 0)**3 + 
        0.16152487 * (BaseSmoke == "Quit") + 
        0.37679934 *     (BaseSmoke == "Yes") + 
        0.47291653 * (BaseInsulin == "Yes") - 
        0.12816986 * (BaseACEInhibOrARB ==    "Yes") + 
        0.24943321 * (new_diabetes == "No") - 
        0.044810759 * (BaseAspirin == "Yes") +     
        0.15919021 * (BasePlavix == "Yes") + 
        0.19962889 * (BaseCholLowervsLipid == "No") -     
        0.090548828 * (BaseCholLowervsLipid == "Yes - After Lipid Panel") + 
        (Medication == "Meglitinide") * (0.0058249368 *     (186 * (Creatinine  ^  -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^     (Race=="African-American"))) - 0.0000022104689 * max((186 * (Creatinine  ^  -1.154) *    (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Race=="African-American"))) -     46.833457, 0)**3 +0.000010243297 * max((186 * (Creatinine  ^  -1.154) * (Age ^ -0.203) *    (0.742 ^ (Gender=="Female")) * (1.21 ^ (Race=="African-American"))) - 80.684806, 0)**    3 - 0.000008032828 * max((186 * (Creatinine  ^  -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender==    "Female")) * (1.21 ^ (Race=="African-American"))) - 90, 0)**3) + 
        (Medication == "Sulfonylurea") *    (0.0059495196 * (186 * (Creatinine  ^  -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) *    (1.21 ^ (Race=="African-American"))) - 0.0000034485636 * max((186 * (Creatinine  ^  -1.154) *    (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Race=="African-American"))) -     46.833457, 0)**3 + 0.000015980619 * max((186 * (Creatinine  ^  -1.154) * (Age ^ -0.203) *     (0.742 ^ (Gender=="Female")) * (1.21 ^ (Race=="African-American"))) - 80.684806, 0)**    3 - 0.000012532055 * max((186 * (Creatinine  ^  -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender==    "Female")) * (1.21 ^ (Race=="African-American"))) - 90, 0)**3) + 
        (Medication == "Thiazolidinedion") *    (-0.0039585837 * (186 * (Creatinine  ^  -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) *    (1.21 ^ (Race=="African-American"))) - 0.00000058864944 * max((186 * (Creatinine  ^  -1.154) *    (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Race=="African-American"))) -     46.833457, 0)**3 + 0.0000027277973 * max((186 * (Creatinine  ^  -1.154) * (Age ^ -0.203) *    (0.742 ^ (Gender=="Female")) * (1.21 ^ (Race=="African-American"))) - 80.684806, 0)**    3 - 0.0000021391478 * max((186 * (Creatinine  ^  -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender==    "Female")) * (1.21 ^ (Race=="African-American"))) - 90, 0)**3) + 
        (Medication == "Meglitinide") *     (-0.050715995 * Age + 0.000027215485 * max(Age - 43.4, 0)**3 - 0.000057792882 *     max(Age - 62.5, 0)**3 + 0.000030577397 * max(Age - 79.5, 0)**3) + (Medication ==     "Sulfonylurea") * (-0.024914294 * Age + 0.0000063155025 * max(Age - 43.4, 0)**3 - 0.000013411155 *     max(Age - 62.5, 0)**3 + 0.0000070956528 * max(Age - 79.5, 0)**3) + (Medication ==     "Thiazolidinedion") * (-0.0328828 * Age + 0.000016940185 * max(Age - 43.4, 0)**3 - 0.000035972982 *     max(Age - 62.5, 0)**3 + 0.000019032797 * max(Age - 79.5, 0)**3)
    0.8231468 ** exp(lp) * 100
})
        library(shiny)
        shinyServer(function(input, output){
            data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$Age))& as.numeric(input$Age)>=0, 'Please input a valid Age'))
Age= as.numeric(input$Age)
Gender = factor(input$Gender, levels = c('Female', 'Male'))
Race = factor(input$Race, levels = c('Caucasian', 'African-American', 'Asian', 'Others'))
validate(need(!is.na(as.numeric(input$Creatinine))& as.numeric(input$Creatinine)>=0.1& as.numeric(input$Creatinine)<=5.0, 'Please input a valid Creatinine'))
Creatinine= as.numeric(input$Creatinine)
BaseTLCBypassCAD = factor(input$BaseTLCBypassCAD, levels = c('No', 'Yes'))
validate(need(!is.na(as.numeric(input$BaseHba1c))& as.numeric(input$BaseHba1c)>=5& as.numeric(input$BaseHba1c)<=15, 'Please input a valid BaseHba1c'))
BaseHba1c= as.numeric(input$BaseHba1c)
validate(need(!is.na(as.numeric(input$Base_BMI))& as.numeric(input$Base_BMI)>=15& as.numeric(input$Base_BMI)<=60, 'Please input a valid Base_BMI'))
Base_BMI= as.numeric(input$Base_BMI)
BaseHeartFailure = factor(input$BaseHeartFailure, levels = c('No', 'Yes'))
validate(need(!is.na(as.numeric(input$BaseBPSystolic))& as.numeric(input$BaseBPSystolic)>=60& as.numeric(input$BaseBPSystolic)<=200, 'Please input a valid BaseBPSystolic'))
BaseBPSystolic= as.numeric(input$BaseBPSystolic)
validate(need(!is.na(as.numeric(input$BaseBPDiastolic))& as.numeric(input$BaseBPDiastolic)>=50& as.numeric(input$BaseBPDiastolic)<=120, 'Please input a valid BaseBPDiastolic'))
BaseBPDiastolic= as.numeric(input$BaseBPDiastolic)
validate(need(!is.na(as.numeric(input$BaseHDL))& as.numeric(input$BaseHDL)>=5& as.numeric(input$BaseHDL)<=100, 'Please input a valid BaseHDL'))
BaseHDL= as.numeric(input$BaseHDL)
validate(need(!is.na(as.numeric(input$BaseLDL))& as.numeric(input$BaseLDL)>=50& as.numeric(input$BaseLDL)<=450, 'Please input a valid BaseLDL'))
BaseLDL= as.numeric(input$BaseLDL)
validate(need(!is.na(as.numeric(input$BaseTriglycerides))& as.numeric(input$BaseTriglycerides)>=50& as.numeric(input$BaseTriglycerides)<=500, 'Please input a valid BaseTriglycerides'))
BaseTriglycerides= as.numeric(input$BaseTriglycerides)
BaseSmoke = factor(input$BaseSmoke, levels = c('No', 'Yes', 'Quit'))
Medication = factor(input$Medication, levels = c('Biguanide', 'Meglitinide', 'Thiazolidinedion', 'Sulfonylurea', 'Compare all of the Medications'))
BaseInsulin = factor(input$BaseInsulin, levels = c('No', 'Yes'))
BaseACEInhibOrARB = factor(input$BaseACEInhibOrARB, levels = c('No', 'Yes'))
new_diabetes = factor(input$new_diabetes, levels = c('No', 'Yes'))
BasePlavix = factor(input$BasePlavix, levels = c('No', 'Yes'))
BaseAspirin = factor(input$BaseAspirin, levels = c('No', 'Yes'))
BaseCholLowervsLipid = factor(input$BaseCholLowervsLipid, levels = c('No', 'Yes - After Lipid Panel', "Yes - Before Lipid Panel"))
data <- data.frame(Age = Age,
Gender = Gender,
Race = Race,
Creatinine = Creatinine,
BaseTLCBypassCAD = BaseTLCBypassCAD,
BaseHba1c = BaseHba1c,
Base_BMI = Base_BMI,
BaseHeartFailure = BaseHeartFailure,
BaseBPSystolic = BaseBPSystolic,
BaseBPDiastolic = BaseBPDiastolic,
BaseHDL = BaseHDL,
BaseLDL = BaseLDL,
BaseTriglycerides = BaseTriglycerides,
BaseSmoke = BaseSmoke,
Medication = Medication,
BaseInsulin = BaseInsulin,
BaseACEInhibOrARB = BaseACEInhibOrARB,
new_diabetes = new_diabetes,
BasePlavix = BasePlavix,
BaseAspirin = BaseAspirin,
BaseCholLowervsLipid = BaseCholLowervsLipid)
data})
output$result <- renderDataTable({data = data()
prob <- paste(ifelse(round(eval(predict.mortality, data), 0) < 1, "<1", ifelse(round(eval(predict.mortality, data), 0) > 99, ">99", round(eval(predict.mortality, data), 0))), "%")
res = data.frame(Result = c("6-Year Percent Chance of Survival"),
                 Probability = c(prob))

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
        