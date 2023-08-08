
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
          titlePanel('30-day and 12-month Outcomes after Discharge for an Acute Coronary Syndrome'),
          sidebarLayout(
              sidebarPanel(id = "sidebar",
                           textInput('AgeonEDvisit', 'Age', placeholder = '30 - 85'),
                           textInput('Height', 'Height (inches)', placeholder = '60 - 80'),
                           textInput('Weight', 'Weight (pounds)', placeholder = '75 - 350'),
                           selectInput('Sex', 'Sex', choices = c('Male', 'Female')),
                           selectInput('ETHNIC_GROUP_C', 'Race', choices = c('Black', 'White', 'Other')),
                           selectInput('ACS_Type', 'ACS Type', choices = c('STEMI', 'NSTEMI', 'Unstable Angina')),
                           selectInput('CabgPCIOtherStent', 'Type of intervention', choices = c('Other', 'PCI-Bare', 'PCI-Coated', 'PCI-No', 'CABG')),
                           selectInput('HospitalacuteBetaBlocker', 'Beta blocker in hospital', choices = c('No', 'Yes')),
                           selectInput('HospitalPlavixPreProc', 'Clopidogrel pre-procedure', choices = c('No', 'Yes')),
                           selectInput('BaseSmoking', 'Current smoker', choices = c('No', 'Yes')),
                           selectInput('ComboHospitalDischargePlavix2', 'Discharged on Clopidogrel', choices = c('No', 'Yes')),
                           selectInput('DischargedHome', 'Discharged to home', choices = c('No', 'Yes')),
                           selectInput('HospitalacuteGII_IIIb', 'Gp IIa/IIIB Inhibitor for PCI', choices = c('No', 'Yes')),
                           selectInput('BaseCHFAny', 'History of CHF', choices = c('No', 'Yes')),
                           selectInput('BaseRenalAnyCKDepi', 'History of Chronic Kidney Disease', choices = c('No', 'Yes')),
                           selectInput('BaseCOPDAny', 'History of COPD', choices = c('No', 'Yes')),
                           selectInput('BaseDiabetesAny', 'History of diabetes', choices = c('No', 'Yes')),
                           selectInput('BaseStroke', 'History of stroke', choices = c('No', 'Yes')),
                           selectInput('BasePerVascDis', 'History of PVD', choices = c('No', 'Yes')),
                           selectInput('BaseHypercholesterolAny', 'Lipid lowering medication', choices = c('No', 'Yes')),
                           selectInput('NewCHF', 'New CHF in hospital', choices = c('No', 'Yes')),
                           selectInput('HospitalStroke', 'Stroke in hospital', choices = c('No', 'Yes')),
                           selectInput('HospitalacuteACEIARB', 'ACE or ARB in hospital', choices = c('No', 'Yes')),
                           textInput('BH_Albumin', 'First Albumin (g/dL)', placeholder = '1 - 6'),
                           textInput('HospitalALT', 'First ALT (u/L)', placeholder = '10 - 500'),
                           textInput('BH_scr', 'First Creatinine (mg/dL)', placeholder = '0.5 - 5'),
                           textInput('BaseHDL', 'First HDL', placeholder = '10 - 80'),
                           textInput('hematocrit', 'First hematocrit (%)', placeholder = '15 - 60'),
                           textInput('BH_LDL', 'First LDL (mg/dL)', placeholder = '10 - 80'),
                           textInput('HospitalPulse', 'First pulse'),
                           textInput('Hospital_Int_Cath_LVEF', 'LVEF (%)', placeholder = '20 - 70'),
                           textInput('MAX_TNT', 'Maximum TNT (mcg/L)', placeholder = '0.01 - 50'),
                           textInput('NVesselsTreated', 'Number of vessels treated', placeholder = '1 - 4'),
                           textInput('NVesselsStenosed50', 'Vessels stenosed >50%', placeholder = '1 - 4')),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  br(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
                  br(),
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] Kumbhani DJ, Wells BJ, Lincoff AM, Jain A, Arrigain S, Yu C, Goormastic M, Ellis SG, Blackstone E, Kattan MW. ",a('Predictive models for short- and long-term adverse outcomes following discharge in a contemporary population with acute coronary syndromes', href='http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3584647/pdf/ajcd0003-0039.pdf'),". Am J Cardiovasc Dis. 2013;3(1):39-52. Epub 2013 Feb 17")),
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
   href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/ACS", 
   style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
 ),
                    style = "text-align: center;"),
                  img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;"))))