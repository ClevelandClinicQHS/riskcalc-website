# psa: enter prostate-specific antigen in ng/mL
# age: enter age in years
# race: enter 1 for African Ancestry, 0 otherwise
# priorbiopsy: enter 1 if there has been one or more prior biopsies (all negative for prostate cancer), 0 otherwise
# dre: enter 1 if digital rectal examination is abnormal (suspicious for prostate cancer), 0 otherwise
# famhistory: enter 1 if there is a first-degree family history of prostate cancer, 0 otherwise

# psa, age and race are mandatory, priorbiopsy, dre and famhistory are allowed missing

risk = function(psa, age, race, priorbiopsy, dre, famhistory) {
  
  ##### create persons data set
  data=c(1, log(psa,2), age, race)
  # is priorbiopsy known?
  a = as.numeric(is.na(priorbiopsy)==FALSE)
  if(a==1){data=c(data, priorbiopsy)}
  # is dre known?
  b = as.numeric(is.na(dre)==FALSE)
  if(b==1){data=c(data, dre)}
  # is famhistory known?
  c = as.numeric(is.na(famhistory)==FALSE)
  if(c==1){data=c(data, famhistory)}
  
  ##### choose correct model
  # psa, age, race, priorbiopsy, dre, famhistory
  if(a==1 & b==1 & c==1){
    no.low=c(-2.44052108 , 0.13617244 , 0.01780617 , 0.78721039 , -0.83613721 , 0.04612721 , 0.33233636)
    no.high=c(-6.36851856 , 0.79996510 , 0.05566536 , 0.61596975 , -1.27437249 , 0.85780143 , 0.61003848)
  }
  # psa, age, race, priorbiopsy, dre
  if(a==1 & b==1 & c==0){
    no.low=c(-2.29687989 , 0.13785591 , 0.01758914 , 0.63876791 , -0.86200471 , 0.07193350)
    no.high=c(-6.06621401 , 0.76053930 , 0.05509847 , 0.51701373 , -1.38390751 , 0.83442202)
  }
  # psa, age, race, priorbiopsy, famhistory
  if(a==1 & b==0 & c==1){
    no.low=c(-2.64840984 , 0.13125283 , 0.02044166 , 0.81792881 , -0.98610357 , 0.31447017)
    no.high=c(-6.70538152 , 0.77635003 , 0.06542705 , 0.52401464 , -1.43681965 , 0.55443478)
  }
  # psa, age, race, dre, famhistory
  if(a==0 & b==1 & c==1){
    no.low=c(-2.16147411 , 0.07409519 , 0.01322988 , 0.76131045 , 0.05397516 , 0.29246219)
    no.high=c(-5.99897055 , 0.70727793 , 0.04992968 , 0.56485952 , 0.89154384 , 0.56910873)
  }
  # psa, age, race, priorbiopsy
  if(a==1 & b==0 & c==0){
    no.low=c(-2.49050385 , 0.12961272 , 0.02020429 , 0.67674970 , -0.97275826)
    no.high=c(-6.41089002 , 0.74110558 , 0.06476911 , 0.42814591 , -1.50274350)
  }
  # psa, age, race, dre
  if(a==0 & b==1 & c==0){
    no.low=c(-2.01851079 , 0.06745424 , 0.01263369 , 0.63938472 , 0.08562844)
    no.high=c(-5.68203352 , 0.65059244 , 0.04883786 , 0.49214793 , 0.87421554)
  }
  # psa, age, race, famhistory
  if(a==0 & b==0 & c==1){
    no.low=c(-2.39161580 , 0.06129651 , 0.01600515 , 0.81132928 , 0.27501639)
    no.high=c(-6.42320154 , 0.67779036 , 0.06092178 , 0.50429130 , 0.50805684)
  }
  # psa, age, race
  if(a==0 & b==0 & c==0){
    no.low=c(-2.23794923 , 0.05343098 , 0.01553627 , 0.69593716)
    no.high=c(-6.13292904 , 0.62979529 , 0.06002002 , 0.43816016)
  }
  
  ##### predicting probabilities
  S1=no.low%*%data
  S2=no.high%*%data
  risk.no=1/(1+exp(S1)+exp(S2))*100
  risk.low=exp(S1)/(1+exp(S1)+exp(S2))*100
  # risk.high=100-risk.no-risk.low
  
  ##### Outcome
  risk.no=risk.no
  risk.low=risk.low
  risk.high=100-risk.no-risk.low
  
  ##### Outcome
  risk.outcome=cbind(risk.no,risk.low,risk.high)
  
  ##### Add Dimnames to Vector
  dimnames(risk.outcome)=list(NULL, c('Chance of No Cancer', 'Risk of Low Grade Cancer', 'Risk of High Grade Cancer'))

  return(risk.outcome)
}


