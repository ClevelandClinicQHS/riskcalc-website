require(shiny)
require(rms)



load("data/fit.marx.hs.RObj")
load("data/fit.marx.btb.RObj")
load("data/fit.ikdc.RObj")
load("data/fit.anyACLin2yrwindow.hs.step.RObj")
load("data/fit.anyACLin2yrwindow.btb.step.RObj")
load("data/ACL.PredPlot.RObj")






shinyServer(function(input, output) {
  get_newdata <- reactive({
    new_df <- data.frame( AGE = input$AGE, 
                          sex = factor(input$sex, levels = c("Male", "Female")), 
                          ethnic2 = factor(input$ethnic2, levels = c("White", "Black/Other")), 
                          spinj2 = factor(input$spinj2, levels = c("Basketball", "Football", "Soccer", "None/Other")), 
                          level1 = factor(input$level1, levels = c("HS/College", "Rec")), 
                          MARX.t0 = input$MARX.t0, IKDC.raw.t0 = input$IKDC.raw.t0, 
                          lax = factor(input$lax, levels = c("Yes", "No")),
                          height = input$height,
                          weight = input$weight
    )
    new_df$BMI <- with(new_df, ((weight * 703)/(height*height)))
    new_df
    
  })
  
  MARX.btb.pred <- reactive({
    round(predict(fit.marx.btb, newdata = get_newdata(), type="mean"), 0)
  })
  MARX.hs.pred <- reactive({
    round(predict(fit.marx.hs, newdata = get_newdata(), type="mean"), 0)
  })
  KOOS.QOL.btb.pred <- reactive({
    KOOS.QOL.btb.pred = "77.0"
    KOOS.QOL.btb.pred
  })
  KOOS.QOL.hs.pred <- reactive({
    KOOS.QOL.hs.pred = "75.3"
    KOOS.QOL.hs.pred
  })
  KOOS.S_P.btb.pred <- reactive({
    KOOS.S_P.btb.pred = "81.5"
    KOOS.S_P.btb.pred
  })
  KOOS.S_P.hs.pred <- reactive({
    KOOS.S_P.hs.pred = "83.0"
    KOOS.S_P.hs.pred
  })
  IKDC.btb.pred <- reactive({
    round(83.766277 - 0.030590729 * input$AGE + 3.541774 * ifelse(input$sex == "Male", 1, 0) + 1.2411331 * ifelse(input$ethnic2 == "White", 1, 0) - 0.44389684 * with(get_newdata(), BMI)+ 0.16982461 * ifelse(input$spinj2 == "Football", 1, 0) - 2.7491881 * ifelse(input$spinj2 == "None/Other", 1, 0) + 1.0523001 * ifelse(input$spinj2 == "Soccer", 1, 0) - 0.92066083 * ifelse(input$level1 == "Rec", 1, 0) - 0.66447287 * ifelse(input$lax == "Yes", 1, 0) + 0.095841682 * input$MARX.t0 + 0.16593678 * input$IKDC.raw.t0, 1)
  })
  IKDC.hs.pred <- reactive({
    round(83.766277 - 0.030590729 * input$AGE + 3.541774 * ifelse(input$sex == "Male", 1, 0) + 1.2411331 * ifelse(input$ethnic2 == "White", 1, 0) - 0.44389684 * with(get_newdata(), BMI)+ 0.16982461 * ifelse(input$spinj2 == "Football", 1, 0) - 2.7491881 * ifelse(input$spinj2 == "None/Other", 1, 0) + 1.0523001 * ifelse(input$spinj2 == "Soccer", 1, 0) - 0.92066083 * ifelse(input$level1 == "Rec", 1, 0) - 0.66447287 * ifelse(input$lax == "Yes", 1, 0) + 0.095841682 * input$MARX.t0 + 0.16593678 * input$IKDC.raw.t0 + 0.89905255, 1)
  })
  Recur.Rupture.btb.pred <- reactive({
    paste(ifelse((round(plogis(predict(fit.anyACLin2yrwindow.btb.step, newdata = get_newdata())), 3)*100) == 0, "<1", round(plogis(predict(fit.anyACLin2yrwindow.btb.step, newdata = get_newdata())), 3)*100), "%", sep="")
  })
  Recur.Rupture.hs.pred <- reactive({
    paste(ifelse((round(plogis(predict(fit.anyACLin2yrwindow.hs.step, newdata = get_newdata())), 3)*100) == 0, "<1", round(plogis(predict(fit.anyACLin2yrwindow.hs.step, newdata = get_newdata())), 3)*100), "%", sep="")
  })
  
  output$P.Plot <- renderPlot({
    ACL.PredPlot(MARX.btb.pred(), MARX.hs.pred(), KOOS.QOL.btb.pred(), KOOS.QOL.hs.pred(), KOOS.S_P.btb.pred(), KOOS.S_P.hs.pred(), IKDC.btb.pred(), IKDC.hs.pred(), Recur.Rupture.btb.pred(), Recur.Rupture.hs.pred())
  })
})