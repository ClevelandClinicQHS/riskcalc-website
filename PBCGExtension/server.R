shinyServer(function(input, output, session){
    data <- reactive({
        input$calcRisk
        isolate({
            if (input$race != "" & input$age>=40 & input$age <=90 & input$psa <= 50 & 
                input$psa >=2 & input$dre != "" & input$famhist != ""){
                race = ifelse(input$race == "African Ancestry",1,0)
                famhist = ifelse(input$famhist == "Yes",1,
                                 ifelse(input$famhist == "Do not know", NA, 0))
                dre = ifelse(input$dre == "Abnormal",1,
                             ifelse(input$dre == "Not performed or not sure", NA, 0))
                priobiop = 0
                psa = input$psa
                age = input$age
                myrisk = risk(psa = psa, age=age, race=race, 
                              priorbiopsy=priobiop, dre=dre, famhistory=famhist) 
                
                if (input$exo == 1 & input$mri == 1) {
                    mid = 1 / (1+exp(-(-3.0125603 + 0.097942723 * myrisk[3] - 7.0987313e-05 *
                                           max(myrisk[3] - 12, 0)**3 + 0.00011493184 *
                                           max(myrisk[3] - 25, 0)**3 - 4.3944527e-05 *
                                           max(myrisk[3] - 46, 0)**3))) * 100
                    if (mid < 1) mid = 1
                    if (mid > 99) mid = 99
                    lower.score1 = max(1 / (1+exp(-(-4.4303365 + 0.094904105 * myrisk[3] - 7.0064585e-05 *
                                                        max(myrisk[3] - 12, 0)**3 + 0.0001134379 *
                                                        max(myrisk[3] - 25, 0)**3 - 4.3373314e-05 *
                                                        max(myrisk[3] - 46, 0)**3 + 0.051210844 *
                                                        0 - 1.3818949e-05 * max(0 - 12.47, 0)**3 +
                                                        2.162334e-05 * max(0 - 32.07, 0)**3 - 7.8043913e-06 *
                                                        max(0 - 66.775, 0)**3)))*100, 1)
                    upper.score1 = min(1 / (1+exp(-(-4.4303365 + 0.094904105 * myrisk[3] - 7.0064585e-05 *
                                                        max(myrisk[3] - 12, 0)**3 + 0.0001134379 *
                                                        max(myrisk[3] - 25, 0)**3 - 4.3373314e-05 *
                                                        max(myrisk[3] - 46, 0)**3 + 0.051210844 *
                                                        100 - 1.3818949e-05 * max(100 - 12.47, 0)**3 +
                                                        2.162334e-05 * max(100 - 32.07, 0)**3 - 7.8043913e-06 *
                                                        max(100 - 66.775, 0)**3)))*100, 99)
                    lower.score2 = max(1 / (1+exp(-(-4.9043729 + 0.068530716 * myrisk[3] - 5.0792013e-05 *
                                                        max(myrisk[3] - 12, 0)**3 + 8.2234688e-05 *
                                                        max(myrisk[3] - 25, 0)**3 - 3.1442675e-05 *
                                                        max(myrisk[3] - 46, 0)**3 + 1.8601514 *
                                                        0 + 3.4478167 * 0)))*100, 1)
                    upper.score2 = min(1 / (1+exp(-(-4.9043729 + 0.068530716 * myrisk[3] - 5.0792013e-05 *
                                                        max(myrisk[3] - 12, 0)**3 + 8.2234688e-05 *
                                                        max(myrisk[3] - 25, 0)**3 - 3.1442675e-05 *
                                                        max(myrisk[3] - 46, 0)**3 + 1.8601514 *
                                                        0 + 3.4478167 * 1)))*100, 99)
                    myrisk = HTML(paste('<h3>Risk of High Grade Cancer: ',as.character(round(mid)), "%<h3/>",
                                        "<h3>Risk level could vary from ", as.character(floor(lower.score1)), "%", " to ", 
                                        as.character(min(ceiling(upper.score1), 100)), "% depending upon ExosomeDx test results.<h3/>",
                                        "<h3>Risk level could vary from ", as.character(floor(lower.score2)), "%", " to ", 
                                        as.character(ceiling(upper.score2)), "% depending upon MRI results.<h3/>",
                                        sep=""))
                } else if (input$exo == 2 & input$mri == 1) {
                    mid = 1 / (1+exp(-(-4.4303365 + 0.094904105 * myrisk[3] - 7.0064585e-05 *
                                           max(myrisk[3] - 12, 0)**3 + 0.0001134379 *
                                           max(myrisk[3] - 25, 0)**3 - 4.3373314e-05 *
                                           max(myrisk[3] - 46, 0)**3 + 0.051210844 *
                                           input$exoEPI - 1.3818949e-05 * max(input$exoEPI - 12.47, 0)**3 +
                                           2.162334e-05 * max(input$exoEPI - 32.07, 0)**3 - 7.8043913e-06 *
                                           max(input$exoEPI - 66.775, 0)**3)))*100
                    if (mid < 1) mid = 1
                    if (mid > 99) mid = 99
                    lower.score = max(1 / (1+exp(-( -6.3625682 + 0.067566868 * myrisk[3] - 5.2756451e-05 *
                                                        max(myrisk[3] - 12, 0)**3 + 8.5415206e-05 *
                                                        max(myrisk[3] - 25, 0)**3 - 3.2658755e-05 *
                                                        max(myrisk[3] - 46, 0)**3 + 0.0537232 *
                                                        input$exoEPI - 1.4777411e-05 * max(input$exoEPI - 12.47, 0)**3 +
                                                        2.3123103e-05 * max(input$exoEPI - 32.07, 0)**3 - 8.3456924e-06 *
                                                        max(input$exoEPI - 66.775, 0)**3 + 1.7195114 * 0 +
                                                        3.4018737 * 0)))*100, 1)
                    upper.score = min(1 / (1+exp(-(-6.3625682 + 0.067566868 * myrisk[3] - 5.2756451e-05 *
                                                       max(myrisk[3] - 12, 0)**3 + 8.5415206e-05 *
                                                       max(myrisk[3] - 25, 0)**3 - 3.2658755e-05 *
                                                       max(myrisk[3] - 46, 0)**3 + 0.0537232 *
                                                       input$exoEPI - 1.4777411e-05 * max(input$exoEPI - 12.47, 0)**3 +
                                                       2.3123103e-05 * max(input$exoEPI - 32.07, 0)**3 - 8.3456924e-06 *
                                                       max(input$exoEPI - 66.775, 0)**3 + 1.7195114 * 0 +
                                                       3.4018737 * 1)))*100, 99)
                    myrisk = HTML(paste('<h3>Risk of High Grade Cancer: ',as.character(round(mid)), "%<h3/>",
                                        "<h3>Risk level could vary from ", as.character(floor(lower.score)), "%", " to ",  
                                        as.character(ceiling(upper.score)), "% depending upon MRI results.<h3/>",
                                        sep=""))
                } else if (input$exo == 1 & input$mri == 2) {
                    mid = 1 / (1+exp(-(-4.9043729 + 0.068530716 * myrisk[3] - 5.0792013e-05 *
                                           max(myrisk[3] - 12, 0)**3 + 8.2234688e-05 *
                                           max(myrisk[3] - 25, 0)**3 - 3.1442675e-05 *
                                           max(myrisk[3] - 46, 0)**3 + 1.8601514 *
                                           (input$PIRADS == "3") + 3.4478167 * (input$PIRADS == ">3"))))*100
                    if (mid < 1) mid = 1
                    if (mid > 99) mid = 99
                    lower.score = max(1 / (1+exp(-(-6.3625682 + 0.067566868 * myrisk[3] - 5.2756451e-05 *
                                                       max(myrisk[3] - 12, 0)**3 + 8.5415206e-05 *
                                                       max(myrisk[3] - 25, 0)**3 - 3.2658755e-05 *
                                                       max(myrisk[3] - 46, 0)**3 + 0.0537232 *
                                                       0 - 1.4777411e-05 * max(0 - 12.47, 0)**3 +
                                                       2.3123103e-05 * max(0 - 32.07, 0)**3 - 8.3456924e-06 *
                                                       max(0 - 66.775, 0)**3 + 1.7195114 * (input$PIRADS == "3") +
                                                       3.4018737 * (input$PIRADS == ">3"))))*100, 1)
                    upper.score = min(1 / (1+exp(-(-6.3625682 + 0.067566868 * myrisk[3] - 5.2756451e-05 *
                                                       max(myrisk[3] - 12, 0)**3 + 8.5415206e-05 *
                                                       max(myrisk[3] - 25, 0)**3 - 3.2658755e-05 *
                                                       max(myrisk[3] - 46, 0)**3 + 0.0537232 *
                                                       100 - 1.4777411e-05 * max(100 - 12.47, 0)**3 +
                                                       2.3123103e-05 * max(100 - 32.07, 0)**3 - 8.3456924e-06 *
                                                       max(100 - 66.775, 0)**3 + 1.7195114 * (input$PIRADS == "3") +
                                                       3.4018737 * (input$PIRADS == ">3"))))*100, 99)
                    myrisk = HTML(paste('<h3>Risk of High Grade Cancer: ',as.character(round(mid)), "%<h3/>",
                                        "<h3>Risk level could vary from ", as.character(floor(lower.score)), "%", " to ", 
                                        as.character(ceiling(upper.score)), "% depending upon ExosomeDx test results.<h3/>",
                                        sep=""))
                } else {
                    mid = 1 / (1+exp(-(-6.3625682 + 0.067566868 * myrisk[3] - 5.2756451e-05 *
                                           max(myrisk[3] - 12, 0)**3 + 8.5415206e-05 *
                                           max(myrisk[3] - 25, 0)**3 - 3.2658755e-05 *
                                           max(myrisk[3] - 46, 0)**3 + 0.0537232 *
                                           input$exoEPI - 1.4777411e-05 * max(input$exoEPI - 12.47, 0)**3 +
                                           2.3123103e-05 * max(input$exoEPI - 32.07, 0)**3 - 8.3456924e-06 *
                                           max(input$exoEPI - 66.775, 0)**3 + 1.7195114 * (input$PIRADS == "3") +
                                           3.4018737 * (input$PIRADS == ">3"))))*100
                    if (mid < 1) mid = 1
                    if (mid > 99) mid = 99
                    myrisk = HTML(paste('<h3>Risk of High Grade Cancer: ',as.character(round(mid)), "%<h3/>",
                                        sep=""))
                }
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
                   (input$famhist !="") & (input$dre !="") )
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