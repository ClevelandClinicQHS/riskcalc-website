
require(shinythemes)
fluidPage(theme = shinytheme("flatly"),
          tags$head(tags$style(
              HTML('
                 #sidebar {
                    overflow-y:scroll; height: 90vh; position:relative;
                 }')
          )),
          titlePanel('Prostate Cancer - Predicting Post-Treatment Freedom from Recurrence'),
          sidebarLayout(
              sidebarPanel(id = "sidebar"
                           ,
                           selectInput('adjrt', 'Received Adjuvant Radiotherapy?', choices = c('No', 'Yes')),
                           textInput('d90', 'Brachytherapy D90 (Gy)', placeholder = '0 - 280'),
                           selectInput('isotopecha', 'Brachytherapy Isotope', choices = c('N/A', 'I-125', 'Pd-103')),
                           selectInput('ecelev', 'Capsular Invasion Type', choices = c('None', 'Inv.Capsule', 'Focal', 'Established')),
                           selectInput('stagecha', 'Clinical Stage', choices = c('T1c', 'T2a', 'T2b', 'T2c', 'T3')),
                           selectInput('ece', 'Extracapsular Extension', choices = c('No', 'Yes')),
                           selectInput('lni', 'Lymph Node Status', choices = c('Negative', 'Positive')),
                           textInput('psa', 'Pre-Treatment PSA Level (ng/mL)', placeholder = '0 - 100'),
                           selectInput('g1', 'Primary Gleason Grade (post-op)', choices = c('1', '2', '3', '4', '5')),
                           selectInput('g2', 'Secondary Gleason Grade (post-op)', choices = c('1', '2', '3', '4', '5')),
                           selectInput('svi', 'Seminal Vesicle Invasion?', choices = c('No', 'Yes')),
                           textInput('experience', '[optional] Surgeon Experience (# of prior cases)', placeholder = '0 - 2000'),
                           selectInput('sm', 'Surgical Margins Status', choices = c('Negative', 'Positive')),
                           textInput('yos', 'Year of Surgery', placeholder = '1960 - 2060')),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
                  br(),
                  wellPanel(h3('Reference'),p("[1] Kattan MW, Wheeler TM, Scardino PT. ",a('Postoperative nomogram for disease recurrence after radical prostatectomy for prostate cancer', href='http://jco.ascopubs.org/content/17/5/1499.full.pdf'),". J Clin Oncol. 1999 May;17(5):1499-507"),
                            p("[2] Kattan MW, Vickers AJ, Yu C, Bianco FJ, Cronin AM, Eastham JA, Klein EA, Reuther AM, Edson Pontes J, Scardino PT. ",a('Preoperative and postoperative nomograms incorporating surgeon experience for clinically localized prostate cancer', href='https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3391599/'),". Cancer. 2009 Mar 1;115(5):1005-10. doi: 10.1002/cncr.24083"),
                            p("[3] Potters L, Roach M 3rd, Davis BJ, Stock RG, Ciezki JP, Zelefsky MJ, Stone NN, Fearn PA, Yu C, Shinohara K, Kattan MW. ",a('Postoperative nomogram predicting the 9-year probability of prostate cancer recurrence after permanent prostate brachytherapy using radiation dose as a prognostic variable', href='http://www.ncbi.nlm.nih.gov/pubmed/19540064'),". Int J Radiat Oncol Biol Phys. 2010 Mar 15;76(4):1061-5. doi: 10.1016/j.ijrobp.2009.03.031. Epub 2009 Jun 18"),
                            p("[4] Stephenson AJ, Scardino PT, Eastham JA, Bianco FJ Jr, Dotan ZA, DiBlasio CJ, Reuther A, Klein EA, Kattan MW. ",a('Postoperative nomogram predicting the 10-year probability of prostate cancer recurrence after radical prostatectomy', href='http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2231088/pdf/nihms27199.pdf'),". J Clin Oncol. 2005 Oct 1;23(28):7005-12")),
                  wellPanel(h3('Disclaimer'),
                            p("No Medical Advice. ALTHOUGH SOME CONTENT MAY BE PROVIDED BY INDIVIDUALS IN THE MEDICAL PROFESSION, YOU ACKNOWLEDGE THAT PROVISION OF SUCH CONTENT DOES NOT CREATE A MEDICAL PROFESSIONAL-PATIENT RELATIONSHIP AND DOES NOT CONSTITUTE AN OPINION, MEDICAL ADVICE, PROFESSIONAL DIAGNOSIS, SERVICE OR TREATMENT OF ANY CONDITION. Access to general information is provided for educational purposes only, through this site and links to other sites. Content is not recommended or endorsed by any doctor or healthcare provider. The information and Content provided are not substitutes for medical or professional care, and you should not use the information in place of a visit, call, consultation or the advice of your physician or other healthcare provider. You are liable or responsible for any advice, course of treatment, diagnosis or any other information, services or product obtained through this site.")),
p(a("Homepage",
                      href = "../", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"), 
                    " | ",
                    a("Contact Us",
                      href = "mailto:ralcsupport@ccf.org", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"), 
                    style = "text-align: center;"),
                  img(src='../CC_c.jpg', style = "max-width:50%; max-height:100%;"))))