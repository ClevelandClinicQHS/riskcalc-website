shinyServer(function(input, output, session){
    data <- reactive({
        input$calcRisk
        isolate({
            if (!is.na(input$age) & !is.na(input$psa) &  
                input$age>=40 & input$age <=90 & input$psa <= 50 & input$psa >=2 &
                (is.na(input$prosvol) | (!is.na(input$prosvol) & (input$prosvol>=15 & input$prosvol <=300)))){
                race = ifelse(input$race == "Yes",1,ifelse(input$race=="No", 0, NA))
                famhist.1 = ifelse(input$famhist1 == "Yes", 1, ifelse(input$famhist1 == "No", 0, NA))
                famhist.2 = ifelse(input$famhist2 == "Yes", 1, ifelse(input$famhist2 == "No", 0, NA))
                famhist.bca = ifelse(input$famhistbca == "Yes", 1, ifelse(input$famhistbca == "No", 0, NA))
                dre = ifelse(input$dre == "Abnormal",1,ifelse(input$dre == "Normal", 0, NA))
                priorbiopsy = ifelse(input$priorbiopsy == "Prior negative biopsy",1,ifelse(input$priorbiopsy == "Never had a prior biopsy", 0, NA))
                hispanic = ifelse(input$hispanic == "Yes",1,ifelse(input$hispanic == "No", 0, NA))
                priorpsa = ifelse(input$priorpsa == "Yes",1,ifelse(input$priorpsa == "No", 0, NA))
                ari.use = ifelse(input$ariuse == "Yes",1,ifelse(input$ariuse == "No", 0, NA))
                
                prosvol = input$prosvol
                psa = input$psa
                age = input$age
                myrisk = risk(age=age, psa = psa, race=race, 
                              priorbiopsy=priorbiopsy, dre=dre,
                              famhist.1 = famhist.1, famhist.2 = famhist.2, famhist.bca = famhist.bca,
                              prosvol = prosvol, hispanic = hispanic, ari.use = ari.use, priorpsa=priorpsa) 
                
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
                if(!is.na(input$age) & !is.na(input$psa))
                {
                    if(input$age<40 | input$age>90)
                    {
                        out = langSwitch(warning_age_en, warning_age_en, type="warning")
                    }
                    else if(input$psa<2 | input$psa>50)
                    {
                        out = langSwitch(warning_psa_en, warning_psa_en, type="warning")
                    }
                    else if(!is.na(input$prosvol) & (input$prosvol<15 | input$prosvol>300))
                    {
                        out = langSwitch(warning_prosvol_en, warning_prosvol_en, type="warning")
                    }
                    else
                    {                                  
                        dat = data()
                        h1("Individualized Risk Assessment of Prostate Cancer")
                        br()
                        out = HTML(calcSmiley(unlist(dat)))
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