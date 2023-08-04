
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

          titlePanel('Predicting 96-Month Disease Specific Survival in Patients with Metastatic Colorectal Cancer after Hepatic Resection'),
          sidebarLayout(
              sidebarPanel(id = "sidebar"
                           ,
                           textInput('AgeYr', 'Age (years)', placeholder = '19 - 87'),
                           selectInput('Gender', 'Gender', choices = c('Male', 'Female')),
                           selectInput('SiteColonCa', 'Location of Primary Tumor', choices = c('Rectum', 'Colon')),
                           textInput('DFI', 'Disease-Free Interval (months)', placeholder = '0 - 152'),
                           textInput('PreOpCEA', 'Pre-Operative CEA Level (ng/mL)', placeholder = '0 - 16400'),
                           textInput('L1Num', 'Number of Hepatic Tumors', placeholder = '0 - 20'),
                           textInput('SizeLargestMet', 'Size of Largest Metastatic Tumor (cm)', placeholder = '0 - 55'),
                           selectInput('NodalStatus', 'Nodal Status of Primary Tumor', choices = c('0', '1', '2')),
                           selectInput('BilatSC', 'Bilateral Resection?', choices = c('Yes', 'No')),
                           selectInput('LobeOrMore', 'More than 1 Lobe Removed?', choices = c('Yes', 'No'))),
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
                            p("[1] Kattan MW, Gonen M, Jarnagin WR, DeMatteo R, DAngelica M, Weiser M, Blumgart LH, Fong Y. ",
                              a('A nomogram for predicting disease-specific survival after hepatic resection for metastatic colorectal cancer', href='http://www.ncbi.nlm.nih.gov/pubmed/18216534'),
                              ". Ann Surg. 2008 Feb;247(2):282-7. doi: 10.1097/SLA.0b013e31815ed67b")),
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
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;")," | ",
 a("Source Code", 
   href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/ColorectalCancer96MonthSurvivalafterHepaticResection", 
   style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
 ),
                    style = "text-align: center;"),
                  img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;")
                  )
              )
          )