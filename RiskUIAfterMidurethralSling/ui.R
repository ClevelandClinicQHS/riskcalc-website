
library(shinythemes)
library(shinyjs)
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
          titlePanel('Predicting Risk of Urinary Incontinence and Adverse Events in Patients 12 Months after Midurethral Sling Surgery'),
          sidebarLayout(
              sidebarPanel(id = "sidebar"
                           ,
                           selectInput('Dynamic', 'Are urodynamic variables available?', choices = c('No', 'Yes')),
                           shinyjs::hidden(
                            div(id = "display",                           
                              textInput('Vol_mcc', 'Bladder volume at maximum cystometric capacity (mL)', placeholder = '>=0'),
                              textInput('Val_pressure', 'Lowest Valsalva Leak Point Pressure (cm of water)', placeholder = '>=0')
                            )),
                           textInput('AgeYr', 'Age (in years)', placeholder = '18 - 100'),
                           selectInput('Race', 'Race', choices = c('Caucasian', 'Other')),
                           selectInput('VPARITY', 'Vaginal Parity', choices = c('0', '1', '2', '3', '>=4')),
                           selectInput('Menopause', 'Menopause', choices = c('Pre', 'Peri', 'Post')),
                           selectInput('BA', 'POPQ BA', choices = c('< +1', '>= +1')),
                           selectInput('CX', 'POPQ C', choices = c('< +1', '>= +1')),
                           selectInput('Prior_pelv_surg', 'Prior Pelvic Surgery', choices = c('No', 'Yes')),
                           selectInput('Pre_med_treat', 'Prior Medical (non-surgical) Treatment for UI', choices = c('No', 'Yes')),
                           selectInput('Physical_leak', 'Do you experience urine leakage related to physical activity, coughing, or sneezing?', choices = c('No', 'Yes - Not at All Bothersome', 'Yes - Slightly Bothersome', 'Yes - Moderately Bothersome', 'Yes - Greatly Bothersome')),
                           selectInput('Small_leak', 'Do you experience small amounts of urine leakage (drops)?', choices = c('No', 'Yes - Not at All Bothersome', 'Yes - Slightly Bothersome', 'Yes - Moderately Bothersome', 'Yes - Greatly Bothersome')),
                           selectInput('Incom_blad', 'Do you experience a feeling of incomplete bladder emptying?', c('No', 'Yes')),
                           selectInput('Urge_leak', 'Do you experience urine leakage related to the feeling of urgency?', choices = c('No', 'Yes')),
                           selectInput('ABD_pain', 'Do you experience pain in the lower abdominal or genital area?', choices = c('No', 'Yes')),
                           selectInput('Dull_pelvic', 'Do you experience heaviness or dullness in the pelvic area?', choices = c('No', 'Yes')),
                           selectInput('Freq_urine', 'Do you experience frequent urination?', choices = c('No', 'Yes')),
                           selectInput('Entertainment_actv', 'Are your entertainment activities such as going to a movie or concert affected by urinary leakage?', choices = c('No', 'Yes')),
                           selectInput('Emotional_health', 'Is your emotional health affected by your urinary leakage?', choices = c('No', 'Yes')),
                           selectInput('Recreation_actv', 'Are your physical recreation activities limited by urinary leakage?', choices = c('No', 'Yes')),
                           selectInput('Frustration', 'Do you experience frustration due to your urinary leakage?', choices = c('No', 'Yes')),
                           textInput('Max_fl_nif', 'Non-invasive maximum uroflow rate (mL/sec)', placeholder = '>=0'),

                           selectInput('Other_surg', 'Are there concomitant procedures being performed?', choices = c('No', 'Yes')),
                           selectInput('Type_of_surgery', 'Type of midurethral sling?', choices = c('Retropubic', 'Transobturator'))),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
                  br(),
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] J. Eric Jelovsek, MD, MMEd, Audra Jolyn Hill, MD, Kevin M. Chagin, MS, Michael W. Kattan, MBA, PhD, and Matthew D. Barber, MD, MHS. ",a('Predicting Risk of Urinary Incontinence and Adverse Events After Midurethral Sling Surgery in Women', href='http://www.ncbi.nlm.nih.gov/pubmed/26942362'),". Obstet Gynecol. 2016 Feb;127(2):330-40. doi: 10.1097/AOG.0000000000001269.")),
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
   href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/RiskUIAfterMidurethralSling", 
   style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
 ),
                    style = "text-align: center;"),
                  img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;"))))