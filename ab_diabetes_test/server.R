library(shiny)
# Formula from prediction equation
formula.anytransfusion <- expression({
        lp <-   1.5324851 - 0.058221603 * bmi - 0.00041699674 * max(bmi - 20.371127, 0)**3 + 0.0021199044 * max(bmi - 25.046788, 0)**3 - 0.0027343681 * max(bmi - 29.184196, 0)**3 + 0.0010496955 * 
                max(bmi - 34.335729, 0)**3 - 1.8235119e-05 * max(bmi - 46.274989, 0)**3 + 1.7746275 * (abd == "TRUE") + 0.94617826 * (myomec == "TRUE") + 0.60718278 * (malig == "TRUE") - 1.4470343 * (hscope == "TRUE") - 0.2833171 * 
                (Fibroids == "TRUE") + 0.60103322 * (hypertension == "TRUE") - 0.78763235 * (Menorrhagia == "TRUE") + 0.87384572 * (OvarianCancer == "TRUE") - 0.89569027 * (Exp_Lap == "TRUE") + 0.779171 * First_parity - 0.33173378 * max(First_parity, 0)**3 + 
                0.91214647 * max(First_parity - 1, 0)**3 - 0.86871096 * max(First_parity - 2, 0)**3 + 0.32791763 * max(First_parity - 3, 0)**3 - 0.039619356 * max(First_parity - 4, 0)**3 - 
                0.366475 * ORD_VALUE;
        
# 30-day transfusion probability
        1/(1+exp(-lp))
        
})

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
        
        # Return the requested dataset
        
        get_newdata <- reactive({
                new.dat <- data.frame( First_parity = input$First_parity,
                                       bmi = input$bmi,
                                       ORD_VALUE = input$ORD_VALUE,
                                       abd = factor(input$abd, levels = c("FALSE", "TRUE")),
                                       myomec = factor(input$myomec, levels = c("FALSE", "TRUE")),
                                       malig = factor(input$malig, levels = c("FALSE", "TRUE")),
                                       hscope = factor(input$hscope, levels = c("FALSE", "TRUE")),
                                       Fibroids = factor(input$Fibroids, levels = c("FALSE", "TRUE")),
                                       hypertension = factor(input$hypertension, levels = c("FALSE", "TRUE")),
                                       Menorrhagia = factor(input$Menorrhagia, levels = c("FALSE", "TRUE")),
                                       OvarianCancer = factor(input$OvarianCancer, levels = c("FALSE", "TRUE")),
                                       Exp_Lap = factor(input$Exp_Lap, levels = c("FALSE", "TRUE"))
                                       
                )
        })
        
        
       
        # Generate a summary of the dataset
        output$prediction <- renderPlot({
                new.dat <- get_newdata()
                pres.anytransfusion <- eval(formula.anytransfusion , envir = new.dat)
                x <-  pres.anytransfusion*100
                xavg <- 2
                x2 <- x1 <- round(c(x, xavg),1)
                #x2 <- ifelse(x1 <1,"<1",
                             #ifelse(x1 > 99,">99", x1))
                names(x2) <- c(paste("Individual Risk ", x2[1],"%",sep =""),"Avg. Transfusion Risk 2%")
                #pie(x1,col = c("red","white"),radius = 0.95)
                barplot(x2, xavg, ylab = ("Risk (%) of Transfusion"), col = c("red", "grey"), ylim = c(0,100), axis.lty = 1, cex.names = 1.5, cex.axis = 1.5, cex.lab = 1.5)
                abline(h = c(2, NA), lty = 2, lwd = 3)

        })
        
})
