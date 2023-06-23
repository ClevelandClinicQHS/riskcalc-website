require(shiny)



#####MI
## Intensive
MI.Intensive.Fit <- expression({
  lp <- -2.9048696 + 0.22407762 * (SMOKE_3CAT == "Former") + 1.2029369 * (SMOKE_3CAT == "Current") + 0.40638478 * (ASPIRIN == "Yes") - 0.012493289 * EGFR + 0.036259773 * AGE + 0.8894328 * (SUB_CLINICALCVD == "Yes") + 0.0061008119 * CHR - 0.019691143 * HDL + 0.049161296 * UMALCR - 4.8700871e-05 * max(UMALCR - 4.08, 0)**3 + 5.346339e-05 * max(UMALCR - 9.57, 0)**3 - 4.7625184e-06 * max(UMALCR - 65.71, 0)**3;
  1-(0.9823819^(exp(lp)))
})
## Standard
MI.Standard.Fit <- expression({
  lp <-  -8.669599 - 0.5087421 * (INCLUSIONFRS == "Yes") + 0.44498296 * (SMOKE_3CAT == "Former") + 1.1457498 * (SMOKE_3CAT == "Current") + 0.026229173 * EGFR + 1.5489564 * SCREAT + 0.075354256 * AGE + 0.66271667 * (SUB_CLINICALCVD == "Yes") - 0.18445412 * ( RACE == "WHITE") - 0.5168721 * ( RACE == "Black") - 0.28306322 * ( RACE == "Hispanic") + 0.0072093472 * CHR - 0.022833142 * HDL;
  1-(0.9759622^(exp(lp)))
})
#####ACS
## Intensive
ACS.Intensive.Fit <- expression({
  lp <- -7.0043364 + 0.027938059 * SBP + 0.64446643 * (SMOKE_3CAT == "Former") + 0.52934718 * (SMOKE_3CAT == "Current") + 0.6196466 * (ASPIRIN == "Yes") + 1.3955436 * (SUB_CLINICALCVD == "Yes") + 0.024803905 * TRR - 1.4692335e-06 * max(TRR - 59, 0)**3 + 2.1568058e-06 * max(TRR - 106.5, 0)**3 - 6.875723e-07 * max(TRR - 208, 0)**3;
  1-(0.9943789^(exp(lp)))
})
## Standard
ACS.Standard.Fit <- expression({
  lp <- -16.288721 - 0.034914359 * SBP + 0.34146119 * (SMOKE_3CAT == "Former") + 0.91712311 * (SMOKE_3CAT == "Current") - 0.41918349 * (SUB_CKD == "Yes") + 0.039213848 * AGE + 1.8954496 * (SUB_CLINICALCVD == "Yes") + 0.028746268 * CHR - 3.2511089e-06 * max(CHR - 141, 0)**3 + 5.9702181e-06 * max(CHR - 187, 0)**3 - 2.7191092e-06 * max(CHR - 242, 0)**3 + 0.15336635 * GLUR - 0.00016932966 * max(GLUR - 85, 0)**3 + 0.00028885649 * max(GLUR - 97, 0)**3 - 0.00011952682 * max(GLUR - 114, 0)**3 - 0.014359157 * HDL - 0.0013495183 * UMALCR;
  1-(0.9957737^(exp(lp)))
})
#####Stroke
## Intensive
Stroke.Intensive.Fit <- expression({
  lp <- 6.8181677 + 0.019346831 * SBP - 0.45296408 * (NOAGENTS == "Yes") - 0.18191217 * (SMOKE_3CAT == "Former") + 0.60769934 * (SMOKE_3CAT == "Current") - 0.033105866 * EGFR - 5.0861211 * SCREAT + 9.0798791 * max(SCREAT - 0.74, 0)**3 - 13.998147 * max(SCREAT - 1, 0)**3 + 4.9182679 * max(SCREAT - 1.48, 0)**3 + 0.038003752 * AGE + 0.81828975 * (SUB_CLINICALCVD == "Yes") + 0.62248938 * (SUB_SUBCLINICALCVD == "Yes") - 0.060853507 * HDL + 4.4077499e-05 * max(HDL - 37, 0)**3 - 7.0123294e-05 * max(HDL - 50, 0)**3 + 2.6045795e-05 * max(HDL - 72, 0)**3 - 0.08822731 * BMI + 0.00063097692 * max(BMI - 23.418849, 0)**3 - 0.0010386979 * max(BMI - 28.993382, 0)**3 + 0.00040772096 * max(BMI - 37.620364, 0)**3;
  1-(0.9899514^(exp(lp)))
})
## Standard
Stroke.Standard.Fit <- expression({
  lp <-  -10.565019 + 0.022147291 * EGFR + 1.1432725 * SCREAT + 0.063849064 * AGE + 0.0044683797 * CHR + 0.017601414 * GLUR + 0.065329606 * UMALCR - 6.298672e-05 * max(UMALCR - 4.05, 0)**3 + 6.8742462e-05 * max(UMALCR - 9.41, 0)**3 - 5.7557423e-06 * max(UMALCR - 68.066, 0)**3;
  1-(0.9870827^(exp(lp)))
})
#####Heart Failure
## Intensive
HF.Intensive.Fit <- expression({
  lp <- -13.299679 + 0.32164334 * N_AGENTS + 0.8810191 * SCREAT + 0.081636056 * AGE + 0.8465883 * (SUB_CLINICALCVD == "Yes") + 0.019831164 * CHR - 1.9112795e-06 * max(CHR - 141, 0)**3 + 3.4271219e-06 * max(CHR - 187, 0)**3 - 1.5158424e-06 * max(CHR - 245, 0)**3 + 0.079928288 * UMALCR - 7.8197316e-05 * max(UMALCR - 4.08, 0)**3 + 8.5844328e-05 * max(UMALCR - 9.57, 0)**3 - 7.6470122e-06 * max(UMALCR - 65.71, 0)**3 + 0.059919894 * BMI;
  1-(0.992932^(exp(lp)))
})
## Standard
HF.Standard.Fit <- expression({
  lp <-  -6.909776 + 0.24921669 * N_AGENTS + 0.15269523 * (SMOKE_3CAT == "Former") + 1.1679171 * (SMOKE_3CAT == "Current") + 0.082193875 * AGE + 0.45146525 * (SUB_CLINICALCVD == "Yes") - 0.016971637 * HDL + 0.043339496 * UMALCR - 4.14594e-05 * max(UMALCR - 4.05, 0)**3 + 4.524797e-05 * max(UMALCR - 9.41, 0)**3 - 3.7885704e-06 * max(UMALCR - 68.066, 0)**3 + 0.030771451 * BMI;
  1-(0.9808009^(exp(lp)))
})
#####CV Death
## Intensive
CV.Death.Intensive.Fit <- expression({
  lp <- -2.9220715 - 1.210532 * (INCLUSIONFRS == "Yes") + 0.02703333 * SBP + 0.23078788 * N_AGENTS + 0.26818548 * (SMOKE_3CAT == "Former") + 0.79779902 * (SMOKE_3CAT == "Current") - 0.02463479 * EGFR + 0.70813566 * SCREAT - 0.83251942 * (SUB_CKD == "Yes") + 0.077341973 * AGE + 0.75190128 * (FEMALE == "Male") + 0.78548978 * (SUB_CLINICALCVD == "Yes") + 0.011488233 * GLUR - 0.031554558 * HDL - 0.0013996742 * TRR + 0.00071722334 * UMALCR - 0.18348081 * BMI + 0.0013279374 * max(BMI - 23.418849, 0)**3 - 0.0021860162 * max(BMI - 28.993382, 0)**3 + 0.0008580788 * max(BMI - 37.620364, 0)**3;
  1-(0.9949559^(exp(lp)))
})
## Standard
CV.Death.Standard.Fit <- expression({
  lp <- -11.649205 - 0.72832632 * (INCLUSIONFRS == "Yes") + 0.034860495 * DBP + 0.2456967 * N_AGENTS + 0.52341359 * (SMOKE_3CAT == "Former") + 0.83319391 * (SMOKE_3CAT == "Current") + 0.015990263 * EGFR + 1.1867132 * SCREAT + 0.086045103 * AGE + 0.70628394 * (FEMALE == "Male") + 0.75233813 * (SUB_CLINICALCVD == "Yes") + 0.55326054 * (SUB_SUBCLINICALCVD == "Yes") + 0.010999557 * CHR - 0.030555274 * HDL + 0.03701967 * UMALCR - 3.5279685e-05 * max(UMALCR - 4.05, 0)**3 + 3.8503552e-05 * max(UMALCR - 9.41, 0)**3 - 3.2238665e-06 * max(UMALCR - 68.066, 0)**3 - 0.048540115 * BMI + 0.45882067 * (STATIN == "Yes");
  1-(0.9904066^(exp(lp)))
})
#####All-Cause Death
## Intensive
All.Death.Intensive.Fit <- expression({
  lp <-  -3.1841647 + 0.38734654 * (INCLUSIONFRS == "Yes") + 0.35027522 * (SMOKE_3CAT == "Former") + 0.7688256 * (SMOKE_3CAT == "Current") + 0.62525866 * SCREAT + 0.0497782 * AGE + 0.48707549 * (SUB_CLINICALCVD == "Yes") - 0.0059742345 * CHR + 0.01055397 * GLUR + 0.011313738 * HDL + 0.035017568 * UMALCR - 3.3956463e-05 * max(UMALCR - 4.08, 0)**3 + 3.7277108e-05 * max(UMALCR - 9.57, 0)**3 - 3.3206445e-06 * max(UMALCR - 65.71, 0)**3 - 0.084530808 * BMI + 0.00060887519 * max(BMI - 23.418849, 0)**3 - 0.0010023146 * max(BMI - 28.993382, 0)**3 + 0.00039343939 * max(BMI - 37.620364, 0)**3 - 0.53184224 * (STATIN == "Yes");
  1-(0.9694576^(exp(lp)))
})
## Standard
All.Death.Standard.Fit <- expression({
  lp <- -9.6476954 + 0.47160092 * (SMOKE_3CAT == "Former") + 1.1022877 * (SMOKE_3CAT == "Current") + 0.022706893 * EGFR + 1.3856071 * SCREAT + 0.078790094 * AGE + 0.51139286 * (SUB_CLINICALCVD == "Yes") + 0.002324323 * TRR + 0.034905174 * UMALCR - 3.3320281e-05 * max(UMALCR - 4.05, 0)**3 + 3.6365097e-05 * max(UMALCR - 9.41, 0)**3 - 3.0448157e-06 * max(UMALCR - 68.066, 0)**3;
  1-(0.9586049^(exp(lp)))
})
#####Hypotension
## Intensive
Hypo.Intensive.Fit <- expression({
  lp <- 0.33901834 + 0.78084365 * (INCLUSIONFRS == "Yes") - 0.010332949 * SBP + 0.014343942 * DBP + 0.14383519 * N_AGENTS + 0.44394661 * (SMOKE_3CAT == "Former") + 0.81039549 * (SMOKE_3CAT == "Current") - 0.016304959 * EGFR + 0.31014838 * (SUB_CLINICALCVD == "Yes") + 0.62637285 * (RACE == "White") + 0.51533266 * (RACE == "Black") + 0 * (RACE == "Hispanic") - 0.018346901 * CHR + 1.6357008e-06 * max(CHR - 141, 0)**3 - 2.9329808e-06 * max(CHR - 187, 0)**3 + 1.29728e-06 * max(CHR - 245, 0)**3 + 0.0072473402 * GLUR + 0.021868495 * HDL + 0.014009797 * TRR - 8.3756958e-07 * max(TRR - 59, 0)**3 + 1.2295356e-06 * max(TRR - 106.5, 0)**3 - 3.9196606e-07 * max(TRR - 208, 0)**3 - 0.00038432022 * UMALCR - 0.016491894 * BMI;
  1-(0.976757^(exp(lp)))
})
## Standard
Hypo.Standard.Fit <- expression({
  lp <- -5.1551479 - 0.56386836 * (INCLUSIONFRS == "Yes") + 0.4071417 * N_AGENTS + 0.8082827 * (NOAGENTS == "Yes") + 0.00082112604 * (SMOKE_3CAT == "Former") + 0.92555184 * (SMOKE_3CAT == "Current") + 0.74496614 * (SUB_CKD == "Yes") + 0.028673463 * AGE + 0.72272216 * (FEMALE == "Male") + 0.42979422 * (SUB_CLINICALCVD == "Yes") + 1.0515872 * (RACE == "White") + 1.0449643 * (RACE == "Black") + 0 * (RACE == "Hispanic") + 0.017120138 * HDL + 0.00073023619 * UMALCR;
  1-(0.9886883^(exp(lp)))
})
#####Orthostatic Hypotension without dizziness
## Intensive
Hypo.wo.Dizzy.Intensive.Fit <- expression({
  lp <- -2.8908688 + 0.0065139501 * DBP + 0.042331873 * (SMOKE_3CAT == "Former") + 0.1463802 * (SMOKE_3CAT == "Current") + 0.27305355 * SCREAT + 0.029890976 * AGE + 0.051153985 * (RACE == "White") - 0.21681401 * (RACE == "Black") + 0 * (RACE == "Hispanic") + 0.006153867 * GLUR - 0.0010504199 * TRR + 0.00054961668 * UMALCR - 0.014954588 * BMI;
  1-(0.7460572^(exp(lp)))
})
## Standard
Hypo.wo.Dizzy.Standard.Fit <- expression({
  lp <-  -0.7011217 - 0.1154738 * (INCLUSIONFRS == "Yes") + 0.0052286922 * SBP + 0.088884205 * (SMOKE_3CAT == "Former") + 0.58014118 * (SMOKE_3CAT == "Current") + 0.022233799 * AGE + 0.26957243 * (SUB_CLINICALCVD == "Yes") + 0.043380799 * (RACE == "White") - 0.14625347 * (RACE == "Black") + 0 * (RACE == "Hispanic") - 0.017305375 * GLUR + 2.122366e-05 * max(GLUR - 85, 0)**3 - 3.6205068e-05 * max(GLUR - 97, 0)**3 + 1.4981407e-05 * max(GLUR - 114, 0)**3 - 0.0024773634 * TRR + 1.5978035e-07 * max(TRR - 59, 0)**3 - 2.3213372e-07 * max(TRR - 107, 0)**3 + 7.2353367e-08 * max(TRR - 213, 0)**3 + 0.015073495 * UMALCR - 1.4391344e-05 * max(UMALCR - 4.05, 0)**3 + 1.5706428e-05 * max(UMALCR - 9.41, 0)**3 - 1.3150846e-06 * max(UMALCR - 68.066, 0)**3;
  1-(0.7123282^(exp(lp)))
})
#####Orthostatic Hypotension with dizziness
## Intensive
Hypo.w.Dizzy.Intensive.Fit <- expression({
  lp <- -3.5078221 + 0.049406581 * (SMOKE_3CAT == "Former") + 0.8323208 * (SMOKE_3CAT == "Current") + 0.036534593 * AGE - 0.72249888 * (FEMALE == "Male") + 0.93517123 * (RACE == "White") + 0.28819798 * (RACE == "Black") + 0 * (RACE == "Hispanic") + 0.01047808 * TRR - 9.5099261e-07 * max(TRR - 59, 0)**3 + 1.3960384e-06 * max(TRR - 106.5, 0)**3 - 4.450458e-07 * max(TRR - 208, 0)**3;
  1-(0.9809689^(exp(lp)))
})
## Standard
Hypo.w.Dizzy.Standard.Fit <- expression({
  lp <- -1.0900694 - 0.0031519771 * (SMOKE_3CAT == "Former") + 0.87043126 * (SMOKE_3CAT == "Current") + 1.1725719 * (RACE == "White") + 0.99607809 * (RACE == "Black") + 0 * (RACE == "Hispanic");
  1-(0.9715309^(exp(lp)))
})
#####Syncope
## Intensive
Syncope.Intensive.Fit <- expression({
  lp <-  0.96730836 + 0.14014733 * N_AGENTS - 0.067219516 * (SMOKE_3CAT == "Former") + 0.52573469 * (SMOKE_3CAT == "Current") - 0.018741959 * EGFR - 0.80352653 * SCREAT + 0.035891757 * AGE - 0.48302951 * (SUB_CLINICALCVD == "Yes") + 0.65645711 * (SUB_SUBCLINICALCVD == "Yes") + 0.55478638 * (RACE == "White") + 0.58670074 * (RACE == "Black") + 0 * (RACE == "Hispanic") - 0.00551902 * CHR - 0.034318715 * BMI + 0.30716304 * (STATIN == "Yes");
  1-(0.9750931^(exp(lp)))
})
## Standard
Syncope.Standard.Fit <- expression({
  lp <-  -4.4430076 - 0.035852683 * (SMOKE_3CAT == "Former") + 1.0911195 * (SMOKE_3CAT == "Current") + 0.45310662 * (ASPIRIN == "Yes") + 0.058655841 * AGE + 0.63107064 * (RACE == "White") + 0.71854155 * (RACE == "Black") + 0 * (RACE == "Hispanic") - 0.0037416733 * TRR;
  1-(0.9809025^(exp(lp)))
})
#####Electrolyte Abnormality
## Intensive
Ele.Abn.Intensive.Fit <- expression({
  lp <- -1.6746163 + 0.016646634 * SBP - 0.027794308 * DBP - 0.51925874 * (NOAGENTS == "Yes") + 0.39244314 * (SMOKE_3CAT == "Former") + 0.40457321 * (SMOKE_3CAT == "Current") + 0.016228904 * EGFR + 0.96877103 * SCREAT + 0.35713422 * (SUB_CKD == "Yes") - 1.1856069 * (FEMALE == "Male") + 0.27536214 * (SUB_CLINICALCVD == "Yes") + 0.94771603 * (RACE == "White") + 0.63864609 * (RACE == "Black") + 0 * (RACE == "Hispanic") + 0.00098070175 * UMALCR - 0.037405844 * BMI + 0.2293489 * (STATIN == "Yes");
  1-(0.9730593^(exp(lp)))
})
## Standard
Ele.Abn.Standard.Fit <- expression({
  lp <- -8.3172788 - 0.49489989 * (INCLUSIONFRS == "Yes") + 0.015183658 * SBP + 0.3151155 * N_AGENTS + 0.23252017 * (SMOKE_3CAT == "Former") + 0.56479164 * (SMOKE_3CAT == "Current") + 0.037515469 * AGE - 0.56173025 * (SUB_SUBCLINICALCVD == "Yes") + 2.4241893 * (RACE == "White") + 2.4416797 * (RACE == "Black") + 0 * (RACE == "Hispanic") + 0.016058051 * HDL + 0.034453905 * UMALCR - 3.261656e-05 * max(UMALCR - 4.05, 0)**3 + 3.5597069e-05 * max(UMALCR - 9.41, 0)**3 - 2.9805094e-06 * max(UMALCR - 68.066, 0)**3 - 0.44900649 * (STATIN == "Yes");
  1-(0.9811382^(exp(lp)))
})
#####Injurious Falls
## Intensive
Falls.Intensive.Fit <- expression({
  lp <- -2.936705 + 0.12552176 * N_AGENTS - 0.0075807149 * EGFR + 0.08538657 * AGE - 0.45670456 * (FEMALE == "Male") + 0.35292165 * (RACE == "White") + 0.030745146 * (RACE == "Black") + 0 * (RACE == "Hispanic") - 0.0060942357 * CHR - 0.012091497 * GLUR + 0.012618643 * HDL + 0.0024410413 * TRR - 0.036354963 * BMI;
  1-(0.9831431^(exp(lp)))
})
## Standard
Falls.Standard.Fit <- expression({
  lp <- -10.966839 - 0.61872709 * (INCLUSIONFRS == "Yes") + 0.36912586 * (SMOKE_3CAT == "Former") + 1.5037059 * (SMOKE_3CAT == "Current") + 0.1446546 * AGE + 1.7592616 * (RACE == "White") + 1.0989284 * (RACE == "Black") + 0 * (RACE == "Hispanic") - 0.38140933 * (STATIN == "Yes");
  1-(0.9860345^(exp(lp)))
})
#####Bradycardia
## Intensive
Brady.Intensive.Fit <- expression({
  lp <- -4.3813094 + 0.22564118 * N_AGENTS + 0.038278641 * (SMOKE_3CAT == "Former") + 0.43505289 * (SMOKE_3CAT == "Current") + 0.46028413 * (ASPIRIN == "Yes") - 0.012920502 * EGFR + 0.051396528 * AGE + 0.46634844 * (FEMALE == "Male") + 0.73173287 * (SUB_SUBCLINICALCVD == "Yes") + 0.89610649 * (RACE == "White") + 0.79274551 * (RACE == "Black") + 0 * (RACE == "Hispanic");
  1-(0.9840974^(exp(lp)))
})
## Standard
Brady.Standard.Fit <- expression({
  lp <- -5.1551479 - 0.56386836 * (INCLUSIONFRS == "Yes") + 0.4071417 * N_AGENTS + 0.8082827 * (NOAGENTS == "Yes") + 0.00082112604 * (SMOKE_3CAT == "Former") + 0.92555184 * (SMOKE_3CAT == "Current") + 0.74496614 * (SUB_CKD == "Yes") + 0.028673463 * AGE + 0.72272216 * (FEMALE == "Male") + 0.42979422 * (SUB_CLINICALCVD == "Yes") + 1.0515872 * (RACE == "White") + 1.0449643 * (RACE == "Black")  + 0 * (RACE == "Hispanic") + 0.017120138 * HDL + 0.00073023619 * UMALCR;
  1-(0.9886883^(exp(lp)))
})
#####Incidence Albuminuria
##  Intensive
Albumin.Intensive.Fit <- expression({
  lp <- 1.326617 + 0.22989051 * (ASPIRIN == "Yes") - 0.012577646 * EGFR + 0.013112055 * AGE - 0.38781272 * (FEMALE == "Male") - 0.011407773 * HDL + 0.11140211 * UMALCR - 0.039726757 * BMI;
  (0.9337469^(exp(lp)))
})
## Standard
Albumin.Standard.Fit <- expression({
  lp <- -1.3881199 - 0.015509878 * SBP + 0.18677566 * N_AGENTS + 1.0621287 * SCREAT + 0.02204398 * AGE - 0.26278989 * (FEMALE == "Male") + 0.25231037 * (SUB_CLINICALCVD == "Yes") + 0.13233468 * UMALCR;
  (0.9202132^(exp(lp)))
})
#####Acute Kidney Disease
Kidney.Intensive.Fit <- expression({
  lp <- ifelse(SUB_CKD == "Yes", 1.326617 + 0.22989051 * (ASPIRIN == "Yes") - 0.012577646 * EGFR + 0.013112055 * AGE - 0.38781272 * (FEMALE == "Male") - 0.011407773 * HDL + 0.11140211 * UMALCR - 0.039726757 * BMI, -3.5360896 + 0.032459897 * SBP - 0.032527534 * DBP + 0.069100622 * UMALCR - 0.00012449415 * max(UMALCR - 4.006, 0)**3 + 0.00014212707 * max(UMALCR - 8.78, 0)**3 - 1.7632917e-05 * max(UMALCR - 42.486, 0)**3 + 0.029241402 * BMI);
  ifelse(SUB_CKD == "Yes", 1-(0.9337469^(exp(lp))), 1-(0.9597719^(exp(lp))))
})
## Standard
Kidney.Standard.Fit <- expression({
  lp <- ifelse(SUB_CKD == "Yes", 17.484842 + 0.06846001 * SBP - 0.096004834 * DBP - 0.15184733 * EGFR - 0.060853018 * AGE + 0.019431164 * CHR - 0.028240395 * GLUR - 0.12833111 * HDL - 0.025182698 * TRR + 0.0019294808 * UMALCR + 0.031332264 * BMI, -1.8922163 - 0.72060061 * ( INCLUSIONFRS == "Yes") + 0.055463907 * SBP - 0.03453476 * DBP - 0.16244875 * (SMOKE_3CAT == "Former") + 0.92041741 * (SMOKE_3CAT == "Current") - 0.04235301 * EGFR + 0.0724283 * UMALCR - 0.00014050435 * max(UMALCR - 4.021, 0)**3 + 0.00015857052 * max(UMALCR - 8.505, 0)**3 - 1.8066169e-05 * max(UMALCR - 43.378, 0)**3);
  ifelse(SUB_CKD == "Yes", 1-(0.9996967^(exp(lp))), 1-(0.9912283^exp(lp)))
})