####################################################################
####################################################################
# PCPTRC 2.0 with percent free PSA and detailed family history (update 17.09.2014)
####################################################################
####################################################################
#L2PSA = Log-base-2-transformed prostate-specific antigen in ng/mL
#DRE = Digital rectal exam, 1 (suspicious for prostate cancer) versus 0 (normal)
#PriorBiop = 1 (ever a prior biopsy negative for prostate cancer) versus 0 (otherwise)
#FamHist = 1 (prostate cancer in a father, brother or son) versus 0 (otherwise)
#AA = 1 (African American) versus 0 (otherwise)
#Age = Age in years
#S1 = -3.002 + 0.256L2PSA + 0.016Age + 0.122AA - 0.455PriorBiop - 0.039DRE + 0.272FamHist
#S2 = -7.053 + 0.705L2PSA + 0.048Age + 1.042AA - 0.214PriorBiop + 0.401DRE + 0.225FamHist
#Risk of no cancer = 1/[1 + exp(S1) + exp(S2)]
#Risk of low-grade cancer = exp(S1)/[1 + exp(S1) + exp(S2)]
#Risk of high-grade cancer = exp(S2)/[1 + exp(S1) + exp(S2)]

#new version 11.03.2014:
#added pct_freePSA (the model was fitted on a dataset with range 5.495801 72.955864)
#coefficients from regression are reported
#prob.update.high, prob.update.low, prob.update.no are the evaluated densities
#update.risk.high, update.risk.low, update.risk.no are the probabilities from the calculator
#updated with the likelihood ratios

#new version 17.09.2014:
#added: FDR_PC_less60, FDR_PC_60, FDR_BC and SDR

#new version 25.08.2106:
#added pca3 or pca3 and t2erg

#new version 05.09.2017:
#changed models for pca3 and t2:erg

