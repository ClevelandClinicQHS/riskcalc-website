library(dplyr)
library(lubridate)
library(tidyverse)

# Outcome - NOT give top box rating
fit1 = expression({
    lp = -1.6604732 - 0.0024088845 * Age + 
        7.3749191e-06 * max(Age - 38, 0)**3 - 
        2.0281028e-05 * max(Age - 66, 0)**3 + 
        1.2906108e-05 * max(Age - 82, 0)**3 - 
        0.0093902032 * (Gender == "MALE") - 
        0.005739776 * (Race == "BLACK RACE") +
        0.099555065 * (Race == "CAUCASIAN") -
        0.017536383 * (Race == "OTHER") +
        0.25276695 * (Ethnicity == "NOT HISPANIC OR LATINO") +
        0.52810013 * (Ethnicity == "UNKNOWN") +
        0.17934869 * (MaritalStatus == "DIVORCED STATE") +
        0.20762519 * (MaritalStatus == "DOMESTIC PARTNER") +
        0.18323951 * (MaritalStatus == "OTHER") +
        0.26001598 * (MaritalStatus == "UNMARRIED PERSON") +
        0.21224089 * (MaritalStatus == "WIDOW") -
        0.065053833 * (Education == "4+ YRS COLLEGE") -
        0.10836136 * (Education == "8TH GRADE OR LESS") -
        0.084511956 * (Education == "HIGH SCHOOL GRAD") +
        0.10114555 * (Education == "OTHER") -
        0.026881606 * (Education == "SOME COLLEGE") -
        0.14966095 * (Education == "SOME HIGH SCHOOL") +
        0.05273433 * (Language == "OTHER") -
        0.18704222 * (Language == "SPANISH") +
        0.080317896 * (Religion == "CATHOLIC") +
        0.12940363 * (Religion == "CHRISTIAN") +
        0.29155948 * (Religion == "JEWISH") +
        0.15581073 * (Religion == "LUTHERAN") +
        0.070279422 * (Religion == "METHODIST") +
        0.17532147 * (Religion == "NONE") +
        0.12514971 * (Religion == "OTHER") +
        0.17238752 * (Religion == "PROTESTANT") +
        0.46298751 * (AdmissionType == "EMERGENCY ADMISSION") +
        0.47650167 * (AdmissionType == "GENERAL OUTPATIENT") +
        0.33976473 * (AdmissionType == "HOSPITAL ADMISSION, URGENT, 48HR") +
        0.44088239 * (AdmissionType == "INPATIENT") +
        0.21139552 * (AdmissionType == "OTHER") -
        0.053762676 * (AdmissionWeek == "MON.") +
        0.092136431 * (AdmissionWeek == "SAT.") +
        0.12763562 * (AdmissionWeek == "SUN.") -
        0.027627949 * (AdmissionWeek == "THU.") -
        0.066674006 * (AdmissionWeek == "TUE.") -
        0.056990156 * (AdmissionWeek == "WED.") -
        0.0033743284 * AdmissionHour +
        5.2551659e-05 * max(AdmissionHour - 4, 0)**3 -
        0.00011167228 * max(AdmissionHour - 13, 0)**3 +
        5.9120616e-05 * max(AdmissionHour - 21, 0)**3
    1/(1+exp(-lp))

})


server <- function(input, output) {
    
    getData <- reactive({
        
        inFile <- input$file1
        
        if (is.null(input$file1))
            return(NULL)
        
        read.csv(inFile$datapath, header=TRUE, sep=input$sep, quote=input$quote, colClasses = "character")
        
    })
    
    observeEvent(input$file1,{
        inFile<<-getData()
    })
    
    
    make_prediction <- reactive({
        if(is.null(input$file1)) return(NULL)
        data = getData()

        new_data = data %>% 
            mutate(
                AdmissionTime = ymd_hms(HSP_ADMIT_DTTM),
                Age = trunc(as.numeric(difftime(HSP_ADMIT_DTTM, PAT_DOB, units = "days")) / 365.25), # updated on 8/25
                AdmissionWeek = wday(AdmissionTime),
                AdmissionWeek = AdmissionWeek %>%
                                    factor %>%
                                    fct_recode(
                                        "SUN." = "1",
                                        "MON." = "2",
                                        "TUE." = "3",
                                        "WED." = "4",
                                        "THU." = "5",
                                        "FRI." = "6",
                                        "SAT." = "7"
                                    ),
                AdmissionHour = as.numeric(hour(AdmissionTime)),
                Gender = GENDER_DESC,
                Race = PAT_RACE_DESC,
                Ethnicity = PAT_ETHNIC_GROUP_DESC,
                MaritalStatus = PAT_MARITAL_STS_DESC,
                Education = EDUCATION_DESC,
                Language = PAT_LANG_DESC,
                Religion = PAT_RELIGION_DESC,
                AdmissionType = HSP_ADMIT_TYPE_DESC)
        
        new_data = new_data %>% # handle potential missing data
            # age - cannot be missing
            # ad week - cannot be missing
            # ad hour - cannot be missing
            # gender - cannot be missing
            # race - other
            # ethnicity - unknown
            # marital status - other
            # education - other
            # language - other
            # religion - other
            # admission type - other
            mutate(Race = ifelse(is.na(Race), "OTHER", Race),
                   Ethnicity = ifelse(is.na(Ethnicity), "UNKNOWN", Ethnicity),
                   MaritalStatus = ifelse(is.na(MaritalStatus), "OTHER", MaritalStatus),
                   Education = ifelse(is.na(Education), "OTHER", Education),
                   Language = ifelse(is.na(Language), "OTHER", Language),
                   Religion = ifelse(is.na(Religion), "OTHER", Religion),
                   AdmissionType = ifelse(is.na(AdmissionType), "OTHER", AdmissionType))
        # calculate prob
        if (nrow(new_data) > 0) {
            new_data$Predicted.Prob = sapply(1:nrow(new_data), function(x) eval(fit1, envir = new_data[x,]))
            # assign grouping
            new_data$Predicted.Group = ifelse(new_data$Predicted.Prob >= 0.25, "NOT TOP BOX", "TOP BOX")
            new_data$TimeStamp = Sys.time()
        } else {
            new_data$Predicted.Prob = numeric()
            new_data$Predicted.Group = numeric()
            new_data$TimeStamp = Sys.time()
        }
        new_data %>% select(-AdmissionTime,-Gender,-Race,-Ethnicity,-MaritalStatus,
                            -Education,-Language,-Religion,-AdmissionType)
        
    })
    
    output$downloadData <- downloadHandler(
        
        filename = function() { 
            paste0('ORIExpPrediction_', Sys.time(),'.csv')
        },
        
        content = function(file) {
            
            write.csv(make_prediction(), file, row.names = FALSE)
            
        })
    
}