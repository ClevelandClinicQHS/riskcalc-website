require(shiny)




######################################################################################################## Recurrent POP
##### Composite Definition
compo.recur.colpo <- expression({
  lp <- -4.1140905 - 0.0079541085 * AGE_SURGERY + 0.10399958 * VPARITY + 0.35851208 * (POPQ == "III") + 0.50037378 * (POPQ == "IV") + 0.006707077 * C + 0.12690832 * BA + 0.17804805 * GH - 0.43662604 * (ANTERIORC == "Yes") - 0.45284712 * (POSTERIORC == "Yes") + 0.28580785 * 1 + 2.2798939 * 0;
  1/(1+exp(-lp))
})
compo.recur.vag <- expression({
 lp <- -4.1140905 - 0.0079541085 * AGE_SURGERY + 0.10399958 * VPARITY + 0.35851208 * (POPQ == "III") + 0.50037378 * (POPQ == "IV") + 0.006707077 * C + 0.12690832 * BA + 0.17804805 * GH - 0.43662604 * (ANTERIORC == "Yes") - 0.45284712 * (POSTERIORC == "Yes") + 0.28580785 * 0 + 2.2798939 * 1;
 1/(1+exp(-lp))
})
compo.recur.abs <- expression({
 lp <- -4.1140905 - 0.0079541085 * AGE_SURGERY + 0.10399958 * VPARITY + 0.35851208 * (POPQ == "III") + 0.50037378 * (POPQ == "IV") + 0.006707077 * C + 0.12690832 * BA + 0.17804805 * GH - 0.43662604 * (ANTERIORC == "Yes") - 0.45284712 * (POSTERIORC == "Yes") + 0.28580785 * 0 + 2.2798939 * 0;
 1/(1+exp(-lp))
})
##### Bothersome buldge
bother.bulge.colpo <- expression({
 lp <- -4.5981236 - 0.021009964 * AGE_SURGERY + 0.99609738 * (RACE3 == "Other") + 0.067425117 * (RACE3 == "White") + 0.1013356 * VPARITY - 0.63638115 * (CARDIAC == "Yes") + 0.24637754 * CMIRS_SUM - 0.50035004 * (POPQ == "III") - 0.68944494 * (POPQ == "IV") + 0.18543736 * BA + 0.15237464 * GH - 0.57392652 * (ANTERIORC == "Yes") - 0.64820497 * (POSTERIORC == "Yes") - 0.39462713 * (HYSTOOP == "Yes") + 0.78136181 * (anesthetics == "Regional") + 0.74919219 * (lifting == "More than once a week") + 0.45246788 * (lifting == "Never") + 0.77235689 * (lifting == "Once a month") + 0.61320358 * (lifting == "Once a week") + 0.87170861 * (lifting == "Two to three times a month") + 0.5176089 * (SF36Q3 == "Limited a lot") + 0.19718403 * (SF36Q3 == "Not limited at all") - 0.59963309 * (uppergi == "Yes") - 0.99663796 * (anticoag == "Yes") - 0.70642899 * 1 + 1.9498035 * 0 + 2.3304832 * 0;
 1/(1+exp(-lp))
})
bother.bulge.vag <- expression({
 lp <- -4.5981236 - 0.021009964 * AGE_SURGERY + 0.99609738 * (RACE3 == "Other") + 0.067425117 * (RACE3 == "White") + 0.1013356 * VPARITY - 0.63638115 * (CARDIAC == "Yes") + 0.24637754 * CMIRS_SUM - 0.50035004 * (POPQ == "III") - 0.68944494 * (POPQ == "IV") + 0.18543736 * BA + 0.15237464 * GH - 0.57392652 * (ANTERIORC == "Yes") - 0.64820497 * (POSTERIORC == "Yes") - 0.39462713 * (HYSTOOP == "Yes") + 0.78136181 * (anesthetics == "Regional") + 0.74919219 * (lifting == "More than once a week") + 0.45246788 * (lifting == "Never") + 0.77235689 * (lifting == "Once a month") + 0.61320358 * (lifting == "Once a week") + 0.87170861 * (lifting == "Two to three times a month") + 0.5176089 * (SF36Q3 == "Limited a lot") + 0.19718403 * (SF36Q3 == "Not limited at all") - 0.59963309 * (uppergi == "Yes") - 0.99663796 * (anticoag == "Yes") - 0.70642899 * 0 + 1.9498035 * 0 + 2.3304832 * 1;
 1/(1+exp(-lp))
})
bother.bulge.abs <- expression({
 lp <- -4.5981236 - 0.021009964 * AGE_SURGERY + 0.99609738 * (RACE3 == "Other") + 0.067425117 * (RACE3 == "White") + 0.1013356 * VPARITY - 0.63638115 * (CARDIAC == "Yes") + 0.24637754 * CMIRS_SUM - 0.50035004 * (POPQ == "III") - 0.68944494 * (POPQ == "IV") + 0.18543736 * BA + 0.15237464 * GH - 0.57392652 * (ANTERIORC == "Yes") - 0.64820497 * (POSTERIORC == "Yes") - 0.39462713 * (HYSTOOP == "Yes") + 0.78136181 * (anesthetics == "Regional") + 0.74919219 * (lifting == "More than once a week") + 0.45246788 * (lifting == "Never") + 0.77235689 * (lifting == "Once a month") + 0.61320358 * (lifting == "Once a week") + 0.87170861 * (lifting == "Two to three times a month") + 0.5176089 * (SF36Q3 == "Limited a lot") + 0.19718403 * (SF36Q3 == "Not limited at all") - 0.59963309 * (uppergi == "Yes") - 0.99663796 * (anticoag == "Yes") - 0.70642899 * 0 + 1.9498035 * 0 + 2.3304832 * 0;
 1/(1+exp(-lp))
})
#####beyond the hymen
beyond.hymen.colpo <- expression({
 lp <- -4.8053227 + 0.75100453 * (POPQ == "III") + 0.58548018 * (POPQ == "IV") + 0.16284854 * BA + 0.19795017 * GH - 0.55328177 * (ANTERIORC == "Yes") - 0.47509898 * (POSTERIORC == "Yes") - 0.42038119 * (uppergi == "Yes") + 0.56990449 * 1 + 1.9305542 * 0 + 2.4079013 * 0; 
 1/(1+exp(-lp))
})
beyond.hymen.vag <- expression({
 lp <- -4.8053227 + 0.75100453 * (POPQ == "III") + 0.58548018 * (POPQ == "IV") + 0.16284854 * BA + 0.19795017 * GH - 0.55328177 * (ANTERIORC == "Yes") - 0.47509898 * (POSTERIORC == "Yes") - 0.42038119 * (uppergi == "Yes") + 0.56990449 * 0 + 1.9305542 * 0 + 2.4079013 * 1; 
 1/(1+exp(-lp))
})
beyond.hymen.abs <- expression({
 lp <- -4.8053227 + 0.75100453 * (POPQ == "III") + 0.58548018 * (POPQ == "IV") + 0.16284854 * BA + 0.19795017 * GH - 0.55328177 * (ANTERIORC == "Yes") - 0.47509898 * (POSTERIORC == "Yes") - 0.42038119 * (uppergi == "Yes") + 0.56990449 * 0 + 1.9305542 * 0 + 2.4079013 * 0; 
 1/(1+exp(-lp))
})
######################################################################################################## Serious Adverse Events
##### >=1 SAE
sae.1m.colpo <- expression({
 lp <- -1.4467535 + 0.014950398 * AGE_SURGERY - 0.55502219 * (RACE3 == "Other") - 0.37245852 * (RACE3 == "White") - 0.30696409 * (ESTROGEN == "Yes") - 0.24517284 * (VASCULAR == "Yes") + 0.097473494 * CMIRS_SUM - 0.29748918 * (HYSTOOP == "Yes") + 0.46102386 * (anesthetics == "Regional") + 0.16268746 * (SF36Q3 == "Limited a lot") - 0.12597559 * (SF36Q3 == "Not limited at all") - 0.51482356 * (lowergi == "Yes") - 1.1202983 * 1 - 1.5504697 * 0 - 0.12124657 * 0 - 0.74867591 * 0 - 0.84810735 * 0;
 1/(1+exp(-lp))
})
sae.1m.ssls <- expression({
 lp <- -1.4467535 + 0.014950398 * AGE_SURGERY - 0.55502219 * (RACE3 == "Other") - 0.37245852 * (RACE3 == "White") - 0.30696409 * (ESTROGEN == "Yes") - 0.24517284 * (VASCULAR == "Yes") + 0.097473494 * CMIRS_SUM - 0.29748918 * (HYSTOOP == "Yes") + 0.46102386 * (anesthetics == "Regional") + 0.16268746 * (SF36Q3 == "Limited a lot") - 0.12597559 * (SF36Q3 == "Not limited at all") - 0.51482356 * (lowergi == "Yes") - 1.1202983 * 0 - 1.5504697 * 0 - 0.12124657 * 0 - 0.74867591 * 1 - 0.84810735 * 0;
 1/(1+exp(-lp))
})
sae.1m.usls <- expression({
 lp <- -1.4467535 + 0.014950398 * AGE_SURGERY - 0.55502219 * (RACE3 == "Other") - 0.37245852 * (RACE3 == "White") - 0.30696409 * (ESTROGEN == "Yes") - 0.24517284 * (VASCULAR == "Yes") + 0.097473494 * CMIRS_SUM - 0.29748918 * (HYSTOOP == "Yes") + 0.46102386 * (anesthetics == "Regional") + 0.16268746 * (SF36Q3 == "Limited a lot") - 0.12597559 * (SF36Q3 == "Not limited at all") - 0.51482356 * (lowergi == "Yes") - 1.1202983 * 0 - 1.5504697 * 0 - 0.12124657 * 0 - 0.74867591 * 0 - 0.84810735 * 1;
 1/(1+exp(-lp))
})
sae.1m.abs <- expression({
 lp <- -1.4467535 + 0.014950398 * AGE_SURGERY - 0.55502219 * (RACE3 == "Other") - 0.37245852 * (RACE3 == "White") - 0.30696409 * (ESTROGEN == "Yes") - 0.24517284 * (VASCULAR == "Yes") + 0.097473494 * CMIRS_SUM - 0.29748918 * (HYSTOOP == "Yes") + 0.46102386 * (anesthetics == "Regional") + 0.16268746 * (SF36Q3 == "Limited a lot") - 0.12597559 * (SF36Q3 == "Not limited at all") - 0.51482356 * (lowergi == "Yes") - 1.1202983 * 0 - 1.5504697 * 0 - 0.12124657 * 0 - 0.74867591 * 0 - 0.84810735 * 0;
 1/(1+exp(-lp))
})
##### >=1 Dindo
dindo.1m.colpo <- expression({
 lp <- -0.96875493 - 0.45685569 * (HYSTERECTOMY == "Yes") - 0.30844547 * (ESTROGEN == "Yes") + 1.0256986 * (TISSUE == "Yes") + 0.31646724 * (CARDIAC == "Yes") + 0.092876522 * CMIRS_SUM + 0.24895286 * (ANTERIORC == "Yes") + 0.3374749 * (ANTIURINE == "None") + 1.2825312 * (ANTIURINE == "Other") + 0.13165018 * (ANTIURINE == "Sling/TVT") - 0.79657789 * (HYSTOOP == "Yes") + 0.43149668 * (lifting == "More than once a week") + 0.36502935 * (lifting == "Never") - 0.27875021 * (lifting == "Once a month") + 0.32779318 * (lifting == "Once a week") + 0.26983544 * (lifting == "Two to three times a month") - 0.38637182 * (smoking.status == "Former") - 0.7617231 * (smoking.status == "Never") - 0.55844731 * (lowergi == "Yes") - 0.87360122 * 1 - 1.9199118 * 0 - 0.30195153 * 0 - 0.81364432 * 0 - 0.97258896 * 0 
 1/(1+exp(-lp))
})
dindo.1m.ssls <- expression({
 lp <- -0.96875493 - 0.45685569 * (HYSTERECTOMY == "Yes") - 0.30844547 * (ESTROGEN == "Yes") + 1.0256986 * (TISSUE == "Yes") + 0.31646724 * (CARDIAC == "Yes") + 0.092876522 * CMIRS_SUM + 0.24895286 * (ANTERIORC == "Yes") + 0.3374749 * (ANTIURINE == "None") + 1.2825312 * (ANTIURINE == "Other") + 0.13165018 * (ANTIURINE == "Sling/TVT") - 0.79657789 * (HYSTOOP == "Yes") + 0.43149668 * (lifting == "More than once a week") + 0.36502935 * (lifting == "Never") - 0.27875021 * (lifting == "Once a month") + 0.32779318 * (lifting == "Once a week") + 0.26983544 * (lifting == "Two to three times a month") - 0.38637182 * (smoking.status == "Former") - 0.7617231 * (smoking.status == "Never") - 0.55844731 * (lowergi == "Yes") - 0.87360122 * 0 - 1.9199118 * 0 - 0.30195153 * 0 - 0.81364432 * 1 - 0.97258896 * 0 
 1/(1+exp(-lp))
})
dindo.1m.usls <- expression({
 lp <- -0.96875493 - 0.45685569 * (HYSTERECTOMY == "Yes") - 0.30844547 * (ESTROGEN == "Yes") + 1.0256986 * (TISSUE == "Yes") + 0.31646724 * (CARDIAC == "Yes") + 0.092876522 * CMIRS_SUM + 0.24895286 * (ANTERIORC == "Yes") + 0.3374749 * (ANTIURINE == "None") + 1.2825312 * (ANTIURINE == "Other") + 0.13165018 * (ANTIURINE == "Sling/TVT") - 0.79657789 * (HYSTOOP == "Yes") + 0.43149668 * (lifting == "More than once a week") + 0.36502935 * (lifting == "Never") - 0.27875021 * (lifting == "Once a month") + 0.32779318 * (lifting == "Once a week") + 0.26983544 * (lifting == "Two to three times a month") - 0.38637182 * (smoking.status == "Former") - 0.7617231 * (smoking.status == "Never") - 0.55844731 * (lowergi == "Yes") - 0.87360122 * 0 - 1.9199118 * 0 - 0.30195153 * 0 - 0.81364432 * 0 - 0.97258896 * 1 
 1/(1+exp(-lp))
})
dindo.1m.abs <- expression({
 lp <- -0.96875493 - 0.45685569 * (HYSTERECTOMY == "Yes") - 0.30844547 * (ESTROGEN == "Yes") + 1.0256986 * (TISSUE == "Yes") + 0.31646724 * (CARDIAC == "Yes") + 0.092876522 * CMIRS_SUM + 0.24895286 * (ANTERIORC == "Yes") + 0.3374749 * (ANTIURINE == "None") + 1.2825312 * (ANTIURINE == "Other") + 0.13165018 * (ANTIURINE == "Sling/TVT") - 0.79657789 * (HYSTOOP == "Yes") + 0.43149668 * (lifting == "More than once a week") + 0.36502935 * (lifting == "Never") - 0.27875021 * (lifting == "Once a month") + 0.32779318 * (lifting == "Once a week") + 0.26983544 * (lifting == "Two to three times a month") - 0.38637182 * (smoking.status == "Former") - 0.7617231 * (smoking.status == "Never") - 0.55844731 * (lowergi == "Yes") - 0.87360122 * 0 - 1.9199118 * 0 - 0.30195153 * 0 - 0.81364432 * 0 - 0.97258896 * 0 
 1/(1+exp(-lp))
})
###################################################################################################### Health Utilities
# ##### Minimally important increase
mii.colpo <- expression({
 lp <- 3.8150616 - 0.025912928 * AGE_SURGERY - 0.82569046 * log(BMI) - 1.0567807 * (TISSUE == "Yes") - 0.084514437 * CMIRS_SUM - 0.033723612 * C + 0.056053674 * BP + 0.082488379 * GH - 0.21282748 * (ANTIURINE == "None") - 1.7320745 * (ANTIURINE == "Other") - 0.0080334497 * (ANTIURINE == "Sling/TVT") + 0.59600032 * (anesthetics == "Regional") + 0.22707641 * (SF36Q3 == "Limited a lot") - 0.88160619 * (SF36Q3 == "Not limited at all") + 0.51674347 * (smoking.status == "Former") + 0.38524675 * (smoking.status == "Never") + 0.077667664 * 1 + 0.67810911 * 0 + 0.53106354 * 0 + 0.59026003 * 0 + 0.52087552 * 0;
 1/(1+exp(-lp))
})
mii.ssls <- expression({
 lp <- 3.8150616 - 0.025912928 * AGE_SURGERY - 0.82569046 * log(BMI) - 1.0567807 * (TISSUE == "Yes") - 0.084514437 * CMIRS_SUM - 0.033723612 * C + 0.056053674 * BP + 0.082488379 * GH - 0.21282748 * (ANTIURINE == "None") - 1.7320745 * (ANTIURINE == "Other") - 0.0080334497 * (ANTIURINE == "Sling/TVT") + 0.59600032 * (anesthetics == "Regional") + 0.22707641 * (SF36Q3 == "Limited a lot") - 0.88160619 * (SF36Q3 == "Not limited at all") + 0.51674347 * (smoking.status == "Former") + 0.38524675 * (smoking.status == "Never") + 0.077667664 * 0 + 0.67810911 * 0 + 0.53106354 * 0 + 0.59026003 * 1 + 0.52087552 * 0;
 1/(1+exp(-lp))
})
mii.usls <- expression({
 lp <- 3.8150616 - 0.025912928 * AGE_SURGERY - 0.82569046 * log(BMI) - 1.0567807 * (TISSUE == "Yes") - 0.084514437 * CMIRS_SUM - 0.033723612 * C + 0.056053674 * BP + 0.082488379 * GH - 0.21282748 * (ANTIURINE == "None") - 1.7320745 * (ANTIURINE == "Other") - 0.0080334497 * (ANTIURINE == "Sling/TVT") + 0.59600032 * (anesthetics == "Regional") + 0.22707641 * (SF36Q3 == "Limited a lot") - 0.88160619 * (SF36Q3 == "Not limited at all") + 0.51674347 * (smoking.status == "Former") + 0.38524675 * (smoking.status == "Never") + 0.077667664 * 0 + 0.67810911 * 0 + 0.53106354 * 0 + 0.59026003 *0 + 0.52087552 * 1;
 1/(1+exp(-lp))
})
mii.abs <- expression({
 lp <- 3.8150616 - 0.025912928 * AGE_SURGERY - 0.82569046 * log(BMI) - 1.0567807 * (TISSUE == "Yes") - 0.084514437 * CMIRS_SUM - 0.033723612 * C + 0.056053674 * BP + 0.082488379 * GH - 0.21282748 * (ANTIURINE == "None") - 1.7320745 * (ANTIURINE == "Other") - 0.0080334497 * (ANTIURINE == "Sling/TVT") + 0.59600032 * (anesthetics == "Regional") + 0.22707641 * (SF36Q3 == "Limited a lot") - 0.88160619 * (SF36Q3 == "Not limited at all") + 0.51674347 * (smoking.status == "Former") + 0.38524675 * (smoking.status == "Never") + 0.077667664 * 0 + 0.67810911 * 0 + 0.53106354 * 0 + 0.59026003 *0 + 0.52087552 * 0;
 1/(1+exp(-lp))
})
##### Minimally important decrease
mid.colpo <- expression({
 lp <- 0.49726942 + 0.020435906 * AGE_SURGERY - 0.77150698 * (RACE3 == "Other") - 0.64007717 * (RACE3 == "White") - 0.80123928 * log(BMI) + 0.088067295 * CMIRS_SUM - 0.053364865 * BA + 0.027603052 * C + 0.27136328 * (HYSTOOP == "Yes") + 0.28788516 * (lifting == "More than once a week") + 0.19693348 * (lifting == "Never") + 0.10821494 * (lifting == "Once a month") + 0.2630636 * (lifting == "Once a week") + 0.67168113 * (lifting == "Two to three times a month") - 0.42151235 * (SF36Q3 == "Limited a lot") + 1.0990015 * (SF36Q3 == "Not limited at all") - 0.5605776 * (smoking.status == "Former") - 0.34625729 * (smoking.status == "Never") - 0.28210417 * (lowergi == "Yes") + 0.19954469 * 0 - 0.21386373 * 0 - 0.17136635 * 0 - 0.1822556 * 0 - 0.062962409 * 0;
 1/(1+exp(-lp))
})
mid.ssls <- expression({
 lp <- 0.49726942 + 0.020435906 * AGE_SURGERY - 0.77150698 * (RACE3 == "Other") - 0.64007717 * (RACE3 == "White") - 0.80123928 * log(BMI) + 0.088067295 * CMIRS_SUM - 0.053364865 * BA + 0.027603052 * C + 0.27136328 * (HYSTOOP == "Yes") + 0.28788516 * (lifting == "More than once a week") + 0.19693348 * (lifting == "Never") + 0.10821494 * (lifting == "Once a month") + 0.2630636 * (lifting == "Once a week") + 0.67168113 * (lifting == "Two to three times a month") - 0.42151235 * (SF36Q3 == "Limited a lot") + 1.0990015 * (SF36Q3 == "Not limited at all") - 0.5605776 * (smoking.status == "Former") - 0.34625729 * (smoking.status == "Never") - 0.28210417 * (lowergi == "Yes") + 0.19954469 * 1 - 0.21386373 * 0 - 0.17136635 * 0 - 0.1822556 * 1 - 0.062962409 * 0;
 1/(1+exp(-lp))
})
mid.usls <- expression({
 lp <- 0.49726942 + 0.020435906 * AGE_SURGERY - 0.77150698 * (RACE3 == "Other") - 0.64007717 * (RACE3 == "White") - 0.80123928 * log(BMI) + 0.088067295 * CMIRS_SUM - 0.053364865 * BA + 0.027603052 * C + 0.27136328 * (HYSTOOP == "Yes") + 0.28788516 * (lifting == "More than once a week") + 0.19693348 * (lifting == "Never") + 0.10821494 * (lifting == "Once a month") + 0.2630636 * (lifting == "Once a week") + 0.67168113 * (lifting == "Two to three times a month") - 0.42151235 * (SF36Q3 == "Limited a lot") + 1.0990015 * (SF36Q3 == "Not limited at all") - 0.5605776 * (smoking.status == "Former") - 0.34625729 * (smoking.status == "Never") - 0.28210417 * (lowergi == "Yes") + 0.19954469 * 1 - 0.21386373 * 0 - 0.17136635 * 0 - 0.1822556 * 0 - 0.062962409 * 1;
 1/(1+exp(-lp))
})
mid.abs <- expression({
 lp <- 0.49726942 + 0.020435906 * AGE_SURGERY - 0.77150698 * (RACE3 == "Other") - 0.64007717 * (RACE3 == "White") - 0.80123928 * log(BMI) + 0.088067295 * CMIRS_SUM - 0.053364865 * BA + 0.027603052 * C + 0.27136328 * (HYSTOOP == "Yes") + 0.28788516 * (lifting == "More than once a week") + 0.19693348 * (lifting == "Never") + 0.10821494 * (lifting == "Once a month") + 0.2630636 * (lifting == "Once a week") + 0.67168113 * (lifting == "Two to three times a month") - 0.42151235 * (SF36Q3 == "Limited a lot") + 1.0990015 * (SF36Q3 == "Not limited at all") - 0.5605776 * (smoking.status == "Former") - 0.34625729 * (smoking.status == "Never") - 0.28210417 * (lowergi == "Yes") + 0.19954469 * 1 - 0.21386373 * 0 - 0.17136635 * 0 - 0.1822556 * 0 - 0.062962409 * 0;
 1/(1+exp(-lp))
})


