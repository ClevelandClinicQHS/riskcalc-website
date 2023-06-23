require(shiny)



shinyUI(fluidPage(
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

  # Application title
  tags$head(tags$style(HTML("h1 {color:ForestGreen}"))),
  headerPanel("Individualized Metabolic Surgery Score"),

  # Sidebar
  sidebarPanel(
    h3("Risk Factors", style="color:ForestGreen"),

    numericInput("Meds_Preop", "Preop Number of Diabetes Medications", min=0, max=5, value=0),

    selectInput("Preop_Insulin", "Preop Insulin Use", choices=list("No", "Yes")),

    numericInput("Duration_Pts", "Preop Duration of Diabetes (years)", min=0, max=40, value=0),

    selectInput("Glycemic_Pts", "Preop Glycemic Control (A1c < 7%)", choices=list("Yes", "No")),

    p(em("Individualized Metabolic Surgery Score"), "categorizes patients with type 2 diabetes into three validated stages for evidence-based bariatric procedure selection (Roux-en-Y gastric bypass [RYGB] vs. sleeve gastrectomy [SG]).")
  ),
  mainPanel(

    h3(textOutput("score.text")),
    plotOutput("pred1", height="500px"),
    #plotOutput("score.rec", height="400px", width = "75%")
    p("Recommendation in Average Risk Patients:"),
    h4(textOutput("rec.text"), align = "center"),
    p(textOutput("recP.text")),
                      wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] Ali Aminian et al. ",a('Individualized Metabolic Surgery Score: Procedure Selection Based on Diabetes Severity', href='https://www.ncbi.nlm.nih.gov/pubmed/28742680'),". Ann Surg. 2017 Jul 24. doi: 10.1097/SLA.0000000000002407")),
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
                    style = "text-align: center;"),
                  img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;"))
))
