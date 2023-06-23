require(shiny)



#####MI
## Intensive
fit <- expression({
  v1 <- Meds_Preop*12.6;
  v2 <- 18*ifelse(Preop_Insulin == "Yes", 1, 0);
  v3 <- ifelse(Duration_Pts >= 0 & Duration_Pts < 5, Duration_Pts*5.6, ifelse(Duration_Pts >= 5 & Duration_Pts < 10, ((Duration_Pts-5)*4)+28, ifelse(Duration_Pts >= 10 & Duration_Pts < 15, ((Duration_Pts-10)*2)+48, ((Duration_Pts-15)*1.68)+58)));
  v4 <- 16*ifelse(Glycemic_Pts == "No", 1, 0);
  pt <- v1 + v2 + v3 + v4
  pt
})


plot.f <- function(pt){
  par(mar=c(2, 4, 2, 0))
  par(bg = "light blue")
  barplot(pt, width=0.5, axes = FALSE, xlim=c(0,2), ylim=c(0, 200), col=ifelse(pt <= 25, "Green3", ifelse(pt > 25 & pt <= 95, "Yellow2", "Red")))
  lines(c(-0.1, 0.15), c(pt, pt), lty=2, col="Gray40")
  axis(2, at = c(0, 50, 100, 150, 200, round(pt,0)))
  lines(c(-0.1, 1.25), c(25, 25), lty=2)
  text(1.35, 25, "25", cex=2)
  lines(c(-0.1, 1.25), c(95, 95), lty=2)
  text(1.35, 95, "95", cex=2)
  text(1.2, 12.5, "Mild", col="Green3", cex=2, font = 2)
  text(1.2, 60, "Moderate", col="Yellow2", cex=2, font = 2)
  text(1.2, 147.5, "Severe", col="Red", cex=2, font = 2)
}

plot.rec <- function(pt){
  if(pt > 0 & pt <= 25){
    par(mar=c(1, 1, 1, 1))
    plot(0,xaxt='n',yaxt='n',pch='',ylab='',xlab='', xlim=c(0,1), ylim=c(0,1))#bty='n',
    text(-0.01, 1, "Recommendation in Average Risk Patients:", pos=4, cex=1)
    text(0.5, 0.9, "Gastric bypass is suggested.", cex=1.25, font=2)
    text(-0.01, 0.675, "Both RYGB and SG are highly effective in treatment of mild\n type 2 diabetes with significantly high long-term remission rates\n of approximately 90% and 75%, respectively. Since RYGB\n results in better long-term diabetic remission and reduction in\n diabetic medications, RYGB is suggested as the metabolic\n procedure of choice in those with mild diabetes, if there is no\n other reason to favor SG.", pos=4)
  } else {if(pt > 25 & pt <= 95){
    par(mar=c(1, 1, 1, 1))
    plot(0,xaxt='n',yaxt='n',pch='',ylab='',xlab='', xlim=c(0,1), ylim=c(0,1))
    text(-0.01, 1, "Recommendation in Average Risk Patients:", pos=4, cex=1)
    text(0.5, 0.9, "Gastric bypass is recommended.", cex=1.25, font=2)
    text(-0.01, 0.725, "Long-term remission of type 2 diabetes for those with a\n moderate disease is significantly higher after RYGB, 60%,\n versus only 25% after SG. RYGB is recommended as the\n optimal metabolic procedure for patients with moderate\n diabetes.", pos=4)
  } else {if(pt > 95){
    par(mar=c(1, 1, 1, 1))
    plot(0,xaxt='n',yaxt='n',pch='',ylab='',xlab='', xlim=c(0,1), ylim=c(0,1))
    text(-0.01, 1, "Recommendation in Average Risk Patients:", pos=4, cex=1)
    text(0.5, 0.9, "Sleeve gastrectomy is suggested.", cex=1.25, font=2)
    text(-0.01, 0.65, "Long-term remission of type 2 diabetes for those with a severe\n disease is about 10% after both RYGB and SG. Given the\n similar long-term postoperative outcomes in glucose control\n and diabetic medications, SG (which is a less risky procedure)\n is suggested for surgical management in those with severe\n diabetes, if there is no other reason to favor RYGB.\n Notably, both procedures result in significant improvements\n in glucose control and number of diabetic medications\n compared to baseline values.", pos=4)
  } else {
    plot(0,xaxt='n',yaxt='n',pch='',ylab='',xlab='', xlim=c(0,1), ylim=c(0,1))
    text(-0.01, 1, "Recommendation in Average Risk Patients:", pos=4, cex=1)
  }  }  }

  }


shinyServer(function(input, output) {
  get_newdata <- reactive({
    new_df <- data.frame(
      Meds_Preop = input$Meds_Preop,
      Preop_Insulin = factor(input$Preop_Insulin, levels = c("Yes", "No")),
      Duration_Pts = input$Duration_Pts,
      Glycemic_Pts = factor(input$Glycemic_Pts, levels = c("Yes", "No"))
    )
    new_df
  })

  output$score.text <- renderText({
    new.dat <- get_newdata()
    pred.pt <- eval(fit, envir = new.dat)

    paste("Total Points:", pred.pt)
  })

  output$pred1 <- renderPlot({
    new.dat <- get_newdata()
    pred.pt <- eval(fit, envir = new.dat)

    plot.f(pred.pt)
  })

  output$rec.text <- renderText({
    new.dat <- get_newdata()
    pred.pt <- eval(fit, envir = new.dat)

    if(pred.pt > 0 & pred.pt <= 25){
      "Gastric bypass is suggested."
    } else {if(pred.pt > 25 & pred.pt <= 95){
     "Gastric bypass is recommended."
    } else {if(pred.pt > 95){
      "Sleeve gastrectomy is suggested."
    } else {
      ""
    }}}
  })

  output$recP.text <- renderText({
    new.dat <- get_newdata()
    pred.pt <- eval(fit, envir = new.dat)

    if(pred.pt > 0 & pred.pt <= 25){
      "Both RYGB and SG are highly effective in treatment of mild type 2 diabetes with significantly high long-term remission rates of approximately 90% and 75%, respectively. Since RYGB results in better long-term diabetic remission and reduction in diabetic medications, RYGB is suggested as the metabolic procedure of choice in those with mild diabetes, if there is no other reason to favor SG."
    } else {if(pred.pt > 25 & pred.pt <= 95){
      "Long-term remission of type 2 diabetes for those with a moderate disease is significantly higher after RYGB, 60%, versus only 25% after SG. RYGB is recommended as the optimal metabolic procedure for patients with moderate diabetes."
    } else {if(pred.pt > 95){
      "Long-term remission of type 2 diabetes for those with a severe disease is about 10% after both RYGB and SG. Given the similar long-term postoperative outcomes in glucose control and diabetic medications, SG (which is a less risky procedure) is suggested for surgical management in those with severe diabetes, if there is no other reason to favor RYGB.  Notably, both procedures result in significant improvements in glucose control and number of diabetic medications compared to baseline values."
    } else {
      ""
    }}}
  })

#   output$score.rec <- renderPlot({
#     new.dat <- get_newdata()
#     pred.pt <- eval(fit, envir = new.dat)
#
#     plot.rec(pred.pt)
#    })



})