color.intensive <- function(input.intensive, input.standard){
  diff <- input.intensive-input.standard
  cell.color <- ifelse(diff > 0 & diff <= 2, "indianred1", ifelse(diff > 2, "red", ifelse(diff < 0 & diff >= -2, "palegreen", ifelse(diff < -2, "Green", "khaki"))))
  return(cell.color)
}
color.standard <- function(input.intensive, input.standard){
  diff <- input.standard-input.intensive
  cell.color <- ifelse(diff > 0 & diff <= 2, "indianred1", ifelse(diff > 2, "Red", ifelse(diff < 0 & diff >= -2, "palegreen", ifelse(diff < -2, "Green", "khaki"))))
  return(cell.color)
}

#cex.intensive <- function(input.intensive, input.standard){
#   diff <- input.intensive-input.standard
#   cex.cell <- ifelse(diff > 0 & diff <= 0.2, 2.1, 
#                    ifelse(diff > 0.2 & diff <= 0.4, 2.2, 
#                    ifelse(diff > 0.4 & diff <= 0.6, 2.3, 
#                    ifelse(diff > 0.6 & diff <= 0.8, 2.4, 
#                    ifelse(diff > 0.8 & diff <= 1, 2.5, 
#                    ifelse(diff > 1 & diff <= 1.5, 2.6,
#                    ifelse(diff > 1.5 & diff <= 2, 2.8,
#                    ifelse(diff > 2 & diff <= 2.5, 3,
#                    ifelse(diff > 2.5 & diff <= 3, 3.2,
#                    ifelse(diff > 3 & diff <= 3.5, 3.4,
#                    ifelse(diff > 3.5 & diff <= 4, 3.6,
#                    ifelse(diff > 4 & diff <= 10, 3.8,
#                    ifelse(diff > 10, 4,
#                    ifelse(diff < 0 & diff >= -0.2, 1.9,
#                    ifelse(diff < -0.2 & diff >= -0.4, 1.8, 
#                    ifelse(diff < -0.4 & diff >= -0.6, 1.7,
#                    ifelse(diff < -0.6 & diff >= -0.8, 1.6,
#                    ifelse(diff < -0.8 & diff >= -1, 1.5,
#                    ifelse(diff < -1 & diff >= -1.5, 1.4,
#                    ifelse(diff < -1.5 & diff >= -2, 1.2,
#                    ifelse(diff < -2 & diff >= -2.5, 1,
#                    ifelse(diff < -2.5 & diff >= -3, 0.8,
#                    ifelse(diff < -3, 0.75, 2)))))))))))))))))))))))
#     
#     return(cex.cell)
# }
# #cex.standad <- function(input.intensive, input.standard){
#   diff <- input.standard-input.intensive
#   cex.cell <- ifelse(diff > 0 & diff <= 0.2, 2.1, 
#                           ifelse(diff > 0.2 & diff <= 0.4, 2.2, 
#                                  ifelse(diff > 0.4 & diff <= 0.6, 2.3, 
#                                         ifelse(diff > 0.6 & diff <= 0.8, 2.4, 
#                                                ifelse(diff > 0.8 & diff <= 1, 2.5, 
#                                                       ifelse(diff > 1 & diff <= 1.5, 2.6,
#                                                              ifelse(diff > 1.5 & diff <= 2, 2.8,
#                                                                     ifelse(diff > 2 & diff <= 2.5, 3,
#                                                                            ifelse(diff > 2.5 & diff <= 3, 3.2,
#                                                                                   ifelse(diff > 3 & diff <= 3.5, 3.4,
#                                                                                          ifelse(diff > 3.5 & diff <= 4, 3.6,
#                                                                                                 ifelse(diff > 4 & diff <= 10, 3.8,
#                                                                                                        ifelse(diff > 10, 4,
#                                                                                                               ifelse(diff < 0 & diff >= -0.2, 1.9,
#                                                                                                                      ifelse(diff < -0.2 & diff >= -0.4, 1.8, 
#                                                                                                                             ifelse(diff < -0.4 & diff >= -0.6, 1.7,
#                                                                                                                                    ifelse(diff < -0.6 & diff >= -0.8, 1.6,
#                                                                                                                                           ifelse(diff < -0.8 & diff >= -1, 1.5,
#                                                                                                                                                  ifelse(diff < -1 & diff >= -1.5, 1.4,
#                                                                                                                                                         ifelse(diff < -1.5 & diff >= -2, 1.2,
#                                                                                                                                                                ifelse(diff < -2 & diff >= -2.5, 1,
#                                                                                                                                                                       ifelse(diff < -2.5 & diff >= -3, 0.8,
#                                                                                                                                                                              ifelse(diff < -3, 0.75, 2)))))))))))))))))))))))
#   
#   return(cex.cell)
# }

