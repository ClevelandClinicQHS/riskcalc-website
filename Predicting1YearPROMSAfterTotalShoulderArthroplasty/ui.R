# ui side

library(shiny)
library(shinythemes)


navbarPage(theme = shinytheme("cerulean"), 
           title = p("Patient-Reported Outcomes Calculator for TSA Patients ",
                     
                     
                       a("Source Code", 
                         href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/Predicting1YearPROMSAfterTotalShoulderArthroplasty", 
                         style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 10px;color: #2c3e50;font-weight: bold;text-align:right;display:inline-block;text-decoration: underline;")
                     , style = 'font-size:32px; text-align: left'),
           
           navlistPanel(id = 'mainPage',
                        
                        'Patient information',
                        
                        tabPanel(title = 'Directions',
                                 span('Directions:', 
                                      style = 'font-size:28px'),
                                 HTML('<br><br>'),
                                 span("Fill in all information as accurately as possible. The Patient-Reported Outcomes prediction at the top of the 'Patient Outcome' page reflect the current configuration of the questions on all pages. These will be updated in real-time as answers are changed.",
                                      style = 'font-size:16px'),
                                 HTML('<br><br>'),
                                 
                                 #Button to go to start app
                                 actionButton(inputId = 'start',
                                              label = 'Start')
                                 
                        ),
                        tabPanel(title = 'Patient Information',
                                 value = 'demographics',
                                 
                                 sliderInput(inputId = 'age',
                                             label = span('What is your current age (in years)?', 
                                                          style = 'font-size:16px'),
                                             min = 0,
                                             max = 100,
                                             value = 20,
                                             step = 1),
                                 
                                 #Inputting patient demographics
                                 selectInput(inputId = 'gender',
                                             label = span('What is your gender?', 
                                                          style = 'font-size:16px'),
                                             choices = c("F", "M")),
                                 
                                 selectInput(inputId = 'race',
                                             label = span('What is your race?', 
                                                          style = 'font-size:16px'),
                                             choices = c("White", "Black", "Other")),
                                 
                                 
                                 span('Height',
                                      style = 'font-size:16px'),
                                 fluidRow(
                                   column(2,
                                          numericInput(inputId = 'feet', 
                                                       label = 'feet', 
                                                       value = 5,
                                                       min = 4,
                                                       max = 9)),
                                   column(2,
                                          numericInput(inputId = 'inches', 
                                                       label = 'inches', 
                                                       value = 0,
                                                       min = 0,
                                                       max = 11))
                                 ),
                                 numericInput(inputId = 'weight',
                                              label = span('Weight (lbs.)', style = 'font-size:16px'),
                                              value = 150,
                                              min = 50,
                                              max = 1000),
                                 
                                 numericInput(inputId = 'cci',
                                              label = span('Charlson Comorbidity Index', style = 'font-size:16px'),
                                              value = 0,
                                              min = 0,
                                              max = 37),
                                 
                                 selectInput(inputId = 'smoking',
                                             label = span('What is your smoking status?', 
                                                          style = 'font-size:16px'),
                                             choices = c("Never", "Quit", "Current")),
                                 
                                 sliderInput(inputId = 'education',
                                             label = span('Years of Education', 
                                                          style = 'font-size:16px'),
                                             min = 0,
                                             max = 20,
                                             value = 0,
                                             step = 1),
                                 
                                 sliderInput(inputId = 'adi',
                                             label = span('Area Deprivation Index', 
                                                          style = 'font-size:16px'),
                                             min = 1,
                                             max = 100,
                                             value = 1,
                                             step = 1),
                                 
                                 selectInput(inputId = 'insurance',
                                             label = span('Insurance Status', 
                                                          style = 'font-size:16px'),
                                             choices = c("Commercial", "Medicaid", "Medicare", "BWC")),
                                 
                                 sliderInput(inputId = 'mcs0',
                                             label = span('Mental Component Score', 
                                                          style = 'font-size:16px'),
                                             min = 0,
                                             max = 100,
                                             value = 0,
                                             step = 1),
                                 
                                 selectInput(inputId = 'psydx',
                                             label = span('Psychiatric Diagnosis', 
                                                          style = 'font-size:16px'),
                                             choices = c("No", "Yes")),
                                 
                                 selectInput(inputId = 'opioid',
                                             label = span('Opioid', 
                                                          style = 'font-size:16px'),
                                             choices = c("None in 12mo", "Yes within 3mo", "Yes but not within 3mo")),
                                 
                                 selectInput(inputId = 'chronicpain',
                                             label = span('Chronic Pain', 
                                                          style = 'font-size:16px'),
                                             choices = c("No", "Yes")),
                                 
                                 selectInput(inputId = 'priorsurgery',
                                             label = span('Prior Surgery', 
                                                          style = 'font-size:16px'),
                                             choices = c("No", "Yes")),
                                 
                                 selectInput(inputId = 'dximplant',
                                             label = span('Diagnosis Implant', 
                                                          style = 'font-size:16px'),
                                             choices = c("OA-Reverse", "CTA-Reverse", "OA-Standard")),
                                 
                                 selectInput(inputId = 'gbl',
                                             label = span('Glenoid Bone Loss', 
                                                          style = 'font-size:16px'),
                                             choices = c("No", "Yes")),
                                 
                                 selectInput(inputId = 'hcomp',
                                             label = span('Humeral Component', 
                                                          style = 'font-size:16px'),
                                             choices = c("Uncemented", "Cemented")),
                                 
                                 
                                 selectInput(inputId = 'sprotatorcuff',
                                             label = span('Superior-Posterior Cuff Repair', 
                                                          style = 'font-size:16px'),
                                             choices = c("No", "Yes")),
                                 
                                 
                                 #Button to go to next page
                                 actionButton(inputId = 'nextPage1',
                                              label = 'Next')
                        ),
                        
                        #Outcomes information
                        tabPanel(title = 'Patient Outcome',
                                 value = 'PRO',
                                 
                                 fluidPage(
                                   tags$head(
                                     tags$style(HTML(
                                       "#currentPreds{
                                          font-size: 16px;
                                       }
                                       "
                                     ))
                                   ),
                                   tableOutput(outputId = 'currentPreds')
                                 ),
                                
                                 
                                 
                                 #Ask for current score. If they don't have it, give them survey
                                 
                                                       tabPanel(title = 'PSS',
                                                                
                                                                #PAIN
                                                                radioButtons(inputId = 'havePSS',
                                                                             label = span("Do you know the patient's current PSS Total score?",
                                                                                          style = 'font-size:16px'),
                                                                             choices = c('Yes', 'No'),
                                                                             inline = TRUE),
                                                                
                                                                #If they have PSS, do this.....
                                                                conditionalPanel(condition = "input.havePSS == 'Yes'",
                                                                                 sliderInput(inputId = 'inputPSS',
                                                                                             label = span('Current PSS Total score:',
                                                                                                          style = 'font-size:16px'),
                                                                                             value = 0,
                                                                                             min = 0,
                                                                                             max = 100)
                                                                ),
                                                                
                                                                #If they don't have PSS, fill out survey...
                                                                conditionalPanel(condition = "input.havePSS == 'No'",
                                                                                 
                                                                                 #Title
                                                                                 span('PSS Total',
                                                                                      style = 'font-size:24px'),
                                                                                 
                                                                                 HTML('<br><br>'),
                                                                                 
                                                                                 span("Part I: Pain & Satisfaction: Please circle the number closest to your level of pain or satisfaction",
                                                                                      style = 'font-size:20px'),
                                                                                 HTML('<br><br>'),
                                                                                 
                                                                                 #Questions
                                                                                 radioButtons(inputId = 'PSS_Q1',
                                                                                              label = span('Pain at rest with your arm by your side:',
                                                                                                           style = 'font-size:16px'),
                                                                                              choices = c('Worst (0)' = 0,
                                                                                                          '1' = 1,
                                                                                                          '2' = 2,
                                                                                                          '3' = 3,
                                                                                                          '4' = 4,
                                                                                                          '5' = 5,
                                                                                                          '6' = 6,
                                                                                                          '7' = 7,
                                                                                                          '8' = 8,
                                                                                                          '9' = 9,
                                                                                                          'None (10)' = 10),
                                                                                              inline = TRUE,
                                                                                              selected = ''),
                                                                                 
                                                                                 radioButtons(inputId = 'PSS_Q2',
                                                                                              label = span('Pain with normal activities (eating, dressing, bathing):',
                                                                                                           style = 'font-size:16px'),
                                                                                              choices = c('Worst (0)' = 0,
                                                                                                          '1' = 1,
                                                                                                          '2' = 2,
                                                                                                          '3' = 3,
                                                                                                          '4' = 4,
                                                                                                          '5' = 5,
                                                                                                          '6' = 6,
                                                                                                          '7' = 7,
                                                                                                          '8' = 8,
                                                                                                          '9' = 9,
                                                                                                          'None (10)' = 10),
                                                                                              inline = TRUE,
                                                                                              selected = ''),
                                                                                 
                                                                                 radioButtons(inputId = 'PSS_Q3',
                                                                                              label = span('Pain with strenuous activities (reaching, lifting, pushing, pulling, throwing):',
                                                                                                           style = 'font-size:16px'),
                                                                                              choices = c('Worst (0)' = 0,
                                                                                                          '1' = 1,
                                                                                                          '2' = 2,
                                                                                                          '3' = 3,
                                                                                                          '4' = 4,
                                                                                                          '5' = 5,
                                                                                                          '6' = 6,
                                                                                                          '7' = 7,
                                                                                                          '8' = 8,
                                                                                                          '9' = 9,
                                                                                                          'None (10)' = 10),
                                                                                              inline = TRUE,
                                                                                              selected = ''),
                                                                                 
                                                                                 radioButtons(inputId = 'PSS_Q4',
                                                                                              label = span('How satisfied are you with the current level of function of your shoulder?',
                                                                                                           style = 'font-size:16px'),
                                                                                              choices = c('Least (0)' = 0,
                                                                                                          '1' = 1,
                                                                                                          '2' = 2,
                                                                                                          '3' = 3,
                                                                                                          '4' = 4,
                                                                                                          '5' = 5,
                                                                                                          '6' = 6,
                                                                                                          '7' = 7,
                                                                                                          '8' = 8,
                                                                                                          '9' = 9,
                                                                                                          'Most (10)' = 10),
                                                                                              inline = TRUE,
                                                                                              selected = ''),
                                                                                 
                                                                                 HTML('<br>'),
                                                                                 
                                                                                 #Survey directions 
                                                                                 span("Part II: Function: Please circle the number that best describes the level of difficulty you might have performing each activity.",
                                                                                      style = 'font-size:20px'),
                                                                                 HTML('<br><br>'),
                                                                                 
                                                                                 pssQuestion(inputId = 'PSS_Q5',
                                                                                              label = 'Reach the small of your back to tuck in your shirt with your hand.'),
                                                                                 pssQuestion(inputId = 'PSS_Q6',
                                                                                              label = 'Wash the middle of your back/hook bra.'),
                                                                                 pssQuestion(inputId = 'PSS_Q7',
                                                                                              label = 'Perform necessary toileting activities.'),
                                                                                 pssQuestion(inputId = 'PSS_Q8',
                                                                                              label = 'Wash the back of opposite shoulder.'),
                                                                                 pssQuestion(inputId = 'PSS_Q9',
                                                                                              label = 'Comb hair.'),
                                                                                 pssQuestion(inputId = 'PSS_Q10',
                                                                                              label = 'Place hand behind head with elbow held straight out to the side.'),
                                                                                 pssQuestion(inputId = 'PSS_Q11',
                                                                                              label = 'Dress self (including put on coat and pull shirt of overhead).'),
                                                                                 pssQuestion(inputId = 'PSS_Q12',
                                                                                              label = 'Sleep on affected side.'),
                                                                                 pssQuestion(inputId = 'PSS_Q13',
                                                                                             label = 'Open a door with affected side.'),
                                                                                 pssQuestion(inputId = 'PSS_Q14',
                                                                                             label = 'Carry a bag of groceries with affected arm.'),
                                                                                 pssQuestion(inputId = 'PSS_Q15',
                                                                                             label = 'Carry a briefcase/small suitcase with affected arm.'),
                                                                                 pssQuestion(inputId = 'PSS_Q16',
                                                                                             label = 'Place a soup can (1-2 lbs.) on a shelf at shoulder level without bending elbow.'),
                                                                                 pssQuestion(inputId = 'PSS_Q17',
                                                                                             label = 'Place a one gallon container (8-10 lbs.) on a shelf at shoulder level without bending elbow.'),
                                                                                 pssQuestion(inputId = 'PSS_Q18',
                                                                                             label = 'Reach a shelf above your head without bending your elbow.'),
                                                                                 pssQuestion(inputId = 'PSS_Q19',
                                                                                             label = 'Place a soup can (1-2 lbs.) on a shelf overhead without bending your elbow.'),
                                                                                 pssQuestion(inputId = 'PSS_Q20',
                                                                                             label = 'Place a one gallon container (8-10 lbs.) on a shelf overhead without bending your elbow'),
                                                                                 pssQuestion(inputId = 'PSS_Q21',
                                                                                             label = 'Perform usual sport/hobby.'),
                                                                                 pssQuestion(inputId = 'PSS_Q22',
                                                                                             label = 'Perform household chores (cleaning, laundry, cooking).'),
                                                                                 pssQuestion(inputId = 'PSS_Q23',
                                                                                             label = 'Throw overhand/swim/overhead racquet sports.'),
                                                                                 pssQuestion(inputId = 'PSS_Q24',
                                                                                             label = 'Work full-time at your regular job.'),
                                                                                 
                                                                                 #Calulate PSS score
                                                                                 span(textOutput(outputId = 'pssCalculated'), 
                                                                                      style = 'font-size:20px')
                                                                                 
                                                                )
                                                       
                                                       
                                            )
                                            )
                                            )
                                 )