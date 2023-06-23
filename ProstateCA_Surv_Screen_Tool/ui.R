shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel(h1("Prostate Cancer Survival Risk Calculator")),
  
  # Sidebar
  sidebarPanel(
    h3("Risk Factors"),
    sliderInput('AGEDX', "Age", min=43, max=77, value=68),
    selectInput('maritalstat', "Marital Status", choices = c("Married", "Unmarried", "Widowed")),
    selectInput('employstat', "Employment Status", choices = c("Employed", "Unemployed", "Retired")),
    selectInput('SMOKER', "Current Smoker", choices = c("No", "Yes")),
    sliderInput('BMI', "Body Mass Index (BMI)", min=12, max=60, value=25),
    sliderInput('CHOLESTEROL', "Cholesterol", min=80, max=400, value=210),
    sliderInput('prepsa', "PSA", min=0.4, max=61, value=1),
    selectInput('allGleason', "Biopsy Gleason Primary + Secondary", choices=c("3+3", "3+4", "4+4", "4+5", "5+4", "5+5")),
    selectInput('cStage', "Clinical Stage", choices = c("T1A", "T1B", "T1C", "T2A", "T2B", "T2C", "T3A", "T3B", "T3C")),
    sliderInput('fCancer', "Percent Cancer in Biopsy Cores (%)", min=0, max=100, value=50),
    selectInput('wwHormtx', "Neoadjuvant Hormones", choices = c("No", "Yes")),
    selectInput('BLADDERCA', "Bladder Cancer", choices = c("No", "Yes")),
    selectInput('ANGINA', "Angina", choices = c("No", "Yes")),
    selectInput('CABG', "CABG", choices = c("No", "Yes")),
    h5("Charlson Comorbidity Scoring"),
    checkboxInput('MI', "Myocardial Infarction", FALSE),
    checkboxInput('CHF', "Congestive Heart Failure", FALSE),
    checkboxInput('PVOD', "Peripheral Disease", FALSE),
    checkboxInput('CVA', "Cerebrovascular Disease", FALSE),
    checkboxInput('DEMENTIA', "Dementia", FALSE),
    checkboxInput('COPD', "COPD", FALSE),
    checkboxInput('COLLVASC', "Connective Tissue Disease", FALSE),
    checkboxInput('ULCER', "Peptic Ulcer Disease", FALSE),
    checkboxInput('MILDLIVER', "Mild Liver Disease", FALSE),
    checkboxInput('DIABETES', "Diabetes without End-Organ Damage", FALSE),
    checkboxInput('HEMIPLEGIA', "Hemiplegia", FALSE),
    checkboxInput('MODSEVRENAL', "Moderate/Severe Renal Disease", FALSE),
    checkboxInput('DIABENDORGAN', "Diabetes with End-Organ Damage", FALSE),
    checkboxInput('OTHERTUMOR', "Tumor without Metastasis", FALSE),
    checkboxInput('LEUKEMIA', "Leukemia", FALSE),
    checkboxInput('LYMPHOMA', "Lymphoma", FALSE),
    checkboxInput('MODSEVLIVER', "Moderate/Severe Liver Disease", FALSE),
    checkboxInput('METASTATIC', "Metastatic Solid Tumor", FALSE),
    checkboxInput('AIDS', "AIDS", FALSE)
  ),
  mainPanel(
    h4(textOutput("surv.text")),
    h4(textOutput("rp.text")),
    h4(textOutput("ww.text")),
    plotOutput("pred.plot", height = 600),
    h1('Reference'),
    p('[1] Cowen ME, Halasyamani LK, Kattan MW.', a(href = 'Predicting life expectancy in men with clinically localized prostate cancer.', 'http://www.sciencedirect.com/science/article/pii/S0022534705000182'), 'J Urol. 2006 Jan;175(1):99-103.'),
    p('[2] Stephenson AJ, Kattan MW, Eastham JA, Bianco FJ Jr, Yossepowitch O, Vickers AJ, Klein EA, Wood DP, Scardino PT.', a(href ='https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3651598/', 'Prostate cancer-specific mortality after radical prostatectomy for patients treated in the prostate-specific antigen era.'), 'J Clin Oncol. 2009 Sep 10;27(26):4300-4305 '),
    p('[3] Kattan MW, Cuzick J, Fisher G, Berney DM, Oliver T, Foster CS, Moller H, Reuter V, Fearn P, Eastham J, Scardino PT. Transatlantic Prostate Group.', a(href = 'http://onlinelibrary.wiley.com/doi/10.1002/cncr.23106/abstract;jsessionid=3A103AEBC7F7B227585F6F20DA93BDA2.f02t03', 'Nomogram incorporating PSA level to predict cancer-specific survival for men with clinically localized prostate cancer managed without curative intent.'), 'Cancer. 2008 Jan 1;112(1):69-74.')
  )
))