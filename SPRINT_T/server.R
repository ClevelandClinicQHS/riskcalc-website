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


gradient.rect <- function (xleft, ybottom, xright, ytop, reds, greens, blues, 
          col = NULL, nslices = 50, gradient = "x", border = par("fg")) 
{
  if (is.null(col)) 
    col <- color.gradient(reds, greens, blues, nslices)
  else nslices <- length(col)
  nrect <- max(unlist(lapply(list(xleft, ybottom, xright, ytop), 
                             length)))
  if (nrect > 1) {
    if (length(xleft) < nrect) 
      xleft <- rep(xleft, length.out = nrect)
    if (length(ybottom) < nrect) 
      ybottom <- rep(ybottom, length.out = nrect)
    if (length(xright) < nrect) 
      xright <- rep(xright, length.out = nrect)
    if (length(ytop) < nrect) 
      ytop <- rep(ytop, length.out = nrect)
    for (i in 1:nrect) gradient.rect(xleft[i], ybottom[i], 
                                     xright[i], ytop[i], reds, greens, blues, col, nslices, 
                                     gradient, border = border)
  }
  else {
    if (gradient == "x") {
      xinc <- (xright - xleft)/nslices
      xlefts <- seq(xleft, xright - xinc, length = nslices)
      xrights <- xlefts + xinc
      rect(xlefts, ybottom, xrights, ytop, col = col, lty = 0)
      rect(xlefts[1], ybottom, xrights[nslices], ytop, 
           border = border)
    }
    else {
      yinc <- (ytop - ybottom)/nslices
      ybottoms <- seq(ybottom, ytop - yinc, length = nslices)
      ytops <- ybottoms + yinc
      rect(xleft, ybottoms, xright, ytops, col = col, lty = 0)
      rect(xleft, ybottoms[1], xright, ytops[nslices], 
           border = border)
    }
  }
  invisible(col)
}

smoothColors <- function (..., alpha = NA) 
{
  args <- list(...)
  r <- g <- b <- NULL
  while (length(args) > 0) {
    if (!is.character(args[[1]])) 
      stop("Usage: smoothColors(\"color name\",[n|\"color name\"],...,\"color name\")")
    arglen <- length(args)
    if (arglen > 1) {
      if (is.numeric(args[[2]])) {
        lastarg <- 2
        while (is.numeric(args[[lastarg]])) {
          lastarg <- lastarg + 1
          if (lastarg > arglen) 
            stop("bad argument list")
        }
        from <- col2rgb(args[[1]])
        too <- col2rgb(args[[lastarg]])
        n <- args[[2]] + 2
        r <- c(r, seq(from[1, ], too[1, ], length = n))
        i <- length(r)
        r <- r[-i]
        g <- c(g, seq(from[2, ], too[2, ], length = n))
        g <- g[-i]
        b <- c(b, seq(from[3, ], too[3, ], length = n))
        b <- b[-i]
        args <- args[-(1:(lastarg - 1))]
      }
      else {
        cc <- col2rgb(args[[1]])
        r <- c(r, cc[1, ])
        g <- c(g, cc[2, ])
        b <- c(b, cc[3, ])
        args <- args[-1]
      }
    }
    else {
      cc <- col2rgb(args[[1]])
      r <- c(r, cc[1, ])
      g <- c(g, cc[2, ])
      b <- c(b, cc[3, ])
      args <- args[-1]
    }
  }
  if (is.na(alpha)) 
    rgb(r, g, b, maxColorValue = 255)
  else rgb(r, g, b, alpha = alpha, maxColorValue = 255)
}


