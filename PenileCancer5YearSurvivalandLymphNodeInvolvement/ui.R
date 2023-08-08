
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

          titlePanel('Predicting 5-Year Survival and Lymph-Node Involvement'),
          sidebarLayout(
              sidebarPanel(id = "sidebar"
                           ,
                           selectInput('EmbGroup', 'Embolization Group', choices = c('Absent', 'Present')),
                           selectInput('GrowthPattern', 'Growth Pattern', choices = c('Superficial', 'Vertical')),
                           selectInput('CCI', 'Infiltration of Corpora Cavernosa', choices = c('Absent', 'Present')),
                           selectInput('CSI', 'Infiltration of Corpus Spongiosum', choices = c('Absent', 'Present')),
                           selectInput('cNGroup', 'Node Stage (Clinical)', choices = c('Unknown', 'cN0', 'cN+')),
                           selectInput('pNGroup', 'Node Stage (Pathological)', choices = c('Unknown', 'pN0', 'pN+', 'pNx')),
                           selectInput('Grade', 'Tumor Grade', choices = c('G1', 'G2', 'G3')),
                           selectInput('TumorThickness', 'Tumor Thickness (mm)', choices = c('> 5 mm', '<= 5 mm')),
                           selectInput('UrethraInfiltr', 'Urethra Infiltration', choices = c('Absent', 'Present'))),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
                  br(),
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),
                            p("[1] Kattan MW, Ficarra V, Artibani W, Cunico SC, Fandella A, Martignoni G, Novara G, Galetti TP, Zattoni F; GUONE Penile Cancer Project Members. ",a('Nomogram predictive of cancer specific survival in patients undergoing partial or total amputation for squamous cell carcinoma of the penis', href='http://www.ncbi.nlm.nih.gov/pubmed/16697813'),". J Urol. 2006 Jun;175(6):2103-8; discussion 2108"),
                            p("[2] Ficarra V, Zattoni F, Artibani W, Fandella A, Martignoni G, Novara G, Galetti TP, Zambolin T, Kattan MW; G.U.O.N.E. Penile Cancer Project Members. ",a('Nomogram predictive of pathological inguinal lymph node involvement in patients with squamous cell carcinoma of the penis', href='http://www.ncbi.nlm.nih.gov/pubmed/16600735'),". J Urol. 2006 May;175(5):1700-4; discussion 1704-5")),
                  
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
   href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/PenileCancer5YearSurvivalandLymphNodeInvolvement", 
   style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
 ),
                    style = "text-align: center;"),
                  img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;"))))