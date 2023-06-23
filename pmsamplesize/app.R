# library(shiny)
# 
# ui <- fluidPage(
#     h1("Redirecting to sample size website in 3 seconds, please use the 'Prediction Model'"),
# )
# 
# server <- function(input, output, session) {
#     # Redirect to another website after 5 seconds
#     observe({
#         Sys.sleep(3) # wait for 3 seconds
#         session$sendRedirect("https://riskcalc.org/samplesize")
#     })
# }
# 
# shinyApp(ui, server)

server <- function(input, output, session) {}
ui <- fluidPage(singleton(tags$head(tags$script('window.location.replace("https://riskcalc.org/samplesize");'))))
shinyApp(ui = ui, server = server)
