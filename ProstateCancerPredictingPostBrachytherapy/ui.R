
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

          titlePanel('Prostate Cancer - Predicting Post-Treatment Freedom from Recurrence'),
          sidebarLayout(
              sidebarPanel(id = "sidebar"
                           ,
                           selectInput('adjrt', 'Received Adjuvant Radiotherapy?', choices = c('No', 'Yes')),
                           textInput('d90', 'Brachytherapy D90 (Gy)', placeholder = '0 - 280'),
                           selectInput('isotopecha', 'Brachytherapy Isotope', choices = c('N/A', 'I-125', 'Pd-103')),
                           selectInput('stagecha', 'Clinical Stage', choices = c('T1c', 'T2a', 'T2b', 'T2c', 'T3')),
                           textInput('psa', 'Pre-Treatment PSA Level (ng/mL)', placeholder = '0 - 100'),
                           selectInput('g1', 'Primary Gleason Grade (post-op)', choices = c('1', '2', '3', '4', '5')),
                           selectInput('g2', 'Secondary Gleason Grade (post-op)', choices = c('1', '2', '3', '4', '5'))),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
                  br(),
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] Potters L, Roach M 3rd, Davis BJ, Stock RG, Ciezki JP, Zelefsky MJ, Stone NN, Fearn PA, Yu C, Shinohara K, Kattan MW. ",a('Postoperative nomogram predicting the 9-year probability of prostate cancer recurrence after permanent prostate brachytherapy using radiation dose as a prognostic variable', href='http://www.ncbi.nlm.nih.gov/pubmed/19540064'),". Int J Radiat Oncol Biol Phys. 2010 Mar 15;76(4):1061-5. doi: 10.1016/j.ijrobp.2009.03.031. Epub 2009 Jun 18")),
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
   href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/ProstateCancerPredictingPostBrachytherapy", 
   style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
 ),
                    style = "text-align: center;"),
                  img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;"))))