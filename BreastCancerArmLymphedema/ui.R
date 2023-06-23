require(shinythemes)
require(shinyjs)

fluidPage(theme = shinytheme("flatly"),
          tags$head(tags$link(rel="shortcut icon", href="../assets/icons/favicon.ico", type="image/x-icon")),
          tags$head(tags$link(rel="apple-touch-icon", href="../assets/icons/apple-touch-icon.png", type="image/x-icon")),
          useShinyjs(),
            tags$script(HTML(
    'function myFunction() {
  var txt;
  if (confirm("This is a mailbox for reporting website errors to programmers for the risk calculator website.  If you have questions or concerns about a specific calculator, please use the calculator Author Contact Information found on the publication for that calculator.  Each calculator is documented by a specific publication with a corresponding author.")) {
    window.open("mailto:rcalcsupport@ccf.org");
  }
}'
  )),
          
          titlePanel('Breast Cancer - Predicting 5-Year Risk of Arm Lymphedema'),
          
          sidebarLayout(
              sidebarPanel(id = "sidebar",
                           selectInput('time', "What is the patient time point?", choices = c("Preoperative", "Within 6 months after surgery", "6 months or more after surgery")),
                           textInput('AGE', 'Age (Years)', placeholder = '20 - 90'),
                           textInput('WEIGHT', 'Weight (Kg)', placeholder = '40 - 150'),
                           textInput('HEIGHT', 'Height (meter)', placeholder = '1.5 - 2.5'),
                           textInput('NEOCHEMO', 'Number of cycles of neo- or adjuvant chemotherapy infusions in ipsilateral arm', placeholder = '0 - 10'),
                           shinyjs::hidden(
                               div(id = "display1",
                                   selectInput('AXILLARYLEVEL', 'Level of axillary dissection', choices = c('I-II', 'I-II and III')),
                                   selectInput('RXTLOCATION1', 'Radiotherapy field', choices = c('Include Lymph Node Basin', 'No RXT or Breast or Chest Wall'))
                               )
                           ),
                           shinyjs::hidden(
                               div(id = "display2",
                                   selectInput('SEROMA', 'Seroma', choices = c('No', 'Yes')),
                                   selectInput('EARLYEDEMA', 'Early Edema', choices = c('No', 'Yes'))
                               )
                           )
              ),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
                  br(),
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] José Luiz B. Bevilacqua, Michael W. Kattan, Yu Changhong, et al. ",a('Nomograms for Predicting the Risk of Arm Lymphedema after Axillary Dissection in Breast Cancer', href='https://link.springer.com/article/10.1245%2Fs10434-012-2290-x'),". Annals of Surgical Oncology, 2012, Volume 19, Number 8, Page 2580")),
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
                  img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;")
              )
          )
)