color.table <- data.frame(diff.cat = as.character(c(-100.0, -99.9, -99.8, -99.7, -99.6, -99.5, -99.4, -99.3, -99.2, -99.1, -99.0, -98.9, -98.8, -98.7, -98.6, -98.5, -98.4, -98.3, -98.2, -98.1, -98.0, -97.9, -97.8, -97.7, -97.6, -97.5, -97.4, -97.3, -97.2, -97.1, -97.0, -96.9, -96.8, -96.7, -96.6, -96.5, -96.4, -96.3, -96.2, -96.1, -96.0, -95.9, -95.8, -95.7,  -95.6, -95.5, -95.4, -95.3, -95.2, -95.1, -95.0, -94.9, -94.8, -94.7, -94.6, -94.5, -94.4, -94.3, -94.2, -94.1, -94.0, -93.9, -93.8, -93.7, -93.6, -93.5, -93.4, -93.3, -93.2, -93.1, -93.0, -92.9, -92.8, -92.7, -92.6, -92.5, -92.4, -92.3, -92.2, -92.1, -92.0, -91.9, -91.8, -91.7, -91.6, -91.5, -91.4, -91.3, -91.2, -91.1, -91.0, -90.9, -90.8, -90.7, -90.6, -90.5, -90.4, -90.3, -90.2, -90.1, -90.0, -89.9, -89.8, -89.7, -89.6, -89.5, -89.4, -89.3, -89.2, -89.1,  -89.0, -88.9, -88.8, -88.7, -88.6, -88.5, -88.4, -88.3, -88.2, -88.1, -88.0, -87.9, -87.8, -87.7, -87.6, -87.5, -87.4, -87.3, -87.2, -87.1, -87.0, -86.9, -86.8, -86.7, -86.6, -86.5, -86.4, -86.3, -86.2, -86.1, -86.0, -85.9, -85.8, -85.7, -85.6, -85.5, -85.4, -85.3, -85.2, -85.1, -85.0, -84.9, -84.8, -84.7,  -84.6, -84.5, -84.4, -84.3, -84.2, -84.1, -84.0, -83.9, -83.8, -83.7, -83.6, -83.5, -83.4, -83.3, -83.2, -83.1, -83.0, -82.9, -82.8, -82.7, -82.6, -82.5, -82.4, -82.3, -82.2, -82.1, -82.0, -81.9, -81.8, -81.7, -81.6, -81.5, -81.4, -81.3, -81.2, -81.1, -81.0, -80.9, -80.8, -80.7, -80.6, -80.5, -80.4, -80.3, -80.2, -80.1, -80.0, -79.9, -79.8, -79.7, -79.6, -79.5, -79.4, -79.3, -79.2, -79.1, -79.0, -78.9, -78.8, -78.7, -78.6, -78.5, -78.4, -78.3, -78.2, -78.1, -78.0, -77.9, -77.8, -77.7, -77.6, -77.5, -77.4, -77.3, -77.2, -77.1, -77.0, -76.9, -76.8, -76.7, -76.6, -76.5, -76.4, -76.3, -76.2, -76.1, -76.0, -75.9, -75.8, -75.7, -75.6, -75.5, -75.4, -75.3, -75.2, -75.1, -75.0, -74.9, -74.8, -74.7, -74.6, -74.5, -74.4, -74.3, -74.2, -74.1, -74.0, -73.9, -73.8, -73.7, -73.6, -73.5, -73.4, -73.3, -73.2, -73.1, -73.0, -72.9, -72.8, -72.7, -72.6, -72.5, -72.4, -72.3, -72.2, -72.1, -72.0, -71.9, -71.8, -71.7, -71.6, -71.5, -71.4, -71.3, -71.2, -71.1, -71.0, -70.9, -70.8, -70.7, -70.6, -70.5, -70.4, -70.3, -70.2, -70.1, -70.0, -69.9, -69.8, -69.7, -69.6, -69.5, -69.4, -69.3, -69.2, -69.1, -69.0, -68.9, -68.8, -68.7, -68.6, -68.5, -68.4, -68.3, -68.2, -68.1, -68.0, -67.9, -67.8, -67.7, -67.6, -67.5, -67.4, -67.3, -67.2, -67.1, -67.0, -66.9, -66.8, -66.7, -66.6, -66.5, -66.4, -66.3, -66.2, -66.1, -66.0, -65.9, -65.8, -65.7, -65.6, -65.5, -65.4, -65.3, -65.2, -65.1, -65.0, -64.9,  -64.8, -64.7, -64.6, -64.5, -64.4, -64.3, -64.2, -64.1, -64.0, -63.9, -63.8, -63.7, -63.6, -63.5, -63.4, -63.3, -63.2, -63.1, -63.0, -62.9, -62.8, -62.7, -62.6, -62.5, -62.4, -62.3, -62.2, -62.1, -62.0, -61.9, -61.8, -61.7, -61.6, -61.5, -61.4, -61.3, -61.2, -61.1, -61.0, -60.9, -60.8, -60.7, -60.6, -60.5, -60.4, -60.3, -60.2, -60.1, -60.0, -59.9, -59.8, -59.7, -59.6, -59.5, -59.4, -59.3, -59.2, -59.1, -59.0, -58.9, -58.8, -58.7, -58.6, -58.5, -58.4, -58.3,  -58.2, -58.1, -58.0, -57.9, -57.8, -57.7, -57.6, -57.5, -57.4, -57.3, -57.2, -57.1, -57.0, -56.9, -56.8, -56.7, -56.6, -56.5, -56.4, -56.3, -56.2, -56.1,  -56.0, -55.9, -55.8, -55.7, -55.6, -55.5, -55.4, -55.3, -55.2, -55.1, -55.0, -54.9, -54.8, -54.7, -54.6, -54.5, -54.4, -54.3, -54.2, -54.1, -54.0, -53.9,  -53.8, -53.7, -53.6, -53.5, -53.4, -53.3, -53.2, -53.1, -53.0, -52.9, -52.8, -52.7, -52.6, -52.5, -52.4, -52.3, -52.2, -52.1, -52.0, -51.9, -51.8, -51.7,  -51.6, -51.5, -51.4, -51.3, -51.2, -51.1, -51.0, -50.9, -50.8, -50.7, -50.6, -50.5, -50.4, 
-50.3, -50.2, -50.1, -50.0, -49.9, -49.8, -49.7, -49.6, -49.5, -49.4, -49.3, -49.2, -49.1, -49.0, -48.9, -48.8, -48.7, -48.6, -48.5, -48.4, -48.3, -48.2, -48.1, -48.0, -47.9, -47.8, -47.7, -47.6, -47.5, -47.4, -47.3,  -47.2, -47.1, -47.0, -46.9, -46.8, -46.7, -46.6, -46.5, -46.4, -46.3, -46.2, -46.1, -46.0, -45.9, -45.8, -45.7, -45.6, -45.5, -45.4, -45.3, -45.2, -45.1,  -45.0, -44.9, -44.8, -44.7, -44.6, -44.5, -44.4, -44.3, -44.2, -44.1, -44.0, -43.9, -43.8, -43.7, -43.6, -43.5, -43.4, -43.3, -43.2, -43.1, -43.0, -42.9, -42.8, -42.7, -42.6, -42.5, -42.4, -42.3, -42.2, -42.1, -42.0, -41.9, -41.8, -41.7, -41.6, -41.5, -41.4, -41.3, -41.2, -41.1, -41.0, -40.9, -40.8, -40.7, -40.6, -40.5, -40.4, -40.3, -40.2, -40.1, -40.0, -39.9, -39.8, -39.7, -39.6, -39.5, -39.4, -39.3, -39.2, -39.1, -39.0, -38.9, -38.8, -38.7, -38.6, -38.5,  -38.4, -38.3, -38.2, -38.1, -38.0, -37.9, -37.8, -37.7, -37.6, -37.5, -37.4, -37.3, -37.2, -37.1, -37.0, -36.9, -36.8, -36.7, -36.6, -36.5, -36.4, -36.3,  -36.2, -36.1, -36.0, -35.9, -35.8, -35.7, -35.6, -35.5, -35.4, -35.3, -35.2, -35.1, -35.0, -34.9, -34.8, -34.7, -34.6, -34.5, -34.4, -34.3, -34.2, -34.1, -34.0, -33.9, -33.8, -33.7, -33.6, -33.5, -33.4, -33.3, -33.2, -33.1, -33.0, -32.9, -32.8, -32.7, -32.6, -32.5, -32.4, -32.3, -32.2, -32.1, -32.0, -31.9,  -31.8, -31.7, -31.6, -31.5, -31.4, -31.3, -31.2, -31.1, -31.0, -30.9, -30.8, -30.7, -30.6, -30.5, -30.4, -30.3, -30.2, -30.1, -30.0, -29.9, -29.8, -29.7,  -29.6, -29.5, -29.4, -29.3, -29.2, -29.1, -29.0, -28.9, -28.8, -28.7, -28.6, -28.5, -28.4, -28.3, -28.2, -28.1, -28.0, -27.9, -27.8, -27.7, -27.6, -27.5, -27.4, -27.3, -27.2, -27.1, -27.0, -26.9, -26.8, -26.7, -26.6, -26.5, -26.4, -26.3, -26.2, -26.1, -26.0, -25.9, -25.8, -25.7, -25.6, -25.5, -25.4, -25.3,  -25.2, -25.1, -25.0, -24.9, -24.8, -24.7, -24.6, -24.5, -24.4, -24.3, -24.2, -24.1, -24.0, -23.9, -23.8, -23.7, -23.6, -23.5, -23.4, -23.3, -23.2, -23.1,  -23.0, -22.9, -22.8, -22.7, -22.6, -22.5, -22.4, -22.3, -22.2, -22.1, -22.0, -21.9, -21.8, -21.7, -21.6, -21.5, -21.4, -21.3, -21.2, -21.1, -21.0, -20.9, -20.8, -20.7, -20.6, -20.5, -20.4, -20.3, -20.2, -20.1, -20.0, -19.9, -19.8, -19.7, -19.6, -19.5, -19.4, -19.3, -19.2, -19.1, -19.0, -18.9, -18.8, -18.7, -18.6, -18.5, -18.4, -18.3, -18.2, -18.1, -18.0, -17.9, -17.8, -17.7, -17.6, -17.5, -17.4, -17.3, -17.2, -17.1, -17.0, -16.9, -16.8, -16.7, -16.6, -16.5,  -16.4, -16.3, -16.2, -16.1, -16.0, -15.9, -15.8, -15.7, -15.6, -15.5, -15.4, -15.3, -15.2, -15.1, -15.0, -14.9, -14.8, -14.7, -14.6, -14.5, -14.4, -14.3, -14.2, -14.1, -14.0, -13.9, -13.8, -13.7, -13.6, -13.5, -13.4, -13.3, -13.2, -13.1, -13.0, -12.9, -12.8, -12.7, -12.6, -12.5, -12.4, -12.3, -12.2, -12.1,  -12.0, -11.9, -11.8, -11.7, -11.6, -11.5, -11.4, -11.3, -11.2, -11.1, -11.0, -10.9, -10.8, -10.7, -10.6, -10.5, -10.4, -10.3, -10.2, -10.1, -10.0,  -9.9,  -9.8,  -9.7,  -9.6,  -9.5,  -9.4,  -9.3,  -9.2,  -9.1,  -9.0,  -8.9,  -8.8,  -8.7,  -8.6,  -8.5,  -8.4,  -8.3,  -8.2,  -8.1,  -8.0,  -7.9,  -7.8,  -7.7,  -7.6,  -7.5,  -7.4,  -7.3,  -7.2,  -7.1,  -7.0,  -6.9,  -6.8,  -6.7,  -6.6,  -6.5,  -6.4,  -6.3,  -6.2,  -6.1,  -6.0,  -5.9,  -5.8,  -5.7,  -5.6,  -5.5, -5.4,  -5.3,  -5.2,  -5.1,  -5.0,  -4.9,  -4.8,  -4.7,  -4.6,  -4.5,  -4.4,  -4.3,  -4.2,  -4.1,  -4.0,  -3.9,  -3.8,  -3.7,  -3.6,  -3.5,  -3.4,  -3.3,  -3.2,  -3.1,  -3.0,  -2.9,  -2.8,  -2.7,  -2.6,  -2.5,  -2.4,  -2.3,  -2.2,  -2.1,  -2.0,  -1.9,  -1.8,  -1.7,  -1.6,  -1.5,  -1.4,  -1.3,  -1.2,  -1.1,  -1.0,  -0.9,  -0.8,  -0.7,  -0.6,  -0.5,  -0.4,  -0.3,  
-0.2,  -0.1,  0.0,  0.1,  0.2,  0.3,  0.4,  0.5,  0.6,  0.7,  0.8,  0.9,  1.0,  1.1,  1.2,  1.3,  1.4,  1.5,  1.6,  1.7,  1.8,  1.9,  2.0,  2.1,  2.2,  2.3,  2.4,  2.5,  2.6,  2.7,  2.8,  2.9,  3.0,  3.1,  3.2,  3.3, 3.4,  3.5,  3.6,  3.7,  3.8,  3.9,  4.0,  4.1,  4.2,  4.3,  4.4,  4.5,  4.6,  4.7,  4.8,  4.9,  5.0,  5.1,  5.2,  5.3,  5.4,  5.5, 5.6,  5.7,  5.8,  5.9,  6.0,  6.1,  6.2,  6.3,  6.4,  6.5,  6.6,  6.7,  6.8,  6.9,  7.0,  7.1,  7.2,  7.3,  7.4,  7.5,  7.6,  7.7, 7.8,  7.9,  8.0,  8.1,  8.2,  8.3,  8.4,  8.5,  8.6,  8.7,  8.8,  8.9,  9.0,  9.1,  9.2,  9.3,  9.4,  9.5,  9.6,  9.7,  9.8,  9.9, 10.0,  10.1,  10.2,  10.3,  10.4,  10.5,  10.6,  10.7,  10.8,  10.9,  11.0,  11.1,  11.2,  11.3,  11.4,  11.5,  11.6,  11.7,  11.8,  11.9,  12.0,  12.1, 12.2,  12.3,  12.4,  12.5,  12.6,  12.7,  12.8,  12.9,  13.0,  13.1,  13.2,  13.3,  13.4,  13.5,  13.6,  13.7,  13.8,  13.9,  14.0,  14.1,  14.2,  14.3, 14.4,  14.5,  14.6,  14.7,  14.8,  14.9,  15.0,  15.1,  15.2,  15.3,  15.4,  15.5,  15.6,  15.7,  15.8,  15.9,  16.0,  16.1,  16.2,  16.3,  16.4,  16.5, 16.6,  16.7,  16.8,  16.9,  17.0,  17.1,  17.2,  17.3,  17.4,  17.5,  17.6,  17.7,  17.8,  17.9,  18.0,  18.1,  18.2,  18.3,  18.4,  18.5,  18.6,  18.7,  18.8,  18.9,  19.0,  19.1,  19.2,  19.3,  19.4,  19.5,  19.6,  19.7,  19.8,  19.9,  20.0,  20.1,  20.2,  20.3,  20.4,  20.5,  20.6,  20.7,  20.8,  20.9,  21.0,  21.1,  21.2,  21.3,  21.4,  21.5,  21.6,  21.7,  21.8,  21.9,  22.0,  22.1,  22.2,  22.3,  22.4,  22.5,  22.6,  22.7,  22.8,  22.9,  23.0,  23.1,  23.2,  23.3,  23.4,  23.5,  23.6,  23.7,  23.8,  23.9,  24.0,  24.1,  24.2,  24.3,  24.4,  24.5,  24.6,  24.7,  24.8,  24.9,  25.0,  25.1,  25.2,  25.3, 25.4,  25.5,  25.6,  25.7,  25.8,  25.9,  26.0,  26.1,  26.2,  26.3,  26.4,  26.5,  26.6,  26.7,  26.8,  26.9,  27.0,  27.1,  27.2,  27.3,  27.4,  27.5,  27.6,  27.7,  27.8,  27.9,  28.0,  28.1,  28.2,  28.3,  28.4,  28.5,  28.6,  28.7,  28.8,  28.9,  29.0,  29.1,  29.2,  29.3,  29.4,  29.5,  29.6,  29.7,  29.8,  29.9,  30.0,  30.1,  30.2,  30.3,  30.4,  30.5,  30.6,  30.7,  30.8,  30.9,  31.0,  31.1,  31.2,  31.3,  31.4,  31.5,  31.6,  31.7,  31.8,  31.9,  32.0,  32.1,  32.2,  32.3,  32.4,  32.5,  32.6,  32.7,  32.8,  32.9,  33.0,  33.1,  33.2,  33.3,  33.4,  33.5,  33.6,  33.7,  33.8,  33.9,  34.0,  34.1,  34.2,  34.3,  34.4,  34.5,  34.6,  34.7,  34.8,  34.9,  35.0,  35.1,  35.2,  35.3,  35.4,  35.5,  35.6,  35.7,  35.8,  35.9,  36.0,  36.1,  36.2,  36.3,  36.4,  36.5,  36.6,  36.7,  36.8,  36.9,  37.0,  37.1,  37.2,  37.3,  37.4,  37.5,  37.6,  37.7,  37.8,  37.9,  38.0,  38.1,  38.2,  38.3,  38.4,  38.5,  38.6,  38.7,  38.8,  38.9,  39.0,  39.1,  39.2,  39.3,  39.4,  39.5,  39.6,  39.7,  39.8,  39.9,  40.0,  40.1,  40.2,  40.3,  40.4,  40.5,  40.6,  40.7,  40.8,  40.9,  41.0,  41.1,  41.2,  41.3,  41.4,  41.5,  41.6,  41.7,  41.8,  41.9,  42.0,  42.1,  42.2,  42.3,  42.4,  42.5,  42.6,  42.7,  42.8,  42.9,  43.0,  43.1,  43.2,  43.3,  43.4,  43.5,  43.6,  43.7,  43.8,  43.9,  44.0,  44.1,  44.2,  44.3,  44.4,  44.5,  44.6,  44.7,  44.8,  44.9,  45.0,  45.1,  45.2,  45.3,  45.4,  45.5,  45.6,  45.7,  45.8,  45.9,  46.0,  46.1,  46.2,  46.3,  46.4,  46.5,  46.6,  46.7,  46.8,  46.9,  47.0,  47.1,  47.2,  47.3,  47.4,  47.5,  47.6,  47.7,  47.8,  47.9,  48.0,  48.1,  48.2,  48.3,  48.4,  48.5,  48.6,  48.7,  48.8,  48.9,  49.0,  49.1,  49.2,  49.3,  49.4,  49.5,  49.6,  49.7,  49.8,  49.9,  50.0,  50.1,  50.2,  50.3,  50.4,  50.5,  50.6,  50.7,  50.8,  50.9,  51.0,  51.1,  51.2,  51.3,  51.4,  51.5,  
51.6,  51.7,  51.8,  51.9,  52.0,  52.1,  52.2,  52.3,  52.4,  52.5,  52.6,  52.7,  52.8,  52.9,  53.0,  53.1,  53.2,  53.3,  53.4,  53.5,  53.6,  53.7,  53.8,  53.9,  54.0,  54.1,  54.2,  54.3,  54.4,  54.5,  54.6,  54.7,  54.8,  54.9,  55.0,  55.1,  55.2,  55.3,  55.4,  55.5,  55.6,  55.7,  55.8,  55.9,  56.0,  56.1,  56.2,  56.3,  56.4,  56.5,  56.6,  56.7,  56.8,  56.9,  57.0,  57.1,  57.2,  57.3,  57.4,  57.5,  57.6,  57.7,  57.8,  57.9,  58.0,  58.1,  58.2,  58.3,  58.4,  58.5,  58.6,  58.7,  58.8,  58.9,  59.0,  59.1,  59.2,  59.3,  59.4,  59.5,  59.6,  59.7,  59.8,  59.9,  60.0,  60.1,  60.2,  60.3,  60.4,  60.5,  60.6,  60.7,  60.8,  60.9,  61.0,  61.1,  61.2,  61.3,  61.4,  61.5,  61.6,  61.7,  61.8,  61.9,  62.0,  62.1,  62.2,  62.3,  62.4,  62.5,  62.6,  62.7,  62.8,  62.9,  63.0,  63.1,  63.2,  63.3,  63.4,  63.5,  63.6,  63.7,  63.8,  63.9,  64.0,  64.1,  64.2,  64.3,  64.4,  64.5,  64.6,  64.7,  64.8,  64.9,  65.0,  65.1,  65.2,  65.3,  65.4,  65.5,  65.6,  65.7,  65.8,  65.9,  66.0,  66.1,  66.2,  66.3,  66.4,  66.5,  66.6,  66.7,  66.8,  66.9,  67.0,  67.1,  67.2,  67.3,  67.4,  67.5,  67.6,  67.7,  67.8,  67.9,  68.0,  68.1,  68.2,  68.3,  68.4,  68.5,  68.6,  68.7,  68.8,  68.9,  69.0,  69.1,  69.2,  69.3,  69.4,  69.5,  69.6,  69.7,  69.8,  69.9,  70.0,  70.1,  70.2,  70.3,  70.4,  70.5,  70.6,  70.7,  70.8,  70.9,  71.0,  71.1,  71.2,  71.3,  71.4,  71.5, 71.6,  71.7,  71.8,  71.9,  72.0,  72.1,  72.2,  72.3,  72.4,  72.5,  72.6,  72.7,  72.8,  72.9,  73.0,  73.1,  73.2,  73.3,  73.4,  73.5,  73.6,  73.7,  73.8,  73.9,  74.0,  74.1,  74.2,  74.3,  74.4,  74.5,  74.6,  74.7,  74.8,  74.9,  75.0,  75.1,  75.2,  75.3,  75.4,  75.5,  75.6,  75.7,  75.8,  75.9,  76.0,  76.1,  76.2,  76.3,  76.4,  76.5,  76.6,  76.7,  76.8,  76.9,  77.0,  77.1,  77.2,  77.3,  77.4,  77.5,  77.6,  77.7,  77.8,  77.9,  78.0,  78.1,   78.2,  78.3,  78.4,  78.5,  78.6,  78.7,  78.8,  78.9,  79.0,  79.1,  79.2,  79.3,  79.4,  79.5,  79.6,  79.7,  79.8,  79.9,  80.0,  80.1,  80.2,  80.3, 80.4,  80.5,  80.6,  80.7,  80.8,  80.9,  81.0,  81.1,  81.2,  81.3,  81.4,  81.5,  81.6,  81.7,  81.8,  81.9,  82.0,  82.1,  82.2,  82.3,  82.4,  82.5, 82.6,  82.7,  82.8,  82.9,  83.0,  83.1,  83.2,  83.3,  83.4,  83.5,  83.6,  83.7,  83.8,  83.9,  84.0,  84.1,  84.2,  84.3,  84.4,  84.5,  84.6,  84.7, 84.8,  84.9,  85.0,  85.1,  85.2,  85.3,  85.4,  85.5,  85.6,  85.7,  85.8,  85.9,  86.0,  86.1,  86.2,  86.3,  86.4,  86.5,  86.6,  86.7,  86.8,  86.9,  87.0,  87.1,  87.2,  87.3,  87.4,  87.5,  87.6,  87.7,  87.8,  87.9,  88.0,  88.1,  88.2,  88.3,  88.4,  88.5,  88.6,  88.7,  88.8,  88.9,  89.0,  89.1, 89.2,  89.3,  89.4,  89.5,  89.6,  89.7,  89.8,  89.9,  90.0,  90.1,  90.2,  90.3,  90.4,  90.5,  90.6,  90.7,  90.8,  90.9,  91.0,  91.1,  91.2,  91.3,  91.4,  91.5,  91.6,  91.7,  91.8,  91.9,  92.0,  92.1,  92.2,  92.3,  92.4,  92.5,  92.6,  92.7,  92.8,  92.9,  93.0,  93.1,  93.2,  93.3,  93.4,  93.5,  93.6,  93.7,  93.8,  93.9,  94.0,  94.1,  94.2,  94.3,  94.4,  94.5,  94.6,  94.7,  94.8,  94.9,  95.0,  95.1,  95.2,  95.3,  95.4,  95.5,  95.6,  95.7,  95.8,  95.9,  96.0,  96.1,  96.2,  96.3,  96.4,  96.5,  96.6,  96.7,  96.8,  96.9,  97.0,  97.1,  97.2,  97.3,  97.4,  97.5,  97.6,  97.7,  97.8,  97.9,  98.0,  98.1,  98.2,  98.3,  98.4,  98.5,  98.6,  98.7,  98.8,  98.9,  99.0,  99.1,  99.2,  99.3,  99.4,  99.5,  99.6,  99.7,  99.8,  99.9, 100.0)),
                          color = rep(c("gray100", "gray99", "gray98", "gray97", "gray96", "gray95", "gray94", "gray93", "gray92", "gray91", "gray90", "gray89", "gray87", "gray86", "gray85", "gray84", "gray83", "gray82", "gray81", "gray80", "gray79", "gray78", "gray77", "gray76", "gray75", "gray74", "gray73", "gray72", "gray71", "gray70", "gray69", "gray68", "gray67", "gray66", "gray65", "gray64", "gray63", "gray63", "gray62", "gray61", "gray60", "gray59", "gray58", "gray57", "gray56", "gray55", "gray54", "gray53", "gray52", "gray51", "gray50", "gray49", "gray48", "gray47", "gray46", "gray45", "gray44", "gray43", "gray42", "gray41", "gray40", "gray39", "gray38", "gray37", "gray36", "gray35", "gray34", "gray33", "gray32", "gray31", "gray30", "gray29", "gray28", "gray27", "gray26", "gray25", "gray24", "gray23", "gray22", "gray21", "gray20", "gray19", "gray18", "gray17", "gray16", "gray15", "gray14", "gray13", "gray12", "gray11", "gray10", "gray9", "gray8", "gray7", "gray6", "gray5", "gray4", "gray3", "gray2", "gray1", "gray0"), 
                                      c(750,       50,       20,       20,       20,       20,       20,       20,       20,       20,       1,         1,         1,         1,         1,         1,         1,   1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        1,        20,      20,      20,      20,      20,      20,      20,      20,      50,      750)))


