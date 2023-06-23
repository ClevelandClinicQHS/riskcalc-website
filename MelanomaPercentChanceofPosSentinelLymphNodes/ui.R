
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

          titlePanel('Percent Chance of Positive Sentinel Lymph Nodes'),
          sidebarLayout(
              sidebarPanel(id = "sidebar"
                           ,
                           textInput('AgeYr', 'Age (years)', placeholder = '5 - 96'),
                           selectInput('Site', 'Site of Primary Tumor', choices = c('Head / Neck', 'Trunk', 'Extremities')),
                           textInput('Thickness', 'Tumor Thickness (mm)', placeholder = '0 - 38'),
                           selectInput('Level', 'Clark Level', choices = c('2/3', '4', '5')),
                           selectInput('ULC', 'Ulceration?', choices = c('No', 'Yes'))),
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
                    p("[1] Wong SL, Kattan MW, McMasters KM, Coit DG. ",a('A nomogram that predicts the presence of sentinel node metastasis in melanoma with better discrimination than the American Joint Committee on Cancer staging system.', href='http://www.springerlink.com/content/w218w8r130622m7j/fulltext.pdf')," Ann Surg Oncol. 2005 Apr;12(4):282-8. Epub 2005 Mar 14"),
                    p("[2] Piñero A, Canteras M, Ortiz E, Martínez-Barba E, Parrilla P. ",a('Validation of a nomogram to predict the presence of sentinel lymph node metastases in melanoma.', href='https://www.ncbi.nlm.nih.gov/pubmed/18648880')," Ann Surg Oncol. 2008 Oct;15(10):2874-7. doi: 10.1245/s10434-008-0077-x. Epub 2008 Jul 22."),
                    p("[3] Pasquali S, Mocellin S, Campana LG, Vecchiato A, Bonandini E, Montesco MC, Santarcangelo S, Zavagno G, Nitti D, Rossi CR. ",a('Maximizing the clinical usefulness of a nomogram to select patients candidate to sentinel node biopsy for cutaneous melanoma.', href='https://www.ncbi.nlm.nih.gov/pubmed/21683543')," Eur J Surg Oncol. 2011 Aug;37(8):675-80. doi: 10.1016/j.ejso.2011.05.007. Epub 2011 Jun 16."),
                    p("[4] Woods JF, De Marchi JA, Lowery AJ, Hill AD. ",a('Validation of a nomogram predicting sentinel lymph node status in melanoma in an Irish population.', href='https://www.ncbi.nlm.nih.gov/pubmed/24997756')," Ir J Med Sci. 2015 Dec;184(4):769-73. doi: 10.1007/s11845-014-1166-4. Epub 2014 Jul 6.")),
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
                  img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;"))))