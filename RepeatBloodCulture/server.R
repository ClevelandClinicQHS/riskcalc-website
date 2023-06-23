
#create the equation for all continuous variables, then use that for the rest of thecategorica ones
prob.gns <- expression({
  
cont_vars = effect_est$Estimate[effect_est$Effect=="Intercept"] +
  (data$Age* effect_est$Estimate[effect_est$Effect=="Age"] ) + 
  (data$BMI* effect_est$Estimate[effect_est$Effect=="BMI"]) + 
  (data$resp_rateAt48hrs* effect_est$Estimate[effect_est$Effect=="resp_rateAt48hrs"])+
  (data$systolic_48Hrs* effect_est$Estimate[effect_est$Effect=="systolic_48Hrs"])+ 
  (data$pulse_48Hrs* effect_est$Estimate[effect_est$Effect=="pulse_48Hrs"])+
  (data$WBC_AtAdmsn* effect_est$Estimate[effect_est$Effect=="WBC_AtAdmsn"])+
  (data$glucose_Admsn* effect_est$Estimate[effect_est$Effect=="glucose_Admsn"])+
  (data$glucose_48Hrs* effect_est$Estimate[effect_est$Effect=="glucose_48Hrs"])+
  (data$CarbonDioxideAdmsn* effect_est$Estimate[effect_est$Effect=="CarbonDioxideAdmsn"])+
  (data$Serum_Creat_Admsn* effect_est$Estimate[effect_est$Effect=="Serum_Creat_Admsn"])+
  (data$BUNOrd_value_AtAdmsn* effect_est$Estimate[effect_est$Effect=="BUNOrd_value_AtAdmsn"])+
  (data$K_Blood_Admsn* effect_est$Estimate[effect_est$Effect=="K_Blood_Admsn"])+
  (data$SerumSodium_Admsn* effect_est$Estimate[effect_est$Effect=="SerumSodium_Admsn"]);
 
 
  gendereffect<- ifelse(data$Gender == "Female", effect_est$Estimate[effect_est$Level=="Female"], effect_est$Estimate[effect_est$Level=="Male"])

  raceeffect<- ifelse(data$Race == "Black", effect_est$Estimate[effect_est$Level=="Black"], 
                      ifelse(data$Race == "Other",  effect_est$Estimate[effect_est$Level=="Other"], effect_est$Estimate[effect_est$Level=="White"]))

  CardiacDeviceeffect<- ifelse(data$CardiacDevice == "No", effect_est$Estimate[effect_est$Effect=="CardiacDevice" & effect_est$Level=="No"], 
                               effect_est$Estimate[effect_est$Level=="Pacemaker/defibrillator"] )

  jointrepeffect<- ifelse(data$Joint_Replacement == "No", effect_est$Estimate[effect_est$Effect=="Joint_Replacement" & effect_est$Level=="No"],
                          effect_est$Estimate[effect_est$Effect=="Joint_Replacement" & effect_est$Level=="Yes"])
  
  mdreffect<- ifelse(data$mdr_organism == "MDRO", effect_est$Estimate[effect_est$Level=="MDRO"], 
                          effect_est$Estimate[effect_est$Effect=="mdr_organism" & effect_est$Level=="No"])
  
  resisteffect<- ifelse(data$resist_abx_adm == "No", effect_est$Estimate[effect_est$Effect=="resist_abx_adm" & effect_est$Level=="NO"],
                          effect_est$Estimate[effect_est$Effect=="resist_abx_adm" & effect_est$Level=="YES"])
  
  sourceeffect<- ifelse(data$source == "CENTRAL LINE INFECTION", effect_est$Estimate[effect_est$Level=="CENTRAL LINE INFECTION"], 
                  ifelse(data$source =="GASTRONINTESTINAL INFECTION", effect_est$Estimate[effect_est$Level=="GASTRONINTESTINAL INFECTION"],
                  ifelse(data$source =="PNEUMONIA", effect_est$Estimate[effect_est$Level=="PNEUMONIA"],
                  ifelse(data$source =="PROSTHETIC/HARDWARE/FOREIGN DEVICE INFECTION",  
                                                      effect_est$Estimate[effect_est$Level=="PROSTHETIC/HARDWARE/FOREIGN DEVICE INFECTION"],
                  ifelse(data$source =="SKIN/SOFT TISSUE INFECTION", effect_est$Estimate[effect_est$Level=="SKIN/SOFT TISSUE INFECTION"],
                  ifelse(data$source =="UNKNOWN SOURCE",  effect_est$Estimate[effect_est$Level=="UNKNOWN SOURCE"], 
                                                      effect_est$Estimate[effect_est$Level=="URINARY TRACT INFECTION"]))))))

  bldclteffect<- ifelse(data$bld_clt_adm == "ESCHERICHIA COLI",  effect_est$Estimate[effect_est$Level=="ESCHERICHIA COLI"], 
                  ifelse(data$bld_clt_adm == "KLEBSIELLA PNEUMONIA",  effect_est$Estimate[effect_est$Level=="KLEBSIELLA PNEUMONIA"],
                  ifelse(data$bld_clt_adm == "OTHER GRAM NEGATIVE", effect_est$Estimate[effect_est$Level=="OTHER GRAM NEGATIVE"],
                                                      effect_est$Estimate[effect_est$Level=="PSEUDOMONAS AERUGINOSA"])))

  XB<-cont_vars+gendereffect+raceeffect+CardiacDeviceeffect+jointrepeffect+mdreffect+resisteffect+sourceeffect+bldclteffect
  probgramnegative<-plogis(XB)
  probgramnegative 
})

# Define server logic required to create a table
shinyServer(function(input, output){
  # It is a function that creates a dataframe called data  for the inputs
  # The function is "reactive" and therefore should be  automatically
  # re-executed when inputs change
  inputdata <- reactive({
    data <- data.frame(
      Age = as.numeric(input$Age),
      BMI = as.numeric(input$BMI),
      Gender = input$Gender,
      Race= input$Race,
      CardiacDevice = input$CardiacDevice,
      Joint_Replacement= input$JointReplacement,
      mdr_organism= input$mdr_organism,
      resist_abx_adm= input$resist_abx_adm,
      source= input$source,
      bld_clt_adm= input$bld_clt_adm ,
      resp_rateAt48hrs= as.numeric(input$resp_rateAt48hrs),
      systolic_48Hrs= as.numeric(input$systolic_48Hrs ),
      pulse_48Hrs= as.numeric(input$pulse_48Hrs ),
      WBC_AtAdmsn= as.numeric(input$WBC_AtAdmsn ),
      glucose_Admsn= as.numeric(input$glucose_Admsn),      
      glucose_48Hrs= as.numeric(input$glucose_48Hrs),
      CarbonDioxideAdmsn= as.numeric(input$CarbonDioxideAdmsn),
      Serum_Creat_Admsn= as.numeric(input$Serum_Creat_Admsn),
      BUNOrd_value_AtAdmsn= as.numeric(input$BUNOrd_value_AtAdmsn),
      K_Blood_Admsn= as.numeric(input$K_Blood_Admsn),
      SerumSodium_Admsn = as.numeric(input$SerumSodium_Admsn)
    )
    data
  })
  
  # Table to display the probability
  output$result <- renderTable({
    # Executes the "inputdata" function to save the dataframe as "data"
    data = inputdata()
    # Evaluate the "prob.gns" expression with values    from "data"
    probgramnegative = eval(prob.gns, data)
    # create a dataframe for output
    resultTable = data.frame(
      Result = "Repeat Blood Culture -> Gram Negative",
      Probability = probgramnegative
    )
    resultTable
  })
})