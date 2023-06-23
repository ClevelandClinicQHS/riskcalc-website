# This file defines all the functions that are used in the simulation

# ----------------------------------------------------------------------------
# SetODEs_SEIR function:
# -----------------------
# Defines the system of differential equations describing the SEIR model 
# INPUT: p - named list of parameter values
# OUTPUT: list of derivatives of each variable

SetODEs_SEIR=function(t,y,p){
  S = y[1]
  E = y[2]
  I1 = y[3]
  I2 = y[4]
  I3 = y[5]
  R = y[6]
  D = y[7]
  
  with(as.list(p),{
    
    dS.dt = -(beta1*I1+beta2*E)*S+delta*R
    dE.dt = (beta1*I1+beta2*E)*S-(alpha1+alpha2)*E
    dI1.dt = alpha1*E-gamma1*I1-p1*I1
    dI2.dt = alpha2*E+p1*I1-gamma2*I2-p2*I2-q1*I2
    dI3.dt = p2*I2-gamma3*I3-q2*I3
    dR.dt = gamma1*I1+gamma2*I2+gamma3*I3-delta*R
    dD.dt = q1*I2+q2*I3
    
    return(list(c(dS.dt, dE.dt, dI1.dt, dI2.dt, dI3.dt, dR.dt, dD.dt)))
  })
}


# ----------------------------------------------------------------------------
# GetSpread_SEIR function:
# --------------------
# This function numerically intergrates the system of differential equations for a given set of parameter values, initial conditions, and maximum time
# INPUT: p- named list of parameter values
#        Tmax - max time to integrate for
#        y0 - named list of initial conditions for each variable
# OUTPUT: Dataframe with rows as timepoints and columns as variables

GetSpread_SEIR = function(p,Tmax,y0){
  
  t = seq(from=0, to=Tmax, by=1)
  
  out = ode(y=y0, times=t, func=SetODEs_SEIR, parms=p)
  
  df = as.data.frame(out)
  
  return(df)
}


# ----------------------------------------------------------------------------
# GetModelParams function:
# --------------------
# Function to take the parameters entered by the user and turn them into the rate parameters used by the model
# INPUT: input - structure containing all the user entered information
# OUTPUT: named list consisting of the population size N and another list of the model parameters, pModel

GetModelParams = function(input){
  
  IncubPeriod=input$DurIncub  #Incubation period, days
  DurMildInf=input$DurMild #Duration of mild infections, days
  DurHosp=input$DurSevere #Duration of hospitalization, days
  DurICU=input$DurICU #Duration of hospitalization in ICU, days
  p1=input$p1
  p2=input$p2
  q1=input$q1
  q2=input$q2
  
  pClin=c(IncubPeriod=IncubPeriod, DurMildInf=DurMildInf,DurHosp=DurHosp,DurICU=DurICU,p1=p1,p2=p2,q1=q1,q2=q2)
  
  # Turn these clinical parameters into the rate constants of the model
  pModel=GetParams_SEIR(pClin)
  
  N=10^(input$LogN)
  
  # The transmission rates are changed from values per time to values per capita per time
  beta1=input$beta1/N
  beta2=input$beta2/N
  delta=input$delta
  proportion=input$proportion
  alpha2=as.numeric(pModel['alpha']*proportion)
  alpha1=as.numeric(pModel['alpha']-alpha2)
  beta=c(beta1,beta2)
  pModel=c(beta=beta,alpha1=alpha1,alpha2=alpha2,p1=p1,p2=p2,q1=q1,q2=q2,pModel,delta=delta)
  
  return(list("N"=N,"pModel"=pModel))
  
}

# ----------------------------------------------------------------------------
# GetParams_SEIR function:
# --------------------
# Function to relate the clinical parameters entered by the user into the rate parameters used by the model
# INPUT: pClin - named list of the clinical parameters
# OUTPUT: named list of the model rate parameters, excluding the Betas

GetParams_SEIR = function(pClin){
  
  with(as.list(pClin),{
    
    alpha=1/IncubPeriod
    
    mild=1/DurMildInf
    
    gamma1=mild-p1
    
    severe=1/DurHosp
    
    gamma2=severe-p2-q1
    
    critical=1/DurICU
    
    gamma3=critical-q2
    
    return(c(alpha=alpha,gamma1=gamma1,gamma2=gamma2,gamma3=gamma3))
  })
  
}

# ----------------------------------------------------------------------------
# GetRo_SEIR function:
# --------------------
# Function to calculate the basic reporductive ratio (Ro) for the model
# INPUT: p - named list of the clinical parameters
#        N - total population size
# OUTPUT: Ro

GetRo_SEIR = function(p,N){
  
  with(as.list(p),{
    
    Ro=N*beta1/(p1+gamma1)*alpha1/(alpha1+alpha2)+N*beta2/(alpha1+alpha2)
    
    return(Ro)
  })
  
}

