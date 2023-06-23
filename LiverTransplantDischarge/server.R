library(shiny)
formula.to.facility <- expression({
           lp <-   -1.1931836 - 0.034482195 * Karnofsky.score.. + 0.029689078 *AGE + 
             0.000037817252 * pmax(AGE - 42, 0)**3 - 0.000082510367 *pmax(AGE - 55, 0)**3 + 
             0.000044693116 * pmax(AGE - 66,  0)**3 + 2.3277348 * INR - 
             2.6743728 * pmax(INR - 1.1, 0)**3 + 3.8205326 * pmax(INR - 1.4, 0)**3 - 
             1.1461598 * pmax(INR - 2.1, 0)**3 + 0.92019636 * CREAT - 
             0.52644474 *pmax(CREAT - 0.7, 0)**3 + 0.60165113 * pmax(CREAT - 1,0)**3 - 
             0.075206391 * pmax(CREAT - 3.1, 0)**3 + 0.53761446 *(PRE_TX_DIABETES == "Yes") - 
             0.10969875 * TBILI + 0.0010745634 *pmax(TBILI - 1, 0)**3 - 
             0.0012248977 * pmax(TBILI - 3.3, 0)**3 + 0.0001503343 * pmax(TBILI - 19.74, 0)**3 - 
             0.60712218 * ALB + 0.18528165 * pmax(ALB - 2.1, 0)**3 - 0.34997646 *pmax(ALB - 2.9, 0)**3 + 
             0.1646948 * pmax(ALB - 3.8, 0)**3 -0.067877556 * BMI + 0.00036666299 * pmax(BMI - 22, 0)**3 - 
             0.00061110498 * pmax(BMI - 28, 0)**3 + 0.00024444199 *pmax(BMI - 37, 0)**3 + 
             0.9883279 * (Dialysis.Y.N == "Yes") - 0.32916729 * (SEX == "Male");
           plogis(lp)
  
    })

# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {

  # Return the requested dataset

  get_newdata <- reactive({
    new.dat <- data.frame( 
      Karnofsky.score.. = input$Karnofsky.score..,
      AGE = input$AGE,
                          INR = input$INR,
                          CREAT = input$CREAT,
                          PRE_TX_DIABETES = factor(input$PRE_TX_DIABETES, levels = c("No","Yes")),
                          TBILI = input$TBILI,
                          ALB = input$ALB,
                          BMI = input$BMI,
                          Dialysis.Y.N = factor(input$Dialysis.Y.N, levels = c("No","Yes")),
                          SEX= factor(input$SEX, levels = c("Female","Male"))
    )
    new.dat
  })


  # Generate a summary of the dataset
  output$piePlot <- renderPlot({
    new.dat <- get_newdata()
    pres.to.facility <- eval(formula.to.facility ,envir = new.dat)
    x <-  pres.to.facility*100
    x2 <- x1 <- round(c(x,100-x),0)
    x2 <- ifelse(x1 <1,"<1",
                 ifelse(x1 > 99,">99", x1))
    names(x1) <- c(paste("Prob. ",x2[1],"%",sep =""),"")
    pie(x1,col = c("forestgreen","white"),radius = 0.95)
  })

})
