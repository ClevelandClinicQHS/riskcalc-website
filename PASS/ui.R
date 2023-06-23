library(shiny)
library(shinyBS)
library(shinythemes)
library(shinyjs)
library(shinyWidgets)

fluidPage(
    shinyjs::useShinyjs(), 
    theme = shinytheme("flatly"),
    tags$head(tags$link(rel="shortcut icon", href="../assets/icons/favicon.ico", type="image/x-icon")),
    tags$head(tags$link(rel="apple-touch-icon", href="../assets/icons/apple-touch-icon.png", type="image/x-icon")),
    tags$hr(style="border: 2px solid #ffffff;"),
    tags$script(HTML(
        'function myFunction() {
  var txt;
  if (confirm("This is a mailbox for reporting website errors to programmers for the risk calculator website.  If you have questions or concerns about a specific calculator, please use the calculator Author Contact Information found on the publication for that calculator.  Each calculator is documented by a specific publication with a corresponding author.")) {
    window.open("mailto:rcalcsupport@ccf.org");
  }
}'
    )),
    tags$head(
        tags$style(HTML("
    .nav-tabs>li>a {
      background-color: #e7e7e7;
      color: #333;
      border: 1px solid #ccc; /* add a border */
      border-radius: 5px;
      font-weight: bold;
      padding: 10px 15px;
      margin-right: 5px;
    }
    
    .nav-tabs>li.active>a,
    .nav-tabs>li.active>a:focus,
    .nav-tabs>li.active>a:hover {
      background-color: #337ab7;
      color: #fff;
      border: 1px solid #337ab7; /* add a border */
    }
  "))
    ),
    
    titlePanel('Predict change in function score, pain score, and probability of PASS'),
    br(),
    sidebarLayout(
        sidebarPanel(
            tabsetPanel(
                tabPanel(
                    "Patient Entry",
                    br(),
                    # numericInput('baseline_pain', 'Pain Score', value = 50, min = 0, max = 100),
                    # bsPopover(id = "baseline_pain",title= "Baseline Pain Score", content = "Baseline pain score: 0-100", placement = "right", trigger = "hover", options = list(container = "body")),
                    # numericInput('baseline_func', 'Function Score', value = 50, min = 0, max = 100),
                    # bsPopover(id = "baseline_func",title= "Baseline Function Score", content = "Baseline function score: 0-100", placement = "right", trigger = "hover", options = list(container = "body")),
                    # numericInput('baseline_mcs', 'MCS Score', value = 50, min = 0, max = 100),
                    # bsPopover(id = "baseline_mcs",title= "Baseline MCS Score", content = "Baseline MCS score: 0-100", placement = "right", trigger = "hover", options = list(container = "body")),
                    radioGroupButtons(inputId = "metric",label = "Height and weight", choices = c("English", "Metric"),status = "info"),
                    conditionalPanel(
                        condition = "input.metric == 'English'",
                        numericInput('height_feet', 'Height (feet)', value = NA, min = 0, max = 10),
                        bsPopover(id = "height_feet",title= "Height (feet)", content = "Height feet part: 0-10", placement = "right", trigger = "hover", options = list(container = "body")),
                        numericInput('height_inch', 'Height (inch)', value = NA, min = 0, max = 12),
                        bsPopover(id = "height_inch",title= "Height (inch)", content = "Height inch part: 0-12", placement = "right", trigger = "hover", options = list(container = "body")),
                        numericInput('weight_pound', 'Weight (pound)', value = NA, min = 60, max = 500),
                        bsPopover(id = "weight_pound",title= "Weight (pound)", content = "Weight in pounds: 60-500", placement = "right", trigger = "hover", options = list(container = "body"))
                    ),
                    conditionalPanel(
                        condition = "input.metric == 'Metric'",
                        numericInput('height_cm', 'Height (cm)', value = NA, min = 80, max = 240),
                        bsPopover(id = "height_cm",title= "Height (cm)", content = "Height in cms: 80-240", placement = "right", trigger = "hover", options = list(container = "body")),
                        numericInput('weight_kg', 'Weight (kg)', value = NA, min = 30, max = 250),
                        bsPopover(id = "weight_kg",title= "Weight (kg)", content = "Weight in kgs: 30-250", placement = "right", trigger = "hover", options = list(container = "body"))
                    ),
                    numericInput('educ_yrs', 'Education (years)', value = NA, min = 5, max = 24),
                    bsPopover(id = "educ_yrs",title= "Education (years)", content = "Number of years of schooling completed starting from 1st grade.  For example, if you finished high school or through 12th grade, you would enter 12.  If you finished 4 years of college after high school, you would enter 16.  If you finished 2 years of graduate school after college, you would enter 18.", placement = "right", trigger = "hover", options = list(container = "body")),
                    radioGroupButtons(inputId = "insurancetype2",label = "Insurance type", choices = c("Medicare/Private", "Medicaid/Uninsured"),status = "info"),
                    radioGroupButtons(inputId = "gender",label = "Gender", choices = c("Female", "Male"),status = "info"),
                    #selectInput("insurancetype2", "Insurance type", selectize = F, choices = c("Medicare/Private", "Medicaid/Uninsured")),
                    #selectInput("gender", "Gender", selectize = F, choices = c("Female", "Male")),
                    # HTML('<p>For National ADI, please visit <a href="https://www.neighborhoodatlas.medicine.wisc.edu/mapping" target="_blank">here</a> to search for your address and find the value of national percentile</p>'),
                    # numericInput('ADI_national', 'National ADI', value = 80, min = 1, max = 100),
                    # bsPopover(id = "ADI_national",title= "National ADI", content = "National ADI: 1-100", placement = "right", trigger = "hover", options = list(container = "body"))
                    br(),
                    p("These questions ask for your view about your knee. This information will help us keep track of how you feel about your knee and how well you are able to perform your usual activities. Answer every question by selecting the appropriate response, only one response for each question. If you are unsure about how to answer a question, please give the best answer you can."),
                    radioGroupButtons(inputId = "pat0_koos_p1", status = "info", selected = character(0), label = "How often do you experience knee pain?", choiceNames = c("Never", "Monthly", "Weekly", "Daily", "Always"), size='sm', individual = TRUE, choiceValues = c(0,1,2,3,4)),
                    p("What amount of knee pain have experienced the last week during the following activities?"),
                    radioGroupButtons(inputId = "pat0_koos_p2", status = "info", selected = character(0), label = "Twisting / pivoting on your knee", choiceNames = c("None", "Mild", "Moderate", "Severe", "Extreme"), size='sm', individual = TRUE, choiceValues = c(0,1,2,3,4)),
                    radioGroupButtons(inputId = "pat0_koos_p3", status = "info", selected = character(0), label = "Straightening knee fully", choiceNames = c("None", "Mild", "Moderate", "Severe", "Extreme"), size='sm', individual = TRUE, choiceValues = c(0,1,2,3,4)),
                    radioGroupButtons(inputId = "pat0_koos_p4", status = "info", selected = character(0), label = "Bending knee fully", choiceNames = c("None", "Mild", "Moderate", "Severe", "Extreme"), size='sm', individual = TRUE, choiceValues = c(0,1,2,3,4)),
                    radioGroupButtons(inputId = "pat0_koos_p5", status = "info", selected = character(0), label = "Walking on flat surface", choiceNames = c("None", "Mild", "Moderate", "Severe", "Extreme"), size='sm', individual = TRUE, choiceValues = c(0,1,2,3,4)),
                    radioGroupButtons(inputId = "pat0_koos_p6", status = "info", selected = character(0), label = "Going up or down stairs", choiceNames = c("None", "Mild", "Moderate", "Severe", "Extreme"), size='sm', individual = TRUE, choiceValues = c(0,1,2,3,4)),
                    radioGroupButtons(inputId = "pat0_koos_p7", status = "info", selected = character(0), label = "At night while in bed", choiceNames = c("None", "Mild", "Moderate", "Severe", "Extreme"), size='sm', individual = TRUE, choiceValues = c(0,1,2,3,4)),
                    radioGroupButtons(inputId = "pat0_koos_p8", status = "info", selected = character(0), label = "Sitting or lying", choiceNames = c("None", "Mild", "Moderate", "Severe", "Extreme"), size='sm', individual = TRUE, choiceValues = c(0,1,2,3,4)),
                    radioGroupButtons(inputId = "pat0_koos_p9", status = "info", selected = character(0), label = "Standing upright", choiceNames = c("None", "Mild", "Moderate", "Severe", "Extreme"), size='sm', individual = TRUE, choiceValues = c(0,1,2,3,4)),
                    hr(),
                    HTML('The following questions concern your level of function in performing usual daily activities and higher level activities.  For each of the following activities, please indicate the degree of difficulty you have experienced in <strong><span style="text-decoration:underline">the last week</span></strong> due to your knee problem.'),
                    radioGroupButtons(inputId = "pat0_koosps_1", status = "info", selected = character(0), label = "Rising from bed", choiceNames = c("None", "Mild", "Moderate", "Severe", "Extreme"), size='sm', individual = TRUE, choiceValues = c(0,1,2,3,4)),
                    radioGroupButtons(inputId = "pat0_koosps_2", status = "info", selected = character(0), label = "Putting on socks/stockings", choiceNames = c("None", "Mild", "Moderate", "Severe", "Extreme"), size='sm', individual = TRUE, choiceValues = c(0,1,2,3,4)),
                    radioGroupButtons(inputId = "pat0_koosps_3", status = "info", selected = character(0), label = "Rising from sitting", choiceNames = c("None", "Mild", "Moderate", "Severe", "Extreme"), size='sm', individual = TRUE, choiceValues = c(0,1,2,3,4)),
                    radioGroupButtons(inputId = "pat0_koosps_4", status = "info", selected = character(0), label = "Bending to floor", choiceNames = c("None", "Mild", "Moderate", "Severe", "Extreme"), size='sm', individual = TRUE, choiceValues = c(0,1,2,3,4)),
                    radioGroupButtons(inputId = "pat0_koosps_5", status = "info", selected = character(0), label = "Twisting/pivoting on your injured knee", choiceNames = c("None", "Mild", "Moderate", "Severe", "Extreme"), size='sm', individual = TRUE, choiceValues = c(0,1,2,3,4)),
                    radioGroupButtons(inputId = "pat0_koosps_6", status = "info", selected = character(0), label = "Kneeling", choiceNames = c("None", "Mild", "Moderate", "Severe", "Extreme"), size='sm', individual = TRUE, choiceValues = c(0,1,2,3,4)),
                    radioGroupButtons(inputId = "pat0_koosps_7", status = "info", selected = character(0), label = "Squatting", choiceNames = c("None", "Mild", "Moderate", "Severe", "Extreme"), size='sm', individual = TRUE, choiceValues = c(0,1,2,3,4)),
                    hr(),
                    radioGroupButtons(inputId = "pat0_vr12_1", selected = character(0), status = "info", label = "In general, would you say your health is:", choiceNames = c("Excellent", "Very good", "Good", "Fair", "Poor"), size='sm', individual = TRUE, choiceValues = c(1,2,3,4,5)),
                    HTML('The following questions are about activities you might do <strong><span style="text-decoration:underline">during a typical day</span></strong>. Does your health now limit you in these activities? If so, how much?'),
                    radioGroupButtons(inputId = "pat0_vr12_2a", selected = character(0), status = "info", label = HTML("<strong>Moderate activities</strong>, such as moving a table, pushing a vacuum cleaner, bowling, or playing golf?"), choiceNames = c("Yes, limited a lot", "Yes, limited a little", "No, not limited at all"), size='sm', individual = TRUE, choiceValues = c(1,2,3)),
                    radioGroupButtons(inputId = "pat0_vr12_2b", selected = character(0), status = "info", label = HTML("Climbing <strong>several</strong> flights of stairs?"), choiceNames = c("Yes, limited a lot", "Yes, limited a little", "No, not limited at all"), size='sm', individual = TRUE, choiceValues = c(1,2,3)),
                    HTML('<strong><span style="text-decoration:underline">During the past 4 weeks</span></strong>, have you had any of the following problems with your work or other regular daily activities <strong>as a result of your physical health</strong>?'),
                    radioGroupButtons(inputId = "pat0_vr12_3a", selected = character(0), status = "info", label = HTML("<strong>Accomplished less</strong> than you would like."), choiceNames = c("No, none of the time", "Yes, a little of the time", "Yes, some of the time", "Yes, most of the time", "Yes, all of the time"), size='sm', individual = TRUE, choiceValues = c(1,2,3,4,5)),
                    radioGroupButtons(inputId = "pat0_vr12_3b", selected = character(0), status = "info", label = HTML("Were limited in the <strong>kind</strong> of work or other activities."), choiceNames = c("No, none of the time", "Yes, a little of the time", "Yes, some of the time", "Yes, most of the time", "Yes, all of the time"), size='sm', individual = TRUE, choiceValues = c(1,2,3,4,5)),
                    HTML('<strong><span style="text-decoration:underline">During the past 4 weeks</span></strong>, have you had any of the following problems with your work or other regular daily activities as a result of any emotional problems (such as feeling depressed or anxious)?'),
                    radioGroupButtons(inputId = "pat0_vr12_4a", selected = character(0), status = "info", label = HTML("<strong>Accomplished less</strong> than you would like."), choiceNames = c("No, none of the time", "Yes, a little of the time", "Yes, some of the time", "Yes, most of the time", "Yes, all of the time"), size='sm', individual = TRUE, choiceValues = c(1,2,3,4,5)),
                    radioGroupButtons(inputId = "pat0_vr12_4b", selected = character(0), status = "info", label = HTML("Didn't do work or other activities as <strong>carefully</strong> as usual."), choiceNames = c("No, none of the time", "Yes, a little of the time", "Yes, some of the time", "Yes, most of the time", "Yes, all of the time"), size='sm', individual = TRUE, choiceValues = c(1,2,3,4,5)),
                    radioGroupButtons(inputId = "pat0_vr12_5", selected = character(0), status = "info", label = HTML('<strong><span style="text-decoration:underline">During the past 4 weeks</span></strong>, how much did <strong>pain</strong> interfere with your normal work (including both work outside the home and house work)?'), choiceNames = c("Not at all", "A little bit", "Moderately", "Quite a bit", "Extremely"), size='sm', individual = TRUE, choiceValues = c(1,2,3,4,5)),
                    HTML('These questions are about how you feel and how things have been with you <strong><span style="text-decoration:underline">during the past 4 weeks</span></strong>. For each question, please give the one answer that comes closest to the way you have been feeling.<br><br>How much of the time <strong><span style="text-decoration:underline">during the past 4 weeks</span></strong>:'),
                    radioGroupButtons(inputId = "pat0_vr12_6a", selected = character(0), status = "info", label = HTML("Have you felt <strong>calm and peaceful</strong>?"), choiceNames = c("All of the time", "Most of the time", "A good bit of the time", "Some of the time", "A little of the time", "None of the time"), size='sm', individual = TRUE, choiceValues = c(1,2,3,4,5,6)),
                    radioGroupButtons(inputId = "pat0_vr12_6b", selected = character(0), status = "info", label = HTML("Did you have <strong>a lot of energy</strong>?"), choiceNames = c("All of the time", "Most of the time", "A good bit of the time", "Some of the time", "A little of the time", "None of the time"), size='sm', individual = TRUE, choiceValues = c(1,2,3,4,5,6)),
                    radioGroupButtons(inputId = "pat0_vr12_6c", selected = character(0), status = "info", label = HTML('Have you felt <strong>downhearted and blue</strong>?'), choiceNames = c("All of the time", "Most of the time", "A good bit of the time", "Some of the time", "A little of the time", "None of the time"), size='sm', individual = TRUE, choiceValues = c(1,2,3,4,5,6)),
                    radioGroupButtons(inputId = "pat0_vr12_7", selected = character(0), status = "info", label = HTML('<strong><span style="text-decoration:underline">During the past 4 weeks</span></strong>, how much of the time has your <strong>physical health or emotional problems</strong> interfered with your social activities (like visiting with friends, relatives, etc.)?'), choiceNames = c("All of the time", "Most of the time", "Some of the time", "A little of the time", "None of the time"), size='sm', individual = TRUE, choiceValues = c(1,2,3,4,5))
                ),
                tabPanel(
                    "Provider Entry",
                    br(),
                    textInput(inputId = "my_address", label = "Process Address Information"),
                    bsPopover(id = "my_address",title= "Address", content = "Street number and name, City, State, and ZIP code", placement = "right", trigger = "hover", options = list(container = "body")),
                    shiny::actionButton(inputId = "find_address", label = "Find Area Deprivation Index", class = "btn-info"),
                    textOutput("address_output"),
                    br(),
                    # selectInput("naveen_4level_mtp", "Cartilage status in the Medial Tibial Plateau (mark all the apply)", selectize = F, choices = c("Negligible", "Mild", "Moderate", "Severe")),
                    pickerInput("naveen_4level_mtp",
                                label = "Cartilage status in the Medial Tibial Plateau (mark all the apply; if more than one lesion, size should be the sum of all lesions)",
                                choices = list(`Normal or Grade 1 changes (cartilage signal abnormality without a defect)` = c("Normal or Grade 1 changes",""),
                                               `Grade 2 changes (low grade partial thickness loss (less than 50% of the cartilage thickness))` = c("Less than 1 cm in size", "1 cm or larger in size"),
                                               `Grade 3 changes (high grade partial thickness loss (50% or more of the cartilage thickness))` = c("Less 2 mm in size (fissure)", "2 mm to less than 1 cm in size (small)", "1 cm to less 2 cm in size (moderate)", "2 cm or larger in size (large)"),
                                               `Grade 4 changes (full thickness cartilage loss)` = c("Less than 1 cm in size (small)", "1 cm to less than 2 cm in size (moderate)", "2 cm or larger in size (large)")),
                                multiple = TRUE, options = list(style = "btn-info", "max-options-group" = 1)),
                    pickerInput("tearside",
                                label = "Tearside",
                                choices = c("Lateral", "Medial", "Both"), 
                                multiple = TRUE, options = list(style = "btn-info", "max-options-group" = 1))
                )
            )
        ),
        mainPanel(
            actionButton("goButton", "Run Calculator"),
            br(),
            hr(),
            tags$head(
                tags$style(type="text/css", "tfoot {display:none;}")
            ),
            div(id = "result_panel", 
                textOutput("baseline_output"),
                DT::dataTableOutput('result')),
                #plotOutput("plot", height = "200px")),
            br(),
            # wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] Wells BJ, Roth R, Nowacki AS, Arrigain S, Yu C, Rosenkrans WA, Jr, Kattan MW. ",
            #                                                                             a('Prediction of morbidity and mortality in patients with type 2 diabetes.', 
            #                                                                               href='https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3685323/'),
            #                                                                             " PeerJ. 2013;1:e87.")),
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