sprint.major.plot <- function(all.death.intensive, all.death.standard, cv.death.intensive, cv.death.standard, stroke.intensive, stroke.standard, hf.intensive, hf.standard, mi.intensive, mi.standard, acs.intensive, acs.standard, kidney.intensive, kidney.standard, BMI, EGFR, SBP, DBP, CHR, HDL, SCREAT, UMALCR, GLUR, TRR){
    par(mar=c(10, 0.1, 2, 0.1))
    plot(1, 1, xaxt="n", yaxt="n", type="n", xlab="", ylab="", xaxs = "i", yaxs="i")#xaxt="n", yaxt="n", 
    abline(v = c(0.9, 1.15))
    abline(h = c(1.3, 1.2, 1.1, 1.0, 0.9, 0.8, 0.7, 0.6))
    text(0.75, 1.35, "Outcomes", cex=2, font = 2)
    text(0.75, 1.25, "All-Cause Death", cex=1.25)
    text(0.75, 1.15, "Cardiovascular Death", cex=1.25)
    text(0.75, 1.05, "Stroke", cex=1.25)
    text(0.75, 0.95, "Heart Failure", cex=1.25)
    text(0.75, 0.85, "Myocardial Infarction", cex=1.25)
    text(0.75, 0.75, "Acute Coronary\n Syndrome", cex=1.25)
    text(0.75, 0.65, "Acute Kidney Disease", cex=1.25)
    #All-Cuase Death
    all.death.intensive.r <- round(all.death.intensive*100, 1)
    all.death.standard.r <- round(all.death.standard*100, 1)
    rect(0.9, 1.2, 1.15, 1.3, col=color.intensive(all.death.intensive.r, all.death.standard.r))
    #text(1.025, 1.25, paste(ifelse(all.death.intensive <0.001, "<0.1", all.death.intensive.r), "%", sep=""), cex=cex.intensive(all.death.intensive.r, all.death.standard.r))
    text(1.025, 1.25, paste(ifelse(all.death.intensive <0.001, "<0.1", all.death.intensive.r), "%", sep=""), cex=1.5)
    rect(1.15, 1.2, 1.4, 1.3, col=color.standard(all.death.intensive.r, all.death.standard.r))
    #text(1.275, 1.25, paste(ifelse(all.death.standard <0.001, "<0.1", all.death.standard.r), "%", sep=""),  cex=cex.standad(all.death.intensive.r, all.death.standard.r))
    text(1.275, 1.25, paste(ifelse(all.death.standard <0.001, "<0.1", all.death.standard.r), "%", sep=""),  cex=1.5)
    #CV Death
    cv.death.intensive.r <- round(cv.death.intensive*100, 1)
    cv.death.standard.r <- round(cv.death.standard*100, 1)
    rect(0.9, 1.1, 1.15, 1.2, col=color.intensive(cv.death.intensive.r, cv.death.standard.r))
    #text(1.025, 1.15, paste(ifelse(cv.death.intensive <0.001, "<0.1", cv.death.intensive.r), "%", sep=""), cex=cex.intensive(cv.death.intensive.r, cv.death.standard.r))
    text(1.025, 1.15, paste(ifelse(cv.death.intensive <0.001, "<0.1", cv.death.intensive.r), "%", sep=""), cex=1.5)
    rect(1.15, 1.1, 1.4, 1.2, col=color.standard(cv.death.intensive.r, cv.death.standard.r))
    #text(1.275, 1.15, paste(ifelse(cv.death.standard <0.001, "<0.1", cv.death.standard.r), "%", sep=""),  cex=cex.standad(cv.death.intensive.r, cv.death.standard.r))
    text(1.275, 1.15, paste(ifelse(cv.death.standard <0.001, "<0.1", cv.death.standard.r), "%", sep=""),  cex=1.5)
    #Stroke
    stroke.intensive.r <- round(stroke.intensive*100, 1)
    stroke.standard.r <- round(stroke.standard*100, 1)
    rect(0.9, 1, 1.15, 1.1, col=color.intensive(stroke.intensive.r, stroke.standard.r))
    #text(1.025, 1.05, paste(ifelse(stroke.intensive <0.001, "<0.1", stroke.intensive.r), "%", sep=""), cex=cex.intensive(stroke.intensive.r, stroke.standard.r))
    text(1.025, 1.05, paste(ifelse(stroke.intensive <0.001, "<0.1", stroke.intensive.r), "%", sep=""), cex=1.5)
    rect(1.15, 1, 1.4, 1.1, col=color.standard(stroke.intensive.r, stroke.standard.r))
    #text(1.275, 1.05, paste(ifelse(stroke.standard <0.001, "<0.1", stroke.standard.r), "%", sep=""),  cex=cex.standad(stroke.intensive.r, stroke.standard.r))
    text(1.275, 1.05, paste(ifelse(stroke.standard <0.001, "<0.1", stroke.standard.r), "%", sep=""),  cex=1.5)
    #Heart Failure
    hf.intensive.r <- round(hf.intensive*100, 1)
    hf.standard.r <- round(hf.standard*100, 1)
    rect(0.9, 0.9, 1.15, 1, col=color.intensive(hf.intensive.r, hf.standard.r))
    #text(1.025, 0.95, paste(ifelse(hf.intensive <0.001, "<0.1", hf.intensive.r), "%", sep=""), cex=cex.intensive(hf.intensive.r, hf.standard.r))
    text(1.025, 0.95, paste(ifelse(hf.intensive <0.001, "<0.1", hf.intensive.r), "%", sep=""), cex=1.5)
    rect(1.15, 0.9, 1.4, 1, col=color.standard(hf.intensive.r, hf.standard.r))
    #text(1.275, 0.95, paste(ifelse(hf.standard <0.001, "<0.1", hf.standard.r), "%", sep=""),  cex=cex.standad(hf.intensive.r, hf.standard.r))
    text(1.275, 0.95, paste(ifelse(hf.standard <0.001, "<0.1", hf.standard.r), "%", sep=""),  cex=1.5)
    #MI
    mi.intensive.r <- round(mi.intensive*100, 1)
    mi.standard.r <- round(mi.standard*100, 1)
    rect(0.9, 0.8, 1.15, 0.9, col=color.intensive(mi.intensive.r, mi.standard.r))
    #text(1.025, 0.85, paste(ifelse(mi.intensive <0.001, "<0.1", mi.intensive.r), "%", sep=""), cex=cex.intensive(mi.intensive.r, mi.standard.r))
    text(1.025, 0.85, paste(ifelse(mi.intensive <0.001, "<0.1", mi.intensive.r), "%", sep=""), cex=1.5)
    rect(1.15, 0.8, 1.4, 0.9, col=color.standard(mi.intensive.r, mi.standard.r))
    #text(1.275, 0.85, paste(ifelse(mi.standard <0.001, "<0.1", mi.standard.r), "%", sep=""),  cex=cex.standad(mi.intensive.r, mi.standard.r))
    text(1.275, 0.85, paste(ifelse(mi.standard <0.001, "<0.1", mi.standard.r), "%", sep=""),  cex=1.5)
    #ACS
    acs.intensive.r <- round(acs.intensive*100, 1)
    acs.standard.r <- round(acs.standard*100, 1)
    rect(0.9, 0.7, 1.15, 0.8, col=color.intensive(acs.intensive.r, acs.standard.r))
    #text(1.025, 0.75, paste(ifelse(acs.intensive <0.001, "<0.1", acs.intensive.r), "%", sep=""), cex=cex.intensive(acs.intensive.r, acs.standard.r))
    text(1.025, 0.75, paste(ifelse(acs.intensive <0.001, "<0.1", acs.intensive.r), "%", sep=""), cex=1.5)
    rect(1.15, 0.7, 1.4, 0.8, col=color.standard(acs.intensive.r, acs.standard.r))
    ##text(1.275, 0.75, paste(ifelse(acs.standard <0.001, "<0.1", acs.standard.r), "%", sep=""),  cex=cex.standad(acs.intensive.r, acs.standard.r))
    text(1.275, 0.75, paste(ifelse(acs.standard <0.001, "<0.1", acs.standard.r), "%", sep=""),  cex=1.5)
    #Acute Kidney Disease
    kidney.intensive.r <- round(kidney.intensive*100, 1)
    kidney.standard.r <- round(kidney.standard*100, 1)
    rect(0.9, 0.6, 1.15, 0.7, col=color.intensive(kidney.intensive.r, kidney.standard.r))
    #text(1.025, 0.65, paste(ifelse(kidney.intensive <0.001, "<0.1", kidney.intensive.r), "%", sep=""), cex=cex.intensive(kidney.intensive.r, kidney.standard.r))
    text(1.025, 0.65, paste(ifelse(kidney.intensive <0.001, "<0.1", kidney.intensive.r), "%", sep=""), cex=1.5)
    rect(1.15, 0.6, 1.4, 0.7, col=color.standard(kidney.intensive.r, kidney.standard.r))
    #text(1.275, 0.65, paste(ifelse(kidney.standard <0.001, "<0.1", kidney.standard.r), "%", sep=""),  cex=cex.standad(kidney.intensive.r, kidney.standard.r))
    text(1.275, 0.65, paste(ifelse(kidney.standard <0.001, "<0.1", kidney.standard.r), "%", sep=""),  cex=1.5)
    
    #add.intensive <- sum(mi.intensive, acs.intensive, stroke.intensive, hf.intensive, cv.death.intensive, all.death.intensive, kidney.intensive)/7
    #add.standard <-  sum(mi.standard,  acs.standard,  stroke.standard,  hf.standard,  cv.death.standard,  all.death.standard,  kidney.standard)/7
    
    #rect(0.9, 1.3, 1.15, 1.4, col=ifelse(add.intensive > add.standard, "Red", ifelse(add.intensive < add.standard, "Green", "khaki")))
    
    text(1.025, 1.35, "Target Systolic Blood \nPressure < 120mm Hg", cex=1.5, font = 2)
    #rect(1.15, 1.3, 1.4, 1.4, col=ifelse(add.intensive > add.standard, "Green", ifelse(add.intensive < add.standard, "Red", "khaki")))
    text(1.275, 1.35, "Target Systolic Blood \nPressure < 140mm Hg", cex=1.5, font = 2)
  
 }

