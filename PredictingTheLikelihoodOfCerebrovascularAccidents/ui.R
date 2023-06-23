
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

          titlePanel('Likelihood of Cerebrovascular Accidents (CVA)'),
          sidebarLayout(
              sidebarPanel(id = "sidebar"
                           ,
                           textInput('age', 'Age (years)', placeholder = '20 - 80'),
                           selectInput('Gender_Female', 'Female', choices = c('No', 'Yes')),
                           selectInput('hypertension', 'Hypertension', choices = c('No', 'Yes')),
                           selectInput('Disorder_Lipid_Metabolism', 'Disorder of Lipid Metabolism', choices = c('No', 'Yes')),
                           selectInput('Peripheral_and_Viceral_Atherosclerosis', 'Peripheral and Visceral Atherosclerosis', choices = c('No', 'Yes')),
                           selectInput('Occlusion_Stenosis_Precerebral_Arteries', 'Occlusion or Stenosis of Precerebral Arteries?', choices = c('No', 'Yes')),
                           selectInput('Ill_Defined_Cerebrovascular_Disease', 'Other and ill-defined Cerebrovascular disease?', choices = c('No', 'Yes')),
                           selectInput('Congestive_Heart_Failure', 'Congestive Heart Failure?', choices = c('No', 'Yes')),
                           selectInput('Aortic_Valve_Disorder', 'Aortic Valve Disorder?', choices = c('No', 'Yes')),
                           selectInput('Acute_Myocardial_Infarction', 'Acute Myocardial Infarction?', choices = c('No', 'Yes')),
                           selectInput('Coronary_Atherosclerosis', 'Coronary Atherosclerosis and other HD?', choices = c('No', 'Yes')),
                           selectInput('Atrial_Fibrillation_Flutter', 'Atrial Fibrillation/Flutter?', choices = c('No', 'Yes')),
                           selectInput('Head_Migraine', 'Headache, including Migraine?', choices = c('No', 'Yes')),
                           selectInput('SLE_Connective_Tissue_Disease', 'SLE/Connective Tissue Disease?', choices = c('No', 'Yes'))),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
                  br(),
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] Shivaraju A, Yu C, Kattan MW, Xie H, Shroff AR, Vidovich MI. ",a('Temporal Trends in Percutaneous Coronary Intervention-Associated Acute Cerebrovascular Accident (from the 1998 to 2008 Nationwide Inpatient Sample Database)', href='http://www.ncbi.nlm.nih.gov/pubmed/24952927'),". Am J Cardiol. 2014 Jul 15;114(2):206-13. doi: 10.1016/j.amjcard.2014.04.044. Epub 2014 May 6")),
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