color.intensive <- function(input.intensive, input.standard){
  diff <- input.intensive-input.standard
  cell.color <- as.character(color.table[color.table$diff.cat == diff,]$color)
  return(cell.color)
}
color.standard <- function(input.intensive, input.standard){
  diff <- input.standard-input.intensive
  cell.color <- as.character(color.table[color.table$diff.cat == diff,]$color)
  return(cell.color)
}

sprint.plot <- function(mi.intensive, mi.standard, acs.intensive, acs.standard, stroke.intensive, stroke.standard, hf.intensive, hf.standard, cv.death.intensive, cv.death.standard, all.death.intensive, all.death.standard, hypo.intensive, hypo.standard, hypo.wo.dizzy.intensive, hypo.wo.dizzy.standard, hypo.w.dizzy.intensive, hypo.w.dizzy.standard, syncope.intensive, syncope.standard, ele.abn.intensive, ele.abn.standard, albumin.intensive, albumin.standard, kidney.intensive, kidney.standard, fall.intensive, fall.standard, bradycardia.intensive, bradycardia.standard){
  par(mar=c(0.1, 5, 0.1, 5))
  plot(1, 1, xaxt="n", yaxt="n", type="n", xlab="", ylab="", xaxs = "i", yaxs="i")#
  rect(0.6, 0.6, 1.4, 1.4, col="lightskyblue1")
  abline(v = c(0.875, 1.1375))
  abline(h = c(0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95, 1.00, 1.05, 1.10, 1.15, 1.20, 1.25, 1.30, 1.35))
  text(0.7375, 1.375, "Outcomes", cex=2, font = 2)
  text(0.7375, 1.325, "Myocardial Infarction")
  text(0.7375, 1.275, "Acute Coronary Syndrome")
  text(0.7375, 1.225, "Stroke")
  text(0.7375, 1.175, "Heart Failure")
  text(0.7375, 1.125, "CV Death")
  text(0.7375, 1.075, "All-Cause Death")
  text(0.7375, 1.025, "Hypotension")
  text(0.7375, 0.975, "Othostatic Hypotension\n without Dizziness")
  text(0.7375, 0.925, "Othostatic Hypotension\n with Dizziness")
  text(0.7375, 0.875, "Syncope")
  text(0.7375, 0.825, "Electrolyte Abnormality")
  text(0.7375, 0.775, "Incident Albuminuria")
  text(0.7375, 0.725, "Acute Kidney Disease")
  text(0.7375, 0.675, "Injurious Falls")
  text(0.7375, 0.625, "Bradycardia")
  
  #MI
  mi.intensive.r <- round(mi.intensive*100, 1)
  mi.standard.r <- round(mi.standard*100, 1)
  rect(0.875, 1.3, 1.1375, 1.35, col=color.intensive(mi.intensive.r, mi.standard.r))
  text(1.00625, 1.325, paste(ifelse(mi.intensive <0.001, "<0.1", mi.intensive.r), "%", sep=""), cex=ifelse(mi.intensive > mi.standard, (mi.intensive-mi.standard)+1, 1-abs(mi.intensive-mi.standard)), col=ifelse(mi.intensive.r-mi.standard.r >= 4, "white", "Black"))
  rect(1.1375, 1.3, 1.4, 1.35, col=color.standard(mi.intensive.r, mi.standard.r))
  text(1.26875, 1.325, paste(ifelse(mi.standard <0.001, "<0.1", mi.standard.r), "%", sep=""),  cex=ifelse(mi.standard > mi.intensive, (mi.standard-mi.intensive)+1, 1-abs(mi.standard-mi.intensive)), col=ifelse(mi.standard.r-mi.intensive.r >= 4, "White", "Black"))
  
  #ACS
  acs.intensive.r <- round(acs.intensive*100, 1)
  acs.standard.r <- round(acs.standard*100, 1)
  rect(0.875, 1.25, 1.1375, 1.3, col=color.intensive(acs.intensive.r, acs.standard.r))
  text(1.00625, 1.275, paste(ifelse(acs.intensive <0.001, "<0.1", acs.intensive.r), "%", sep=""), cex=ifelse(acs.intensive > acs.standard, (acs.intensive-acs.standard)+1, 1-abs(acs.intensive-acs.standard)), col=ifelse(acs.intensive.r-acs.standard.r >= 4, "white", "Black"))
  rect(1.1375, 1.25, 1.4, 1.3, col=color.standard(acs.intensive.r, acs.standard.r))
  text(1.26875, 1.275, paste(ifelse(acs.standard <0.001, "<0.1", acs.standard.r), "%", sep=""),  cex=ifelse(acs.standard > acs.intensive, (acs.standard-acs.intensive)+1, 1-abs(acs.standard-acs.intensive)), col=ifelse(acs.standard.r-acs.intensive.r >= 4, "White", "Black"))
  
  
  #Stroke
  stroke.intensive.r <- round(stroke.intensive*100, 1)
  stroke.standard.r <- round(stroke.standard*100, 1)
  rect(0.875, 1.2, 1.1375, 1.25, col=color.intensive(stroke.intensive.r, stroke.standard.r))
  text(1.00625, 1.225, paste(ifelse(stroke.intensive <0.001, "<0.1", stroke.intensive.r), "%", sep=""), cex=ifelse(stroke.intensive > stroke.standard, (stroke.intensive-stroke.standard)+1, 1-abs(stroke.intensive-stroke.standard)), col=ifelse(stroke.intensive.r-stroke.standard.r >= 4, "white", "Black"))
  rect(1.1375, 1.2, 1.4, 1.25, col=color.standard(stroke.intensive.r, stroke.standard.r))
  text(1.26875, 1.225, paste(ifelse(stroke.standard <0.001, "<0.1", stroke.standard.r), "%", sep=""),  cex=ifelse(stroke.standard > stroke.intensive, (stroke.standard-stroke.intensive)+1, 1-abs(stroke.standard-stroke.intensive)), col=ifelse(stroke.standard.r-stroke.intensive.r >= 4, "White", "Black"))
  
  
  #Heart Failure
  hf.intensive.r <- round(hf.intensive*100, 1)
  hf.standard.r <- round(hf.standard*100, 1)
  rect(0.875, 1.15, 1.1375, 1.2, col=color.intensive(hf.intensive.r, hf.standard.r))
  text(1.00625, 1.175, paste(ifelse(hf.intensive <0.001, "<0.1", hf.intensive.r), "%", sep=""), cex=ifelse(hf.intensive > hf.standard, (hf.intensive-hf.standard)+1, 1-abs(hf.intensive-hf.standard)), col=ifelse(hf.intensive.r-hf.standard.r >= 4, "white", "Black"))
  rect(1.1375, 1.15, 1.4, 1.2, col=color.standard(hf.intensive.r, hf.standard.r))
  text(1.26875, 1.175, paste(ifelse(hf.standard <0.001, "<0.1", hf.standard.r), "%", sep=""),  cex=ifelse(hf.standard > hf.intensive, (hf.standard-hf.intensive)+1, 1-abs(hf.standard-hf.intensive)), col=ifelse(hf.standard.r-hf.intensive.r >= 4, "White", "Black"))
  
  
  #CV Death
  cv.death.intensive.r <- round(cv.death.intensive*100, 1)
  cv.death.standard.r <- round(cv.death.standard*100, 1)
  rect(0.875, 1.1, 1.1375, 1.15, col=color.intensive(cv.death.intensive.r, cv.death.standard.r))
  text(1.00625, 1.125, paste(ifelse(cv.death.intensive <0.001, "<0.1", cv.death.intensive.r), "%", sep=""), cex=ifelse(cv.death.intensive > cv.death.standard, (cv.death.intensive-cv.death.standard)+1, 1-abs(cv.death.intensive-cv.death.standard)), col=ifelse(cv.death.intensive.r-cv.death.standard.r >= 4, "white", "Black"))
  rect(1.1375, 1.1, 1.4, 1.15, col=color.standard(cv.death.intensive.r, cv.death.standard.r))
  text(1.26875, 1.125, paste(ifelse(cv.death.standard <0.001, "<0.1", cv.death.standard.r), "%", sep=""),  cex=ifelse(cv.death.standard > cv.death.intensive, (cv.death.standard-cv.death.intensive)+1, 1-abs(cv.death.standard-cv.death.intensive)), col=ifelse(cv.death.standard.r-cv.death.intensive.r >= 4, "White", "Black"))
  
  #All-Cause Death
  all.death.intensive.r <- round(all.death.intensive*100, 1)
  all.death.standard.r <- round(all.death.standard*100, 1)
  rect(0.875, 1.05, 1.1375, 1.1, col=color.intensive(all.death.intensive.r, all.death.standard.r))
  text(1.00625, 1.075, paste(ifelse(all.death.intensive <0.001, "<0.1", all.death.intensive.r), "%", sep=""), cex=ifelse(all.death.intensive > all.death.standard, (all.death.intensive-all.death.standard)+1, 1-abs(all.death.intensive-all.death.standard)), col=ifelse(all.death.intensive.r-all.death.standard.r >= 4, "white", "Black"))
  rect(1.1375, 1.05, 1.4, 1.1, col=color.standard(all.death.intensive.r, all.death.standard.r))
  text(1.26875, 1.075, paste(ifelse(all.death.standard <0.001, "<0.1", all.death.standard.r), "%", sep=""),  cex=ifelse(all.death.standard > all.death.intensive, (all.death.standard-all.death.intensive)+1, 1-abs(all.death.standard-all.death.intensive)), col=ifelse(all.death.standard.r-all.death.intensive.r >= 4, "White", "Black"))
  
  #Hypotension
  hypo.intensive.r <- round(hypo.intensive*100, 1)
  hypo.standard.r <- round(hypo.standard*100, 1)
  rect(0.875, 1, 1.1375, 1.05, col=color.intensive(hypo.intensive.r, hypo.standard.r))
  text(1.00625, 1.025, paste(ifelse(hypo.intensive <0.001, "<0.1", hypo.intensive.r), "%", sep=""), cex=ifelse(hypo.intensive > hypo.standard, (hypo.intensive-hypo.standard)+1, 1-abs(hypo.intensive-hypo.standard)), col=ifelse(hypo.intensive.r-hypo.standard.r >= 4, "white", "Black"))
  rect(1.1375, 1, 1.4, 1.05, col=color.standard(hypo.intensive.r, hypo.standard.r))
  text(1.26875, 1.025, paste(ifelse(hypo.standard <0.001, "<0.1", hypo.standard.r), "%", sep=""),  cex=ifelse(hypo.standard > hypo.intensive, (hypo.standard-hypo.intensive)+1, 1-abs(hypo.standard-hypo.intensive)), col=ifelse(hypo.standard.r-hypo.intensive.r >= 4, "White", "Black"))
  
  
  #Orthostatic Hypotension without dizziness
  hypo.wo.dizzy.intensive.r <- round(hypo.wo.dizzy.intensive*100, 1)
  hypo.wo.dizzy.standard.r <- round(hypo.wo.dizzy.standard*100, 1)
  rect(0.875, 0.95, 1.1375, 1, col=color.intensive(hypo.wo.dizzy.intensive.r, hypo.wo.dizzy.standard.r))
  text(1.00625, 0.975, paste(ifelse(hypo.wo.dizzy.intensive <0.001, "<0.1", hypo.wo.dizzy.intensive.r), "%", sep=""), cex=ifelse(hypo.wo.dizzy.intensive > hypo.wo.dizzy.standard, (hypo.wo.dizzy.intensive-hypo.wo.dizzy.standard)+1, 1-abs(hypo.wo.dizzy.intensive-hypo.wo.dizzy.standard)), col=ifelse(hypo.wo.dizzy.intensive.r-hypo.wo.dizzy.standard.r >= 4, "white", "Black"))
  rect(1.1375, 0.95, 1.4, 1, col=color.standard(hypo.wo.dizzy.intensive.r, hypo.wo.dizzy.standard.r))
  text(1.26875, 0.975, paste(ifelse(hypo.wo.dizzy.standard <0.001, "<0.1", hypo.wo.dizzy.standard.r), "%", sep=""),  cex=ifelse(hypo.wo.dizzy.standard > hypo.wo.dizzy.intensive, (hypo.wo.dizzy.standard-hypo.wo.dizzy.intensive)+1, 1-abs(hypo.wo.dizzy.standard-hypo.wo.dizzy.intensive)), col=ifelse(hypo.wo.dizzy.standard.r-hypo.wo.dizzy.intensive.r >= 4, "White", "Black"))
  
  
  #Orthostatic Hypotension with dizziness
  hypo.w.dizzy.intensive.r <- round(hypo.w.dizzy.intensive*100, 1)
  hypo.w.dizzy.standard.r <- round(hypo.w.dizzy.standard*100, 1)
  rect(0.875, 0.9, 1.1375, 0.95, col=color.intensive(hypo.w.dizzy.intensive.r, hypo.w.dizzy.standard.r))
  text(1.00625, 0.925, paste(ifelse(hypo.w.dizzy.intensive <0.001, "<0.1", hypo.w.dizzy.intensive.r), "%", sep=""), cex=ifelse(hypo.w.dizzy.intensive > hypo.w.dizzy.standard, (hypo.w.dizzy.intensive-hypo.w.dizzy.standard)+1, 1-abs(hypo.w.dizzy.intensive-hypo.w.dizzy.standard)), col=ifelse(hypo.w.dizzy.intensive.r-hypo.w.dizzy.standard.r >= 4, "white", "Black"))
  rect(1.1375, 0.9, 1.4, 0.95, col=color.standard(hypo.w.dizzy.intensive.r, hypo.w.dizzy.standard.r))
  text(1.26875, 0.925, paste(ifelse(hypo.w.dizzy.standard <0.001, "<0.1", hypo.w.dizzy.standard.r), "%", sep=""),  cex=ifelse(hypo.w.dizzy.standard > hypo.w.dizzy.intensive, (hypo.w.dizzy.standard-hypo.w.dizzy.intensive)+1, 1-abs(hypo.w.dizzy.standard-hypo.w.dizzy.intensive)), col=ifelse(hypo.w.dizzy.standard.r-hypo.w.dizzy.intensive.r >= 4, "White", "Black"))
  
  
  #syncope
  syncope.intensive.r <- round(syncope.intensive*100, 1)
  syncope.standard.r <- round(syncope.standard*100, 1)
  rect(0.875, 0.85, 1.1375, 0.9, col=color.intensive(syncope.intensive.r, syncope.standard.r))
  text(1.00625, 0.875, paste(ifelse(syncope.intensive <0.001, "<0.1", syncope.intensive.r), "%", sep=""), cex=ifelse(syncope.intensive > syncope.standard, (syncope.intensive-syncope.standard)+1, 1-abs(syncope.intensive-syncope.standard)), col=ifelse(syncope.intensive.r-syncope.standard.r >= 4, "white", "Black"))
  rect(1.1375, 0.85, 1.4, 0.9, col=color.standard(syncope.intensive.r, syncope.standard.r))
  text(1.26875, 0.875, paste(ifelse(syncope.standard <0.001, "<0.1", syncope.standard.r), "%", sep=""),  cex=ifelse(syncope.standard > syncope.intensive, (syncope.standard-syncope.intensive)+1, 1-abs(syncope.standard-syncope.intensive)), col=ifelse(syncope.standard.r-syncope.intensive.r >= 4, "White", "Black"))
  
  
  #Electrolyte Abnormality
  ele.abn.intensive.r <- round(ele.abn.intensive*100, 1)
  ele.abn.standard.r <- round(ele.abn.standard*100, 1)
  rect(0.875, 0.8, 1.1375, 0.85, col=color.intensive(ele.abn.intensive.r, ele.abn.standard.r))
  text(1.00625, 0.825, paste(ifelse(ele.abn.intensive <0.001, "<0.1", ele.abn.intensive.r), "%", sep=""), cex=ifelse(ele.abn.intensive > ele.abn.standard, (ele.abn.intensive-ele.abn.standard)+1, 1-abs(ele.abn.intensive-ele.abn.standard)), col=ifelse(ele.abn.intensive.r-ele.abn.standard.r >= 4, "white", "Black"))
  rect(1.1375, 0.8, 1.4, 0.85, col=color.standard(ele.abn.intensive.r, ele.abn.standard.r))
  text(1.26875, 0.825, paste(ifelse(ele.abn.standard <0.001, "<0.1", ele.abn.standard.r), "%", sep=""),  cex=ifelse(ele.abn.standard > ele.abn.intensive, (ele.abn.standard-ele.abn.intensive)+1, 1-abs(ele.abn.standard-ele.abn.intensive)), col=ifelse(ele.abn.standard.r-ele.abn.intensive.r >= 4, "White", "Black"))
  
  
  #Incident albuminuria
  albumin.intensive.r <- round(albumin.intensive*100, 1)
  albumin.standard.r <- round(albumin.standard*100, 1)
  rect(0.875, 0.75, 1.1375, 0.8, col=color.intensive(albumin.intensive.r, albumin.standard.r))
  text(1.00625, 0.775, paste(ifelse(albumin.intensive <0.001, "<0.1", albumin.intensive.r), "%", sep=""), cex=ifelse(albumin.intensive > albumin.standard, (albumin.intensive-albumin.standard)+1, 1-abs(albumin.intensive-albumin.standard)), col=ifelse(albumin.intensive.r-albumin.standard.r >= 4, "white", "Black"))
  rect(1.1375, 0.75, 1.4, 0.8, col=color.standard(albumin.intensive.r, albumin.standard.r))
  text(1.26875, 0.775, paste(ifelse(albumin.standard <0.001, "<0.1", albumin.standard.r), "%", sep=""),  cex=ifelse(albumin.standard > albumin.intensive, (albumin.standard-albumin.intensive)+1, 1-abs(albumin.standard-albumin.intensive)), col=ifelse(albumin.standard.r-albumin.intensive.r >= 4, "White", "Black"))
  
  
  #Acute Kidney Disease
  kidney.intensive.r <- round(kidney.intensive*100, 1)
  kidney.standard.r <- round(kidney.standard*100, 1)
  rect(0.875, 0.7, 1.1375, 0.75, col=color.intensive(kidney.intensive.r, kidney.standard.r))
  text(1.00625, 0.725, paste(ifelse(kidney.intensive <0.001, "<0.1", kidney.intensive.r), "%", sep=""), cex=ifelse(kidney.intensive > kidney.standard, (kidney.intensive-kidney.standard)+1, 1-abs(kidney.intensive-kidney.standard)), col=ifelse(kidney.intensive.r-kidney.standard.r >= 4, "white", "Black"))
  rect(1.1375, 0.7, 1.4, 0.75, col=color.standard(kidney.intensive.r, kidney.standard.r))
  text(1.26875, 0.725, paste(ifelse(kidney.standard <0.001, "<0.1", kidney.standard.r), "%", sep=""),  cex=ifelse(kidney.standard > kidney.intensive, (kidney.standard-kidney.intensive)+1, 1-abs(kidney.standard-kidney.intensive)), col=ifelse(kidney.standard.r-kidney.intensive.r >= 4, "White", "Black"))
  
  
  #Injurious Falls
  fall.intensive.r <- round(fall.intensive*100, 1)
  fall.standard.r <- round(fall.standard*100, 1)
  rect(0.875, 0.65, 1.1375, 0.7, col=color.intensive(fall.intensive.r, fall.standard.r))
  text(1.00625, 0.675, paste(ifelse(fall.intensive <0.001, "<0.1", fall.intensive.r), "%", sep=""), cex=ifelse(fall.intensive > fall.standard, (fall.intensive-fall.standard)+1, 1-abs(fall.intensive-fall.standard)), col=ifelse(fall.intensive.r-fall.standard.r >= 4, "white", "Black"))
  rect(1.1375, 0.65, 1.4, 0.7, col=color.standard(fall.intensive.r, fall.standard.r))
  text(1.26875, 0.675, paste(ifelse(fall.standard <0.001, "<0.1", fall.standard.r), "%", sep=""),   cex=ifelse(fall.standard > fall.intensive, (fall.standard-fall.intensive)+1, 1-abs(fall.standard-fall.intensive)), col=ifelse(fall.standard.r-fall.intensive.r >= 4, "White", "Black"))
  
  
  #Bradycardia
  bradycardia.intensive.r <- round(bradycardia.intensive*100, 1)
  bradycardia.standard.r <- round(bradycardia.standard*100, 1)
  rect(0.875, 0.6, 1.1375, 0.65, col=color.intensive(bradycardia.intensive.r, bradycardia.standard.r))
  text(1.00625, 0.625, paste(ifelse(bradycardia.intensive <0.001, "<0.1", bradycardia.intensive.r), "%", sep=""), cex=ifelse(bradycardia.intensive > bradycardia.standard, (bradycardia.intensive-bradycardia.standard)+1, 1-abs(bradycardia.intensive-bradycardia.standard)), col=ifelse(bradycardia.intensive.r-bradycardia.standard.r >= 4, "white", "Black"))
  rect(1.1375, 0.6, 1.4, 0.65, col=color.standard(bradycardia.intensive.r, bradycardia.standard.r))
  text(1.26875, 0.625, paste(ifelse(bradycardia.standard <0.001, "<0.1", bradycardia.standard.r), "%", sep=""),   cex=ifelse(bradycardia.standard > bradycardia.intensive, (bradycardia.standard-bradycardia.intensive)+1, 1-abs(bradycardia.standard-bradycardia.intensive)), col=ifelse(bradycardia.standard.r-bradycardia.intensive.r >= 4, "White", "Black"))
  
  add.intensive <- sum(mi.intensive, acs.intensive, stroke.intensive, hf.intensive, cv.death.intensive, all.death.intensive, hypo.intensive, hypo.wo.dizzy.intensive, hypo.w.dizzy.intensive, syncope.intensive, ele.abn.intensive, albumin.intensive, kidney.intensive, fall.intensive, bradycardia.intensive)/15
  add.standard <- sum(mi.standard, acs.standard, stroke.standard, hf.standard, cv.death.standard, all.death.standard, hypo.standard, hypo.wo.dizzy.standard, hypo.w.dizzy.standard, syncope.standard, ele.abn.standard, albumin.standard, kidney.standard, fall.standard, bradycardia.standard)/15
  
  gradient.rect(0.875, 1.35, 1.4, 1.4,col=smoothColors(ifelse(add.intensive > add.standard, "gray0", ifelse(add.intensive < add.standard, "gray100", "gray50")),38,ifelse(add.intensive > add.standard, "gray100", ifelse(add.intensive < add.standard, "gray0", "gray50"))),border=T)
  text(1.00625, 1.375, "Intensive", cex=1.75, font=2, col="lightskyblue1")
  text(1.26875, 1.375, "Standard", cex=1.75, font=2, col="lightskyblue1")
  abline(v=1.1375)
  
  
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
    pred.mi.intensive <- eval(MI.Intensive.Fit, envir = new.dat)
    pred.mi.standard <- eval(MI.Standard.Fit, envir = new.dat)
    pred.acs.intensive <- eval(ACS.Intensive.Fit, envir = new.dat)
    pred.acs.standard <- eval(ACS.Standard.Fit, envir = new.dat)
    pred.stroke.intensive <- eval(Stroke.Intensive.Fit, envir = new.dat)
    pred.stroke.standard <- eval(Stroke.Standard.Fit, envir = new.dat)
    pred.hf.intensive <- eval(HF.Intensive.Fit, envir = new.dat)
    pred.hf.standard <- eval(HF.Standard.Fit, envir = new.dat)
    pred.cv.death.intensive <- eval(CV.Death.Intensive.Fit, envir = new.dat)
    pred.cv.death.standard <- eval(CV.Death.Standard.Fit, envir = new.dat)
    pred.all.death.intensive <- eval(All.Death.Intensive.Fit, envir = new.dat)
    pred.all.death.standard <- eval(All.Death.Standard.Fit, envir = new.dat)
    pred.hypo.intensive <- eval(Hypo.Intensive.Fit, envir = new.dat)
    pred.hypo.standard <- eval(Hypo.Standard.Fit, envir = new.dat)
    pred.hypo.wo.dizzy.intensive <- eval(Hypo.wo.Dizzy.Intensive.Fit, envir = new.dat)
    pred.hypo.wo.dizzy.standard <- eval(Hypo.wo.Dizzy.Standard.Fit, envir = new.dat)
    pred.hypo.w.dizzy.intensive <- eval(Hypo.w.Dizzy.Intensive.Fit, envir = new.dat)
    pred.hypo.w.dizzy.standard <- eval(Hypo.w.Dizzy.Standard.Fit, envir = new.dat)
    pred.syncope.intensive <- eval(Syncope.Intensive.Fit, envir = new.dat)
    pred.syncope.standard <- eval(Syncope.Standard.Fit, envir = new.dat)
    pred.ele.abn.intensive <- eval(Ele.Abn.Intensive.Fit, envir = new.dat)
    pred.ele.abn.standard <- eval(Ele.Abn.Standard.Fit, envir = new.dat)
    pred.albumin.intensive <- eval(Albumin.Intensive.Fit, envir = new.dat)
    pred.albumin.standard <- eval(Albumin.Standard.Fit, envir = new.dat)
    pred.kidney.intensive <- eval(Kidney.Intensive.Fit, envir = new.dat)
    pred.kidney.standard <- eval(Kidney.Standard.Fit, envir = new.dat)
    pred.fall.intensive <- eval(Falls.Intensive.Fit, envir = new.dat)
    pred.fall.standard <- eval(Falls.Standard.Fit, envir = new.dat)
    pred.bradycardia.intensive <- eval(Brady.Intensive.Fit, envir = new.dat)
    pred.bradycardia.standard <- eval(Brady.Standard.Fit, envir = new.dat)
    
    sprint.plot(pred.mi.intensive, pred.mi.standard, pred.acs.intensive, pred.acs.standard, pred.stroke.intensive, pred.stroke.standard, pred.hf.intensive, pred.hf.standard, pred.cv.death.intensive, pred.cv.death.standard, pred.all.death.intensive, pred.all.death.standard, pred.hypo.intensive, pred.hypo.standard, pred.hypo.wo.dizzy.intensive, pred.hypo.wo.dizzy.standard, pred.hypo.w.dizzy.intensive, pred.hypo.w.dizzy.standard, pred.syncope.intensive, pred.syncope.standard, pred.ele.abn.intensive, pred.ele.abn.standard, pred.albumin.intensive, pred.albumin.standard, pred.kidney.intensive, pred.kidney.standard, pred.fall.intensive, pred.fall.standard, pred.bradycardia.intensive, pred.bradycardia.standard)  
  })
  
 
  
})