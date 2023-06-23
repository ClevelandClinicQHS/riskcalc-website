library(shiny)

# Define server logic for random distribution app ----
server <- function(input, output) {
    
}

# Create Shiny app ----
shinyApp(ui = htmlTemplate("www/index.html"), server)