
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

          titlePanel('Prostate Cancer - Predicting Survival, Indolent Cancer, Freedom from Recurrence, Metastasis, and Trifecta'),
          sidebarLayout(
              sidebarPanel(id = "sidebar"
                           ,
                           textInput('Agex', 'Age (years)', placeholder = '>=0'),
                           selectInput('allGleason', 'Biopsy Gleason Primary + Secondary', choices = c('1+1', '1+2', '1+3', '2+1', '2+2', '2+3', '2+4', '2+5', '3+1', '3+2', '3+3', '3+4', '3+5', '4+1', '4+2', '4+3', '4+4', '4+5', '5+1', '5+2', '5+3', '5+4', '5+5')),
                           selectInput('cStage', 'Clinical Stage', choices = c('T1A', 'T1B', 'T1C', 'T2A', 'T2B', 'T2C', 'T3A', 'T3B', 'T3C')),
                           textInput('experience', '[optional] Experience', placeholder = '0 - 2000'),
                           selectInput('DxType', 'Method of Diagnosis', choices = c('TURP', 'Needle Biopsy')),
                           textInput('totalneg', 'non-Cancer (in all cores) (mm)', placeholder = '>=0'),
                           textInput('totalca', 'Cancer (in all cores) (mm)', placeholder = '>=0'),
                           selectInput('wwHormtx', 'Neoadjuvant Hormones', choices = c('No', 'Yes')),
                           textInput('fCancer', 'Percent Cancer in Biopsy Cores (%)', placeholder = '0 - 100'),
                           textInput('perbx', 'Percent Positive Cores (%)', placeholder = '0 - 100'),
                           selectInput('PreTxEF', 'Pre-Treatment Erectile Function', choices = c('Normal full', 'Normal but decreased')),
                           textInput('prepsa', 'Pre-Treatment PSA Level  (ng/mL)', placeholder = '0 - 50'),
                           textInput('dose100', 'Radiation Dose (cGy)', placeholder = '6400 - 8600'),
                           textInput('usvol', 'U/S Prostate Volume (cc)', placeholder = '0 - 200')),
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
                            p("[1] Stephenson AJ, Kattan MW, Eastham JA, Bianco FJ Jr, Yossepowitch O, Vickers AJ, Klein EA, Wood DP, Scardino PT. ",a('Prostate cancer-specific mortality after radical prostatectomy for patients treated in the prostate-specific antigen era', href='http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3651598/'),". J Clin Oncol. 2009 Sep 10;27(26):4300-4305"),
                            p("[2] Kattan MW, Eastham JA, Wheeler TM, Maru N, Scardino PT, Erbersdobler A, Graefen M, Huland H, Koh H, Shariat S, Slawin KM, Ohori M. ",a('Counseling men with prostate cancer: a nomogram for predicting the presence of small, moderately differentiated, confined tumors', href='http://www.sciencedirect.com/science/article/pii/S0022534705629357'),". J Urol. 2003; 170: 1792-1797"),
                            p("[3] Kattan MW, Zelefsky MJ, Kupelian PA, Cho D, Scardino PT, Fuks Z, Leibel SA. ",a('Pretreatment nomogram that predicts 5-year probability of metastasis following three-dimensional conformal radiation therapy for localized prostate cancer', href='http://jco.ascopubs.org/content/21/24/4568.long'),". J Clin Oncol 2003; 21(24):4568-4571"),
                            p("[4] Stephenson AJ, Scardino PT, Eastham JA, Bianco FJ Jr, Dotan ZA, Fearn PA, Kattan MW. ",a('Preoperative nomogram predicting the 10-year probability of prostate cancer recurrence after radical prostatectomy', href='http://jnci.oxfordjournals.org/content/98/10/715.long'),". JNCI. 2006 May 17;98(10):715-717"),
                            p("[5] Zelefsky MJ, Kattan MW, Fearn P, Fearon BL, Stasi JP, Shippy AM, Scardino PT. ",
                              a('Pretreatment nomogram predicting ten-year biochemical outcome of three-dimensional conformal radiotherapy and intensity-modulated radiotherapy for prostate cancer', 
                                href='http://www.sciencedirect.com/science/article/pii/S0090429507004165'),
                              ". Urology. 2007, Aug:70(2):283-287"),
                            p("[6] Kattan MW, Cuzick J, Fisher G, Berney DM, Oliver T, Foster CS, Moller H, Reuter V, Fearn P, Eastham J, Scardino PT. ",
                              a('Transatlantic Prostate Group. Nomogram incorporating PSA level to predict cancer-specific survival for men with clinically localized prostate cancer managed without curative intent', 
                                href='http://onlinelibrary.wiley.com/doi/10.1002/cncr.23106/abstract;jsessionid=3A103AEBC7F7B227585F6F20DA93BDA2.f02t03'),
                              ". Cancer. 2008 Jan 1;112(1):69-74."),
                            p("[7] Eastham JA, Scardino PT, Kattan MW. ",a('Predicting an optimal outcome after radical prostatectomy: the trifecta nomogram', href='http://www.sciencedirect.com/science/article/pii/S002253470800253X'),". J Urol. 2008 Jun;179(6):2210-2211"),
                            p("[8] Kattan MW, Vickers AJ, Yu C, Bianco FJ, Cronin AM, Eastham JA, Klein EA, Reuther AM, Edson Pontes J, Scardino PT. ",a('Preoperative and postoperative nomograms incorporating surgeon experience for clinically localized prostate cancer', href='http://onlinelibrary.wiley.com/doi/10.1002/cncr.24083/abstract'),". Cancer. 2009 March 1;115(5):1005-1010")),
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