# ----------------------------------------------------------------------------
# Getr_SEIR_Emp function:
# --------------------
# Function to calculate the early exponential growth rate (r) for the model from the model timecourse
# INPUT: p - named list of the clinical parameters
#        N - total population size
# OUTPUT: Ro

# Getr_SEIR_Emp = function(out.df,V){
#   
#   tpeak=out.df[which.max(select(out.df,"time",V)[,2]),"time"]; # find location of peak infection
#   
#   t2=tpeak/4 # choose timepoints long before peak infection
#   t1=tpeak/8
#   
#   outV=subset(out.df, select=c("time",V))
#   colnames(outV)=c("time","value")
#   value1=outV$value[which.min(abs(t1-outV$time))]
#   value2=outV$value[which.min(abs(t2-outV$time))]
#   r=(log(value2)-log(value1))/(t2-t1)
#   
#   DoublingTime=log(2)/r
#   
#   return(list("r"=r,"DoublingTime"=DoublingTime))
#   
# }

# ----------------------------------------------------------------------------
# Getr_SEIR function:
# --------------------
# Function to calculate the early exponential growth rate (r) for the model from parameters
# INPUT: p - named list of the clinical parameters
#        N - total population size
# OUTPUT: Ro



# ----------------------------------------------------------------------------
# SetHospitalCapacity function:
# --------------------
# Function to determine the capacity for hospital beds and ICU beds based on total beds and availability, and to # get ventilator capacity
# INPUT: input - structure containing all the user entered information
# OUTPUT: named list consisting of all the healthcare capacity parameters

SetHospCapacity=function(input){
  
  AvailHospBeds=input$HospBedper*(100-input$HospBedOcc*(1+input$IncFluOcc/100))/100 #Available hospital beds per 1000 ppl in US based on total beds and occupancy
  AvailICUBeds=input$ICUBedper*(100-input$ICUBedOcc*(1+input$IncFluOcc/100))/100 #Available ICU beds per 1000 ppl in US, based on total beds and occupancy. Only counts adult not neonatal/pediatric beds
  ConvVentCap=input$ConvMVCap #Estimated excess # of patients who could be ventilated in US (per 1000 ppl) using conventional protocols
  ContVentCap=input$ContMVCap #Estimated excess # of patients who could be ventilated in US (per 1000 ppl) using contingency protocols
  CrisisVentCap=input$CrisisMVCap #Estimated excess # of patients who could be ventilated in US (per 1000 ppl) using crisis protocols
  
  capParams=c("AvailHospBeds"=AvailHospBeds,"AvailICUBeds"=AvailICUBeds,"ConvVentCap"=ConvVentCap,"ContVentCap"=ContVentCap,"CrisisVentCap"=CrisisVentCap)
  
  return(capParams)
}

# ----------------------------------------------------------------------------
# SimSEIR function:
# --------------------
# Function to simulate the spread of infection using the model
# INPUT: input - structure containing all the user entered information
# OUTPUT: named list consisting of df - wide format of the timecourse of each variable, N, Ro, r, and doubling time

SimSEIR = function(input){
  
  ParamStruct=GetModelParams(input)
  pModel=ParamStruct$pModel
  N=ParamStruct$N
  Tmax=input$Tmax
  
  # Set initial conditions and time interval
  E0=input$InitInf
  S0 = N-E0
  y0 = c(S=S0, E=E0, I1=0, I2=0, I3=0, R=0, D=0)
  
  #get Ro and r values
  Ro=GetRo_SEIR(pModel,N)
  
  #run ODEs
  out.df=GetSpread_SEIR(pModel,Tmax,y0)
  
  return(list("out.df"=out.df,"N"=N,"Ro"=Ro))
  
}

# ----------------------------------------------------------------------------
# SimSEIRintB function:
# --------------------
# Function to simulate the spread of infection using the model, when an intervention to reduce Beta is implemented
# INPUT: input - structure containing all the user entered information
# OUTPUT: named list consisting of df - wide format of the timecourse of each variable, N, Ro, r, and doubling time

