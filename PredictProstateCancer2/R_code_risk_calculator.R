# psa: enter prostate-specific antigen in ng/mL
# age: enter age in years
# race: enter 1 for African Ancestry, 0 otherwise
# priorbiopsy: enter 1 if there has been one or more prior biopsies (all negative for prostate cancer), 0 otherwise
# dre: enter 1 if digital rectal examination is abnormal (suspicious for prostate cancer), 0 otherwise
# famhistory: enter 1 if there is a first-degree family history of prostate cancer, 0 otherwise




# psa, age and race are mandatory, priorbiopsy, dre and famhistory are allowed missing
risk = function(Age = Age, PSA = PSA, Prompt = Prompt) {
  age = rcs(c(Age), c(53.3, 64.45, 74.61))
  age1 = as.vector(age)[1]
  age2 = as.vector(age)[2]
  psa = rcs(c(PSA), c(2.570, 5.605, 11.900))
  psa1 = as.vector(psa)[1]
  psa2 = as.vector(psa)[2]
  prompt = rcs(c(Prompt),c(0.354,0.860,1.803))
  prompt1 = as.vector(prompt)[1]
  prompt2 = as.vector(prompt)[2]
  
  fit1.low = -1.161247 - log((1-0.14) / 0.14 * 0.36/0.64)  + 0.01537635 * age1 + 0.006796506 * age2 + 0.004252489 * psa1 + -0.04703878 * psa2
  fit1.high = -2.601431 - log((1-0.04) / 0.04 * 0.21/0.79) + 0.01072251 * age1 + 0.033492713 * age2 + 0.167305611 * psa1 + -0.13730554 * psa2
  
  risk.neg1 = 1 / (exp(fit1.low) + exp(fit1.high) + 1)
  risk.low1 = round(exp(fit1.low) * risk.neg1 * 1000)
  risk.high1 = round(exp(fit1.high) * risk.neg1 * 1000)
  risk.neg1 = 1000 - risk.low1 - risk.high1
  
  fit2.low = -1.827615 - log((1-0.14) / 0.14 * 0.36/0.64) + 0.01345542 * age1 + 0.009138863 * age2 + -0.0009138257 * psa1 + -0.04307176 * psa2 + 1.171349 * prompt1 + -1.2976914 * prompt2
  fit2.high = -3.587598 - log((1-0.04) / 0.04 * 0.21/0.79) + 0.01194945 * age1 + 0.034012703 * age2 + 0.1568920085 * psa1 + -0.12705581 * psa2 + 1.203475 * prompt1 + -0.9117661 * prompt2
  
  risk.neg2 = 1 / (exp(fit2.low) + exp(fit2.high) + 1)
  risk.low2 = round(exp(fit2.low) * risk.neg2 * 1000)
  risk.high2 = round(exp(fit2.high) * risk.neg2 * 1000)
  risk.neg2 = 1000 - risk.low2 - risk.high2
  
  fit3.low = -1.161247 + 0.01537635 * age1 + 0.006796506 * age2 + 0.004252489 * psa1 + -0.04703878 * psa2
  fit3.high = -2.601431 + 0.01072251 * age1 + 0.033492713 * age2 + 0.167305611 * psa1 + -0.13730554 * psa2
  
  risk.neg3 = 1 / (exp(fit3.low) + exp(fit3.high) + 1)
  risk.low3 = round(exp(fit3.low) * risk.neg3 * 1000)
  risk.high3 = round(exp(fit3.high) * risk.neg3 * 1000)
  risk.neg3 = 1000 - risk.low3 - risk.high3
  
  fit4.low = -1.827615 + 0.01345542 * age1 + 0.009138863 * age2 + -0.0009138257 * psa1 + -0.04307176 * psa2 + 1.171349 * prompt1 + -1.2976914 * prompt2
  fit4.high = -3.587598 + 0.01194945 * age1 + 0.034012703 * age2 + 0.1568920085 * psa1 + -0.12705581 * psa2 + 1.203475 * prompt1 + -0.9117661 * prompt2

  risk.neg4 = 1 / (exp(fit4.low) + exp(fit4.high) + 1)
  risk.low4 = round(exp(fit4.low) * risk.neg4 * 1000)
  risk.high4 = round(exp(fit4.high) * risk.neg4 * 1000)
  risk.neg4 = 1000 - risk.low4 - risk.high4
  
  risk.outcome = c(risk.neg1,
                   risk.low1,
                   risk.high1,
                   risk.neg2,
                   risk.low2,
                   risk.high2,
                   risk.neg3,
                   risk.low3,
                   risk.high3,
                   risk.neg4,
                   risk.low4,
                   risk.high4)
  
  return(risk.outcome)
}
