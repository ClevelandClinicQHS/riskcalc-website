library(shiny)
# Formula from prediciton equation
formula.30day.anyinfection <- expression({
        lp <-   -3.0105365 - 0.013402558 * GA_days + 1.0605752 * (Type == "Scheduled") + 1.8637415 * (Type == "Unscheduled") + 
        0.12273392 * BMI + 0.5575743 * Number_prior + 1.0350074 * (Reason_failtoprogress == "Yes") - 0.30676012 * (Closure_skin == "Suture") + 
        0.57296032 * (Chorio_clinicaldx == "Yes") + 0.54921889 * (Comorbidities_asthma == "Yes") + BMI * (-0.064166667 * (Type == "Scheduled") -
        0.081976131 * (Type == "Unscheduled but not Emergent"));
        
# 30-day infection probability
        1/(1+exp(-lp))
        
})

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
        
        # Return the requested dataset
        
        get_newdata <- reactive({
                new.dat <- data.frame( GA_weeks = input$GA_weeks,
                                       GA_days1 = input$GA_days1,
                                       BMI = input$BMI,
                                       Type = factor(input$Type, levels = c("Emergent", "Scheduled", "Unscheduled but not Emergent")),
                                       Number_prior = input$Number_prior,
                                       Reason_failtoprogress = factor(input$Reason_failtoprogress, levels = c("No", "Yes")),
                                       Closure_skin = factor(input$Closure_skin, levels = c("Staples", "Suture")),
                                       Chorio_clinicaldx = factor(input$Chorio_clinicaldx, levels = c("No", "Yes")),
                                       Comorbidities_asthma = factor(input$Comorbidities_asthma, levels = c("No","Yes"))
                )
                new.dat$GA_days <- with(new.dat, ((GA_weeks*7)+GA_days1))
                new.dat
        })
        
        
       
        # Generate a summary of the dataset
        output$prediction <- renderPlot({
                new.dat <- get_newdata()
                pres.30day.anyinfection <- eval(formula.30day.anyinfection , envir = new.dat)
                x <-  pres.30day.anyinfection*100
                xavg <- 6
                x2 <- x1 <- round(c(x, xavg),0)
                #x2 <- ifelse(x1 <1,"<1",
                             #ifelse(x1 > 99,">99", x1))
                names(x2) <- c(paste("Individual Risk ", x2[1],"%",sep =""),"Average Infection Risk 6%")
                #pie(x1,col = c("red","white"),radius = 0.95)
                barplot(x2, xavg, ylab = ("Risk (%) of Infection"), col = c("red", "grey"), ylim = c(0,100), axis.lty = 1, cex.names = 1.5, cex.axis = 1.5, cex.lab = 1.5)
                abline(h = c(6, NA), lty = 2, lwd = 3)

        })
        
})
