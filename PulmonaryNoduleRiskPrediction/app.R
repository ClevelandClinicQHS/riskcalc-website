# R shiny learn
# Xiaozhen HAN & Lei Kou
# Start Date: 2018 - 07 - 01

library(shiny)
library(shinydashboard)

# simple template
library(shinythemes)
library(ggplot2)

ui <- fluidPage(
  # Google Analytics
  tags$head(includeHTML("../google-analytics.html")),
  
  
  theme = shinytheme("flatly"),
                titlePanel('Probability of malignancy of pulmonary nodules clinically deemed at high enough risk to consider biopsy or resection'),
                sidebarLayout(
                  sidebarPanel(id = "sidebar"
                               ,
                               textInput('ctage', 'Age at Initial CT', placeholder = '18 - 100'),
                               textInput('packyears', 'Smoking Pack Years', placeholder = '0 - 200'),
                               selectInput('smokerstatus', 'Smoking Status', choices = c('Current', 'Former', 'Never')),
                               selectInput('emphasema', 'Emphysema Present on CT', choices = c('No', 'Yes')),
                               selectInput('petavidity', 'FDG-PET Avid*', choices = c(NA, 'Avid','Not Avid')),
                               selectInput('location', 'Upper Lobe', choices = c('Yes', 'No')),
                               selectInput('size', 'Change in Nodule Size', choices = c('Yes', 'No', NA)),
                               selectInput('solid', 'Nodule attenuation on CT', choices = c('Solid', 'Part Solid', 'Ground Glass')),
                               selectInput('density', 'Nodule Border and Density**', choices = c('Part Solid','Ground Glass', 'Solid Smooth','Solid Irregular','Solid Spiculated','Solid Lobulated')),
                               selectInput('hx', 'History of Cancer Other Than Lung', choices = c('Yes', 'No')),
                               p('*Fluorodeoxyglucose-positron emission tomography (FDG-PET) was considered “positive” if the maximum standardized uptake value (SUV) was reported to be > 2.5 or described as “positive” or “hypermetabolic” in the radiology report.'),
                               p("** Please select 'Solid' in Nodule attenuation on CT when you need to select 'Solid Smooth', 'Solid Irregular', 'Solid Spiculated' and 'Solid Lobulated'.")),
                  
                  
                  
                  mainPanel(
                    actionButton("goButton", "Run Calculator"),
                    br(),
                    hr(),
                    tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                    ),
                    dataTableOutput('result'),
                    br(),
                   
                      plotOutput("BarplotMalignant")  ,
                      br(),
                      hr(),
                    
                 
                    wellPanel(h3('Reference'),p("Reid, Michal, Humberto K. Choi, Xiaozhen Han, Xiaofeng Wang, Sanjay Mukhopadhyay, Lei Kou, Usman Ahmad, Xiaoqiong Wang, and Peter J. Mazzone.",
                                                " Development of a risk prediction model to estimate the probability of malignancy in pulmonary nodules being considered for biopsy.",
                                                " Chest 156, no. 2 (2019): 367-375.")),
                    wellPanel(h3('Disclaimer'),
                              p("No Medical Advice. ALTHOUGH SOME CONTENT MAY BE PROVIDED BY INDIVIDUALS IN THE MEDICAL PROFESSION, YOU ACKNOWLEDGE THAT PROVISION OF SUCH CONTENT DOES NOT CREATE A MEDICAL PROFESSIONAL-PATIENT RELATIONSHIP AND DOES NOT CONSTITUTE AN OPINION, MEDICAL ADVICE, PROFESSIONAL DIAGNOSIS, SERVICE OR TREATMENT OF ANY CONDITION. Access to general information is provided for educational purposes only, through this site and links to other sites. Content is not recommended or endorsed by any doctor or healthcare provider. The information and Content provided are not substitutes for medical or professional care, and you should not use the information in place of a visit, call, consultation or the advice of your physician or other healthcare provider. You are liable or responsible for any advice, course of treatment, diagnosis or any other information, services or product obtained through this site.")),
                    
                    p(a("Homepage",
                        href = "../", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                        font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"), 
                      " | ",
                      a("Contact Us",
                        href = "mailto:hanx@ccf.org", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                        font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"), 
                      style = "text-align: center;")
                    )))

formula1 <- expression({
  
  lp <-  -7.2447906+
    0.134743413* ctage-
    0.000151552814*pmax(ctage-50,0)^3+
    0.000314763537*pmax(ctage-64,0)^3-
    0.000163210723*pmax(ctage-77,0)^3+
    0.0235144405*packyears+
    0.553461951*(emphasema=="Yes")+
    0.537149548*(location=="Yes")+
    0.867857069*(density=="Ground Glass")-
    1.17293018*(density=="Solid Smooth")-
    0.920890315*(density=="Solid Irregular")-
    1.05828549*(density=="Solid Spiculated")-
    0.452306008*(density=="Solid Lobulated")-
    0.622013075*(hx == "Yes") ;
  exp(lp)/(1+exp(lp))})


formula1B <- expression({
  
  lp <-  -7.99985168+
    0.131550371* ctage-
    0.000131895331*pmax(ctage-49.2,0)^3+
    0.000271327538*pmax(ctage-64,0)^3-
    0.000139432207*pmax(ctage-78,0)^3+
    0.0302058714*packyears+
    0.777663093*(location=="Yes")-
    0.749851087*(hx=="Yes") ;
  exp(lp)/(1+exp(lp))})


formula2 <- expression({
  
  lp <-  -7.25817834+
    0.159947419* ctage-
    0.00018046189*pmax(ctage-50,0)^3+
    0.000360923779*pmax(ctage-64,0)^3-
    0.00018046189*pmax(ctage-78,0)^3+
    0.0140932781*packyears-
    0.405799091*(smokerstatus=="Former")-
    1.14942768*(smokerstatus=="Never")+
    0.566957445*(emphasema=="Yes")+
    0.458036131*(location=="Yes")-
    0.676084423*(petavidity=="Not Avid")+
    0.180502669*(density=="Ground Glass")-
    1.05241386*(density=="Solid Smooth")-
    1.39273685*(density=="Solid Irregular")-
    1.69580894*(density=="Solid Spiculated")-
    0.976141102*(density=="Solid Lobulated")-
    0.685630139*(hx=="Yes") ;
  exp(lp)/(1+exp(lp))})



formula2B <- expression({
  
  lp <-  -7.39919463+
    0.138965418* ctage-
    0.000150329716*pmax(ctage-50,0)^3+
    0.000300659432*pmax(ctage-64,0)^3-
    0.000150329716*pmax(ctage-78,0)^3+
    0.0181431163*packyears-
    0.663443792*(smokerstatus=="Former")-
    1.18152454*(smokerstatus=="Never")+
    0.634806891*(location=="Yes")-
    1.06613843*(petavidity=="Not Avid") ;
  exp(lp)/(1+exp(lp))})



formula3 <- expression({
  
  lp <-  -7.18461213+
    0.139114084* ctage-
    0.000163549144*pmax(ctage-50,0)^3+
    0.000339678992*pmax(ctage-64,0)^3-
    0.000176129848*pmax(ctage-77,0)^3+
    0.0201061168*packyears+
    1.0605741*(density=="Ground Glass")-
    1.24620002*(density=="Solid Smooth")-
    0.399463064*(density=="Solid Irregular")-
    0.740191807*(density=="Solid Spiculated")-
    0.615285486*(density=="Solid Lobulated") ;
  exp(lp)/(1+exp(lp))})



formula4 <- expression({
  
  lp <-  -8.5679255+
    0.188439012* ctage-
    0.000189745852*pmax(ctage-50,0)^3+
    0.000426928167*pmax(ctage-65,0)^3-
    0.000237182315*pmax(ctage-77,0)^3-
    0.744394218*(smokerstatus=="Former")-
    1.6544751*(smokerstatus=="Never")+
    0.328983801*(density=="Ground Glass")-
    1.48959434*(density=="Solid Smooth")-
    0.980508188*(density=="Solid Irregular")-
    1.04326744*(density=="Solid Spiculated")-
    1.06638315*(density=="Solid Lobulated") ;
  exp(lp)/(1+exp(lp))})


formula3B <- expression({
  
  lp <-  -7.29443623+
    0.126203436* ctage-
    0.000139389667*pmax(ctage-50,0)^3+
    0.000289501617*pmax(ctage-64,0)^3-
    0.000150111949*pmax(ctage-77,0)^3+
    0.0212635624*packyears ;
  exp(lp)/(1+exp(lp))})


formula4B <- expression({
  
  lp <-  -6.86960259+
    0.128268669* ctage-
    0.000146777959*pmax(ctage-50,0)^3+
    0.000318413476*pmax(ctage-64.5,0)^3-
    0.000171635517*pmax(ctage-76.9,0)^3+
    0.0180005867*packyears-
    1.31022412*(petavidity=="Not Avid") ;
  exp(lp)/(1+exp(lp))})


server <- shinyServer(function(input, output){
  data <- eventReactive(input$goButton, {
    
    ctage= as.numeric(input$ctage)
    
   
    packyears= as.numeric(input$packyears)
    
    emphasema = factor(input$emphasema, levels = c('No', 'Yes'))
    
    location = factor(input$location, levels = c('Yes', 'No'))
    
    solid = factor(input$solid, levels = c('Solid', 'Part Solid', 'Ground Glass') )
    
    density = factor(input$density, levels = c('Part Solid','Ground Glass', 'Solid Smooth','Solid Irregular','Solid Spiculated','Solid Lobulated'))
    
    hx = factor(input$hx, levels = c('No', 'Yes'))
    
    size = factor(input$size, levels = c('Yes', 'No'))
    petavidity = factor(input$petavidity, levels = c('Avid','Not Avid'))
    smokerstatus = factor(input$smokerstatus, levels = c('Current', 'Former', 'Never'))
    
    
    
    
    if( is.na(petavidity)  & is.na(size) & solid != 'Solid' ){
      model_any = 'M1'
    }else{
      if( is.na(petavidity)  & is.na(size) & solid == 'Solid'){
        model_any = 'M1B'
      }else{
        
        if(!is.na(petavidity)  & is.na(size) & solid != 'Solid'){
          model_any = 'M2'
        }else{
           
          if(!is.na(petavidity)  & is.na(size) & solid == 'Solid'){
            model_any= 'M2B'
          }else{
            
            if(is.na(petavidity)  & !is.na(size) & solid != 'Solid'){
              model_any = 'M3'
            }else{
              
              if(is.na(petavidity)  & !is.na(size) & solid == 'Solid'){
                model_any = 'M3B'
              }else{
                
                if(!is.na(petavidity)  & !is.na(size) & solid != 'Solid'){
                  model_any = 'M4'
                }else{
                  model_any = 'M4B'
                }
                
              }
              
            }
            
          }
          
          
        }
        
      }
    }
    
    data <- data.frame(ctage = ctage,
                       packyears = packyears,
                      
                       emphasema = emphasema,
                       location = location,
                       density = density,
                       hx = hx,
                       petavidity = petavidity,
                       smokerstatus = smokerstatus,
                       Model = model_any
                       )
    data})
  
  output$result <- renderDataTable({data = data()
  
  
  if(data$Model == 'M1' ){
   yr2 <- eval(formula1,envir = data)
   
   showPP <- ifelse(is.na(yr2) , NA , 
                    ifelse(yr2 >= 0.9 , '0.101', 
                           ifelse(yr2 >= 0.8, '0.337' ,
                                  ifelse(yr2 >= 0.7, '0.804', 
                                         ifelse(yr2 >= 0.6, '0.838', 
                                                ifelse( yr2 >= 0.5, '1.980',
                                                        ifelse (yr2 >= 0.4, '2.520',
                                                                ifelse(yr2 >= 0.3, '3.564' ,
                                                                       ifelse( yr2 >= 0.2, '4.950', 
                                                                               ifelse(yr2 >= 0.1,'8.911' , 'Inf'))))))))))
   
   
   
   
   
   
  }else{
    if(data$Model == 'M1B'){
      yr2 <- eval(formula1B,envir = data)
      
      showPP <- ifelse(is.na(yr2) , NA , 
                       ifelse(yr2 >= 0.9 , '0.049', 
                              ifelse(yr2 >= 0.8, '0.325' ,
                                     ifelse(yr2 >= 0.7, '0.618', 
                                            ifelse(yr2 >= 0.6, '0.870', 
                                                   ifelse( yr2 >= 0.5, '1.033',
                                                           ifelse (yr2 >= 0.4, '2.551',
                                                                   ifelse(yr2 >= 0.3, '3.788' ,
                                                                          ifelse( yr2 >= 0.2, '2.598', 
                                                                                  ifelse(yr2 >= 0.1,'6.494' , 'Inf'))))))))))
      
    }else{
      if(data$Model == 'M2B'){
        yr2 <- eval(formula2B,envir = data)
        
        showPP <- ifelse(is.na(yr2) , NA , 
                         ifelse(yr2 >= 0.9 , '0.099', 
                                ifelse(yr2 >= 0.8, '0.217' ,
                                       ifelse(yr2 >= 0.7, '0.577', 
                                              ifelse(yr2 >= 0.6, '0.619', 
                                                     ifelse( yr2 >= 0.5, '3.465',
                                                             ifelse (yr2 >= 0.4, '3.881',
                                                                     ifelse(yr2 >= 0.3, '3.032' ,
                                                                            ifelse( yr2 >= 0.2, '1.386', 
                                                                                    ifelse(yr2 >= 0.1,'8.662' , '13.859'))))))))))
        
      }else{
        
        if(data$Model == 'M2'){
          
          yr2 <- eval(formula2,envir = data)
          
          showPP <- ifelse(is.na(yr2) , NA , 
                           ifelse(yr2 >= 0.9 , '0.147', 
                                  ifelse(yr2 >= 0.8, '0.256' ,
                                         ifelse(yr2 >= 0.7, '0.742', 
                                                ifelse(yr2 >= 0.6, '1.122', 
                                                       ifelse( yr2 >= 0.5, '2.399',
                                                               ifelse (yr2 >= 0.4, '2.399',
                                                                       ifelse(yr2 >= 0.3, '3.046' ,
                                                                              ifelse( yr2 >= 0.2, '10.663', 
                                                                                      ifelse(yr2 >= 0.1,'10.663' , 'Inf'))))))))))
        
        }else{
          
          if(data$Model=='M3'){
            yr2 <- eval(formula3,envir = data)
            
            showPP <- ifelse(is.na(yr2) , NA , 
                             ifelse(yr2 >= 0.9 , '0.067', 
                                    ifelse(yr2 >= 0.8, '0.369' ,
                                           ifelse(yr2 >= 0.7, '0.791', 
                                                  ifelse(yr2 >= 0.6, '2.273', 
                                                         ifelse( yr2 >= 0.5, '1.705',
                                                                 ifelse (yr2 >= 0.4, '2.273',
                                                                         ifelse(yr2 >= 0.3, '3.788' ,
                                                                                ifelse( yr2 >= 0.2, '2.273', 
                                                                                        ifelse(yr2 >= 0.1,'9.091' , 'Inf'))))))))))
            
          }else{
            if(data$Model == 'M3B'){
              yr2 <- eval(formula3B,envir = data)
              
              showPP <- ifelse(is.na(yr2) , NA , 
                               ifelse(yr2 >= 0.9 , '0.165', 
                                      ifelse(yr2 >= 0.8, '0.272' ,
                                             ifelse(yr2 >= 0.7, '0.777', 
                                                    ifelse(yr2 >= 0.6, '0.794', 
                                                           ifelse( yr2 >= 0.5, '1.814',
                                                                   ifelse (yr2 >= 0.4, '2.419',
                                                                           ifelse(yr2 >= 0.3, '4.535' ,
                                                                                  ifelse( yr2 >= 0.2, '0.907', 
                                                                                          ifelse(yr2 >= 0.1,'9.070' , 'Inf'))))))))))
              
            }else{
              if(data$Model == 'M4'){
                yr2 <- eval(formula4,envir = data)
                
                showPP <- ifelse(is.na(yr2) , NA , 
                                 ifelse(yr2 >= 0.9 , '0.000', 
                                        ifelse(yr2 >= 0.8, '0.294' ,
                                               ifelse(yr2 >= 0.7, '1.392', 
                                                      ifelse(yr2 >= 0.6, '0.942', 
                                                             ifelse( yr2 >= 0.5, '1.570',
                                                                     ifelse (yr2 >= 0.4, '3.141',
                                                                             ifelse(yr2 >= 0.3, '8.244' ,
                                                                                    ifelse( yr2 >= 0.2, '4.711', 
                                                                                            ifelse(yr2 >= 0.1,'2.356' , '11.778'))))))))))
                
              }else{
                yr2 <- eval(formula4B,envir = data)
                
                showPP <- ifelse(is.na(yr2) , NA , 
                                 ifelse(yr2 >= 0.9 , '0.000', 
                                        ifelse(yr2 >= 0.8, '0.367' ,
                                               ifelse(yr2 >= 0.7, '0.423', 
                                                      ifelse(yr2 >= 0.6, '1.833', 
                                                             ifelse( yr2 >= 0.5, '1.833',
                                                                     ifelse (yr2 >= 0.4, '1.833',
                                                                             ifelse(yr2 >= 0.3, '1.833' ,
                                                                                    ifelse( yr2 >= 0.2, '7.333', 
                                                                                            ifelse(yr2 >= 0.1,'Inf' , '7.333'))))))))))
                
              }
            }
          }
          
        }
        
   
      }
    }
  }
  
  
  

  
  res = data.frame(Result = c("Probability of malignancy score","Benign Group Proportion : Malignant Group Proportion (in the model training population)"),
                   Probability = c(paste(round(yr2 * 100,2),"%"), showPP)  )
  res}, options = list(
    pageLength = 10,
    lengthMenu = 0,
    
    searching = 0,
    info = 0,
    paging = 0,
    initComplete = I(
      "function(settings, json) {
      $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
}")))
  
  
  output$BarplotMalignant <- renderPlot({
    
    data = data()
    
    # Render a barplot

    if(data$Model == 'M1' ){
      yr2 <- eval(formula1,envir = data)
      x <- c('0.0-0.1','0.1-0.2','0.2-0.3','0.3-0.4','0.4-0.5','0.5-0.6','0.6-0.7','0.7-0.8',
             '0.8-0.9','0.9-1.0', '0.0-0.1','0.1-0.2','0.2-0.3','0.3-0.4','0.4-0.5','0.5-0.6','0.6-0.7','0.7-0.8',
             '0.8-0.9','0.9-1.0')
      y <- c(0.0990099010, 0.0891089109 ,0.0990099010, 0.0891089109, 0.1386138614, 0.1386138614 ,0.1089108911, 0.1287128713,
             0.0792079208, 0.0297029703, 0.0000000000, 0.0100000000 ,0.0200000000, 0.0250000000, 0.0550000000, 0.0700000000,
             0.1300000000, 0.1600000000 ,0.2350000000 , 0.2950000000)
      drp <- c(rep('Benign',10),rep('Malignent',10))
      
      dat3 <- data.frame(x=x, y=y, grp=drp)
      dat3$LabelY <- c('Inf','8.911','4.950','3.564','2.520','1.980','0.838','0.804','0.337','0.101',rep(NA,10))
      p <-ggplot(dat3, aes(x, y))
      
      p +geom_bar(stat = "identity", aes(fill = grp), position = "dodge") +
        ylab("Proportion") + 
        xlab("Predicted probability to be malignant\n \nThe figure shows the proportion of malignant and benign nodules at different deciles of risk of malignancy in the model training population (All patients).\n \nThe number shows the ratio of benign group proportion over malignant group proportion.")+
        geom_text(aes(label = LabelY), position=position_dodge(width=2), vjust=-0.25)
      
      
      
    }else{
      if(data$Model == 'M1B'){
        
        yr2 <- eval(formula1B,envir = data)
        x <- c('0.0-0.1','0.1-0.2','0.2-0.3','0.3-0.4','0.4-0.5','0.5-0.6','0.6-0.7','0.7-0.8',
               '0.8-0.9','0.9-1.0', '0.0-0.1','0.1-0.2','0.2-0.3','0.3-0.4','0.4-0.5','0.5-0.6','0.6-0.7','0.7-0.8',
               '0.8-0.9','0.9-1.0')
        y <- c(0.0941176471, 0.0941176471, 0.0941176471, 0.1647058824, 0.1294117647, 0.0823529412,
                0.1764705882, 0.0941176471, 0.0588235294, 0.0117647059, 0.0000000000, 0.0144927536,
                0.0362318841, 0.0434782609, 0.0507246377, 0.0797101449, 0.2028985507, 0.1521739130,
                0.1811594203, 0.2391304348)
        drp <- c(rep('Benign',10),rep('Malignent',10))
        dat3 <- data.frame(x=x, y=y, grp=drp)
        dat3$LabelY <- c('Inf','6.494','2.598','3.788','2.551','1.033','0.870','0.618','0.325','0.049',rep(NA,10))
        p <-ggplot(dat3, aes(x, y))
        
        p +geom_bar(stat = "identity", aes(fill = grp), position = "dodge") +
          ylab("Proportion") + 
          xlab("Predicted probability to be malignant\n \nThe figure shows the proportion of malignant and benign nodules at different deciles of risk of malignancy in the model training population (Patients with solid nodule).\n \nThe number shows the ratio of benign group proportion over malignant group proportion.") +
          geom_text(aes(label = LabelY), position=position_dodge(width=2), vjust=-0.25)
        
      }else{
        if(data$Model == 'M2B'){
          yr2 <- eval(formula2B,envir = data)
          x <- c('0.0-0.1','0.1-0.2','0.2-0.3','0.3-0.4','0.4-0.5','0.5-0.6','0.6-0.7','0.7-0.8',
                 '0.8-0.9','0.9-1.0', '0.0-0.1','0.1-0.2','0.2-0.3','0.3-0.4','0.4-0.5','0.5-0.6','0.6-0.7','0.7-0.8',
                 '0.8-0.9','0.9-1.0')
          y <- c(  0.1126760563, 0.1408450704, 0.0563380282, 0.0985915493, 0.1549295775, 0.1971830986, 0.0704225352,
                   0.0845070423, 0.0563380282, 0.0281690141, 0.0081300813, 0.0162601626, 0.0406504065, 0.0325203252,
                   0.0406504065, 0.0569105691, 0.1138211382, 0.1463414634, 0.2601626016, 0.2845528455  )
          drp <- c(rep('Benign',10),rep('Malignent',10))
          dat3 <- data.frame(x=x, y=y, grp=drp)
          dat3$LabelY <- c('13.859','8.662','1.386','3.032','3.811','3.465','0.619','0.577','0.217','0.099',rep(NA,10))
          p <-ggplot(dat3, aes(x, y))
          
          p +geom_bar(stat = "identity", aes(fill = grp), position = "dodge") +
            ylab("Proportion") + 
            xlab("Predicted probability to be malignant\n \nThe figure shows the proportion of malignant and benign nodules at different deciles of risk of malignancy in the model training population (Patients who had PET scan and solid nodule).\n \nThe number shows the ratio of benign group proportion over malignant group proportion.") +
            geom_text(aes(label = LabelY), position=position_dodge(width=2), vjust=-0.25)
          
        }else{
          
          if(data$Model == 'M2'){
            
            yr2 <- eval(formula2,envir = data)
            x <- c('0.0-0.1','0.1-0.2','0.2-0.3','0.3-0.4','0.4-0.5','0.5-0.6','0.6-0.7','0.7-0.8',
                   '0.8-0.9','0.9-1.0', '0.0-0.1','0.1-0.2','0.2-0.3','0.3-0.4','0.4-0.5','0.5-0.6','0.6-0.7','0.7-0.8',
                   '0.8-0.9','0.9-1.0')
            y <- c( 0.0843373494, 0.1204819277, 0.1204819277, 0.1204819277, 0.1084337349, 0.1084337349, 0.1204819277,
                    0.0963855422, 0.0722891566, 0.0481927711, 0.0000000000 , 0.0112994350, 0.0112994350, 0.0395480226,
                    0.0451977401, 0.0451977401, 0.1073446328, 0.1299435028, 0.2824858757, 0.3276836158   )
            drp <- c(rep('Benign',10),rep('Malignent',10))
            dat3 <- data.frame(x=x, y=y, grp=drp)
            dat3$LabelY <- c('Inf','10.663','10.663','3.046','2.399','2.399','1.122','0.742','0.256','0.147',rep(NA,10))
            p <-ggplot(dat3, aes(x, y))
            
            p +geom_bar(stat = "identity", aes(fill = grp), position = "dodge") +
              ylab("Proportion") + 
              xlab("Predicted probability to be malignant\n \nThe figure shows the proportion of malignant and benign nodules at different deciles of risk of malignancy in the model training population (Patients who had PET scan).\n \nThe number shows the ratio of benign group proportion over malignant group proportion.") +
              geom_text(aes(label = LabelY), position=position_dodge(width=2), vjust=-0.25)
              
          }else{
            
            if(data$Model=='M3'){
              
              yr2 <- eval(formula3,envir = data)
              x <- c('0.0-0.1','0.1-0.2','0.2-0.3','0.3-0.4','0.4-0.5','0.5-0.6','0.6-0.7','0.7-0.8',
                     '0.8-0.9','0.9-1.0', '0.0-0.1','0.1-0.2','0.2-0.3','0.3-0.4','0.4-0.5','0.5-0.6','0.6-0.7','0.7-0.8',
                     '0.8-0.9','0.9-1.0')
              y <- c(   0.1090909091, 0.0727272727, 0.0363636364, 0.0909090909, 0.1272727273, 0.1090909091, 0.1818181818,
                       0.1454545455, 0.1090909091, 0.0181818182, 0.0000000000, 0.0080000000, 0.0160000000, 0.0240000000,
                        0.0560000000, 0.0640000000, 0.0800000000, 0.1840000000, 0.2960000000 , 0.2720000000  )
              drp <- c(rep('Benign',10),rep('Malignent',10))
              dat3 <- data.frame(x=x, y=y, grp=drp)
              dat3$LabelY <- c('Inf','9.091','2.273','3.788','2.273','1.705','2.273','0.791','0.369','0.067',rep(NA,10))
             p <-ggplot(dat3, aes(x, y))
              
              p +geom_bar(stat = "identity", aes(fill = grp), position = "dodge") +
                ylab("Proportion") + 
                xlab("Predicted probability to be malignant\n \nThe figure shows the proportion of malignant and benign nodules at different deciles of risk of malignancy in the model training population (Patients who had follow up scan).\n \nThe number shows the ratio of benign group proportion over malignant group proportion.") +
                geom_text(aes(label = LabelY), position=position_dodge(width=2), vjust=-0.25)
              
            }else{
              if(data$Model == 'M3B'){
                
                yr2 <- eval(formula3B,envir = data)
                x <- c('0.0-0.1','0.1-0.2','0.2-0.3','0.3-0.4','0.4-0.5','0.5-0.6','0.6-0.7','0.7-0.8',
                       '0.8-0.9','0.9-1.0', '0.0-0.1','0.1-0.2','0.2-0.3','0.3-0.4','0.4-0.5','0.5-0.6','0.6-0.7','0.7-0.8',
                       '0.8-0.9','0.9-1.0')
                y <- c(   0.0465116279, 0.1162790698, 0.0232558140, 0.1162790698, 0.0930232558, 0.2093023256, 0.1627906977,
                          0.1395348837, 0.0697674419, 0.0232558140, 0.0000000000, 0.0128205128, 0.0256410256, 0.0256410256,
                          0.0384615385, 0.1153846154, 0.2051282051, 0.1794871795, 0.2564102564, 0.1410256410  )
                drp <- c(rep('Benign',10),rep('Malignent',10))
                dat3 <- data.frame(x=x, y=y, grp=drp)
                dat3$LabelY <- c('Inf','9.070','0.907','4.535','2.419','1.814','0.794','0.777','0.272','0.165',rep(NA,10))
                p <-ggplot(dat3, aes(x, y))
                
               p +geom_bar(stat = "identity", aes(fill = grp), position = "dodge") +
                  ylab("Proportion") + 
                  xlab("Predicted probability to be malignant\n \nThe figure shows the proportion of malignant and benign nodules at different deciles of risk of malignancy in the model training population (Patients who had follow up scan and solid nodule).\n \nThe number shows the ratio of benign group proportion over malignant group proportion.") +
                  geom_text(aes(label = LabelY), position=position_dodge(width=2), vjust=-0.25)
               
              }else{
                if(data$Model == 'M4'){
                  
                  yr2 <- eval(formula4,envir = data)
                  x <- c('0.0-0.1','0.1-0.2','0.2-0.3','0.3-0.4','0.4-0.5','0.5-0.6','0.6-0.7','0.7-0.8',
                         '0.8-0.9','0.9-1.0', '0.0-0.1','0.1-0.2','0.2-0.3','0.3-0.4','0.4-0.5','0.5-0.6','0.6-0.7','0.7-0.8',
                         '0.8-0.9','0.9-1.0')
                  y <- c( 0.11111111111, 0.02222222222, 0.08888888889, 0.15555555556, 0.08888888889, 0.04444444444, 0.08888888889,
                          0.28888888889, 0.11111111111, 0.00000000000, 0.00943396226, 0.00943396226, 0.01886792453, 0.01886792453,
                          0.02830188679, 0.02830188679 , 0.09433962264, 0.20754716981, 0.37735849057, 0.20754716981  )
                  drp <- c(rep('Benign',10),rep('Malignent',10))
                  dat3 <- data.frame(x=x, y=y, grp=drp)
                  dat3$LabelY <- c('11.778','2.356','4.711','8.244','3.141','1.570','0.942','1.392','0.294','0.000',rep(NA,10))
                  p <-ggplot(dat3, aes(x, y))
                  
                  p +geom_bar(stat = "identity", aes(fill = grp), position = "dodge") +
                    ylab("Proportion") + 
                    xlab("Predicted probability to be malignant\n \nThe figure shows the proportion of malignant and benign nodules at different deciles of risk of malignancy in the model training population (Patients who had both PET scan and follow up scan).\n \nThe number shows the ratio of benign group proportion over malignant group proportion.") +
                    geom_text(aes(label = LabelY), position=position_dodge(width=2), vjust=-0.25)
                  
                }else{
                  
                  yr2 <- eval(formula4B,envir = data)
                  x <- c('0.0-0.1','0.1-0.2','0.2-0.3','0.3-0.4','0.4-0.5','0.5-0.6','0.6-0.7','0.7-0.8',
                         '0.8-0.9','0.9-1.0', '0.0-0.1','0.1-0.2','0.2-0.3','0.3-0.4','0.4-0.5','0.5-0.6','0.6-0.7','0.7-0.8',
                         '0.8-0.9','0.9-1.0')
                  y <- c(    0.1111111111, 0.0833333333, 0.1111111111, 0.1111111111, 0.1388888889, 0.0555555556, 0.1666666667,
                             0.0833333333, 0.1388888889, 0.0000000000, 0.0151515152, 0.0000000000, 0.0151515152, 0.0606060606,
                             0.0757575758, 0.0303030303, 0.0909090909, 0.1969696970, 0.3787878788, 0.1363636364 )
                  drp <- c(rep('Benign',10),rep('Malignent',10))
                  dat3 <- data.frame(x=x, y=y, grp=drp)
                  dat3$LabelY <- c('7.333','Inf','7.333','1.833','1.833','1.833','1.833','0.423','0.367','0.000',rep(NA,10))
                 p <-ggplot(dat3, aes(x, y))
                  
                  p +geom_bar(stat = "identity", aes(fill = grp), position = "dodge") +
                    ylab("Proportion") + 
                    xlab("Predicted probability to be malignant\n \nThe figure shows the proportion of malignant and benign nodules at different deciles of risk of malignancy in the model training population (Solid Nodule Patients who had both PET scan and follow up scan).\n \nThe number shows the ratio of benign group proportion over malignant group proportion.") +
                    geom_text(aes(label = LabelY), position=position_dodge(width=2), vjust=-0.25)
                  
                }
              }
            }
            
          }
          
          
        }
      }
    }
    
    
    
    
    
    
    
    
    
    
    
   
  })
  
  
  })





shinyApp(ui=ui, server = server)





