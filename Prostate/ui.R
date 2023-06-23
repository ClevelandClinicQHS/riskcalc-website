
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

          titlePanel('Prostate Cancer - Predicting Increased Pathologic Gleason Score'),
          sidebarLayout(
              sidebarPanel(id = "sidebar"
                           ,
                           textInput('AgeYr', 'Age (years)', placeholder = '>=0'),
                           selectInput('Race', 'Race', choices = c('African American', 'Caucasian', 'Other')),
                           selectInput('AbDRE', 'Abnormal DRE Results', choices = c('No', 'Yes')),
                           textInput('TV', 'Prostate Volume (cc)', placeholder = '>=0'),
                           selectInput('ClinStage', 'Clinical Stage', choices = c('T1C', 'T2', 'T3')),
                           textInput('NumBiopsies', 'Number of Previous Biopsies', placeholder = '>=0'),
                           textInput('PSA', 'Most Recent PSA Level (ng/mL)', placeholder = '>=0'),
                           textInput('Cores', 'Number of Cores Taken', placeholder = '>=0'),
                           textInput('PosCores', 'Number of Positive Cores', placeholder = '>=0'),
                           textInput('MaxPerc', 'Maximum Percent Cancer (%)', placeholder = '0 - 100'),
                           selectInput('G2', 'Secondary Gleason Grade', choices = c('3', '4')),
                           selectInput('PerInv', 'Perineural Invasion?', choices = c('No', 'Yes')),
                           selectInput('Inflam', 'Inflammation?', choices = c('No', 'Yes')),
                           selectInput('PINHist', 'History of HGPIN?', choices = c('No', 'Yes')),
                           selectInput('AtypiaHist', 'History of Atypia?', choices = c('No', 'Yes'))),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
                  br(),
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] Moussa AS, Kattan MW, Berglund R, Yu C, Fareed K, Jones JS. ",a('A nomogram for predicting upgrading in patients with low- and intermediate-grade prostate cancer in the era of extended prostate sampling', href='https://www.ncbi.nlm.nih.gov/pubmed/19681898'),". BJU Int. 2010 Feb;105(3):352-8. doi: 10.1111/j.1464-410X.2009.08778.x. Epub 2009 Aug 13")),
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