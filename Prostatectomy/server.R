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
      no_death <- 100 - death_ps - death_other
      
      list(death_ps = death_ps, death_other = death_other, no_death = no_death)
      
    })
  
  # Make the text output3
  output$label_no_death <- renderUI({HTML(paste0("<p><strong><span style = 'font-size:24px; color: #7f7f7f'>", risk_set()$no_death,"%<br></span><span style='font-size:14px; color: #7f7f7f'>men would have lived</span></strong></p>"))})
  output$label_death_ps <- renderUI({HTML(paste0("<p><strong><span style = 'font-size:24px; color: #c00000'>", risk_set()$death_ps,"%<br></span><span style='font-size:14px; color: #c00000'>men would have died of untreated prostate cancer</span></strong></p>"))})
  output$label_death_other <- renderUI({HTML(paste0("<p><strong><span style = 'font-size:24px; color: #215f9a'>", risk_set()$death_other,"%<br></span><span style='font-size:14px; color: #215f9a'>men would have died of other causes</span></strong></p>"))})

  # Make the people plot
  output$people <-
    renderImage({
      
      # Data set
      temp_dat <-
        data.frame(
          row = c(rep(1, 25), rep(2, 25), rep(3, 25), rep(4, 25)),
          col = rep(1:25, 4),
          image = c(rep("man_alive.png", risk_set()$no_death), rep("man_dead_ps.png", risk_set()$death_ps), rep("man_dead_other.png", risk_set()$death_other))
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
          size = .05
        ) +
        theme(
          panel.background = element_blank(),
          axis.title = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank()
        ) +
        coord_cartesian(ylim = c(-1.5, 6.5)) 
      
      # Output as image
      temp_image <- tempfile(fileext = ".png")
      ggsave(temp_image, temp_plot, device = "png", width = 800, height = 600, units = "px")
      
      # Crop the image
      temp_image_edit <- image_read(temp_image)
      temp_image_edit <- image_crop(magick::image_crop(temp_image_edit, "715x0+50+150"), "0x0+0-165")
      temp_image2 <- tempfile(fileext = ".png")
      image_write(temp_image_edit, temp_image2, format = "png")
      
     list(src = temp_image2)
      
    }, deleteFile = TRUE)
  
})