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
  lp <- 4.322554 - 0.029647732 * Age.b + 0.029708808 * PrepregWeight_b - 0.032065916 * height.b + 0.20354882 * 1 + 
    0.32883851 * (FH.POP.b == "Yes") + 0.85481062 * (uiprepreg.b == "Yes") + 0.7612477 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.BotherUI.csec.before <- expression({
  lp <- 4.322554 - 0.029647732 * Age.b + 0.029708808 * PrepregWeight_b - 0.032065916 * height.b + 0.20354882 * 0 + 
    0.32883851 * (FH.POP.b == "Yes") + 0.85481062 * (uiprepreg.b == "Yes") + 0.7612477 * (uiduringpreg.b == "Yes");
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
  lp <- 4.4970952 - 0.028309627 * Age.b + 0.029325068 * PrepregWeight_b - 0.03281012 * height.b + 0.26079761 * 1 + 
    0.23834741 * (FH.POP.b == "Yes") + 1.0285458 * (uiprepreg.b == "Yes") + 0.72079281 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.CompoUI.csec.before <- expression({
  lp <- 4.4970952 - 0.028309627 * Age.b + 0.029325068 * PrepregWeight_b - 0.03281012 * height.b + 0.26079761 * 0 + 
    0.23834741 * (FH.POP.b == "Yes") + 1.0285458 * (uiprepreg.b == "Yes") + 0.72079281 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
#####Bothersome FI
## Vaginal
ProLong.BotherFI.vag.before <- expression({
  lp <- -0.70880645 + 0.026725689 * Age.b + 0.023984978 * PrepregWeight_b - 0.021730371 * height.b + 0.6049813 * (uiprepreg.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.BotherFI.csec.before <- expression({
  lp <- -0.70880645 + 0.026725689 * Age.b + 0.023984978 * PrepregWeight_b - 0.021730371 * height.b + 0.6049813 * (uiprepreg.b == "Yes");
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
  lp <- -0.062462857 + 0.096912419 * parity_b + 0.016418002 * Age.b + 0.025041924 * PrepregWeight_b - 0.027867723 * height.b + 
    0.00013956281 * BirthWeight.b + 0.19311497 * (FH.POP.b == "Yes") + 0.49823562 * (uiprepreg.b == "Yes") + 0.30088359 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.CompoFI.csec.before <- expression({
  lp <- -0.062462857 + 0.096912419 * parity_b + 0.016418002 * Age.b + 0.025041924 * PrepregWeight_b - 0.027867723 * height.b + 
    0.00013956281 * BirthWeight.b + 0.19311497 * (FH.POP.b == "Yes") + 0.49823562 * (uiprepreg.b == "Yes") + 0.30088359 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
#####Bothersome PFD
## Vaginal
ProLong.BotherPFD.vag.before <- expression({
  lp <- 3.8724 + 0.029984046 * PrepregWeight_b - 0.030821968 * height.b + 0.37395999 * (FH.POP.b == "Yes") + 0.7263833 * (uiprepreg.b == "Yes") + 0.51962292 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.BotherPFD.csec.before <- expression({
  lp <- 3.8724 + 0.029984046 * PrepregWeight_b - 0.030821968 * height.b + 0.37395999 * (FH.POP.b == "Yes") + 0.7263833 * (uiprepreg.b == "Yes") + 0.51962292 * (uiduringpreg.b == "Yes");
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
  lp <- 5.0418777 - 0.036476964 * Age.b + 0.031204157 * PrepregWeight_b - 0.032067382 * height.b + 0.29861156 * (FH.POP.b == "Yes") + 0.83816285 * (uiprepreg.b == "Yes") + 0.5678043 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.CompoPFD.csec.before <- expression({
  lp <- 5.0418777 - 0.036476964 * Age.b + 0.031204157 * PrepregWeight_b - 0.032067382 * height.b + 0.29861156 * (FH.POP.b == "Yes") + 0.83816285 * (uiprepreg.b == "Yes") + 0.5678043 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
#####Bothersome 2 PFD
## Vaginal
ProLong.Bother2PFD.vag.before <- expression({
  lp <- 7.1198964 + 0.29984304 * parity_b - 0.045353056 * Age.b + 0.030488196 * 
    PrepregWeight_b - 0.042636768 * height.b - 0.084991316 * circumference.b + 0.2735331 * (uiprepreg.b == "Yes") + 0.411249 * (uiduringpreg.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.Bother2PFD.csec.before <- expression({
  lp <- 7.1198964 + 0.29984304 * parity_b - 0.045353056 * Age.b + 0.030488196 * 
    PrepregWeight_b - 0.042636768 * height.b - 0.084991316 * circumference.b + 0.2735331 * (uiprepreg.b == "Yes") + 0.411249 * (uiduringpreg.b == "Yes");
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
  lp <- 7.6772933 + 0.25786122 * parity_b + 0.034803865 * PrepregWeight_b - 0.054432807 * height.b - 0.079627486 * circumference.b;
  1/(1+exp(-lp))
})
## C-Section
ProLong.Compo2PFD.csec.before <- expression({
  lp <- 7.6772933 + 0.25786122 * parity_b + 0.034803865 * PrepregWeight_b - 0.054432807 * height.b - 0.079627486 * circumference.b;
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
#####Bothersome FI
## Vaginal
SwePop.BotherFI.vag.before <- expression({
  lp <- -3.3923702 - 0.050965286 * Age.b + 0.01780414 * PrepregWeight_b + 0.45803695 * (FH.UI.b == "Yes") + 0.97236577 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.BotherFI.csec.before <- expression({
  lp <- -3.3923702 - 0.050965286 * Age.b + 0.01780414 * PrepregWeight_b + 0.45803695 * (FH.UI.b == "Yes") + 0.97236577 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
#####Treatment for FI
## Vaginal
SwePop.TreatFI.vag.before <- expression({
  lp <- -4.4461225 + 0.012280974 * PrepregWeight_b - 0.80311556 * 1 + 1.015031 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.TreatFI.csec.before <- expression({
  lp <- -4.4461225 + 0.012280974 * PrepregWeight_b - 0.80311556 * 0 + 1.015031 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
#####Composite of FI
## Vaginal
SwePop.CompoFI.vag.before <- expression({
  lp <- 1.8159994 - 0.032933142 * Age.b + 0.020570891 * PrepregWeight_b - 0.033102998 * height.b + 0.3441092 * (FH.UI.b == "Yes") + 0.99315704 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.CompoFI.csec.before <- expression({
  lp <- 1.8159994 - 0.032933142 * Age.b + 0.020570891 * PrepregWeight_b - 0.033102998 * height.b + 0.3441092 * (FH.UI.b == "Yes") + 0.99315704 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
#####Bothersome PFD
## Vaginal
SwePop.BotherPFD.vag.before <- expression({
  lp <- 1.3858103 + 0.019026201 * PrepregWeight_b - 0.032591202 * height.b + 0.82051575 * 1 + 0.49967725 * (FH.POP.b == "Yes") + 0.84170987 * (FH.UI.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.BotherPFD.csec.before <- expression({
  lp <- 1.3858103 + 0.019026201 * PrepregWeight_b - 0.032591202 * height.b + 0.82051575 * 0 + 0.49967725 * (FH.POP.b == "Yes") + 0.84170987 * (FH.UI.b == "Yes");
  1/(1+exp(-lp))
})
#####Treatment for PFD
## Vaginal
SwePop.TreatPFD.vag.before <- expression({
  lp <- -5.233742 + 0.020682138 * Age.b + 0.0003812622 * BirthWeight.b + 0.28472959 * 1 + 0.33331018 * (FH.POP.b == "Yes") + 0.54140219 * (FH.UI.b == "Yes") + 0.26520328 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.TreatPFD.csec.before <- expression({
  lp <- -5.233742 + 0.020682138 * Age.b + 0.0003812622 * BirthWeight.b + 0.28472959 * 0 + 0.33331018 * (FH.POP.b == "Yes") + 0.54140219 * (FH.UI.b == "Yes") + 0.26520328 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
#####Composite of PFD
## Vaginal
SwePop.CompoPFD.vag.before <- expression({
  lp <- -1.2740402 + 0.012101119 * PrepregWeight_b - 0.53269414 * Bwt.height.b + 0.12074765 * max(Bwt.height.b - 3.9608802, 0)**3 - 0.19817306 * 
    max(Bwt.height.b - 4.7428571, 0)**3 + 0.077425415 * max(Bwt.height.b - 5.9623776, 0)**3 + 0.91846484 * 1 + 0.6372069 * (FH.POP.b == "Yes") + 0.92517171 * (FH.UI.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.CompoPFD.csec.before <- expression({
  lp <- -1.2740402 + 0.012101119 * PrepregWeight_b - 0.53269414 * Bwt.height.b + 0.12074765 * max(Bwt.height.b - 3.9608802, 0)**3 - 0.19817306 * 
    max(Bwt.height.b - 4.7428571, 0)**3 + 0.077425415 * max(Bwt.height.b - 5.9623776, 0)**3 + 0.91846484 * 0 + 0.6372069 * (FH.POP.b == "Yes") + 0.92517171 * (FH.UI.b == "Yes");
  1/(1+exp(-lp))
})
#####Bothersome 2 PFD
## Vaginal
SwePop.Bother2PFD.vag.before <- expression({
  lp <- -1.4692333 + 0.016348049 * PrepregWeight_b - 0.23244733 * Bwt.height.b - 0.10083104 * circumference.b + 0.7604179 * 1 + 1.15577 * (FH.POP.b == "Yes") + 0.74324133 * 
    (FH.UI.b == "Yes") + 0.92684933 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.Bother2PFD.csec.before <- expression({
  lp <- -1.4692333 + 0.016348049 * PrepregWeight_b - 0.23244733 * Bwt.height.b - 0.10083104 * circumference.b + 0.7604179 * 0 + 1.15577 * (FH.POP.b == "Yes") + 0.74324133 * 
    (FH.UI.b == "Yes") + 0.92684933 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
#####Treatment for 2 PFD
## Vaginal
SwePop.Treat2PFD.vag.before <- expression({
  lp <- -8.5583616 + 0.00068873972 * BirthWeight.b + 1.111058 * (FH.UI.b == "Yes") + 0.70532879 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.Treat2PFD.csec.before <- expression({
  lp <- -8.5583616 + 0.00068873972 * BirthWeight.b + 1.111058 * (FH.UI.b == "Yes") + 0.70532879 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
#####Treatment for 2 PFD
## Vaginal
SwePop.Compo2PFD.vag.before <- expression({
  lp <- -3.4149124 + 0.015200827 * PrepregWeight_b + 0.00052623852 * BirthWeight.b - 0.11567555 * circumference.b + 0.63036912 * 
    1 + 1.0264006 * (FH.POP.b == "Yes") + 0.73794424 * (FH.UI.b == "Yes") + 0.6289421 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.Compo2PFD.csec.before <- expression({
  lp <- -3.4149124 + 0.015200827 * PrepregWeight_b + 0.00052623852 * BirthWeight.b - 0.11567555 * circumference.b + 0.63036912 * 
    0 + 1.0264006 * (FH.POP.b == "Yes") + 0.73794424 * (FH.UI.b == "Yes") + 0.6289421 * (FH.FI.b == "Yes");
  1/(1+exp(-lp))
})

PriorDelivPlot <- function(pred.pop.any.vag, pred.pop.any.csec, pred.ui.any.vag, pred.ui.any.csec, pred.pop.bother.vag, pred.pop.bother.csec, pred.ui.bother.vag, pred.ui.bother.csec, pred.fi.bother.vag, pred.fi.bother.csec, pred.pfd.bother.vag, pred.pfd.bother.csec, pred.2pfd.bother.vag, pred.2pfd.bother.csec, pred.pop.treat.vag, pred.pop.treat.csec, pred.ui.treat.vag, pred.ui.treat.csec, pred.fi.treat.vag, pred.fi.treat.csec, pred.pfd.treat.vag, pred.pfd.treat.csec, pred.2pfd.treat.vag, pred.2pfd.treat.csec, pred.pop.compo.vag, pred.pop.compo.csec, pred.ui.compo.vag, pred.ui.compo.csec, pred.fi.compo.vag, pred.fi.compo.csec, pred.pfd.compo.vag, pred.pfd.compo.csec, pred.2pfd.compo.vag, pred.2pfd.compo.csec){
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
  text(0.95375, 0.9575, "N/A", cex=2)
  text(0.95375, 0.8925, "N/A", cex=2)
  #any PFD
  text(0.95375, 0.8275, "N/A", cex=2)
  text(0.95375, 0.7625, "N/A", cex=2)
  #any 2 or more PFD
  text(0.95375, 0.6975, "N/A", cex=2)
  text(0.95375, 0.6325, "N/A", cex=2)
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
  lp <- 3.6704111 - 0.051616431 * Age - 0.024607221 * height + 0.39187625 * 
    (FH.POP == "Yes") + 0.71890992 * (uiprepreg == "Yes") + 0.69477538 * 
    (uiduringpreg == "Yes") + 0.67552437 * (multiple == "Yes");
  1/(1+exp(-lp))
})
#Bothersome POP
ProLong.BotherPOP.after <- expression({
  lp <- -0.84881965 + 0.30298427 * parity - 0.099076614 * Age + 0.41423317 * 
    (epidural == "Yes") + 0.49379033 * (FH.POP == "Yes") + 
    0.60189619 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
#Treatment for POP
ProLong.TreatPOP.after <- expression({
  lp <- -9.4268 + 0.13760704 * Age + 0.023535813 * PrepregWeight + 
    0.97815416 * (FH.POP == "Yes");
  1/(1+exp(-lp))
})
#Composite of POP
ProLong.CompoPOP.after <- expression({
  lp <- 1.4753588 + 0.2648621 * parity - 0.041074238 * Age + 0.017934193 * 
    PrepregWeight - 0.028700515 * height + 0.39052387 * (epidural == "Yes") + 0.62005308 * (FH.POP == "Yes") + 0.35206667 * 
    (Episiotomy == "Yes") + 0.58143251 * (uiprepreg == "Yes") + 0.41506412 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
#UI
ProLong.UI.after <- expression({
  lp <- -1.138814 - 0.11167835 * parity + 0.024421446 * Age + 0.34983546 * 
    (delmode2 == "Vaginal") + 0.49471109 * (FH.POP == "Yes") + 
    1.7905902 * (uiprepreg == "Yes") + 1.4188088 * (uiduringpreg == "Yes") + 0.21478367 * (induction == "Yes");
  1/(1+exp(-lp))
})
#Bothersome UI
ProLong.BotherUI.after <- expression({
  lp <- 4.322554 - 0.029647732 * Age + 0.029708808 * PrepregWeight - 
    0.032065916 * height + 0.20354882 * (delmode2 == "Vaginal") + 
    0.32883851 * (FH.POP == "Yes") + 0.85481062 * (uiprepreg == "Yes") + 
    0.7612477 * (uiduringpreg == "Yes");
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
  lp <- 4.4970952 - 0.028309627 * Age + 0.029325068 * PrepregWeight - 
    0.03281012 * height + 0.26079761 * (delmode2 == "Vaginal") + 
    0.23834741 * (FH.POP == "Yes") + 1.0285458 * (uiprepreg == "Yes") + 
    0.72079281 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
#Bothersome FI
ProLong.BotherFI.after <- expression({
  lp <- -0.97826291 + 0.14038045 * parity + 0.018898669 * Age + 0.024061393 * 
    PrepregWeight - 0.020607582 * height + 0.27248232 * (Episiotomy == "Yes") + 0.56624466 * (uiprepreg == "Yes");
  1/(1+exp(-lp))
})
#Treatment for FI
ProLong.TreatFI.after <- expression({
  lp <- -2.7107826 + 0.029075201 * PrepregWeight - 0.63118183 * Bwt.height + 
    0.52507969 * (epidural == "Yes");
  1/(1+exp(-lp))
})
#Composite of FI
ProLong.CompoFI.after <- expression({
  lp <- -3.6579308 + 0.19351297 * parity + 0.021572269 * PrepregWeight + 
    0.34971088 * (Episiotomy == "Yes") + 0.56058433 * (uiprepreg == "Yes") + 
    0.3157898 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
#Bothersome PFD
ProLong.BotherPFD.after <- expression({
  lp <- 4.0280976 + 0.14079446 * parity - 0.022280642 * Age + 0.030815584 * 
    PrepregWeight - 0.030233071 * height + 0.35362122 * (FH.POP == "Yes") + 0.19577765 * (Episiotomy == "Yes") + 0.72978868 * 
    (uiprepreg == "Yes") + 0.49989498 * (uiduringpreg == "Yes") + 0.0013982891 * stage2;
  1/(1+exp(-lp))
})
#Treatment for PFD
ProLong.TreatPFD.after <- expression({
  lp <- -0.69193707 + 0.037740734 * Age + 0.020991164 * PrepregWeight - 
    0.036886936 * height + 0.00034762508 * BirthWeight + 
    0.61265529 * (delmode2 == "Vaginal") + 0.56956987 * (epidural == "Yes") + 0.26427208 * (Episiotomy == "Yes") + 1.2773287 * 
    (uiprepreg == "Yes") + 0.40237679 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
#Composite of PFD
ProLong.CompoPFD.after <- expression({
  lp <- 4.9015979 - 0.034357102 * Age + 0.031234078 * PrepregWeight - 
    0.033708959 * height + 0.32924907 * (delmode2 == "Vaginal") + 
    0.21920569 * (epidural == "Yes") + 0.2966308 * (FH.POP == "Yes") + 0.83860881 * (uiprepreg == "Yes") + 0.54973194 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
#Bothersome 2 PFD
ProLong.Bother2PFD.after <- expression({
  lp <- 7.1198964 + 0.29984304 * parity - 0.045353056 * Age + 0.030488196 * 
    PrepregWeight - 0.042636768 * height - 0.084991316 * 
    circumference + 0.2735331 * (uiprepreg == "Yes") + 0.411249 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
#Treatment for 2 PFD
ProLong.Treat2PFD.after <- expression({
  lp <- -0.36021966 + 0.17032048 * Age - 0.07165287 * height + 0.00054246756 * 
    BirthWeight + 1.0001059 * (FH.POP == "Yes");
  1/(1+exp(-lp))
})
#Composite of 2 PFD
ProLong.Compo2PFD.after <- expression({
  lp <- 7.5353671 + 0.31212625 * parity - 0.025689542 * Age + 0.03354305 * 
    PrepregWeight - 0.050092713 * height - 0.082711844 * 
    circumference + 0.2026665 * (epidural == "Yes") + 0.14887655 * 
    (FH.POP == "Yes") + 0.2957437 * (Episiotomy == "Yes") + 
    0.33044583 * (uiprepreg == "Yes") + 0.23861612 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
########################################################20 year models (SwePop)
#POP
SwePop.POP.after <- expression({
  lp <- 0.086362341 + 0.0060559079 * PrepregWeight - 0.034477462 * 
    height + 0.00014501143 * BirthWeight + 0.04097377 * circumference + 
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
  lp <- -8.0593804 - 0.016445836 * PrepregWeight + 0.0012433252 * 
    BirthWeight - 0.35347233 * (epidural == "Yes") + 1.9355939 * 
    (FH.POP == "Yes") - 0.83242282 * (FH.UI == "Yes");
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
  lp <- 0.50742374 + 0.021776637 * Age + 0.020681185 * PrepregWeight - 
    0.024102771 * height + 0.57223284 * (delmode2 == "Vaginal") - 
    0.14044898 * (FH.POP == "Yes") + 1.6086467 * (FH.UI == "Yes") + 0.2548407 * (FH.FI == "Yes") - 0.1282564 * (Episiotomy == "Yes");
  1/(1+exp(-lp))
})
#Bothersome UI
SwePop.BotherUI.after <- expression({
  lp <- -1.0734901 + 0.019893706 * PrepregWeight - 0.020191772 * 
    height + 0.50231621 * (delmode2 == "Vaginal") + 0.21258875 * 
    (epidural == "Yes") + 0.29124933 * (FH.POP == "Yes") + 
    1.0368519 * (FH.UI == "Yes") - 0.35131066 * (Episiotomy == "Yes");
  1/(1+exp(-lp))
})
#Treatment for UI
SwePop.TreatUI.after <- expression({
  lp <- -6.3562271 + 0.01316452 * PrepregWeight + 0.00026999295 * 
    BirthWeight + 0.65414949 * (delmode2 == "Vaginal") + 
    1.245927 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})
#Composite of UI
SwePop.CompoUI.after <- expression({
  lp <- -4.0110612 + 0.015989521 * PrepregWeight + 0.56140066 * (delmode2 == "Vaginal") + 1.1958132 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})
#Bothersome FI
SwePop.BotherFI.after <- expression({
  lp <- -3.3923702 - 0.050965286 * Age + 0.01780414 * PrepregWeight + 
    0.45803695 * (FH.UI == "Yes") + 0.97236577 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})
#Treatment for FI
SwePop.TreatFI.after <- expression({
  lp <- -4.5783096 + 0.011875551 * PrepregWeight - 0.81098586 * (delmode2 == "Vaginal") + 0.45771166 * (epidural == "Yes") + 1.03147 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})
#Composite of FI
SwePop.CompoFI.after <- expression({
  lp <- 1.7131302 - 0.032862984 * Age + 0.020384123 * PrepregWeight - 
    0.032826392 * height + 0.21085962 * (epidural == "Yes") + 
    0.33371373 * (FH.UI == "Yes") + 1.0046374 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})
#Bothersome PFD
SwePop.BotherPFD.after <- expression({
  lp <- 1.3858103 + 0.019026201 * PrepregWeight - 0.032591202 * height + 
    0.82051575 * (delmode2 == "Vaginal") + 0.49967725 * (FH.POP == "Yes") + 0.84170987 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})
#Treatment for PFD
SwePop.TreatPFD.after <- expression({
  lp <- -5.2253295 + 0.020816636 * Age + 0.00037726673 * BirthWeight + 
    0.32358398 * (delmode2 == "Vaginal") + 0.32872024 * (FH.POP == "Yes") + 0.54356831 * (FH.UI == "Yes") + 0.26959435 * 
    (FH.FI == "Yes") - 0.44915949 * (Episiotomy == "Yes");
  1/(1+exp(-lp))
})
#Composite of PFD
SwePop.CompoPFD.after <- expression({
  lp <- -1.2740402 + 0.012101119 * PrepregWeight - 0.53269414 * Bwt.height + 
    0.12074765 * max(Bwt.height - 3.9608802, 0)**3 - 0.19817306 * 
    max(Bwt.height - 4.7428571, 0)**3 + 0.077425415 * max(Bwt.height - 5.9623776, 0)**3 + 0.91846484 * (delmode2 == "Vaginal") + 
    0.6372069 * (FH.POP == "Yes") + 0.92517171 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})
#Bothersome 2 PFD
SwePop.Bother2PFD.after <- expression({
  lp <- -1.4692333 + 0.016348049 * PrepregWeight - 0.23244733 * Bwt.height - 
    0.10083104 * circumference + 0.7604179 * (delmode2 == "Vaginal") + 1.15577 * (FH.POP == "Yes") + 0.74324133 * 
    (FH.UI == "Yes") + 0.92684933 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})
#Treatment for 2 PFD
SwePop.Treat2PFD.after <- expression({
  lp <- -8.5583616 + 0.00068873972 * BirthWeight + 1.111058 * (FH.UI == "Yes") + 0.70532879 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})
#Treatment for 2 PFD
SwePop.Compo2PFD.after <- expression({
  lp <- 2.2198667 + 0.015544052 * PrepregWeight - 0.84132303 * Bwt.height + 
    0.1694497 * max(Bwt.height - 3.9608802, 0)**3 - 0.27810368 * 
    max(Bwt.height - 4.7428571, 0)**3 + 0.10865398 * max(Bwt.height - 5.9623776, 0)**3 - 0.11773453 * circumference + 0.75828506 * 
    (delmode2 == "Vaginal") + 1.0101912 * (FH.POP == "Yes") + 
    0.75205969 * (FH.UI == "Yes") + 0.64388282 * (FH.FI == "Yes") - 0.67299847 * (Episiotomy == "Yes");
  1/(1+exp(-lp))
})

PostpardumPlot <- function(pred.pop.any, pred.ui.any, pred.pop.bother, pred.ui.bother, pred.fi.bother, pred.pfd.bother, pred.2pfd.bother, pred.pop.treat, pred.ui.treat, pred.fi.treat, pred.pfd.treat, pred.2pfd.treat, pred.pop.compo, pred.ui.compo, pred.fi.compo, pred.pfd.compo, pred.2pfd.compo){
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
  text(0.9275, 0.925, "N/A", cex=2)
  #any PFD
  text(0.9275, 0.795, "N/A", cex=2)
  #any 2 or more PFD
  text(0.9275, 0.665, "N/A", cex=2)
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
    
    PriorDelivPlot(pred.ProLong.POP.vag.before, pred.ProLong.POP.csec.before, pred.ProLong.UI.vag.before, pred.ProLong.UI.csec.before, pred.ProLong.BotherPOP.vag.before, pred.ProLong.BotherPOP.csec.before, pred.ProLong.BotherUI.vag.before, pred.ProLong.BotherUI.csec.before, pred.ProLong.BotherFI.vag.before, pred.ProLong.BotherFI.csec.before, pred.ProLong.BotherPFD.vag.before, pred.ProLong.BotherPFD.csec.before, pred.ProLong.Bother2PFD.vag.before, pred.ProLong.Bother2PFD.csec.before, pred.ProLong.TreatPOP.vag.before, pred.ProLong.TreatPOP.csec.before, pred.ProLong.TreatUI.vag.before, pred.ProLong.TreatUI.csec.before, pred.ProLong.TreatFI.vag.before, pred.ProLong.TreatFI.csec.before, pred.ProLong.TreatPFD.vag.before, pred.ProLong.TreatPFD.csec.before, pred.ProLong.Treat2PFD.vag.before, pred.ProLong.Treat2PFD.csec.before, pred.ProLong.CompoPOP.vag.before, pred.ProLong.CompoPOP.csec.before, pred.ProLong.CompoUI.vag.before, pred.ProLong.CompoUI.csec.before, pred.ProLong.CompoFI.vag.before, pred.ProLong.CompoFI.csec.before, pred.ProLong.CompoPFD.vag.before, pred.ProLong.CompoPFD.csec.before, pred.ProLong.Compo2PFD.vag.before, pred.ProLong.Compo2PFD.csec.before)
  })
  
  output$pred1.5 <- renderPlot({
    new.dat <- get_newdata()
    pred.SwePop.POP.vag.before <- eval(SwePop.POP.vag.before, envir = new.dat)
    pred.SwePop.POP.csec.before <- eval(SwePop.POP.csec.before, envir = new.dat)
    pred.SwePop.UI.vag.before <- eval(SwePop.UI.vag.before, envir = new.dat)
    pred.SwePop.UI.csec.before <- eval(SwePop.UI.csec.before, envir = new.dat)
    
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
    
    PriorDelivPlot(pred.SwePop.POP.vag.before, pred.SwePop.POP.csec.before, pred.SwePop.UI.vag.before, pred.SwePop.UI.csec.before, pred.SwePop.BotherPOP.vag.before, pred.SwePop.BotherPOP.csec.before, pred.SwePop.BotherUI.vag.before, pred.SwePop.BotherUI.csec.before, pred.SwePop.BotherFI.vag.before, pred.SwePop.BotherFI.csec.before, pred.SwePop.BotherPFD.vag.before, pred.SwePop.BotherPFD.csec.before, pred.SwePop.Bother2PFD.vag.before, pred.SwePop.Bother2PFD.csec.before, pred.SwePop.TreatPOP.vag.before, pred.SwePop.TreatPOP.csec.before, pred.SwePop.TreatUI.vag.before, pred.SwePop.TreatUI.csec.before, pred.SwePop.TreatFI.vag.before, pred.SwePop.TreatFI.csec.before, pred.SwePop.TreatPFD.vag.before, pred.SwePop.TreatPFD.csec.before, pred.SwePop.Treat2PFD.vag.before, pred.SwePop.Treat2PFD.csec.before, pred.SwePop.CompoPOP.vag.before, pred.SwePop.CompoPOP.csec.before, pred.SwePop.CompoUI.vag.before, pred.SwePop.CompoUI.csec.before, pred.SwePop.CompoFI.vag.before, pred.SwePop.CompoFI.csec.before, pred.SwePop.CompoPFD.vag.before, pred.SwePop.CompoPFD.csec.before, pred.SwePop.Compo2PFD.vag.before, pred.SwePop.Compo2PFD.csec.before)
  })
  
  output$pred2 <- renderPlot({
    new.dat <- get_newdata()
    pred.ProLong.POP.after <- eval(ProLong.POP.after, envir = new.dat)
    pred.ProLong.UI.after <- eval(ProLong.UI.after, envir = new.dat)
    
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
    
    PostpardumPlot(pred.ProLong.POP.after, pred.ProLong.UI.after, pred.ProLong.BotherPOP.after, pred.ProLong.BotherUI.after, pred.ProLong.BotherFI.after, pred.ProLong.BotherPFD.after, pred.ProLong.Bother2PFD.after, pred.ProLong.TreatPOP.after, pred.ProLong.TreatUI.after, pred.ProLong.TreatFI.after, pred.ProLong.TreatPFD.after, pred.ProLong.Treat2PFD.after, pred.ProLong.CompoPOP.after, pred.ProLong.CompoUI.after, pred.ProLong.CompoFI.after, pred.ProLong.CompoPFD.after, pred.ProLong.Compo2PFD.after)
  })
  
  output$pred2.5 <- renderPlot({
    new.dat <- get_newdata()
    pred.SwePop.POP.after <- eval(SwePop.POP.after, envir = new.dat)
    pred.SwePop.UI.after <- eval(SwePop.UI.after, envir = new.dat)
    
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
    
    PostpardumPlot(pred.SwePop.POP.after, pred.SwePop.UI.after, pred.SwePop.BotherPOP.after, pred.SwePop.BotherUI.after, pred.SwePop.BotherFI.after, pred.SwePop.BotherPFD.after, pred.SwePop.Bother2PFD.after, pred.SwePop.TreatPOP.after, pred.SwePop.TreatUI.after, pred.SwePop.TreatFI.after, pred.SwePop.TreatPFD.after, pred.SwePop.Treat2PFD.after, pred.SwePop.CompoPOP.after, pred.SwePop.CompoUI.after, pred.SwePop.CompoFI.after, pred.SwePop.CompoPFD.after, pred.SwePop.Compo2PFD.after)
  })
  
})