pop.plot <- function(pred.abs.recur, pred.abs.bulge, pred.abs.hyman, pred.abs.sae, pred.abs.dindo, pred.abs.mii, pred.abs.mid, pred.usls.recur, pred.usls.bulge, pred.usls.hymen, pred.usls.sae, pred.usls.dindo, pred.usls.mii, pred.usls.mid, pred.ssls.recur, pred.ssls.bulge, pred.ssls.hymen, pred.ssls.sae, pred.ssls.dindo, pred.ssls.mii, pred.ssls.mid, pred.colpo.recur, pred.colpo.bulge, pred.colpo.hymen, pred.colpo.sae, pred.colpo.dindo, pred.colpo.mii, pred.colpo.mid){
  par(mar=c(0,0,0,0))
  plot(1, 1, type="n", xlab="", ylab="", xaxs = "i", yaxs="i", xlim=c(0,1), ylim=c(0,1))#xaxt="n", yaxt="n", 
  rect(0.2, 0.54, 1, 0.72, col="lightskyblue1", border = NA)
  rect(0.2, 0.36, 1, 0.54, col="lightsteelblue1", border = NA)
  rect(0.2, 0.18, 1, 0.36, col="lightskyblue1", border = NA)
  rect(0.2, 0, 1, 0.18, col="lightsteelblue1", border = NA)
  abline(h = c(0.18, 0.36, 0.54, 0.72))
  lines(c(0.2, 1), c(0.9, 0.9))
  text(0.1, 0.63, "Abdominal Sacral\n Colpopexy ", cex=1.5, font=2)
  text(0.1, 0.45, "Uterosacral \nLigament\n Suspension", cex=1.5, font=2)
  text(0.1, 0.27, "Sacrospinous  \nLigament\n Suspension", cex=1.5, font=2)
  text(0.1, 0.09, "Colpocleisis", cex=1.5, font=2)
  text(0.3, 0.81, "Composite\n Definition", cex=1.25, font=2)
  text(0.4, 0.81, "Vaginal\n Bulge", cex=1.25, font=2)
  text(0.5, 0.81, "Prolapse\n Below\n the Vaginal\n Hymen", cex=1.25, font=2)
  text(0.4, 0.95, "Recurrent Pelvic Organ Prolapse", cex=1.25, font=2)
  text(0.6, 0.81, "≥ 1\n Serious\n Adverse\n Event", cex=1.25, font=2)
  text(0.7, 0.81, "≥ 1\n Dindo\n Grade 3", cex=1.25, font=2)
  text(0.65, 0.95, "Complications", cex=1.25, font=2)
  text(0.8, 0.81, "Overall\n Health\n Status\n Improves", cex=1.25, font=2)
  text(0.9, 0.81, "Overall\n Health\n Status\n Worsens", cex=1.25, font=2)
  text(0.85, 0.95, "Overall Health Status\n Using Health Utilities", cex=1.25, font=2)
  #absominal Sacral Colpopexy - Comopsite
  text(0.3, 0.63, ifelse(pred.abs.recur < 0.006, "<0.5%", ifelse(pred.abs.recur > 0.995, ">99%", paste(round(pred.abs.recur*100, 1), "%", sep=""))), cex=2)
  #absominal Sacral Colpopexy - vaginal
  text(0.4, 0.63, ifelse(pred.abs.bulge < 0.006, "<0.5%", ifelse(pred.abs.bulge > 0.995, ">99%", paste(round(pred.abs.bulge*100, 1), "%", sep=""))), cex=2)
  #absominal Sacral Colpopexy - hymen
  text(0.5, 0.63, ifelse(pred.abs.hyman < 0.006, "<0.5%", ifelse(pred.abs.hyman > 0.995, ">99%", paste(round(pred.abs.hyman*100, 1), "%", sep=""))), cex=2)
  #absominal Sacral Colpopexy - sae
  text(0.6, 0.63, ifelse(pred.abs.sae < 0.006, "<0.5%", ifelse(pred.abs.sae > 0.995, ">99%", paste(round(pred.abs.sae*100, 1), "%", sep=""))), cex=2)
  #absominal Sacral Colpopexy - dindo
  text(0.7, 0.63, ifelse(pred.abs.dindo < 0.006, "<0.5%", ifelse(pred.abs.dindo > 0.995, ">99%", paste(round(pred.abs.dindo*100, 1), "%", sep=""))), cex=2)
  #absominal Sacral Colpopexy - mii
  text(0.8, 0.63, ifelse(pred.abs.mii < 0.006, "<0.5%", ifelse(pred.abs.mii > 0.995, ">99%", paste(round(pred.abs.mii*100, 1), "%", sep=""))), cex=2)
  #absominal Sacral Colpopexy - mid
  text(0.9, 0.63, ifelse(pred.abs.mid < 0.006, "<0.5%", ifelse(pred.abs.mid > 0.995, ">99%", paste(round(pred.abs.mid*100, 1), "%", sep=""))), cex=2)
  
  #SSLS - Comopsite
  text(0.3, 0.27, ifelse(pred.ssls.recur < 0.006, "<0.5%", ifelse(pred.ssls.recur > 0.995, ">99%", paste(round(pred.ssls.recur*100, 1), "%", sep=""))), cex=2)
  #SSLS - vaginal
  text(0.4, 0.27, ifelse(pred.ssls.bulge < 0.006, "<0.5%", ifelse(pred.ssls.bulge > 0.995, ">99%", paste(round(pred.ssls.bulge*100, 1), "%", sep=""))), cex=2)
  #SSLS - hymen
  text(0.5, 0.27, ifelse(pred.ssls.hymen < 0.006, "<0.5%", ifelse(pred.ssls.hymen > 0.995, ">99%", paste(round(pred.ssls.hymen*100, 1), "%", sep=""))), cex=2)
  #SSLS - sae
  text(0.6, 0.27, ifelse(pred.ssls.sae < 0.006, "<0.5%", ifelse(pred.ssls.sae > 0.995, ">99%", paste(round(pred.ssls.sae*100, 1), "%", sep=""))), cex=2)
  #SSLS - dindo
  text(0.7, 0.27, ifelse(pred.ssls.dindo < 0.006, "<0.5%", ifelse(pred.ssls.dindo > 0.995, ">99%", paste(round(pred.ssls.dindo*100, 1), "%", sep=""))), cex=2)
  #SSLS - mii
  text(0.8, 0.27, ifelse(pred.ssls.mii < 0.006, "<0.5%", ifelse(pred.ssls.mii > 0.995, ">99%", paste(round(pred.ssls.mii*100, 1), "%", sep=""))), cex=2)
  #SSLS - mid
  text(0.9, 0.27, ifelse(pred.ssls.mid < 0.006, "<0.5%", ifelse(pred.ssls.mid > 0.995, ">99%", paste(round(pred.ssls.mid*100, 1), "%", sep=""))), cex=2)
  
  #USLS - Comopsite
  text(0.3, 0.45, ifelse(pred.usls.recur < 0.006, "<0.5%", ifelse(pred.usls.recur > 0.995, ">99%", paste(round(pred.usls.recur*100, 1), "%", sep=""))), cex=2)
  #USLS - vagina
  text(0.4, 0.45, ifelse(pred.usls.bulge < 0.006, "<0.5%", ifelse(pred.usls.bulge > 0.995, ">99%", paste(round(pred.usls.bulge*100, 1), "%", sep=""))), cex=2)
  #USLS - hymen
  text(0.5, 0.45, ifelse(pred.usls.hymen < 0.006, "<0.5%", ifelse(pred.usls.hymen > 0.995, ">99%", paste(round(pred.usls.hymen*100, 1), "%", sep=""))), cex=2)
  #USLS - sae
  text(0.6, 0.45, ifelse(pred.usls.sae < 0.006, "<0.5%", ifelse(pred.usls.sae > 0.995, ">99%", paste(round(pred.usls.sae*100, 1), "%", sep=""))), cex=2)
  #USLS - dindo
  text(0.7, 0.45, ifelse(pred.usls.dindo < 0.006, "<0.5%", ifelse(pred.usls.dindo > 0.995, ">99%", paste(round(pred.usls.dindo*100, 1), "%", sep=""))), cex=2)
  #USLS - mii
  text(0.8, 0.45, ifelse(pred.usls.mii < 0.006, "<0.5%", ifelse(pred.usls.mii > 0.995, ">99%", paste(round(pred.usls.mii*100, 1), "%", sep=""))), cex=2)
  #USLS - mid
  text(0.9, 0.45, ifelse(pred.usls.mid < 0.006, "<0.5%", ifelse(pred.usls.mid > 0.995, ">99%", paste(round(pred.usls.mid*100, 1), "%", sep=""))), cex=2)
  
  #Colpocleisis - Comopsite
  text(0.3, 0.09, ifelse(pred.colpo.recur < 0.006, "<0.5%", ifelse(pred.colpo.recur > 0.995, ">99%", paste(round(pred.colpo.recur*100, 1), "%", sep=""))), cex=2)
  #Colpocleisis - vaginal
  text(0.4, 0.09, ifelse(pred.colpo.bulge < 0.006, "<0.5%", ifelse(pred.colpo.bulge > 0.995, ">99%", paste(round(pred.colpo.bulge*100, 1), "%", sep=""))), cex=2)
  #Colpocleisis - hymen
  text(0.5, 0.09, ifelse(pred.colpo.hymen < 0.006, "<0.5%", ifelse(pred.colpo.hymen > 0.995, ">99%", paste(round(pred.colpo.hymen*100, 1), "%", sep=""))), cex=2)
  #Colpocleisis - sae
  text(0.6, 0.09, ifelse(pred.colpo.sae < 0.006, "<0.5%", ifelse(pred.colpo.sae > 0.995, ">99%", paste(round(pred.colpo.sae*100, 1), "%", sep=""))), cex=2)
  #Colpocleisis - dindo
  text(0.7, 0.09, ifelse(pred.colpo.dindo < 0.006, "<0.5%", ifelse(pred.colpo.dindo > 0.995, ">99%", paste(round(pred.colpo.dindo*100, 1), "%", sep=""))), cex=2)
  #Colpocleisis - mii
  text(0.8, 0.09, ifelse(pred.colpo.mii < 0.006, "<0.5%", ifelse(pred.colpo.mii > 0.995, ">99%", paste(round(pred.colpo.mii*100, 1), "%", sep=""))), cex=2)
  #Colpocleisis - mid
  text(0.9, 0.09, ifelse(pred.colpo.mid < 0.006, "<0.5%", ifelse(pred.colpo.mid > 0.995, ">99%", paste(round(pred.colpo.mid*100, 1), "%", sep=""))), cex=2)
}
  
  
  

  

