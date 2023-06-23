
require(shinythemes)
fluidPage(theme = shinytheme("flatly"),
    tags$script(HTML(
    'function myFunction() {
  var txt;
  if (confirm("This is a mailbox for reporting website errors to programmers for the risk calculator website.  If you have questions or concerns about a specific calculator, please use the calculator Author Contact Information found on the publication for that calculator.  Each calculator is documented by a specific publication with a corresponding author.")) {
    window.open("mailto:rcalcsupport@ccf.org");
  }
}'
  )),

          titlePanel('Prostate Cancer - Predicting PSA Recurrence Following Salvage Radiation Therapy'),
          sidebarLayout(
              sidebarPanel(id = "sidebar"
                           ,
                           textInput('PreOpPSA', '[optional] Pre-Prostatectomy PSA Level (ng/mL)', placeholder = '0 - 100'),
                           selectInput('Gleason', 'Gleason Grade', choices = c('6 or lower', '7', '8', '9-10')),
                           selectInput('SVI', 'Seminal Vesicle Invasion?', choices = c('No', 'Yes')),
                           selectInput('ECE', 'Extracapsular (Extraprostatic) Extension?', choices = c('No', 'Yes')),
                           selectInput('SM', 'Surgical Margins Status', choices = c('Negative', 'Positive')),
                           selectInput('LNI', 'Lymph Node Metastasis?', choices = c('Unknown', 'No', 'Yes')),
                           selectInput('RPPSANMA', 'Elevated post-Prostatectomy PSA Level? (persistently)', choices = c('Unknown', 'No', 'Yes')),
                           textInput('DFI', '[optional] Disease-Free Interval (months)', placeholder = '0 - 60'),
                           textInput('RTPSA', 'Pre-Radiotherapy PSA (ng/mL)', placeholder = '0.2 - 20'),
                           textInput('PSADT', '[optional] PSA Doubling Time (months)', placeholder = '0 - 120'),
                           selectInput('NADT', 'Neoadjuvant/concurrent Androgen-Deprivation Therapy?', choices = c('No', 'Yes')),
                           textInput('RTDose', '[optional] Prostate bed Radiation Dose (cGy)', placeholder = '5000 - 7600')),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
                  br(),
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] Rahul D. Tendulkar, Shree Agrawal, Tianming Gao, Jason A. Efstathiou, Thomas M. Pisansky, Jeff M. Michalski, Bridget F. Koontz, Daniel A. Hamstra, Felix Y. Feng, Stanley L. Liauw, Matthew C. Abramowitz, Alan Pollack, Mitchell S. Anscher, Drew Moghanaki, Robert B. Den, Kevin L. Stephans, Anthony L. Zietman, W. Robert Lee, Michael W. Kattan and Andrew J. Stephenson. ",a('Contemporary Update of a Multi-Institutional Predictive Nomogram for Salvage Radiotherapy After Radical Prostatectomy', href='http://ascopubs.org/doi/abs/10.1200/JCO.2016.67.9647'),". J Clin Oncol. published online on August 15, 2016"),
                            p("[2] Stephenson AJ, Scardino PT, Kattan MW, Pisansky TM, Slawin KM, Klein EA, Anscher MS, Michalski JM, Sandler HM, Lin DW, Forman JD, Zelefsky MJ, Kestin LL, Roehrborn CG, Catton CN, DeWeese TL, Liauw SL, Valicenti RK, Kuban DA, Pollack A. ",a('Predicting the outcome of salvage radiation therapy for recurrent prostate cancer after radical prostatectomy', href='https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2670394/'),". J Clin Oncol. 2007 May 20;25(15):2035-41. Erratum in: J Clin Oncol. 2007 Sep 10;25(26):4153")),
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
                    style = "text-align: center;"),
                  img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;"))))