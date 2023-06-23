library(shiny)
ui <- fluidPage(
    fluidPage(
        titlePanel("ORI Experience Risk Calculator (Pilot Study)"),
        fluidRow(
            column(4,
                   wellPanel(
                       h4("Upload your data"),
                   fileInput('file1', 'Choose CSV File',
                             accept=c('text/csv', 
                                      'text/comma-separated-values,text/plain', 
                                      '.csv')),
                   tags$hr(),
                   radioButtons('sep', 'Separator',
                                c(Comma=',',
                                  Semicolon=';',
                                  Tab='\t'),
                                ','),
                   radioButtons('quote', 'Quote',
                                c(None='',
                                  'Double Quote'='"',
                                  'Single Quote'="'"),
                                '"')
                   ),
                   wellPanel(
                       h4("Download data with prediction"),
                       downloadButton('downloadData', 'Download')
                   )
            ),
            column(8,
                   wellPanel(
                       h3("Instruction"),
                       p("The uploaded file must have the following columns (headers are case sensitive): "),
                       p("HSP_ADMIT_DTTM (format example: 2012-05-31 14:14:00)"),
                       p("PAT_DOB (format example: 1964-06-24)"),
                       p("GENDER_DESC (MALE/FEMALE)"),
                       p("PAT_RACE_DESC (ASIANS/BLACK RACE/CAUCASIAN/OTHER)"),
                       p("PAT_ETHNIC_GROUP_DESC (HISPANIC AMERICANS/NOT HISPANIC OR LATINO/UNKNOWN)"),
                       p("PAT_MARITAL_STS_DESC (CURRENTLY MARRIED/DIVORCED STATE/DOMESTIC PARTNER/OTHER/UNMARRIED PERSON/WIDOW)"),
                       p("EDUCATION_DESC (4-YR COLL. GRAD./4+ YRS COLLEGE/8TH GRADE OR LESS/HIGH SCHOOL GRAD/OTHER/SOME COLLEGE/SOME HIGH SCHOOL)"),
                       p("PAT_LANG_DESC (ENGLISH/OTHER/SPANISH)"),
                       p("PAT_RELIGION_DESC (BAPTIST/CATHOLIC/CHRISTIAN/JEWISH/LUTHERAN/METHODIST/NONE/OTHER/PROTESTANT)"),
                       p("HSP_ADMIT_TYPE_DESC (ELECTIVE/EMERGENCY ADMISSION/GENERAL OUTPATIENT/HOSPITAL ADMISSION, URGENT, 48HR/INPATIENT/OTHER)"),
                       hr(),
                       h5("Missing data for race, ethnicity, marital status, education, language, religion, admission type will be
                          treated as OTHER or UNKNOWN. If age, admission time, gender is missing, then prediction will be missing."),
                       h5("We don't store your data.")
                   )
            )
        )
    )
)
