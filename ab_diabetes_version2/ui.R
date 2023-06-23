library(shiny)

# Define UI for the risk calculator that
##  predicts the 30 probability of
## receiving a transfusion after gynecologic surgery
shinyUI(pageWithSidebar(
        tags$script(HTML(
    'function myFunction() {
  var txt;
  if (confirm("This is a mailbox for reporting website errors to programmers for the risk calculator website.  If you have questions or concerns about a specific calculator, please use the calculator Author Contact Information found on the publication for that calculator.  Each calculator is documented by a specific publication with a corresponding author.")) {
    window.open("mailto:rcalcsupport@ccf.org");
  }
}'
  )),
        # Application title
        headerPanel(h1("Type 2 Diabetes Mellitus Risk Calculator", style = "color:Black")),
        
        # Sidebar with controls to select a dataset and specify the number
        # of observations to view
        sidebarPanel(
                sliderInput("a1c", "HbA1c", value = 5.7, min = 3.9, max = 6.4, round = TRUE),
                sliderInput("Age", "Age", value = 58, min = 19, max = 108, round = TRUE),
                selectInput("Fam_Hx_Diabetes", "Family history of diabetes mellitus", 
                            choices = c("Yes", "No")),
                sliderInput("bmi", "Body Mass Index", value = 30, min = 14, max = 90, round = TRUE),
                sliderInput("HDL", "HDL", value = 50, min = 10, max = 128, round = TRUE),
                sliderInput("TRIGLY", "TRIGLY", value = 110, min = 23, max = 1179, round = TRUE),
                sliderInput("ALT", "ALT", value = 22, min = 4, max = 1597, round = TRUE),
                selectInput("TobaccoUse", "Tobacco Use", 
                            choices = c("Yes", "No"))
               # submitButton(text = "Calculate")
        ),
        
        # Show the desired plot in the UI
        mainPanel(
                h2("Probability of Developing Type 2 Diabetes Mellitus",
                   style = "color:DodgerMediumBlue",align = "center"),
                plotOutput("prediction"),
                h6("The calculator can not be used for pregnant woman with gestational diabetes or patients taking steroids.",
                   align = "bottom", style = "color:black"),
                h3(a("Cleveland Clinic, Internal Medicine Institute",
                     href = "http://my.clevelandclinic.org/services/medicine-institute/internal-medicine", align = "center", style = "color:DodgerMediumBlue")
                )
                
                
        )
))

