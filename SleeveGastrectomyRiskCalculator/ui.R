
require(shinythemes)
fluidPage(theme = shinytheme("flatly"),
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

          titlePanel('Sleeve Gastrectomy Risk Calculator'),
          sidebarLayout(
              sidebarPanel(id = "sidebar"
                           ,
                           selectInput('Gender', 'Gender', choices = c('Male', 'Female')),
                           textInput('BMI', 'Body Mass Index (BMI) (kg/m2)', placeholder = '30 - 100'),
                           selectInput('Diabetes', 'Diabetes', choices = c('No', 'Yes')),
                           selectInput('History_CHF', 'History of Congestive Heart Failure (CHF)', choices = c('No', 'Yes')),
                           selectInput('Steriod_Use_Chronic_Condition', 'Steroid Use for Chronic Condition', choices = c('No', 'Yes')),
                           textInput('Preop_Hematocrit_Level', 'Preoperative Hematocrit Level (%)', placeholder = '27 - 54'),
                           selectInput('Preop_Serum_Total_Bilirubin_Level', 'Preoperative Serum Total Bilirubin Level (mg/dL)', choices = c('0', '1', '2', '3'))),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
                  br(),
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] Aminian A, Brethauer SA, Sharafkhah M, Schauer PR. ",a('Development of a sleeve gastrectomy risk calculator', href='http://www.sciencedirect.com/science/article/pii/S1550728914004948'),". Surg Obes Relat Dis. 2015 Jul-Aug;11(4):758-64. doi: 10.1016/j.soard.2014.12.012. Epub 2014 Dec 19")),
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
   href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/SleeveGastrectomyRiskCalculator", 
   style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
 ),
                    style = "text-align: center;"),
                  img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;"))))