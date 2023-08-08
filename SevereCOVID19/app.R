#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(rms)
library(shinyBS)
library(shinyjs)
# surv = readRDS("surv_icu.RDS")

# Define UI
ui <- fluidPage(
  shinyjs::useShinyjs(),
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
  
    # Application title
    titlePanel("COVID-19 Positive Risk of Severe COVID-19"),
    
    h3("This tool predicts the risk of progression to severe COVID-19 in patients who first tested positive for COVID-19 today."),
    
    wellPanel(
      fluidRow(
        column(width = 2),
        column(width = 4,
               numericInput("Age", "Age (years)", min = 20, max = 85, value = 20),
               bsTooltip("Age", "Range: 20 - 85", "bottom", options = list(container = "body"))),
        column(width = 4,
               uiOutput("AgePoint")),
        column(width = 2)
      ),
      br(),
      fluidRow(
        column(width = 2),
        column(width = 4,
               selectInput("Gender", "Gender", choices = c("Male", "Female"))),
        column(width = 4,
               uiOutput("GenderPoint")),
        column(width = 2)
      ),
      br(),
      fluidRow(
        column(width = 2),
        column(width = 4,
               selectInput("Race", "Race", choices = c("Asian", "Black", "White", "Other"))),
        column(width = 4,
               uiOutput("RacePoint")),
        column(width = 2)
      ),
      br(),
      fluidRow(
        column(width = 2),
        column(width = 4,
               numericInput("MedianIncome", "Household Income ($,000)", min = 0, max = 260, value = 50),
               bsTooltip("MedianIncome", "Range: 0 - 260", "bottom", options = list(container = "body"))),
        column(width = 4,
               uiOutput("IncomePoint")),
        column(width = 2)
      ),
      br(),
      fluidRow(
        column(width = 2),
        column(width = 4,
               numericInput("BMI", "Body Mass Index (weight in kg/height in meters squared)", min = 20, max = 50, value = 30),
               bsTooltip("BMI", "Range: 20 - 50", "bottom", options = list(container = "body"))),
        column(width = 4,
               uiOutput("BMIPoint")),
        column(width = 2)
      ),
      br(),
      fluidRow(
        column(width = 2),
        column(width = 4,
               selectInput("COPD", "COPD/emphysema", choices = c("No", "Yes"))),
        column(width = 4,
               uiOutput("COPDPoint")),
        column(width = 2)
      ),
      br(),
      fluidRow(
        column(width = 2),
        column(width = 4,
               selectInput("Diabetes", "Diabetes", choices = c("No", "Yes"))),
        column(width = 4,
               uiOutput("DiabetesPoint")),
        column(width = 2)
      ),
      br(),
      fluidRow(
        column(width = 2),
        column(width = 4,
               selectInput("Hypertension", "Hypertension", choices = c("No", "Yes"))),
        column(width = 4,
               uiOutput("HypertensionPoint")),
        column(width = 2)
      ),
      br(),
      fluidRow(
        column(width = 2),
        column(width = 4,
               selectInput("CAD", "Coronary artery disease", choices = c("No", "Yes"))),
        column(width = 4,
               uiOutput("CADPoint")),
        column(width = 2)
      ),
      br(),
      fluidRow(
        column(width = 2),
        column(width = 4,
               selectInput("HF", "Heart failure", choices = c("No", "Yes"))),
        column(width = 4,
               uiOutput("HFPoint")),
        column(width = 2)
      ),
      br(),
      fluidRow(
        column(width = 2),
        column(width = 4,
               selectInput("TH", "Transplant history", choices = c("No", "Yes"))),
        column(width = 4,
               uiOutput("THPoint")),
        column(width = 2)
      ),
      br(),
      fluidRow(
        column(width = 2),
        column(width = 4,
               selectInput("MS", "Multiple sclerosis", choices = c("No", "Yes"))),
        column(width = 4,
               uiOutput("MSPoint")),
        column(width = 2)
      ),
      br(),
      fluidRow(
        column(width = 2),
        column(width = 4,
               selectInput("ID", "Immunosuppressive disease", choices = c("No", "Yes")),
               HTML(paste("Please follow", a("this link", href="https://www.qualityindicators.ahrq.gov/Downloads/Modules/PSI/V60-ICD10/TechSpecs/PSI_Appendix_I.pdf", target="_blank"), 
"for a list of immunosuppressive diseases"))),
        column(width = 4,
               uiOutput("IDPoint")),
        column(width = 2)
      ),
      br(),
      fluidRow(
        column(width = 2),
        column(width = 4,
               selectInput("IT", "Immunosuppressive treatment", choices = c("No", "Yes")),
               bsTooltip("IT", "This refers to systemic immunosuppressants only; if only topical steroids are used, for example, check No.", "bottom", options = list(container = "body")),
               a(id = "toggleIT", "Show/hide Immunosuppressive Medications"),
               shinyjs::hidden(
                 div(id = "ITdetail",
                     HTML('<table class="table table-bordered table-hover table-condensed">
                            <tbody><tr>
                            <td>Abatacept</td>
                            <td>Actemra</td>
                            <td>Adalimumab</td>
                            <td>Afinitor</td>
                            </tr>
                            <tr>
                            <td>A-Hydrocort</td>
                            <td>A-Methapred</td>
                            <td>Anakinra</td>
                            <td>Arava</td>
                            </tr>
                            <tr>
                            <td>Aristocort</td>
                            <td>Aristospan</td>
                            <td>Asmalpred</td>
                            <td>Astagraf XL</td>
                            </tr>
                            <tr>
                            <td>Azasan</td>
                            <td>Azathioprine</td>
                            <td>Basiliximab</td>
                            <td>Beclomethasone</td>
                            </tr>
                            <tr>
                            <td>Belimumab</td>
                            <td>Benlysta</td>
                            <td>Betamethasone</td>
                            <td>Brodalumab</td>
                            </tr>
                            <tr>
                            <td>Bubbli-Pred</td>
                            <td>Budesonide</td>
                            <td>Celestone</td>
                            <td>CellCept</td>
                            </tr>
                            <tr>
                            <td>Certolizumab</td>
                            <td>Cimzia</td>
                            <td>Cortef</td>
                            <td>Cortisone</td>
                            </tr>
                            <tr>
                            <td>Cosentyx</td>
                            <td>CPC-Cort-D</td>
                            <td>Cyclosprine</td>
                            <td>Daclizumab</td>
                            </tr>
                            <tr>
                            <td>Decadron</td>
                            <td>Deflazacort</td>
                            <td>Deltasone</td>
                            <td>Depo-Medrol</td>
                            </tr>
                            <tr>
                            <td>Dexacen</td>
                            <td>Dexamethasone</td>
                            <td>Dexone</td>
                            <td>Dexpak</td>
                            </tr>
                            <tr>
                            <td>Enbrel</td>
                            <td>Entocort EC</td>
                            <td>Entyvio</td>
                            <td>Envarsus XR</td>
                            </tr>
                            <tr>
                            <td>Etanercept</td>
                            <td>Everolimus</td>
                            <td>Flo-Pred</td>
                            <td>Florinef</td>
                            </tr>
                            <tr>
                            <td>Fludrocortisone</td>
                            <td>Golimumab</td>
                            <td>Guselkumab</td>
                            <td>Humira</td>
                            </tr>
                            <tr>
                            <td>Hydrocortisone</td>
                            <td>Hydrocortone</td>
                            <td>Imuran</td>
                            <td>Infliximab</td>
                            </tr>
                            <tr>
                            <td>Ixekizumab</td>
                            <td>Kenaject</td>
                            <td>Kenalog</td>
                            <td>Kineret</td>
                            </tr>
                            <tr>
                            <td>Leflunomide</td>
                            <td>Medrol</td>
                            <td>Meprolone</td>
                            <td>Methotrexate</td>
                            </tr>
                            <tr>
                            <td>Methylpred</td>
                            <td>Methylprednisolone</td>
                            <td>Meticorten</td>
                            <td>Millipred</td>
                            </tr>
                            <tr>
                            <td>Mycophenolate</td>
                            <td>Myfortic</td>
                            <td>Natalizumab</td>
                            <td>Neoral</td>
                            </tr>
                            <tr>
                            <td>Orapred</td>
                            <td>Orencia</td>
                            <td>Pediapred</td>
                            <td>Predicort</td>
                            </tr>
                            <tr>
                            <td>Prednisolone</td>
                            <td>Prednisone</td>
                            <td>Prelone</td>
                            <td>Prograf</td>
                            </tr>
                            <tr>
                            <td>Rapamune</td>
                            <td>Rayos</td>
                            <td>Remicade</td>
                            <td>Risankizumab-rzaa</td>
                            </tr>
                            <tr>
                            <td>Rituxan</td>
                            <td>Rituximab</td>
                            <td>Sandimmune</td>
                            <td>SangCya</td>
                            </tr>
                            <tr>
                            <td>Secukinumab</td>
                            <td>Skyrizi</td>
                            <td>Siliq</td>
                            <td>Simponi</td>
                            </tr>
                            <tr>
                            <td>Simulect</td>
                            <td>Sirolimus</td>
                            <td>Stelara</td>
                            <td>Sterapred</td>
                            </tr>
                            <tr>
                            <td>Tacrolimus</td>
                            <td>Taltz</td>
                            <td>Tocilizumab</td>
                            <td>Tofacitinib</td>
                            </tr>
                            <tr>
                            <td>Tremfya</td>
                            <td>Triamcinolone</td>
                            <td>Triesence</td>
                            <td>Tysabri</td>
                            </tr>
                            <tr>
                            <td>Ustekinumab</td>
                            <td>Vedolizumab</td>
                            <td>Veripred</td>
                            <td>Xeljanz</td>
                            </tr>
                            <tr>
                            <td>Zema</td>
                            <td>Zinbryta</td>
                            <td>Zortress </td>
                            <td> </td>
                            </tr>
                            </tbody></table>')
                 )
               )),
        column(width = 4,
               uiOutput("ITPoint")),
        column(width = 2)
      ),
      br(),
      fluidRow(
        column(width = 2),
        column(width = 4,
               selectInput("Steroids", "Steroids", choices = c("No", "Yes")),
               bsTooltip("st", "This refers to systemic - oral, IV, inhaled; not nasal or topical.", "bottom", options = list(container = "body")),
               a(id = "toggleST", "Show/hide Steroids Medications"),
               shinyjs::hidden(
                 div(id = "STdetail",
                     HTML('<table class="table table-bordered table-hover table-condensed">
                           <tbody><tr>
                           <td>A-Hydrocort</td>
                           <td>A-Methapred</td>
                           <td>Advair</td>
                           <td>Aristocort</td>
                           </tr>
                           <tr>
                           <td>Aristospan</td>
                           <td>Asmalpred</td>
                           <td>Beclomethasone</td>
                           <td>Betamethasone</td>
                           </tr>
                           <tr>
                           <td>Bubbli-Pred</td>
                           <td>Celestone</td>
                           <td>Cortef</td>
                           <td>Cortisone</td>
                           </tr>
                           <tr>
                           <td>CPC-Cort-D</td>
                           <td>Decadron</td>
                           <td>Deflazacort</td>
                           <td>Deltasone</td>
                           </tr>
                           <tr>
                           <td>Depo-Medrol</td>
                           <td>Dexacen</td>
                           <td>Dexamethasone</td>
                           <td>Dexone</td>
                           </tr>
                           <tr>
                           <td>Dexpak</td>
                           <td>Flo-Pred</td>
                           <td>Florinef</td>
                           <td>Fludrocortisone</td>
                           </tr>
                           <tr>
                           <td>Fluticasone propionate</td>
                           <td>Hydrocortisone</td>
                           <td>Hydrocortone</td>
                           <td>Kenaject</td>
                           </tr>
                           <tr>
                           <td>Kenalog</td>
                           <td>Medrol</td>
                           <td>Meprolone</td>
                           <td>Methylpred</td>
                           </tr>
                           <tr>
                           <td>Methylprednisolone</td>
                           <td>Meticorten</td>
                           <td>Millipred</td>
                           <td>Orapred</td>
                           </tr>
                           <tr>
                           <td>Pediapred</td>
                           <td>Predicort</td>
                           <td>Prednisolone</td>
                           <td>Prednisone</td>
                           </tr>
                           <tr>
                           <td>Prelone</td>
                           <td>Rayos</td>
                           <td>Sterapred</td>
                           <td>Triamcinolone</td>
                           </tr>
                           <tr>
                           <td>Triesence</td>
                           <td>Veripred</td>
                           <td>Zema</td>
                           <td> </td>
                           </tr>
                           </tbody></table>')
                 )
               )),
        column(width = 4,
               uiOutput("SteroidsPoint")),
        column(width = 2)
      ),
      br(),
      fluidRow(
        column(width = 2),
        column(width = 4,
               selectInput("Carvedilol", "Carvedilol", choices = c("No", "Yes"))),
        column(width = 4,
               uiOutput("CarvedilolPoint")),
        column(width = 2)
      ),
      br(),
      fluidRow(
        column(width = 2),
        column(width = 4,
               selectInput("ACE", "ACE inhibitor", choices = c("No", "Yes")),
               a(id = "toggleACE", "Show/hide ACE Inhibitor Medications"),
               shinyjs::hidden(
                 div(id = "ACEdetail",
                     HTML('<table class="table table-bordered table-hover table-condensed">
                            <tbody><tr>
                            <td>Accupril </td>
                            <td>Accuretic</td>
                            <td>Aceon</td>
                            <td>Altace</td>
                            </tr>
                            <tr>
                            <td>Benazepril</td>
                            <td>Capoten</td>
                            <td>Capozide</td>
                            <td>Captopril</td>
                            </tr>
                            <tr>
                            <td>Enalapril</td>
                            <td>Fosinopril</td>
                            <td>Lexxel</td>
                            <td>Lisinopril</td>
                            </tr>
                            <tr>
                            <td>Lotensin</td>
                            <td>Lotrel</td>
                            <td>Mavik</td>
                            <td>Moexipril</td>
                            </tr>
                            <tr>
                            <td>Monopril</td>
                            <td>Perindopril</td>
                            <td>Prestalia</td>
                            <td>Prinvil</td>
                            </tr>
                            <tr>
                            <td>Prinzide</td>
                            <td>Quinapril</td>
                            <td>Quinaretic</td>
                            <td>Ramipril</td>
                            </tr>
                            <tr>
                            <td>Tarka</td>
                            <td>Trandolapril</td>
                            <td>Uniretic</td>
                            <td>Univasc</td>
                            </tr>
                            <tr>
                            <td>Vaseretic</td>
                            <td>Vasotec</td>
                            <td>Zestoretic</td>
                            <td>Zestril</td>
                            </tr>
                            </tbody></table>')
                 )
               )),
        column(width = 4,
               uiOutput("ACEPoint")),
        column(width = 2)
      )
    ),
    wellPanel(
      fluidRow(
        column(width = 6,
               h4("Total Points", style="color:darkred")),
        column(width = 5,
               uiOutput("TotalPoint")),
        column(width = 1)),
      fluidRow(
        column(width = 6,
               h4("Probability of severe COVID-19 within 2 weeks of testing positive for COVID-19*", style="color:darkred"),
               p("*Based on the 0.15 probability cutoff described in manuscript. Low or High refers to below or above, respectively, the proposed threshold for vaccine eligibility.")),
        column(width = 5,
               uiOutput("PredictRisk")),
        column(width = 1))
    ),
br(),
wellPanel(
  h3('Click Below for Calculator and Author Contact Information'),
  p(
    "Kattan, Michael W. PhD; Ji, Xinge MS; Milinovich, Alex BA; Adegboye, Janet MD; Duggal, Abhijit MD; Dweik, Raed MD; Khouli, Hassan MD; Gordon, Steve MD; Young, James B. MD; Jehi, Lara MD. ",
    a(
      "An Algorithm for Classifying Patients Most Likely to Develop Severe Coronavirus Disease 2019 Illness. ",
      href = "https://journals.lww.com/ccejournal/Fulltext/2020/12000/An_Algorithm_for_Classifying_Patients_Most_Likely.24.aspx"
    ),
    "Critical Care Explorations: December 2020 - Volume 2 - Issue 12 - p e0300.  doi: 10.1097/CCE.0000000000000300"
  )
),
wellPanel(
  h3('Disclaimer'),
  p(
    "No Medical Advice. ALTHOUGH SOME CONTENT MAY BE PROVIDED BY INDIVIDUALS IN THE MEDICAL PROFESSION, YOU ACKNOWLEDGE THAT PROVISION OF SUCH CONTENT DOES NOT CREATE A MEDICAL PROFESSIONAL-PATIENT RELATIONSHIP AND DOES NOT CONSTITUTE AN OPINION, MEDICAL ADVICE, PROFESSIONAL DIAGNOSIS, SERVICE OR TREATMENT OF ANY CONDITION. Access to general information is provided for educational purposes only, through this site and links to other sites. Content is not recommended or endorsed by any doctor or healthcare provider. The information and Content provided are not substitutes for medical or professional care, and you should not use the information in place of a visit, call, consultation or the advice of your physician or other healthcare provider. You are liable or responsible for any advice, course of treatment, diagnosis or any other information, services or product obtained through this site."
  )
),
p(
  a(
    "Homepage",
    href = "../",
    style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
  ),
  " | ",
  a(
    "Website Error Messages",
    href = "javascript:myFunction()",
    style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
  ),
  " | ",
  a("Add to phone (iOS Safari)", href="https://support.apple.com/guide/iphone/bookmark-favorite-webpages-iph42ab2f3a7/ios#iph4f9a47bbc", target="_blank", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
  " | ", 
  a("Add to phone (Android)", href="https://www.cnet.com/tech/mobile/adding-one-touch-bookmarks-to-your-androids-home-screen/", target="_blank", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
  " | ",
  a("Source Code", 
    href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/SevereCOVID19", 
    style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
  ),
  style = "text-align: center;"
),
div(
  img(src = '../logo-ccf.png', style = "max-width:50%; max-height:100%;"),
  style = "text-align:center;display:block;"
)
)

# Define server
server <- function(input, output) {
  shinyjs::onclick("toggleIT",
                   shinyjs::toggle(id = "ITdetail", anim = TRUE)) 
  shinyjs::onclick("toggleST",
                   shinyjs::toggle(id = "STdetail", anim = TRUE)) 
  shinyjs::onclick("toggleACE",
                   shinyjs::toggle(id = "ACEdetail", anim = TRUE))
  
  data = reactive({
    age = input$Age
    age_point = 0.063204423 * age - 
      1.1677205e-05 * max(age - 24.740788, 0)**3 + 2.1561191e-05 * 
      max(age - 49.779448, 0)**3 - 9.8839853e-06 * max(age - 79.360793, 0)**3
    age_point = 100 / (3.757518 - 1.264088) * (age_point - 1.264088)
    gender = input$Gender
    gender_point = ifelse(gender == "Male", 26, 0)
    race = input$Race
    race_point = ifelse(race == "Asian", 39,
                        ifelse(race == "Black", 26,
                               ifelse(race == "White", 20, 0)))
    MedianIncome = input$MedianIncome
    income_point = - 0.009388391 * MedianIncome + 
      1.824143e-06 * max(MedianIncome - 26.224, 0)**3 - 
      3.0598322e-06 * max(MedianIncome - 55.192, 0)**3 + 
      1.2356892e-06 * max(MedianIncome - 97.955, 0)**3
    income_point = (14.0268438 - 0) / (-0.1643615 - -0.5141109) * (income_point - -0.5141109)
    BMI = input$BMI
    bmi_point = - 0.083503337 * BMI + 
      0.0010354943 * max(BMI - 24.511568, 0)**3 - 
      0.001626246 * max(BMI - 28.693878, 0)**3 + 
      0.00059075177 * max(BMI - 36.024803, 0)**3
    bmi_point = (47.821819 - 0) / (-1.145125 - -2.337528) * (bmi_point - -2.337528)
    copd = input$COPD
    copd_point = ifelse(copd == "No", 0, 7)
    diabetes = input$Diabetes
    diabetes_point = ifelse(diabetes == "No", 0, 20)
    hf = input$HF
    hf_point = ifelse(hf == "No", 0, 11)
    cad = input$CAD
    cad_point = ifelse(cad == "No", 0, 3)    
    hypertension = input$Hypertension
    hypertension_point = ifelse(hypertension == "No", 0, 10)
    th = input$TH
    th_point = ifelse(th == "No", 0, 29)
    ms = input$MS
    ms_point = ifelse(ms == "No", 0, 23)
    id = input$ID
    id_point = ifelse(id == "No", 0, 11)
    it = input$IT
    it_point = ifelse(it == "No", 0, 13)
    steroids = input$Steroids
    steroids_point = ifelse(steroids == "No", 0, 10)
    carvedilol = input$Carvedilol
    carvedilol_point = ifelse(carvedilol == "No", 16, 0)
    ace = input$ACE
    ace_point = ifelse(ace == "No", 7, 0)
    list(age_point = age_point,
         gender_point = gender_point,
         race_point = race_point,
         income_point = income_point,
         bmi_point = bmi_point,
         copd_point = copd_point,
         diabetes_point = diabetes_point,
         hf_point = hf_point,
         cad_point = cad_point,
         hypertension_point = hypertension_point,
         th_point = th_point,
         ms_point = ms_point,
         id_point = id_point,
         it_point = it_point,
         steroids_point = steroids_point,
         carvedilol_point = carvedilol_point,
         ace_point = ace_point,
         total_point = round(age_point) + round(gender_point) + 
           round(race_point) + round(income_point) + round(bmi_point) + 
           round(copd_point) + round(diabetes_point) + round(hf_point) + 
           round(cad_point) + round(hypertension_point) + round(th_point) + 
           round(ms_point) + round(id_point) + round(it_point) + 
           round(steroids_point) + round(carvedilol_point) + round(ace_point)
    )
  })
  output$AgePoint = renderUI({
    res = data()
    shiny::validate(
      need(input$Age>=20&input$Age<=85, "Range of Age: 20 - 85")
    )
    HTML(paste("<h4>", round(res$age_point), "Points</h4>"))
  })
  
  output$GenderPoint = renderUI({
    res = data()
    HTML(paste("<h4>", round(res$gender_point), "Points</h4>"))
  })
  
  output$RacePoint = renderUI({
    res = data()
    HTML(paste("<h4>", round(res$race_point), "Points</h4>"))
  })
  
  output$IncomePoint = renderUI({
    res = data()
    shiny::validate(
      need(input$BMI>=20&input$BMI<=50, "Rance of BMI: 20 - 50")
    )
    HTML(paste("<h4>", round(res$income_point), "Points</h4>"))
  })
  
  output$BMIPoint = renderUI({
    res = data()
    shiny::validate(
      need(input$MedianIncome>=0&input$MedianIncome<=260, "Range of Household Income ($,000): 0 - 260")
    )
    HTML(paste("<h4>", round(res$bmi_point), "Points</h4>"))
  })
  
  output$COPDPoint = renderUI({
    res = data()
    HTML(paste("<h4>", round(res$copd_point), "Points</h4>"))
  })
  
  output$DiabetesPoint = renderUI({
    res = data()
    HTML(paste("<h4>", round(res$diabetes_point), "Points</h4>"))
  })
  
  output$HypertensionPoint = renderUI({
    res = data()
    HTML(paste("<h4>", round(res$hypertension_point), "Points</h4>"))
  })
  
  output$CADPoint = renderUI({
    res = data()
    HTML(paste("<h4>", round(res$cad_point), "Points</h4>"))
  })
  
  output$HFPoint = renderUI({
    res = data()
    HTML(paste("<h4>", round(res$hf_point), "Points</h4>"))
  })
  
  output$THPoint = renderUI({
    res = data()
    HTML(paste("<h4>", round(res$th_point), "Points</h4>"))
  })
  
  output$MSPoint = renderUI({
    res = data()
    HTML(paste("<h4>", round(res$ms_point), "Points</h4>"))
  })
  
  output$IDPoint = renderUI({
    res = data()
    HTML(paste("<h4>", round(res$id_point), "Points</h4>"))
  })
  
  output$ITPoint = renderUI({
    res = data()
    HTML(paste("<h4>", round(res$it_point), "Points</h4>"))
  })
  
  output$SteroidsPoint = renderUI({
    res = data()
    HTML(paste("<h4>", round(res$steroids_point), "Points</h4>"))
  })
  
  output$CarvedilolPoint = renderUI({
    res = data()
    HTML(paste("<h4>", round(res$carvedilol_point), "Points</h4>"))
  })
  
  output$ACEPoint = renderUI({
    res = data()
    HTML(paste("<h4>", round(res$ace_point), "Points</h4>"))
  })
  
  output$TotalPoint = renderUI({
    res = data()
    shiny::validate(
      need(input$Age>=20&input$Age<=85, "Range of Age: 20 - 85"),
      need(input$BMI>=20&input$BMI<=50, "Rance of BMI: 20 - 50"),
      need(input$MedianIncome>=0&input$MedianIncome<=260, "Range of Household Income ($,000): 0 - 260")
    )
    HTML(paste('<h4 style="color:darkred">', res$total_point, "Points</h4>"))
  })
  
  output$PredictRisk = renderUI({
    res = data()
    shiny::validate(
      need(input$Age>=20&input$Age<=85, "Range of Age: 20 - 85"),
      need(input$BMI>=20&input$BMI<=50, "Rance of BMI: 20 - 50"),
      need(input$MedianIncome>=0&input$MedianIncome<=260, "Range of Household Income ($,000): 0 - 260")
    )
    # pred = (4 - -4) / (341.46849 - -21.03685) * (res$total_point - -21.03685) - 4
    # pred = 1 - surv(14, pred)
    if (res$total_point < 186) {
      HTML('<h4 style="color:darkred">4% LOW</h4>')
    } else {
      HTML('<h4 style="color:darkred">21% HIGH</h4>')
    }
    
  })

}

# Run the application 
shinyApp(ui = ui, server = server)
