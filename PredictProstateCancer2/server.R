shinyServer(function(input, output, session){
    data <- reactive({
        input$calcRisk
        isolate({
            if (!is.na(input$Age) & !is.na(input$PSA) & !is.na(input$Prompt) &
                input$Age>=40 & input$Age <=90 & input$PSA <= 50 & input$PSA >=0.1 & input$Prompt>=0.1 & input$Prompt<=10){
                PSA = input$PSA
                Age = input$Age
                Prompt = input$Prompt
                myrisk = risk(Age = Age, PSA = PSA, Prompt = Prompt) 
                
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
                if(!is.na(input$Age) & !is.na(input$PSA) & !is.na(input$Prompt))
                {
                    if(input$Age<40 | input$Age>90)
                    {
                        out = langSwitch(warning_age_en, warning_age_en, type="warning")
                    }
                    else if(input$PSA<0.1 | input$PSA>50)
                    {
                        out = langSwitch(warning_psa_en, warning_psa_en, type="warning")
                    }
                    else if(input$Prompt<0.1 | input$Prompt>10)
                    {
                        out = langSwitch(warning_prompt_en, warning_prosvol_en, type="warning")
                    }
                    else
                    {                                  
                        h1("Individualized Risk Assessment of Prostate Cancer")
                        br()
                        dat = data()
                        out = HTML(calcSmiley(unlist(dat)))
                    }
                }
                else
                {
                    out=div(div(warning_overall_en,style='display: inline'),
                            br(),
                            br(),
                            class="warning_text")
                }
            })
        }
        
        out
    })
})