SimSEIRintB = function(input){
  
  ParamStruct=GetModelParams(input)
  pModel=ParamStruct$pModel
  N=ParamStruct$N
  Tmax=input$Tmax
  
  # start/end time of intervention
  Tint1=input$Tint1
  Tint2=input$Tint2
  #Tend=input$Tend
  #decay=input$decay
  #intervention parameters
  pModelInt=pModel
  set10=pModelInt["beta1"]
  set11=pModelInt["beta1"]*(1-input$s1/100)
  set12=pModelInt["beta1"]*(1-input$s2/100)
  
  set20=pModelInt["beta2"]
  set21=pModelInt["beta2"]*(1-input$s1/100)
  set22=pModelInt["beta2"]*(1-input$s2/100)
  #s=c(set0,set1,set2)
  #change_time<-c(-1,Tint1-1,Tint2-1,Tmax)
  #pi <-rep(s,diff(change_time))
  
  #if(decay==1){
  #  change_time<-c(-1,Tint1-1,Tint2-1,Tmax)
  #  pi <-rep(s,diff(change_time))
  #  
  #} else if (decay==2){
  #  pi <- set0*exp(-lambda0*(0:(Tmax-1)))
  #}
  
  pModelInt["beta1"]=set12
  pModelInt["beta2"]=set22
  # intervention Ro and r values
  RoInt=GetRo_SEIR(pModelInt,N)
  
  E0=input$InitInf
  S0 = N-E0
  y0 = c(S=S0, E=E0, I1=0, I2=0, I3=0, R=0, D=0)
  
  if(Tint1==Tint2){
    if(Tint1==0){
      pModelInt["beta1"]=min(c(set11,set12))
      pModelInt["beta2"]=min(c(set21,set22))
      outInt.df=GetSpread_SEIR(pModelInt,Tmax,y0)
    }else if(Tint1==Tmax){
      outInt.df=GetSpread_SEIR(pModel,Tmax,y0)
    }else{
      out.df1=GetSpread_SEIR(pModel,Tint1,y0)
      
      iInt=nrow(out.df1)
      S0 = out.df1[iInt,"S"]
      E0 = out.df1[iInt,"E"]
      I10 = out.df1[iInt,"I1"]
      I20 = out.df1[iInt,"I2"]
      I30 = out.df1[iInt,"I3"]
      D0 = out.df1[iInt,"D"]
      R0 = out.df1[iInt,"R"]
      y0 = c(S=S0, E=E0, I1=I10, I2=I20, I3=I30, R=R0, D=D0)
      
      pModelInt["beta1"]=min(c(set11,set12))
      pModelInt["beta2"]=min(c(set21,set22))
      out.df2=GetSpread_SEIR(pModelInt,(Tmax-Tint1),y0)
      
      outInt.df=rbind(out.df1,out.df2[-1,])
      outInt.df$time=seq(0,Tmax,1)
    }
  }else if(Tint1<Tint2){
    if(Tint1==0&Tint2==Tmax){
      pModelInt["beta1"]=set11
      pModelInt["beta2"]=set21
      outInt.df=GetSpread_SEIR(pModelInt,Tmax,y0)
    }else if(Tint1>0 & Tint2==Tmax){
      out.df1=GetSpread_SEIR(pModel,Tint1,y0)
      
      iInt=nrow(out.df1)
      S0 = out.df1[iInt,"S"]
      E0 = out.df1[iInt,"E"]
      I10 = out.df1[iInt,"I1"]
      I20 = out.df1[iInt,"I2"]
      I30 = out.df1[iInt,"I3"]
      D0 = out.df1[iInt,"D"]
      R0 = out.df1[iInt,"R"]
      y0 = c(S=S0, E=E0, I1=I10, I2=I20, I3=I30, R=R0, D=D0)
      
      pModelInt["beta1"]=set11
      pModelInt["beta2"]=set21
      out.df2=GetSpread_SEIR(pModelInt,(Tmax-Tint1),y0)
      
      outInt.df=rbind(out.df1,out.df2[-1,])
      outInt.df$time=seq(0,Tmax,1)
    }else{
      out.df1=GetSpread_SEIR(pModel,Tint1,y0)
      
      iInt=nrow(out.df1)
      S0 = out.df1[iInt,"S"]
      E0 = out.df1[iInt,"E"]
      I10 = out.df1[iInt,"I1"]
      I20 = out.df1[iInt,"I2"]
      I30 = out.df1[iInt,"I3"]
      D0 = out.df1[iInt,"D"]
      R0 = out.df1[iInt,"R"]
      y0 = c(S=S0, E=E0, I1=I10, I2=I20, I3=I30, R=R0, D=D0)
      
      pModelInt["beta1"]=set11
      pModelInt["beta2"]=set21
      out.df2=GetSpread_SEIR(pModelInt,(Tint2-Tint1),y0)
      
      iInt=nrow(out.df2)
      S0 = out.df2[iInt,"S"]
      E0 = out.df2[iInt,"E"]
      I10 = out.df2[iInt,"I1"]
      I20 = out.df2[iInt,"I2"]
      I30 = out.df2[iInt,"I3"]
      D0 = out.df2[iInt,"D"]
      R0 = out.df2[iInt,"R"]
      y0 = c(S=S0, E=E0, I1=I10, I2=I20, I3=I30, R=R0, D=D0)
      
      pModelInt["beta1"]=set12
      pModelInt["beta2"]=set22
      out.df3=GetSpread_SEIR(pModelInt,(Tmax-Tint2),y0)
      
      outInt.df=rbind(out.df1,out.df2[-1,],out.df3[-1,])
      outInt.df$time=seq(0,Tmax,1)
    }
  }

  return(list("out.df"=outInt.df,"N"=N,"Ro"=RoInt))
  
}



