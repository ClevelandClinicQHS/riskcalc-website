library(shiny)

# Define UI for the risk calculator that
##  predicts the 30 probability of
## any infection after Cesarean delivery
shinyUI(

  pageWithSidebar(
    
    # Application title
    headerPanel("Infection After Cesarean Delivery Risk Calculator"),
    
    # Sidebar with controls to select a dataset and specify the number
    # of observations to view
    sidebarPanel(
      sliderInput("GA_weeks", "Gestational age (Weeks)", value = 38, min = 24, max = 42, round = TRUE),
      sliderInput("GA_days1", "Gestational age (Days)", value = 0, min = 0, max = 6, round = TRUE),
      sliderInput("BMI", "Body Mass Index (kg/m^2) ", value = 32, min = 16, max = 80, round = TRUE),
      selectInput("Type", "Urgency to perform Cesarean section", choices = c("Emergent", "Scheduled", "Unscheduled but not Emergent")),
      sliderInput("Number_prior", "Number of previous Cesarean sections (0 to 5 or more", value = 0, min = 0, max = 5, round = TRUE), 
      selectInput("Reason_failtoprogress", "Failure to progress", choices = c("No", "Yes")),
      selectInput("Closure_skin", "Skin closure technique", choices = c("Staples", "Suture")),
      selectInput("Chorio_clinicaldx", "Chorioamnionitis", choices = c("No", "Yes")),
      selectInput("Comorbidities_asthma", "History of Asthma", choices = c("No", "Yes"))
      
      # submitButton(text = "Calculate")
    ),
    
    # Show the desired plot in the UI
    mainPanel(
      h2("30-day probability of infection after Cesarean Delivery",
         style = "color:DodgerMediumBlue",align = "center"),
      h4("Predictions assume prophylactic antibiotics were given at time of surgery", align = "center", style = "color:Black"),
      wellPanel(
        plotOutput("prediction"),
        h3(a("Cleveland Clinic Obstetrics, Gynecology & Women's Health Institute",
             href = "http://my.clevelandclinic.org/services/ob-gyn-womens-health", align = "center", style = "color:DodgerMediumBlue")
        )),
      br(),
      wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] Laura J. Moulton, J. Eric Jelovsek, Mark Lachiewicz, Kevin Chagin & Oluwatosin Goje (2017): ",a('A model to predict risk of postpartum infection after Caesarean delivery', href='http://dx.doi.org/10.1080/14767058.2017.1344632')," The Journal of Maternal-Fetal & Neonatal Medicine, DOI: 10.1080/14767058.2017.1344632")),
      wellPanel(h3('Disclaimer'),
                p("No Medical Advice. ALTHOUGH SOME CONTENT MAY BE PROVIDED BY INDIVIDUALS IN THE MEDICAL PROFESSION, YOU ACKNOWLEDGE THAT PROVISION OF SUCH CONTENT DOES NOT CREATE A MEDICAL PROFESSIONAL-PATIENT RELATIONSHIP AND DOES NOT CONSTITUTE AN OPINION, MEDICAL ADVICE, PROFESSIONAL DIAGNOSIS, SERVICE OR TREATMENT OF ANY CONDITION. Access to general information is provided for educational purposes only, through this site and links to other sites. Content is not recommended or endorsed by any doctor or healthcare provider. The information and Content provided are not substitutes for medical or professional care, and you should not use the information in place of a visit, call, consultation or the advice of your physician or other healthcare provider. You are liable or responsible for any advice, course of treatment, diagnosis or any other information, services or product obtained through this site.")),
      tags$script(HTML(
        'function myFunction() {
  var txt;
  if (confirm("This is a mailbox for reporting website errors to programmers for the risk calculator website.  If you have questions or concerns about a specific calculator, please use the calculator Author Contact Information found on the publication for that calculator.  Each calculator is documented by a specific publication with a corresponding author.")) {
    window.open("mailto:rcalcsupport@ccf.org");
  }
}'
      )),
      p(a("Homepage",
          href = "../", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                    font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"), 
        " | ",
        a("Website Error Messages",
          href = "javascript:myFunction()",
          style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                    font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"), 
        style = "text-align: center;"),
      img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;")
      
      
    )
  ))

