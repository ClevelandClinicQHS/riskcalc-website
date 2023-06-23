shinyServer(function(input, output, session){
    data <- reactive({
        input$calcRisk
        isolate({
            if (input$race != "" & input$age>=40 & input$age <=90 & input$psa <= 50 & 
                input$psa >=2 & input$dre != "" & input$priobiop != "" & input$famhist != ""){
                race = ifelse(input$race == "African Ancestry",1,0)
                famhist = ifelse(input$famhist == "Yes",1,
                                 ifelse(input$famhist == "Do not know", NA, 0))
                dre = ifelse(input$dre == "Abnormal",1,
                             ifelse(input$dre == "Not performed or not sure", NA, 0))
                priobiop = ifelse(input$priobiop == "Prior negative biopsy",1,
                                  ifelse(input$priobiop == "Not sure",NA,0))
                psa = input$psa
                age = input$age
                myrisk = risk(psa = psa, age=age, race=race, 
                              priorbiopsy=priobiop, dre=dre, famhistory=famhist) 
                
                myrisk
            }
            else {
                # this case should never be reached but just in case
                warning(test)
                langSwitch("Error", "Error", type="warning")
            }
        })
    })
    
    output$smile_en <- renderUI({
        out = ""
        if(input$calcRisk){
            isolate({
                if(!is.na(input$age) & !is.na(input$psa) & (input$race !="") &
                   (input$famhist !="") & (input$dre !="") & (input$priobiop !=""))
                {
                    if(input$age<40 | input$age>90)
                    {
                        out = langSwitch(warning_age_en, warning_age_en, type="warning")
                    }
                    else if(input$psa<2 | input$psa>50)
                    {
                        out = langSwitch(warning_psa_en, warning_psa_en, type="warning")
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