sprint.ae.plot <- function(syncope.intensive, syncope.standard, fall.intensive, fall.standard, ele.abn.intensive, ele.abn.standard, hypo.intensive, hypo.standard, hypo.w.dizzy.intensive, hypo.w.dizzy.standard, bradycardia.intensive, bradycardia.standard, albumin.intensive, albumin.standard, hypo.wo.dizzy.intensive, hypo.wo.dizzy.standard){
  par(mar=c(4, 2, 2, 2))
  plot(1, 1, xaxt="n", yaxt="n", type="n", xlab="", ylab="", xaxs = "i", yaxs="i")#
  abline(v = c(0.9, 1.15))
  abline(h = c(1.3, 1.2125, 1.125, 1.0375, 0.95, 0.8625, 0.775, 0.6875)) 
  text(0.75, 1.35, "Outcomes", cex=2, font = 2)          
  text(0.75, 1.25625, "Syncope", cex=1.5)    
  text(0.75, 1.16875, "Injurious Falls", cex=1.5)
  text(0.75, 1.08125, "Electrolyte \nAbnormality", cex=1.5)
  text(0.75, 0.99375, "Hypotension", cex=1.5)
  text(0.75, 0.90625, "Othostatic Hypotension\n with Dizziness", cex=1.5)
  text(0.75, 0.81875, "Bradycardia", cex=1.5)
  text(0.75, 0.73125, "Incident Albuminuria", cex=1.5)
  text(0.75, 0.64375, "Othostatic Hypotension\n without Dizziness", cex=1.5)
  #syncope
  syncope.intensive.r <- round(syncope.intensive*100, 1)
  syncope.standard.r <- round(syncope.standard*100, 1)
  rect(0.9, 1.2125, 1.15, 1.3, col=color.intensive(syncope.intensive.r, syncope.standard.r))
  #text(1.025, 1.25625, paste(ifelse(syncope.intensive <0.001, "<0.1", syncope.intensive.r), "%", sep=""), cex=cex.intensive(syncope.intensive.r, syncope.standard.r))
  text(1.025, 1.25625, paste(ifelse(syncope.intensive <0.001, "<0.1", syncope.intensive.r), "%", sep=""), cex=1.5)
  rect(1.15, 1.2125, 1.4, 1.3, col=color.standard(syncope.intensive.r, syncope.standard.r))
  #text(1.275, 1.25625, paste(ifelse(syncope.standard <0.001, "<0.1", syncope.standard.r), "%", sep=""),  cex=cex.standad(syncope.intensive.r, syncope.standard.r))
  text(1.275, 1.25625, paste(ifelse(syncope.standard <0.001, "<0.1", syncope.standard.r), "%", sep=""),  cex=1.5)
  #Injurious Falls
  fall.intensive.r <- round(fall.intensive*100, 1)
  fall.standard.r <- round(fall.standard*100, 1)
  rect(0.9, 1.125, 1.15, 1.2125, col=color.intensive(fall.intensive.r, fall.standard.r))
  #text(1.025, 1.16875, paste(ifelse(fall.intensive <0.001, "<0.1", fall.intensive.r), "%", sep=""), cex=cex.intensive(fall.intensive.r, fall.standard.r))
  text(1.025, 1.16875, paste(ifelse(fall.intensive <0.001, "<0.1", fall.intensive.r), "%", sep=""), cex=1.5)
  rect(1.15, 1.125, 1.4, 1.2125, col=color.standard(fall.intensive.r, fall.standard.r))
  #text(1.275, 1.16875, paste(ifelse(fall.standard <0.001, "<0.1", fall.standard.r), "%", sep=""),   cex=cex.standad(fall.intensive.r, fall.standard.r))
  text(1.275, 1.16875, paste(ifelse(fall.standard <0.001, "<0.1", fall.standard.r), "%", sep=""),   cex=1.5)
  #Electrolyte Abnormality
  ele.abn.intensive.r <- round(ele.abn.intensive*100, 1)
  ele.abn.standard.r <- round(ele.abn.standard*100, 1)
  rect(0.9, 1.0375, 1.15, 1.125, col=color.intensive(ele.abn.intensive.r, ele.abn.standard.r))
  #text(1.025, 1.08125, paste(ifelse(ele.abn.intensive <0.001, "<0.1", ele.abn.intensive.r), "%", sep=""), cex=cex.intensive(ele.abn.intensive.r, ele.abn.standard.r))
  text(1.025, 1.08125, paste(ifelse(ele.abn.intensive <0.001, "<0.1", ele.abn.intensive.r), "%", sep=""), cex=1.5)
  rect(1.15, 1.0375, 1.4, 1.125, col=color.standard(ele.abn.intensive.r, ele.abn.standard.r))
  #text(1.275, 1.08125, paste(ifelse(ele.abn.standard <0.001, "<0.1", ele.abn.standard.r), "%", sep=""),  cex=cex.standad(ele.abn.intensive.r, ele.abn.standard.r))
  text(1.275, 1.08125, paste(ifelse(ele.abn.standard <0.001, "<0.1", ele.abn.standard.r), "%", sep=""),  cex=1.5)
  #Hypotension
  hypo.intensive.r <- round(hypo.intensive*100, 1)
  hypo.standard.r <- round(hypo.standard*100, 1)
  rect(0.9, 0.95, 1.15, 1.0375, col=color.intensive(hypo.intensive.r, hypo.standard.r))
  #text(1.025, 0.99375, paste(ifelse(hypo.intensive <0.001, "<0.1", hypo.intensive.r), "%", sep=""), cex=cex.intensive(hypo.intensive.r, hypo.standard.r))
  text(1.025, 0.99375, paste(ifelse(hypo.intensive <0.001, "<0.1", hypo.intensive.r), "%", sep=""), cex=1.5)
  rect(1.15, 0.95, 1.4, 1.0375, col=color.standard(hypo.intensive.r, hypo.standard.r))
  #text(1.275, 0.99375, paste(ifelse(hypo.standard <0.001, "<0.1", hypo.standard.r), "%", sep=""),  cex=cex.standad(hypo.intensive.r, hypo.standard.r))
  text(1.275, 0.99375, paste(ifelse(hypo.standard <0.001, "<0.1", hypo.standard.r), "%", sep=""),  cex=1.5)
  #Orthostatic Hypotension with dizziness
  hypo.w.dizzy.intensive.r <- round(hypo.w.dizzy.intensive*100, 1)
  hypo.w.dizzy.standard.r <- round(hypo.w.dizzy.standard*100, 1)
  rect(0.90, 0.8625, 1.15, 0.95, col=color.intensive(hypo.w.dizzy.intensive.r, hypo.w.dizzy.standard.r))
  #text(1.025, 0.90625, paste(ifelse(hypo.w.dizzy.intensive <0.001, "<0.1", hypo.w.dizzy.intensive.r), "%", sep=""), cex=cex.intensive(hypo.w.dizzy.intensive.r, hypo.w.dizzy.standard.r))
  text(1.025, 0.90625, paste(ifelse(hypo.w.dizzy.intensive <0.001, "<0.1", hypo.w.dizzy.intensive.r), "%", sep=""), cex=1.5)
  rect(1.15, 0.8625, 1.4, 0.95, col=color.standard(hypo.w.dizzy.intensive.r, hypo.w.dizzy.standard.r))
  #text(1.275, 0.90625, paste(ifelse(hypo.w.dizzy.standard <0.001, "<0.1", hypo.w.dizzy.standard.r), "%", sep=""),  cex=cex.standad(hypo.w.dizzy.intensive.r, hypo.w.dizzy.standard.r))
  text(1.275, 0.90625, paste(ifelse(hypo.w.dizzy.standard <0.001, "<0.1", hypo.w.dizzy.standard.r), "%", sep=""),  cex=1.5)
  #Bradycardia
  bradycardia.intensive.r <- round(bradycardia.intensive*100, 1)
  bradycardia.standard.r <- round(bradycardia.standard*100, 1)
  rect(0.9, 0.775, 1.15, 0.8625, col=color.intensive(bradycardia.intensive.r, bradycardia.standard.r))
  #text(1.025, 0.81875, paste(ifelse(bradycardia.intensive <0.001, "<0.1", bradycardia.intensive.r), "%", sep=""), cex=cex.intensive(bradycardia.intensive.r, bradycardia.standard.r))
  text(1.025, 0.81875, paste(ifelse(bradycardia.intensive <0.001, "<0.1", bradycardia.intensive.r), "%", sep=""), cex=1.5)
  rect(1.15, 0.775, 1.4, 0.8625, col=color.standard(bradycardia.intensive.r, bradycardia.standard.r))
  #text(1.275, 0.81875, paste(ifelse(bradycardia.standard <0.001, "<0.1", bradycardia.standard.r), "%", sep=""),   cex=cex.standad(bradycardia.intensive.r, bradycardia.standard.r))
  text(1.275, 0.81875, paste(ifelse(bradycardia.standard <0.001, "<0.1", bradycardia.standard.r), "%", sep=""),   cex=1.5)
  #Incident albuminuria
  albumin.intensive.r <- round(albumin.intensive*100, 1)
  albumin.standard.r <- round(albumin.standard*100, 1)
  rect(0.9, 0.6875, 1.15, 0.775, col=color.intensive(albumin.intensive.r, albumin.standard.r))
  #text(1.025, 0.73125, paste(ifelse(albumin.intensive <0.001, "<0.1", albumin.intensive.r), "%", sep=""), cex=cex.intensive(albumin.intensive.r, albumin.standard.r))
  text(1.025, 0.73125, paste(ifelse(albumin.intensive <0.001, "<0.1", albumin.intensive.r), "%", sep=""), cex=1.5)
  rect(1.15, 0.6875, 1.4, 0.775, col=color.standard(albumin.intensive.r, albumin.standard.r))
  #text(1.275, 0.73125, paste(ifelse(albumin.standard <0.001, "<0.1", albumin.standard.r), "%", sep=""),  cex=cex.standad(albumin.intensive.r, albumin.standard.r))
  text(1.275, 0.73125, paste(ifelse(albumin.standard <0.001, "<0.1", albumin.standard.r), "%", sep=""),  cex=1.5)
  #Orthostatic Hypotension without dizziness
  hypo.wo.dizzy.intensive.r <- round(hypo.wo.dizzy.intensive*100, 1)
  hypo.wo.dizzy.standard.r <- round(hypo.wo.dizzy.standard*100, 1)
  rect(0.9, 0.6, 1.15, 0.6875, col=color.intensive(hypo.wo.dizzy.intensive.r, hypo.wo.dizzy.standard.r))
  #text(1.025, 0.64375, paste(ifelse(hypo.wo.dizzy.intensive <0.001, "<0.1", hypo.wo.dizzy.intensive.r), "%", sep=""), cex=cex.intensive(hypo.wo.dizzy.intensive.r, hypo.wo.dizzy.standard.r))
  text(1.025, 0.64375, paste(ifelse(hypo.wo.dizzy.intensive <0.001, "<0.1", hypo.wo.dizzy.intensive.r), "%", sep=""), cex=1.5)
  rect(1.15, 0.6, 1.4, 0.6875, col=color.standard(hypo.wo.dizzy.intensive.r, hypo.wo.dizzy.standard.r))
  #text(1.275, 0.64375, paste(ifelse(hypo.wo.dizzy.standard <0.001, "<0.1", hypo.wo.dizzy.standard.r), "%", sep=""),  cex=cex.standad(hypo.wo.dizzy.intensive.r, hypo.wo.dizzy.standard.r))
  text(1.275, 0.64375, paste(ifelse(hypo.wo.dizzy.standard <0.001, "<0.1", hypo.wo.dizzy.standard.r), "%", sep=""),  cex=1.5)
  
  #add.intensive <- sum(hypo.intensive, hypo.wo.dizzy.intensive, hypo.w.dizzy.intensive, syncope.intensive, ele.abn.intensive, albumin.intensive, fall.intensive, bradycardia.intensive)/8
  #add.standard <-  sum(hypo.standard,  hypo.wo.dizzy.standard,  hypo.w.dizzy.standard,  syncope.standard,  ele.abn.standard,  albumin.standard,  fall.standard,  bradycardia.standard)/8
  
  #rect(0.9, 1.3, 1.15, 1.4, col=ifelse(add.intensive > add.standard, "Red", ifelse(add.intensive < add.standard, "Green", "khaki")))
  text(1.025, 1.35, "Target Systolic Blood \nPressure < 120mm Hg", cex=1.5, font = 2)
  #rect(1.15, 1.3, 1.4, 1.4, col=ifelse(add.intensive > add.standard, "Green", ifelse(add.intensive < add.standard, "Red", "khaki")))
  text(1.275, 1.35, "Target Systolic Blood \nPressure < 140mm Hg", cex=1.5, font = 2)
}




