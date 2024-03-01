#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
function(input, output, session) {

    output$distPlot <- renderPlot({

        temp_data <- data.frame(
            name=c("csPCa","no csPCa"),
            value=c(input$risk,100-input$risk))

    })
    
    observeEvent(input$langChoice, {
      # Call the "updateSelectInput" and edit what needed
      updateSelectInput(session, "myDropdown", 
                        label = input$langChoice,
                        choices = setNames(translations$id, translations[,input$langChoice]))
    })
    
    data <- reactive({
        input$calcRisk
        isolate({
            if (input$PIRADS != "" & 
                input$priobiop != "" &
                input$PSA <= 100 & 
                input$PSA > 0 & 
                input$Volume > 0 & 
                input$Volume <=100 & # todo higher? 
                input$Age>=55 & 
                input$Age <=90){
                #priobiop = ifelse(input$priobiop == "yes",1,0) # todo: priobiop as integer?
                
                # todo: priobiop as integer?
                Prior_neg_biopsy = ifelse(input$priobiop == "Prior negative biopsy",1,
                                          ifelse(input$priobiop == "Never had a prior biopsy",0,NA))
                
                PIRADS = as.numeric(input$PIRADS)
                Volume = input$Volume
                PSA = input$PSA
                Age = input$Age
                # todo: set PSA=VOL=NA if density available
                if(input$dpsa_avail==T){
                    if(input$dpsa>0 & input$dpsa<10){
                        dPSA=input$dpsa
                    } else {
                        warning(test)
                        langSwitch("Error", "Error", type="warning")
                    }
                } else{
                    dPSA = PSA/Volume
                }
                myrisk = risk(Age=Age, PIRADS=PIRADS, Prior_neg_biopsy=Prior_neg_biopsy, density=dPSA) 
                
                myrisk
                
            }
            else {
                # this case should never be reached but just in case
                warning(test)
                langSwitch("Error", "Error", type="warning")
            }
        })
    })       
    output$view <- renderTable({
        dat =  data #data()
        if(sum(dat) == 100){
            dat = as.matrix(dat)
            t(as.matrix(apply(dat,2 ,function(x) paste(x,2, "%", sep=""))))
        }
    }, include.rownames=FALSE)
        

    
    output$smile_en <- renderUI({
        out = ""
            if(input$calcRisk){
                h3("Individualized Risk Assessment of Prostate Cancer")
                br()
                isolate({
                    if(!is.na(input$Age) & !is.na(input$PSA) & (input$Volume !="") &
                       (input$PIRADS !="") & (input$priobiop !="")){
                        if(input$Age<55){
                            out = langSwitch(warning_Age_eng, warning_Age_ger, type="warning")
                        }
                        else if(input$PSA<=0 | input$PSA>100){
                            out = langSwitch(warning_PSA_eng, warning_PSA_ger, type="warning")
                        }
                        else if((input$dpsa_avail==T)&(input$dpsa<=0 | input$dpsa>10)){
                            out = langSwitch(warning_dpsa_eng, warning_dpsa_ger, type="warning")
                        }
                        else if(input$Volume<=0 | input$Volume>100){
                            out = langSwitch(warning_Volume_eng, warning_Volume_ger, type="warning")
                        }
                        else if(!(input$PIRADS %in% 1:5)){
                            out = langSwitch(warning_PIRADS_eng, warning_PIRADS_ger, type="warning")
                        }
                        else if(input$priobiop == ""){
                            out = langSwitch(warning_priorbiop0_eng, warning_priorbiop0_ger, type="warning")
                        }
                        else if(input$priobiop == "Prior positive biopsy"){
                            out = langSwitch(warning_priorbiop1_eng, warning_priorbiop1_ger, type="warning")
                        }
                        # todo: density
                        else{
                            dat = data()
                            if(sum(dat) == 100){
                                h1("Individualized Risk Assessment of Prostate Cancer")
                                br()
                                out = HTML(calcSmiley(unlist(dat), input$lang))
                            }    
                        out = HTML(calcSmiley(unlist(dat),input$lang))
                        }
                    }
                    else{
                      out=langSwitch(warning_overall_eng, warning_overall_ger, type="warning")
                    }
                })
          #  }
        }
        out
    })
    
}
