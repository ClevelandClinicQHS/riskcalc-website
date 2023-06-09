library(readxl)
library(deSolve)
library(reshape)
library(googlesheets4)
sheets_deauth()
source("functions.R")

# ----------------------------------------------------------------------------
# Load data:
# --------------------

HospDataAll=read_excel("COVID19_Parameters.xlsx",sheet="Hospital capacity")
HospDataAll=na.omit(HospDataAll)
hdata = as.data.frame(t(data.frame(HospDataAll[,c("Name","Value")], row.names="Name")))


function(input, output, session) {
  
  # Plot timecourse of all variables
  
  output$plot0 = renderPlotly({
    
    sim=SimSEIR(input)
    
    out.df=sim$out.df
    N=sim$N
    Ro=sim$Ro
    r=sim$r
    DoublingTime=sim$DoublingTime
    
    #reformat data for plotting
    out.df2=rename(out.df, c(Susceptible='S',Exposed='E', Infected.Mild='I1', Infected.Severe='I2', 
                             Infected.Critical='I3', Recovered='R', Dead='D'))
    out=melt(out.df,id="time")
    out2=melt(out.df2,id="time")
    out$variableName=out2$variable
    out$variableLegend = paste0(out$variableName,' (',out$variable,')')
    out$variableLegend = factor(out$variableLegend, levels = unique(out[["variableLegend"]]))
    
    #plot
    p=plot_ly(data = out, x=~time, y=~value, color=~variableLegend, type='scatter', mode='lines',colors = "Set2")

    p=layout(p,xaxis=list(title="Time since introduction (days)"),yaxis=list(title=paste("Number per",formatC(N,big.mark=",",format="f",digits=0),"people"),type=input$yscale),
             annotations=list(text=HTML(paste("R", tags$sub(0),'=',format(round(Ro,4),nsmall=1))),
                              showarrow=FALSE,xref="paper",xanchor="left",x=1.05, yref="paper", yanchor="center",y=0.4, align="left"))

  })
  
  #Plot timecourse with an intervention
  
  output$plotInt = renderPlotly({
    
    sim=SimSEIR(input)
    
    out.df=sim$out.df
    N=sim$N
    Ro=sim$Ro
    r=sim$r
    DoublingTime=sim$DoublingTime
    
    simInt=SimSEIRintB(input)
    
    outInt.df=simInt$out.df
    RoInt=simInt$Ro
    rInt=simInt$r
    DoublingTimeInt=simInt$DoublingTime
    
    if(input$VarShowInt=="Inf"){
      
      out.df$value=rowSums(out.df[,c("E", "I1","I2","I3")]) # create observed variable
      outInt.df$value=rowSums(outInt.df[,c("E", "I1","I2","I3")])
      
    }else if(input$VarShowInt=="Cases"){
      out.df$value=rowSums(out.df[,c("I1","I2","I3")]) # create observed variable
      outInt.df$value=rowSums(outInt.df[,c("I1","I2","I3")])
      
    }else if(input$VarShowInt=="Hosp"){
      out.df$value=rowSums(out.df[,c("I2","I3")]) # create observed variable
      outInt.df$value=rowSums(outInt.df[,c("I2","I3")])
      out.df$Intervention="Baseline" # add intervention column

    }else{

      out.df$value=out.df[,input$VarShowInt] # create observed variable
      outInt.df$value=outInt.df[,input$VarShowInt]
      
    }
    out.df$Intervention="Baseline" # add intervention column
    outInt.df$Intervention="Intervention"
    outAll.df=rbind(out.df,outInt.df) #combine baseline and intervention
    outAll.sub=subset(outAll.df, select=c("time","value","Intervention")) # choose only case column
    outAll.sub$Intervention=factor(outAll.sub$Intervention) # set intervention as factor
    outAll.sub=outAll.sub[with(outAll.sub,order(Intervention,time)),]
    
    
    p=plot_ly(data = outAll.sub, x=~time, y=~value, color=~Intervention, type='scatter', mode='lines',colors=c("#a50f15","#fc9272"))
    
    p=layout(p,xaxis=list(title="Time since introduction (days)"),yaxis=list(title=paste("Number per", formatC(N,big.mark=",",format="f",digits=0),"people"),type=input$yscaleInt),
             annotations=list(text=HTML(paste("Baseline: <br>R", tags$sub(0),'=',format(round(Ro,4),nsmall=1), "<br>Intervention: <br>R", tags$sub(0),'=',round(RoInt,4))),
                              showarrow=FALSE,xref="paper",xanchor="left",x=1.05, yref="paper", yanchor="top",y=0.5, align="left")
             )
    
  })
  
  output$plotCap = renderPlotly({
    
    sim=SimSEIR(input)
    
    out.df=sim$out.df
    N=sim$N
    Ro=sim$Ro
    r=sim$r
    DoublingTime=sim$DoublingTime
    
    simInt=SimSEIRintB(input)
    
    outInt.df=simInt$out.df
    RoInt=simInt$Ro
    rInt=simInt$r
    DoublingTimeInt=simInt$DoublingTime
    
    Tmax=input$Tmax
    
    #subset the relevant variables and add in a column for capacity
    capParams=SetHospCapacity(input)

    if(input$VarShowCap=="I3mv"){
      
      out.df$value=out.df[,"I3"] # create observed variable
      outInt.df$value=outInt.df[,"I3"]
      out.df$Intervention="Baseline" # add intervention column
      outInt.df$Intervention="Intervention"
      outAll.df=rbind(out.df,outInt.df) #combine baseline and intervention
      outAll.sub=subset(outAll.df, select=c("time","value","Intervention")) # choose only case column
      outAll.sub$Intervention=factor(outAll.sub$Intervention) # set intervention as factor
      outAll.sub=outAll.sub[with(outAll.sub,order(Intervention,time)),]
      
      capData=data.frame("time"=seq(0, Tmax, length.out = 1e3),"value"=rep(1,1e3)*capParams["ConvVentCap"]*(N/1000), "Intervention"="Conventional Mechanical \n Ventilator Capacity")
      combData=rbind(outAll.sub,capData)
      capData=data.frame("time"=seq(0, Tmax, length.out = 1e3),"value"=rep(1,1e3)*capParams["ContVentCap"]*(N/1000), "Intervention"="Contingency Mechanical \n Ventilator Capacity")
      combData=rbind(combData,capData)
      capData=data.frame("time"=seq(0, Tmax, length.out = 1e3),"value"=rep(1,1e3)*capParams["CrisisVentCap"]*(N/1000), "Intervention"="Crisis Mechanical \n Ventilator Capacity")
      combData=rbind(combData,capData)
      
      p=plot_ly(data = combData, x=~time, y=~value, color=~Intervention, linetype=~Intervention, type='scatter', mode='lines', colors=c("#a50f15","#fc9272","grey","grey","grey"), linetypes=c("solid","solid","dash","dashdot","dot"))
      
    }else if(input$VarShowCap=="I3bed"){
      
      out.df$value=out.df[,"I3"] # create observed variable
      outInt.df$value=outInt.df[,"I3"]
      out.df$Intervention="Baseline" # add intervention column
      outInt.df$Intervention="Intervention"
      outAll.df=rbind(out.df,outInt.df) #combine baseline and intervention
      outAll.sub=subset(outAll.df, select=c("time","value","Intervention")) # choose only case column
      outAll.sub$Intervention=factor(outAll.sub$Intervention) # set intervention as factor
      outAll.sub=outAll.sub[with(outAll.sub,order(Intervention,time)),]
      
      capData=data.frame("time"=seq(0, Tmax, length.out = 1e3),"value"=rep(1,1e3)*capParams["AvailICUBeds"]*(N/1000), "Intervention"="Available ICU Beds")
      combData=rbind(outAll.sub,capData)
      
      p=plot_ly(data = combData, x=~time, y=~value, color=~Intervention, linetype=~Intervention, type='scatter', mode='lines', colors=c("#a50f15","#fc9272","grey"), linetypes=c("solid","solid","dash"))
      
    }else if(input$VarShowCap=="Hosp"){
      
      out.df$value=rowSums(out.df[,c("I2","I3")]) # create observed variable
      outInt.df$value=rowSums(outInt.df[,c("I2","I3")])
      out.df$Intervention="Baseline" # add intervention column
      outInt.df$Intervention="Intervention"
      outAll.df=rbind(out.df,outInt.df) #combine baseline and intervention
      outAll.sub=subset(outAll.df, select=c("time","value","Intervention")) # choose only case column
      outAll.sub$Intervention=factor(outAll.sub$Intervention) # set intervention as factor
      outAll.sub=outAll.sub[with(outAll.sub,order(Intervention,time)),]
      
      capData=data.frame("time"=seq(0, Tmax, length.out = 1e3),"value"=rep(1,1e3)*capParams["AvailHospBeds"]*(N/1000), "Intervention"="Available Hospital Beds")
      combData=rbind(outAll.sub,capData)
      
      p=plot_ly(data = combData, x=~time, y=~value, color=~Intervention, linetype=~Intervention, type='scatter', mode='lines', colors=c("#a50f15","#fc9272","grey"), linetypes=c("solid","solid","dash"))
      
    }else if(input$VarShowCap=="CasesCap"){ #CasesCap
      out.df$value=rowSums(out.df[,c("I1","I2","I3")]) # create observed variable
      outInt.df$value=rowSums(outInt.df[,c("I1","I2","I3")])
      out.df$Intervention="Baseline" # add intervention column
      outInt.df$Intervention="Intervention"
      outAll.df=rbind(out.df,outInt.df) #combine baseline and intervention
      outAll.sub=subset(outAll.df, select=c("time","value","Intervention")) # choose only case column
      outAll.sub$Intervention=factor(outAll.sub$Intervention) # set intervention as factor
      outAll.sub=outAll.sub[with(outAll.sub,order(Intervention,time)),]
      
      capData=data.frame("time"=seq(0, Tmax, length.out = 1e3),"value"=rep(1,1e3)*capParams["AvailHospBeds"]*(N/1000), "Intervention"="Available Hospital Beds")
      combData=rbind(outAll.sub,capData)
      
      p=plot_ly(data = combData, x=~time, y=~value, color=~Intervention, linetype=~Intervention, type='scatter', mode='lines', colors=c("#a50f15","#fc9272","grey"), linetypes=c("solid","solid","dash"))
      
    }
    
    
    p=layout(p,xaxis=list(title="Time since introduction (days)"),yaxis=list(title=paste("Number per",formatC(N,big.mark=",",format="f",digits=0),"people"),type=input$yscaleCap), 
             annotations=list(text=HTML(paste("Baseline: <br>R", tags$sub(0),'=',format(round(Ro,4),nsmall=1)," <br>Intervention: <br>R", tags$sub(0),'=',round(RoInt,4))),
                              showarrow=FALSE,xref="paper",xanchor="left",x=1.05, yref="paper", yanchor="top",y=0.5, align="left")
    )
    
  })
  
  # Show the rate parameter values using an HTML table
  output$ParameterTable <-renderTable(
    formattedModelParameters(), hover = T,bordered = T,striped = F, digits=4
  )
  
  formattedModelParameters <- reactive({
    
    ParamStruct=GetModelParams(input)
    pModel=ParamStruct$pModel
    N=ParamStruct$N
    pModel.df=data.frame(as.list(pModel))
    pModel.df$N=N
    
    pModel.df$beta1=pModel.df$beta1*N
    pModel.df$beta2=pModel.df$beta2*N
    names(pModel.df)[names(pModel.df)=="beta1"] <- "beta_m"
    names(pModel.df)[names(pModel.df)=="beta2"] <- "beta_E"
    names(pModel.df)[names(pModel.df)=="p1"] <- "p_s"
    names(pModel.df)[names(pModel.df)=="p2"] <- "p_c"
    names(pModel.df)[names(pModel.df)=="q1"] <- "q_s"
    names(pModel.df)[names(pModel.df)=="q2"] <- "q_c"
    names(pModel.df)[names(pModel.df)=="alpha1"] <- "alpha_m"
    names(pModel.df)[names(pModel.df)=="alpha2"] <- "alpha_s"
    names(pModel.df)[names(pModel.df)=="gamma1"] <- "gamma_m"
    names(pModel.df)[names(pModel.df)=="gamma2"] <- "gamma_s"
    names(pModel.df)[names(pModel.df)=="gamma3"] <- "gamma_c"
    
    pModel.df=melt(pModel.df)
    colnames(pModel.df)[1]="Parameter"
    colnames(pModel.df)[2]="Value"
    pModel.df[-9,]
    
  }) 
  
  # Display the model diagram
  output$plot4 <- renderImage({
    filename <- normalizePath(file.path('./images',"model.png"))
    
    list(src = filename, height=340, width=745)
    
  }, deleteFile = FALSE)
  
  # 
  url = a("GitHub", href="https://github.com/alsnhll/SEIR_COVID19")
  output$tab = renderUI({
    tagList("Rscripts used to make this R Shiny web application are available on", url,". Contact Alison Hill alhill@fas.harvard.edu with questions. Thanks to Anjalika Nande, Andrei Gheorghe, Ski Krieger, Sherrie Xie, and Mike Levy for feedback on early versions of this tool.")

  })
  
  output$parameterDesc <- renderUI({
    tags$iframe(src="Parameters.html",width="100%",frameBorder="0",height="5000px")
  })
  
  
  # ------------Set the sliders/forms that have dynamic values based on other sliders ----------------------
  
  output$N <- renderText({ 
    N=round(10^(input$LogN))
    HTML(paste("<b> N = </b>",formatC(N,big.mark=",",format="f",digits=0),""))
  })
  
  #Get default hospital capacity parameters and create sliders 
  output$HospBedper <- renderUI({
    numericInput("HospBedper","Total (per 1000 ppl)",value = signif(hdata$HospBedper,digits=3), min = 0, step = 0.1)
  })
  output$HospBedOcc <- renderUI({
    numericInput("HospBedOcc","Occupancy (%)",value = signif(hdata$HospBedOcc,digits=3)*100, min = 0, max = 100, step = 0.1)
  })
  output$ICUBedper <- renderUI({
    numericInput("ICUBedper","Total (per 1000 ppl)",value = signif(hdata$ICUBedper,digits=3), min = 0, step = 0.01)
  })
  output$ICUBedOcc <- renderUI({
    numericInput("ICUBedOcc","Occupancy (%)",value = signif(hdata$ICUBedOcc,digits=3)*100, min = 0, max = 100, step = 1)
  })
  output$IncFluOcc <- renderUI({
    numericInput("IncFluOcc","Increased occupancy during flu season (%)",value = signif(hdata$IncFluOcc,digits=3)*100, min = 0, max = 100, step = 1)
  })
  output$ConvVentCap <- renderUI({
    numericInput("ConvMVCap","Conventional",value = signif(hdata$ConvMVCap,digits=3), min = 0, step = 0.01)
  })
  output$ContVentCap <- renderUI({
    numericInput("ContMVCap","Contingency",value = signif(hdata$ContMVCap,digits=3), min = 0, step = 0.01)
  })
  output$CrisisVentCap <- renderUI({
    numericInput("CrisisMVCap","Crisis",value = signif(hdata$CrisisMVCap,digits=3), min = 0, step = 0.01)
  })
  
  #Make sure the intervention doesn't end before it starts, and doesn't end after total simulation time
  observeEvent(input$Tint1,  {
    updateSliderInput(session = session, inputId = "Tint2", min = input$Tint1)
    updateSliderInput(session = session, inputId = "Tint2C", min = input$Tint1)
  })
  observeEvent(input$Tmax,  {
    updateSliderInput(session = session, inputId = "Tint2", max = input$Tmax)
    updateSliderInput(session = session, inputId = "Tint2C", max = input$Tmax)
  })
  
  #Update intervention sliders on capacity tab to match intervention tab
  observeEvent(input$Tint1,  {
    updateSliderInput(session = session, inputId = "Tint1C", value = input$Tint1)
  })
  observeEvent(input$Tint2,  {
    updateSliderInput(session = session, inputId = "Tint2C", value = input$Tint2)
  })
  observeEvent(input$s1,  {
    updateSliderInput(session = session, inputId = "s1C", value = input$s1)
  })
  observeEvent(input$s2,  {
    updateSliderInput(session = session, inputId = "s2C", value = input$s2)
  })
  
  #And vice versa
  
  observeEvent(input$Tint1C,  {
    updateSliderInput(session = session, inputId = "Tint1", value = input$Tint1C)
  })
  observeEvent(input$Tint2C,  {
    updateSliderInput(session = session, inputId = "Tint2", value = input$Tint2C)
  })
  observeEvent(input$s1C,  {
    updateSliderInput(session = session, inputId = "s1", value = input$s1C)
  })
  observeEvent(input$s2C,  {
    updateSliderInput(session = session, inputId = "s2", value = input$s2C)
  })
  

  # Reset all parameters if the RESET button is pushed
  observeEvent(input$reset,{
    updateSliderInput(session,'DurIncub',value = 6.65)
    updateSliderInput(session,'DurMild',value = 14.47)
    updateSliderInput(session,'DurSevere',value = 6.53)
    updateSliderInput(session,'DurICU',value = 3.27)
    updateSliderInput(session,'beta1',value = 0.0579)
    updateSliderInput(session,'beta2',value = 0.3495)
    updateSliderInput(session,'p1',value = 0.0002)
    updateSliderInput(session,'p2',value = 0.1009)
    updateSliderInput(session,'delta',value = 1.35e-8)
    updateSliderInput(session,'proportion',value = 0.2242)
    updateSliderInput(session,'LogN',value = 3)
    updateSliderInput(session,'Tmax',value = 300)
    updateSliderInput(session,'InitInf',value = 1)
  })
   
}