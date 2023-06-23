require(shiny)



######################################################################################################## Before Delivery Models
########################################################12 year models(ProLong)
#####POP
## Vaginal
ProLong.POP.vag.before <- expression({
  lp <- 3.6956988 - 0.050854279 * Age.b - 0.024768861 * height.b + 0.39409592 * (FH.POP.b == "Yes") + 0.71334542 * (uiprepreg.b == "Yes") + 0.6891609 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.POP.csec.before <- expression({
  lp <- 3.6956988 - 0.050854279 * Age.b - 0.024768861 * height.b + 0.39409592 * (FH.POP.b == "Yes") + 0.71334542 * (uiprepreg.b == "Yes") + 0.6891609 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
#####Bothersome POP
## Vaginal
ProLong.BotherPOP.vag.before <- expression({
  lp <- 3.9793057 + 0.24187659 * parity_b - 0.09973269 * Age.b + 0.016401187 * 
    PrepregWeight_b - 0.03425059 * height.b + 0.52574193 * (FH.POP.b == "Yes") + 0.55326307 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.BotherPOP.csec.before <- expression({
  lp <- 3.9793057 + 0.24187659 * parity_b - 0.09973269 * Age.b + 0.016401187 * 
    PrepregWeight_b - 0.03425059 * height.b + 0.52574193 * (FH.POP.b == "Yes") + 0.55326307 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
#####Treatment for POP
## Vaginal
ProLong.TreatPOP.vag.before <- expression({
  lp <- -10.447932 + 0.13671401 * Age.b + 0.021626867 * PrepregWeight_b + 0.00033922595 * BirthWeight.b + 0.97867607 * (FH.POP.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.TreatPOP.csec.before <- expression({
  lp <- -10.447932 + 0.13671401 * Age.b + 0.021626867 * PrepregWeight_b + 0.00033922595 * BirthWeight.b + 0.97867607 * (FH.POP.b == "Yes");
  1/(1+exp(-lp))
})
#####Composite of POP
## Vaginal
ProLong.CompoPOP.vag.before <- expression({
  lp <- 2.2275621 + 0.17752923 * parity_b - 0.037355951 * Age.b + 0.019116688 * 
    PrepregWeight_b - 0.032110696 * height.b + 0.63984451 * (FH.POP.b == "Yes") + 0.53246377 * (uiprepreg.b == "Yes") + 0.42596158 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
## Vaginal
ProLong.CompoPOP.csec.before <- expression({
  lp <- 2.2275621 + 0.17752923 * parity_b - 0.037355951 * Age.b + 0.019116688 * 
    PrepregWeight_b - 0.032110696 * height.b + 0.63984451 * (FH.POP.b == "Yes") + 0.53246377 * (uiprepreg.b == "Yes") + 0.42596158 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
#####UI
## Vaginal
ProLong.UI.vag.before <- expression({
  lp <- -1.0992483 - 0.12107433 * parity_b + 0.024783245 * Age.b + 0.35082349 * 
    1 + 0.50857387 * (FH.POP.b == "Yes") + 1.7820322 * (uiprepreg.b == "Yes") + 1.4187054 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.UI.csec.before <- expression({
  lp <- -1.0992483 - 0.12107433 * parity_b + 0.024783245 * Age.b + 0.35082349 * 
    0 + 0.50857387 * (FH.POP.b == "Yes") + 1.7820322 * (uiprepreg.b == "Yes") + 1.4187054 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
#####Bothersome UI
## Vaginal
ProLong.BotherUI.vag.before <- expression({
  lp <- 1.0640506 - 0.07994981 * parity_b + 0.018134236 * PrepregWeight_b - 0.021088737 * height.b + 0.30652063 * 1 + 
    0.52721895 * (FH.POP.b == "Yes") + 1.5436131 * (uiprepreg.b == "Yes") + 1.3107707 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.BotherUI.csec.before <- expression({
  lp <- 1.0640506 - 0.07994981 * parity_b + 0.018134236 * PrepregWeight_b - 0.021088737 * height.b + 0.30652063 * 0 + 
    0.52721895 * (FH.POP.b == "Yes") + 1.5436131 * (uiprepreg.b == "Yes") + 1.3107707 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
#####Treatment for UI
## Vaginal
ProLong.TreatUI.vag.before <- expression({
  lp <- -1.649538 - 0.22847971 * parity_b + 0.046745714 * Age.b - 0.020091952 * 
    height.b + 0.99380684 * 1 + 1.5257638 * (uiprepreg.b == "Yes") + 0.31507231 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.TreatUI.csec.before <- expression({
  lp <- -1.649538 - 0.22847971 * parity_b + 0.046745714 * Age.b - 0.020091952 * 
    height.b + 0.99380684 * 0 + 1.5257638 * (uiprepreg.b == "Yes") + 0.31507231 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
#####Composite of UI
## Vaginal
ProLong.CompoUI.vag.before <- expression({
  lp <- 1.603181 - 0.087259326 * parity_b + 0.01970003 * PrepregWeight_b - 0.024598056 * height.b + 0.39094911 * 1 + 
    0.47230596 * (FH.POP.b == "Yes") + 1.785147 * (uiprepreg.b == "Yes") + 1.2919741 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.CompoUI.csec.before <- expression({
  lp <- 1.603181 - 0.087259326 * parity_b + 0.01970003 * PrepregWeight_b - 0.024598056 * height.b + 0.39094911 * 0 + 
    0.47230596 * (FH.POP.b == "Yes") + 1.785147 * (uiprepreg.b == "Yes") + 1.2919741 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
#####Any FI
## Vaginal
ProLong.AnyFI.vag.before <- expression({
  lp <- -0.70880645 + 0.026725689 * Age.b + 0.023984978 * PrepregWeight_b - 0.021730371 * height.b + 0.6049813 * (uiprepreg.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.AnyFI.csec.before <- expression({
  lp <- -0.70880645 + 0.026725689 * Age.b + 0.023984978 * PrepregWeight_b - 0.021730371 * height.b + 0.6049813 * (uiprepreg.b == "Yes");
  1/(1+exp(-lp))
})
#####Bothersome FI
## Vaginal
ProLong.BotherFI.vag.before <- expression({
  lp <- -1.3569386 + 0.19763021 * parity_b - 0.048361427 * Age.b + 0.019652322 * PrepregWeight_b - 0.12046018 * Bwt.height.b - 0.046894926 * 
    circumference.b - 0.53435032 * 1 + 0.060987469 * (FH.POP.b == "Yes") + 1.2103 * (uiprepreg.b == "Yes") + 0.66119937 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.BotherFI.csec.before <- expression({
  lp <- -1.3569386 + 0.19763021 * parity_b - 0.048361427 * Age.b + 0.019652322 * PrepregWeight_b - 0.12046018 * Bwt.height.b - 0.046894926 * 
    circumference.b - 0.53435032 * 0 + 0.060987469 * (FH.POP.b == "Yes") + 1.2103 * (uiprepreg.b == "Yes") + 0.66119937 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
#####Treatment for FI
## Vaginal
ProLong.TreatFI.vag.before <- expression({
  lp <- -2.4067932 + 0.030784593 * PrepregWeight_b - 0.67659832 * Bwt.height.b;
  1/(1+exp(-lp))
})
## C-Section
ProLong.TreatFI.csec.before <- expression({
  lp <- -2.4067932 + 0.030784593 * PrepregWeight_b - 0.67659832 * Bwt.height.b;
  1/(1+exp(-lp))
})
#####Composite of FI
## Vaginal
ProLong.CompoFI.vag.before <- expression({
  lp <- -2.8137274 - 0.031385373 * Age.b + 0.028497827 * PrepregWeight_b - 0.26192183 * Bwt.height.b + 0.74611988 * (uiprepreg.b == "Yes") + 0.65732878 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.CompoFI.csec.before <- expression({
  lp <- -2.8137274 - 0.031385373 * Age.b + 0.028497827 * PrepregWeight_b - 0.26192183 * Bwt.height.b + 0.74611988 * (uiprepreg.b == "Yes") + 0.65732878 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
#####Any PFD
## Vaginal
ProLong.AnyPFD.vag.before <- expression({
  lp <- 1.6187199 - 0.16397949 * parity_b + 0.01351673 * Age.b + 0.011180323 * PrepregWeight_b - 0.016231275 * height.b + 0.37554541 * 1 + 
    0.55535281 * (FH.POP.b == "Yes") + 1.7588291 * (uiprepreg == "Yes") + 1.2441832 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.AnyPFD.csec.before <- expression({
  lp <- 1.6187199 - 0.16397949 * parity_b + 0.01351673 * Age.b + 0.011180323 * PrepregWeight_b - 0.016231275 * height.b + 0.37554541 * 0 + 
    0.55535281 * (FH.POP.b == "Yes") + 1.7588291 * (uiprepreg == "Yes") + 1.2441832 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
#####Bothersome PFD
## Vaginal
ProLong.BotherPFD.vag.before <- expression({
  lp <- 0.77978215 - 0.090103357 * parity_b + 0.019183459 * PrepregWeight_b - 0.018518821 * height.b + 0.27994143 * 1 + 
    0.60655156 * (FH.POP.b == "Yes") + 1.4969551 * (uiprepreg.b == "Yes") + 1.157906 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.BotherPFD.csec.before <- expression({
  lp <- 0.77978215 - 0.090103357 * parity_b + 0.019183459 * PrepregWeight_b - 0.018518821 * height.b + 0.27994143 * 0 + 
    0.60655156 * (FH.POP.b == "Yes") + 1.4969551 * (uiprepreg.b == "Yes") + 1.157906 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
#####Treatment for PFD
## Vaginal
ProLong.TreatPFD.vag.before <- expression({
  lp <- -0.2011576 + 0.016845475 * PrepregWeight_b - 0.69159835 * Bwt.height.b + 0.13699403 * max(Bwt.height.b - 4.0190046, 0)**3 - 0.21938738 * 
    max(Bwt.height.b - 4.7875286, 0)**3 + 0.082393356 * max(Bwt.height.b - 6.0653403, 0)**3 + 1.270255 * (uiprepreg.b == "Yes") + 0.45241401 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.TreatPFD.csec.before <- expression({
  lp <- -0.2011576 + 0.016845475 * PrepregWeight_b - 0.69159835 * Bwt.height.b + 0.13699403 * max(Bwt.height.b - 4.0190046, 0)**3 - 0.21938738 * 
    max(Bwt.height.b - 4.7875286, 0)**3 + 0.082393356 * max(Bwt.height.b - 6.0653403, 0)**3 + 1.270255 * (uiprepreg.b == "Yes") + 0.45241401 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
#####Composite of PFD
## Vaginal
ProLong.CompoPFD.vag.before <- expression({
  lp <- 1.3422924 - 0.069592472 * parity_b + 0.021767577 * PrepregWeight_b - 0.024359092 * height.b + 0.00015663884 * BirthWeight.b + 
    0.28956416 * 1 + 0.51208509 * (FH.POP.b == "Yes") + 1.5359855 * (uiprepreg.b == "Yes") + 1.1039282 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.CompoPFD.csec.before <- expression({
  lp <- 1.3422924 - 0.069592472 * parity_b + 0.021767577 * PrepregWeight_b - 0.024359092 * height.b + 0.00015663884 * BirthWeight.b + 
    0.28956416 * 0 + 0.51208509 * (FH.POP.b == "Yes") + 1.5359855 * (uiprepreg.b == "Yes") + 1.1039282 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
#####Any 2 PFD
## Vaginal
ProLong.Any2PFD.vag.before <- expression({
  lp <- 1.7666334 + 0.014400808 * PrepregWeight_b - 0.027214869 * height.b + 0.4302425 * (FH.POP.b == "Yes") + 1.0278357 * (uiprepreg.b == "Yes") + 0.87342165 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.Any2PFD.csec.before <- expression({
  lp <- 1.7666334 + 0.014400808 * PrepregWeight_b - 0.027214869 * height.b + 0.4302425 * (FH.POP.b == "Yes") + 1.0278357 * (uiprepreg.b == "Yes") + 0.87342165 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
#####Bothersome 2 PFD
## Vaginal
ProLong.Bother2PFD.vag.before <- expression({
  lp <- -2.2817518 + 0.31320174 * parity_b - 0.084427257 * Age.b + 0.013813951 * PrepregWeight_b + 1.0255693 * (uiprepreg.b == "Yes") + 1.3328242 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.Bother2PFD.csec.before <- expression({
  lp <- -2.2817518 + 0.31320174 * parity_b - 0.084427257 * Age.b + 0.013813951 * PrepregWeight_b + 1.0255693 * (uiprepreg.b == "Yes") + 1.3328242 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
#####Treatment for 2 PFD
## Vaginal
ProLong.Treat2PFD.vag.before <- expression({
  lp <- -0.36021966 + 0.17032048 * Age.b - 0.07165287 * height.b + 0.00054246756 * BirthWeight.b + 1.0001059 * (FH.POP.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.Treat2PFD.csec.before <- expression({
  lp <- -0.36021966 + 0.17032048 * Age.b - 0.07165287 * height.b + 0.00054246756 * BirthWeight.b + 1.0001059 * (FH.POP.b == "Yes");
  1/(1+exp(-lp))
})
#####Composite of 2 PFD
## Vaginal
ProLong.Compo2PFD.vag.before <- expression({
  lp <- -3.3877273 + 0.21934624 * parity_b - 0.036834748 * Age.b + 0.018408371 * PrepregWeight_b + 0.50411283 * (FH.POP.b == "Yes") + 1.1234042 * (uiprepreg.b == "Yes") + 
    1.0910118 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.Compo2PFD.csec.before <- expression({
  lp <- -3.3877273 + 0.21934624 * parity_b - 0.036834748 * Age.b + 0.018408371 * PrepregWeight_b + 0.50411283 * (FH.POP.b == "Yes") + 1.1234042 * (uiprepreg.b == "Yes") + 
    1.0910118 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
########################################################20 year models (SwePop)
#####POP
## Vaginal
SwePop.POP.vag.before <- expression({
  lp <- 0.086362341 + 0.0060559079 * PrepregWeight_b - 0.034477462 * height.b + 0.00014501143 * BirthWeight.b + 0.04097377 * circumference.b + 
    1.1274898 * 1 + 0.84095709 * (FH.POP.b == "Yes") + 0.38807919 * (FH.UI.b == "Yes") + 0.2897172 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.POP.csec.before <- expression({
  lp <- 0.086362341 + 0.0060559079 * PrepregWeight_b - 0.034477462 * height.b + 0.00014501143 * BirthWeight.b + 0.04097377 * circumference.b + 
    1.1274898 * 0 + 0.84095709 * (FH.POP.b == "Yes") + 0.38807919 * (FH.UI.b == "Yes") + 0.2897172 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
#####Bothersome POP
## Vaginal
SwePop.BotherPOP.vag.before <- expression({
  lp <- -5.8856757 + 0.00031454699 * BirthWeight.b + 1.5174002 * 1 + 1.3759935 * (FH.POP.b == "Yes") + 0.52465413 * (FH.UI.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.BotherPOP.csec.before <- expression({
  lp <- -5.8856757 + 0.00031454699 * BirthWeight.b + 1.5174002 * 0 + 1.3759935 * (FH.POP.b == "Yes") + 0.52465413 * (FH.UI.b == "Yes");
  1/(1+exp(-lp))
})
#####Treatment for POP
## Vaginal
SwePop.TreatPOP.vag.before <- expression({
  lp <- -8.7351039 + 0.024495103 * Age.b - 0.016574761 * PrepregWeight_b + 0.0012037986 * BirthWeight.b + 1.9131961 * (FH.POP.b == "Yes") - 0.825517 * (FH.UI.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.TreatPOP.csec.before <- expression({
  lp <- -8.7351039 + 0.024495103 * Age.b - 0.016574761 * PrepregWeight_b + 0.0012037986 * BirthWeight.b + 1.9131961 * (FH.POP.b == "Yes") - 0.825517 * (FH.UI.b == "Yes");
  1/(1+exp(-lp))
})
#####Composite of POP
## Vaginal
SwePop.CompoPOP.vag.before <- expression({
  lp <- -1.1221432 - 0.78035428 * Bwt.height.b + 0.15777475 * max(Bwt.height.b - 3.9608802, 0)**3 - 0.25894256 * max(Bwt.height.b - 4.7428571, 0)**3 + 0.10116781 * max(Bwt.height.b - 5.9623776, 0)**3 + 
    1.6483109 * 1 + 1.5199717 * (FH.POP.b == "Yes") + 0.34329192 * (FH.UI.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.CompoPOP.csec.before <- expression({
  lp <- -1.1221432 - 0.78035428 * Bwt.height.b + 0.15777475 * max(Bwt.height.b - 3.9608802, 0)**3 - 0.25894256 * max(Bwt.height.b - 4.7428571, 0)**3 + 0.10116781 * max(Bwt.height.b - 5.9623776, 0)**3 + 
    1.6483109 * 0 + 1.5199717 * (FH.POP.b == "Yes") + 0.34329192 * (FH.UI.b == "Yes");
  1/(1+exp(-lp))
})
#####UI
## Vaginal
SwePop.UI.vag.before <- expression({
  lp <- 0.49624908 + 0.021775329 * Age.b + 0.020890093 * PrepregWeight_b - 0.024110535 * height.b + 0.5592133 * 1 - 
    0.13947227 * (FH.POP.b == "Yes") + 1.6079145 * (FH.UI.b == "Yes") + 0.25331044 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.UI.csec.before <- expression({
  lp <- 0.49624908 + 0.021775329 * Age.b + 0.020890093 * PrepregWeight_b - 0.024110535 * height.b + 0.5592133 * 0 - 
    0.13947227 * (FH.POP.b == "Yes") + 1.6079145 * (FH.UI.b == "Yes") + 0.25331044 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
#####Bothersome UI
## Vaginal
SwePop.BotherUI.vag.before <- expression({
  lp <- -4.1546514 + 0.01751938 * PrepregWeight_b + 0.43529983 * 1 + 1.1120021 * (FH.UI.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.BotherUI.csec.before <- expression({
  lp <- -4.1546514 + 0.01751938 * PrepregWeight_b + 0.43529983 * 0 + 1.1120021 * (FH.UI.b == "Yes");
  1/(1+exp(-lp))
})
#####Treatment for UI
## Vaginal
SwePop.TreatUI.vag.before <- expression({
  lp <- -6.3562271 + 0.01316452 * PrepregWeight_b + 0.00026999295 * BirthWeight.b + 0.65414949 * 1 + 1.245927 * (FH.UI.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.TreatUI.csec.before <- expression({
  lp <- -6.3562271 + 0.01316452 * PrepregWeight_b + 0.00026999295 * BirthWeight.b + 0.65414949 * 0 + 1.245927 * (FH.UI.b == "Yes");
  1/(1+exp(-lp))
})
#####Composite of UI
## Vaginal
SwePop.CompoUI.vag.before <- expression({
  lp <- -4.0110612 + 0.015989521 * PrepregWeight_b + 0.56140066 * 1 + 1.1958132 * (FH.UI.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.CompoUI.csec.before <- expression({
  lp <- -4.0110612 + 0.015989521 * PrepregWeight_b + 0.56140066 * 0 + 1.1958132 * (FH.UI.b == "Yes");
  1/(1+exp(-lp))
})
#####Any FI
## Vaginal
SwePop.AnyFI.vag.before <- expression({
  lp <- 1.2943374 + 0.02612035 * Age.b + 0.02234005 * PrepregWeight_b - 0.035378719 * height.b + 0.38442496 * 1 + 0.25838814 * (FH.UI.b == "Yes") + 0.9359758 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.AnyFI.csec.before <- expression({
  lp <- 1.2943374 + 0.02612035 * Age.b + 0.02234005 * PrepregWeight_b - 0.035378719 * height.b + 0.38442496 * 0 + 0.25838814 * (FH.UI.b == "Yes") + 0.9359758 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
#####Bothersome FI
## Vaginal
SwePop.BotherFI.vag.before <- expression({
  lp <- -2.8815813 - 0.064478953 * Age.b + 0.024092437 * PrepregWeight_b - 0.18607341 * Bwt.height.b + 0.45277169 * (FH.POP.b == "Yes") + 1.0567838 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.BotherFI.csec.before <- expression({
  lp <- -2.8815813 - 0.064478953 * Age.b + 0.024092437 * PrepregWeight_b - 0.18607341 * Bwt.height.b + 0.45277169 * (FH.POP.b == "Yes") + 1.0567838 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
#####Treatment for FI
## Vaginal
SwePop.TreatFI.vag.before <- expression({
  lp <- -6.3971892 + 0.029203393 * PrepregWeight_b;
  1/(1+exp(-lp))
})
## C-Section
SwePop.TreatFI.csec.before <- expression({
  lp <- -6.3971892 + 0.029203393 * PrepregWeight_b;
  1/(1+exp(-lp))
})
#####Composite of FI
## Vaginal
SwePop.CompoFI.vag.before <- expression({
  lp <- -4.2962332 - 0.040706386 * Age.b + 0.027405682 * PrepregWeight_b + 1.1285417 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.CompoFI.csec.before <- expression({
  lp <- -4.2962332 - 0.040706386 * Age.b + 0.027405682 * PrepregWeight_b + 1.1285417 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
#####Any PFD
## Vaginal
SwePop.AnyPFD.vag.before <- expression({
  lp <- 1.0887746 + 0.026574806 * Age.b + 0.01749256 * PrepregWeight_b - 0.029955334 * height.b + 0.024202047 * circumference.b + 0.63159024 * 1 + 
    1.384855 * (FH.UI.b == "Yes") + 0.49693696 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.AnyPFD.csec.before <- expression({
  lp <- 1.0887746 + 0.026574806 * Age.b + 0.01749256 * PrepregWeight_b - 0.029955334 * height.b + 0.024202047 * circumference.b + 0.63159024 * 0 + 
    1.384855 * (FH.UI.b == "Yes") + 0.49693696 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
#####Bothersome PFD
## Vaginal
SwePop.BotherPFD.vag.before <- expression({
  lp <- 0.63021419 + 0.020315141 * PrepregWeight_b - 0.029159009 * height.b + 0.85530758 * 1 + 0.52529044 * (FH.POP.b == "Yes") + 0.8559326 * (FH.UI.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.BotherPFD.csec.before <- expression({
  lp <- 0.63021419 + 0.020315141 * PrepregWeight_b - 0.029159009 * height.b + 0.85530758 * 0 + 0.52529044 * (FH.POP.b == "Yes") + 0.8559326 * (FH.UI.b == "Yes");
  1/(1+exp(-lp))
})
#####Treatment for PFD
## Vaginal
SwePop.TreatPFD.vag.before <- expression({
  lp <- -6.5619098 + 0.023041262 * Age.b + 0.010480843 * PrepregWeight_b + 0.00042588726 * BirthWeight.b + 0.58630369 * 1 + 0.48424612 * (FH.POP.b == "Yes") + 
    0.66185055 * (FH.UI.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.TreatPFD.csec.before <- expression({
  lp <- -6.5619098 + 0.023041262 * Age.b + 0.010480843 * PrepregWeight_b + 0.00042588726 * BirthWeight.b + 0.58630369 * 0 + 0.48424612 * (FH.POP.b == "Yes") + 
    0.66185055 * (FH.UI.b == "Yes");
  1/(1+exp(-lp))
})
#####Composite of PFD
## Vaginal
SwePop.CompoPFD.vag.before <- expression({
  lp <- -1.2092321 + 0.014601911 * PrepregWeight_b - 0.52854027 * Bwt.height.b + 0.11860865 * max(Bwt.height.b - 3.9608802, 0)**3 - 0.1946625 * max(Bwt.height.b - 4.7428571, 0)**3 + 
    0.076053852 * max(Bwt.height.b - 5.9623776, 0)**3 + 0.80480055 * 1 + 0.60312594 * (FH.POP.b == "Yes") + 0.88071797 * (FH.UI.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.CompoPFD.csec.before <- expression({
  lp <- -1.2092321 + 0.014601911 * PrepregWeight_b - 0.52854027 * Bwt.height.b + 0.11860865 * max(Bwt.height.b - 3.9608802, 0)**3 - 0.1946625 * max(Bwt.height.b - 4.7428571, 0)**3 + 
    0.076053852 * max(Bwt.height.b - 5.9623776, 0)**3 + 0.80480055 * 0 + 0.60312594 * (FH.POP.b == "Yes") + 0.88071797 * (FH.UI.b == "Yes");
  1/(1+exp(-lp))
})
#####Any 2 PFD
## Vaginal
SwePop.Any2PFD.vag.before <- expression({
  lp <- 2.6164186 + 0.026339102 * PrepregWeight_b - 0.043576125 * height.b + 0.79784559 * 1 + 0.47561695 * (FH.POP.b == "Yes") + 0.75767347 * (FH.UI.b == "Yes") + 
    0.59984961 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.Any2PFD.csec.before <- expression({
  lp <- 2.6164186 + 0.026339102 * PrepregWeight_b - 0.043576125 * height.b + 0.79784559 * 0 + 0.47561695 * (FH.POP.b == "Yes") + 0.75767347 * (FH.UI.b == "Yes") + 
    0.59984961 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
#####Bothersome 2 PFD
## Vaginal
SwePop.Bother2PFD.vag.before <- expression({
  lp <- -5.2651255 + 0.94439022 * 1 + 1.2454745 * (FH.POP.b == "Yes") + 0.78612541 * (FH.UI.b == "Yes") + 0.77491574 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.Bother2PFD.csec.before <- expression({
  lp <- -5.2651255 + 0.94439022 * 0 + 1.2454745 * (FH.POP.b == "Yes") + 0.78612541 * (FH.UI.b == "Yes") + 0.77491574 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
#####Treatment for 2 PFD
## Vaginal
SwePop.Treat2PFD.vag.before <- expression({
  lp <- -2.6342476 - 0.62563331 * Bwt.height.b;
  1/(1+exp(-lp))
})
## C-Section
SwePop.Treat2PFD.csec.before <- expression({
  lp <- -2.6342476 - 0.62563331 * Bwt.height.b;
  1/(1+exp(-lp))
})
#####Treatment for 2 PFD
## Vaginal
SwePop.Compo2PFD.vag.before <- expression({
  lp <- 2.1120385 + 0.015463315 * PrepregWeight_b - 0.88449844 * Bwt.height.b + 0.1826067 * max(Bwt.height.b - 3.9608802, 0)**3 - 0.29969717 * max(Bwt.height.b - 4.7428571, 0)**3 + 
    0.11709047 * max(Bwt.height.b - 5.9623776, 0)**3 - 0.11319881 * circumference.b + 0.72700138 * 1 + 1.1664284 * (FH.POP.b == "Yes") + 
    0.74265498 * (FH.UI.b == "Yes") + 0.59446222 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.Compo2PFD.csec.before <- expression({
  lp <- 2.1120385 + 0.015463315 * PrepregWeight_b - 0.88449844 * Bwt.height.b + 0.1826067 * max(Bwt.height.b - 3.9608802, 0)**3 - 0.29969717 * max(Bwt.height.b - 4.7428571, 0)**3 + 
    0.11709047 * max(Bwt.height.b - 5.9623776, 0)**3 - 0.11319881 * circumference.b + 0.72700138 * 0 + 1.1664284 * (FH.POP.b == "Yes") + 
    0.74265498 * (FH.UI.b == "Yes") + 0.59446222 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})

PriorDelivPlot <- function(pred.pop.any.vag, pred.pop.any.csec, pred.ui.any.vag, pred.ui.any.csec, pred.fi.any.vag, pred.fi.any.csec, pred.pfd.any.vag, pred.pfd.any.csec, pred.2pfd.any.vag, pred.2pfd.any.csec, pred.pop.bother.vag, pred.pop.bother.csec, pred.ui.bother.vag, pred.ui.bother.csec, pred.fi.bother.vag, pred.fi.bother.csec, pred.pfd.bother.vag, pred.pfd.bother.csec, pred.2pfd.bother.vag, pred.2pfd.bother.csec, pred.pop.treat.vag, pred.pop.treat.csec, pred.ui.treat.vag, pred.ui.treat.csec, pred.fi.treat.vag, pred.fi.treat.csec, pred.pfd.treat.vag, pred.pfd.treat.csec, pred.2pfd.treat.vag, pred.2pfd.treat.csec, pred.pop.compo.vag, pred.pop.compo.csec, pred.ui.compo.vag, pred.ui.compo.csec, pred.fi.compo.vag, pred.fi.compo.csec, pred.pfd.compo.vag, pred.pfd.compo.csec, pred.2pfd.compo.vag, pred.2pfd.compo.csec){
  par(mar=c(15,2,1,1))
  plot(1, 1, type="n", xaxt="n", yaxt="n", xlab="", ylab="", xaxs = "i", yaxs="i")
  abline(h = c(0.73, 0.86, 0.99, 1.12, 1.25))
  abline(v = c(0.78, 0.89, 1.0175, 1.145, 1.2725))
  text(0.69, 1.325, "Outcomes", cex=1.2, font=2)
  text(0.835, 1.325, "Route\n of\n Delivery", cex=1.2, font=2)
  text(0.95375, 1.325, "Any", cex=1.2, font=2)
  text(1.08125, 1.325, "Bothersome", cex=1.2, font=2)
  text(1.20875, 1.325, "Treatment", cex=1.2, font=2)
  text(1.33625, 1.325, "Composite\n of\n Bothersome\n or Treatment", cex=1.2, font=2)
  text(0.69, 1.185, "Pelvic Organ\n Prolapse", cex=1.2, font=2)
  text(0.69, 1.055, "Urinary\n Incontinence", cex=1.2, font=2)
  text(0.69, 0.925, "Fecal\n Incontinence", cex=1.2, font=2)
  text(0.69, 0.795, "Any Pelvic\n Floor\n Disorder", cex=1.2, font=2)
  text(0.69, 0.665, "Two or More\n Pelvic Floor\n Disorders", cex=1.2, font=2)
  
  lines(c(0.78, 1.4), c(1.185, 1.185))
  lines(c(0.78, 1.4), c(1.055, 1.055))
  lines(c(0.78, 1.4), c(0.925, 0.925))
  lines(c(0.78, 1.4), c(0.795, 0.795))
  lines(c(0.78, 1.4), c(0.665, 0.665))
  text(0.835, 1.2175, "Vaginal", cex=1.2, font=2)
  text(0.835, 1.1525, "C-Section", cex=1.2, font=2)
  text(0.835, 1.0875, "Vaginal", cex=1.2, font=2)
  text(0.835, 1.0225, "C-Section", cex=1.2, font=2)
  text(0.835, 0.9575, "Vaginal", cex=1.2, font=2)
  text(0.835, 0.8925, "C-Section", cex=1.2, font=2)
  text(0.835, 0.8275, "Vaginal", cex=1.2, font=2)
  text(0.835, 0.7625, "C-Section", cex=1.2, font=2)
  text(0.835, 0.6975, "Vaginal", cex=1.2, font=2)
  text(0.835, 0.6325, "C-Section", cex=1.2, font=2)
  #any pop
  text(0.95375, 1.2175, ifelse(pred.pop.any.vag < 0.0006, "<0.1%", ifelse(pred.pop.any.vag > 0.9994, ">99.9%", paste(round(pred.pop.any.vag*100, 1), "%", sep=""))), cex=2)
  text(0.95375, 1.1525, ifelse(pred.pop.any.csec < 0.0006, "<0.1%", ifelse(pred.pop.any.csec > 0.9994, ">99.9%", paste(round(pred.pop.any.csec*100, 1), "%", sep=""))), cex=2)
  #any UI
  text(0.95375, 1.0875, ifelse(pred.ui.any.vag < 0.0006, "<0.1%", ifelse(pred.ui.any.vag > 0.9994, ">99.9%", paste(round(pred.ui.any.vag*100, 1), "%", sep=""))), cex=2)
  text(0.95375, 1.0225, ifelse(pred.ui.any.csec < 0.0006, "<0.1%", ifelse(pred.ui.any.csec > 0.9994, ">99.9%", paste(round(pred.ui.any.csec*100, 1), "%", sep=""))), cex=2)
  #any FI
  text(0.95375, 0.9575, ifelse(pred.fi.any.vag < 0.0006, "<0.1%", ifelse(pred.fi.any.vag > 0.9994, ">99.9%", paste(round(pred.fi.any.vag*100, 1), "%", sep=""))), cex=2)
  text(0.95375, 0.8925, ifelse(pred.fi.any.csec < 0.0006, "<0.1%", ifelse(pred.fi.any.csec > 0.9994, ">99.9%", paste(round(pred.fi.any.csec*100, 1), "%", sep=""))), cex=2)
  #any PFD
  text(0.95375, 0.8275, ifelse(pred.pfd.any.vag < 0.0006, "<0.1%", ifelse(pred.pfd.any.vag > 0.9994, ">99.9%", paste(round(pred.pfd.any.vag*100, 1), "%", sep=""))), cex=2)
  text(0.95375, 0.7625, ifelse(pred.pfd.any.csec < 0.0006, "<0.1%", ifelse(pred.pfd.any.csec > 0.9994, ">99.9%", paste(round(pred.pfd.any.csec*100, 1), "%", sep=""))), cex=2)
  #any 2 or more PFD
  text(0.95375, 0.6975, ifelse(pred.2pfd.any.vag < 0.0006, "<0.1%", ifelse(pred.2pfd.any.vag > 0.9994, ">99.9%", paste(round(pred.2pfd.any.vag*100, 1), "%", sep=""))), cex=2)
  text(0.95375, 0.6325, ifelse(pred.2pfd.any.csec < 0.0006, "<0.1%", ifelse(pred.2pfd.any.csec > 0.9994, ">99.9%", paste(round(pred.2pfd.any.csec*100, 1), "%", sep=""))), cex=2)
  #Bothersome pop
  text(1.08125, 1.2175, ifelse(pred.pop.bother.vag < 0.0006, "<0.1%", ifelse(pred.pop.bother.vag > 0.9994, ">99.9%", paste(round(pred.pop.bother.vag*100, 1), "%", sep=""))), cex=2)
  text(1.08125, 1.1525, ifelse(pred.pop.bother.csec < 0.0006, "<0.1%", ifelse(pred.pop.bother.csec > 0.9994, ">99.9%", paste(round(pred.pop.bother.csec*100, 1), "%", sep=""))), cex=2)
  #Bothersome UI
  text(1.08125, 1.0875, ifelse(pred.ui.bother.vag < 0.0006, "<0.1%", ifelse(pred.ui.bother.vag > 0.9994, ">99.9%", paste(round(pred.ui.bother.vag*100, 1), "%", sep=""))), cex=2)
  text(1.08125, 1.0225, ifelse(pred.ui.bother.csec < 0.0006, "<0.1%", ifelse(pred.ui.bother.csec > 0.9994, ">99.9%", paste(round(pred.ui.bother.csec*100, 1), "%", sep=""))), cex=2)
  #Bothersome FI
  text(1.08125, 0.9575, ifelse(pred.fi.bother.vag < 0.0006, "<0.1%", ifelse(pred.fi.bother.vag > 0.9994, ">99.9%", paste(round(pred.fi.bother.vag*100, 1), "%", sep=""))), cex=2)
  text(1.08125, 0.8925, ifelse(pred.fi.bother.csec < 0.0006, "<0.1%", ifelse(pred.fi.bother.csec > 0.9994, ">99.9%", paste(round(pred.fi.bother.csec*100, 1), "%", sep=""))), cex=2)
  #Bothersome PFD
  text(1.08125, 0.8275, ifelse(pred.pfd.bother.vag < 0.0006, "<0.1%", ifelse(pred.pfd.bother.vag > 0.9994, ">99.9%", paste(round(pred.pfd.bother.vag*100, 1), "%", sep=""))), cex=2)
  text(1.08125, 0.7625, ifelse(pred.pfd.bother.csec < 0.0006, "<0.1%", ifelse(pred.pfd.bother.csec > 0.9994, ">99.9%", paste(round(pred.pfd.bother.csec*100, 1), "%", sep=""))), cex=2)
  #Bothersome 2 or more PFD
  text(1.08125, 0.6975, ifelse(pred.2pfd.bother.vag < 0.0006, "<0.1%", ifelse(pred.2pfd.bother.vag > 0.9994, ">99.9%", paste(round(pred.2pfd.bother.vag*100, 1), "%", sep=""))), cex=2)
  text(1.08125, 0.6325, ifelse(pred.2pfd.bother.csec < 0.0006, "<0.1%", ifelse(pred.2pfd.bother.csec > 0.9994, ">99.9%", paste(round(pred.2pfd.bother.csec*100, 1), "%", sep=""))), cex=2)
  #Treatment for pop
  text(1.20875, 1.2175, ifelse(pred.pop.treat.vag < 0.0006, "<0.1%", ifelse(pred.pop.treat.vag > 0.9994, ">99.9%", paste(round(pred.pop.treat.vag*100, 1), "%", sep=""))), cex=2)
  text(1.20875, 1.1525, ifelse(pred.pop.treat.csec < 0.0006, "<0.1%", ifelse(pred.pop.treat.csec > 0.9994, ">99.9%", paste(round(pred.pop.treat.csec*100, 1), "%", sep=""))), cex=2)
  #Treatment for UI
  text(1.20875, 1.0875, ifelse(pred.ui.treat.vag < 0.0006, "<0.1%", ifelse(pred.ui.treat.vag > 0.9994, ">99.9%", paste(round(pred.ui.treat.vag*100, 1), "%", sep=""))), cex=2)
  text(1.20875, 1.0225, ifelse(pred.ui.treat.csec < 0.0006, "<0.1%", ifelse(pred.ui.treat.csec > 0.9994, ">99.9%", paste(round(pred.ui.treat.csec*100, 1), "%", sep=""))), cex=2)
  #Treatment for FI
  text(1.20875, 0.9575, ifelse(pred.fi.treat.vag < 0.0006, "<0.1%", ifelse(pred.fi.treat.vag > 0.9994, ">99.9%", paste(round(pred.fi.treat.vag*100, 1), "%", sep=""))), cex=2)
  text(1.20875, 0.8925, ifelse(pred.fi.treat.csec < 0.0006, "<0.1%", ifelse(pred.fi.treat.csec > 0.9994, ">99.9%", paste(round(pred.fi.treat.csec*100, 1), "%", sep=""))), cex=2)
  #Treatment for PFD
  text(1.20875, 0.8275, ifelse(pred.pfd.treat.vag < 0.0006, "<0.1%", ifelse(pred.pfd.treat.vag > 0.9994, ">99.9%", paste(round(pred.pfd.treat.vag*100, 1), "%", sep=""))), cex=2)
  text(1.20875, 0.7625, ifelse(pred.pfd.treat.csec < 0.0006, "<0.1%", ifelse(pred.pfd.treat.csec > 0.9994, ">99.9%", paste(round(pred.pfd.treat.csec*100, 1), "%", sep=""))), cex=2)
  #Treatment for 2 or more PFD
  text(1.20875, 0.6975, ifelse(pred.2pfd.treat.vag < 0.0006, "<0.1%", ifelse(pred.2pfd.treat.vag > 0.9994, ">99.9%", paste(round(pred.2pfd.treat.vag*100, 1), "%", sep=""))), cex=2)
  text(1.20875, 0.6325, ifelse(pred.2pfd.treat.csec < 0.0006, "<0.1%", ifelse(pred.2pfd.treat.csec > 0.9994, ">99.9%", paste(round(pred.2pfd.treat.csec*100, 1), "%", sep=""))), cex=2)
  #Composite pop
  text(1.33625, 1.2175, ifelse(pred.pop.compo.vag < 0.0006, "<0.1%", ifelse(pred.pop.compo.vag > 0.9994, ">99.9%", paste(round(pred.pop.compo.vag*100, 1), "%", sep=""))), cex=2)
  text(1.33625, 1.1525, ifelse(pred.pop.compo.csec < 0.0006, "<0.1%", ifelse(pred.pop.compo.csec > 0.9994, ">99.9%", paste(round(pred.pop.compo.csec*100, 1), "%", sep=""))), cex=2)
  #Composite of UI
  text(1.33625, 1.0875, ifelse(pred.ui.compo.vag < 0.0006, "<0.1%", ifelse(pred.ui.compo.vag > 0.9994, ">99.9%", paste(round(pred.ui.compo.vag*100, 1), "%", sep=""))), cex=2)
  text(1.33625, 1.0225, ifelse(pred.ui.compo.csec < 0.0006, "<0.1%", ifelse(pred.ui.compo.csec > 0.9994, ">99.9%", paste(round(pred.ui.compo.csec*100, 1), "%", sep=""))), cex=2)
  #Composite of FI
  text(1.33625, 0.9575, ifelse(pred.fi.compo.vag < 0.0006, "<0.1%", ifelse(pred.fi.compo.vag > 0.9994, ">99.9%", paste(round(pred.fi.compo.vag*100, 1), "%", sep=""))), cex=2)
  text(1.33625, 0.8925, ifelse(pred.fi.compo.csec < 0.0006, "<0.1%", ifelse(pred.fi.compo.csec > 0.9994, ">99.9%", paste(round(pred.fi.compo.csec*100, 1), "%", sep=""))), cex=2)
  #Composite of PFD
  text(1.33625, 0.8275, ifelse(pred.pfd.compo.vag < 0.0006, "<0.1%", ifelse(pred.pfd.compo.vag > 0.9994, ">99.9%", paste(round(pred.pfd.compo.vag*100, 1), "%", sep=""))), cex=2)
  text(1.33625, 0.7625, ifelse(pred.pfd.compo.csec < 0.0006, "<0.1%", ifelse(pred.pfd.compo.csec > 0.9994, ">99.9%", paste(round(pred.pfd.compo.csec*100, 1), "%", sep=""))), cex=2)
  #Composite of 2 or more PFD
  text(1.33625, 0.6975, ifelse(pred.2pfd.compo.vag < 0.0006, "<0.1%", ifelse(pred.2pfd.compo.vag > 0.9994, ">99.9%", paste(round(pred.2pfd.compo.vag*100, 1), "%", sep=""))), cex=2)
  text(1.33625, 0.6325, ifelse(pred.2pfd.compo.csec < 0.0006, "<0.1%", ifelse(pred.2pfd.compo.csec > 0.9994, ">99.9%", paste(round(pred.2pfd.compo.csec*100, 1), "%", sep=""))), cex=2)
  
}

########################################################################################################After Delivery Models
########################################################12 year models(ProLong)
#POP
ProLong.POP.after <- expression({
  lp <- 3.6704111 - 0.051616431 * Age - 0.024607221 * height + 0.39187625 * (FH.POP == "Yes") + 0.71890992 * (uiprepreg == "Yes") + 0.69477538 * 
    (uiduringpreg == "Yes") + 0.67552437 * (multiple == "Yes");
  1/(1+exp(-lp))
})
#Bothersome POP
ProLong.BotherPOP.after <- expression({
  lp <- -0.84881965 + 0.30298427 * parity - 0.099076614 * Age + 0.41423317 * (epidural == "Yes") + 0.49379033 * (FH.POP == "Yes") + 0.60189619 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
#Treatment for POP
ProLong.TreatPOP.after <- expression({
  lp <- -9.4268 + 0.13760704 * Age + 0.023535813 * PrepregWeight + 0.97815416 * (FH.POP == "Yes");
  1/(1+exp(-lp))
})
#Composite of POP
ProLong.CompoPOP.after <- expression({
  lp <- 1.4753588 + 0.2648621 * parity - 0.041074238 * Age + 0.017934193 * PrepregWeight - 0.028700515 * height + 0.39052387 * (epidural == "Yes") + 0.62005308 * (FH.POP == "Yes") + 
    0.35206667 * (Episiotomy == "Yes") + 0.58143251 * (uiprepreg == "Yes") + 0.41506412 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
#UI
ProLong.UI.after <- expression({
  lp <- -1.138814 - 0.11167835 * parity + 0.024421446 * Age + 0.34983546 * (delmode2 == "Vaginal") + 0.49471109 * (FH.POP == "Yes") + 
    1.7905902 * (uiprepreg == "Yes") + 1.4188088 * (uiduringpreg == "Yes") + 0.21478367 * (induction == "Yes");
  1/(1+exp(-lp))
})
#Bothersome UI
ProLong.BotherUI.after <- expression({
  lp <- 1.0640506 - 0.07994981 * parity + 0.018134236 * PrepregWeight - 0.021088737 * height + 0.30652063 * (delmode2 == "Vaginal") + 0.52721895 * (FH.POP == "Yes") + 
    1.5436131 * (uiprepreg == "Yes") + 1.3107707 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
#Treatment for UI
ProLong.TreatUI.after <- expression({
  lp <- -5.4079895 + 0.040235677 * Age - 0.38844371 * (Laceration == "Yes") + 1.1803848 * (delmode2 == "Vaginal") + 0.39694055 * 
    (epidural == "Yes") + 1.5029574 * (uiprepreg == "Yes") + 0.0027861086 * stage2;
  1/(1+exp(-lp))
})
#Composite of UI
ProLong.CompoUI.after <- expression({
  lp <- 1.4345975 - 0.057841334 * parity + 0.019021519 * PrepregWeight - 0.02376862 * height + 0.34212922 * (delmode2 == "Vaginal") + 0.45681294 * (FH.POP == "Yes") + 
    0.15923925 * (Episiotomy == "Yes") + 1.8003921 * (uiprepreg == "Yes") + 1.2881663 * (uiduringpreg == "Yes") + 0.17759776 * (induction == "Yes");
  1/(1+exp(-lp))
})
#Any FI
ProLong.AnyFI.after <- expression({
  lp <- -0.97826291 + 0.14038045 * parity + 0.018898669 * Age + 0.024061393 * PrepregWeight - 0.020607582 * height + 0.27248232 * (Episiotomy == "Yes") + 0.56624466 * (uiprepreg == "Yes");
  1/(1+exp(-lp))
})
#Bothersome FI
ProLong.BotherFI.after <- expression({
  lp <- -3.6650711 + 0.32806017 * parity - 0.05667342 * Age + 0.020242634 * PrepregWeight - 0.75412488 * (delmode2 == "Vaginal") + 0.89144524 * (Episiotomy == "Yes") + 
    1.2799473 * (uiprepreg == "Yes") + 0.64645946 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
#Treatment for FI
ProLong.TreatFI.after <- expression({
  lp <- -2.7107826 + 0.029075201 * PrepregWeight - 0.63118183 * Bwt.height + 0.52507969 * (epidural == "Yes");
  1/(1+exp(-lp))
})
#Composite of FI
ProLong.CompoFI.after <- expression({
  lp <- 0.82775013 + 0.2560474 * parity - 0.050948553 * Age + 0.032185524 * PrepregWeight - 0.040278207 * height + 0.00050701849 * BirthWeight - 0.56306576 * (delmode2 == "Vaginal") + 
    0.88108214 * (Episiotomy == "Yes") + 0.72999107 * (uiprepreg == "Yes") + 0.59989647 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
#Any PFD
ProLong.AnyPFD.after <- expression({
  lp <- 1.6187199 - 0.16397949 * parity + 0.01351673 * Age + 0.011180323 * PrepregWeight - 0.016231275 * height + 0.37554541 * (delmode2 == "Vaginal") + 0.55535281 * (FH.POP == "Yes") + 
    1.7588291 * (uiprepreg == "Yes") + 1.2441832 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
#Bothersome PFD
ProLong.BotherPFD.after <- expression({
  lp <- 0.29709053 + 0.018019946 * PrepregWeight - 0.015032336 * height + 0.58721916 * (FH.POP == "Yes") + 0.29284809 * (Episiotomy == "Yes") + 1.4955022 * (uiprepreg == "Yes") + 
    1.1618042 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
#Treatment for PFD
ProLong.TreatPFD.after <- expression({
  lp <- -0.69193707 + 0.037740734 * Age + 0.020991164 * PrepregWeight - 0.036886936 * height + 0.00034762508 * BirthWeight + 0.61265529 * (delmode2 == "Vaginal") + 
    0.56956987 * (epidural == "Yes") + 0.26427208 * (Episiotomy == "Yes") + 1.2773287 * (uiprepreg == "Yes") + 0.40237679 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
#Composite of PFD
ProLong.CompoPFD.after <- expression({
  lp <- 0.89378211 + 0.02110515 * PrepregWeight - 0.022154261 * height + 0.0001293616 * BirthWeight + 0.27050778 * (delmode2 == "Vaginal") + 0.14608521 * (epidural == "Yes") + 
    0.49730851 * (FH.POP == "Yes") + 0.32411166 * (Episiotomy == "Yes") + 1.5495279 * (uiprepreg == "Yes") + 1.0996529 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
#Any 2 PFD
ProLong.Any2PFD.after <- expression({
  lp <- 1.7666334 + 0.014400808 * PrepregWeight - 0.027214869 * height + 0.4302425 * (FH.POP == "Yes") + 1.0278357 * (uiprepreg == "Yes") + 0.87342165 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
#Bothersome 2 PFD
ProLong.Bother2PFD.after <- expression({
  lp <- -2.2817518 + 0.31320174 * parity - 0.084427257 * Age + 0.013813951 * PrepregWeight + 1.0255693 * (uiprepreg == "Yes") + 1.3328242 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
#Treatment for 2 PFD
ProLong.Treat2PFD.after <- expression({
  lp <- -0.36021966 + 0.17032048 * Age - 0.07165287 * height + 0.00054246756 * BirthWeight + 1.0001059 * (FH.POP == "Yes");
  1/(1+exp(-lp))
})
#Composite of 2 PFD
ProLong.Compo2PFD.after <- expression({
  lp <-  6.3197096 + 0.2794224 * parity - 0.038225948 * Age + 0.027260495 * PrepregWeight - 0.051071607 * height - 0.062605921 * circumference + 0.50880024 * (FH.POP == "Yes") + 
    0.63312823 * (Episiotomy == "Yes") + 1.132779 * (uiprepreg == "Yes") + 1.0189703 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
########################################################20 year models (SwePop)
#POP
SwePop.POP.after <- expression({
  lp <- 0.086362341 + 0.0060559079 * PrepregWeight - 0.034477462 * height + 0.00014501143 * BirthWeight + 0.04097377 * circumference + 
    1.1274898 * (delmode2 == "Vaginal") + 0.84095709 * (FH.POP == "Yes") + 0.38807919 * (FH.UI == "Yes") + 0.2897172 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})
#Bothersome POP
SwePop.BotherPOP.after <- expression({
  lp <- -5.8856757 + 0.00031454699 * BirthWeight + 1.5174002 * (delmode2 == "Vaginal") + 1.3759935 * (FH.POP == "Yes") + 0.52465413 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})
#Treatment for POP
SwePop.TreatPOP.after <- expression({
  lp <- -8.0593804 - 0.016445836 * PrepregWeight + 0.0012433252 * BirthWeight - 0.35347233 * (epidural == "Yes") + 1.9355939 * (FH.POP == "Yes") - 0.83242282 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})
#Composite of POP
SwePop.CompoPOP.after <- expression({
  lp <- -1.1221432 - 0.78035428 * Bwt.height + 0.15777475 * max(Bwt.height - 3.9608802, 0)**3 - 0.25894256 * max(Bwt.height - 4.7428571, 0)**3 + 0.10116781 * max(Bwt.height - 5.9623776, 0)**3 + 
    1.6483109 * (delmode2 == "Vaginal") + 1.5199717 * (FH.POP == "Yes") + 0.34329192 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})
#UI
SwePop.UI.after <- expression({
  lp <- 0.50742374 + 0.021776637 * Age + 0.020681185 * PrepregWeight - 0.024102771 * height + 0.57223284 * (delmode2 == "Vaginal") - 
    0.14044898 * (FH.POP == "Yes") + 1.6086467 * (FH.UI == "Yes") + 0.2548407 * (FH.FI == "Yes") - 0.1282564 * (Episiotomy == "Yes");
  1/(1+exp(-lp))
})
#Bothersome UI
SwePop.BotherUI.after <- expression({
  lp <- -1.0734901 + 0.019893706 * PrepregWeight - 0.020191772 * height + 0.50231621 * (delmode2 == "Vaginal") + 0.21258875 * (epidural == "Yes") + 0.29124933 * (FH.POP == "Yes") + 
    1.0368519 * (FH.UI == "Yes") - 0.35131066 * (Episiotomy == "Yes");
  1/(1+exp(-lp))
})
#Treatment for UI
SwePop.TreatUI.after <- expression({
  lp <- -6.3562271 + 0.01316452 * PrepregWeight + 0.00026999295 * BirthWeight + 0.65414949 * (delmode2 == "Vaginal") + 1.245927 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})
#Composite of UI
SwePop.CompoUI.after <- expression({
  lp <- -4.0110612 + 0.015989521 * PrepregWeight + 0.56140066 * (delmode2 == "Vaginal") + 1.1958132 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})
#Any FI
SwePop.AnyFI.after <- expression({
  lp <- 1.2997096 + 0.026180457 * Age + 0.021572189 * PrepregWeight - 0.035447551 * height + 0.42522668 * (delmode2 == "Vaginal") + 0.16551578 * (epidural == "Yes") - 
    0.48673468 * (Episiotomy == "Yes") + 0.25413017 * (FH.UI == "Yes") + 0.95050067 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})
#Bothersome FI
SwePop.BotherFI.after <- expression({
  lp <- -2.8815813 - 0.064478953 * Age + 0.024092437 * PrepregWeight - 0.18607341 * Bwt.height + 0.45277169 * (FH.POP == "Yes") + 1.0567838 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})
#Treatment for FI
SwePop.TreatFI.after <- expression({
  lp <- -6.3971892 + 0.029203393 * PrepregWeight;
  1/(1+exp(-lp))
})
#Composite of FI
SwePop.CompoFI.after <- expression({
  lp <- -4.2962332 - 0.040706386 * Age + 0.027405682 * PrepregWeight + 1.1285417 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})
#Any PFD
SwePop.AnyPFD.after <- expression({
  lp <- 1.1493395 + 0.026524507 * Age + 0.016966275 * PrepregWeight - 0.029572801 * height + 0.020833706 * circumference + 0.6538037 * (delmode2 == "Vaginal") + 
    0.089989158 * (epidural == "Yes") + 1.3831272 * (FH.UI == "Yes") + 0.50369069 * (FH.FI == "Yes") - 0.23176314 * (Episiotomy == "Yes");
  1/(1+exp(-lp))
})
#Bothersome PFD
SwePop.BotherPFD.after <- expression({
  lp <- 0.63021419 + 0.020315141 * PrepregWeight - 0.029159009 * height + 0.85530758 * (delmode2 == "Vaginal") + 0.52529044 * (FH.POP == "Yes") + 0.8559326 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})
#Treatment for PFD
SwePop.TreatPFD.after <- expression({
  lp <- -6.5619098 + 0.023041262 * Age + 0.010480843 * PrepregWeight + 0.00042588726 * BirthWeight + 0.58630369 * (delmode2 == "Vaginal") + 0.48424612 * (FH.POP == "Yes") + 
    0.66185055 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})
#Composite of PFD
SwePop.CompoPFD.after <- expression({
  lp <- -1.2092321 + 0.014601911 * PrepregWeight - 0.52854027 * Bwt.height + 0.11860865 * max(Bwt.height - 3.9608802, 0)**3 - 0.1946625 * max(Bwt.height - 4.7428571, 0)**3 + 
    0.076053852 * max(Bwt.height - 5.9623776, 0)**3 + 0.80480055 * (delmode2 == "Vaginal") + 0.60312594 * (FH.POP == "Yes") + 0.88071797 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})
#Any 2 PFD
SwePop.Any2PFD.after <- expression({
  lp <- 2.6164186 + 0.026339102 * PrepregWeight - 0.043576125 * height + 0.79784559 * (delmode2 == "Vaginal") + 0.47561695 * (FH.POP == "Yes") + 0.75767347 * (FH.UI == "Yes") + 
    0.59984961 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})
#Bothersome 2 PFD
SwePop.Bother2PFD.after <- expression({
  lp <- -5.2651255 + 0.94439022 * (delmode2 == "Vaginal") + 1.2454745 * (FH.POP == "Yes") + 0.78612541 * (FH.UI == "Yes") + 0.77491574 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})
#Treatment for 2 PFD
SwePop.Treat2PFD.after <- expression({
  lp <- -2.6342476 - 0.62563331 * Bwt.height;
  1/(1+exp(-lp))
})
#Treatment for 2 PFD
SwePop.Compo2PFD.after <- expression({
  lp <- 2.1120385 + 0.015463315 * PrepregWeight - 0.88449844 * Bwt.height + 0.1826067 * max(Bwt.height - 3.9608802, 0)**3 - 0.29969717 * max(Bwt.height - 4.7428571, 0)**3 + 
    0.11709047 * max(Bwt.height - 5.9623776, 0)**3 - 0.11319881 * circumference + 0.72700138 * (delmode2 == "Vaginal") + 1.1664284 * (FH.POP == "Yes") + 
    0.74265498 * (FH.UI == "Yes") + 0.59446222 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})

PostpardumPlot <- function(pred.pop.any, pred.ui.any, pred.fi.any, pred.pfd.any, pred.2pfd.any, pred.pop.bother, pred.ui.bother, pred.fi.bother, pred.pfd.bother, pred.2pfd.bother, pred.pop.treat, pred.ui.treat, pred.fi.treat, pred.pfd.treat, pred.2pfd.treat, pred.pop.compo, pred.ui.compo, pred.fi.compo, pred.pfd.compo, pred.2pfd.compo){
  par(mar=c(15,1,1,1))
  plot(1, 1, type="n", xaxt="n", yaxt="n", xlab="", ylab="", xaxs = "i", yaxs="i")
  abline(h = c(0.73, 0.86, 0.99, 1.12, 1.25))
  abline(v = c(0.86, 0.995, 1.13, 1.265))
  text(0.73, 1.325, "Outcomes", cex=1.2, font=2)
  text(0.925, 1.325, "Any", cex=1.2, font=2)
  text(1.06, 1.325, "Bothersome", cex=1.2, font=2)
  text(1.195, 1.325, "Treatment", cex=1.2, font=2)
  text(1.33, 1.325, "Composite\n of\n Bothersome\n or Treatment", cex=1.2, font=2)
  text(0.73, 1.185, "Pelvic Organ Prolapse", cex=1.2, font=2)
  text(0.73, 1.055, "Urinary Incontinence", cex=1.2, font=2)
  text(0.73, 0.925, "Fecal Incontinence", cex=1.2, font=2)
  text(0.73, 0.795, "Any Pelvic Floor Disorder", cex=1.2, font=2)
  text(0.73, 0.665, "Two or More Pelvic Floor\n Disorders", cex=1.2, font=2)
  
  #any pop
  text(0.9275, 1.185, ifelse(pred.pop.any < 0.0006, "<0.1%", ifelse(pred.pop.any > 0.9994, ">99.9%", paste(round(pred.pop.any*100, 1), "%", sep=""))), cex=2)
  #any UI
  text(0.9275, 1.055, ifelse(pred.ui.any < 0.0006, "<0.1%", ifelse(pred.ui.any > 0.9994, ">99.9%", paste(round(pred.ui.any*100, 1), "%", sep=""))), cex=2)
  #any FI
  text(0.9275, 0.925, ifelse(pred.fi.any < 0.0006, "<0.1%", ifelse(pred.fi.any > 0.9994, ">99.9%", paste(round(pred.fi.any*100, 1), "%", sep=""))), cex=2)
  #any PFD
  text(0.9275, 0.795, ifelse(pred.pfd.any < 0.0006, "<0.1%", ifelse(pred.pfd.any > 0.9994, ">99.9%", paste(round(pred.pfd.any*100, 1), "%", sep=""))), cex=2)
  #any 2 or more PFD
  text(0.9275, 0.665, ifelse(pred.2pfd.any < 0.0006, "<0.1%", ifelse(pred.2pfd.any > 0.9994, ">99.9%", paste(round(pred.2pfd.any*100, 1), "%", sep=""))), cex=2)
  #Bothersome pop
  text(1.0625, 1.185, ifelse(pred.pop.bother < 0.0006, "<0.1%", ifelse(pred.pop.bother > 0.9994, ">99.9%", paste(round(pred.pop.bother*100, 1), "%", sep=""))), cex=2)
  #Bothersome UI
  text(1.0625, 1.055, ifelse(pred.ui.bother < 0.0006, "<0.1%", ifelse(pred.ui.bother > 0.9994, ">99.9%", paste(round(pred.ui.bother*100, 1), "%", sep=""))), cex=2)
  #Bothersome FI
  text(1.0625, 0.925, ifelse(pred.fi.bother < 0.0006, "<0.1%", ifelse(pred.fi.bother > 0.9994, ">99.9%", paste(round(pred.fi.bother*100, 1), "%", sep=""))), cex=2)
  #Bothersome PFD
  text(1.0625, 0.795, ifelse(pred.pfd.bother < 0.0006, "<0.1%", ifelse(pred.pfd.bother > 0.9994, ">99.9%", paste(round(pred.pfd.bother*100, 1), "%", sep=""))), cex=2)
  #Bothersome 2 or more PFD
  text(1.0625, 0.665, ifelse(pred.2pfd.bother < 0.0006, "<0.1%", ifelse(pred.2pfd.bother > 0.9994, ">99.9%", paste(round(pred.2pfd.bother*100, 1), "%", sep=""))), cex=2)
  #Treatment for pop
  text(1.1975, 1.185, ifelse(pred.pop.treat < 0.0006, "<0.1%", ifelse(pred.pop.treat > 0.9994, ">99.9%", paste(round(pred.pop.treat*100, 1), "%", sep=""))), cex=2)
  #Treatment for UI
  text(1.1975, 1.055, ifelse(pred.ui.treat < 0.0006, "<0.1%", ifelse(pred.ui.treat > 0.9994, ">99.9%", paste(round(pred.ui.treat*100, 1), "%", sep=""))), cex=2)
  #Treatment for FI
  text(1.1975, 0.925, ifelse(pred.fi.treat < 0.0006, "<0.1%", ifelse(pred.fi.treat > 0.9994, ">99.9%", paste(round(pred.fi.treat*100, 1), "%", sep=""))), cex=2)
  #Treatment for PFD
  text(1.1975, 0.795, ifelse(pred.pfd.treat < 0.0006, "<0.1%", ifelse(pred.pfd.treat > 0.9994, ">99.9%", paste(round(pred.pfd.treat*100, 1), "%", sep=""))), cex=2)
  #Treatment for 2 or more PFD
  text(1.1975, 0.665, ifelse(pred.2pfd.treat < 0.0006, "<0.1%", ifelse(pred.2pfd.treat > 0.9994, ">99.9%", paste(round(pred.2pfd.treat*100, 1), "%", sep=""))), cex=2)
  #Composite pop
  text(1.3325, 1.185, ifelse(pred.pop.compo < 0.0006, "<0.1%", ifelse(pred.pop.compo > 0.9994, ">99.9%", paste(round(pred.pop.compo*100, 1), "%", sep=""))), cex=2)
  #Composite of UI
  text(1.3325, 1.055, ifelse(pred.ui.compo < 0.0006, "<0.1%", ifelse(pred.ui.compo > 0.9994, ">99.9%", paste(round(pred.ui.compo*100, 1), "%", sep=""))), cex=2)
  #Composite of FI
  text(1.3325, 0.925, ifelse(pred.fi.compo < 0.0006, "<0.1%", ifelse(pred.fi.compo > 0.9994, ">99.9%", paste(round(pred.fi.compo*100, 1), "%", sep=""))), cex=2)
  #Composite of PFD
  text(1.3325, 0.795, ifelse(pred.pfd.compo < 0.0006, "<0.1%", ifelse(pred.pfd.compo > 0.9994, ">99.9%", paste(round(pred.pfd.compo*100, 1), "%", sep=""))), cex=2)
  #Composite of 2 or more PFD
  text(1.3325, 0.665, ifelse(pred.2pfd.compo < 0.0006, "<0.1%", ifelse(pred.2pfd.compo > 0.9994, ">99.9%", paste(round(pred.2pfd.compo*100, 1), "%", sep=""))), cex=2)
}



shinyServer(function(input, output) {
  get_newdata <- reactive({
    new_df <- data.frame(Age = input$Age,
                         parity = input$parity,
                         PrepregWeight = input$PrepregWeight,
                         PrepregWeight.lb = input$PrepregWeight.lb,
                         height = input$height,
                         height.ft = input$height.ft,
                         height.in = input$height.in,
                         BirthWeight = input$BirthWeight,
                         BirthWeight.p = input$BirthWeight.p,
                         BirthWeight.o = input$BirthWeight.o,
                         circumference = input$circumference,
                         FH.POP = factor(input$FH.POP, levels=c("Yes", "No")),
                         FH.UI = factor(input$FH.UI, levels=c("Yes", "No")),
                         FH.FI = factor(input$FH.FI, levels=c("Yes", "No")),
                         uiprepreg = factor(input$uiprepreg, levels=c("Yes", "No")),
                         uiduringpreg = factor(input$uiduringpreg, levels=c("Yes", "No")),
                         delmode2 = factor(input$delmode2, levels=c("Vaginal", "C-Section")),
                         epidural = factor(input$epidural, levels=c("Yes", "No")),
                         Episiotomy = factor(input$Episiotomy, levels=c("Yes", "No")),
                         induction = factor(input$induction, levels=c("Yes", "No")),
                         Laceration = factor(input$Laceration, levels=c("Yes", "No")),
                         multiple = factor(input$multiple, levels=c("Yes", "No")),
                         stage2 = input$stage2,
                         
                         Age.b = input$Age.b,
                         parity_b = input$parity_b,
                         PrepregWeight_b = input$PrepregWeight_b,
                         PrepregWeight_lb_b = input$PrepregWeight_lb_b,
                         height.b = input$height.b,
                         height.ft.b = input$height.ft.b,
                         height.in.b = input$height.in.b,
                         BirthWeight.b = input$BirthWeight.b,
                         BirthWeight.p.b = input$BirthWeight.p.b,
                         BirthWeight.o.b = input$BirthWeight.o.b,
                         circumference.b = input$circumference.b,
                         FH.POP.b = factor(input$FH.POP.b, levels=c("Yes", "No")),
                         FH.UI.b = factor(input$FH.UI.b, levels=c("Yes", "No")),
                         FH.FI.b = factor(input$FH.FI.b, levels=c("Yes", "No")),
                         uiprepreg.b = factor(input$uiprepreg.b, levels=c("Yes", "No")),
                         uiduringpreg.b = factor(input$uiduringpreg.b, levels=c("Yes", "No"))
      )
    new_df$PrepregWeight <- with(new_df, ifelse(PrepregWeight == 0 | is.na(PrepregWeight) == T, PrepregWeight.lb*0.453592, PrepregWeight))
    new_df$PrepregWeight_b <- with(new_df, ifelse(PrepregWeight_b == 0 | is.na(PrepregWeight_b) == T, PrepregWeight_lb_b*0.453592, PrepregWeight_b))
    
    new_df$height <- with(new_df, ifelse(height == 0 | is.na(height) == T, (height.ft*12 + ifelse(is.na(height.in) == T, 0, height.in))*2.54, height))
    new_df$height.b <- with(new_df, ifelse(height.b == 0 | is.na(height.b) == T, (height.ft.b*12 + ifelse(is.na(height.in.b) == T, 0, height.in.b))*2.54, height.b))
    
    new_df$BirthWeight <- with(new_df, ifelse(BirthWeight == 0 | is.na(BirthWeight) == T, (BirthWeight.p*16 + ifelse(is.na(BirthWeight.o) == T, 0, BirthWeight.o))/0.035274, BirthWeight))
    new_df$BirthWeight.b <- with(new_df, ifelse(BirthWeight.b == 0 | is.na(BirthWeight.b) == T, (BirthWeight.p.b*16 + ifelse(is.na(BirthWeight.o.b) == T, 0, BirthWeight.o.b))/0.035274, BirthWeight.b))
    
    new_df$Bwt.height.b <- with(new_df, (height.b/BirthWeight.b)*100)
    new_df$Bwt.height <- with(new_df, (height/BirthWeight)*100)
    new_df
  })
  
  output$pred1 <- renderPlot({
    new.dat <- get_newdata()
    pred.ProLong.POP.vag.before <- eval(ProLong.POP.vag.before, envir = new.dat)
    pred.ProLong.POP.csec.before <- eval(ProLong.POP.csec.before, envir = new.dat)
    pred.ProLong.UI.vag.before <- eval(ProLong.UI.vag.before, envir = new.dat)
    pred.ProLong.UI.csec.before <- eval(ProLong.UI.csec.before, envir = new.dat)
    pred.ProLong.FI.vag.before <- eval(ProLong.AnyFI.vag.before, envir = new.dat)
    pred.ProLong.FI.csec.before <- eval(ProLong.AnyFI.csec.before, envir = new.dat)
    pred.ProLong.PFD.vag.before <- eval(ProLong.AnyPFD.vag.before, envir = new.dat)
    pred.ProLong.PFD.csec.before <- eval(ProLong.AnyPFD.csec.before, envir = new.dat)
    pred.ProLong.2PFD.vag.before <- eval(ProLong.Any2PFD.vag.before, envir = new.dat)
    pred.ProLong.2PFD.csec.before <- eval(ProLong.Any2PFD.csec.before, envir = new.dat)
    
    pred.ProLong.BotherPOP.vag.before <- eval(ProLong.BotherPOP.vag.before, envir = new.dat)
    pred.ProLong.BotherPOP.csec.before <- eval(ProLong.BotherPOP.csec.before, envir = new.dat)
    pred.ProLong.BotherUI.vag.before <- eval(ProLong.BotherUI.vag.before, envir = new.dat)
    pred.ProLong.BotherUI.csec.before <- eval(ProLong.BotherUI.csec.before, envir = new.dat)    
    pred.ProLong.BotherFI.vag.before <- eval(ProLong.BotherFI.vag.before, envir = new.dat)
    pred.ProLong.BotherFI.csec.before <- eval(ProLong.BotherFI.csec.before, envir = new.dat)
    pred.ProLong.BotherPFD.vag.before <- eval(ProLong.BotherPFD.vag.before, envir = new.dat)
    pred.ProLong.BotherPFD.csec.before <- eval(ProLong.BotherPFD.csec.before, envir = new.dat)
    pred.ProLong.Bother2PFD.vag.before <- eval(ProLong.Bother2PFD.vag.before, envir = new.dat)
    pred.ProLong.Bother2PFD.csec.before <- eval(ProLong.Bother2PFD.csec.before, envir = new.dat)
    
    pred.ProLong.TreatPOP.vag.before <- eval(ProLong.TreatPOP.vag.before, envir = new.dat)
    pred.ProLong.TreatPOP.csec.before <- eval(ProLong.TreatPOP.csec.before, envir = new.dat)
    pred.ProLong.TreatUI.vag.before <- eval(ProLong.TreatUI.vag.before, envir = new.dat)
    pred.ProLong.TreatUI.csec.before <- eval(ProLong.TreatUI.csec.before, envir = new.dat)
    pred.ProLong.TreatFI.vag.before <- eval(ProLong.TreatFI.vag.before, envir = new.dat)
    pred.ProLong.TreatFI.csec.before <- eval(ProLong.TreatFI.csec.before, envir = new.dat)
    pred.ProLong.TreatPFD.vag.before <- eval(ProLong.TreatPFD.vag.before, envir = new.dat)
    pred.ProLong.TreatPFD.csec.before <- eval(ProLong.TreatPFD.csec.before, envir = new.dat)
    pred.ProLong.Treat2PFD.vag.before <- eval(ProLong.Treat2PFD.vag.before, envir = new.dat)
    pred.ProLong.Treat2PFD.csec.before <- eval(ProLong.Treat2PFD.csec.before, envir = new.dat)
    
    pred.ProLong.CompoPOP.vag.before <- eval(ProLong.CompoPOP.vag.before, envir = new.dat)
    pred.ProLong.CompoPOP.csec.before <- eval(ProLong.CompoPOP.csec.before, envir = new.dat)
    pred.ProLong.CompoUI.vag.before <- eval(ProLong.CompoUI.vag.before, envir = new.dat)
    pred.ProLong.CompoUI.csec.before <- eval(ProLong.CompoUI.csec.before, envir = new.dat)
    pred.ProLong.CompoFI.vag.before <- eval(ProLong.CompoFI.vag.before, envir = new.dat)
    pred.ProLong.CompoFI.csec.before <- eval(ProLong.CompoFI.csec.before, envir = new.dat)
    pred.ProLong.CompoPFD.vag.before <- eval(ProLong.CompoPFD.vag.before, envir = new.dat)
    pred.ProLong.CompoPFD.csec.before <- eval(ProLong.CompoPFD.csec.before, envir = new.dat)
    pred.ProLong.Compo2PFD.vag.before <- eval(ProLong.Compo2PFD.vag.before, envir = new.dat)
    pred.ProLong.Compo2PFD.csec.before <- eval(ProLong.Compo2PFD.csec.before, envir = new.dat)
    
    PriorDelivPlot(pred.ProLong.POP.vag.before, pred.ProLong.POP.csec.before, pred.ProLong.UI.vag.before, pred.ProLong.UI.csec.before, pred.ProLong.FI.vag.before, pred.ProLong.FI.csec.before, pred.ProLong.PFD.vag.before, pred.ProLong.PFD.csec.before, pred.ProLong.2PFD.vag.before, pred.ProLong.2PFD.csec.before, pred.ProLong.BotherPOP.vag.before, pred.ProLong.BotherPOP.csec.before, pred.ProLong.BotherUI.vag.before, pred.ProLong.BotherUI.csec.before, pred.ProLong.BotherFI.vag.before, pred.ProLong.BotherFI.csec.before, pred.ProLong.BotherPFD.vag.before, pred.ProLong.BotherPFD.csec.before, pred.ProLong.Bother2PFD.vag.before, pred.ProLong.Bother2PFD.csec.before, pred.ProLong.TreatPOP.vag.before, pred.ProLong.TreatPOP.csec.before, pred.ProLong.TreatUI.vag.before, pred.ProLong.TreatUI.csec.before, pred.ProLong.TreatFI.vag.before, pred.ProLong.TreatFI.csec.before, pred.ProLong.TreatPFD.vag.before, pred.ProLong.TreatPFD.csec.before, pred.ProLong.Treat2PFD.vag.before, pred.ProLong.Treat2PFD.csec.before, pred.ProLong.CompoPOP.vag.before, pred.ProLong.CompoPOP.csec.before, pred.ProLong.CompoUI.vag.before, pred.ProLong.CompoUI.csec.before, pred.ProLong.CompoFI.vag.before, pred.ProLong.CompoFI.csec.before, pred.ProLong.CompoPFD.vag.before, pred.ProLong.CompoPFD.csec.before, pred.ProLong.Compo2PFD.vag.before, pred.ProLong.Compo2PFD.csec.before)
  })
  
  output$pred1.5 <- renderPlot({
    new.dat <- get_newdata()
    pred.SwePop.POP.vag.before <- eval(SwePop.POP.vag.before, envir = new.dat)
    pred.SwePop.POP.csec.before <- eval(SwePop.POP.csec.before, envir = new.dat)
    pred.SwePop.UI.vag.before <- eval(SwePop.UI.vag.before, envir = new.dat)
    pred.SwePop.UI.csec.before <- eval(SwePop.UI.csec.before, envir = new.dat)
    pred.SwePop.FI.vag.before <- eval(SwePop.AnyFI.vag.before, envir = new.dat)
    pred.SwePop.FI.csec.before <- eval(SwePop.AnyFI.csec.before, envir = new.dat)
    pred.SwePop.PFD.vag.before <- eval(SwePop.AnyPFD.vag.before, envir = new.dat)
    pred.SwePop.PFD.csec.before <- eval(SwePop.AnyPFD.csec.before, envir = new.dat)
    pred.SwePop.2PFD.vag.before <- eval(SwePop.Any2PFD.vag.before, envir = new.dat)
    pred.SwePop.2PFD.csec.before <- eval(SwePop.Any2PFD.csec.before, envir = new.dat)
    
    pred.SwePop.BotherPOP.vag.before <- eval(SwePop.BotherPOP.vag.before, envir = new.dat)
    pred.SwePop.BotherPOP.csec.before <- eval(SwePop.BotherPOP.csec.before, envir = new.dat)
    pred.SwePop.BotherUI.vag.before <- eval(SwePop.BotherUI.vag.before, envir = new.dat)
    pred.SwePop.BotherUI.csec.before <- eval(SwePop.BotherUI.csec.before, envir = new.dat)
    pred.SwePop.BotherFI.vag.before <- eval(SwePop.BotherFI.vag.before, envir = new.dat)
    pred.SwePop.BotherFI.csec.before <- eval(SwePop.BotherFI.csec.before, envir = new.dat)
    pred.SwePop.BotherPFD.vag.before <- eval(SwePop.BotherPFD.vag.before, envir = new.dat)
    pred.SwePop.BotherPFD.csec.before <- eval(SwePop.BotherPFD.csec.before, envir = new.dat)
    pred.SwePop.Bother2PFD.vag.before <- eval(SwePop.Bother2PFD.vag.before, envir = new.dat)
    pred.SwePop.Bother2PFD.csec.before <- eval(SwePop.Bother2PFD.csec.before, envir = new.dat)
    
    pred.SwePop.TreatPOP.vag.before <- eval(SwePop.TreatPOP.vag.before, envir = new.dat)
    pred.SwePop.TreatPOP.csec.before <- eval(SwePop.TreatPOP.csec.before, envir = new.dat)
    pred.SwePop.TreatUI.vag.before <- eval(SwePop.TreatUI.vag.before, envir = new.dat)
    pred.SwePop.TreatUI.csec.before <- eval(SwePop.TreatUI.csec.before, envir = new.dat)
    pred.SwePop.TreatFI.vag.before <- eval(SwePop.TreatFI.vag.before, envir = new.dat)
    pred.SwePop.TreatFI.csec.before <- eval(SwePop.TreatFI.csec.before, envir = new.dat)
    pred.SwePop.TreatPFD.vag.before <- eval(SwePop.TreatPFD.vag.before, envir = new.dat)
    pred.SwePop.TreatPFD.csec.before <- eval(SwePop.TreatPFD.csec.before, envir = new.dat)
    pred.SwePop.Treat2PFD.vag.before <- eval(SwePop.Treat2PFD.vag.before, envir = new.dat)
    pred.SwePop.Treat2PFD.csec.before <- eval(SwePop.Treat2PFD.csec.before, envir = new.dat)
    
    pred.SwePop.CompoPOP.vag.before <- eval(SwePop.CompoPOP.vag.before, envir = new.dat)
    pred.SwePop.CompoPOP.csec.before <- eval(SwePop.CompoPOP.csec.before, envir = new.dat)
    pred.SwePop.CompoUI.vag.before <- eval(SwePop.CompoUI.vag.before, envir = new.dat)
    pred.SwePop.CompoUI.csec.before <- eval(SwePop.CompoUI.csec.before, envir = new.dat)
    pred.SwePop.CompoFI.vag.before <- eval(SwePop.CompoFI.vag.before, envir = new.dat)
    pred.SwePop.CompoFI.csec.before <- eval(SwePop.CompoFI.csec.before, envir = new.dat)
    pred.SwePop.CompoPFD.vag.before <- eval(SwePop.CompoPFD.vag.before, envir = new.dat)
    pred.SwePop.CompoPFD.csec.before <- eval(SwePop.CompoPFD.csec.before, envir = new.dat)
    pred.SwePop.Compo2PFD.vag.before <- eval(SwePop.Compo2PFD.vag.before, envir = new.dat)
    pred.SwePop.Compo2PFD.csec.before <- eval(SwePop.Compo2PFD.csec.before, envir = new.dat)
    
    PriorDelivPlot(pred.SwePop.POP.vag.before, pred.SwePop.POP.csec.before, pred.SwePop.UI.vag.before, pred.SwePop.UI.csec.before, pred.SwePop.FI.vag.before, pred.SwePop.FI.csec.before, pred.SwePop.PFD.vag.before, pred.SwePop.PFD.csec.before, pred.SwePop.2PFD.vag.before, pred.SwePop.2PFD.csec.before, pred.SwePop.BotherPOP.vag.before, pred.SwePop.BotherPOP.csec.before, pred.SwePop.BotherUI.vag.before, pred.SwePop.BotherUI.csec.before, pred.SwePop.BotherFI.vag.before, pred.SwePop.BotherFI.csec.before, pred.SwePop.BotherPFD.vag.before, pred.SwePop.BotherPFD.csec.before, pred.SwePop.Bother2PFD.vag.before, pred.SwePop.Bother2PFD.csec.before, pred.SwePop.TreatPOP.vag.before, pred.SwePop.TreatPOP.csec.before, pred.SwePop.TreatUI.vag.before, pred.SwePop.TreatUI.csec.before, pred.SwePop.TreatFI.vag.before, pred.SwePop.TreatFI.csec.before, pred.SwePop.TreatPFD.vag.before, pred.SwePop.TreatPFD.csec.before, pred.SwePop.Treat2PFD.vag.before, pred.SwePop.Treat2PFD.csec.before, pred.SwePop.CompoPOP.vag.before, pred.SwePop.CompoPOP.csec.before, pred.SwePop.CompoUI.vag.before, pred.SwePop.CompoUI.csec.before, pred.SwePop.CompoFI.vag.before, pred.SwePop.CompoFI.csec.before, pred.SwePop.CompoPFD.vag.before, pred.SwePop.CompoPFD.csec.before, pred.SwePop.Compo2PFD.vag.before, pred.SwePop.Compo2PFD.csec.before)
  })
  
  output$pred2 <- renderPlot({
    new.dat <- get_newdata()
    pred.ProLong.POP.after <- eval(ProLong.POP.after, envir = new.dat)
    pred.ProLong.UI.after <- eval(ProLong.UI.after, envir = new.dat)
    pred.ProLong.FI.after <- eval(ProLong.AnyFI.after, envir = new.dat)
    pred.ProLong.PFD.after <- eval(ProLong.AnyPFD.after, envir = new.dat)
    pred.ProLong.2PFD.after <- eval(ProLong.Any2PFD.after, envir = new.dat)
    
    pred.ProLong.BotherPOP.after <- eval(ProLong.BotherPOP.after, envir = new.dat)
    pred.ProLong.BotherUI.after <- eval(ProLong.BotherUI.after, envir = new.dat)
    pred.ProLong.BotherFI.after <- eval(ProLong.BotherFI.after, envir = new.dat)
    pred.ProLong.BotherPFD.after <- eval(ProLong.BotherPFD.after, envir = new.dat)
    pred.ProLong.Bother2PFD.after <- eval(ProLong.Bother2PFD.after, envir = new.dat)
    
    pred.ProLong.TreatPOP.after <- eval(ProLong.TreatPOP.after, envir = new.dat)
    pred.ProLong.TreatUI.after <- eval(ProLong.TreatUI.after, envir = new.dat)
    pred.ProLong.TreatFI.after <- eval(ProLong.TreatFI.after, envir = new.dat)
    pred.ProLong.TreatPFD.after <- eval(ProLong.TreatPFD.after, envir = new.dat)
    pred.ProLong.Treat2PFD.after <- eval(ProLong.Treat2PFD.after, envir = new.dat)
    
    pred.ProLong.CompoPOP.after <- eval(ProLong.CompoPOP.after, envir = new.dat)
    pred.ProLong.CompoUI.after <- eval(ProLong.CompoUI.after, envir = new.dat)
    pred.ProLong.CompoFI.after <- eval(ProLong.CompoFI.after, envir = new.dat)
    pred.ProLong.CompoPFD.after <- eval(ProLong.CompoPFD.after, envir = new.dat)
    pred.ProLong.Compo2PFD.after <- eval(ProLong.Compo2PFD.after, envir = new.dat)
    
    PostpardumPlot(pred.ProLong.POP.after, pred.ProLong.UI.after, pred.ProLong.FI.after, pred.ProLong.PFD.after, pred.ProLong.2PFD.after, pred.ProLong.BotherPOP.after, pred.ProLong.BotherUI.after, pred.ProLong.BotherFI.after, pred.ProLong.BotherPFD.after, pred.ProLong.Bother2PFD.after, pred.ProLong.TreatPOP.after, pred.ProLong.TreatUI.after, pred.ProLong.TreatFI.after, pred.ProLong.TreatPFD.after, pred.ProLong.Treat2PFD.after, pred.ProLong.CompoPOP.after, pred.ProLong.CompoUI.after, pred.ProLong.CompoFI.after, pred.ProLong.CompoPFD.after, pred.ProLong.Compo2PFD.after)
  })
  
  output$pred2.5 <- renderPlot({
    new.dat <- get_newdata()
    pred.SwePop.POP.after <- eval(SwePop.POP.after, envir = new.dat)
    pred.SwePop.UI.after <- eval(SwePop.UI.after, envir = new.dat)
    pred.SwePop.FI.after <- eval(SwePop.AnyFI.after, envir = new.dat)
    pred.SwePop.PFD.after <- eval(SwePop.AnyPFD.after, envir = new.dat)
    pred.SwePop.2PFD.after <- eval(SwePop.Any2PFD.after, envir = new.dat)
    
    pred.SwePop.BotherPOP.after <- eval(SwePop.BotherPOP.after, envir = new.dat)
    pred.SwePop.BotherUI.after <- eval(SwePop.BotherUI.after, envir = new.dat)
    pred.SwePop.BotherFI.after <- eval(SwePop.BotherFI.after, envir = new.dat)
    pred.SwePop.BotherPFD.after <- eval(SwePop.BotherPFD.after, envir = new.dat)
    pred.SwePop.Bother2PFD.after <- eval(SwePop.Bother2PFD.after, envir = new.dat)
    
    pred.SwePop.TreatPOP.after <- eval(SwePop.TreatPOP.after, envir = new.dat)
    pred.SwePop.TreatUI.after <- eval(SwePop.TreatUI.after, envir = new.dat)
    pred.SwePop.TreatFI.after <- eval(SwePop.TreatFI.after, envir = new.dat)
    pred.SwePop.TreatPFD.after <- eval(SwePop.TreatPFD.after, envir = new.dat)
    pred.SwePop.Treat2PFD.after <- eval(SwePop.Treat2PFD.after, envir = new.dat)
    
    pred.SwePop.CompoPOP.after <- eval(SwePop.CompoPOP.after, envir = new.dat)
    pred.SwePop.CompoUI.after <- eval(SwePop.CompoUI.after, envir = new.dat)
    pred.SwePop.CompoFI.after <- eval(SwePop.CompoFI.after, envir = new.dat)
    pred.SwePop.CompoPFD.after <- eval(SwePop.CompoPFD.after, envir = new.dat)
    pred.SwePop.Compo2PFD.after <- eval(SwePop.Compo2PFD.after, envir = new.dat)
    
    PostpardumPlot(pred.SwePop.POP.after, pred.SwePop.UI.after, pred.SwePop.FI.after, pred.SwePop.PFD.after, pred.SwePop.2PFD.after, pred.SwePop.BotherPOP.after, pred.SwePop.BotherUI.after, pred.SwePop.BotherFI.after, pred.SwePop.BotherPFD.after, pred.SwePop.Bother2PFD.after, pred.SwePop.TreatPOP.after, pred.SwePop.TreatUI.after, pred.SwePop.TreatFI.after, pred.SwePop.TreatPFD.after, pred.SwePop.Treat2PFD.after, pred.SwePop.CompoPOP.after, pred.SwePop.CompoUI.after, pred.SwePop.CompoFI.after, pred.SwePop.CompoPFD.after, pred.SwePop.Compo2PFD.after)
  })
  
})