shinyServer(function(input, output) {
  get_newdata <- reactive({
    new_df <- data.frame(#INCLUSIONFRS = factor(input$INCLUSIONFRS, levels=c("Yes", "No")),
      SMOKE_3CAT = factor(input$SMOKE_3CAT, levels=c("Never", "Former", "Current")),
      ASPIRIN = factor(input$ASPIRIN, levels=c("Yes", "No")),
      EGFR = input$EGFR,
      AGE = input$AGE,
      SCREAT = input$SCREAT,
      SUB_CLINICALCVD = factor(input$SUB_CLINICALCVD, levels=c("Yes", "No")),
      CHR = input$CHR,
      HDL = input$HDL,
      UMALCR = input$UMALCR,
      RACE = factor(input$RACE, levels=c("White", "Black", "Hispanic", "Other")),
      SBP = input$SBP,
      TRR = input$TRR,
      SUB_CKD = factor(input$SUB_CKD, levels=c("Yes", "No")),
      GLUR = input$GLUR,
      NOAGENTS = factor(input$NOAGENTS, levels=c("No", "Yes")),
      SUB_SUBCLINICALCVD = factor(input$SUB_SUBCLINICALCVD, levels=c("Yes", "No")),
      BMI = input$BMI,
      N_AGENTS = input$N_AGENTS,
      FEMALE = factor(input$FEMALE, levels=c("Female", "Male")),
      DBP = input$DBP,
      STATIN = factor(input$STATIN, levels=c("Yes", "No"))
    )
    
    new_df$INCLUSIONFRS <- with(new_df, ifelse(FEMALE == "Male"   & (1-(0.88936^(exp((3.06117*log(AGE) + 1.12370*log(CHR) - 0.93263*log(HDL) + 1.93303*log(SBP)*(NOAGENTS == "No") + 1.99881*log(SBP)*(NOAGENTS == "Yes") + 0.65451*(SMOKE_3CAT == "Current") + 0.57367*0) - 23.9802)))) > 0.15, "Yes", 
                                               ifelse(FEMALE == "Female" & (1-(0.95012^(exp((2.32888*log(AGE) + 1.20904*log(CHR) - 0.70833*log(HDL) + 2.76157*log(SBP)*(NOAGENTS == "No") + 2.82263*log(SBP)*(NOAGENTS == "Yes") + 0.52873*(SMOKE_3CAT == "Current") + 0.69154*0) - 26.1931)))) > 0.15, "Yes", "No")))
    
    new_df
  })
  
  output$pred1 <- renderPlot({
    new.dat <- get_newdata()
    pred.all.death.intensive <- eval(All.Death.Intensive.Fit, envir = new.dat)
    pred.all.death.standard <- eval(All.Death.Standard.Fit, envir = new.dat)
    pred.cv.death.intensive <- eval(CV.Death.Intensive.Fit, envir = new.dat)
    pred.cv.death.standard <- eval(CV.Death.Standard.Fit, envir = new.dat)
    pred.stroke.intensive <- eval(Stroke.Intensive.Fit, envir = new.dat)
    pred.stroke.standard <- eval(Stroke.Standard.Fit, envir = new.dat)
    pred.hf.intensive <- eval(HF.Intensive.Fit, envir = new.dat)
    pred.hf.standard <- eval(HF.Standard.Fit, envir = new.dat)
    pred.mi.intensive <- eval(MI.Intensive.Fit, envir = new.dat)
    pred.mi.standard <- eval(MI.Standard.Fit, envir = new.dat)
    pred.acs.intensive <- eval(ACS.Intensive.Fit, envir = new.dat)
    pred.acs.standard <- eval(ACS.Standard.Fit, envir = new.dat)
    pred.kidney.intensive <- eval(Kidney.Intensive.Fit, envir = new.dat)
    pred.kidney.standard <- eval(Kidney.Standard.Fit, envir = new.dat)
    
    sprint.major.plot(pred.all.death.intensive, pred.all.death.standard, pred.cv.death.intensive, pred.cv.death.standard, pred.stroke.intensive, pred.stroke.standard, pred.hf.intensive, pred.hf.standard, pred.mi.intensive, pred.mi.standard, pred.acs.intensive, pred.acs.standard, pred.kidney.intensive, pred.kidney.standard)
  })
  
  output$pred2 <- renderPlot({
    new.dat <- get_newdata()
    pred.syncope.intensive <- eval(Syncope.Intensive.Fit, envir = new.dat)
    pred.syncope.standard <- eval(Syncope.Standard.Fit, envir = new.dat)
    pred.fall.intensive <- eval(Falls.Intensive.Fit, envir = new.dat)
    pred.fall.standard <- eval(Falls.Standard.Fit, envir = new.dat)
    pred.ele.abn.intensive <- eval(Ele.Abn.Intensive.Fit, envir = new.dat)
    pred.ele.abn.standard <- eval(Ele.Abn.Standard.Fit, envir = new.dat)
    pred.hypo.intensive <- eval(Hypo.Intensive.Fit, envir = new.dat)
    pred.hypo.standard <- eval(Hypo.Standard.Fit, envir = new.dat)
    pred.hypo.w.dizzy.intensive <- eval(Hypo.w.Dizzy.Intensive.Fit, envir = new.dat)
    pred.hypo.w.dizzy.standard <- eval(Hypo.w.Dizzy.Standard.Fit, envir = new.dat)
    pred.bradycardia.intensive <- eval(Brady.Intensive.Fit, envir = new.dat)
    pred.bradycardia.standard <- eval(Brady.Standard.Fit, envir = new.dat)
    pred.albumin.intensive <- eval(Albumin.Intensive.Fit, envir = new.dat)
    pred.albumin.standard <- eval(Albumin.Standard.Fit, envir = new.dat)
    pred.hypo.wo.dizzy.intensive <- eval(Hypo.wo.Dizzy.Intensive.Fit, envir = new.dat)
    pred.hypo.wo.dizzy.standard <- eval(Hypo.wo.Dizzy.Standard.Fit, envir = new.dat)
    
    sprint.ae.plot(pred.syncope.intensive, pred.syncope.standard, pred.fall.intensive, pred.fall.standard, pred.ele.abn.intensive, pred.ele.abn.standard, pred.hypo.intensive, pred.hypo.standard, pred.hypo.w.dizzy.intensive, pred.hypo.w.dizzy.standard, pred.bradycardia.intensive, pred.bradycardia.standard, pred.albumin.intensive, pred.albumin.standard, pred.hypo.wo.dizzy.intensive, pred.hypo.wo.dizzy.standard)  
  })
  
  output$text <- renderText({
    new.dat <- get_newdata()
    Framingham <- with(new.dat, ifelse(FEMALE == "Male", (1-(0.88936^(exp((3.06117*log(AGE) + 1.12370*log(CHR) - 0.93263*log(HDL) + 1.93303*log(SBP)*(NOAGENTS == "No") + 1.99881*log(SBP)*(NOAGENTS == "Yes") + 0.65451*(SMOKE_3CAT == "Current") + 0.57367*0) - 23.9802)))),
                                             (1-(0.95012^(exp((2.32888*log(AGE) + 1.20904*log(CHR) - 0.70833*log(HDL) + 2.76157*log(SBP)*(NOAGENTS == "No") + 2.82263*log(SBP)*(NOAGENTS == "Yes") + 0.52873*(SMOKE_3CAT == "Current") + 0.69154*0) - 26.1931))))))
    paste("Framingham Risk Score:", round(Framingham*100, 1))
  })
  
  output$color.plot <- renderPlot({
    par(mar=c(0, 0, 0, 0))
    plot(1, 1, xaxt="n", yaxt="n", type="n", xlab="", ylab="", xaxs = "i", yaxs="i", bty="n")
    text(1, 1.35, "Color Scale", cex=2, font = 2)
    rect(0.7, 1.2, 0.9, 1.3, col="Green")
    text(0.95, 1.25, "Difference between treatments\n > 2 percentage points", pos = 4, font = 2)
    rect(0.7, 1.1, 0.9, 1.2, col="palegreen")
    text(0.95, 1.15, "Difference between treatments\n > 0 and ≤ 2 percentage points", pos = 4, font = 2)
    rect(0.7, 1.0, 0.9, 1.1, col="khaki")
    text(0.95, 1.05, "Difference between treatments\n = 0 percentage points", pos = 4, font = 2)
    rect(0.7, 0.9, 0.9, 1.0, col="indianred1")
    text(0.95, 0.95, "Difference between treatments\n < 0 and ≥ -2 percentage points", pos = 4, font = 2)
    rect(0.7, 0.8, 0.9, 0.9, col="Red")
    text(0.95, 0.85, "Difference between treatments\n < -2 percentage points", pos = 4, font = 2)
  })
  
  
})