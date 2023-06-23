require(shiny)



######12 year models(ProLong)
#####POP
## Vaginal
ProLong.POP.vag <- expression({
  lp <- 3.6956988 - 0.050854279 * Age - 0.024768861 * height + 0.39409592 * (FH.POP == "Yes") + 0.71334542 * (uiprepreg == "Yes") + 0.6891609 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.POP.csec <- expression({
  lp <- 3.6956988 - 0.050854279 * Age - 0.024768861 * height + 0.39409592 * (FH.POP == "Yes") + 0.71334542 * (uiprepreg == "Yes") + 0.6891609 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})

#####Bothersome POP
## Vaginal
ProLong.BotherPOP.vag <- expression({
  lp <- 3.9793057 + 0.24187659 * parity - 0.09973269 * Age + 0.016401187 * 
    PrepregWeight - 0.03425059 * height + 0.52574193 * (FH.POP == "Yes") + 0.55326307 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.BotherPOP.csec <- expression({
  lp <- 3.9793057 + 0.24187659 * parity - 0.09973269 * Age + 0.016401187 * 
    PrepregWeight - 0.03425059 * height + 0.52574193 * (FH.POP == "Yes") + 0.55326307 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})

#####Treatment for POP
## Vaginal
ProLong.TreatPOP.vag <- expression({
  lp <- -10.447932 + 0.13671401 * Age + 0.021626867 * PrepregWeight + 0.00033922595 * BirthWeight + 0.97867607 * (FH.POP == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.TreatPOP.csec <- expression({
  lp <- -10.447932 + 0.13671401 * Age + 0.021626867 * PrepregWeight + 0.00033922595 * BirthWeight + 0.97867607 * (FH.POP == "Yes");
  1/(1+exp(-lp))
})

#####Composite of POP
## Vaginal
ProLong.CompoPOP.vag <- expression({
  lp <- 2.2275621 + 0.17752923 * parity - 0.037355951 * Age + 0.019116688 * 
    PrepregWeight - 0.032110696 * height + 0.63984451 * (FH.POP == "Yes") + 0.53246377 * (uiprepreg == "Yes") + 0.42596158 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
## Vaginal
ProLong.CompoPOP.csec <- expression({
  lp <- 2.2275621 + 0.17752923 * parity - 0.037355951 * Age + 0.019116688 * 
    PrepregWeight - 0.032110696 * height + 0.63984451 * (FH.POP == "Yes") + 0.53246377 * (uiprepreg == "Yes") + 0.42596158 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})

#####UI
## Vaginal
ProLong.UI.vag <- expression({
  lp <- -1.0992483 - 0.12107433 * parity + 0.024783245 * Age + 0.35082349 * 
    1 + 0.50857387 * (FH.POP == "Yes") + 1.7820322 * (uiprepreg == "Yes") + 1.4187054 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.UI.csec <- expression({
  lp <- -1.0992483 - 0.12107433 * parity + 0.024783245 * Age + 0.35082349 * 
    0 + 0.50857387 * (FH.POP == "Yes") + 1.7820322 * (uiprepreg == "Yes") + 1.4187054 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})

#####Bothersome UI
## Vaginal
ProLong.BotherUI.vag <- expression({
  lp <- 4.322554 - 0.029647732 * Age + 0.029708808 * PrepregWeight - 0.032065916 * height + 0.20354882 * 1 + 
    0.32883851 * (FH.POP == "Yes") + 0.85481062 * (uiprepreg == "Yes") + 0.7612477 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.BotherUI.csec <- expression({
  lp <- 4.322554 - 0.029647732 * Age + 0.029708808 * PrepregWeight - 0.032065916 * height + 0.20354882 * 0 + 
    0.32883851 * (FH.POP == "Yes") + 0.85481062 * (uiprepreg == "Yes") + 0.7612477 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})

#####Treatment for UI
## Vaginal
ProLong.TreatUI.vag <- expression({
  lp <- -1.649538 - 0.22847971 * parity + 0.046745714 * Age - 0.020091952 * 
    height + 0.99380684 * 1 + 1.5257638 * (uiprepreg == "Yes") + 0.31507231 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.TreatUI.csec <- expression({
  lp <- -1.649538 - 0.22847971 * parity + 0.046745714 * Age - 0.020091952 * 
    height + 0.99380684 * 0 + 1.5257638 * (uiprepreg == "Yes") + 0.31507231 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})

#####Composite of UI
## Vaginal
ProLong.CompoUI.vag <- expression({
  lp <- 4.4970952 - 0.028309627 * Age + 0.029325068 * PrepregWeight - 0.03281012 * height + 0.26079761 * 1 + 
    0.23834741 * (FH.POP == "Yes") + 1.0285458 * (uiprepreg == "Yes") + 0.72079281 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.CompoUI.csec <- expression({
  lp <- 4.4970952 - 0.028309627 * Age + 0.029325068 * PrepregWeight - 0.03281012 * height + 0.26079761 * 0 + 
    0.23834741 * (FH.POP == "Yes") + 1.0285458 * (uiprepreg == "Yes") + 0.72079281 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})

#####Bothersome FI
## Vaginal
ProLong.BotherFI.vag <- expression({
  lp <- -0.70880645 + 0.026725689 * Age + 0.023984978 * PrepregWeight - 0.021730371 * height + 0.6049813 * (uiprepreg == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.BotherFI.csec <- expression({
  lp <- -0.70880645 + 0.026725689 * Age + 0.023984978 * PrepregWeight - 0.021730371 * height + 0.6049813 * (uiprepreg == "Yes");
  1/(1+exp(-lp))
})

#####Treatment for FI
## Vaginal
ProLong.TreatFI.vag <- expression({
  lp <- -2.4067932 + 0.030784593 * PrepregWeight - 0.67659832 * Bwt.height;
  1/(1+exp(-lp))
})
## C-Section
ProLong.TreatFI.csec <- expression({
  lp <- -2.4067932 + 0.030784593 * PrepregWeight - 0.67659832 * Bwt.height;
  1/(1+exp(-lp))
})

#####Composite of FI
## Vaginal
ProLong.CompoFI.vag <- expression({
  lp <- -0.062462857 + 0.096912419 * parity + 0.016418002 * Age + 0.025041924 * PrepregWeight - 0.027867723 * height + 
    0.00013956281 * BirthWeight + 0.19311497 * (FH.POP == "Yes") + 0.49823562 * (uiprepreg == "Yes") + 0.30088359 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.CompoFI.csec <- expression({
  lp <- -0.062462857 + 0.096912419 * parity + 0.016418002 * Age + 0.025041924 * PrepregWeight - 0.027867723 * height + 
    0.00013956281 * BirthWeight + 0.19311497 * (FH.POP == "Yes") + 0.49823562 * (uiprepreg == "Yes") + 0.30088359 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})

#####Bothersome PFD
## Vaginal
ProLong.BotherPFD.vag <- expression({
  lp <- 3.8724 + 0.029984046 * PrepregWeight - 0.030821968 * height + 0.37395999 * (FH.POP == "Yes") + 0.7263833 * (uiprepreg == "Yes") + 0.51962292 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.BotherPFD.csec <- expression({
  lp <- 3.8724 + 0.029984046 * PrepregWeight - 0.030821968 * height + 0.37395999 * (FH.POP == "Yes") + 0.7263833 * (uiprepreg == "Yes") + 0.51962292 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})

#####Treatment for PFD
## Vaginal
ProLong.TreatPFD.vag <- expression({
  lp <- -0.2011576 + 0.016845475 * PrepregWeight - 0.69159835 * Bwt.height + 0.13699403 * max(Bwt.height - 4.0190046, 0)**3 - 0.21938738 * 
    max(Bwt.height - 4.7875286, 0)**3 + 0.082393356 * max(Bwt.height - 6.0653403, 0)**3 + 1.270255 * (uiprepreg == "Yes") + 0.45241401 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.TreatPFD.csec <- expression({
  lp <- -0.2011576 + 0.016845475 * PrepregWeight - 0.69159835 * Bwt.height + 0.13699403 * max(Bwt.height - 4.0190046, 0)**3 - 0.21938738 * 
    max(Bwt.height - 4.7875286, 0)**3 + 0.082393356 * max(Bwt.height - 6.0653403, 0)**3 + 1.270255 * (uiprepreg == "Yes") + 0.45241401 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})

#####Composite of PFD
## Vaginal
ProLong.CompoPFD.vag <- expression({
  lp <- 5.0418777 - 0.036476964 * Age + 0.031204157 * PrepregWeight - 0.032067382 * height + 0.29861156 * (FH.POP == "Yes") + 0.83816285 * (uiprepreg == "Yes") + 0.5678043 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.CompoPFD.csec <- expression({
  lp <- 5.0418777 - 0.036476964 * Age + 0.031204157 * PrepregWeight - 0.032067382 * height + 0.29861156 * (FH.POP == "Yes") + 0.83816285 * (uiprepreg == "Yes") + 0.5678043 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})

#####Bothersome 2 PFD
## Vaginal
ProLong.Bother2PFD.vag <- expression({
  lp <- 7.1198964 + 0.29984304 * parity - 0.045353056 * Age + 0.030488196 * 
    PrepregWeight - 0.042636768 * height - 0.084991316 * circumference + 0.2735331 * (uiprepreg == "Yes") + 0.411249 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.Bother2PFD.csec <- expression({
  lp <- 7.1198964 + 0.29984304 * parity - 0.045353056 * Age + 0.030488196 * 
    PrepregWeight - 0.042636768 * height - 0.084991316 * circumference + 0.2735331 * (uiprepreg == "Yes") + 0.411249 * (uiduringpreg == "Yes");
  1/(1+exp(-lp))
})

#####Treatment for 2 PFD
## Vaginal
ProLong.Treat2PFD.vag <- expression({
  lp <- -0.36021966 + 0.17032048 * Age - 0.07165287 * height + 0.00054246756 * BirthWeight + 1.0001059 * (FH.POP == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.Treat2PFD.csec <- expression({
  lp <- -0.36021966 + 0.17032048 * Age - 0.07165287 * height + 0.00054246756 * BirthWeight + 1.0001059 * (FH.POP == "Yes");
  1/(1+exp(-lp))
})

#####Composite of 2 PFD
## Vaginal
ProLong.Compo2PFD.vag <- expression({
  lp <- 7.6772933 + 0.25786122 * parity + 0.034803865 * PrepregWeight - 0.054432807 * height - 0.079627486 * circumference;
  1/(1+exp(-lp))
})
## C-Section
ProLong.Compo2PFD.csec <- expression({
  lp <- 7.6772933 + 0.25786122 * parity + 0.034803865 * PrepregWeight - 0.054432807 * height - 0.079627486 * circumference;
  1/(1+exp(-lp))
})




######20 year models (SwePop)
#####POP
## Vaginal
SwePop.POP.vag <- expression({
  lp <- 0.086362341 + 0.0060559079 * PrepregWeight - 0.034477462 * height + 0.00014501143 * BirthWeight + 0.04097377 * circumference + 
    1.1274898 * 1 + 0.84095709 * (FH.POP == "Yes") + 0.38807919 * (FH.UI == "Yes") + 0.2897172 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.POP.csec <- expression({
  lp <- 0.086362341 + 0.0060559079 * PrepregWeight - 0.034477462 * height + 0.00014501143 * BirthWeight + 0.04097377 * circumference + 
    1.1274898 * 0 + 0.84095709 * (FH.POP == "Yes") + 0.38807919 * (FH.UI == "Yes") + 0.2897172 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})

#####Bothersome POP
## Vaginal
SwePop.BotherPOP.vag <- expression({
  lp <- -5.8856757 + 0.00031454699 * BirthWeight + 1.5174002 * 1 + 1.3759935 * (FH.POP == "Yes") + 0.52465413 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.BotherPOP.csec <- expression({
  lp <- -5.8856757 + 0.00031454699 * BirthWeight + 1.5174002 * 0 + 1.3759935 * (FH.POP == "Yes") + 0.52465413 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})

#####Treatment for POP
## Vaginal
SwePop.TreatPOP.vag <- expression({
  lp <- -8.7351039 + 0.024495103 * Age - 0.016574761 * PrepregWeight + 0.0012037986 * BirthWeight + 1.9131961 * (FH.POP == "Yes") - 0.825517 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.TreatPOP.csec <- expression({
  lp <- -8.7351039 + 0.024495103 * Age - 0.016574761 * PrepregWeight + 0.0012037986 * BirthWeight + 1.9131961 * (FH.POP == "Yes") - 0.825517 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})

#####Composite of POP
## Vaginal
SwePop.CompoPOP.vag <- expression({
  lp <- -1.1221432 - 0.78035428 * Bwt.height + 0.15777475 * max(Bwt.height - 3.9608802, 0)**3 - 0.25894256 * max(Bwt.height - 4.7428571, 0)**3 + 0.10116781 * max(Bwt.height - 5.9623776, 0)**3 + 
    1.6483109 * 1 + 1.5199717 * (FH.POP == "Yes") + 0.34329192 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.CompoPOP.csec <- expression({
  lp <- -1.1221432 - 0.78035428 * Bwt.height + 0.15777475 * max(Bwt.height - 3.9608802, 0)**3 - 0.25894256 * max(Bwt.height - 4.7428571, 0)**3 + 0.10116781 * max(Bwt.height - 5.9623776, 0)**3 + 
    1.6483109 * 0 + 1.5199717 * (FH.POP == "Yes") + 0.34329192 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})

#####UI
## Vaginal
SwePop.UI.vag <- expression({
  lp <- 0.49624908 + 0.021775329 * Age + 0.020890093 * PrepregWeight - 0.024110535 * height + 0.5592133 * 1 - 
    0.13947227 * (FH.POP == "Yes") + 1.6079145 * (FH.UI == "Yes") + 0.25331044 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.UI.csec <- expression({
  lp <- 0.49624908 + 0.021775329 * Age + 0.020890093 * PrepregWeight - 0.024110535 * height + 0.5592133 * 0 - 
    0.13947227 * (FH.POP == "Yes") + 1.6079145 * (FH.UI == "Yes") + 0.25331044 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})

#####Bothersome UI
## Vaginal
SwePop.BotherUI.vag <- expression({
  lp <- -4.1546514 + 0.01751938 * PrepregWeight + 0.43529983 * 1 + 1.1120021 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.BotherUI.csec <- expression({
  lp <- -4.1546514 + 0.01751938 * PrepregWeight + 0.43529983 * 0 + 1.1120021 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})

#####Treatment for UI
## Vaginal
SwePop.TreatUI.vag <- expression({
  lp <- -6.3562271 + 0.01316452 * PrepregWeight + 0.00026999295 * BirthWeight + 0.65414949 * 1 + 1.245927 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.TreatUI.csec <- expression({
  lp <- -6.3562271 + 0.01316452 * PrepregWeight + 0.00026999295 * BirthWeight + 0.65414949 * 0 + 1.245927 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})

#####Composite of UI
## Vaginal
SwePop.CompoUI.vag <- expression({
  lp <- -4.0110612 + 0.015989521 * PrepregWeight + 0.56140066 * 1 + 1.1958132 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.CompoUI.csec <- expression({
  lp <- -4.0110612 + 0.015989521 * PrepregWeight + 0.56140066 * 0 + 1.1958132 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})

#####Bothersome FI
## Vaginal
SwePop.BotherFI.vag <- expression({
  lp <- -3.3923702 - 0.050965286 * Age + 0.01780414 * PrepregWeight + 0.45803695 * (FH.UI == "Yes") + 0.97236577 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.BotherFI.csec <- expression({
  lp <- -3.3923702 - 0.050965286 * Age + 0.01780414 * PrepregWeight + 0.45803695 * (FH.UI == "Yes") + 0.97236577 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})

#####Treatment for FI
## Vaginal
SwePop.TreatFI.vag <- expression({
  lp <- -4.4461225 + 0.012280974 * PrepregWeight - 0.80311556 * 1 + 1.015031 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.TreatFI.csec <- expression({
  lp <- -4.4461225 + 0.012280974 * PrepregWeight - 0.80311556 * 0 + 1.015031 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})

#####Composite of FI
## Vaginal
SwePop.CompoFI.vag <- expression({
  lp <- 1.8159994 - 0.032933142 * Age + 0.020570891 * PrepregWeight - 0.033102998 * height + 0.3441092 * (FH.UI == "Yes") + 0.99315704 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.CompoFI.csec <- expression({
  lp <- 1.8159994 - 0.032933142 * Age + 0.020570891 * PrepregWeight - 0.033102998 * height + 0.3441092 * (FH.UI == "Yes") + 0.99315704 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})

#####Bothersome PFD
## Vaginal
SwePop.BotherPFD.vag <- expression({
  lp <- 1.3858103 + 0.019026201 * PrepregWeight - 0.032591202 * height + 0.82051575 * 1 + 0.49967725 * (FH.POP == "Yes") + 0.84170987 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.BotherPFD.csec <- expression({
  lp <- 1.3858103 + 0.019026201 * PrepregWeight - 0.032591202 * height + 0.82051575 * 0 + 0.49967725 * (FH.POP == "Yes") + 0.84170987 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})

#####Treatment for PFD
## Vaginal
SwePop.TreatPFD.vag <- expression({
  lp <- -5.233742 + 0.020682138 * Age + 0.0003812622 * BirthWeight + 0.28472959 * 1 + 0.33331018 * (FH.POP == "Yes") + 0.54140219 * (FH.UI == "Yes") + 0.26520328 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.TreatPFD.csec <- expression({
  lp <- -5.233742 + 0.020682138 * Age + 0.0003812622 * BirthWeight + 0.28472959 * 0 + 0.33331018 * (FH.POP == "Yes") + 0.54140219 * (FH.UI == "Yes") + 0.26520328 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})

#####Composite of PFD
## Vaginal
SwePop.CompoPFD.vag <- expression({
  lp <- -1.2740402 + 0.012101119 * PrepregWeight - 0.53269414 * Bwt.height + 0.12074765 * max(Bwt.height - 3.9608802, 0)**3 - 0.19817306 * 
    max(Bwt.height - 4.7428571, 0)**3 + 0.077425415 * max(Bwt.height - 5.9623776, 0)**3 + 0.91846484 * 1 + 0.6372069 * (FH.POP == "Yes") + 0.92517171 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.CompoPFD.csec <- expression({
  lp <- -1.2740402 + 0.012101119 * PrepregWeight - 0.53269414 * Bwt.height + 0.12074765 * max(Bwt.height - 3.9608802, 0)**3 - 0.19817306 * 
    max(Bwt.height - 4.7428571, 0)**3 + 0.077425415 * max(Bwt.height - 5.9623776, 0)**3 + 0.91846484 * 0 + 0.6372069 * (FH.POP == "Yes") + 0.92517171 * (FH.UI == "Yes");
  1/(1+exp(-lp))
})

#####Bothersome 2 PFD
## Vaginal
SwePop.Bother2PFD.vag <- expression({
  lp <- -1.4692333 + 0.016348049 * PrepregWeight - 0.23244733 * Bwt.height - 0.10083104 * circumference + 0.7604179 * 1 + 1.15577 * (FH.POP == "Yes") + 0.74324133 * 
    (FH.UI == "Yes") + 0.92684933 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.Bother2PFD.csec <- expression({
  lp <- -1.4692333 + 0.016348049 * PrepregWeight - 0.23244733 * Bwt.height - 0.10083104 * circumference + 0.7604179 * 0 + 1.15577 * (FH.POP == "Yes") + 0.74324133 * 
    (FH.UI == "Yes") + 0.92684933 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})

#####Treatment for 2 PFD
## Vaginal
SwePop.Treat2PFD.vag <- expression({
  lp <- -8.5583616 + 0.00068873972 * BirthWeight + 1.111058 * (FH.UI == "Yes") + 0.70532879 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.Treat2PFD.csec <- expression({
  lp <- -8.5583616 + 0.00068873972 * BirthWeight + 1.111058 * (FH.UI == "Yes") + 0.70532879 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})

#####Treatment for 2 PFD
## Vaginal
SwePop.Compo2PFD.vag <- expression({
  lp <- -3.4149124 + 0.015200827 * PrepregWeight + 0.00052623852 * BirthWeight - 0.11567555 * circumference + 0.63036912 * 
    1 + 1.0264006 * (FH.POP == "Yes") + 0.73794424 * (FH.UI == "Yes") + 0.6289421 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})
## C-Section
SwePop.Compo2PFD.csec <- expression({
  lp <- -3.4149124 + 0.015200827 * PrepregWeight + 0.00052623852 * BirthWeight - 0.11567555 * circumference + 0.63036912 * 
    0 + 1.0264006 * (FH.POP == "Yes") + 0.73794424 * (FH.UI == "Yes") + 0.6289421 * (FH.FI == "Yes");
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


shinyServer(function(input, output) {
  get_newdata <- reactive({
    new_df <- data.frame(Age = input$Age, 
                         parity = input$parity,
                         PrepregWeight = input$PrepregWeight,
                         PrepregWeight.b = input$PrepregWeight.b,
                         height = input$height,
                         height.ft = input$height.ft,
                         height.in = input$height.in,
                         BirthWeight = input$BirthWeight,
                         BirthWeight.p = input$BirthWeight.p,
                         BirthWeight.o = input$BirthWeight.o,
                         circumference = input$circumference,
                         delmode2 = factor(input$delmode2, levels = c("Vaginal", "C-Section")),
                         FH.POP = factor(input$FH.POP, levels = c("Yes", "No")), 
                         FH.UI = factor(input$FH.UI, levels = c("Yes", "No")), 
                         FH.FI = factor(input$FH.FI, levels = c("Yes", "No")),
                         uiprepreg = factor(input$uiprepreg, levels = c("Yes", "No")), 
                         uiduringpreg = factor(input$uiduringpreg, levels = c("Yes", "No")) 
    )
    new_df$PrepregWeight <- with(new_df, ifelse(PrepregWeight == 0 | is.na(PrepregWeight) == T, PrepregWeight.b*0.453592, PrepregWeight))
    new_df$height <- with(new_df, ifelse(height == 0 | is.na(height) == T, (height.ft*12 + ifelse(is.na(height.in) == T, 0, height.in))*2.54, height))
    new_df$BirthWeight <- with(new_df, ifelse(BirthWeight == 0 | is.na(BirthWeight) == T, (BirthWeight.p*16 + ifelse(is.na(BirthWeight.o) == T, 0, BirthWeight.o))/0.035274, BirthWeight))
    new_df$Bwt.height <- with(new_df, (height/BirthWeight)*100)
    new_df
    
  })
  
  output$prediction <- renderPlot({
    new.dat <- get_newdata()
    pred.ProLong.POP.vag <- eval(ProLong.POP.vag, envir = new.dat)
    pred.ProLong.BotherPOP.vag <- eval(ProLong.BotherPOP.vag, envir = new.dat)
    pred.ProLong.TreatPOP.vag <- eval(ProLong.TreatPOP.vag, envir = new.dat)
    pred.ProLong.CompoPOP.vag <- eval(ProLong.CompoPOP.vag, envir = new.dat)
    pred.ProLong.UI.vag <- eval(ProLong.UI.vag, envir = new.dat)
    pred.ProLong.BotherUI.vag <- eval(ProLong.BotherUI.vag, envir = new.dat)
    pred.ProLong.TreatUI.vag <- eval(ProLong.TreatUI.vag, envir = new.dat)
    pred.ProLong.CompoUI.vag <- eval(ProLong.CompoUI.vag, envir = new.dat)
    pred.ProLong.BotherFI.vag <- eval(ProLong.BotherFI.vag, envir = new.dat)
    pred.ProLong.TreatFI.vag <- eval(ProLong.TreatFI.vag, envir = new.dat)
    pred.ProLong.CompoFI.vag <- eval(ProLong.CompoFI.vag, envir = new.dat)
    pred.ProLong.BotherPFD.vag <- eval(ProLong.BotherPFD.vag, envir = new.dat)
    pred.ProLong.TreatPFD.vag <- eval(ProLong.TreatPFD.vag, envir = new.dat)
    pred.ProLong.CompoPFD.vag <- eval(ProLong.CompoPFD.vag, envir = new.dat)
    pred.ProLong.Bother2PFD.vag <- eval(ProLong.Bother2PFD.vag, envir = new.dat)
    pred.ProLong.Treat2PFD.vag <- eval(ProLong.Treat2PFD.vag, envir = new.dat)
    pred.ProLong.Compo2PFD.vag <- eval(ProLong.Compo2PFD.vag, envir = new.dat)
    
    pred.ProLong.POP.csec <- eval(ProLong.POP.csec, envir = new.dat)
    pred.ProLong.BotherPOP.csec <- eval(ProLong.BotherPOP.csec, envir = new.dat)
    pred.ProLong.TreatPOP.csec <- eval(ProLong.TreatPOP.csec, envir = new.dat)
    pred.ProLong.CompoPOP.csec <- eval(ProLong.CompoPOP.csec, envir = new.dat)
    pred.ProLong.UI.csec <- eval(ProLong.UI.csec, envir = new.dat)
    pred.ProLong.BotherUI.csec <- eval(ProLong.BotherUI.csec, envir = new.dat)
    pred.ProLong.TreatUI.csec <- eval(ProLong.TreatUI.csec, envir = new.dat)
    pred.ProLong.CompoUI.csec <- eval(ProLong.CompoUI.csec, envir = new.dat)
    pred.ProLong.BotherFI.csec <- eval(ProLong.BotherFI.csec, envir = new.dat)
    pred.ProLong.TreatFI.csec <- eval(ProLong.TreatFI.csec, envir = new.dat)
    pred.ProLong.CompoFI.csec <- eval(ProLong.CompoFI.csec, envir = new.dat)
    pred.ProLong.BotherPFD.csec <- eval(ProLong.BotherPFD.csec, envir = new.dat)
    pred.ProLong.TreatPFD.csec <- eval(ProLong.TreatPFD.csec, envir = new.dat)
    pred.ProLong.CompoPFD.csec <- eval(ProLong.CompoPFD.csec, envir = new.dat)
    pred.ProLong.Bother2PFD.csec <- eval(ProLong.Bother2PFD.csec, envir = new.dat)
    pred.ProLong.Treat2PFD.csec <- eval(ProLong.Treat2PFD.csec, envir = new.dat)
    pred.ProLong.Compo2PFD.csec <- eval(ProLong.Compo2PFD.csec, envir = new.dat)
        
    PriorDelivPlot(pred.ProLong.POP.vag, pred.ProLong.POP.csec, pred.ProLong.UI.vag, pred.ProLong.UI.csec, pred.ProLong.BotherPOP.vag, pred.ProLong.BotherPOP.csec, pred.ProLong.BotherUI.vag, pred.ProLong.BotherUI.csec, pred.ProLong.BotherFI.vag, pred.ProLong.BotherFI.csec, pred.ProLong.BotherPFD.vag, pred.ProLong.BotherPFD.csec, pred.ProLong.Bother2PFD.vag, pred.ProLong.Bother2PFD.csec, pred.ProLong.TreatPOP.vag, pred.ProLong.TreatPOP.csec, pred.ProLong.TreatUI.vag, pred.ProLong.TreatUI.csec, pred.ProLong.TreatFI.vag, pred.ProLong.TreatFI.csec, pred.ProLong.TreatPFD.vag, pred.ProLong.TreatPFD.csec, pred.ProLong.Treat2PFD.vag, pred.ProLong.Treat2PFD.csec, pred.ProLong.CompoPOP.vag, pred.ProLong.CompoPOP.csec, pred.ProLong.CompoUI.vag, pred.ProLong.CompoUI.csec, pred.ProLong.CompoFI.vag, pred.ProLong.CompoFI.csec, pred.ProLong.CompoPFD.vag, pred.ProLong.CompoPFD.csec, pred.ProLong.Compo2PFD.vag, pred.ProLong.Compo2PFD.csec)
  })
  
  output$prediction2 <- renderPlot({
    new.dat <- get_newdata()
    pred.SwePop.POP.vag <- eval(SwePop.POP.vag, envir = new.dat)
    pred.SwePop.BotherPOP.vag <- eval(SwePop.BotherPOP.vag, envir = new.dat)
    pred.SwePop.TreatPOP.vag <- eval(SwePop.TreatPOP.vag, envir = new.dat)
    pred.SwePop.CompoPOP.vag <- eval(SwePop.CompoPOP.vag, envir = new.dat)
    pred.SwePop.UI.vag <- eval(SwePop.UI.vag, envir = new.dat)
    pred.SwePop.BotherUI.vag <- eval(SwePop.BotherUI.vag, envir = new.dat)
    pred.SwePop.TreatUI.vag <- eval(SwePop.TreatUI.vag, envir = new.dat)
    pred.SwePop.CompoUI.vag <- eval(SwePop.CompoUI.vag, envir = new.dat)
    pred.SwePop.BotherFI.vag <- eval(SwePop.BotherFI.vag, envir = new.dat)
    pred.SwePop.TreatFI.vag <- eval(SwePop.TreatFI.vag, envir = new.dat)
    pred.SwePop.CompoFI.vag <- eval(SwePop.CompoFI.vag, envir = new.dat)
    pred.SwePop.BotherPFD.vag <- eval(SwePop.BotherPFD.vag, envir = new.dat)
    pred.SwePop.TreatPFD.vag <- eval(SwePop.TreatPFD.vag, envir = new.dat)
    pred.SwePop.CompoPFD.vag <- eval(SwePop.CompoPFD.vag, envir = new.dat)
    pred.SwePop.Bother2PFD.vag <- eval(SwePop.Bother2PFD.vag, envir = new.dat)
    pred.SwePop.Treat2PFD.vag <- eval(SwePop.Treat2PFD.vag, envir = new.dat)
    pred.SwePop.Compo2PFD.vag <- eval(SwePop.Compo2PFD.vag, envir = new.dat)
    
    pred.SwePop.POP.csec <- eval(SwePop.POP.csec, envir = new.dat)
    pred.SwePop.BotherPOP.csec <- eval(SwePop.BotherPOP.csec, envir = new.dat)
    pred.SwePop.TreatPOP.csec <- eval(SwePop.TreatPOP.csec, envir = new.dat)
    pred.SwePop.CompoPOP.csec <- eval(SwePop.CompoPOP.csec, envir = new.dat)
    pred.SwePop.UI.csec <- eval(SwePop.UI.csec, envir = new.dat)
    pred.SwePop.BotherUI.csec <- eval(SwePop.BotherUI.csec, envir = new.dat)
    pred.SwePop.TreatUI.csec <- eval(SwePop.TreatUI.csec, envir = new.dat)
    pred.SwePop.CompoUI.csec <- eval(SwePop.CompoUI.csec, envir = new.dat)
    pred.SwePop.BotherFI.csec <- eval(SwePop.BotherFI.csec, envir = new.dat)
    pred.SwePop.TreatFI.csec <- eval(SwePop.TreatFI.csec, envir = new.dat)
    pred.SwePop.CompoFI.csec <- eval(SwePop.CompoFI.csec, envir = new.dat)
    pred.SwePop.BotherPFD.csec <- eval(SwePop.BotherPFD.csec, envir = new.dat)
    pred.SwePop.TreatPFD.csec <- eval(SwePop.TreatPFD.csec, envir = new.dat)
    pred.SwePop.CompoPFD.csec <- eval(SwePop.CompoPFD.csec, envir = new.dat)
    pred.SwePop.Bother2PFD.csec <- eval(SwePop.Bother2PFD.csec, envir = new.dat)
    pred.SwePop.Treat2PFD.csec <- eval(SwePop.Treat2PFD.csec, envir = new.dat)
    pred.SwePop.Compo2PFD.csec <- eval(SwePop.Compo2PFD.csec, envir = new.dat)
    
    PriorDelivPlot(pred.SwePop.POP.vag, pred.SwePop.POP.csec, pred.SwePop.UI.vag, pred.SwePop.UI.csec, pred.SwePop.BotherPOP.vag, pred.SwePop.BotherPOP.csec, pred.SwePop.BotherUI.vag, pred.SwePop.BotherUI.csec, pred.SwePop.BotherFI.vag, pred.SwePop.BotherFI.csec, pred.SwePop.BotherPFD.vag, pred.SwePop.BotherPFD.csec, pred.SwePop.Bother2PFD.vag, pred.SwePop.Bother2PFD.csec, pred.SwePop.TreatPOP.vag, pred.SwePop.TreatPOP.csec, pred.SwePop.TreatUI.vag, pred.SwePop.TreatUI.csec, pred.SwePop.TreatFI.vag, pred.SwePop.TreatFI.csec, pred.SwePop.TreatPFD.vag, pred.SwePop.TreatPFD.csec, pred.SwePop.Treat2PFD.vag, pred.SwePop.Treat2PFD.csec, pred.SwePop.CompoPOP.vag, pred.SwePop.CompoPOP.csec, pred.SwePop.CompoUI.vag, pred.SwePop.CompoUI.csec, pred.SwePop.CompoFI.vag, pred.SwePop.CompoFI.csec, pred.SwePop.CompoPFD.vag, pred.SwePop.CompoPFD.csec, pred.SwePop.Compo2PFD.vag, pred.SwePop.Compo2PFD.csec)
  })
})