shinyServer(function(input, output){
  get_newdata <- reactive({
    new_df <- data.frame(AGE_SURGERY = input$AGE_SURGERY,
                         VPARITY = input$VPARITY,
                         RACE3 = factor(input$RACE3, levels = c("White", "Other", "Black")),
                         CARDIAC = factor(input$CARDIAC, levels = c("Yes", "No")),
                         uppergi = factor(input$uppergi, levels = c("Yes", "No")),
                         lowergi = factor(input$lowergi, levels = c("Yes", "No")),
                         VASCULAR = factor(input$VASCULAR, levels = c("Yes", "No")),
                         TISSUE = factor(input$TISSUE, levels = c("Yes", "No")),
                         SF36Q3 = factor(input$SF36Q3, levels = c("Limited a lot", "Not limited at all", "Limited a little")),
                         lifting = factor(input$lifting, levels = c("Less than once a month", "Once a month", "Two to three times a month", "Once a week", "More than once a week", "Never")),
                         smoking.status = factor(input$smoking.status, levels = c("Never", "Former", "Current")),
                         ESTROGEN = factor(input$ESTROGEN, levels = c("Yes", "No")),
                         anticoag = factor(input$anticoag, levels = c("Yes", "No")),
                         CMIRS_SUM = input$CMIRS_SUM,
                         HYSTERECTOMY = factor(input$HYSTERECTOMY, levels = c("Yes", "No")),
                         PRIORPOP = factor(input$PRIORPOP, levels = c("Yes", "No")),
                         BMI = input$BMI,
                         POPQ = factor(input$POPQ, levels = c("II", "III", "IV")),
                         C = input$C,
                         BA = input$BA,
                         BP = input$BP,
                         GH = input$GH,
                         anesthetics = factor(input$anesthetics, levels = c("Regional", "General")),
                         ANTERIORC = factor(input$ANTERIORC, levels = c("Yes", "No")),
                         POSTERIORC = factor(input$POSTERIORC, levels = c("Yes", "No")),
                         HYSTOOP = factor(input$HYSTOOP, levels = c("Yes", "No")),
                         ANTIURINE = factor(input$ANTIURINE, levels = c("Burch", "Sling/TVT", "Other", "None"))
                         )
    new_df
  })
  
  output$pred1 <- renderPlot({
    new.dat <- get_newdata()
    pred.abs.recur <- eval(compo.recur.abs, envir = new.dat)
    pred.abs.bulge <- eval(bother.bulge.abs, envir = new.dat)
    pred.abs.hyman <- eval(beyond.hymen.abs, envir = new.dat)
    pred.abs.sae <- eval(sae.1m.abs, envir = new.dat)
    pred.abs.dindo <- eval(dindo.1m.abs, envir = new.dat)
    pred.abs.mii <- eval(mii.abs, envir = new.dat)
    pred.abs.mid <- eval(mid.abs, envir = new.dat)
     
    pred.vag.recur <- eval(compo.recur.vag, envir = new.dat)
    pred.vag.bulge <- eval(bother.bulge.vag, envir = new.dat)
    pred.vag.bulge <- eval(beyond.hymen.vag, envir = new.dat)

    pred.usls.sae <- eval(sae.1m.ssls, envir = new.dat)
    pred.usls.dindo <- eval(dindo.1m.usls, envir = new.dat)
    pred.usls.mii <- eval(mii.usls, envir = new.dat)
    pred.usls.mid <- eval(mid.usls, envir = new.dat)
     
    pred.ssls.sae <- eval(sae.1m.ssls, envir = new.dat)
    pred.ssls.dindo <- eval(dindo.1m.ssls, envir = new.dat)
    pred.ssls.mii <- eval(mii.ssls, envir = new.dat)
    pred.ssls.mid <- eval(mid.ssls, envir = new.dat)
     
    pred.colpo.recur <- eval(compo.recur.colpo, envir = new.dat)
    pred.colpo.bulge <- eval(bother.bulge.colpo, envir = new.dat)
    pred.colpo.hyman <- eval(beyond.hymen.colpo, envir = new.dat)
    pred.colpo.sae <- eval(sae.1m.colpo, envir = new.dat)
    pred.colpo.dindo <- eval(dindo.1m.colpo, envir = new.dat)
    pred.colpo.mii <- eval(mii.colpo, envir = new.dat)
    pred.colpo.mid <- eval(mid.colpo, envir = new.dat)
    
pop.plot(pred.abs.recur,   pred.abs.bulge,   pred.abs.hyman,   pred.abs.sae,   pred.abs.dindo,   pred.abs.mii,   pred.abs.mid, 
         pred.vag.recur,   pred.vag.bulge,   pred.vag.bulge,   pred.usls.sae,  pred.usls.dindo,  pred.usls.mii,  pred.usls.mid, 
         pred.vag.recur,   pred.vag.bulge,   pred.vag.bulge,   pred.ssls.sae,  pred.ssls.dindo,  pred.ssls.mii,  pred.ssls.mid, 
         pred.colpo.recur, pred.colpo.bulge, pred.colpo.hyman, pred.colpo.sae, pred.colpo.dindo, pred.colpo.mii, pred.colpo.mid)

  })
  

  
})