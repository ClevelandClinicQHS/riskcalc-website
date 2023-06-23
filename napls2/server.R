# updated 5-factor model in 2017
library(shiny)
formula.1yrs.psychosis <- expression({
    lp <-   1.4468513 - 0.028694511 * DEMO_AGE_YM - 0.014936943 * BACS_RAW - 
        0.038728208 * HVLT_TOTAL + 0.20635307 * GFS_DECLINE_PAST_YEAR + 
        0.34883645 * P1P2
    # 1-year psychosis free probability
    0.9012041^exp(lp)
    
})
formula.2yrs.psychosis <- expression({
           lp <-   1.4468513 - 0.028694511 * DEMO_AGE_YM - 0.014936943 * BACS_RAW - 
               0.038728208 * HVLT_TOTAL + 0.20635307 * GFS_DECLINE_PAST_YEAR + 
               0.34883645 * P1P2
   # 2-year psychosis free probability
           0.8695878^exp(lp)

    })

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
    observe({
        if (input$sips == TRUE & input$prof == TRUE) {
            shinyjs::show(id = "display", anim = TRUE)
        } else {
            shinyjs::hide(id = "display", anim = TRUE)
        }
    })

  # Return the requested dataset

  get_newdata <- reactive({
    new.dat <- data.frame( DEMO_AGE_YM = input$DEMO_AGE_YM,
                          BACS_RAW = input$BACS_RAW,
                          HVLT_TOTAL = input$HVLT_TOTAL,
                          #UNDES_LIFE_EVENTS_TOTAL = input$UNDES_LIFE_EVENTS_TOTAL,
                          #TOTAL_TRAUMA = input$TOTAL_TRAUMA,
                          P1P2 = input$P1P2,
                          ## GFS_CURRENT = input$GFS_CURRENT,
                          GFS_DECLINE_PAST_YEAR = input$GFS_DECLINE_PAST_YEAR
                          #GENETIC_RISK = factor(input$GENETIC_RISK, levels = c("No","Yes"))
    )
    new.dat
  })


  # Generate a summary of the dataset
  output$piePlot <- renderPlot({
    new.dat <- get_newdata()
    par(mfrow=c(1,2))
    pres.1yrs.psychosis <- eval(formula.1yrs.psychosis ,envir = new.dat)
    pres.2yrs.psychosis <- eval(formula.2yrs.psychosis ,envir = new.dat)
    x3 <-  pres.1yrs.psychosis*100
    x5 <- x4 <- round(c(100 - x3,x3),1)
    x5 <- ifelse(x4 <1,"<1",
                 ifelse(x4 > 99,">99", x4))
    names(x4) <- c(paste("Risk ",x5[1],"%",sep =""),"")
    pie(x4,col = c("red","white"),radius = 0.95)
    x <-  pres.2yrs.psychosis*100
    x2 <- x1 <- round(c(100 - x,x),1)
    x2 <- ifelse(x1 <1,"<1",
                 ifelse(x1 > 99,">99", x1))
    names(x1) <- c(paste("Risk ",x2[1],"%",sep =""),"")
    pie(x1,col = c("red","white"),radius = 0.95)
  })

})
