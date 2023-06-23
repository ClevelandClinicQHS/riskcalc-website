library(shiny)
# Formula from prediction equation

formula.dm <- expression({
  lp <- -8.3033389 + 1.4336625 * a1c + 1.028993 * max(a1c - 5.1,0)**3 - 2.2637845 * 
    max(a1c - 5.7,0)**3 + 1.2347916 * max(a1c - 6.2,0)**3 - 0.016925925 * Age + 1.6833044e-05 *
    max(Age - 41.185753,0)**3 - 3.324323e-05 * max(Age - 58.335616,0)**3 + 1.6410186e-05 *
    max(Age - 75.927397,0)**3 + 0.26701826 * (Fam_Hx_Diabetes == "Yes") + 0.011322997 * bmi -
    0.015548068 * HDL + 0.0028646575 * TRIGLY - 8.9614167e-08 * max(TRIGLY - 58,0)**3 +
    1.2978603e-07 * max(TRIGLY - 110,0)**3 - 4.0171868e-08 * max(TRIGLY - 226,0)**3 +
    0.24043673 * log(ALT) - 0.16584938 * (TobaccoUse == "No");
  0.8891389**exp(lp)
  })

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
        
        # Return the requested dataset
        
        get_newdata <- reactive({
                new.dat <- data.frame( a1c = input$a1c,
                                       Age = input$Age,
                                       Fam_Hx_Diabetes = factor(input$Fam_Hx_Diabetes,
                                                                levels = c("Yes", "No")),
                                       bmi = input$bmi,
                                       HDL = input$HDL,
                                       TRIGLY = input$TRIGLY,
                                       ALT = input$ALT,
                                       TobaccoUse = factor(input$TobaccoUse,
                                                           levels = c("Yes", "No"))
                                       
                                       
                )
        })
        
        
       
        # Generate a summary of the dataset
        output$prediction <- renderPlot({
                new.dat <- get_newdata()
                pres.dm <- 1 - eval(formula.dm , envir = new.dat)
                x <-  pres.dm*100
                xgroup <- ifelse(pres.dm <= 0.0615, "5 years",
                               ifelse(pres.dm <= 0.1719, "35 months", "8 months"))
                x1 <- round(x,1)
                #x2 <- ifelse(x1 <1,"<1",
                             #ifelse(x1 > 99,">99", x1))
                # names(x1) <- 
#                 pie(x2,col = c("red","white"),radius = 0.95)
                barplot(x1, ylab = ("T2DM Probability"), col = c("red"), ylim = c(0,100), 
                        axis.lty = 1, cex.names = 1.5, cex.axis = 1.5, cex.lab = 1.5,
                        xlab = c(paste(paste(paste("Individual T2DM Prob ", x1,"%",sep =""),
                                             "Time to screen:", sep = "\n"), xgroup, sep = " ")))
                # abline(h = c(82, NA), lty = 2, lwd = 3)

        })
        
})

# test.dat <- data.frame( psa = 7,cstage = "T1c",yos = 1997,experience = 259,bg = 6)
# pred(pre3.f, envir = test.dat)
# load("H:/Projects/2013/Rcalc/Prostate Pre - FINAL 10-Year Recurrence-Free Percentage Radical Prostatectomy/pre3.f")
# load("H:/Projects/2013/Rcalc/Prostate Pre - FINAL 10-Year Recurrence-Free Percentage Radical Prostatectomy/pre2.fns")
# # survest.cph to estimate survival probability at certain time s_i(t)
# survest(pre2.fns, test.dat, time = 120) #0.8865135
# # predict.cph to estimate lp
# predict.cph(pre2.fns, test.dat)#-0.4961972 
# # refer to formula s_i(t) = s_0(t)^exp(lp)
# # exp(log(s_i(t))/exp(lp))
# exp(log(0.8865135)/exp(-0.4961972))

# calculate baseline hazard
# Function(dm.cp22)
# test.dat <- data.frame( a1c = 5.7,
#                         Age = 58.335616,
#                         Fam_Hx_Diabetes = "No",
#                         bmi = 28.978354,
#                         HDL = 50,
#                         TRIGLY = 110,
#                         ALT = 22,
#                         TobaccoUse = "No")
# survest(dm.cp22, test.dat, time = 60) #0.92287
# predict.cph(dm.cp22, test.dat) #-0.3810964
# exp(log(0.92287)/exp(-0.3810964))
# eval(formula.dm, envir = test.dat)
