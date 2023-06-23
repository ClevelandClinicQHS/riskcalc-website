library(shiny)
formula.5yrs.recur <- expression({
           lp <-    -1.547257 + 0.31586672 * log(prepsa) - 0.028514161 * 
             pmax(log(prepsa) - 0.18255172, 0)^3 + 1.5861474 * pmax(log(prepsa) - 1.5260563, 0)^3 - 
             3.4262086 * pmax(log(prepsa) - 1.9169226, 0)^3 + 
             2.1286971 * pmax(log(prepsa) - 2.3608539, 0)^3 - 
             0.26012179 * pmax(log(prepsa) - 3.3565481, 0)^3 - 0.70223659 * 
             (uicc == "T1c") - 0.40668754 * (uicc == "T2a") + 0.22358978 * 
             (uicc == "T2b") + 0.021192631 * (uicc == "T2c") + 0.7597205 * 
             (uicc == "T3a") + 0.71327666 * (bxggmk == "<3+3") + 0.80371467 * 
             (bxggmk == "3+<3") + 0.77753355 * (bxggmk == "3+3") + 
             1.4273016 * (bxggmk == "<4+>3") + 1.4957297 * (bxggmk == 
                                                              ">3+>0");
   # 5-year recurrence free probability
           0.7800056^exp(lp)

    })


# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {

  # Return the requested dataset

  get_newdata <- reactive({
    
#     prepsa2 <- as.numeric(input$prepsa2)
#     if(!is.na(prepsa2)) prepsa <-  prepsa2 
    g1 <- input$g1
    g2 <- input$g2
    bxggmk <- ifelse(g1 < 3 & g2 <3, "<3+<3",
                   ifelse(g1 < 3 & g2 ==3, "<3+3",
                          ifelse(g1 == 3 & g2 <3, "3+<3",
                                 ifelse(g1 == 3 & g2 ==3, "3+3",
                                        ifelse(g1 <= 3 & g2 >3, "<4+>3",">3+>0")))))
    new.dat <- data.frame( prepsa = input$prepsa,
                          uicc = factor(input$uicc,levels = c("T1ab","T1c","T2a","T2b","T2c","T3a")),
                          bxggmk = factor(bxggmk,levels = c("<3+<3","<3+3","3+<3","3+3","<4+>3",">3+>0"))
    )
    new.dat
  })


  # Generate a summary of the data
  output$outcomePlot <- renderPlot({
    new.dat <- get_newdata()
    pres.5yrs.recur <- eval(formula.5yrs.recur ,envir = new.dat)
    x <-  pres.5yrs.recur*100
    x1 <- round(x,0)
    x2 <- ifelse(x1 < 1,"<1",
                 ifelse(x1 > 99,">99", x1))
    x.name <- c(paste(" ",x2,"%",sep =""))
    
    shiny:::validate(
      need( input$prepsa >= 0.1  & input$prepsa <= 110 ,"PSA must be between 0.1 and 110 ng/mL!"))
    
  
    # pie(x1,col = c("green3","red3"),radius = 0.95)
    barplot(100,horiz = TRUE,col = "red3",axes = FALSE, cex.names = 1.5,space = 0.8,
            xlim = c(-10,110),ylim =c(0,2),main ="5-year Probability of Freedom From Disease Recurrence",
            cex.main = 2, col.main = "dodgerblue3")
    mp <- barplot(x,horiz = TRUE,col = "green3",add = TRUE,axes = FALSE,space = 0.8,
                  xlim = c(-10,110),ylim =c(0,20))
    text(x,mp,x.name,pos=2)
    
  })

})

