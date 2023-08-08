library(shiny)

# Define UI for the risk calculator that
##  predicts the 30 probability of
## receiving a transfusion after gynecologic surgery
fluidPage(
    tags$head(tags$link(rel="shortcut icon", href="../assets/icons/favicon.ico", type="image/x-icon")),
    tags$head(tags$link(rel="apple-touch-icon", href="../assets/icons/apple-touch-icon.png", type="image/x-icon")),
      tags$script(HTML(
    'function myFunction() {
  var txt;
  if (confirm("This is a mailbox for reporting website errors to programmers for the risk calculator website.  If you have questions or concerns about a specific calculator, please use the calculator Author Contact Information found on the publication for that calculator.  Each calculator is documented by a specific publication with a corresponding author.")) {
    window.open("mailto:rcalcsupport@ccf.org");
  }
}'
  )),
      
    titlePanel("Transfusion After Gynecologic Surgery Risk Calculator"),
        
        # Sidebar with controls to select a dataset and specify the number
        # of observations to view
    sidebarLayout(
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
            ),
            
            wellPanel(h3('Disclaimer'),
                      p("No Medical Advice. ALTHOUGH SOME CONTENT MAY BE PROVIDED BY INDIVIDUALS IN THE MEDICAL PROFESSION, YOU ACKNOWLEDGE THAT PROVISION OF SUCH CONTENT DOES NOT CREATE A MEDICAL PROFESSIONAL-PATIENT RELATIONSHIP AND DOES NOT CONSTITUTE AN OPINION, MEDICAL ADVICE, PROFESSIONAL DIAGNOSIS, SERVICE OR TREATMENT OF ANY CONDITION. Access to general information is provided for educational purposes only, through this site and links to other sites. Content is not recommended or endorsed by any doctor or healthcare provider. The information and Content provided are not substitutes for medical or professional care, and you should not use the information in place of a visit, call, consultation or the advice of your physician or other healthcare provider. You are liable or responsible for any advice, course of treatment, diagnosis or any other information, services or product obtained through this site.")),
            p(a("Homepage",
                href = "../", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"), 
              " | ",
              a("Website Error Messages",
                href = "javascript:myFunction()",
 style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"), 
 " | ",
 a("Add to phone (iOS Safari)", href="https://support.apple.com/guide/iphone/bookmark-favorite-webpages-iph42ab2f3a7/ios#iph4f9a47bbc", target="_blank", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
 " | ", 
 a("Add to phone (Android)", href="https://www.cnet.com/tech/mobile/adding-one-touch-bookmarks-to-your-androids-home-screen/", target="_blank", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
 " | ",
 a("Source Code", 
   href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/TransfusionAfterGynecologicSurgery", 
   style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
 ),
              style = "text-align: center;"),
            img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;")
            
        ))
)

