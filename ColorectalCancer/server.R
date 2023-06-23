formula <- expression({
    if (Gender == "Female"){
        lp <- -5.9026635 + 
            0.090012542 * AgeYr - 
            4.4217156e-05 * max(AgeYr - 47, 0)**3 + 
            9.2119076e-05 * max(AgeYr - 60, 0)**3 - 
            4.7901919e-05 * max(AgeYr - 72, 0)**3 - 
            0.24100367* (Ethnicity == "Hawaiian")+ 
            0.014010715   * (Ethnicity == "Japanese")- 
            0.39669678    * (Ethnicity == "Latino")- 
            0.34056094    * (Ethnicity == "White")+ 
            0.07443905    * YearsEdu - 
            0.00062546554 * max(YearsEdu -  7, 0)**3 + 
            0.0017200302  * max(YearsEdu - 14, 0)**3 - 
            0.0010945647  * max(YearsEdu - 18, 0)**3 - 
            0.24500762    * (Estrogen == "Yes-currently")- 
            0.044320489   * (Estrogen == "Yes-previously")+ 
            0.23328937    * (Diabetes == "Yes")+ 
            0.062703176   * PackYears - 
            0.002446026   * max(PackYears, 0)**3 + 
            0.003038396   * max(PackYears - 1.25, 0)**3 - 
            0.00059134632 * max(PackYears - 6.375, 0)**3 - 
            1.023614e-06  * max(PackYears - 27.5125, 0)**3 + 
            0.31589053    * (FamilyCRC == "Yes")- 
            0.1665365     * (Multivitamin == "Yes") + 
            0.0075233925  * (Weight * 0.45359237) / ((Height * 0.0254)    ^    2) + 
            6.7918662e-05 * max((Weight * 0.45359237) / ((Height * 0.0254)    ^    2) - 20.371336, 0)**3 - 
            0.00011039091 * max((Weight * 0.45359237) / ((Height * 0.0254)    ^    2) - 25.508027, 0)**3 + 
            4.2472244e-05 * max((Weight * 0.45359237) / ((Height * 0.0254)    ^    2) - 33.722266, 0)**3 - 
            0.046383323   * (PainMed == "Yes, but not currently")- 
            0.236997      * (PainMed == "Yes, currently")- 
            0.08856241    * Alcohol + 
            0.62375456    * max(Alcohol, 0)**3 - 
            0.7191129     * max(Alcohol - 0.10740682, 0)**3+ 
            0.095358349   * max(Alcohol - 0.8099724, 0)**3
        100 - 100 *	0.9901043 ** exp(lp)
    } else {
        lp <- -6.6419738 + 
            0.091669179 * AgeYr - 
            3.7411814e-05 * max(AgeYr - 47, 0)**3 + 
            7.794128e-05  * max(AgeYr - 60, 0)**3 - 
            4.0529466e-05 * max(AgeYr - 72, 0)**3 + 
            0.16092241    * (Ethnicity == "Hawaiian")+ 
            0.25353936    * (Ethnicity == "Japanese")- 
            0.13659953    * (Ethnicity == "Latino")- 
            0.16728044    * (Ethnicity == "White")+ 
            0.00022581331 * PackYears + 
            1.1341047e-05 * max(PackYears, 0)**3 - 
            1.3522018e-05 * max(PackYears - 6.375, 0)**3 + 
            2.1809706e-06 * max(PackYears - 39.525,0)**3 + 
            0.28379769    * Alcohol - 
            0.21424251    * max(Alcohol, 0)**3 + 
            0.22570057    * max(Alcohol - 0.14457189, 0)**3 - 
            0.011458065   * max(Alcohol - 2.8477722, 0)**3 + 
            0.018020786   * (Weight * 0.45359237) / ((Height * 0.0254)       ^       2)+ 
            9.4715899e-05 * max((Weight * 0.45359237) / ((Height * 0.0254)       ^       2) -22.047175, 0)**3 - 
            0.00015791645 * max((Weight * 0.45359237) / ((Height * 0.0254)       ^       2) - 25.941735, 0)**3 + 
            6.3200548e-05 * max((Weight * 0.45359237) / ((Height * 0.0254)       ^       2) - 31.778341, 0)**3 + 
            0.072052428   * YearsEdu - 
            0.00060634342 * max(YearsEdu - 7, 0)**3 + 
            0.0016674444  * max(YearsEdu -14, 0)**3 - 
            0.001061101   * max(YearsEdu - 18, 0)**3 - 
            0.032284161   * (Aspirin == "Yes - Not Currently")- 
            0.20960315    * (Aspirin == "Yes")+ 
            0.24250922    * (FamilyCRC == "Yes")- 
            0.19175375    * (Multivitamin == "Yes")+ 
            0.073141733   *  TotalMeat - 
            0.0043503766  * max(TotalMeat - 0.59081962, 0)**3 + 
            0.0065250851  * max(TotalMeat - 2.0822052, 0)**3 - 
            0.0021747085  * max(TotalMeat - 5.0656345, 0)**3 + 
            0.11020556    * (Diabetes == "Yes")- 
            0.090669913   * Activity + 
            0.0093816671  * max(Activity - 0.10714286, 0)**3 - 
            0.011850527   * max(Activity - 0.82142857, 0)**3 + 
            0.0024688598  * max(Activity - 3.5357143,  0)**3
        100 - 100 * 0.9846654 ** exp(lp)
    }
})
        library(shiny)
        shinyServer(function(input, output){
            data <- eventReactive(input$goButton, {
        Gender = factor(input$Gender, levels = c('Male', 'Female'))
validate(need(!is.na(as.numeric(input$Weight))& as.numeric(input$Weight)>=75& as.numeric(input$Weight)<=350, 'Please input a valid Weight'))
Weight= as.numeric(input$Weight)
validate(need(!is.na(as.numeric(input$Height))& as.numeric(input$Height)>=60& as.numeric(input$Height)<=80, 'Please input a valid Height'))
Height= as.numeric(input$Height)
validate(need(!is.na(as.numeric(input$AgeYr))& as.numeric(input$AgeYr)>=45& as.numeric(input$AgeYr)<=85, 'Please input a valid AgeYr'))
AgeYr= as.numeric(input$AgeYr)
Ethnicity = factor(input$Ethnicity, levels = c('Hawaiian', 'Japanese', 'Latino', 'White', 'Black'))
validate(need(!is.na(as.numeric(input$PackYears))& as.numeric(input$PackYears)>=0& as.numeric(input$PackYears)<=50, 'Please input a valid PackYears'))
PackYears= as.numeric(input$PackYears)
validate(need(!is.na(as.numeric(input$Alcohol))& as.numeric(input$Alcohol)>=0& as.numeric(input$Alcohol)<=12, 'Please input a valid Alcohol'))
Alcohol= as.numeric(input$Alcohol)
validate(need(!is.na(as.numeric(input$YearsEdu))& as.numeric(input$YearsEdu)>=6& as.numeric(input$YearsEdu)<=20, 'Please input a valid YearsEdu'))
YearsEdu= as.numeric(input$YearsEdu)
FamilyCRC = factor(input$FamilyCRC, levels = c('No', 'Yes'))
Aspirin = factor(input$Aspirin, levels = c('No', 'Yes - Not Currently', 'Yes'))
Multivitamin = factor(input$Multivitamin, levels = c('No', 'Yes'))
Diabetes = factor(input$Diabetes, levels = c('No', 'Yes'))
PainMed = factor(input$PainMed, levels = c('No', 'Yes, but not currently', 'Yes, currently'))
Estrogen = factor(input$Estrogen, levels = c('No', 'Yes, but not currently', 'Yes-currently'))
validate(need(!is.na(as.numeric(input$Activity))& as.numeric(input$Activity)>=0& as.numeric(input$Activity)<=4, 'Please input a valid Activity'))
Activity= as.numeric(input$Activity)
validate(need(!is.na(as.numeric(input$TotalMeat))& as.numeric(input$TotalMeat)>=0& as.numeric(input$TotalMeat)<=5, 'Please input a valid TotalMeat'))
TotalMeat= as.numeric(input$TotalMeat)
data <- data.frame(Gender = Gender,
Weight = Weight,
Height = Height,
AgeYr = AgeYr,
Ethnicity = Ethnicity,
PackYears = PackYears,
Alcohol = Alcohol,
YearsEdu = YearsEdu,
FamilyCRC = FamilyCRC,
Aspirin = Aspirin,
Multivitamin = Multivitamin,
Diabetes = Diabetes,
PainMed = PainMed,
Estrogen = Estrogen,
Activity = Activity,
TotalMeat = TotalMeat)
data})
output$result <- renderDataTable({data = data()
prob = eval(formula, data)
res = data.frame(Result = c("10-Yr Risk of Colorectal Cancer"), Probability = c(paste(ifelse(round(prob, 0) < 1, "<1", ifelse(round(prob, 0) > 99, ">99", round(prob, 0))), "%")))

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
        