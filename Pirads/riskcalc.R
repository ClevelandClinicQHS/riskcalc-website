
####################################################################
####################################################################
# TUM-RC (07.11.2023)
####################################################################
####################################################################
#outcome: csPCa3 : ISUP>2
#log. reg. model csPCa3 ~ Age10 + l2density + PIRADS + Prior_neg_biopsy
#PSA = prostate-specific antigen density in ng/mL
#Volume = prostate volume in cc
#Age10 = Age in 10-year steps
#l2density = Log-base-2-transformed PSA density: log2(PSA/Volume)
#Prior_neg_biopsy = 1 (ever a prior biopsy negative for prostate cancer) versus 0 (otherwise)

#S= -6.1785 + 0.4933*Age10 + 0.4688*l2density + 0.8548*PIRADS - 0.8491*Prior_neg_biopsy 
#Risk of no csPCa = 1/[1 + exp(S)]
#Risk of csPCa = exp(S)/[1 + exp(S)]

risk = function(Age,density,PIRADS,Prior_neg_biopsy) {
  ##### create persons data set 
  
  Age10=Age/10
  l2density=log2(density)
  
  data=c(1,Age10,l2density,PIRADS,Prior_neg_biopsy)
  
  S= -6.1785 + 0.4933*Age10 + 0.4688*l2density + 0.8548*PIRADS - 0.8491*Prior_neg_biopsy 
  
  risk.no=1/(1+exp(S))
  risk.csPCa=1-risk.no
  
  risk.outcome=cbind(risk.no,risk.csPCa)*100 # in percentage
    
  ##### Add Dimnames to Vector
  dimnames(risk.outcome)=list(NULL, c('Chance of no csPCa', 'Risk of csPCa (ISUP>2)'))
    
  return(risk.outcome)
}