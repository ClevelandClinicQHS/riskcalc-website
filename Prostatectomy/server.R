# Created: 2024-07-22
# Author: Alex Zajichek
# Project: Risk of dying from prostate cancer
# Description: Contains the app server

shinyServer(function(input, output, session){
  
  # Get the current risk set
  risk_set <-
    reactive({
      
      # Compute the number of men for each color
      death_ps <- round(100 * input$rod_prostate)
      death_other <- round(100 * input$rod_other)
      death_trt <- round(100 * input$rod_trt)
      no_death <- 100 - death_ps - death_other
      
      list(death_ps = death_ps, death_other = death_other, no_death = no_death, death_trt = death_trt)
      
    })
  
  # Make the text output3
  output$label_no_death <- renderUI({HTML(paste0("<p><strong><span style = 'font-size:24px; color: #7f7f7f'>", risk_set()$no_death,"%<br></span></strong><span style='font-size:14px; color: #7f7f7f'>men would have lived</span></p>"))})
  output$label_death_ps <- renderUI({HTML(paste0("<p><strong><span style = 'font-size:24px; color: #c00000'>", risk_set()$death_ps,"%<br></span></strong><span style='font-size:14px; color: #7f7f7f'>men would have died of untreated prostate cancer</span><br><strong><span style='font-size:14px; color: #c00000'>", risk_set()$death_trt, "% men would have lived with getting the treatments</span></strong></p>"))})
  output$label_death_other <- renderUI({HTML(paste0("<p><strong><span style = 'font-size:24px; color: #215f9a'>", risk_set()$death_other,"%<br></span></strong><span style='font-size:14px; color: #7f7f7f'>men would have died of other causes</span></p>"))})

  # Make the people plot
  output$people <-
    renderPlot({
      
      # Data set
      temp_dat <-
        data.frame(
          row = c(rep(1, 25), rep(2, 25), rep(3, 25), rep(4, 25)),
          col = rep(1:25, 4),
          image = c(rep("www/man_alive.png", risk_set()$no_death), rep("www/man_dead_ps.png", risk_set()$death_ps - risk_set()$death_trt), rep("www/man_dead_ps_trt.png", risk_set()$death_trt), rep("www/man_dead_other.png", risk_set()$death_other))
        )
      
      # Make the plot
      temp_plot <-
        ggplot(temp_dat) + 
        geom_image(
          aes(
            x = col,
            y = 5 - row,
            image = image
          ),
          size = .03
        ) +
        theme(
          panel.background = element_blank(),
          axis.title = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          plot.margin = unit(c(-10, 0, -3, 0), "cm")
        ) +
        coord_cartesian(ylim = c(-3, 8)) 
      
      temp_plot
      
    }, height = 600, width = 800)
  
})