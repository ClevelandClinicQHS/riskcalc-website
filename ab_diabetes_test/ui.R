library(shiny)

# Define UI for the risk calculator that
##  predicts the 30 probability of
## receiving a transfusion after gynecologic surgery
shinyUI(pageWithSidebar(
        
        # Application title
        headerPanel(h1("Transfusion After Gynecologic Surgery Risk Calculator", style = "color:Black")),
        
        # Sidebar with controls to select a dataset and specify the number
        # of observations to view
        sidebarPanel(
                sliderInput("First_parity", "Parity", value = 2, min = 0, max = 12, round = TRUE),
                sliderInput("bmi", "Body Mass Index (kg/m^2) ", value = 30, min = 10, max = 90, round = TRUE),
                selectInput("abd", "Planning laparotomy", choices = c("FALSE", "TRUE")),
                selectInput("myomec", "Planning myomectomy", choices = c("FALSE", "TRUE")),
                selectInput("malig", "Planning procedure for possible malignancy", choices = c("FALSE", "TRUE")),
                selectInput("hscope", "Planning hysteroscopy", choices = c("FALSE", "TRUE")),
                selectInput("Fibroids", "History of uterine fibroids", choices = c("FALSE", "TRUE")),
                selectInput("hypertension", "History of hypertension", choices = c("FALSE", "TRUE")),
                selectInput("Menorrhagia", "History of heavy menstrual bleeding", choices = c("FALSE", "TRUE")),
                selectInput("OvarianCancer", "History of ovarian cancer", choices = c("FALSE", "TRUE")),
                selectInput("Exp_Lap", "History of previous laparotomy", choices = c("FALSE", "TRUE")),
                sliderInput("ORD_VALUE","Preoperative Hemoglobin (g/dL)", value = 13, min = 3, max = 17, round = TRUE)
                
               # submitButton(text = "Calculate")
        ),
        
        # Show the desired plot in the UI
        mainPanel(
                h2("Probability of transfusion after gynecologic surgery",
                   style = "color:DodgerMediumBlue",align = "center"),
                plotOutput("prediction"),
                h3(a("Cleveland Clinic Obstetrics, Gynecology & Women's Health Institute",
                     href = "http://my.clevelandclinic.org/services/ob-gyn-womens-health", align = "center", style = "color:DodgerMediumBlue")
                )
                
                
        )
))

