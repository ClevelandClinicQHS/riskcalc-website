
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

          titlePanel('Prostate Cancer - Predicting Cancer Risk Following Repeated Biopsy'),
          sidebarLayout(
              sidebarPanel(id = "sidebar"
                           ,
                           textInput('AgeYr', 'Age (years)', placeholder = '>=0'),
                           selectInput('DRE', 'Abnormal DRE Results', choices = c('No', 'Yes, < 1/2 lobe', 'Yes, > 1/2 lobe')),
                           textInput('PSA', 'Pre-Treatment PSA Level (ng/mL)', placeholder = '0 - 100'),
                           selectInput('PrevASAP', 'History of ASAP on Previous Biopsy?', choices = c('No', 'Yes')),
                           selectInput('PrevPIN', 'History of HGPIN on Previous Biopsy?', choices = c('No', 'Yes')),
                           selectInput('FH', 'Family History of Prostate Cancer?', choices = c('No', 'Yes')),
                           textInput('Height', 'Height (m)', placeholder = '1 - 3'),
                           textInput('Weight', 'Weight (kg)', placeholder = '10 - 300'),
                           textInput('NegCores', 'Number of Negative Cores Removed', placeholder = '>=0'),
                           selectInput('VolumeMissing', 'Is Total Prostate Volume (cc) missing?', choices = c('No', 'Yes')),
                           textInput('PVol', '[optional] Total Prostate Volume (if measured by MRI or Ultrasound) (cc)', placeholder = '>=0'),
                           textInput('PSASlope', 'PSA Slope (ng/mL/month)', placeholder = '>0'),
                           textInput('Diff', 'Months from Initial Negative Biopsy (months)', placeholder = '>=0'),
                           textInput('Months', 'Months from Previous Negative Biopsy (months)', placeholder = '>=0')),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
                  br(),
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] Moussa AS, Jones JS, Yu C, Fareed K, Kattan MW. ",a('Development and validation of a nomogram for predicting a positive repeat prostate biopsy in patients with a previous negative biopsy session in the era of extended prostate sampling', href='http://www.ncbi.nlm.nih.gov/pubmed/20438566'),". BJU Int. 2010 Nov;106(9):1309-14. doi: 10.1111/j.1464-410X.2010.09362.x."),
                            p("[2] Yanke BV, Gonen M, Scardino PT, Kattan MW. ",a('Validation of a nomogram for predicting positive repeat biopsy for prostate cancer', href='http://www.ncbi.nlm.nih.gov/pubmed/15643192'),". J Urol. 2005 Feb;173(2):421-4")),
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
   href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/ProstateCancerPredictCancerRiskFollowingRepeatedBiopsy", 
   style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
 ),
                    style = "text-align: center;"),          
                  img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;"))))