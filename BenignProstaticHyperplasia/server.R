formula1 <- expression({
    if (TMTDG == "Dutasteride") {
        lp <- 1*(1- (0.9592932^exp(-0.9692797 + 
                                   0.020090573 * BAUA + 
                                   0.074734558 * BBII + 
                                   0.45900897 * (ABLKTK == "Yes") + 
                                   0.010711346 * BPV + 
                                   0.10336224 *  BPSA - 
                                   0.11253732 * BQM )))
    } else {
        lp <- 1- (0.9592932^exp(-0.9692797 + 
                                    0.020090573 * BAUA + 
                                    0.074734558 * BBII + 
                                    0.45900897 * (ABLKTK == "Yes") + 
                                    0.010711346 * BPV + 
                                    0.10336224 *BPSA - 
                                    0.11253732 * BQM + 0.70067995))
    }
    lp * 100
})
        library(shiny)
        shinyServer(function(input, output){
            data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$BAUA))& as.numeric(input$BAUA)>=1& as.numeric(input$BAUA)<=35, 'Please input a valid BAUA'))
BAUA= as.numeric(input$BAUA)
validate(need(!is.na(as.numeric(input$BBII))& as.numeric(input$BBII)>=0& as.numeric(input$BBII)<=13, 'Please input a valid BBII'))
BBII= as.numeric(input$BBII)
validate(need(!is.na(as.numeric(input$BQM))& as.numeric(input$BQM)>=2& as.numeric(input$BQM)<=30, 'Please input a valid BQM'))
BQM= as.numeric(input$BQM)
ABLKTK = factor(input$ABLKTK, levels = c('No', 'Yes'))
validate(need(!is.na(as.numeric(input$BPV))& as.numeric(input$BPV)>=16& as.numeric(input$BPV)<=260, 'Please input a valid BPV'))
BPV= as.numeric(input$BPV)
validate(need(!is.na(as.numeric(input$BPSA))& as.numeric(input$BPSA)>=0.7& as.numeric(input$BPSA)<=10, 'Please input a valid BPSA'))
BPSA= as.numeric(input$BPSA)
TMTDG = factor(input$TMTDG, levels = c('Placebo', 'Dutasteride'))
data <- data.frame(BAUA = BAUA,
BBII = BBII,
BQM = BQM,
ABLKTK = ABLKTK,
BPV = BPV,
BPSA = BPSA,
TMTDG = TMTDG)
data})
output$result <- renderDataTable({data = data()
yr2 = eval(formula1, envir = data)
res = data.frame(Result = c("Predicting Acute Urinary Retention or Surgical Intervention within 2 years"),
                 Probability = c(paste(ifelse(round(yr2, 0) < 1, "<1", ifelse(round(yr2, 0) > 99, ">99", round(yr2, 0))), "%")))
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
        