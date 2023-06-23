require(shiny)
require(plotrix)


PC.Screen.fit <- expression({
  lp <- 0*(Age == ">= 70") + 4*(Age == "65-69") + 3*(Age == "55-64") + 2*(Age == "45-54") + 1*(Age == "< 45") + 
        1*(Race == "White/Caucasian") + 2*(Race == "Black/African-American") + 0*(Race == "Asian/Pacific Islander") + 0*(Race == "Other") + 0*(Ethnic == "Non-Hispanic") + 0*(Ethnic == "Hispanic") + 0*(Race == "Native American/Alaskan Native") +
        2*(Hx.pc.father == "Yes") + 3*(Hx_pc_brother == "Yes") + ifelse(Hx_pc_brother == "Yes" & Num_pc_brother-1 > 0, (Num_pc_brother-1)*1, 0) + 1*(Other_Hx_pc_family) + 0*(know.family.hx == TRUE) + 0*(know.brother.hx == TRUE) +
        0*(DRE == "No previous DRE") + 0*(DRE == "Normal DRE") + 1*(DRE == "Abnormal DRE") + 
        0*(prev.PSA == "No previous PSA") + 0*(prev.PSA == "PSA < 1.0") + 1*(prev.PSA == "PSA 1.0-2.5") + 2*(prev.PSA == "PSA > 2.5") + 
        3*(Health == "Excellent") + 2*(Health == "Very Good") + 1*(Health == "Good") + 0*(Health == "Poor") + 
        3*(Leak == "Not Bothersome") + 2*(Leak == "Somewhat Bothersome") + 1*(Leak == "Very Bothersome") + 0*(Leak == "Extremely Bothersome") + 
        3*(Sex == "Not Important") + 2*(Sex == "Somewhat Important") + 1*(Sex == "Very Important") + 0*(Sex == "Extremely Important") + 
        0*(PC.Concern == "Not concerned at all") + 1*(PC.Concern == "Little concerned") + 2*(PC.Concern == "Very concerned") + 3*(PC.Concern == "Extremely concerned");
  lp
})

therm.plot <- function(pred.score){
  plot(0, xaxt='n', yaxt='n',bty='n',pch='',ylab='',xlab='', xlim=c(0.6, 1.4), ylim=c(-8, 32))
  axis(2, at=seq(0, 32, by=2))
  
  rect(0.95, -2, 1.05, 32)
  rect(0.95, -2, 1.05, ifelse(pred.score==0, -2, pred.score), col=ifelse(pred.score == 0, "White", ifelse(pred.score > 0 & pred.score <= 16, "Red", "Green")))
  draw.circle(1,-4.4, 0.1,    col=ifelse(pred.score == 0, "Dark Red", ifelse(pred.score > 0 & pred.score <= 16, "Red", "Green")))
  text(1.15, pred.score, paste(pred.score), cex=2, col=ifelse(pred.score == 0, "Dark Red", ifelse(pred.score > 0 & pred.score <= 16, "Red", "Green")))  
}


shinyServer(function(input, output) {
  get_newdata <- reactive({
    new_df <- data.frame(Age = factor(input$Age, levels=c(">= 70", "65-69", "55-64", "45-54", "< 45")),
                         Race = factor(input$Race, levels=c("White/Caucasian", "Black/African-American", "Asian/Pacific Islander", "Native American/Alaskan Native", "Other")),
                         Ethnic = factor(input$Ethnic, levels=c("Non-Hispanic", "Hispanic")),
                         Hx.pc.father = factor(input$Hx.pc.father, levels=c("Yes", "No/Not Sure")),
                         Hx_pc_brother = factor(input$Hx_pc_brother, levels=c("Yes", "No/Not Sure")),
                         Num_pc_brother = input$Num_pc_brother,
                         Other_Hx_pc_family = input$Other_Hx_pc_family,
                         know.family.hx = factor(input$know.family.hx, levels=c(TRUE, FALSE)),
                         know.brother.hx = factor(input$know.brother.hx, levels=c(TRUE, FALSE)),
                         DRE = factor(input$DRE, levels=c("No previous DRE", "Normal DRE", "Abnormal DRE")),
                         prev.PSA = factor(input$prev.PSA, levels=c("No previous PSA", "PSA < 1.0", "PSA 1.0-2.5", "PSA > 2.5")),
                         Health = factor(input$Health, levels=c("Excellent", "Very Good", "Good", "Poor")),
                         Leak = factor(input$Leak, levels=c("Not Bothersome", "Somewhat Bothersome", "Very Bothersome", "Extremely Bothersome")),
                         Sex = factor(input$Sex, levels=c("Not Important", "Somewhat Important", "Very Important", "Extremely Important")),
                         PC.Concern = factor(input$PC.Concern, levels=c("Not concerned at all", "Little concerned", "Very concerned", "Extremely concerned"))
      )
    new_df
  })
  
  output$pred <- renderPlot({
    pred.score <- eval(PC.Screen.fit, envir = get_newdata())
    therm.plot(pred.score)
    
    
  })
  
  
  
})