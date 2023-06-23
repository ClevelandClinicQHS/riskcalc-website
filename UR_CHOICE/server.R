require(shiny)




######################################################################################################## Before Delivery Models
########################################################12 year models(ProLong)
#####POP
## Vaginal
ProLong.POP.Vag <- expression({
  lp <- 3.5845717 - 0.050218993 * Age + 0.0084571116 * PrepregWeight - 0.027447196 * height + 0.66189957 * (uiprepreg == "Yes") + 0.67263742 * (uiduringpreg == "Yes") + 0.42334708 * (FH.POP == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.POP.CSec <- expression({
  lp <- 3.5845717 - 0.050218993 * Age + 0.0084571116 * PrepregWeight - 0.027447196 * height + 0.66189957 * (uiprepreg == "Yes") + 0.67263742 * (uiduringpreg == "Yes") + 0.42334708 * (FH.POP == "Yes");
  1/(1+exp(-lp))
})
#####Bothersome POP
## Vaginal
ProLong.BotherPOP.Vag <- expression({
  lp <- 4.0336115 - 0.088429813 * Age + 0.029192152 * PrepregWeight - 0.03976679 * height + 0.42428402 * (uiprepreg == "Yes") + 0.58568497 * (uiduringpreg == "Yes") + 0.405117 * (FH.POP == "Yes") + 0.41400314 * (Hx.Forcept.Vag == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.BotherPOP.CSec <- expression({
  lp <- 4.0336115 - 0.088429813 * Age + 0.029192152 * PrepregWeight - 0.03976679 * height + 0.42428402 * (uiprepreg == "Yes") + 0.58568497 * (uiduringpreg == "Yes") + 0.405117 * (FH.POP == "Yes") + 0.41400314 * (Hx.Forcept.Vag == "Yes");
  1/(1+exp(-lp))
})
#####Treatment POP
## vaginal
ProLong.TreatPOP.Vag <- expression({
  lp <- -12.740395 + 0.13834054 * Age + 0.022436993 * PrepregWeight + 0.70357522 * (uiprepreg == "Yes") + 0.8890048 * (FH.POP == "Yes") + 0.092895801 * circumference;
  1/(1+exp(-lp))
})
## C-Section
ProLong.TreatPOP.CSec <- expression({
  lp <- -12.740395 + 0.13834054 * Age + 0.022436993 * PrepregWeight + 0.70357522 * (uiprepreg == "Yes") + 0.8890048 * (FH.POP == "Yes") + 0.092895801 * circumference;
  1/(1+exp(-lp))
})
#####Composite POP
## vaginal
ProLong.CompoPOP.Vag <- expression({
  lp <- 2.6925484 + 0.3517386 * parity - 0.034363772 * Age + 0.03003301 * PrepregWeight - 0.036828099 * height + 0.50236895 * (uiprepreg == "Yes") + 0.40421791 * (uiduringpreg == "Yes") + 0.5757929 * (FH.POP == "Yes") - 0.27113246 * svd - 0.53464925 * vacuum - 0.54999345 * emergencycs;
  1/(1+exp(-lp))
})
## C-Section
ProLong.CompoPOP.CSec <- expression({
  lp <- 2.6925484 + 0.3517386 * parity - 0.034363772 * Age + 0.03003301 * PrepregWeight - 0.036828099 * height + 0.50236895 * (uiprepreg == "Yes") + 0.40421791 * (uiduringpreg == "Yes") + 0.5757929 * (FH.POP == "Yes") - 0.27113246 * svd - 0.53464925 * vacuum - 0.54999345 * emergencycs;
  1/(1+exp(-lp))
})
#####UI
## Vaginal
ProLong.UI.Vag <- expression({
  lp <- -0.10286298 - 0.094854567 * parity + 0.024763229 * Age + 0.0086028615 * PrepregWeight - 0.010742873 * height + 1.7818611 * (uiprepreg == "Yes") + 1.4080395 * (uiduringpreg == "Yes") + 0.63365899 * (FH.POP == "Yes") + 0.40814509 * 1;
  1/(1+exp(-lp))
})
## C-Section
ProLong.UI.CSec <- expression({
  lp <- -0.10286298 - 0.094854567 * parity + 0.024763229 * Age + 0.0086028615 * PrepregWeight - 0.010742873 * height + 1.7818611 * (uiprepreg == "Yes") + 1.4080395 * (uiduringpreg == "Yes") + 0.63365899 * (FH.POP == "Yes") + 0.40814509 * 0;
  1/(1+exp(-lp))
})
#####Bothersome UI
## Vaginal
ProLong.BotherUI.Vag <- expression({
  lp <- 3.0067393 + 0.026031277 * PrepregWeight - 0.03827048 * height + 1.5249087 * (uiprepreg == "Yes") + 1.3464168 * (uiduringpreg == "Yes") + 0.23554523 * (FH.POP == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.BotherUI.CSec <- expression({
  lp <- 3.0067393 + 0.026031277 * PrepregWeight - 0.03827048 * height + 1.5249087 * (uiprepreg == "Yes") + 1.3464168 * (uiduringpreg == "Yes") + 0.23554523 * (FH.POP == "Yes");
  1/(1+exp(-lp))
})
#####Treatment UI
## Vaginal
ProLong.TreatUI.Vag <- expression({
  lp <- -4.2781819 - 0.21262121 * parity + 0.048854736 * Age - 0.016856555 * height + 1.4625942 * (uiprepreg == "Yes") + 0.28470792 * (uiduringpreg == "Yes") + 0.11652269 * (FH.POP == "Yes") + 0.054942649 * circumference + 0.8713227 * 1;
  1/(1+exp(-lp))  
})
## C-Section
ProLong.TreatUI.CSec <- expression({
  lp <- -4.2781819 - 0.21262121 * parity + 0.048854736 * Age - 0.016856555 * height + 1.4625942 * (uiprepreg == "Yes") + 0.28470792 * (uiduringpreg == "Yes") + 0.11652269 * (FH.POP == "Yes") + 0.054942649 * circumference + 0.8713227 * 0;
  1/(1+exp(-lp))  
})
######Composite UI
## Vaginal
ProLong.CompoUI.Vag <- expression({
  lp <- 3.3489926 + 0.02534809 * PrepregWeight - 0.038923063 * height + 1.6867086 * (uiprepreg == "Yes") + 1.2777648 * (uiduringpreg == "Yes") + 0.30030438 * (FH.POP == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.CompoUI.CSec <- expression({
  lp <- 3.3489926 + 0.02534809 * PrepregWeight - 0.038923063 * height + 1.6867086 * (uiprepreg == "Yes") + 1.2777648 * (uiduringpreg == "Yes") + 0.30030438 * (FH.POP == "Yes");
  1/(1+exp(-lp))
})
#####FI
## Vaginal
ProLong.FI.Vag <- expression({
  lp <- -1.0976944 + 0.15071555 * parity + 0.016216903 * Age + 0.017827349 * PrepregWeight - 0.015977149 * height + 0.58813723 * (uiprepreg == "Yes") + 0.27159935 * (uiduringpreg == "Yes") + 0.33264025 * (FH.POP == "Yes") - 0.20156972 * (Hx.Unassist.Vag == "Yes") + 0.22200542 * (Hx.Forcept.Vag == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.FI.CSec <- expression({
  lp <- -1.0976944 + 0.15071555 * parity + 0.016216903 * Age + 0.017827349 * PrepregWeight - 0.015977149 * height + 0.58813723 * (uiprepreg == "Yes") + 0.27159935 * (uiduringpreg == "Yes") + 0.33264025 * (FH.POP == "Yes") - 0.20156972 * (Hx.Unassist.Vag == "Yes") + 0.22200542 * (Hx.Forcept.Vag == "Yes");
  1/(1+exp(-lp))
})
#####Bothersome FI
## Vaginal
ProLong.BotherFI.Vag <- expression({
  lp <- 0.01331393 * PrepregWeight + 1.1170596 * (uiprepreg == "Yes") + 0.72890704 * (uiduringpreg == "Yes") - 1.3416811 * 1 - 0.94131886 * (Hx_CSec == "Yes");
  1/(1+exp(-lp))
})
## Vaginal
ProLong.BotherFI.CSec <- expression({
  lp <- 0.01331393 * PrepregWeight + 1.1170596 * (uiprepreg == "Yes") + 0.72890704 * (uiduringpreg == "Yes") - 1.3416811 * 0 - 0.94131886 * (Hx_CSec == "Yes");
  1/(1+exp(-lp))
})
#####Treatment FI
## Vaginal
ProLong.TreatFI.Vag <- expression({
  lp <- 1.7817967 + 0.034689479 * PrepregWeight - 0.081061307 * height + 0.00047950866 * FetalWeight + 0.61547153 * (uiduringpreg == "Yes") + 0.10199884 * circumference + 0.64396148 * (Hx.Forcept.Vag == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.TreatFI.CSec <- expression({
  lp <- 1.7817967 + 0.034689479 * PrepregWeight - 0.081061307 * height + 0.00047950866 * FetalWeight + 0.61547153 * (uiduringpreg == "Yes") + 0.10199884 * circumference + 0.64396148 * (Hx.Forcept.Vag == "Yes");
  1/(1+exp(-lp))
})
#####Composite FI
## Vaginal
ProLong.CompoFI.Vag <- expression({
  lp <- 0.34310069 + 0.2037877 * parity - 0.051477445 * Age + 0.025208631 * PrepregWeight - 0.033537595 * height + 0.00044111548 * FetalWeight + 0.69556141 * (uiprepreg == "Yes") + 0.70335853 * (uiduringpreg == "Yes") + 0.23583169 * (FH.POP == "Yes") - 0.29459854 * (Hx.Unassist.Vag == "Yes") + 0.70725259 * (Hx.Forcept.Vag == "Yes") + 0.56761327 * (Hx.Plan.CSec == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.CompoFI.CSec <- expression({
  lp <- 0.34310069 + 0.2037877 * parity - 0.051477445 * Age + 0.025208631 * PrepregWeight - 0.033537595 * height + 0.00044111548 * FetalWeight + 0.69556141 * (uiprepreg == "Yes") + 0.70335853 * (uiduringpreg == "Yes") + 0.23583169 * (FH.POP == "Yes") - 0.29459854 * (Hx.Unassist.Vag == "Yes") + 0.70725259 * (Hx.Forcept.Vag == "Yes") + 0.56761327 * (Hx.Plan.CSec == "Yes");
  1/(1+exp(-lp))
})
#####Any PFD
## Vaginal
ProLong.PFD.Vag <- expression({
  lp <- 1.9036782 - 0.093176529 * parity + 0.012302636 * PrepregWeight - 0.017403845 * height + 1.7746431 * (uiprepreg == "Yes") + 1.2481604 * (uiduringpreg == "Yes") + 0.67709173 * (FH.POP == "Yes") + 0.33626329 * 1;
  1/(1+exp(-lp))
})
## C-Section
ProLong.PFD.CSec <- expression({
  lp <- 1.9036782 - 0.093176529 * parity + 0.012302636 * PrepregWeight - 0.017403845 * height + 1.7746431 * (uiprepreg == "Yes") + 1.2481604 * (uiduringpreg == "Yes") + 0.67709173 * (FH.POP == "Yes") + 0.33626329 * 0;
  1/(1+exp(-lp))
})
#####Bothersome PFD
## Vaginal
ProLong.BotherPFD.Vag <- expression({
  lp <- 3.1193651 - 0.073350951 * parity + 0.027525424 * PrepregWeight - 0.040352496 * height + 1.3897784 * (uiprepreg == "Yes") + 1.2123888 * (uiduringpreg == "Yes") + 0.27802429 * (FH.POP == "Yes") + 0.45647541 * (Hx_Vaginal == "Yes") + 0.31094155 * (Hx_CSec == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.BotherPFD.CSec <- expression({
  lp <- 3.1193651 - 0.073350951 * parity + 0.027525424 * PrepregWeight - 0.040352496 * height + 1.3897784 * (uiprepreg == "Yes") + 1.2123888 * (uiduringpreg == "Yes") + 0.27802429 * (FH.POP == "Yes") + 0.45647541 * (Hx_Vaginal == "Yes") + 0.31094155 * (Hx_CSec == "Yes");
  1/(1+exp(-lp))
})
#####Treatment PFD
## Vaginal
ProLong.TreatPFD.Vag <- expression({
  lp <- -2.944289 - 0.10265771 * parity + 0.044348602 * Age + 0.024678518 * PrepregWeight - 0.034328156 * height + 1.2040022 * (uiprepreg == "Yes") + 0.40876376 * (uiduringpreg == "Yes") + 0.21624874 * (FH.POP == "Yes") + 0.087032833 * circumference + 0.47103104 * 1;
  1/(1+exp(-lp))
})
## C-Section
ProLong.TreatPFD.CSec <- expression({
  lp <- -2.944289 - 0.10265771 * parity + 0.044348602 * Age + 0.024678518 * PrepregWeight - 0.034328156 * height + 1.2040022 * (uiprepreg == "Yes") + 0.40876376 * (uiduringpreg == "Yes") + 0.21624874 * (FH.POP == "Yes") + 0.087032833 * circumference + 0.47103104 * 0;
  1/(1+exp(-lp))
})
#####Composite PFD
## Vaginal
ProLong.CompoPFD.Vag <- expression({
  lp <- 2.245348 + 0.028869145 * PrepregWeight - 0.040592258 * height + 1.5527193 * (uiprepreg == "Yes") + 1.0738084 * (uiduringpreg == "Yes") + 0.27793638 * (FH.POP == "Yes") + 0.04006634 * circumference + 0.38001013 * 1 - 0.071498453 * svd + 0.27144871 * electivecs;
  1/(1+exp(-lp))
})
## C-Section
ProLong.CompoPFD.CSec <- expression({
  lp <- 2.245348 + 0.028869145 * PrepregWeight - 0.040592258 * height + 1.5527193 * (uiprepreg == "Yes") + 1.0738084 * (uiduringpreg == "Yes") + 0.27793638 * (FH.POP == "Yes") + 0.04006634 * circumference + 0.38001013 * 0 - 0.071498453 * svd + 0.27144871 * electivecs;
  1/(1+exp(-lp))
})
#####Any 2 ore more PFDs
## Vaginal
ProLong.2PFD.Vag <- expression({
  lp <- 1.6126934 + 0.016239788 * PrepregWeight - 0.027175523 * height + 1.0400766 * (uiprepreg == "Yes") + 0.90804755 * (uiduringpreg == "Yes") + 0.54494461 * (FH.POP == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.2PFD.CSec <- expression({
  lp <- 1.6126934 + 0.016239788 * PrepregWeight - 0.027175523 * height + 1.0400766 * (uiprepreg == "Yes") + 0.90804755 * (uiduringpreg == "Yes") + 0.54494461 * (FH.POP == "Yes");
  1/(1+exp(-lp))
})
#####2 or more bothersome PFDs
## Vaginal
ProLong.Bother2PFD.Vag <- expression({
  lp <- 3.4939245 - 0.067656838 * Age + 0.032069607 * PrepregWeight - 0.044385635 * height + 1.2682737 * (uiprepreg == "Yes") + 1.2178721 * (uiduringpreg == "Yes") + 0.52548149 * (Hx.Forcept.Vag == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.Bother2PFD.CSec <- expression({
  lp <- 3.4939245 - 0.067656838 * Age + 0.032069607 * PrepregWeight - 0.044385635 * height + 1.2682737 * (uiprepreg == "Yes") + 1.2178721 * (uiduringpreg == "Yes") + 0.52548149 * (Hx.Forcept.Vag == "Yes");
  1/(1+exp(-lp))
})
#####2 or more treatment PFDs
## Vaginal
ProLong.Treat2PFD.Vag <- expression({
  lp <- -12.603395 + 0.14607916 * Age - 0.041814986 * PrepregWeight + 0.89994894 * (FH.POP == "Yes") + 0.15881471 * circumference + 1.0360975 * (Hx.Forcept.Vag == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.Treat2PFD.CSec <- expression({
  lp <- -12.603395 + 0.14607916 * Age - 0.041814986 * PrepregWeight + 0.89994894 * (FH.POP == "Yes") + 0.15881471 * circumference + 1.0360975 * (Hx.Forcept.Vag == "Yes");
  1/(1+exp(-lp))
})
#####2 ore more composites PFDs
## Vaginal
ProLong.Compo2PFD.Vag <- expression({
  lp <- 3.7271044 - 0.038931814 * Age + 0.027822603 * PrepregWeight - 0.04802595 * height + 1.1432241 * (uiprepreg == "Yes") + 0.96517748 * (uiduringpreg == "Yes") + 0.45440569 * (FH.POP == "Yes") + 0.62171653 * (Hx.Forcept.Vag == "Yes");
  1/(1+exp(-lp))
})
## C-Section
ProLong.Compo2PFD.CSec <- expression({
  lp <- 3.7271044 - 0.038931814 * Age + 0.027822603 * PrepregWeight - 0.04802595 * height + 1.1432241 * (uiprepreg == "Yes") + 0.96517748 * (uiduringpreg == "Yes") + 0.45440569 * (FH.POP == "Yes") + 0.62171653 * (Hx.Forcept.Vag == "Yes");
  1/(1+exp(-lp))
})
########################################################20 year models (SwePop)
#####POP
## Vaginal
SwePop.POP.Vag <- expression({
  lp <- 0.75305459 - 0.029712297 * height + 0.00022801583 * FetalWeight + 0.87653233 * (DIABETES == "Yes") + 0.93886717 * (FH.POP == "Yes") + 0.41970082 * (FH.UI == "Yes") + 0.30468516 * (FH.FI == "Yes") + 1.1080877 * 1;
  1/(1+exp(-lp))
})
## C-Section
SwePop.POP.CSec <- expression({
  lp <- 0.75305459 - 0.029712297 * height + 0.00022801583 * FetalWeight + 0.87653233 * (DIABETES == "Yes") + 0.93886717 * (FH.POP == "Yes") + 0.41970082 * (FH.UI == "Yes") + 0.30468516 * (FH.FI == "Yes") + 1.1080877 * 0;
  1/(1+exp(-lp))
})
#####Bother POP
## Vaginal
SwePop.BotherPOP.Vag <- expression({
  lp <- -5.9288434 + 0.00033636553 * FetalWeight + 1.3403544 * (FH.POP == "Yes") + 0.54526964 * (FH.UI == "Yes") + 1.487187 * 1;
  1/(1+exp(-lp))
})
## C-Section
SwePop.BotherPOP.CSec <- expression({
  lp <- -5.9288434 + 0.00033636553 * FetalWeight + 1.3403544 * (FH.POP == "Yes") + 0.54526964 * (FH.UI == "Yes") + 1.487187 * 0;
  1/(1+exp(-lp))
})
#####Treat POP
## Vaginal
SwePop.TreatPOP.Vag <- expression({
  lp <- -12.023751 + 0.05461006 * Age - 0.017839191 * PrepregWeight + 0.0012703733 * FetalWeight + 1.5961632 * (FH.POP == "Yes") - 1.2930345 * (FH.FI == "Yes") + 2.5236288 * 1;
  1/(1+exp(-lp))
})
## C-Section
SwePop.TreatPOP.CSec <- expression({
  lp <- -12.023751 + 0.05461006 * Age - 0.017839191 * PrepregWeight + 0.0012703733 * FetalWeight + 1.5961632 * (FH.POP == "Yes") - 1.2930345 * (FH.FI == "Yes") + 2.5236288 * 0;
  1/(1+exp(-lp))
})
#####Compo POP
## Vaginal
SwePop.CompoPOP.Vag <- expression({
  lp <- -0.81442527 - 0.84383303 * Bwt.height + 0.17560627 * max(Bwt.height - 3.9608802, 0)**3 - 0.28843705 * max(Bwt.height - 4.7443182, 0)**3 + 0.11283078 * max(Bwt.height - 5.9636364, 0)**3 + 1.4320447 * (FH.POP == "Yes") + 0.38937658 * (FH.UI == "Yes") + 1.6354237 * 1;
  1/(1+exp(-lp))
})
## CSection
SwePop.CompoPOP.CSec <- expression({
  lp <- -0.81442527 - 0.84383303 * Bwt.height + 0.17560627 * max(Bwt.height - 3.9608802, 0)**3 - 0.28843705 * max(Bwt.height - 4.7443182, 0)**3 + 0.11283078 * max(Bwt.height - 5.9636364, 0)**3 + 1.4320447 * (FH.POP == "Yes") + 0.38937658 * (FH.UI == "Yes") + 1.6354237 * 0;
  1/(1+exp(-lp))
})
#####UI
## Vaginal
SwePop.UI.Vag <- expression({
  lp <- -0.3263724 + 0.022606663 * Age + 0.018820574 * PrepregWeight - 0.018268529 * height + 1.5764999 * (FH.UI == "Yes") + 0.53946364 * 1;
  1/(1+exp(-lp))
})
## C-Section
SwePop.UI.CSec <- expression({
  lp <- -0.3263724 + 0.022606663 * Age + 0.018820574 * PrepregWeight - 0.018268529 * height + 1.5764999 * (FH.UI == "Yes") + 0.53946364 * 0;
  1/(1+exp(-lp))
})
#####Bothersome UI
## Vaginal
SwePop.BotherUI.Vag <- expression({
  lp <- -1.5671066 + 0.02783685 * Age + 0.029622143 * PrepregWeight - 0.021333126 * height + 1.1442632 * (FH.UI == "Yes") + 0.38280288 * 1;
  1/(1+exp(-lp))
})
## C-Section
SwePop.BotherUI.CSec <- expression({
  lp <- -1.5671066 + 0.02783685 * Age + 0.029622143 * PrepregWeight - 0.021333126 * height + 1.1442632 * (FH.UI == "Yes") + 0.38280288 * 0;
  1/(1+exp(-lp))
})
#####Treatment UI
## Vaginal
SwePop.TreatUI.Vag <- expression({
  lp <- -5.5837703 + 0.016211978 * PrepregWeight + 1.1268069 * (FH.UI == "Yes") + 0.73085901 * 1;
  1/(1+exp(-lp))
})
## C-Section
SwePop.TreatUI.CSec <- expression({
  lp <- -5.5837703 + 0.016211978 * PrepregWeight + 1.1268069 * (FH.UI == "Yes") + 0.73085901 * 0;
  1/(1+exp(-lp))
})
#####Composite
## Vaginal
SwePop.CompoUI.Vag <- expression({
  lp <- -2.1919469 + 0.027678167 * Age + 0.027938544 * PrepregWeight - 0.016617118 * height + 1.2141832 * (FH.UI == "Yes") + 0.480806 * 1;
  1/(1+exp(-lp)) 
})
## C-Section
SwePop.CompoUI.CSec <- expression({
  lp <- -2.1919469 + 0.027678167 * Age + 0.027938544 * PrepregWeight - 0.016617118 * height + 1.2141832 * (FH.UI == "Yes") + 0.480806 * 0;
  1/(1+exp(-lp)) 
})
#####FI
## Vaginal
SwePop.FI.Vag <- expression({
  lp <- 1.2426184 + 0.02331574 * Age + 0.022844146 * PrepregWeight - 0.034808721 * height + 0.74550816 * (DIABETES == "Yes") + 1.1469429 * (FH.FI == "Yes") + 0.43017442 * 1;
  1/(1+exp(-lp))
})
## C-Section
SwePop.FI.CSec <- expression({
  lp <- 1.2426184 + 0.02331574 * Age + 0.022844146 * PrepregWeight - 0.034808721 * height + 0.74550816 * (DIABETES == "Yes") + 1.1469429 * (FH.FI == "Yes") + 0.43017442 * 0;
  1/(1+exp(-lp))
})
#####Bothersome FI
## Vaginal
SwePop.BotherFI.Vag <- expression({
  lp <- 2.4953207 - 0.061173568 * Age + 0.036310934 * PrepregWeight - 0.045784771 * height + 1.4377976 * (FH.FI == "Yes") + 0.52938901 * 1;
  1/(1+exp(-lp))
})
## C-Section
SwePop.BotherFI.CSec <- expression({
  lp <- 2.4953207 - 0.061173568 * Age + 0.036310934 * PrepregWeight - 0.045784771 * height + 1.4377976 * (FH.FI == "Yes") + 0.52938901 * 0;
  1/(1+exp(-lp))
})
#####Treatment FI
## Vaginal
SwePop.TreatFI.Vag <- expression({
  lp <- -6.8331117 + 0.034606464 * PrepregWeight + 0.74931232 * (FH.UI == "Yes") + 0.73250902 * (FH.FI == "Yes") - 0.65524021 * 1;
  1/(1+exp(-lp))
})
## C-Section
SwePop.TreatFI.CSec <- expression({
  lp <- -6.8331117 + 0.034606464 * PrepregWeight + 0.74931232 * (FH.UI == "Yes") + 0.73250902 * (FH.FI == "Yes") - 0.65524021 * 0;
  1/(1+exp(-lp))
})
#####Composite FI
## Vaginal 
SwePop.CompoFI.Vag <- expression({
  lp <-  -4.8468457 - 0.043551506 * Age + 0.033675753 * PrepregWeight + 0.47907507 * (FH.UI == "Yes") + 1.0869827 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})
## C-Section 
SwePop.CompoFI.CSec <- expression({
  lp <-  -4.8468457 - 0.043551506 * Age + 0.033675753 * PrepregWeight + 0.47907507 * (FH.UI == "Yes") + 1.0869827 * (FH.FI == "Yes");
  1/(1+exp(-lp))
})
#####Any PFD
## Vaginal
SwePop.PFD.Vag <- expression({
  lp <- 1.1505469 + 0.026862663 * Age + 0.015510598 * PrepregWeight - 0.024675559 * height + 0.83265737 * (DIABETES == "Yes") + 1.3407096 * (FH.UI == "Yes") + 0.48268351 * (FH.FI == "Yes") + 0.64946566 * 1;
  1/(1+exp(-lp))
})
## C-Section
SwePop.PFD.CSec <- expression({
  lp <- 1.1505469 + 0.026862663 * Age + 0.015510598 * PrepregWeight - 0.024675559 * height + 0.83265737 * (DIABETES == "Yes") + 1.3407096 * (FH.UI == "Yes") + 0.48268351 * (FH.FI == "Yes") + 0.64946566 * 0;
  1/(1+exp(-lp))
})
#####Bothersom PFD
## Vaginal
SwePop.BotherPFD.Vag <- expression({
  lp <- 0.20478322 + 0.021119238 * Age + 0.02830259 * PrepregWeight - 0.0343199 * height + 0.00021860909 * FetalWeight + 0.1864501 * (FH.POP == "Yes") + 1.033608 * (FH.UI == "Yes") + 0.21994638 * (FH.FI == "Yes") + 0.61016317 * 1;
  1/(1+exp(-lp))
})
## C-Section
SwePop.BotherPFD.CSec <- expression({
  lp <- 0.20478322 + 0.021119238 * Age + 0.02830259 * PrepregWeight - 0.0343199 * height + 0.00021860909 * FetalWeight + 0.1864501 * (FH.POP == "Yes") + 1.033608 * (FH.UI == "Yes") + 0.21994638 * (FH.FI == "Yes") + 0.61016317 * 0;
  1/(1+exp(-lp))
})
#####Treatment PFD
## Vaginal
SwePop.TreatPFD.Vag <- expression({
  lp <- -6.7527922 + 0.024594314 * Age + 0.012370731 * PrepregWeight + 0.00042591734 * FetalWeight + 0.85697369 * (DIABETES == "Yes") + 0.29063181 * (FH.POP == "Yes") + 0.73550005 * (FH.UI == "Yes") + 0.61391582 * 1;
  1/(1+exp(-lp))
})
## C-Section
SwePop.TreatPFD.CSec <- expression({
  lp <- -6.7527922 + 0.024594314 * Age + 0.012370731 * PrepregWeight + 0.00042591734 * FetalWeight + 0.85697369 * (DIABETES == "Yes") + 0.29063181 * (FH.POP == "Yes") + 0.73550005 * (FH.UI == "Yes") + 0.61391582 * 0;
  1/(1+exp(-lp))
})
#####Composite PFD
## Vaginal
SwePop.CompoPFD.Vag <- expression({
  lp <- -0.66468152 + 0.020144619 * Age + 0.026270057 * PrepregWeight - 0.028571126 * height + 0.00029026767 * FetalWeight + 0.26867342 * (FH.POP == "Yes") + 1.0498902 * (FH.UI == "Yes") + 0.21824137 * (FH.FI == "Yes") + 0.63029908 * 1;
  1/(1+exp(-lp))
})
## C-Section
SwePop.CompoPFD.CSec <- expression({
  lp <- -0.66468152 + 0.020144619 * Age + 0.026270057 * PrepregWeight - 0.028571126 * height + 0.00029026767 * FetalWeight + 0.26867342 * (FH.POP == "Yes") + 1.0498902 * (FH.UI == "Yes") + 0.21824137 * (FH.FI == "Yes") + 0.63029908 * 0;
  1/(1+exp(-lp))
})
#####Any 2 or more PFD
## Vaginal
SwePop.2PFD.Vag <- expression({
  lp <- 2.5502309 + 0.02578611 * PrepregWeight - 0.043155913 * height + 1.003148 * (DIABETES == "Yes") + 0.39349982 * (FH.POP == "Yes") + 0.74584676 * (FH.UI == "Yes") + 0.7389503 * (FH.FI == "Yes") + 0.80713455 * 1;
  1/(1+exp(-lp))
})
## C-Section
SwePop.2PFD.CSec <- expression({
  lp <- 2.5502309 + 0.02578611 * PrepregWeight - 0.043155913 * height + 1.003148 * (DIABETES == "Yes") + 0.39349982 * (FH.POP == "Yes") + 0.74584676 * (FH.UI == "Yes") + 0.7389503 * (FH.FI == "Yes") + 0.80713455 * 0;
  1/(1+exp(-lp))
})
#####2 or more bothersome PFD
## Vaginal
SwePop.Bother2PFD.Vag <- expression({
  lp <- -6.3896658 + 0.022000868 * PrepregWeight + 0.91124636 * (FH.POP == "Yes") + 0.995035 * (FH.UI == "Yes") + 0.6032157 * (FH.FI == "Yes") + 0.89471617 * 1;
  1/(1+exp(-lp))
})
## C-Section
SwePop.Bother2PFD.CSec <- expression({
  lp <- -6.3896658 + 0.022000868 * PrepregWeight + 0.91124636 * (FH.POP == "Yes") + 0.995035 * (FH.UI == "Yes") + 0.6032157 * (FH.FI == "Yes") + 0.89471617 * 0;
  1/(1+exp(-lp))
})
#####2 or more Treatment PFDs
## Vaginal
SwePop.Treat2PFD.Vag <- expression({
  lp <- -3.0398168 - 0.52834069 * Bwt.height;
  1/(1+exp(-lp))
})
## C-Section
SwePop.Treat2PFD.CSec <- expression({
  lp <- -3.0398168 - 0.52834069 * Bwt.height;
  1/(1+exp(-lp))
})
#####2 ore more Composte PFDs
## Vaginal
SwePop.Compo2PFD.Vag <- expression({
  lp <- -6.0896226 + 0.019783492 * PrepregWeight + 1.1946149 * (DIABETES == "Yes") + 0.92326936 * (FH.POP == "Yes") + 0.97970368 * (FH.UI == "Yes") + 0.59615059 * (FH.FI == "Yes") + 0.80566606 * 1;
  1/(1+exp(-lp))
})
## C-Section
SwePop.Compo2PFD.CSec <- expression({
  lp <- -6.0896226 + 0.019783492 * PrepregWeight + 1.1946149 * (DIABETES == "Yes") + 0.92326936 * (FH.POP == "Yes") + 0.97970368 * (FH.UI == "Yes") + 0.59615059 * (FH.FI == "Yes") + 0.80566606 * 0;
  1/(1+exp(-lp))
})


PriorDelivPlot.ProLong <- function(pred.pop.any.vag, pred.pop.any.csec, pred.ui.any.vag, pred.ui.any.csec, pred.fi.any.vag, pred.fi.any.csec, pred.pfd.any.vag, pred.pfd.any.csec, pred.2pfd.any.vag, pred.2pfd.any.csec, pred.pop.bother.vag, pred.pop.bother.csec, pred.ui.bother.vag, pred.ui.bother.csec, pred.fi.bother.vag, pred.fi.bother.csec, pred.pfd.bother.vag, pred.pfd.bother.csec, pred.2pfd.bother.vag, pred.2pfd.bother.csec, pred.pop.treat.vag, pred.pop.treat.csec, pred.ui.treat.vag, pred.ui.treat.csec, pred.pfd.treat.vag, pred.pfd.treat.csec, pred.2pfd.treat.vag, pred.2pfd.treat.csec, pred.pop.compo.vag, pred.pop.compo.csec, pred.ui.compo.vag, pred.ui.compo.csec, pred.fi.compo.vag, pred.fi.compo.csec, pred.pfd.compo.vag, pred.pfd.compo.csec, pred.2pfd.compo.vag, pred.2pfd.compo.csec, parity){
  par(mar=c(0,0,0,0))
  plot(1, 1, type="n", xlab="", ylab="", xaxs = "i", yaxs="i")#xaxt="n", yaxt="n", 
  rect(0.78, 1.185, 1.4, 1.25, col="light gray", border = NA)
  rect(0.78, 1.055, 1.4, 1.12, col="light gray", border = NA)
  rect(0.78, 0.925, 1.4, 0.99, col="light gray", border = NA)
  rect(0.78, 0.795, 1.4, 0.86, col="light gray", border = NA)
  rect(0.78, 0.665, 1.4, 0.73, col="light gray", border = NA)
  abline(h = c(0.73, 0.86, 0.99, 1.12, 1.25))
  #abline(v = c(0.78, 0.89, 0.992, 1.094, 1.196, 1.298))
  text(0.69, 1.325, "Outcomes", cex=1.25, font=2)
  text(0.835, 1.325, "Route\n of\n Delivery", cex=1.25, font=2)
  text(0.941, 1.325, "Any", cex=1.25, font=2)
  text(1.043, 1.325, "Bothersome", cex=1.25, font=2)
  text(1.145, 1.325, "Treatment", cex=1.25, font=2)
  text(1.247, 1.325, "Bothersome\n or Treatment", cex=1.25, font=2)
  text(1.349, 1.325, "Average Risk\n of\n Bothersome\n or Treatment", cex=1.25, font=2)
  text(0.69, 1.185, "Pelvic Organ\n Prolapse", cex=1.25, font=2)
  text(0.69, 1.055, "Urinary\n Incontinence", cex=1.25, font=2)
  text(0.69, 0.925, "Fecal\n Incontinence", cex=1.25, font=2)
  text(0.69, 0.795, "Any Pelvic\n Floor\n Disorder", cex=1.25, font=2)
  text(0.69, 0.665, "Two or More\n Pelvic Floor\n Disorders", cex=1.25, font=2)
  
  lines(c(0.78, 1.4), c(1.185, 1.185))
  lines(c(0.78, 1.4), c(1.055, 1.055))
  lines(c(0.78, 1.4), c(0.925, 0.925))
  lines(c(0.78, 1.4), c(0.795, 0.795))
  lines(c(0.78, 1.4), c(0.665, 0.665))
  text(0.835, 1.2175, "Vaginal", cex=1.25, font=2)
  text(0.835, 1.1525, "C-Section", cex=1.25, font=2)
  text(0.835, 1.0875, "Vaginal", cex=1.25, font=2)
  text(0.835, 1.0225, "C-Section", cex=1.25, font=2)
  text(0.835, 0.9575, "Vaginal", cex=1.25, font=2)
  text(0.835, 0.8925, "C-Section", cex=1.25, font=2)
  text(0.835, 0.8275, "Vaginal", cex=1.25, font=2)
  text(0.835, 0.7625, "C-Section", cex=1.25, font=2)
  text(0.835, 0.6975, "Vaginal", cex=1.25, font=2)
  text(0.835, 0.6325, "C-Section", cex=1.25, font=2)
  
  
  #any pop
  text(0.941, 1.2175, ifelse(pred.pop.any.vag < 0.006, "<0.5%", ifelse(pred.pop.any.vag > 0.995, ">99%", paste(round(pred.pop.any.vag*100, 0), "%", sep=""))), cex=2)
  text(0.941, 1.1525, ifelse(pred.pop.any.csec < 0.006, "<0.5%", ifelse(pred.pop.any.csec > 0.995, ">99%", paste(round(pred.pop.any.csec*100, 0), "%", sep=""))), cex=2)
  #any UI
  text(0.941, 1.0875, ifelse(pred.ui.any.vag < 0.006, "<0.5%", ifelse(pred.ui.any.vag > 0.99, ">99%", paste(round(pred.ui.any.vag*100, 0), "%", sep=""))), cex=2)
  text(0.941, 1.0225, ifelse(pred.ui.any.csec < 0.006, "<0.5%", ifelse(pred.ui.any.csec > 0.99, ">99%", paste(round(pred.ui.any.csec*100, 0), "%", sep=""))), cex=2)
  #any FI
  text(0.941, 0.9575, ifelse(pred.fi.any.vag < 0.006, "<0.5%", ifelse(pred.fi.any.vag > 0.305, ">30%", paste(round(pred.fi.any.vag*100, 0), "%", sep=""))), cex=2)
  text(0.941, 0.8925, ifelse(pred.fi.any.csec < 0.006, "<0.5%", ifelse(pred.fi.any.csec > 0.305, ">30%", paste(round(pred.fi.any.csec*100, 0), "%", sep=""))), cex=2)
  #any PFD
  text(0.941, 0.8275, ifelse(pred.pfd.any.vag < 0.006, "<0.5%", ifelse(pred.pfd.any.vag > 0.995, ">99%", paste(round(pred.pfd.any.vag*100, 0), "%", sep=""))), cex=2)
  text(0.941, 0.7625, ifelse(pred.pfd.any.csec < 0.006, "<0.5%", ifelse(pred.pfd.any.csec > 0.995, ">99%", paste(round(pred.pfd.any.csec*100, 0), "%", sep=""))), cex=2)
  #any 2 or more PFD
  text(0.941, 0.6975, ifelse(pred.2pfd.any.vag < 0.006, "<0.5%", ifelse(pred.2pfd.any.vag > 0.995, ">99%", paste(round(pred.2pfd.any.vag*100, 0), "%", sep=""))), cex=2)
  text(0.941, 0.6325, ifelse(pred.2pfd.any.csec < 0.006, "<0.5%", ifelse(pred.2pfd.any.csec > 0.995, ">99%", paste(round(pred.2pfd.any.csec*100, 0), "%", sep=""))), cex=2)
  #Bothersome pop
  text(1.043, 1.2175, ifelse(pred.pop.bother.vag < 0.006, "<0.5%", ifelse(pred.pop.bother.vag > 0.995, ">99%", paste(round(pred.pop.bother.vag*100, 0), "%", sep=""))), cex=2)
  text(1.043, 1.1525, ifelse(pred.pop.bother.csec < 0.006, "<0.5%", ifelse(pred.pop.bother.csec > 0.995, ">99%", paste(round(pred.pop.bother.csec*100, 0), "%", sep=""))), cex=2)
  #Bothersome UI
  text(1.043, 1.0875, ifelse(pred.ui.bother.vag < 0.006, "<0.5%", ifelse(pred.ui.bother.vag > 0.995, ">99%", paste(round(pred.ui.bother.vag*100, 0), "%", sep=""))), cex=2)
  text(1.043, 1.0225, ifelse(pred.ui.bother.csec < 0.006, "<0.5%", ifelse(pred.ui.bother.csec > 0.995, ">99%", paste(round(pred.ui.bother.csec*100, 0), "%", sep=""))), cex=2)
  #Bothersome FI
  text(1.043, 0.9575, ifelse(pred.fi.bother.vag < 0.006, "<0.5%", ifelse(pred.fi.bother.vag > 0.105, ">10%", paste(round(pred.fi.bother.vag*100, 0), "%", sep=""))), cex=2)
  text(1.043, 0.8925, ifelse(pred.fi.bother.csec < 0.006, "<0.5%", ifelse(pred.fi.bother.csec > 0.105, ">10%", paste(round(pred.fi.bother.csec*100, 0), "%", sep=""))), cex=2)
  #Bothersome PFD
  text(1.043, 0.8275, ifelse(pred.pfd.bother.vag < 0.006, "<0.5%", ifelse(pred.pfd.bother.vag > 0.995, ">99%", paste(round(pred.pfd.bother.vag*100, 0), "%", sep=""))), cex=2)
  text(1.043, 0.7625, ifelse(pred.pfd.bother.csec < 0.006, "<0.5%", ifelse(pred.pfd.bother.csec > 0.995, ">99%", paste(round(pred.pfd.bother.csec*100, 0), "%", sep=""))), cex=2)
  #Bothersome 2 or more PFD
  text(1.043, 0.6975, ifelse(pred.2pfd.bother.vag < 0.006, "<0.5%", ifelse(pred.2pfd.bother.vag > 0.995, ">99%", paste(round(pred.2pfd.bother.vag*100, 0), "%", sep=""))), cex=2)
  text(1.043, 0.6325, ifelse(pred.2pfd.bother.csec < 0.006, "<0.5%", ifelse(pred.2pfd.bother.csec > 0.995, ">99%", paste(round(pred.2pfd.bother.csec*100, 0), "%", sep=""))), cex=2)
  #Treatment for pop
  text(1.145, 1.2175, ifelse(parity == 0, "2%*", ifelse(parity == 1, "3%*", ifelse(parity == 2, "5%*", "3%*"))), cex=2)
  text(1.145, 1.1525, ifelse(parity == 0, "2%*", ifelse(parity == 1, "2%*", "4%*")), cex=2)
  #Treatment for UI
  text(1.145, 1.0875, ifelse(pred.ui.treat.vag < 0.006, "<0.5%", ifelse(pred.ui.treat.vag > 0.995, ">99%", paste(round(pred.ui.treat.vag*100, 0), "%", sep=""))), cex=2)
  text(1.145, 1.0225, ifelse(pred.ui.treat.csec < 0.006, "<0.5%", ifelse(pred.ui.treat.csec > 0.995, ">99%", paste(round(pred.ui.treat.csec*100, 0), "%", sep=""))), cex=2)
  #Treatment for FI
  text(1.145, 0.9575, ifelse(parity == 0, "2%*", ifelse(parity == 1, "3%*", ifelse(parity == 2, "3%*", "1%*"))), cex=2)
  text(1.145, 0.8925, ifelse(parity == 0, "2%*", ifelse(parity == 1, "3%*", ifelse(parity == 2, "7%*", "4%*"))), cex=2)
  #Treatment for PFD
  text(1.145, 0.8275, ifelse(pred.pfd.treat.vag < 0.006, "<0.5%", ifelse(pred.pfd.treat.vag > 0.995, ">99%", paste(round(pred.pfd.treat.vag*100, 0), "%", sep=""))), cex=2)
  text(1.145, 0.7625, ifelse(pred.pfd.treat.csec < 0.006, "<0.5%", ifelse(pred.pfd.treat.csec > 0.995, ">99%", paste(round(pred.pfd.treat.csec*100, 0), "%", sep=""))), cex=2)
  #Treatment for 2 or more PFD
  text(1.145, 0.6975, ifelse(pred.2pfd.treat.vag < 0.006, "<0.5%", ifelse(pred.2pfd.treat.vag > 0.15, ">15%", paste(round(pred.2pfd.treat.vag*100, 0), "%", sep=""))), cex=2)
  text(1.145, 0.6325, ifelse(pred.2pfd.treat.csec < 0.006, "<0.5%", ifelse(pred.2pfd.treat.csec > 0.15, ">15%", paste(round(pred.2pfd.treat.csec*100, 0), "%", sep=""))), cex=2)
  #Composite pop
  text(1.247, 1.2175, ifelse(pred.pop.compo.vag < 0.006, "<0.5%", ifelse(pred.pop.compo.vag > 0.995, ">99%", paste(round(pred.pop.compo.vag*100, 0), "%", sep=""))), cex=2)
  text(1.247, 1.1525, ifelse(pred.pop.compo.csec < 0.006, "<0.5%", ifelse(pred.pop.compo.csec > 0.995, ">99%", paste(round(pred.pop.compo.csec*100, 0), "%", sep=""))), cex=2)
  #Composite of UI
  text(1.247, 1.0875, ifelse(pred.ui.compo.vag < 0.006, "<0.5%", ifelse(pred.ui.compo.vag > 0.995, ">99%", paste(round(pred.ui.compo.vag*100, 0), "%", sep=""))), cex=2)
  text(1.247, 1.0225, ifelse(pred.ui.compo.csec < 0.006, "<0.5%", ifelse(pred.ui.compo.csec > 0.995, ">99%", paste(round(pred.ui.compo.csec*100, 0), "%", sep=""))), cex=2)
  #Composite of FI
  text(1.247, 0.9575, ifelse(pred.fi.compo.vag < 0.006, "<0.5%", ifelse(pred.fi.compo.vag > 0.155, ">15%", paste(round(pred.fi.compo.vag*100, 0), "%", sep=""))), cex=2)
  text(1.247, 0.8925, ifelse(pred.fi.compo.csec < 0.006, "<0.5%", ifelse(pred.fi.compo.csec > 0.155, ">15%", paste(round(pred.fi.compo.csec*100, 0), "%", sep=""))), cex=2)
  #Composite of PFD
  text(1.247, 0.8275, ifelse(pred.pfd.compo.vag < 0.006, "<0.5%", ifelse(pred.pfd.compo.vag > 0.995, ">99%", paste(round(pred.pfd.compo.vag*100, 0), "%", sep=""))), cex=2)
  text(1.247, 0.7625, ifelse(pred.pfd.compo.csec < 0.006, "<0.5%", ifelse(pred.pfd.compo.csec > 0.995, ">99%", paste(round(pred.pfd.compo.csec*100, 0), "%", sep=""))), cex=2)
  #Composite of 2 or more PFD
  text(1.247, 0.6975, ifelse(pred.2pfd.compo.vag < 0.006, "<0.5%", ifelse(pred.2pfd.compo.vag > 0.995, ">99%", paste(round(pred.2pfd.compo.vag*100, 0), "%", sep=""))), cex=2)
  text(1.247, 0.6325, ifelse(pred.2pfd.compo.csec < 0.006, "<0.5%", ifelse(pred.2pfd.compo.csec > 0.995, ">99%", paste(round(pred.2pfd.compo.csec*100, 0), "%", sep=""))), cex=2)
  #Average Composite Risk for POP
  text(1.349, 1.2175, "9%", cex=2)
  text(1.349, 1.1525, "7%", cex=2)
  #Average Composite Risk for UI
  text(1.349, 1.0875, "28%", cex=2)
  text(1.349, 1.0225, "24%", cex=2)
  #Average Composite Risk for FI
  text(1.349, 0.9575, "5%", cex=2)
  text(1.349, 0.8925, "5%", cex=2)
  #Average Composite Risk for PFD
  text(1.349, 0.8275, "37%", cex=2)
  text(1.349, 0.7625, "32%", cex=2)
  #Average Composite Risk for 2 or more PFD
  text(1.349, 0.6975, "5%", cex=2)
  text(1.349, 0.6325, "5%", cex=2)
}
PriorDelivPlot.SwePop <- function(pred.pop.any.vag, pred.pop.any.csec, pred.ui.any.vag, pred.ui.any.csec, pred.fi.any.vag, pred.fi.any.csec, pred.pfd.any.vag, pred.pfd.any.csec, pred.2pfd.any.vag, pred.2pfd.any.csec, pred.pop.bother.vag, pred.pop.bother.csec, pred.ui.bother.vag, pred.ui.bother.csec, pred.fi.bother.vag, pred.fi.bother.csec, pred.pfd.bother.vag, pred.pfd.bother.csec, pred.2pfd.bother.vag, pred.2pfd.bother.csec, pred.pop.treat.vag, pred.pop.treat.csec, pred.ui.treat.vag, pred.ui.treat.csec, pred.pfd.treat.vag, pred.pfd.treat.csec, pred.2pfd.treat.vag, pred.2pfd.treat.csec, pred.pop.compo.vag, pred.pop.compo.csec, pred.ui.compo.vag, pred.ui.compo.csec, pred.fi.compo.vag, pred.fi.compo.csec, pred.pfd.compo.vag, pred.pfd.compo.csec, pred.2pfd.compo.vag, pred.2pfd.compo.csec){
  par(mar=c(0,0,0,0))
  plot(1, 1, type="n", xaxt="n", yaxt="n", xlab="", ylab="", xaxs = "i", yaxs="i")
  rect(0.78, 1.185, 1.4, 1.25, col="light gray", border = NA)
  rect(0.78, 1.055, 1.4, 1.12, col="light gray", border = NA)
  rect(0.78, 0.925, 1.4, 0.99, col="light gray", border = NA)
  rect(0.78, 0.795, 1.4, 0.86, col="light gray", border = NA)
  rect(0.78, 0.665, 1.4, 0.73, col="light gray", border = NA)
  abline(h = c(0.73, 0.86, 0.99, 1.12, 1.25))
  #abline(v = c(0.78, 0.89, 0.992, 1.094, 1.196, 1.298))
  text(0.69, 1.325, "Outcomes", cex=1.25, font=2)
  text(0.835, 1.325, "Route\n of\n Delivery", cex=1.25, font=2)
  text(0.941, 1.325, "Any", cex=1.25, font=2)
  text(1.043, 1.325, "Bothersome", cex=1.25, font=2)
  text(1.145, 1.325, "Treatment", cex=1.25, font=2)
  text(1.247, 1.325, "Bothersome\n or Treatment", cex=1.25, font=2)
  text(1.349, 1.325, "Average Risk\n of\n Bothersome\n or Treatment", cex=1.25, font=2)
  text(0.69, 1.185, "Pelvic Organ\n Prolapse", cex=1.25, font=2)
  text(0.69, 1.055, "Urinary\n Incontinence", cex=1.25, font=2)
  text(0.69, 0.925, "Fecal\n Incontinence", cex=1.25, font=2)
  text(0.69, 0.795, "Any Pelvic\n Floor\n Disorder", cex=1.25, font=2)
  text(0.69, 0.665, "Two or More\n Pelvic Floor\n Disorders", cex=1.25, font=2)
  
  lines(c(0.78, 1.4), c(1.185, 1.185))
  lines(c(0.78, 1.4), c(1.055, 1.055))
  lines(c(0.78, 1.4), c(0.925, 0.925))
  lines(c(0.78, 1.4), c(0.795, 0.795))
  lines(c(0.78, 1.4), c(0.665, 0.665))
  text(0.835, 1.2175, "Vaginal", cex=1.25, font=2)
  text(0.835, 1.1525, "C-Section", cex=1.25, font=2)
  text(0.835, 1.0875, "Vaginal", cex=1.25, font=2)
  text(0.835, 1.0225, "C-Section", cex=1.25, font=2)
  text(0.835, 0.9575, "Vaginal", cex=1.25, font=2)
  text(0.835, 0.8925, "C-Section", cex=1.25, font=2)
  text(0.835, 0.8275, "Vaginal", cex=1.25, font=2)
  text(0.835, 0.7625, "C-Section", cex=1.25, font=2)
  text(0.835, 0.6975, "Vaginal", cex=1.25, font=2)
  text(0.835, 0.6325, "C-Section", cex=1.25, font=2)
  #any pop
  text(0.941, 1.2175, ifelse(pred.pop.any.vag < 0.006, "<0.5%", ifelse(pred.pop.any.vag > 0.305, ">30%", paste(round(pred.pop.any.vag*100, 0), "%", sep=""))), cex=2)
  text(0.941, 1.1525, ifelse(pred.pop.any.csec < 0.006, "<0.5%", ifelse(pred.pop.any.csec > 0.305, ">30%", paste(round(pred.pop.any.csec*100, 0), "%", sep=""))), cex=2)
  #any UI
  text(0.941, 1.0875, ifelse(pred.ui.any.vag < 0.006, "<0.5%", ifelse(pred.ui.any.vag > 0.995, ">99%", paste(round(pred.ui.any.vag*100, 0), "%", sep=""))), cex=2)
  text(0.941, 1.0225, ifelse(pred.ui.any.csec < 0.006, "<0.5%", ifelse(pred.ui.any.csec > 0.995, ">99%", paste(round(pred.ui.any.csec*100, 0), "%", sep=""))), cex=2)
  #any FI
  text(0.941, 0.9575, ifelse(pred.fi.any.vag < 0.006, "<0.5%", ifelse(pred.fi.any.vag > 0.995, ">99%", paste(round(pred.fi.any.vag*100, 0), "%", sep=""))), cex=2)
  text(0.941, 0.8925, ifelse(pred.fi.any.csec < 0.006, "<0.5%", ifelse(pred.fi.any.csec > 0.995, ">99%", paste(round(pred.fi.any.csec*100, 0), "%", sep=""))), cex=2)
  #any PFD
  text(0.941, 0.8275, ifelse(pred.pfd.any.vag < 0.006, "<0.5%", ifelse(pred.pfd.any.vag > 0.995, ">99%", paste(round(pred.pfd.any.vag*100, 0), "%", sep=""))), cex=2)
  text(0.941, 0.7625, ifelse(pred.pfd.any.csec < 0.006, "<0.5%", ifelse(pred.pfd.any.csec > 0.995, ">99%", paste(round(pred.pfd.any.csec*100, 0), "%", sep=""))), cex=2)
  #any 2 or more PFD
  text(0.941, 0.6975, ifelse(pred.2pfd.any.vag < 0.006, "<0.5%", ifelse(pred.2pfd.any.vag > 0.455, ">45%", paste(round(pred.2pfd.any.vag*100, 0), "%", sep=""))), cex=2)
  text(0.941, 0.6325, ifelse(pred.2pfd.any.csec < 0.006, "<0.5%", ifelse(pred.2pfd.any.csec > 0.455, ">45%", paste(round(pred.2pfd.any.csec*100, 0), "%", sep=""))), cex=2)
  #Bothersome pop
  text(1.043, 1.2175, ifelse(pred.pop.bother.vag < 0.006, "<0.5%", ifelse(pred.pop.bother.vag > 0.105, ">10%", paste(round(pred.pop.bother.vag*100, 0), "%", sep=""))), cex=2)
  text(1.043, 1.1525, ifelse(pred.pop.bother.csec < 0.006, "<0.5%", ifelse(pred.pop.bother.csec > 0.105, ">10%", paste(round(pred.pop.bother.csec*100, 0), "%", sep=""))), cex=2)
  #Bothersome UI
  text(1.043, 1.0875, ifelse(pred.ui.bother.vag < 0.006, "<0.5%", ifelse(pred.ui.bother.vag > 0.355, ">35%", paste(round(pred.ui.bother.vag*100, 0), "%", sep=""))), cex=2)
  text(1.043, 1.0225, ifelse(pred.ui.bother.csec < 0.006, "<0.5%", ifelse(pred.ui.bother.csec > 0.355, ">35%", paste(round(pred.ui.bother.csec*100, 0), "%", sep=""))), cex=2)
  #Bothersome FI
  text(1.043, 0.9575, ifelse(pred.fi.bother.vag < 0.006, "<0.5%", ifelse(pred.fi.bother.vag > 0.105, ">10%", paste(round(pred.fi.bother.vag*100, 0), "%", sep=""))), cex=2)
  text(1.043, 0.8925, ifelse(pred.fi.bother.csec < 0.006, "<0.5%", ifelse(pred.fi.bother.csec > 0.105, ">10%", paste(round(pred.fi.bother.csec*100, 0), "%", sep=""))), cex=2)
  #Bothersome PFD
  text(1.043, 0.8275, ifelse(pred.pfd.bother.vag < 0.006, "<0.5%", ifelse(pred.pfd.bother.vag > 0.405, ">40%", paste(round(pred.pfd.bother.vag*100, 0), "%", sep=""))), cex=2)
  text(1.043, 0.7625, ifelse(pred.pfd.bother.csec < 0.006, "<0.5%", ifelse(pred.pfd.bother.csec > 0.405, ">40%", paste(round(pred.pfd.bother.csec*100, 0), "%", sep=""))), cex=2)
  #Bothersome 2 or more PFD
  text(1.043, 0.6975, ifelse(pred.2pfd.bother.vag < 0.006, "<0.5%", ifelse(pred.2pfd.bother.vag > 0.105, ">10%", paste(round(pred.2pfd.bother.vag*100, 0), "%", sep=""))), cex=2)
  text(1.043, 0.6325, ifelse(pred.2pfd.bother.csec < 0.006, "<0.5%", ifelse(pred.2pfd.bother.csec > 0.105, ">10%", paste(round(pred.2pfd.bother.csec*100, 0), "%", sep=""))), cex=2)
  #Treatment for pop
  text(1.145, 1.2175, ifelse(pred.pop.treat.vag < 0.006, "<0.5%", ifelse(pred.pop.treat.vag > 0.155, ">15%", paste(round(pred.pop.treat.vag*100, 0), "%", sep=""))), cex=2)
  text(1.145, 1.1525, ifelse(pred.pop.treat.csec < 0.006, "<0.5%", ifelse(pred.pop.treat.csec > 0.155, ">15%", paste(round(pred.pop.treat.csec*100, 0), "%", sep=""))), cex=2)
  #Treatment for UI
  text(1.145, 1.0875, ifelse(pred.ui.treat.vag < 0.006, "<0.5%", ifelse(pred.ui.treat.vag > 0.105, ">10%", paste(round(pred.ui.treat.vag*100, 0), "%", sep=""))), cex=2)
  text(1.145, 1.0225, ifelse(pred.ui.treat.csec < 0.006, "<0.5%", ifelse(pred.ui.treat.csec > 0.105, ">10%", paste(round(pred.ui.treat.csec*100, 0), "%", sep=""))), cex=2)
  #Treatment for FI
  text(1.145, 0.9575, "1%*", cex=2)
  text(1.145, 0.8925, "2%*", cex=2)
  #Treatment for PFD
  text(1.145, 0.8275, ifelse(pred.pfd.treat.vag < 0.006, "<0.5%", ifelse(pred.pfd.treat.vag > 0.155, ">15%", paste(round(pred.pfd.treat.vag*100, 0), "%", sep=""))), cex=2)
  text(1.145, 0.7625, ifelse(pred.pfd.treat.csec < 0.006, "<0.5%", ifelse(pred.pfd.treat.csec > 0.155, ">15%", paste(round(pred.pfd.treat.csec*100, 0), "%", sep=""))), cex=2)
  #Treatment for 2 or more PFD
  text(1.145, 0.6975, ifelse(pred.2pfd.treat.vag < 0.006, "<0.5%", ifelse(pred.2pfd.treat.vag > 0.055, ">5%", paste(round(pred.2pfd.treat.vag*100, 0), "%", sep=""))), cex=2)
  text(1.145, 0.6325, ifelse(pred.2pfd.treat.csec < 0.006, "<0.5%", ifelse(pred.2pfd.treat.csec > 0.055, ">5%", paste(round(pred.2pfd.treat.csec*100, 0), "%", sep=""))), cex=2)
  #Composite pop
  text(1.247, 1.2175, ifelse(pred.pop.compo.vag < 0.006, "<0.5%", ifelse(pred.pop.compo.vag > 0.205, ">20%", paste(round(pred.pop.compo.vag*100, 0), "%", sep=""))), cex=2)
  text(1.247, 1.1525, ifelse(pred.pop.compo.csec < 0.006, "<0.5%", ifelse(pred.pop.compo.csec > 0.205, ">20%", paste(round(pred.pop.compo.csec*100, 0), "%", sep=""))), cex=2)
  #Composite of UI
  text(1.247, 1.0875, ifelse(pred.ui.compo.vag < 0.006, "<0.5%", ifelse(pred.ui.compo.vag > 0.305, ">30%", paste(round(pred.ui.compo.vag*100, 0), "%", sep=""))), cex=2)
  text(1.247, 1.0225, ifelse(pred.ui.compo.csec < 0.006, "<0.5%", ifelse(pred.ui.compo.csec > 0.305, ">30%", paste(round(pred.ui.compo.csec*100, 0), "%", sep=""))), cex=2)
  #Composite of FI
  text(1.247, 0.9575, ifelse(pred.fi.compo.vag < 0.006, "<0.5%", ifelse(pred.fi.compo.vag > 0.155, ">15%", paste(round(pred.fi.compo.vag*100, 0), "%", sep=""))), cex=2)
  text(1.247, 0.8925, ifelse(pred.fi.compo.csec < 0.006, "<0.5%", ifelse(pred.fi.compo.csec > 0.155, ">15%", paste(round(pred.fi.compo.csec*100, 0), "%", sep=""))), cex=2)
  #Composite of PFD
  text(1.247, 0.8275, ifelse(pred.pfd.compo.vag < 0.006, "<0.5%", ifelse(pred.pfd.compo.vag > 0.505, ">50%", paste(round(pred.pfd.compo.vag*100, 0), "%", sep=""))), cex=2)
  text(1.247, 0.7625, ifelse(pred.pfd.compo.csec < 0.006, "<0.5%", ifelse(pred.pfd.compo.csec > 0.505, ">50%", paste(round(pred.pfd.compo.csec*100, 0), "%", sep=""))), cex=2)
  #Composite of 2 or more PFD
  text(1.247, 0.6975, ifelse(pred.2pfd.compo.vag < 0.006, "<0.5%", ifelse(pred.2pfd.compo.vag > 0.105, ">10%", paste(round(pred.2pfd.compo.vag*100, 0), "%", sep=""))), cex=2)
  text(1.247, 0.6325, ifelse(pred.2pfd.compo.csec < 0.006, "<0.5%", ifelse(pred.2pfd.compo.csec > 0.105, ">10%", paste(round(pred.2pfd.compo.csec*100, 0), "%", sep=""))), cex=2)
  #Average Composite Risk for POP
  text(1.349, 1.2175, "9%", cex=2)
  text(1.349, 1.1525, "3%", cex=2)
  #Average Composite Risk for UI
  text(1.349, 1.0875, "20%", cex=2)
  text(1.349, 1.0225, "15%", cex=2)
  #Average Composite Risk for FI
  text(1.349, 0.9575, "3%", cex=2)
  text(1.349, 0.8925, "3%", cex=2)
  #Average Composite Risk for PFD
  text(1.349, 0.8275, "27%", cex=2)
  text(1.349, 0.7625, "18%", cex=2)
  #Average Composite Risk for 2 or more PFD
  text(1.349, 0.6975, "4%", cex=2)
  text(1.349, 0.6325, "2%", cex=2)
}




  

shinyServer(function(input, output) {
  get_newdata <- reactive({
    new_df <- data.frame(Age = input$Age,
                         parity = input$parity,
                         PrepregWeight = input$PrepregWeight,
                         PrepregWeight_lb = input$PrepregWeight_lb,
                         height = input$height,
                         height.ft = input$height.ft,
                         height.in = input$height.in,
                         FetalWeight = input$FetalWeight,
                         FetalWeight.p = input$FetalWeight.p,
                         FetalWeight.o = input$FetalWeight.o,
                         circumference = input$circumference,
                         uiprepreg = factor(input$uiprepreg, levels = c("Yes", "No")),
                         uiduringpreg = factor(input$uiduringpreg, levels = c("Yes", "No")),
                         FH.POP = factor(input$FH.POP, levels = c("Yes", "No")),
                         FH.UI = factor(input$FH.UI, levels = c("Yes", "No")),
                         FH.FI = factor(input$FH.FI, levels = c("Yes", "No")),
                         DIABETES = factor(input$DIABETES, levels = c("Yes", "No")),
                         Hx.Forcept.Vag = factor(input$Hx.Forcept.Vag, levels = c("Yes", "No")),
                         svd = input$svd,
                         vacuum = input$vacuum,
                         emergencycs = input$emergencycs,
                         electivecs = input$electivecs,
                         Hx.Unassist.Vag = factor(input$Hx.Unassist.Vag, levels = c("Yes", "No")),
                         Hx_CSec = factor(input$Hx_CSec, levels = c("Yes", "No")),
                         Hx.Plan.CSec = factor(input$Hx.Plan.CSec, levels = c("Yes", "No")),
                         Hx_Vaginal = factor(input$Hx_Vaginal, levels = c("Yes", "No"))
                         
    )
    new_df$PrepregWeight <- with(new_df, ifelse(PrepregWeight == 0 | is.na(PrepregWeight) == T, PrepregWeight_lb*0.453592, PrepregWeight))
    new_df$height <- with(new_df, ifelse(height == 0 | is.na(height) == T, (height.ft*12 + ifelse(is.na(height.in) == T, 0, height.in))*2.54, height))
    new_df$FetalWeight <- with(new_df, ifelse(FetalWeight == 0 | is.na(FetalWeight) == T, (FetalWeight.p*16 + ifelse(is.na(FetalWeight.o) == T, 0, FetalWeight.o))/0.035274, FetalWeight))
    new_df$Bwt.height <- with(new_df, (height/FetalWeight)*100)
    new_df
  })
  
  output$pred1 <- renderPlot({
    new.dat <- get_newdata()
    pred.ProLong.POP.Vag <- eval(ProLong.POP.Vag, envir = new.dat)
    pred.ProLong.POP.CSec <- eval(ProLong.POP.CSec, envir = new.dat)
    pred.ProLong.BotherPOP.Vag <- eval(ProLong.BotherPOP.Vag, envir = new.dat)
    pred.ProLong.BotherPOP.CSec <- eval(ProLong.BotherPOP.CSec, envir = new.dat)
    pred.ProLong.TreatPOP.Vag <- eval(ProLong.TreatPOP.Vag, envir = new.dat)
    pred.ProLong.TreatPOP.CSec <- eval(ProLong.TreatPOP.CSec, envir = new.dat)
    pred.ProLong.CompoPOP.Vag <- eval(ProLong.CompoPOP.Vag, envir = new.dat)
    pred.ProLong.CompoPOP.CSec <- eval(ProLong.CompoPOP.CSec, envir = new.dat)
    pred.ProLong.UI.Vag <- eval(ProLong.UI.Vag, envir = new.dat)
    pred.ProLong.UI.CSec <- eval(ProLong.UI.CSec, envir = new.dat)
    pred.ProLong.BotherUI.Vag <- eval(ProLong.BotherUI.Vag, envir = new.dat)
    pred.ProLong.BotherUI.CSec <- eval(ProLong.BotherUI.CSec, envir = new.dat)
    pred.ProLong.TreatUI.Vag <- eval(ProLong.TreatUI.Vag, envir = new.dat)
    pred.ProLong.TreatUI.CSec <- eval(ProLong.TreatUI.CSec, envir = new.dat)
    pred.ProLong.CompoUI.Vag <- eval(ProLong.CompoUI.Vag, envir = new.dat)
    pred.ProLong.CompoUI.CSec <- eval(ProLong.CompoUI.CSec, envir = new.dat)
    pred.ProLong.FI.Vag <- eval(ProLong.FI.Vag, envir = new.dat)
    pred.ProLong.FI.CSec <- eval(ProLong.FI.CSec, envir = new.dat)
    pred.ProLong.BotherFI.Vag <- eval(ProLong.BotherFI.Vag, envir = new.dat)
    pred.ProLong.BotherFI.CSec <- eval(ProLong.BotherFI.CSec, envir = new.dat)
    pred.ProLong.CompoFI.Vag <- eval(ProLong.CompoFI.Vag, envir = new.dat)
    pred.ProLong.CompoFI.CSec <- eval(ProLong.CompoFI.CSec, envir = new.dat)
    pred.ProLong.PFD.Vag <- eval(ProLong.PFD.Vag, envir = new.dat)
    pred.ProLong.PFD.CSec <- eval(ProLong.PFD.CSec, envir = new.dat)
    pred.ProLong.BotherPFD.Vag <- eval(ProLong.BotherPFD.Vag, envir = new.dat)
    pred.ProLong.BotherPFD.CSec <- eval(ProLong.BotherPFD.CSec, envir = new.dat)
    pred.ProLong.TreatPFD.Vag <- eval(ProLong.TreatPFD.Vag, envir = new.dat)
    pred.ProLong.TreatPFD.CSec <- eval(ProLong.TreatPFD.CSec, envir = new.dat)
    pred.ProLong.CompoPFD.Vag <- eval(ProLong.CompoPFD.Vag, envir = new.dat)
    pred.ProLong.CompoPFD.CSec <- eval(ProLong.CompoPFD.CSec, envir = new.dat)
    pred.ProLong.2PFD.Vag <- eval(ProLong.2PFD.Vag, envir = new.dat)
    pred.ProLong.2PFD.CSec <- eval(ProLong.2PFD.CSec, envir = new.dat)
    pred.ProLong.Bother2PFD.Vag <- eval(ProLong.Bother2PFD.Vag, envir = new.dat)
    pred.ProLong.Bother2PFD.CSec <- eval(ProLong.Bother2PFD.CSec, envir = new.dat)
    pred.ProLong.Treat2PFD.Vag <- eval(ProLong.Treat2PFD.Vag, envir = new.dat)
    pred.ProLong.Treat2PFD.CSec <- eval(ProLong.Treat2PFD.CSec, envir = new.dat)
    pred.ProLong.Compo2PFD.Vag <- eval(ProLong.Compo2PFD.Vag, envir = new.dat)
    pred.ProLong.Compo2PFD.CSec <- eval(ProLong.Compo2PFD.CSec, envir = new.dat)
    
    PriorDelivPlot.ProLong(pred.ProLong.POP.Vag, pred.ProLong.POP.CSec, pred.ProLong.UI.Vag, pred.ProLong.UI.CSec, pred.ProLong.FI.Vag, pred.ProLong.FI.CSec, pred.ProLong.PFD.Vag, pred.ProLong.PFD.CSec, pred.ProLong.2PFD.Vag, pred.ProLong.2PFD.CSec, 
                           pred.ProLong.BotherPOP.Vag, pred.ProLong.BotherPOP.CSec, pred.ProLong.BotherUI.Vag, pred.ProLong.BotherUI.CSec, pred.ProLong.BotherFI.Vag, pred.ProLong.BotherFI.CSec, pred.ProLong.BotherPFD.Vag, pred.ProLong.BotherPFD.CSec, pred.ProLong.Bother2PFD.Vag, pred.ProLong.Bother2PFD.CSec, 
                           pred.ProLong.TreatPOP.Vag, pred.ProLong.TreatPOP.CSec, pred.ProLong.TreatUI.Vag, pred.ProLong.TreatUI.CSec, pred.ProLong.TreatPFD.Vag, pred.ProLong.TreatPFD.CSec, pred.ProLong.Treat2PFD.Vag, pred.ProLong.Treat2PFD.CSec, 
                           pred.ProLong.CompoPOP.Vag, pred.ProLong.CompoPOP.CSec, pred.ProLong.CompoUI.Vag, pred.ProLong.CompoUI.CSec, pred.ProLong.CompoFI.Vag, pred.ProLong.CompoFI.CSec, pred.ProLong.CompoPFD.Vag, pred.ProLong.CompoPFD.CSec, pred.ProLong.Compo2PFD.Vag, pred.ProLong.Compo2PFD.CSec, input$parity)
  })
  
  output$pred2 <- renderPlot({
    new.dat <- get_newdata()
    pred.SwePop.POP.Vag <- eval(SwePop.POP.Vag, envir = new.dat)
    pred.SwePop.POP.CSec <- eval(SwePop.POP.CSec, envir = new.dat)
    pred.SwePop.BotherPOP.Vag <- eval(SwePop.BotherPOP.Vag, envir = new.dat)
    pred.SwePop.BotherPOP.CSec <- eval(SwePop.BotherPOP.CSec, envir = new.dat)
    pred.SwePop.TreatPOP.Vag <- eval(SwePop.TreatPOP.Vag, envir = new.dat)
    pred.SwePop.TreatPOP.CSec <- eval(SwePop.TreatPOP.CSec, envir = new.dat)
    pred.SwePop.CompoPOP.Vag <- eval(SwePop.CompoPOP.Vag, envir = new.dat)
    pred.SwePop.CompoPOP.CSec <- eval(SwePop.CompoPOP.CSec, envir = new.dat)
    pred.SwePop.UI.Vag <- eval(SwePop.UI.Vag, envir = new.dat)
    pred.SwePop.UI.CSec <- eval(SwePop.UI.CSec, envir = new.dat)
    pred.SwePop.BotherUI.Vag <- eval(SwePop.BotherUI.Vag, envir = new.dat)
    pred.SwePop.BotherUI.CSec <- eval(SwePop.BotherUI.CSec, envir = new.dat)
    pred.SwePop.TreatUI.Vag <- eval(SwePop.TreatUI.Vag, envir = new.dat)
    pred.SwePop.TreatUI.CSec <- eval(SwePop.TreatUI.CSec, envir = new.dat)
    pred.SwePop.CompoUI.Vag <- eval(SwePop.CompoUI.Vag, envir = new.dat)
    pred.SwePop.CompoUI.CSec <- eval(SwePop.CompoUI.CSec, envir = new.dat)
    pred.SwePop.FI.Vag <- eval(SwePop.FI.Vag, envir = new.dat)
    pred.SwePop.FI.CSec <- eval(SwePop.FI.CSec, envir = new.dat)
    pred.SwePop.BotherFI.Vag <- eval(SwePop.BotherFI.Vag, envir = new.dat)
    pred.SwePop.BotherFI.CSec <- eval(SwePop.BotherFI.CSec, envir = new.dat)
    pred.SwePop.CompoFI.Vag <- eval(SwePop.CompoFI.Vag, envir = new.dat)
    pred.SwePop.CompoFI.CSec <- eval(SwePop.CompoFI.CSec, envir = new.dat)
    pred.SwePop.PFD.Vag <- eval(SwePop.PFD.Vag, envir = new.dat)
    pred.SwePop.PFD.CSec <- eval(SwePop.PFD.CSec, envir = new.dat)
    pred.SwePop.BotherPFD.Vag <- eval(SwePop.BotherPFD.Vag, envir = new.dat)
    pred.SwePop.BotherPFD.CSec <- eval(SwePop.BotherPFD.CSec, envir = new.dat)
    pred.SwePop.TreatPFD.Vag <- eval(SwePop.TreatPFD.Vag, envir = new.dat)
    pred.SwePop.TreatPFD.CSec <- eval(SwePop.TreatPFD.CSec, envir = new.dat)
    pred.SwePop.CompoPFD.Vag <- eval(SwePop.CompoPFD.Vag, envir = new.dat)
    pred.SwePop.CompoPFD.CSec <- eval(SwePop.CompoPFD.CSec, envir = new.dat)
    pred.SwePop.2PFD.Vag <- eval(SwePop.2PFD.Vag, envir = new.dat)
    pred.SwePop.2PFD.CSec <- eval(SwePop.2PFD.CSec, envir = new.dat)
    pred.SwePop.Bother2PFD.Vag <- eval(SwePop.Bother2PFD.Vag, envir = new.dat)
    pred.SwePop.Bother2PFD.CSec <- eval(SwePop.Bother2PFD.CSec, envir = new.dat)
    pred.SwePop.Treat2PFD.Vag <- eval(SwePop.Treat2PFD.Vag, envir = new.dat)
    pred.SwePop.Treat2PFD.CSec <- eval(SwePop.Treat2PFD.CSec, envir = new.dat)
    pred.SwePop.Compo2PFD.Vag <- eval(SwePop.Compo2PFD.Vag, envir = new.dat)
    pred.SwePop.Compo2PFD.CSec <- eval(SwePop.Compo2PFD.CSec, envir = new.dat)
    
    PriorDelivPlot.SwePop(pred.SwePop.POP.Vag, pred.SwePop.POP.CSec, pred.SwePop.UI.Vag, pred.SwePop.UI.CSec, pred.SwePop.FI.Vag, pred.SwePop.FI.CSec, pred.SwePop.PFD.Vag, pred.SwePop.PFD.CSec, pred.SwePop.2PFD.Vag, pred.SwePop.2PFD.CSec, 
                          pred.SwePop.BotherPOP.Vag, pred.SwePop.BotherPOP.CSec, pred.SwePop.BotherUI.Vag, pred.SwePop.BotherUI.CSec, pred.SwePop.BotherFI.Vag, pred.SwePop.BotherFI.CSec, pred.SwePop.BotherPFD.Vag, pred.SwePop.BotherPFD.CSec, pred.SwePop.Bother2PFD.Vag, pred.SwePop.Bother2PFD.CSec, 
                          pred.SwePop.TreatPOP.Vag, pred.SwePop.TreatPOP.CSec, pred.SwePop.TreatUI.Vag, pred.SwePop.TreatUI.CSec, pred.SwePop.TreatPFD.Vag, pred.SwePop.TreatPFD.CSec, pred.SwePop.Treat2PFD.Vag, pred.SwePop.Treat2PFD.CSec, 
                          pred.SwePop.CompoPOP.Vag, pred.SwePop.CompoPOP.CSec, pred.SwePop.CompoUI.Vag, pred.SwePop.CompoUI.CSec, pred.SwePop.CompoFI.Vag, pred.SwePop.CompoFI.CSec, pred.SwePop.CompoPFD.Vag, pred.SwePop.CompoPFD.CSec, pred.SwePop.Compo2PFD.Vag, pred.SwePop.Compo2PFD.CSec)
  })
  
})