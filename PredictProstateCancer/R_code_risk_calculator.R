# psa: enter prostate-specific antigen in ng/mL
# age: enter age in years
# race: enter 1 for African Ancestry, 0 otherwise
# priorbiopsy: enter 1 if there has been one or more prior biopsies (all negative for prostate cancer), 0 otherwise
# dre: enter 1 if digital rectal examination is abnormal (suspicious for prostate cancer), 0 otherwise
# famhistory: enter 1 if there is a first-degree family history of prostate cancer, 0 otherwise




# psa, age and race are mandatory, priorbiopsy, dre and famhistory are allowed missing
risk = function(Age = Age, PSA = PSA, Prompt = Prompt, DRE = DRE, FamHX = FamHX) {
  age = rcs(c(Age), c(53.3, 64.45, 74.61))
  age1 = as.vector(age)[1]
  age2 = as.vector(age)[2]
  psa = rcs(c(PSA), c(2.570, 5.605, 11.900))
  psa1 = as.vector(psa)[1]
  psa2 = as.vector(psa)[2]
  prompt = rcs(c(Prompt),c(0.354,0.860,1.803))
  prompt1 = as.vector(prompt)[1]
  prompt2 = as.vector(prompt)[2]
  
  fit1.low = -1.220689 - log((1-0.14) / 0.14 * 0.36/0.64)  + 0.01490701 * age1 + 0.006523653 * age2 + 0.2513077 * FamHX
  fit1.high = -2.487868 - log((1-0.04) / 0.04 * 0.21/0.79) + 0.02324159 * age1 + 0.029742822 * age2 + 0.3113015 * FamHX
  
  risk.neg1 = 1 / (exp(fit1.low) + exp(fit1.high) + 1)
  risk.low1 = round(exp(fit1.low) * risk.neg1 * 1000)
  risk.high1 = round(exp(fit1.high) * risk.neg1 * 1000)
  risk.neg1 = 1000 - risk.low1 - risk.high1
  
  fit2.low = -1.894625 - log((1-0.14) / 0.14 * 0.36/0.64) + 0.01259611 * age1 + 0.009261383 * age2 + 0.2738444 * FamHX + 1.172013 * prompt1 + -1.304782 * prompt2
  fit2.high = -3.560674 - log((1-0.04) / 0.04 * 0.21/0.79) + 0.02337383 * age1 + 0.031075152 * age2 + 0.3241195 * FamHX + 1.350144 * prompt1 + -1.096314 * prompt2
  
  risk.neg2 = 1 / (exp(fit2.low) + exp(fit2.high) + 1)
  risk.low2 = round(exp(fit2.low) * risk.neg2 * 1000)
  risk.high2 = round(exp(fit2.high) * risk.neg2 * 1000)
  risk.neg2 = 1000 - risk.low2 - risk.high2
  
  fit3.low = -1.413980 - log((1-0.14) / 0.14 * 0.36/0.64) + 0.016307230 * age1 + 0.004387034 * age2 + 0.2296109 * FamHX + 0.02382053 * psa1 + -0.0665921 * psa2 + 0.3232089 * DRE
  fit3.high = -3.172067 - log((1-0.04) / 0.04 * 0.21/0.79) + 0.004982674 * age1 + 0.034284538 * age2 + 0.3257238 * FamHX + 0.25251326 * psa1 + -0.2326998 * psa2 + 1.4681579 * DRE
  
  risk.neg3 = 1 / (exp(fit3.low) + exp(fit3.high) + 1)
  risk.low3 = round(exp(fit3.low) * risk.neg3 * 1000)
  risk.high3 = round(exp(fit3.high) * risk.neg3 * 1000)
  risk.neg3 = 1000 - risk.low3 - risk.high3
  
  fit4.low = -2.098867 - log((1-0.14) / 0.14 * 0.36/0.64) + 0.014487800 * age1 + 0.006448289 * age2 + 0.2519112 * FamHX + 0.01694281 * psa1 + -0.05964471 * psa2 + 0.3295875 * DRE + 1.196466 * prompt1 + -1.338695 * prompt2
  fit4.high = -4.312286 - log((1-0.04) / 0.04 * 0.21/0.79) + 0.006388085 * age1 + 0.034469015 * age2 + 0.3240178 * FamHX + 0.24638173 * psa1 + -0.22607433 * psa2 + 1.4955614 * DRE + 1.363544 * prompt1 + -1.097636 * prompt2
  
  risk.neg4 = 1 / (exp(fit4.low) + exp(fit4.high) + 1)
  risk.low4 = round(exp(fit4.low) * risk.neg4 * 1000)
  risk.high4 = round(exp(fit4.high) * risk.neg4 * 1000)
  risk.neg4 = 1000 - risk.low4 - risk.high4
  
  fit5.low = -1.413980 + 0.016307230 * age1 + 0.004387034 * age2 + 0.2296109 * FamHX + 0.02382053 * psa1 + -0.0665921 * psa2 + 0.3232089 * DRE
  fit5.high = -3.172067 + 0.004982674 * age1 + 0.034284538 * age2 + 0.3257238 * FamHX + 0.25251326 * psa1 + -0.2326998 * psa2 + 1.4681579 * DRE
  
  risk.neg5 = 1 / (exp(fit5.low) + exp(fit5.high) + 1)
  risk.low5 = round(exp(fit5.low) * risk.neg5 * 1000)
  risk.high5 = round(exp(fit5.high) * risk.neg5 * 1000)
  risk.neg5 = 1000 - risk.low5 - risk.high5
  
  fit6.low = -2.098867 + 0.014487800 * age1 + 0.006448289 * age2 + 0.2519112 * FamHX + 0.01694281 * psa1 + -0.05964471 * psa2 + 0.3295875 * DRE + 1.196466 * prompt1 + -1.338695 * prompt2
  fit6.high = -4.312286 + 0.006388085 * age1 + 0.034469015 * age2 + 0.3240178 * FamHX + 0.24638173 * psa1 + -0.22607433 * psa2 + 1.4955614 * DRE + 1.363544 * prompt1 + -1.097636 * prompt2
  
  risk.neg6 = 1 / (exp(fit6.low) + exp(fit6.high) + 1)
  risk.low6 = round(exp(fit6.low) * risk.neg6 * 1000)
  risk.high6 = round(exp(fit6.high) * risk.neg6 * 1000)
  risk.neg6 = 1000 - risk.low6 - risk.high6
  
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
                   risk.high4,
                   risk.neg5,
                   risk.low5,
                   risk.high5,
                   risk.neg6,
                   risk.low6,
                   risk.high6)
  
  return(risk.outcome)
}
