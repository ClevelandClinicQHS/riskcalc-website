shinyServer(function(input, output, session){
    data <- reactive({
        input$calcRisk
        isolate({
            if (!is.na(input$Age) & !is.na(input$BMI) & !is.na(input$Preopsize) &
                input$Age>=18 & input$Age <=100 & input$BMI >= 14 & input$BMI <=75 &
                input$Preopsize>=0.5 & input$Preopsize <=7){
                
                Diabetes = ifelse(input$Diabetes == "Yes", 1, 0)
                Sex = ifelse(input$Sex == "Male", 1, 0)
                Surgery = input$Surgery
                Preopsize = input$Preopsize
                BMI = input$BMI
                Age = input$Age
                risk = function(Surgery, Sex, Diabetes, Preopsize, Age, BMI){
                    
                    if(any(is.na(c(Surgery, Sex, Diabetes, Preopsize, Age, BMI)))){stop("Fill in all risk faktors!")}
                    
                    if(Surgery=="Partial"){
                        risk = -6.92622764 + 0.47941980*Sex + 0.49817783*Diabetes + 0.23159349*Preopsize + 0.03005984*Age + 0.02742528*BMI
                    }else{
                        risk = -3.74210349 + 0.16611813*Sex + 0.27670120*Diabetes + 0.21862351*Preopsize + 0.01563046*Age + 0.01363674*BMI
                    }
                    
                    risk.outcome = exp(risk)/(1+exp(risk))
                    # show resulting risk in percentages with one digit
                    #risk.outcome = round(risk.outcome*100,1)
                    
                    if (risk.outcome < 0.01) {
                        HTML(calcSmiley(c(100, 0)))
                    } else if (risk.outcome > 0.99) {
                        HTML(calcSmiley(c(0, 100)))
                    } else {
                        HTML(calcSmiley(c(100-round(risk.outcome*100), round(risk.outcome*100))))
                    }
                    
                    
                } 
                myrisk = risk(Surgery, Sex, Diabetes, Preopsize, Age, BMI)
                myrisk
            }
            else {
                # this case should never be reached but just in case
                #warning(test)
                langSwitch("Error", "Error", type="warning")
            }
        })
    })
    
    output$smile_en <- renderUI({
        out = ""
        if(input$calcRisk){
            isolate({
                if(!is.na(input$Age) & !is.na(input$BMI) & !is.na(input$Preopsize))
                {
                    if(input$Age<18 | input$Age>100)
                    {
                        out = langSwitch(warning_age_en, warning_age_en, type="warning")
                    }
                    else if(input$BMI<14 | input$BMI>75)
                    {
                        out = langSwitch(warning_bmi_en, warning_bmi_en, type="warning")
                    }
                    else if(input$Preopsize<0.5 | input$Preopsize>7)
                    {
                        out = langSwitch(warning_preopsize_en, warning_preopsize_en, type="warning")
                    }
                    else
                    {                                  
                        dat = data()
                        h1("Individualized Risk Assessment of Kidney cancer upstaging risk")
                        br()
                        out = dat
                    }
                }
                else
                {
                    out=div(div(warning_overall_en,style='display: inline'),
                            br(),br(),
                            class="warning_text")
                }
            })
        }
        
        out
    })
}) 