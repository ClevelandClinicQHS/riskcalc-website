require(shiny)



#####MI
## Intensive
MI.Intensive.Fit <- expression({
  lp <- -2.9048696 + 0.22407762 * (SMOKE_3CAT == "Former") + 1.2029369 * (SMOKE_3CAT == "Current") + 0.40638478 * (ASPIRIN == "Yes") - 0.012493289 * EGFR + 0.036259773 * AGE + 0.8894328 * (SUB_CLINICALCVD == "Yes") + 0.0061008119 * CHR - 0.019691143 * HDL + 0.049161296 * UMALCR - 4.8700871e-05 * max(UMALCR - 4.08, 0)**3 + 5.346339e-05 * max(UMALCR - 9.57, 0)**3 - 4.7625184e-06 * max(UMALCR - 65.71, 0)**3;
  1-(0.9823819^(exp(lp)))
})
## Standard
MI.Standard.Fit <- expression({
  lp <- -8.6149583 - 0.47817601 * (INCLUSIONFRS == "Yes") + 0.4420547 * (SMOKE_3CAT == "Former") + 1.1348434 * (SMOKE_3CAT == "Current") + 0.026029893 * EGFR + 1.5391332 * SCREAT + 0.074622895 * AGE + 0.66114949 * (SUB_CLINICALCVD == "Yes") - 0.18398209 * (RACE == "White") - 0.51224455 * (RACE == "Black") - 0.27825131 * (RACE == "Hispanic") + 0.0071121936 * CHR - 0.02247639 * HDL;
  1-(0.9759231^(exp(lp)))
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
  lp <-  -9.4166905 + 0.021676884 * EGFR + 1.1084367 * SCREAT + 0.060746054 * AGE + 0.017472017 * GLUR + 0.064874796 * UMALCR - 6.2585691e-05 * max(UMALCR - 4.05, 0)**3 + 6.8304787e-05 * max(UMALCR - 9.41, 0)**3 - 5.7190962e-06 * max(UMALCR - 68.066, 0)**3;
  1-(0.9869259^(exp(lp)))
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
  lp <- -2.9016602 - 1.1948194 * (INCLUSIONFRS == "Yes") + 0.026940212 * SBP + 0.23101875 * N_AGENTS + 0.26864514 * (SMOKE_3CAT == "Former") + 0.79529688 * (SMOKE_3CAT == "Current") - 0.02463086 * EGFR + 0.71078674 * SCREAT - 0.83441919 * (SUB_CKD == "Yes") + 0.077096624 * AGE + 0.74279622 * (FEMALE == "Male") + 0.78559824 * (SUB_CLINICALCVD == "Yes") + 0.01155035 * GLUR - 0.031440008 * HDL - 0.0014196837 * TRR + 0.00071728057 * UMALCR - 0.183794 * BMI + 0.0013293612 * max(BMI - 23.418849, 0)**3 - 0.00218836 * max(BMI - 28.993382, 0)**3 + 0.0008589988 * max(BMI - 37.620364, 0)**3;
  1-(0.9949521^(exp(lp)))
})
## Standard
CV.Death.Standard.Fit <- expression({
  lp <-  -11.578656 - 0.68750304 * (INCLUSIONFRS == "Yes") + 0.03475262 * DBP + 0.24641799 * N_AGENTS + 0.52432301 * (SMOKE_3CAT == "Former") + 0.82133082 * (SMOKE_3CAT == "Current") + 0.015961116 * EGFR + 1.187243 * SCREAT + 0.085162101 * AGE + 0.68600507 * (FEMALE == "Male") + 0.74985161 * (SUB_CLINICALCVD == "Yes") + 0.55839265 * (SUB_SUBCLINICALCVD == "Yes") + 0.010873748 * CHR - 0.030284894 * HDL + 0.036753622 * UMALCR - 3.5018692e-05 * max(UMALCR - 4.05, 0)**3 + 3.8218708e-05 * max(UMALCR - 9.41, 0)**3 - 3.2000168e-06 * max(UMALCR - 68.066, 0)**3 - 0.048561888 * BMI + 0.45644122 * (STATIN == "Yes");
  1-(0.9903884^(exp(lp)))
})
#####All-Cause Death
## Intensive
All.Death.Intensive.Fit <- expression({
  lp <- -2.3728497 + 0.40345551 * (INCLUSIONFRS == "Yes") + 0.34267418 * (SMOKE_3CAT == "Former") + 0.74137606 * (SMOKE_3CAT == "Current") + 0.59876252 * SCREAT + 0.048961102 * AGE + 0.49254323 * (SUB_CLINICALCVD == "Yes") - 0.0056752463 * CHR + 0.01038787 * HDL + 0.035917287 * UMALCR - 3.4844427e-05 * max(UMALCR - 4.08, 0)**3 + 3.8251906e-05 * max(UMALCR - 9.57, 0)**3 - 3.4074796e-06 * max(UMALCR - 65.71, 0)**3 - 0.07431295 * BMI + 0.00056302635 * max(BMI - 23.418849, 0)**3 - 0.00092683942 * max(BMI - 28.993382, 0)**3 + 0.00036381306 * max(BMI - 37.620364, 0)**3 - 0.49572032 * (STATIN == "Yes");
  1-(0.9689685^(exp(lp)))
})
## Standard
All.Death.Standard.Fit <- expression({
  lp <- -9.6476954 + 0.47160092 * (SMOKE_3CAT == "Former") + 1.1022877 * (SMOKE_3CAT == "Current") + 0.022706893 * EGFR + 1.3856071 * SCREAT + 0.078790094 * AGE + 0.51139286 * (SUB_CLINICALCVD == "Yes") + 0.002324323 * TRR + 0.034905174 * UMALCR - 3.3320281e-05 * max(UMALCR - 4.05, 0)**3 + 3.6365097e-05 * max(UMALCR - 9.41, 0)**3 - 3.0448157e-06 * max(UMALCR - 68.066, 0)**3;
  1-(0.9586049^(exp(lp)))
})
#####Hypotension
## Intensive
Hypo.Intensive.Fit <- expression({
  lp <- 0.96916989 + 0.81674982 * (INCLUSIONFRS == "Yes") - 0.010897797 * SBP + 0.014681601 * DBP + 0.13601972 * N_AGENTS + 0.47419562 * (SMOKE_3CAT == "Former") + 0.79735923 * (SMOKE_3CAT == "Current") - 0.017057312 * EGFR + 0.32558951 * (SUB_CLINICALCVD == "Yes") - 0.018582793 * CHR + 1.6426952e-06 * max(CHR - 141, 0)**3 - 2.9455225e-06 * max(CHR - 187, 0)**3 + 1.3028273e-06 * max(CHR - 245, 0)**3 + 0.007261011 * GLUR + 0.022314225 * HDL + 0.01365782 * TRR - 8.1859821e-07 * max(TRR - 59, 0)**3 + 1.201686e-06 * max(TRR - 106.5, 0)**3 - 3.8308783e-07 * max(TRR - 208, 0)**3 - 0.0004250535 * UMALCR - 0.01580844 * BMI;
  1-(0.9763317^(exp(lp)))
})
## Standard
Hypo.Standard.Fit <- expression({
  lp <- -6.1074949 - 0.7717307 * (INCLUSIONFRS == "Yes") + 0.012589652 * DBP + 0.42343962 * N_AGENTS + 0.82197301 * (NOAGENTS == "Yes") + 0.037979106 * (SMOKE_3CAT == "Former") + 1.0464472 * (SMOKE_3CAT == "Current") + 0.76583413 * (SUB_CKD == "Yes") + 0.042159037 * AGE + 0.83599467 * (FEMALE == "Male") + 0.45909187 * (SUB_CLINICALCVD == "Yes") + 0.016323722 * HDL + 0.00071808673 * UMALCR;
  1-(0.9883312^(exp(lp)))
})
#####Orthostatic Hypotension without dizziness
## Intensive
Hypo.wo.Dizzy.Intensive.Fit <- expression({
  lp <- -2.8908688 + 0.0065139501 * DBP + 0.042331873 * (SMOKE_3CAT == "Former") + 0.1463802 * (SMOKE_3CAT == "Current") + 0.27305355 * SCREAT + 0.029890976 * AGE + 0.051153985 * (RACE == "White") - 0.21681401 * (RACE == "Black") + 0 * (RACE == "Hispanic") + 0.006153867 * GLUR - 0.0010504199 * TRR + 0.00054961668 * UMALCR - 0.014954588 * BMI;
  1-(0.7460572^(exp(lp)))
})
## Standard
Hypo.wo.Dizzy.Standard.Fit <- expression({
  lp <- -0.40220288 + 0.0041838382 * SBP + 0.086831286 * (SMOKE_3CAT == "Former") + 0.54266468 * (SMOKE_3CAT == "Current") + 0.020379517 * AGE + 0.26804583 * (SUB_CLINICALCVD == "Yes") + 0.031281347 * (RACE == "White") - 0.14481382 * (RACE == "Black") + 0 * (RACE == "Hispanic") - 0.017833414 * GLUR + 2.1595212e-05 * max(GLUR - 85, 0)**3 - 3.6838891e-05 * max(GLUR - 97, 0)**3 + 1.5243679e-05 * max(GLUR - 114, 0)**3 - 0.0028643077 * TRR + 1.7540512e-07 * max(TRR - 59, 0)**3 - 2.5483386e-07 * max(TRR - 107, 0)**3 + 7.9428735e-08 * max(TRR - 213, 0)**3 + 0.01529738 * UMALCR - 1.4609365e-05 * max(UMALCR - 4.05, 0)**3 + 1.5944372e-05 * max(UMALCR - 9.41, 0)**3 - 1.3350074e-06 * max(UMALCR - 68.066, 0)**3;
  1-(0.7118317^(exp(lp)))
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
  lp <-  1.4029277 + 0.13961685 * N_AGENTS - 0.086523901 * (SMOKE_3CAT == "Former") + 0.56125971 * (SMOKE_3CAT == "Current") - 0.019532903 * EGFR - 0.89019886 * SCREAT + 0.038350791 * AGE - 0.41107694 * (SUB_CLINICALCVD == "Yes") + 0.54739612 * (SUB_SUBCLINICALCVD == "Yes") - 0.56907309 * (RACE == "Other") - 0.56907309 * (RACE == "Hispanic") - 0.045889753 * (RACE == "White") - 0.0053355844 * CHR + 0.0004850331 * UMALCR - 0.030702694 * BMI + 0.24817497 * (STATIN == "Yes");
  1-(0.9747857^(exp(lp)))
})
## Standard
Syncope.Standard.Fit <- expression({
  lp <-  -6.1083608 - 0.4650883 * (INCLUSIONFRS == "Yes") + 0.014350322 * SBP - 0.50986998 * (NOAGENTS == "Yes") - 0.085234141 * (SMOKE_3CAT == "Former") + 1.2002921 * (SMOKE_3CAT == "Current") + 0.36761148 * (ASPIRIN == "Yes") + 0.063739113 * AGE + 0.34629581 * (FEMALE == "Male") - 0.73682657 * (RACE == "Other") - 0.73682657 * (RACE == "Hispanic") - 0.07722744 * (RACE == "White") - 0.0031636648 * TRR + 0.26634038 * (STATIN == "Yes");
  1-(0.981569^(exp(lp)))
})
#####Electrolyte Abnormality
## Intensive
Ele.Abn.Intensive.Fit <- expression({
  lp <- -1.6746163 + 0.016646634 * SBP - 0.027794308 * DBP - 0.51925874 * (NOAGENTS == "Yes") + 0.39244314 * (SMOKE_3CAT == "Former") + 0.40457321 * (SMOKE_3CAT == "Current") + 0.016228904 * EGFR + 0.96877103 * SCREAT + 0.35713422 * (SUB_CKD == "Yes") - 1.1856069 * (FEMALE == "Male") + 0.27536214 * (SUB_CLINICALCVD == "Yes") + 0.94771603 * (RACE == "White") + 0.63864609 * (RACE == "Black") + 0 * (RACE == "Hispanic") + 0.00098070175 * UMALCR - 0.037405844 * BMI + 0.2293489 * (STATIN == "Yes");
  1-(0.9730593^(exp(lp)))
})
## Standard
Ele.Abn.Standard.Fit <- expression({
  lp <- -6.3458197 - 0.32000941 * (INCLUSIONFRS == "Yes") + 0.012673514 * SBP + 0.32574293 * N_AGENTS + 0.25484574 * (SMOKE_3CAT == "Former") + 0.40655904 * (SMOKE_3CAT == "Current") + 0.028191564 * AGE - 0.28305738 * (FEMALE == "Male") - 0.54368946 * (SUB_SUBCLINICALCVD == "Yes") + 2.489632 * (RACE == "White") + 2.508559 * (RACE == "Black") + 0 * (RACE == "Hispanic") + 0.012979483 * HDL + 0.034138215 * UMALCR - 3.2275715e-05 * max(UMALCR - 4.05, 0)**3 + 3.5225078e-05 * max(UMALCR - 9.41, 0)**3 - 2.9493629e-06 * max(UMALCR - 68.066, 0)**3 - 0.027440599 * BMI - 0.43424862 * (STATIN == "Yes");
  1-(0.9812803^(exp(lp)))
})
#####Injurious Falls
## Intensive
Falls.Intensive.Fit <- expression({
  lp <- -2.936705 + 0.12552176 * N_AGENTS - 0.0075807149 * EGFR + 0.08538657 * AGE - 0.45670456 * (FEMALE == "Male") + 0.35292165 * (RACE == "White") + 0.030745146 * (RACE == "Black") + 0 * (RACE == "Hispanic") - 0.0060942357 * CHR - 0.012091497 * GLUR + 0.012618643 * HDL + 0.0024410413 * TRR - 0.036354963 * BMI;
  1-(0.9831431^(exp(lp)))
})
## Standard
Falls.Standard.Fit <- expression({
  lp <- -11.092099 - 0.64552622 * (INCLUSIONFRS == "Yes") + 0.30856265 * (SMOKE_3CAT == "Former") + 1.4461734 * (SMOKE_3CAT == "Current") + 0.14428859 * AGE + 1.7820499 * (RACE == "White") + 1.1303555 * (RACE == "Black") + 0 * (RACE == "Hispanic");
  1-(0.9861881^(exp(lp)))
})
#####Bradycardia
## Intensive
Brady.Intensive.Fit <- expression({
  lp <- -4.3813094 + 0.22564118 * N_AGENTS + 0.038278641 * (SMOKE_3CAT == "Former") + 0.43505289 * (SMOKE_3CAT == "Current") + 0.46028413 * (ASPIRIN == "Yes") - 0.012920502 * EGFR + 0.051396528 * AGE + 0.46634844 * (FEMALE == "Male") + 0.73173287 * (SUB_SUBCLINICALCVD == "Yes") + 0.89610649 * (RACE == "White") + 0.79274551 * (RACE == "Black") + 0 * (RACE == "Hispanic");
  1-(0.9840974^(exp(lp)))
})
## Standard
Brady.Standard.Fit <- expression({
  lp <- -5.2767275 - 0.67355236 * (INCLUSIONFRS == "Yes") + 0.40602567 * N_AGENTS + 0.83251577 * (NOAGENTS == "Yes") - 0.0027645568 * (SMOKE_3CAT == "Former") + 0.96602327 * (SMOKE_3CAT == "Current") + 0.74610005 * (SUB_CKD == "Yes") + 0.031349465 * AGE + 0.77468575 * (FEMALE == "Male") + 0.42035922 * (SUB_CLINICALCVD == "Yes") + 1.0500462 * (RACE == "White") + 1.0412021 * (RACE == "Black") + 0 * (RACE == "Hispanic") + 0.01658679 * HDL + 0.00072516681 * UMALCR;
  1-(0.9887822^(exp(lp)))
})
#####Incidence Albuminuria
##  Intensive
Albumin.Intensive.Fit <- expression({
  lp <- 1.4693104 - 0.016482871 * EGFR + 0.12967866 * UMALCR - 0.034101844 * BMI;
  (0.9321196^(exp(lp)))
})
## Standard
Albumin.Standard.Fit <- expression({
  lp <- -1.3881199 - 0.015509878 * SBP + 0.18677566 * N_AGENTS + 1.0621287 * SCREAT + 0.02204398 * AGE - 0.26278989 * (FEMALE == "Male") + 0.25231037 * (SUB_CLINICALCVD == "Yes") + 0.13233468 * UMALCR;
  (0.9202132^(exp(lp)))
})
#####Acute Kidney Disease
Kidney.Intensive.Fit <- expression({
  lp <- ifelse(SUB_CKD == "Yes", 1.3229872 - 0.031253785 * DBP + 0.42632461 * N_AGENTS - 0.065907938 * EGFR + 0.021694587 * HDL + 0.072619838 * BMI, -2.5411648 + 0.029720618 * SBP - 0.027635234 * DBP - 0.25401197 * (SMOKE_3CAT == "Former") - 0.23153925 * (SMOKE_3CAT == "Current") + 0.07134613 * UMALCR - 0.00012854918 * max(UMALCR - 4.006, 0)**3 + 0.00014675644 * max(UMALCR - 8.78, 0)**3 - 1.8207257e-05 * max(UMALCR - 42.486, 0)**3);
  ifelse(SUB_CKD == "Yes", 1-(0.9915901^(exp(lp))), 1-(0.9596302^(exp(lp))))
})
## Standard
Kidney.Standard.Fit <- expression({
  lp <- ifelse(SUB_CKD == "Yes", 22.335648 + 2.2127079 * (INCLUSIONFRS == "Yes") + 0.069783296 * SBP - 0.12176667 * DBP - 0.16154312 * EGFR - 0.11855138 * AGE + 0.016616461 * CHR - 0.04424519 * GLUR - 0.10971121 * HDL - 0.028121456 * TRR + 0.0022527386 * UMALCR + 0.084387567 * BMI, -1.0031483 - 0.72306128 * (INCLUSIONFRS == "Yes") + 0.053818537 * SBP - 0.036408013 * DBP - 0.12870016 * (SMOKE_3CAT == "Former") + 0.94865741 * (SMOKE_3CAT == "Current") - 0.65076176 * (ASPIRIN == "Yes") - 0.045291969 * EGFR + 0.075396612 * UMALCR - 0.00014668629 * max(UMALCR - 4.021, 0)**3 + 0.00016554733 * max(UMALCR - 8.505, 0)**3 - 1.8861047e-05 * max(UMALCR - 43.378, 0)**3);
  ifelse(SUB_CKD == "Yes", 1-(0.9998514^(exp(lp))), 1-(0.9916444^exp(lp)))
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

cex.intensive <- function(input.intensive, input.standard){
  diff <- input.intensive-input.standard
  cex.cell <- ifelse(diff > 0 & diff <= 0.2, 2.1, 
                   ifelse(diff > 0.2 & diff <= 0.4, 2.2, 
                   ifelse(diff > 0.4 & diff <= 0.6, 2.3, 
                   ifelse(diff > 0.6 & diff <= 0.8, 2.4, 
                   ifelse(diff > 0.8 & diff <= 1, 2.5, 
                   ifelse(diff > 1 & diff <= 1.5, 2.6,
                   ifelse(diff > 1.5 & diff <= 2, 2.8,
                   ifelse(diff > 2 & diff <= 2.5, 3,
                   ifelse(diff > 2.5 & diff <= 3, 3.2,
                   ifelse(diff > 3 & diff <= 3.5, 3.4,
                   ifelse(diff > 3.5 & diff <= 4, 3.6,
                   ifelse(diff > 4 & diff <= 10, 3.8,
                   ifelse(diff > 10, 4,
                   ifelse(diff < 0 & diff >= -0.2, 1.9,
                   ifelse(diff < -0.2 & diff >= -0.4, 1.8, 
                   ifelse(diff < -0.4 & diff >= -0.6, 1.7,
                   ifelse(diff < -0.6 & diff >= -0.8, 1.6,
                   ifelse(diff < -0.8 & diff >= -1, 1.5,
                   ifelse(diff < -1 & diff >= -1.5, 1.4,
                   ifelse(diff < -1.5 & diff >= -2, 1.2,
                   ifelse(diff < -2 & diff >= -2.5, 1,
                   ifelse(diff < -2.5 & diff >= -3, 0.8,
                   ifelse(diff < -3, 0.75, 2)))))))))))))))))))))))
    
    return(cex.cell)
}
cex.standad <- function(input.intensive, input.standard){
  diff <- input.standard-input.intensive
  cex.cell <- ifelse(diff > 0 & diff <= 0.2, 2.1, 
                          ifelse(diff > 0.2 & diff <= 0.4, 2.2, 
                                 ifelse(diff > 0.4 & diff <= 0.6, 2.3, 
                                        ifelse(diff > 0.6 & diff <= 0.8, 2.4, 
                                               ifelse(diff > 0.8 & diff <= 1, 2.5, 
                                                      ifelse(diff > 1 & diff <= 1.5, 2.6,
                                                             ifelse(diff > 1.5 & diff <= 2, 2.8,
                                                                    ifelse(diff > 2 & diff <= 2.5, 3,
                                                                           ifelse(diff > 2.5 & diff <= 3, 3.2,
                                                                                  ifelse(diff > 3 & diff <= 3.5, 3.4,
                                                                                         ifelse(diff > 3.5 & diff <= 4, 3.6,
                                                                                                ifelse(diff > 4 & diff <= 10, 3.8,
                                                                                                       ifelse(diff > 10, 4,
                                                                                                              ifelse(diff < 0 & diff >= -0.2, 1.9,
                                                                                                                     ifelse(diff < -0.2 & diff >= -0.4, 1.8, 
                                                                                                                            ifelse(diff < -0.4 & diff >= -0.6, 1.7,
                                                                                                                                   ifelse(diff < -0.6 & diff >= -0.8, 1.6,
                                                                                                                                          ifelse(diff < -0.8 & diff >= -1, 1.5,
                                                                                                                                                 ifelse(diff < -1 & diff >= -1.5, 1.4,
                                                                                                                                                        ifelse(diff < -1.5 & diff >= -2, 1.2,
                                                                                                                                                               ifelse(diff < -2 & diff >= -2.5, 1,
                                                                                                                                                                      ifelse(diff < -2.5 & diff >= -3, 0.8,
                                                                                                                                                                             ifelse(diff < -3, 0.75, 2)))))))))))))))))))))))
  
  return(cex.cell)
}

sprint.major.plot <- function(all.death.intensive, all.death.standard, cv.death.intensive, cv.death.standard, stroke.intensive, stroke.standard, hf.intensive, hf.standard, mi.intensive, mi.standard, acs.intensive, acs.standard, kidney.intensive, kidney.standard){
  par(mar=c(10, 0.1, 2, 0.1))
  plot(1, 1, xaxt="n", yaxt="n", type="n", xlab="", ylab="", xaxs = "i", yaxs="i")#xaxt="n", yaxt="n", 
  abline(v = c(0.9, 1.15))
  abline(h = c(1.3, 1.2, 1.1, 1.0, 0.9, 0.8, 0.7, 0.6))
  text(0.75, 1.35, "Outcomes", cex=2, font = 2)
  text(0.75, 1.25, "All-Cause Death", cex=1.25)
  text(0.75, 1.15, "CV Death", cex=1.25)
  text(0.75, 1.05, "Stroke", cex=1.25)
  text(0.75, 0.95, "Heart Failure", cex=1.25)
  text(0.75, 0.85, "Myocardial Infarction", cex=1.25)
  text(0.75, 0.75, "Acute Coronary\n Syndrome", cex=1.25)
  text(0.75, 0.65, "Acute Kidney Disease", cex=1.25)
  #All-Cuase Death
  all.death.intensive.r <- round(all.death.intensive*100, 1)
  all.death.standard.r <- round(all.death.standard*100, 1)
  rect(0.9, 1.2, 1.15, 1.3, col=color.intensive(all.death.intensive.r, all.death.standard.r))
  text(1.025, 1.25, paste(ifelse(all.death.intensive <0.001, "<0.1", all.death.intensive.r), "%", sep=""), cex=cex.intensive(all.death.intensive.r, all.death.standard.r))
  rect(1.15, 1.2, 1.4, 1.3, col=color.standard(all.death.intensive.r, all.death.standard.r))
  text(1.275, 1.25, paste(ifelse(all.death.standard <0.001, "<0.1", all.death.standard.r), "%", sep=""),  cex=cex.standad(all.death.intensive.r, all.death.standard.r))
  #CV Death
  cv.death.intensive.r <- round(cv.death.intensive*100, 1)
  cv.death.standard.r <- round(cv.death.standard*100, 1)
  rect(0.9, 1.1, 1.15, 1.2, col=color.intensive(cv.death.intensive.r, cv.death.standard.r))
  text(1.025, 1.15, paste(ifelse(cv.death.intensive <0.001, "<0.1", cv.death.intensive.r), "%", sep=""), cex=cex.intensive(cv.death.intensive.r, cv.death.standard.r))
  rect(1.15, 1.1, 1.4, 1.2, col=color.standard(cv.death.intensive.r, cv.death.standard.r))
  text(1.275, 1.15, paste(ifelse(cv.death.standard <0.001, "<0.1", cv.death.standard.r), "%", sep=""),  cex=cex.standad(cv.death.intensive.r, cv.death.standard.r))
  #Stroke
  stroke.intensive.r <- round(stroke.intensive*100, 1)
  stroke.standard.r <- round(stroke.standard*100, 1)
  rect(0.9, 1, 1.15, 1.1, col=color.intensive(stroke.intensive.r, stroke.standard.r))
  text(1.025, 1.05, paste(ifelse(stroke.intensive <0.001, "<0.1", stroke.intensive.r), "%", sep=""), cex=cex.intensive(stroke.intensive.r, stroke.standard.r))
  rect(1.15, 1, 1.4, 1.1, col=color.standard(stroke.intensive.r, stroke.standard.r))
  text(1.275, 1.05, paste(ifelse(stroke.standard <0.001, "<0.1", stroke.standard.r), "%", sep=""),  cex=cex.standad(stroke.intensive.r, stroke.standard.r))
  #Heart Failure
  hf.intensive.r <- round(hf.intensive*100, 1)
  hf.standard.r <- round(hf.standard*100, 1)
  rect(0.9, 0.9, 1.15, 1, col=color.intensive(hf.intensive.r, hf.standard.r))
  text(1.025, 0.95, paste(ifelse(hf.intensive <0.001, "<0.1", hf.intensive.r), "%", sep=""), cex=cex.intensive(hf.intensive.r, hf.standard.r))
  rect(1.15, 0.9, 1.4, 1, col=color.standard(hf.intensive.r, hf.standard.r))
  text(1.275, 0.95, paste(ifelse(hf.standard <0.001, "<0.1", hf.standard.r), "%", sep=""),  cex=cex.standad(hf.intensive.r, hf.standard.r))
  #MI
  mi.intensive.r <- round(mi.intensive*100, 1)
  mi.standard.r <- round(mi.standard*100, 1)
  rect(0.9, 0.8, 1.15, 0.9, col=color.intensive(mi.intensive.r, mi.standard.r))
  text(1.025, 0.85, paste(ifelse(mi.intensive <0.001, "<0.1", mi.intensive.r), "%", sep=""), cex=cex.intensive(mi.intensive.r, mi.standard.r))
  rect(1.15, 0.8, 1.4, 0.9, col=color.standard(mi.intensive.r, mi.standard.r))
  text(1.275, 0.85, paste(ifelse(mi.standard <0.001, "<0.1", mi.standard.r), "%", sep=""),  cex=cex.standad(mi.intensive.r, mi.standard.r))
  #ACS
  acs.intensive.r <- round(acs.intensive*100, 1)
  acs.standard.r <- round(acs.standard*100, 1)
  rect(0.9, 0.7, 1.15, 0.8, col=color.intensive(acs.intensive.r, acs.standard.r))
  text(1.025, 0.75, paste(ifelse(acs.intensive <0.001, "<0.1", acs.intensive.r), "%", sep=""), cex=cex.intensive(acs.intensive.r, acs.standard.r))
  rect(1.15, 0.7, 1.4, 0.8, col=color.standard(acs.intensive.r, acs.standard.r))
  text(1.275, 0.75, paste(ifelse(acs.standard <0.001, "<0.1", acs.standard.r), "%", sep=""),  cex=cex.standad(acs.intensive.r, acs.standard.r))
  #Acute Kidney Disease
  kidney.intensive.r <- round(kidney.intensive*100, 1)
  kidney.standard.r <- round(kidney.standard*100, 1)
  rect(0.9, 0.6, 1.15, 0.7, col=color.intensive(kidney.intensive.r, kidney.standard.r))
  text(1.025, 0.65, paste(ifelse(kidney.intensive <0.001, "<0.1", kidney.intensive.r), "%", sep=""), cex=cex.intensive(kidney.intensive.r, kidney.standard.r))
  rect(1.15, 0.6, 1.4, 0.7, col=color.standard(kidney.intensive.r, kidney.standard.r))
  text(1.275, 0.65, paste(ifelse(kidney.standard <0.001, "<0.1", kidney.standard.r), "%", sep=""),  cex=cex.standad(kidney.intensive.r, kidney.standard.r))
  
  add.intensive <- sum(mi.intensive, acs.intensive, stroke.intensive, hf.intensive, cv.death.intensive, all.death.intensive, kidney.intensive)/7
  add.standard <-  sum(mi.standard,  acs.standard,  stroke.standard,  hf.standard,  cv.death.standard,  all.death.standard,  kidney.standard)/7
  
  rect(0.9, 1.3, 1.15, 1.4, col=ifelse(add.intensive > add.standard, "Red", ifelse(add.intensive < add.standard, "Green", "khaki")))
  text(1.025, 1.37, "Intensive", cex=2, font=2)
  text(1.025, 1.325, "(SBP: < 120mm Hg)", cex=1)
  rect(1.15, 1.3, 1.4, 1.4, col=ifelse(add.intensive > add.standard, "Green", ifelse(add.intensive < add.standard, "Red", "khaki")))
  text(1.275, 1.37, "Standard", cex=2, font=2)
  text(1.275, 1.325, "(SBP: < 140mm Hg)", cex=1)
  
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
  text(0.75, 0.90625, "Othostatic \nHypotension\n with Dizziness", cex=1.5)
  text(0.75, 0.81875, "Bradycardia", cex=1.5)
  text(0.75, 0.73125, "Incident Albuminuria", cex=1.5)
  text(0.75, 0.64375, "Othostatic \nHypotension\n without Dizziness", cex=1.5)
  #syncope
  syncope.intensive.r <- round(syncope.intensive*100, 1)
  syncope.standard.r <- round(syncope.standard*100, 1)
  rect(0.9, 1.2125, 1.15, 1.3, col=color.intensive(syncope.intensive.r, syncope.standard.r))
  text(1.025, 1.25625, paste(ifelse(syncope.intensive <0.001, "<0.1", syncope.intensive.r), "%", sep=""), cex=cex.intensive(syncope.intensive.r, syncope.standard.r))
  rect(1.15, 1.2125, 1.4, 1.3, col=color.standard(syncope.intensive.r, syncope.standard.r))
  text(1.275, 1.25625, paste(ifelse(syncope.standard <0.001, "<0.1", syncope.standard.r), "%", sep=""),  cex=cex.standad(syncope.intensive.r, syncope.standard.r))
  #Injurious Falls
  fall.intensive.r <- round(fall.intensive*100, 1)
  fall.standard.r <- round(fall.standard*100, 1)
  rect(0.9, 1.125, 1.15, 1.2125, col=color.intensive(fall.intensive.r, fall.standard.r))
  text(1.025, 1.16875, paste(ifelse(fall.intensive <0.001, "<0.1", fall.intensive.r), "%", sep=""), cex=cex.intensive(fall.intensive.r, fall.standard.r))
  rect(1.15, 1.125, 1.4, 1.2125, col=color.standard(fall.intensive.r, fall.standard.r))
  text(1.275, 1.16875, paste(ifelse(fall.standard <0.001, "<0.1", fall.standard.r), "%", sep=""),   cex=cex.standad(fall.intensive.r, fall.standard.r))
  #Electrolyte Abnormality
  ele.abn.intensive.r <- round(ele.abn.intensive*100, 1)
  ele.abn.standard.r <- round(ele.abn.standard*100, 1)
  rect(0.9, 1.0375, 1.15, 1.125, col=color.intensive(ele.abn.intensive.r, ele.abn.standard.r))
  text(1.025, 1.08125, paste(ifelse(ele.abn.intensive <0.001, "<0.1", ele.abn.intensive.r), "%", sep=""), cex=cex.intensive(ele.abn.intensive.r, ele.abn.standard.r))
  rect(1.15, 1.0375, 1.4, 1.125, col=color.standard(ele.abn.intensive.r, ele.abn.standard.r))
  text(1.275, 1.08125, paste(ifelse(ele.abn.standard <0.001, "<0.1", ele.abn.standard.r), "%", sep=""),  cex=cex.standad(ele.abn.intensive.r, ele.abn.standard.r))
  #Hypotension
  hypo.intensive.r <- round(hypo.intensive*100, 1)
  hypo.standard.r <- round(hypo.standard*100, 1)
  rect(0.9, 0.95, 1.15, 1.0375, col=color.intensive(hypo.intensive.r, hypo.standard.r))
  text(1.025, 0.99375, paste(ifelse(hypo.intensive <0.001, "<0.1", hypo.intensive.r), "%", sep=""), cex=cex.intensive(hypo.intensive.r, hypo.standard.r))
  rect(1.15, 0.95, 1.4, 1.0375, col=color.standard(hypo.intensive.r, hypo.standard.r))
  text(1.275, 0.99375, paste(ifelse(hypo.standard <0.001, "<0.1", hypo.standard.r), "%", sep=""),  cex=cex.standad(hypo.intensive.r, hypo.standard.r))
  #Orthostatic Hypotension with dizziness
  hypo.w.dizzy.intensive.r <- round(hypo.w.dizzy.intensive*100, 1)
  hypo.w.dizzy.standard.r <- round(hypo.w.dizzy.standard*100, 1)
  rect(0.90, 0.8625, 1.15, 0.95, col=color.intensive(hypo.w.dizzy.intensive.r, hypo.w.dizzy.standard.r))
  text(1.025, 0.90625, paste(ifelse(hypo.w.dizzy.intensive <0.001, "<0.1", hypo.w.dizzy.intensive.r), "%", sep=""), cex=cex.intensive(hypo.w.dizzy.intensive.r, hypo.w.dizzy.standard.r))
  rect(1.15, 0.8625, 1.4, 0.95, col=color.standard(hypo.w.dizzy.intensive.r, hypo.w.dizzy.standard.r))
  text(1.275, 0.90625, paste(ifelse(hypo.w.dizzy.standard <0.001, "<0.1", hypo.w.dizzy.standard.r), "%", sep=""),  cex=cex.standad(hypo.w.dizzy.intensive.r, hypo.w.dizzy.standard.r))
  #Bradycardia
  bradycardia.intensive.r <- round(bradycardia.intensive*100, 1)
  bradycardia.standard.r <- round(bradycardia.standard*100, 1)
  rect(0.9, 0.775, 1.15, 0.8625, col=color.intensive(bradycardia.intensive.r, bradycardia.standard.r))
  text(1.025, 0.81875, paste(ifelse(bradycardia.intensive <0.001, "<0.1", bradycardia.intensive.r), "%", sep=""), cex=cex.intensive(bradycardia.intensive.r, bradycardia.standard.r))
  rect(1.15, 0.775, 1.4, 0.8625, col=color.standard(bradycardia.intensive.r, bradycardia.standard.r))
  text(1.275, 0.81875, paste(ifelse(bradycardia.standard <0.001, "<0.1", bradycardia.standard.r), "%", sep=""),   cex=cex.standad(bradycardia.intensive.r, bradycardia.standard.r))
  #Incident albuminuria
  albumin.intensive.r <- round(albumin.intensive*100, 1)
  albumin.standard.r <- round(albumin.standard*100, 1)
  rect(0.9, 0.6875, 1.15, 0.775, col=color.intensive(albumin.intensive.r, albumin.standard.r))
  text(1.025, 0.73125, paste(ifelse(albumin.intensive <0.001, "<0.1", albumin.intensive.r), "%", sep=""), cex=cex.intensive(albumin.intensive.r, albumin.standard.r))
  rect(1.15, 0.6875, 1.4, 0.775, col=color.standard(albumin.intensive.r, albumin.standard.r))
  text(1.275, 0.73125, paste(ifelse(albumin.standard <0.001, "<0.1", albumin.standard.r), "%", sep=""),  cex=cex.standad(albumin.intensive.r, albumin.standard.r))
  #Orthostatic Hypotension without dizziness
  hypo.wo.dizzy.intensive.r <- round(hypo.wo.dizzy.intensive*100, 1)
  hypo.wo.dizzy.standard.r <- round(hypo.wo.dizzy.standard*100, 1)
  rect(0.9, 0.6, 1.15, 0.6875, col=color.intensive(hypo.wo.dizzy.intensive.r, hypo.wo.dizzy.standard.r))
  text(1.025, 0.64375, paste(ifelse(hypo.wo.dizzy.intensive <0.001, "<0.1", hypo.wo.dizzy.intensive.r), "%", sep=""), cex=cex.intensive(hypo.wo.dizzy.intensive.r, hypo.wo.dizzy.standard.r))
  rect(1.15, 0.6, 1.4, 0.6875, col=color.standard(hypo.wo.dizzy.intensive.r, hypo.wo.dizzy.standard.r))
  text(1.275, 0.64375, paste(ifelse(hypo.wo.dizzy.standard <0.001, "<0.1", hypo.wo.dizzy.standard.r), "%", sep=""),  cex=cex.standad(hypo.wo.dizzy.intensive.r, hypo.wo.dizzy.standard.r))
  
  add.intensive <- sum(hypo.intensive, hypo.wo.dizzy.intensive, hypo.w.dizzy.intensive, syncope.intensive, ele.abn.intensive, albumin.intensive, fall.intensive, bradycardia.intensive)/8
  add.standard <-  sum(hypo.standard,  hypo.wo.dizzy.standard,  hypo.w.dizzy.standard,  syncope.standard,  ele.abn.standard,  albumin.standard,  fall.standard,  bradycardia.standard)/8
  
  rect(0.9, 1.3, 1.15, 1.4, col=ifelse(add.intensive > add.standard, "Red", ifelse(add.intensive < add.standard, "Green", "khaki")))
  text(1.025, 1.37, "Intensive", cex=2, font=2)
  text(1.025, 1.325, "(SBP: < 120mm Hg)", cex=1)
  rect(1.15, 1.3, 1.4, 1.4, col=ifelse(add.intensive > add.standard, "Green", ifelse(add.intensive < add.standard, "Red", "khaki")))
  text(1.275, 1.37, "Standard", cex=2, font=2)
  text(1.275, 1.325, "(SBP: < 140mm Hg)", cex=1)
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
  
  
  
})