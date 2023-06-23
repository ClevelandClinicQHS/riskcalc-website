
        require(shinythemes)
        fluidPage(theme = shinytheme("flatly"),
        tags$head(tags$style(
            HTML('
                 #sidebar {
                    overflow-y:scroll; height: 90vh; position:relative;
                 }')
        )),
        titlePanel('Chronic Kidney Disease - Graft Survival at 5-Years and eGFR at 1-Year using Pre-Transplant Information'),
        sidebarLayout(
            sidebarPanel(id = "sidebar"
        ,
selectInput('IMMyco', 'Mycophenolate Mofetil Used?', choices = c('No', 'Yes')),
selectInput('IMAza', 'Azathioprine Used?', choices = c('No', 'Yes')),
selectInput('IMCalci', 'Calcineurin Inhibitor Used?', choices = c('No', 'Yes')),
selectInput('Diaggrpc', 'Cause of Renal Failure', choices = c('Glomerulonephritis', 'Other', 'Retransplant', 'Diabetes')),
selectInput('IMDeple', 'Depleting Antibodies Used?', choices = c('No', 'Yes')),
textInput('DonAge', 'Donor Age (Years)', placeholder = '30 - 60'),
textInput('DonBMI', 'Donor BMI (kg/m2)', placeholder = '20 - 40'),
textInput('DonCreat', 'Donor Creatinine (mg/dL) (mg/dL)', placeholder = '0.1 - 2'),
selectInput('DonGender', 'Donor Gender', choices = c('Male', 'Female')),
selectInput('DonRaceCat', 'Donor Race', choices = c('Caucasian', 'African-American', 'Other')),
selectInput('IMIL2', 'IL2 Receptor Antibodies Used?', choices = c('No', 'Yes')),
selectInput('DonProcec', 'Nephrectomy Type', choices = c('Open', 'Laparoscopic')),
selectInput('IMRapa', 'Rapamycin (Sirolimus) Used?', choices = c('No', 'Yes')),
textInput('AgeYr', 'Recipient Age (Years)', placeholder = '30 - 90'),
textInput('BMI', 'Recipient BMI (kg/m2)', placeholder = '15 - 50'),
selectInput('Gender', 'Recipient Gender', choices = c('Male', 'Female')),
textInput('HLAMis', 'Recipient HLA Mismatch Level', placeholder = '0 - 6'),
selectInput('RaceCat', 'Recipient Race', choices = c('Caucasian', 'African-American', 'Other'))),
mainPanel(
actionButton("goButton", "Run Calculator"),
br(),
hr(),
dataTableOutput('result'),
br(),
wellPanel(h3('Reference'),p("[1] Tiong HY, Goldfarb DA, Kattan MW, Alster JM, Thuita L, Yu C, Wee A, Poggio ED. ",a('Nomograms for predicting graft function and survival in living donor kidney transplantation based on the UNOS Registry', href='http://www.sciencedirect.com/science/article/pii/S0022534708030127'),". J Urol. 2009 Mar;181(3):1248-55. doi: 10.1016/j.juro.2008.10.164. Epub 2009 Jan 23")),
img(src='../CC_c.jpg', style = "max-width:50%; max-height:100%;"))))