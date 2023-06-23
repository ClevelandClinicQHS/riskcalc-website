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
  risk.no=round(risk.no)
  risk.low=round(risk.low)
  risk.high=100-risk.no-risk.low
  
  ##### Outcome
  risk.outcome=cbind(risk.no,risk.low,risk.high)
  
  ##### Add Dimnames to Vector
  dimnames(risk.outcome)=list(NULL, c('Chance of No Cancer', 'Risk of Low Grade Cancer', 'Risk of High Grade Cancer'))

  return(risk.outcome)
}