risk_PCPT = function(psa, pct_freePSA, pca3, t2erg, age, race, priorbiopsy, dre, famhistory,
                FDR_PC_less60 = NA, FDR_PC_60 = NA, FDR_BC = NA, SDR = NA,SNP = NA, genotype = NA) {
  # if detailed family history data is given, use famihistory=0 for the prior risk
  if(!is.na(FDR_PC_less60)&!is.na(FDR_PC_60)&!is.na(FDR_BC)){famhistory=0}
  #indicator for detailed FH and SNPs
  flag=0
  ##### create persons data set
  data=c(1, log(psa,2), age, race)
  
  # prior biopsy known?
  a = as.numeric(is.na(priorbiopsy)==FALSE)
  if(a==1){data=c(data, priorbiopsy)}
  # DRE was recorded?
  b = as.numeric(is.na(dre)==FALSE)
  
  if(b==1){data=c(data, dre)}
  # family history was recorded?
  c = as.numeric(is.na(famhistory)==FALSE)
  if(c==1){data=c(data, famhistory)}
  
  ##### choose correct model
  if(a==1 & b==1 & c==1){
    # PSA, age, race, priorbiopsy, DRE, familyhistory
    no.low=c(-3.00215469, 0.25613390, 0.01643637, 0.12172599, -0.45533257, -0.03864628,
             0.27197219)
    no.high=c(-7.05304534, 0.70489441, 0.04753804, 1.04174529, -0.21409933, 0.40068434,
              0.22467348)
  }
  if(a==1 & b==1 & c==0){
    # PSA, age, race, priorbiopsy, DRE
    no.low=c(-2.89648245, 0.25904098, 0.01559192, 0.11996693, -0.45444000, -0.03729244)
    no.high=c(-6.96119633, 0.70674359, 0.04676393, 1.03937720, -0.21100921, 0.40319606)
  }
  if(a==1 & b==0 & c==1){
    # PSA, age, race, priorbiopsy, familyhistory
    no.low=c(-3.01529063, 0.25578861, 0.01654912, 0.12327661, -0.45825158, 0.27183869)
    no.high=c(-6.94522156, 0.70637260, 0.04697087, 1.02065099, -0.18320006, 0.23044734)
  }
  if(a==1 & b==0 & c==0){
    # PSA, age, race, priorbiopsy
    no.low=c(-2.90917471, 0.25872451, 0.01570165, 0.12141077, -0.45729181)
    no.high=c(-6.85264083, 0.70797314, 0.04621214, 1.01887797, -0.17972927)
  }
  if(a==0 & b==1 & c==1){
    # PSA, age, race, DRE, familyhistory
    no.low=c(-2.90933651, 0.23803667, 0.01447269, 0.11443251, -0.06592322, 0.27128248)
    no.high=c(-6.99449483, 0.69530025, 0.04637911, 1.03847001, 0.38651649, 0.22287791)
  }
  if(a==0 & b==1 & c==0){
    # PSA, age, race, DRE
    no.low=c(-2.80429793, 0.24127801, 0.01363705, 0.11165777, -0.06487585)
    no.high=c(-6.90681925, 0.69720305, 0.04566552, 1.03622425, 0.38925765)
  }
  if(a==0 & b==0 & c==1){
    # PSA, age, race, familyhistory
    no.low=c(-2.92983751, 0.23714373, 0.01463232, 0.11765430, 0.27095959)
    no.high=c(-6.90439295, 0.69799874, 0.04608130, 1.01787561, 0.22913998)
  }
  if(a==0 & b==0 & c==0){
    # PSA, age, race
    no.low=c(-2.81814489, 0.24044370, 0.01370219, 0.12000825)
    no.high=c(-6.84249970, 0.70043815, 0.04574460, 1.01699029)
  }
  
  
  
  ##### predicting probabilities
  S1=no.low%*%data
  S2=no.high%*%data
  
  risk.no=1/(1+exp(S1)+exp(S2))
  risk.low=exp(S1)/(1+exp(S1)+exp(S2))
  risk.high=1-risk.no-risk.low
  
  #### update 11.03.2014 with pct_freePSA ### Moved some pieces specific to percent free
  #### PSA to here on 29.08.2016
  
  #is pct_freePSA value provided?
  #if not then skip the section below
  if(!is.na(pct_freePSA)){
    
    #update percent free psa
    #intercept log2 psa sd
    #coefficients from linear regression with standard error
    #coef.high corresponds to highgrade cancer #coef.low corresponds to lowgrade cancer
    #coef.no corresponds to no cancer
    coef.high = c(4.8059009, -0.3483031); sd.high = 0.6452902
    coef.low = c(4.9730353, -0.3856204); sd.low = 0.6010974
    coef.no = c(4.9602101, -0.2195069); sd.no = 0.5154306
    #normal densities are evaluated
    prob.update.high = dnorm(log2(pct_freePSA), coef.high %*% c(1, log2(psa)),sd.high) #highgrade
    prob.update.low = dnorm(log2(pct_freePSA), coef.low %*% c(1, log2(psa)),sd.low) #lowgrade
    prob.update.no = dnorm(log2(pct_freePSA), coef.no %*% c(1, log2(psa)),sd.no) #no cancer
    
    #the probability of the PCPTRC2.0 is updated with the likelihood ratios
    update.risk.high = risk.high * prob.update.high / (risk.no * prob.update.no +risk.low *
                                                         prob.update.low)
    update.risk.low = risk.low * prob.update.low / (risk.no * prob.update.no + risk.high *
                                                      prob.update.high)
    update.risk.no = risk.no * prob.update.no / (risk.low * prob.update.low + risk.high *
                                                   prob.update.high)
    
    #transformation to probability scale and rounding
    risk.low = update.risk.low / (update.risk.low +1)
    risk.no = update.risk.no / (update.risk.no +1)
    risk.high = 1 - risk.low - risk.no
    
  }
  
  #### update 25.08.2016 with pca3 #############################
  
  #is pca3 provided?
  #if not then skip the section below
  #See Supplementary Appendix of paper for all formulas
  if(!is.na(pca3)){
    #range check pca3 0.3 to 332.5 allowed
    #intercept age race sd
    #coefficients from linear regression, standard error forced to be equal
    #coef.high corresponds to highgrade cancer
    #coef.low corresponds to lowgrade cancer
    #coef.no corresponds to no cancer
    #sd = 1.367
    sd = 1.51
    #coef.high = c(1.163+1.203,0.045,0.482)
    #coef.low = c(1.163+1.056,0.045, 0.482)
    #coef.no = c(1.163,0.045, 0.482)
    coef.high = c(0.346+1.222,0.058,0.733)
    coef.low = c(0.346+0.908,0.058,0.733)
    coef.no = c(0.346,0.058,0.733)
    
    
    #normal densities are evaluated
    prob.update.high = dnorm(log2(pca3), coef.high %*% c(1, age, race),sd) #highgrade
    prob.update.low = dnorm(log2(pca3), coef.low %*% c(1, age, race),sd) #lowgrade
    prob.update.no = dnorm(log2(pca3), coef.no %*% c(1, age, race),sd) #no cancer
    
    #is t2erg provided in addition?, if not then skip this section
    if (!is.na(pca3) & !is.na(t2erg)) {
      #range check t2erg 0.0 – 6031.6 for
      #logistic regression coefficients for non-zero t2erg
      #intercept log2(pca3) race
      #logistic.high = c(0.298 + 0.545, 0.157,-0.873)
      #logistic.low = c(0.298 + 0.930, 0.157,-0.873)
      #logistic.no = c(0.298, 0.157,-0.873)
      logistic.high = c(0.2 + 0.46, 0.18,-0.507)
      logistic.low = c(0.2 + 0.60, 0.18,-0.507)
      logistic.no = c(0.2, 0.18,-0.507)
      nonzerot2erg =as.numeric(t2erg!=0)
      linear.high = logistic.high %*% c(1,log2(pca3),race)
      linear.low = logistic.low %*% c(1,log2(pca3),race)
      linear.no = logistic.no %*% c(1,log2(pca3),race)
      binomprob.high = exp(linear.high)/(1+exp(linear.high))
      binomprob.low = exp(linear.low)/(1+exp(linear.low))
      binomprob.no = exp(linear.no)/(1+exp(linear.no))
      prob.update.high = prob.update.high*dbinom(nonzerot2erg,1,binomprob.high)
      prob.update.low = prob.update.low*dbinom(nonzerot2erg,1,binomprob.low)
      prob.update.no=prob.update.no*dbinom(nonzerot2erg,1,binomprob.no)
      if (nonzerot2erg) {
        #linear regression coefficients for log2(t2erg)
        #intercept log2(pca3)
        sd = 2.87
        coef.high = c(0.911+2.037,0.398)
        coef.low = c(0.911+0.971,0.398)
        coef.no = c(0.911,0.511)
        prob.update.high = prob.update.high*dnorm(log2(t2erg), coef.high %*% c(1, log2(pca3)),sd)
        prob.update.low = prob.update.low*dnorm(log2(t2erg), coef.low %*% c(1,log2(pca3)),sd)
        prob.update.no = prob.update.no*dnorm(log2(t2erg), coef.no %*% c(1,log2(pca3)),sd)
      }
      
    }
    #end of t2erg section
    
    #the probability of the PCPTRC2.0 is updated with the likelihood ratios
    update.risk.high = risk.high * prob.update.high / (risk.no * prob.update.no +risk.low * prob.update.low)
    update.risk.low = risk.low * prob.update.low / (risk.no * prob.update.no + risk.high * prob.update.high)
    update.risk.no = risk.no * prob.update.no / (risk.low * prob.update.low + risk.high * prob.update.high)
    
    #transformation to probability scale and rounding
    risk.low = update.risk.low / (update.risk.low +1)
    risk.no = update.risk.no / (update.risk.no +1)
    risk.high = 1 - risk.low - risk.no
    
  }
  if (is.na(pca3) & !is.na(t2erg)) {
    risk.low = NA
    risk.no = NA
    risk.high = NA
  }
  
  #### end of update 25.08.2016 with pca3 #############################
  
  
  #### update 17.09.2014 with detailed family history -----
  #FDR_PC_less60 corresponds to number of FDRs diagnosed with prostate cancer at < 60 years of age
  #FDR_PC_60 corresponds to number of FDRs diagnosed with prostate cancer at >= 60 years of age
  #FDR_BC corresponds to number of FDRs with breast cancer
  #SDR corresponds to the number of SDRs with prostate cancer
  #combine low and high grade cancer, differentiation not available for family history update
  
  #is detailed family history provided?
  #if not then skip the section below
  if(!is.na(FDR_PC_less60)&!is.na(FDR_PC_60)&!is.na(FDR_BC)){
    flag=1
    risk.ca=risk.low+risk.high
    #determine family history pattern and corresponding LR
    if(FDR_PC_less60==0){
      if(FDR_PC_60==0){
        if(FDR_BC==0){LR=0.92}
        if(FDR_BC>=1){LR=0.90}
        #include SDR history conditional on FDR history only here
        if(SDR>=1){LR=LR*1.09}
      }
      if(FDR_PC_60==1){
        if(FDR_BC==0){LR=1.63}
        if(FDR_BC>=1){LR=1.87}
      }
      if(FDR_PC_60>=2){
        if(FDR_BC==0){LR=3.46}
        if(FDR_BC>=1){LR=3.72}
      }
    }
    if(FDR_PC_less60==1){
      if(FDR_PC_60==0){
        if(FDR_BC==0){LR=2.47}
        if(FDR_BC>=1){LR=2.30}
      }
      if(FDR_PC_60==1){
        if(FDR_BC==0){LR=3.65}
        if(FDR_BC>=1){LR=6.59}
      }
      if(FDR_PC_60>=2){LR=6.28}
    }
    if(FDR_PC_less60>=2){
      if(FDR_PC_60==0){
        if(FDR_BC==0){LR=5.68}
        if(FDR_BC>=1){LR=7.71}
      }
      if(FDR_PC_60==1){
        if(FDR_BC==0){LR=9.92}
        if(FDR_BC>=1){LR=11.57}
      }
      if(FDR_PC_60>=2){
        if(FDR_BC==0){LR=21.21}
        if(FDR_BC==1){LR=15.91}
      }
    }
    
    
    priorodds = risk.ca/risk.no
    
    #the probability of the PCPTRC2.0 is updated with the likelihood ratios for the specific family history pattern
    risk.ca = (LR * priorodds)/(LR * priorodds + 1)
    risk.no =  1/(1 + LR * priorodds)
    
  }
  
  #### update 27.01.2015 with 30 SNPs -----
  # a combination of up to 5 SNPs is possible.
  # variable SNP provides which SNPs are measured (vector of length 1,2,3,4 or 5 with the SNP Number according to Table1)
  # variable genotype states for each SNP how many risk alleles (0,1 or 2 risk alleles) (vector of length 1,2,3,4 or 5)
  # combine low and high grade cancer, differentiation not available for SNP update
  
  #is SNP information available?
  #if not then skip the section below
  #define three LR vectors for the three genotypes
  
  if(!is.na(sum(SNP))&!is.na(sum(genotype))){
    if(flag==0){risk.ca=risk.low+risk.high}
    flag=1
    LR0<-c(0.949,0.959,1,0.977,0.960, 0.874, 0.868, 0.937, 0.939, 0.881, 0.922, 0.806, 0.955, 0.948, 0.899, 0.818,
           0.917, 0.861, 1, 0.927, 0.848, 0.824, 0.814, 0.863, 0.890, 0.880, 0.800,1, 0.851 ,0.865 )
    LR1<-c(1.073, 1.062,0.779, 1.066,1,0.945, 1, 1, 1,1, 1, 1, 1.575, 1.129, 0.971, 1, 1.307, 1, 1, 1.118, 1, 0.929, 1, 1, 1, 0.934, 0.890,1, 1, 1.044)
    LR2<-c(1.179,1.164,1.031,1.407,1,1.093, 1.101, 1, 1.100, 1.123, 1.105, 1.069, 2.552, 1.355, 1.067, 1.188, 1.887,
           1.291, 1, 1.291, 1.173, 1.044, 1.194, 1.226, 1.109, 1.055, 1.044,1, 1.161, 1.262)
    
    #determine the corresponding LRs
    LR=1
    for (i in 1:length(SNP)){
      if(genotype[i]==0){LR=LR*LR0[SNP[i]]}
      if(genotype[i]==1){LR=LR*LR1[SNP[i]]}
      if(genotype[i]==2){LR=LR*LR2[SNP[i]]}
    }
    
    
    priorodds = risk.ca/risk.no
    
    #the probability of the PCPTRC2.0 is updated with the likelihood ratios for the specific family history pattern
    risk.ca = (LR * priorodds)/(LR * priorodds + 1)
    risk.no =  1/(1 + LR * priorodds)
    
  }
  #if no detailed FH and no SNPs are given, round and report the 3-dim outcome, otherwise 2-dim
  if(flag==0){
    #round
    risk.no=(risk.no * 100)
    risk.low=(risk.low * 100)
    risk.high=100-risk.no-risk.low
    
    risk.no=round(risk.no)
    risk.low=round(risk.low)
    risk.high=round(risk.high)
    
    ##### Outcome
    risk.outcome=cbind(risk.no,risk.low,risk.high)
    
    ##### Add Dimnames to Vector
    dimnames(risk.outcome)=list(NULL, c('Chance of No Cancer', 'Risk of Low Grade Cancer', 'Risk of
                                        High Grade Cancer'))
  }else{
    risk.ca=round(risk.ca * 100)
    risk.no=round(risk.no * 100)
    
    ##limit risk
    if(risk.ca>75){
      risk.ca = 75
      risk.no = 25
    }
    
    ##### Outcome
    risk.outcome=cbind(risk.no,risk.ca)
    
    ##### Add Dimnames to Vector
    dimnames(risk.outcome)=list(NULL, c('Chance of No Cancer', 'Risk of Cancer'))
    
  }
  return(risk.outcome)
}