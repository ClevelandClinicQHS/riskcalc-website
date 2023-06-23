#2018-04-26 user interface for 10-yr MOON outcomes risk calculator

#Using a 'fancy' shinytheme
navbarPage(theme = shinytheme("yeti"), 
           title = span("Projected 10-year outcomes after ACLR",
                        style = 'font-size:32px'),
          
           navlistPanel(id = 'mainPage',
                        
             'Patient information',
             
             tabPanel(title = 'Directions',
                      span('Directions:', 
                           style = 'font-size:28px'),
                      HTML('<br><br>'),
                      span("Fill in all information as accurately as possible. The 10-year predictions at the top of the 'Patient reported outcomes' page reflect the current configuration of the questions on all pages. These will be updated in real-time as answers are changed.",
                           style = 'font-size:16px'),
                      HTML('<br><br>'),
                      
                      #Button to go to start app
                      actionButton(inputId = 'start',
                                   label = 'Start')
                      
             ),
             tabPanel(title = 'Demographics',
                      value = 'demographics',
                      
                      #Inputting patient demographics
                      selectInput(inputId = 'gender',
                                  label = span('What is your gender?', 
                                               style = 'font-size:16px'),
                                  choices = X$Gender),
                      sliderInput(inputId = 'age',
                                  label = span('What is your current age (in years)?', 
                                               style = 'font-size:16px'),
                                  min = X$Age[1],
                                  max = X$Age[3],
                                  value = X$Age[2],
                                  step = 1),
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
                                   label = 'Weight (lbs.)',
                                   value = 150,
                                   min = 50,
                                   max = 1000),
                      
                      sliderInput(inputId = 'education',
                                  label = span('What is your education level? (in years)', 
                                               style = 'font-size:16px'),
                                  min = X$Education[1],
                                  max = X$Education[3],
                                  value = X$Education[2],
                                  step = 1),
                      selectInput(inputId = 'smoking',
                                  label = span('What is your current smoking status?',
                                               style = 'font-size:16px'),
                                  choices = X$SmokingStatus),
                      
                      #Button to go to next page
                      actionButton(inputId = 'nextPage1',
                                   label = 'Next')
                      ),
             
             #Information for current surgery
             tabPanel(title = 'Surgery information',
                      value = 'surgery',
                      
                      radioButtons(inputId = 'timePoint', 
                                   label = span('How long has it been since surgery?', style = 'font-size:16px'),
                                   choices = c("I haven't had surgery" = "None",
                                               "2 years" = "Two",
                                               "6 years" = "Six"),
                                   inline = TRUE),
                      selectInput(inputId = 'recon',
                                  label = span('Was this a primary or revision repair?',
                                               style = 'font-size:16px'),
                                  choices = X$ReconstructionType),
                      
                      #Surgical information
                      span('Pathology', 
                           style = 'font-size:24px;'),
                      selectInput(inputId = 'latPath',
                                  label = span('Lateral articular cartilage',
                                               style = 'font-size:16px'),
                                  choices = X$ACLateralPathology),
                      selectInput(inputId = 'medPath',
                                  label = span('Medial articular cartilage',
                                               style = 'font-size:16px'),
                                  choices = X$ACMedialPathology),
                      selectInput(inputId = 'pfPath',
                                  label = span('Patellofemoral articular cartilage',
                                               style = 'font-size:16px'),
                                  choices = X$ACPatellofemoralPathology),
                      selectInput(inputId = 'latFracPath',
                                  label = span('Lateral fracture articular cartilage',
                                               style = 'font-size:16px'),
                                  choices = X$ACLateralFracturePathology),
                      selectInput(inputId = 'latMenPath',
                                  label = span('Lateral meniscal pathology',
                                               style = 'font-size:16px'),
                                  choices = X$LateralMeniscalPathology),
                      
                      #Other stuff
                      span('Other details', 
                           style = 'font-size:24px;'),
                      selectInput(inputId = 'graft',
                                  label = span('What type of graft did you receive?', 
                                               style = 'font-size:16px'),
                                  choices = X$GraftType),
                      selectInput(inputId = 'laxity',
                                  label = span('High-grade laxity?',
                                               style = 'font-size:16px'),
                                  choices = X$HighGradeLaxity),
                      selectInput(inputId = 'exposure',
                                  label = span('Surgical exposure',
                                               style = 'font-size:16px'),
                                  choices = X$SurgicalExposure),
                      selectInput(inputId = 'fixation',
                                  label = span('Tibial fixation',
                                               style = 'font-size:16px'),
                                  choices = X$TibialFixation),
                      
                      
                      #Only show these if they are at a later time-point
                      conditionalPanel(condition = "input.timePoint != 'None'",
                                       selectInput(inputId = 'subCL',
                                                   label = span('Have you had an additional surgery on your contralateral (non-surgical) knee since the initial surgery?',
                                                                style = 'font-size:16px'),
                                                   choices = X$SubsequentSurgeryContralateral1),
                                       selectInput(inputId = 'subIL',
                                                   label = span('Have you had an additional surgery on your ipsilateral (surgical) knee since the initial surgery?',
                                                                style = 'font-size:16px'),
                                                   choices = X$SubsequentSurgeryIpsilateral1)),
                      #Button to go to next page
                      actionButton(inputId = 'nextPage2',
                                   label = 'Next')
                      
                      ),
             
             #Information for sports/prior surgeries
             tabPanel(title = 'Other risk factors',
                      value = 'riskFactors',
                      
                      
                      span('Sports', 
                           style = 'font-size:24px'),
                      selectInput(inputId = 'sport',
                                  label = span('What was your sport of injury?',
                                               style = 'font-size:16px'),
                                  choices = X$Sport),
                      selectInput(inputId = 'competition',
                                  label = span('What was your highest competition level?', 
                                               style = 'font-size:16px'),
                                  choices = X$CompetitionLevel),
                      
                      #Surgical history
                      span('Surgical history', 
                           style = 'font-size:24px'),
                      selectInput(inputId = 'prevMed',
                                  label = span('Have you had a previous medial meniscus surgery?',
                                               style = 'font-size:16px'),
                                  choices = X$PreviousMedialMeniscusSurgery),
                      selectInput(inputId = 'prevACLR',
                                  label = span('Did you have a previous ACL repair on your contralateral (non-surgical) knee?',
                                               style = 'font-size:16px'),
                                  choices = X$PreviousACLRContralateralKnee),
                      selectInput(inputId = 'prevIL',
                                  label = span('Have you previously had surgery on your ipsilateral (surgical) knee?',
                                               style = 'font-size:16px'),
                                  choices = X$PreviousILKneeSurgery),
                      
                      #Button to go to next page
                      actionButton(inputId = 'nextPage3',
                                   label = 'Next')
             ),
             
             #Outcomes information
             tabPanel(title = 'Patient reported outcomes',
                      value = 'PRO',
                      
                      checkboxGroupInput(inputId = 'selectedPROs',
                                         label = span('Display 10-year prediction for:',
                                                      style = 'font-size:28px'),
                                         choices = c('ADL', 'QOL', 'PAIN', 'SAR', 'SYMP', 'IKDC', 'MARX'),
                                         inline = TRUE),
                      
                      tableOutput(outputId = 'currentPreds'),


                      #Ask for current score. If they don't have it, give them survey
                      navbarPage(theme = shinytheme('yeti'),
                                 title = NULL,
                                 navbarMenu(title = 'KOOS',
                                            tabPanel(title = 'ADL',
                                                     
                                                     #ADL
                                                     radioButtons(inputId = 'haveADL',
                                                                  label = span('Do you know your current KOOS ADL score?',
                                                                               style = 'font-size:16px'),
                                                                  choices = c('Yes', 'No'),
                                                                  inline = TRUE),
                                                     
                                                     #If they have ADL, do this.....
                                                     conditionalPanel(condition = "input.haveADL == 'Yes'",
                                                                      sliderInput(inputId = 'inputADL',
                                                                                  label = span('Current ADL:',
                                                                                               style = 'font-size:16px'),
                                                                                  value = X$ADL[2],
                                                                                  min = 0,
                                                                                  max = 100)
                                                                      ),
                                                     
                                                     #If they don't have ADL, fill out survey...
                                                     conditionalPanel(condition = "input.haveADL == 'No'",
                                                                      
                                                                      #Title
                                                                      span('Function, daily living',
                                                                           style = 'font-size:24px'),
                                                                      HTML('<br>'),
                                                                      
                                                                      #Survey directions 
                                                                      span("The following questions concern your physical function. By this we mean your ability to move around and to look after yourself. For each of the following activities please indicate the degree of difficulty you have experienced in the last week due to your knee.",
                                                                           style = 'font-size:20px'),
                                                                      
                                                                      HTML('<br><br>'),
                                                                      
                                                                      #Survey questions
                                                                      adlQuestion(inputId = 'ADL_Q1',
                                                                                  label = 'Descending stairs'),
                                                                      adlQuestion(inputId = 'ADL_Q2',
                                                                                  label = 'Ascending stairs'),
                                                                      adlQuestion(inputId = 'ADL_Q3',
                                                                                  label = 'Rising from sitting'),
                                                                      adlQuestion(inputId = 'ADL_Q4',
                                                                                  label = 'Standing'),
                                                                      adlQuestion(inputId = 'ADL_Q5',
                                                                                  label = 'Bending to floor/pick up an object'),
                                                                      adlQuestion(inputId = 'ADL_Q6',
                                                                                  label = 'Walking on flat surface'),
                                                                      adlQuestion(inputId = 'ADL_Q7',
                                                                                  label = 'Getting in/out of car'),
                                                                      adlQuestion(inputId = 'ADL_Q8',
                                                                                  label = 'Going shopping'),
                                                                      adlQuestion(inputId = 'ADL_Q9',
                                                                                  label = 'Putting on socks/stockings'),
                                                                      adlQuestion(inputId = 'ADL_Q10',
                                                                                  label = 'Rising from bed'),
                                                                      adlQuestion(inputId = 'ADL_Q11',
                                                                                  label = 'Taking off socks/stockings'),
                                                                      adlQuestion(inputId = 'ADL_Q12',
                                                                                  label = 'Lying in bed (turning over, maintaining knee position)'),
                                                                      adlQuestion(inputId = 'ADL_Q13',
                                                                                  label = 'Getting in/out of bath'),
                                                                      adlQuestion(inputId = 'ADL_Q14',
                                                                                  label = 'Sitting'),
                                                                      adlQuestion(inputId = 'ADL_Q15',
                                                                                  label = 'Getting on/off toilet'),
                                                                      adlQuestion(inputId = 'ADL_Q16',
                                                                                  label = 'Heavy domestic duties (moving heavy boxes, scrubbing floors, etc.)'),
                                                                      adlQuestion(inputId = 'ADL_Q17',
                                                                                  label = 'Light domestic duties (cooking, dusting, etc.)'),
                                                                      
                                                                      #Calulate ADL score
                                                                      span(textOutput(outputId = 'adlCalculated'), 
                                                                           style = 'font-size:20px')
                                                                      )
                                                     
                                                     ),
                                            
                                            #Quality of life
                                            tabPanel(title = 'KR-QOL',
                                                     
                                                     #QOL
                                                     radioButtons(inputId = 'haveQOL',
                                                                  label = span('Do you know your current knee-related quality of life score?',
                                                                               style = 'font-size:16px'),
                                                                  choices = c('Yes', 'No'),
                                                                  inline = TRUE),
                                                     
                                                     #If they have QOL, do this.....
                                                     conditionalPanel(condition = "input.haveQOL == 'Yes'",
                                                                      sliderInput(inputId = 'inputQOL',
                                                                                  label = span('Current knee-related quality of life:',
                                                                                               style = 'font-size:16px'),
                                                                                  value = X$QOL[2],
                                                                                  min = 0,
                                                                                  max = 100)
                                                                     ),
                                                     #If they don't have ADL, fill out survey...
                                                     conditionalPanel(condition = "input.haveQOL == 'No'",
                                                                      
                                                                      #Title
                                                                      span('Quality of life',
                                                                           style = 'font-size:24px'),
                                                                      
                                                                      HTML('<br><br>'),
                                                                      
                                                                      #Questions
                                                                      qolQuestion(inputId = 'QOL_Q1',
                                                                                  label = 'How often are you aware of your knee problem?',
                                                                                  choices = c('Never' = 0,
                                                                                              'Monthly' = 1,
                                                                                              'Weekly' = 2,
                                                                                              'Daily' = 3,
                                                                                              'Constantly' = 4)),
                                                                      qolQuestion(inputId = 'QOL_Q2',
                                                                                  label = 'Have you modified your life style to avoid potentially damaging activities?',
                                                                                  choices = c('Not at all' = 0,
                                                                                              'Mildly' = 1,
                                                                                              'Moderately' = 2,
                                                                                              'Severely' = 3,
                                                                                              'Totally' = 4)),
                                                                      qolQuestion(inputId = 'QOL_Q3',
                                                                                  label = 'How much are you troubled with lack of confidence in your knee?',
                                                                                  choices = c('Not at all' = 0,
                                                                                              'Mildly' = 1,
                                                                                              'Moderately' = 2,
                                                                                              'Severely' = 3,
                                                                                              'Totally' = 4)),
                                                                      qolQuestion(inputId = 'QOL_Q4',
                                                                                  label = 'In general, how much difficulty do you have with your knee?',
                                                                                  choices = c('None' = 0,
                                                                                              'Mild' = 1,
                                                                                              'Moderate' = 2,
                                                                                              'Severe' = 3,
                                                                                              'Extreme' = 4)),
                                                                      
                                                                      #Calulate QOL score
                                                                      span(textOutput(outputId = 'qolCalculated'), 
                                                                           style = 'font-size:20px')
                                                                      )
                                                     
                                                     ),
                                            tabPanel(title = 'Pain',
                                                     
                                                     #PAIN
                                                     radioButtons(inputId = 'havePAIN',
                                                                  label = span('Do you know your current KOOS Pain score?',
                                                                               style = 'font-size:16px'),
                                                                  choices = c('Yes', 'No'),
                                                                  inline = TRUE),
                                                     
                                                     #If they have Pain, do this.....
                                                     conditionalPanel(condition = "input.havePAIN == 'Yes'",
                                                                      sliderInput(inputId = 'inputPAIN',
                                                                                  label = span('Current pain score:',
                                                                                               style = 'font-size:16px'),
                                                                                  value = X$Pain[2],
                                                                                  min = 0,
                                                                                  max = 100)
                                                     ),
                                                     
                                                     #If they don't have Pain, fill out survey...
                                                     conditionalPanel(condition = "input.havePAIN == 'No'",
                                                                      
                                                                      #Title
                                                                      span('Pain',
                                                                           style = 'font-size:24px'),
                                                                      
                                                                      HTML('<br><br>'),
                                                                      
                                                                      #Questions
                                                                      radioButtons(inputId = 'PAIN_Q1',
                                                                                   label = span('How often do you experience knee pain?',
                                                                                                style = 'font-size:16px'),
                                                                                   choices = c('Never' = 0,
                                                                                               'Monthly' = 1,
                                                                                               'Weekly' = 2,
                                                                                               'Daily' = 3,
                                                                                               'Constantly' = 4),
                                                                                   inline = TRUE,
                                                                                   selected = ''),
                                                                      
                                                                      HTML('<br>'),
                                                                      
                                                                      #Survey directions 
                                                                      span("What amount of knee pain have you experienced the last week during the following activities?",
                                                                           style = 'font-size:20px'),
                                                                      HTML('<br><br>'),
                                                                      
                                                                      painQuestion(inputId = 'PAIN_Q2',
                                                                                  label = 'Twisting/pivoting on your knee'),
                                                                      painQuestion(inputId = 'PAIN_Q3',
                                                                                   label = 'Straightening knee fully'),
                                                                      painQuestion(inputId = 'PAIN_Q4',
                                                                                   label = 'Bending knee fully'),
                                                                      painQuestion(inputId = 'PAIN_Q5',
                                                                                   label = 'Walking on flat surface'),
                                                                      painQuestion(inputId = 'PAIN_Q6',
                                                                                   label = 'Going up or down stairs'),
                                                                      painQuestion(inputId = 'PAIN_Q7',
                                                                                   label = 'At night while in bed'),
                                                                      painQuestion(inputId = 'PAIN_Q8',
                                                                                   label = 'Sitting or lying'),
                                                                      painQuestion(inputId = 'PAIN_Q9',
                                                                                   label = 'Standing upright'),
                                                                      
                                                                      #Calulate Pain score
                                                                      span(textOutput(outputId = 'painCalculated'), 
                                                                           style = 'font-size:20px')
                                                                      
                                                                      )
                                                     ),
                                            tabPanel(title = 'Sports & rec',
                                                     
                                                     #SAR
                                                     radioButtons(inputId = 'haveSAR',
                                                                  label = span('Do you know your current KOOS Sports & recreation score?',
                                                                               style = 'font-size:16px'),
                                                                  choices = c('Yes', 'No'),
                                                                  inline = TRUE),
                                                     
                                                     #If they have SAR, do this.....
                                                     conditionalPanel(condition = "input.haveSAR == 'Yes'",
                                                                      sliderInput(inputId = 'inputSAR',
                                                                                  label = span('Current sports and rec score:',
                                                                                               style = 'font-size:16px'),
                                                                                  value = X$SAR[2],
                                                                                  min = 0,
                                                                                  max = 100)
                                                     ),
                                                     
                                                     #If they don't have SAR, fill out survey...
                                                     conditionalPanel(condition = "input.haveSAR == 'No'",
                                                                      
                                                                      #Title
                                                                      span('Function, sports and recreational activities',
                                                                           style = 'font-size:24px'),
                                                                      
                                                                      HTML('<br><br>'),
                                                                      
                                                                      #Survey directions 
                                                                      span("The following questions concern your physical function when being active on a higher level. The questions should be answered thinking of what degree of difficulty you have experienced during the last week due to your knee.",
                                                                           style = 'font-size:20px'),
                                                                      HTML('<br><br>'),
                                                                      sarQuestion(inputId = 'SAR_Q1',
                                                                                  label = 'Squatting'),
                                                                      sarQuestion(inputId = 'SAR_Q2',
                                                                                  label = 'Running'),
                                                                      sarQuestion(inputId = 'SAR_Q3',
                                                                                  label = 'Jumping'),
                                                                      sarQuestion(inputId = 'SAR_Q4',
                                                                                  label = 'Twisting/pivoting on your injured knee'),
                                                                      sarQuestion(inputId = 'SAR_Q5',
                                                                                   label = 'Kneeling'),
                                                                      
                                                                      #Calulate SAR score
                                                                      span(textOutput(outputId = 'sarCalculated'), 
                                                                           style = 'font-size:20px')
                                                                      
                                                                      )
                                                     ),
                                            tabPanel(title = 'Symptom',
                                                     
                                                     #Symptom
                                                     radioButtons(inputId = 'haveSYMP',
                                                                  label = span('Do you know your current KOOS Symptom score?',
                                                                               style = 'font-size:16px'),
                                                                  choices = c('Yes', 'No'),
                                                                  inline = TRUE),
                                                     
                                                     #If they have SYMP, do this.....
                                                     conditionalPanel(condition = "input.haveSYMP == 'Yes'",
                                                                      sliderInput(inputId = 'inputSYMP',
                                                                                  label = span('Current symptom score:',
                                                                                               style = 'font-size:16px'),
                                                                                  value = X$SYMP[2],
                                                                                  min = 0,
                                                                                  max = 100)
                                                     ),
                                                     
                                                     #If they don't have SYMP, fill out survey...
                                                     conditionalPanel(condition = "input.haveSYMP == 'No'",
                                                                      
                                                                      #Title
                                                                      span('Symptoms',
                                                                           style = 'font-size:24px'),
                                                                      
                                                                      HTML('<br><br>'),
                                                                      
                                                                      #Survey directions 
                                                                      span("These questions should be answered thinking of your knee symptoms during the last week.",
                                                                           style = 'font-size:20px'),
                                                                      HTML('<br><br>'),
                                                                      sympQuestion(inputId = 'SYMP_Q1',
                                                                                   label = 'Do you have swelling in your knee?'),
                                                                      sympQuestion(inputId = 'SYMP_Q2',
                                                                                   label = 'Do you feel grinding, hear clicking, or any other type of noise when your knee moves?'),
                                                                      sympQuestion(inputId = 'SYMP_Q3',
                                                                                   label = 'Does your knee catch or hang up when moving?'),
                                                                      sympQuestion(inputId = 'SYMP_Q4',
                                                                                   label = 'Can you straighten your knee fully?'),
                                                                      sympQuestion(inputId = 'SYMP_Q5',
                                                                                   label = 'Can you bend your knee fully?'),
                                                                      
                                                                      #Calulate Symptom score
                                                                      span(textOutput(outputId = 'sympCalculated'), 
                                                                           style = 'font-size:20px')
                                                                      
                                                                      )
                                                     )
                                            ),
                                 
                                 #IKDC score
                                 tabPanel(title = 'IKDC',
                                          
                                          #IKDC
                                          radioButtons(inputId = 'haveIKDC',
                                                       label = span('Do you know your current IKDC score?',
                                                                    style = 'font-size:16px'),
                                                       choices = c('Yes', 'No'),
                                                       inline = TRUE),
                                          
                                          #If they have IKDC, do this.....
                                          conditionalPanel(condition = "input.haveIKDC == 'Yes'",
                                                           sliderInput(inputId = 'inputIKDC',
                                                                       label = span('Current IKDC:',
                                                                                    style = 'font-size:16px'),
                                                                       value = X$IKDC[2],
                                                                       min = 0,
                                                                       max = 100)
                                          ),
                                          
                                          #If they don't have IKDC, fill out survey...
                                          conditionalPanel(condition = "input.haveIKDC == 'No'",
                                                           
                                                           #Title
                                                           span('Symptoms',
                                                                style = 'font-size:24px'),
                                                           
                                                           HTML('<br><br>'),
                                                           
                                                           #Survey directions 
                                                           span("Grade symptoms at the highest activity level at which you think you could function without significant symptoms, even if you are not actually performing activities at this level.",
                                                                style = 'font-size:20px'),
                                                           HTML('<br><br>'),
                                                           
                                                           #Questions
                                                           radioButtons(inputId = 'ikdc_Q1',
                                                                        label = span('What is the highest level of activity that you can perform without significant knee pain?',
                                                                                     style = 'font-size:16px'),
                                                                        choices = c('Very strenuous activities like jumping or pivoting as in basketball or soccer' = 4,
                                                                                    'Strenuous activities like heavy physical work, skiing or tennis' = 3,
                                                                                    'Moderate activities like moderate physical work, running or jogging' = 2,
                                                                                    'Light activities like walking, housework or yard work' = 1,
                                                                                    'Unable to perform any of the above activities due to knee pain' = 0)),
                                                           sliderInput(inputId = 'ikdc_Q2',
                                                                       label = span('During the past 4 weeks, or since your injury, how often have you had pain? (0 = never; 10 = constant)',
                                                                                     style = 'font-size:16px'),
                                                                       min = 0,
                                                                       max = 10,
                                                                       value = 0),
                                                           sliderInput(inputId = 'ikdc_Q3',
                                                                       label = span('If you have pain, how severe is it? (0 = none; 10 = worst imaginable)',
                                                                                    style = 'font-size:16px'),
                                                                       min = 0,
                                                                       max = 10,
                                                                       value = 0),
                                                           radioButtons(inputId = 'ikdc_Q4',
                                                                        label = span('During the past 4 weeks, or since your injury, how stiff or swollen was your knee?',
                                                                                     style = 'font-size:16px'),
                                                                        choices = c('Not at all' = 4,
                                                                                    'Mildly' = 3,
                                                                                    'Moderately' = 2,
                                                                                    'Very' = 1,
                                                                                    'Extremely' = 0),
                                                                        inline = TRUE),
                                                           radioButtons(inputId = 'ikdc_Q5',
                                                                        label = span('What is the highest level of activity that you can perform without significant swelling in your knee?',
                                                                                     style = 'font-size:16px'),
                                                                        choices = c('Very strenuous activities like jumping or pivoting as in basketball or soccer' = 4,
                                                                                    'Strenuous activities like heavy physical work, skiing or tennis' = 3,
                                                                                    'Moderate activities like moderate physical work, running or jogging' = 2,
                                                                                    'Light activities like walking, housework or yard work' = 1,
                                                                                    'Unable to perform any of the above activities due to knee pain' = 0)),
                                                           radioButtons(inputId = 'ikdc_Q6',
                                                                        label = span('During the past 4 weeks, or since your injury, did your knee lock or catch?',
                                                                                     style = 'font-size:16px'),
                                                                        choices = c('No' = 1,
                                                                                    'Yes' = 0),
                                                                        inline = TRUE),
                                                           radioButtons(inputId = 'ikdc_Q7',
                                                                        label = span('What is the highest level of activity that you can perform without significant giving way to your knee?',
                                                                                     style = 'font-size:16px'),
                                                                        choices = c('Very strenuous activities like jumping or pivoting as in basketball or soccer' = 4,
                                                                                    'Strenuous activities like heavy physical work, skiing or tennis' = 3,
                                                                                    'Moderate activities like moderate physical work, running or jogging' = 2,
                                                                                    'Light activities like walking, housework or yard work' = 1,
                                                                                    'Unable to perform any of the above activities due to knee pain' = 0)),
                                                           
                                                           #Title
                                                           span('Sports activities',
                                                                style = 'font-size:24px'),
                                                           
                                                           HTML('<br><br>'),
                                                           
                                                           #Questions
                                                           radioButtons(inputId = 'ikdc_Q8',
                                                                        label = span('What is the highest level of activity that you can participate in on a regular basis?',
                                                                                     style = 'font-size:16px'),
                                                                        choices = c('Very strenuous activities like jumping or pivoting as in basketball or soccer' = 4,
                                                                                    'Strenuous activities like heavy physical work, skiing or tennis' = 3,
                                                                                    'Moderate activities like moderate physical work, running or jogging' = 2,
                                                                                    'Light activities like walking, housework or yard work' = 1,
                                                                                    'Unable to perform any of the above activities due to knee pain' = 0)),
                                                           HTML('<br><br>'),
                                                           span("How does your knee affect your ability to...",
                                                                style = 'font-size:20px'),
                                                           
                                                           HTML('<br>'),
                                                           
                                                           ikdcQuestion(inputId = 'ikdc_Q9',
                                                                        label = 'Go up stairs?'),
                                                           ikdcQuestion(inputId = 'ikdc_Q10',
                                                                        label = 'Go down stairs?'),
                                                           ikdcQuestion(inputId = 'ikdc_Q11',
                                                                        label = 'Kneel on the front of your knee?'),
                                                           ikdcQuestion(inputId = 'ikdc_Q12',
                                                                        label = 'Squat?'),
                                                           ikdcQuestion(inputId = 'ikdc_Q13',
                                                                        label = 'Sit with your knee bent?'),
                                                           ikdcQuestion(inputId = 'ikdc_Q14',
                                                                        label = 'Rise from a chair?'),
                                                           ikdcQuestion(inputId = 'ikdc_Q15',
                                                                        label = 'Run straight ahead?'),
                                                           ikdcQuestion(inputId = 'ikdc_Q16',
                                                                        label = 'Jump and land on your involved leg?'),
                                                           ikdcQuestion(inputId = 'ikdc_Q17',
                                                                        label = 'Stop and start quickly?'),
                                                           
                                                           #Title
                                                           span('Function',
                                                                style = 'font-size:24px'),
                                                           
                                                           HTML('<br><br>'),
                                                           span("How would you rate the function of your knee on a scale of 0 to 10 with 10 being normal, excellent function and 0 being the inability to perform any of your usual daily activities which may include sports?",
                                                                style = 'font-size:20px'),
                                                           sliderInput(inputId = 'ikdc_Q18',
                                                                       label = span("Function prior to your knee injury (0 = couldn't perform daily activities; 10 = no limitation)",
                                                                                    style = 'font-size:16px'),
                                                                       min = 0,
                                                                       max = 10,
                                                                       value = 0),
                                                           sliderInput(inputId = 'ikdc_Q19',
                                                                       label = span("Current function of your knee (0 = can't perform daily activities; 10 = no limitation)",
                                                                                    style = 'font-size:16px'),
                                                                       min = 0,
                                                                       max = 10,
                                                                       value = 0),
                                                           
                                                                        
                                                           #Calulate IKDC score
                                                           span(textOutput(outputId = 'ikdcCalculated'), 
                                                                style = 'font-size:20px')
                                                           
                                                          )
                                          ),
                                 
                                 #MARX Activity level
                                 tabPanel('MARX',
                                          
                                          #MARX
                                          radioButtons(inputId = 'haveMARX',
                                                       label = span('Do you know your current MARX activity level?',
                                                                    style = 'font-size:16px'),
                                                       choices = c('Yes', 'No'),
                                                       inline = TRUE),
                                          
                                          #If they have MARX, do this.....
                                          conditionalPanel(condition = "input.haveMARX == 'Yes'",
                                                           sliderInput(inputId = 'inputMARX',
                                                                       label = span('Current MARX:',
                                                                                    style = 'font-size:16px'),
                                                                       value = X$MARX[2],
                                                                       min = 0,
                                                                       max = 16)
                                          ),
                                          
                                          #If they don't have MARX, fill out survey...
                                          conditionalPanel(condition = "input.haveMARX == 'No'",
                                                           
                                                           #Title
                                                           span('MARX Activity Level',
                                                                style = 'font-size:24px'),
                                                           
                                                           HTML('<br><br>'),
                                                           
                                                           span("Please indicate how often you performed each activity in your healthiest and most active state, in the past year:",
                                                                style = 'font-size:24px'),
                                                           
                                                           HTML('<br>'),
                                                           
                                                           #Questions
                                                           marxQuestion(inputId = 'marx_Q1',
                                                                        label = 'Running: running while playing a sport or jogging'),
                                                           marxQuestion(inputId = 'marx_Q2',
                                                                        label = 'Cutting: changing directions while running'),
                                                           marxQuestion(inputId = 'marx_Q3',
                                                                        label = 'Decelerating: coming to a quick stop while running'),
                                                           marxQuestion(inputId = 'marx_Q4',
                                                                        label = 'Pivoting: turning your body with your foot planted while playing a sport. For example, skiing, skating, kicking, throwing, hitting a ball (golf, tennis, squash), etc.'),
                                                           
                                                           
                                                           
                                                           #Calulate Pain score
                                                           span(textOutput(outputId = 'marxCalculated'), 
                                                                style = 'font-size:20px')
                                                           
                                                          )
                                          )
                                 )
                      )
           ))
                    
           
           





