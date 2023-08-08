require(shinythemes)
require(shinyBS)

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
    titlePanel('Predicting discharge to a long-term acute care hospital after admission to an intensive care unit'),
    sidebarLayout(
        sidebarPanel(
            id = "sidebar",
            h4("*Values should be selected based on the first 24 hours of ICU admission ONLY*", style = "font-weight: bold;"),
            textInput('Age', 'Age (years)', placeholder = '18 - 100'),
            selectInput(
                'Gender', 'Gender', choices = c('Female', 'Male')
            ),
            textInput('BMI', 'Body Mass Index', placeholder = '0 - 100'),
            textInput('NUM_LOSbeforeICUadmit', 'Length of Stay prior to ICU Admission (days)', placeholder = '0 - 60'),
            selectInput(
                'Adm_Site', 'Source of Admission', choices = c("Emergency Department", "Floor/Operating Room", "SNF/LTAC/Hospital Transfer")
            ),
            selectInput(
                'ICU_Category', 'Type of ICU Admission', choices = c('Cardiovascular ICU', "Coronary ICU", "Heart Failure ICU", "Medical ICU", "Neuro ICU", "Surgical ICU")
            ),
            selectInput(
                'Planned', 'ICU Category', choices = c("Planned", "Unplanned")
            ),
            textInput('MAPDay0', 'Mean Arterial Pressure (mm Hg)', placeholder = '0 - 300'),
            bsTooltip("MAPDay0", "MAP = 1/3 * systolic blood pressure + 2/3 * diastolic blood pressure", "right", options = list(container = "body")),
            selectInput('PressureUlcer', 'Pressure Ulcers (>= Stage 3)', choices = c('No', 'Yes')),
            selectInput('IntubationDay0', 'Mechanical Ventilation', choices = c('No', 'Yes')),
            textInput('FiO2Day0', 'Fraction of Inspired Oxygen (FiO2) (%)', placeholder = '20 - 100'),
            bsTooltip("FiO2Day0", "If patient is intubated, enter mechanical ventilator value. If patient is on an oxygen device or nasal cannula, estimate FiO2 using the liters per minute (LPM) and following equation: 21% + 3% (for first LPM) + 4% (for each additional LPM). For example, 1LPM = 24%; 2LPM = 28%; 3LPM = 32%; 4LPM = 36%; etc. If patient has no oxygen support, enter “21” for room air.", "right", options = list(container = "body")),
            textInput('PaO2Day0', 'Arterial Blood Oxygen Tension (PaO2) (mm Hg)', placeholder = '0 - 700'),
            selectInput('DopaDay0', 'Dopamine', choices = c('No', 'Yes')),
            selectInput('DobutDay0', 'Dobutamine', choices = c('No', 'Yes')),
            selectInput('NoraDay0', 'Norepinephrine', choices = c('No', 'Yes')),
            selectInput('EpineDay0', 'Epinephrine', choices = c('No', 'Yes')),
            selectInput('DialysisDay0', 'Dialysis', choices = c('No', 'Yes')),
            textInput(
                'CreatinineDay0', 'Creatinine (mg/dL)', placeholder = '0 - 200'
            ),
            textInput(
                'BilirubinDay0', 'Total Bilirubin (mg/dL)', placeholder = '0 - 100'
            ),
            textInput(
                'AlbuminDay0', 'Albumin (g/dL)', placeholder = '0 - 100'
            ),
            textInput(
                'PlateletsDay0', 'Platelet Count (K/uL)', placeholder = '0 - 1000'
            )
 
        ),
        
        mainPanel(
            actionButton("goButton", "Run Calculator"),
            br(),
            hr(),
            tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
            br(),
            wellPanel(
                h3('Click Below for Calculator and Author Contact Information'),
                p(
                    "[1] Szubski CR, Tellez A, Klika AK, Xu M, Kattan MW, Guzman JA, Barsoum WK. ",
                    a(
                        'Predicting discharge to a long-term acute care hospital after admission to an intensive care unit.',
                        href = 'https://www.ncbi.nlm.nih.gov/pubmed/24986179'
                    ),
                    " Am J Crit Care. 2014 Jul;23(4):e46-53. doi: 10.4037/ajcc2014985."
                )
            ),
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
   href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/LTACHafterICU", 
   style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
 ),
              style = "text-align: center;"),
            img(src = '../logo-ccf.png', style = "max-width:30%; max-height:100%;")
        )
    )
)
