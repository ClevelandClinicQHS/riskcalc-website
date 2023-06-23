predict.highgrade.dutasteride <- function(B_OPFPS,AGE,SBSRL,B_BMI,IMP,LIB,HIS_PCA,B_IPSS,B_QM,B_NOCOR,B_OPSA,B_PV,B_RSD,B_DRE) {
    score = -2.5995679 + 0.092685394 * AGE - 
        0.000042571616 * max(AGE - 55, 0)**3 + 
        0.000085143232 * max(AGE - 63, 0)**3 - 
        0.000042571616 * max(AGE - 71, 0)**3 - 
        0.02729155 * B_PV + 
        0.000003473756 * max(B_PV - 25.52, 0)**3 - 
        0.000005955998 * max(B_PV - 43.47, 0)**3 + 
        0.000002482242 * max(B_PV - 68.59, 0)**3 - 
        0.021879504 * B_NOCOR - 
        0.0013241433 * max(B_NOCOR - 6, 0)**3 + 
        0.0026482866 * max(B_NOCOR - 9, 0)**3 - 
        0.0013241433 * max(B_NOCOR - 12, 0)**3 + 
        0.1414056 * B_OPSA - 
        0.0038989431 * max(B_OPSA - 3.5, 0)**3 + 
        0.006758168 * max(B_OPSA - 5.7, 0)**3 - 
        0.0028592249 * max(B_OPSA - 8.7, 0)**3 - 
        0.1644022 * B_OPFPS + 
        0.00056993789 * max(B_OPFPS - 9.6774194, 0)**3 - 
        0.0010176765 * max(B_OPFPS - 16.071429, 0)**3 + 
        0.00044773859 * max(B_OPFPS - 24.210526, 0)**3 + 
        0.31134948 * (HIS_PCA == "Yes") - 
        0.52677693 * (B_DRE == "Yes") + 
        0.01188137 * B_BMI + 
        0.00011619678 * max(B_BMI - 23.15, 0)**3 - 
        0.00019842834 * max(B_BMI - 26.83, 0)**3 + 
        0.000082231564 * max(B_BMI - 32.03, 0)**3
    if (50 <= AGE && AGE <= 75 && 0 <= B_PV && B_PV <= 80 && 6 <= B_NOCOR && B_NOCOR <= 12 && 2 <= B_OPSA && B_OPSA <= 10 && 0 <= B_OPFPS && B_OPFPS <= 64 && HIS_PCA != "Unknown" && B_DRE != "Unknown" && 15 <= B_BMI && B_BMI <= 50) {
        round((1 - 0.9560246 ** exp(score)) * 100, 0)
    } else {
        "Not Applicable"
    }
}
predict.highgrade.nodutasteride <- function(B_OPFPS,AGE,SBSRL,B_BMI,IMP,LIB,HIS_PCA,B_IPSS,B_QM,B_NOCOR,B_OPSA,B_PV,B_RSD,B_DRE) {
    score = -5.291106 + 0.12865175 * AGE - 
        0.00011792908 * max(AGE - 55, 0)**3 + 
        0.00023585817 * max(AGE - 63, 0)**3 - 
        0.00011792908 * max(AGE - 71, 0)**3 - 
        0.041330344 * B_PV + 
        2.0545925e-05 * max(B_PV - 25.52, 0)**3 - 
        3.5227428e-05 * max(B_PV - 43.47, 0)**3 + 
        1.4681503e-05 * max(B_PV - 68.59, 0)**3 - 
        0.11735785 * B_NOCOR + 
        0.002743688 * max(B_NOCOR - 6, 0)**3 - 
        0.005487376 * max(B_NOCOR - 9, 0)**3 + 
        0.002743688 * max(B_NOCOR - 12, 0)**3 + 
        0.24274067 * B_OPSA - 
        0.0096728386 * max(B_OPSA - 3.5, 0)**3 + 
        0.016766254 * max(B_OPSA - 5.7, 0)**3 - 
        0.007093415 * max(B_OPSA - 8.7, 0)**3 - 
        0.14091258 * B_OPFPS + 
        0.00050049136 * max(B_OPFPS - 9.6774194, 0)**3 - 
        0.00089367332 * max(B_OPFPS - 16.071429, 0)**3 + 
        0.00039318196 * max(B_OPFPS - 24.210526, 0)**3 + 
        0.55482753 * (HIS_PCA == "Yes") - 
        0.1854322 * (B_DRE == "Yes") + 
        0.027549519 * B_BMI - 
        0.0003469818 * max(B_BMI - 23.15, 0)**3 + 
        0.00059253815 * max(B_BMI - 26.83, 0)**3 - 
        0.00024555635 * max(B_BMI - 32.03, 0)**3
    if (50 <= AGE && AGE <= 75 && 0 <= B_PV && B_PV <= 80 && 2 <= B_OPSA && B_OPSA <= 10 && 0 <= B_OPFPS && B_OPFPS <= 64 && HIS_PCA != "Unknown" && B_DRE != "Unknown" && 15 <= B_BMI && B_BMI <= 50) {
        round((1 - 0.9485273 ** exp(score)) * 100, 0)
    } else {
        "Not Applicable"
    }
}
predict.aur.dutasteride <- function(B_OPFPS,AGE,SBSRL,B_BMI,IMP,LIB,HIS_PCA,B_IPSS,B_QM,B_NOCOR,B_OPSA,B_PV,B_RSD,B_DRE) {
    score = 1.1645202 - 
        0.061061932 * AGE + 
        0.00021214229 * max(AGE - 55, 0) ** 3 - 
        0.00042428457 * max(AGE - 63, 0) ** 3 + 
        0.00021214229 * max(AGE - 71, 0) ** 3 -
        0.0089110256 * B_PV + 
        0.0000079993515 * max(B_PV - 25.52, 0) ** 3 - 
        0.000013715449 * max(B_PV - 43.47, 0) ** 3 + 
        0.0000057160971 * max(B_PV - 68.59, 0) ** 3 + 
        0.32260345 * B_OPSA - 
        0.014797257 * max(B_OPSA - 3.5, 0) ** 3 + 
        0.025648579 * max(B_OPSA - 5.7, 0) ** 3 - 
        0.010851322 * max(B_OPSA - 8.7, 0) ** 3 + 
        0.13327946 * B_IPSS - 
        0.0003871158 * max(B_IPSS - 2, 0) ** 3 + 
        0.00064519299 * max(B_IPSS - 8, 0) ** 3 - 
        0.0002580772 * max(B_IPSS - 17, 0) ** 3 + 
        0.01045639 * B_QM - 
        0.00016491276 * max(B_QM - 7.8, 0) ** 3 + 
        0.00025179364 * max(B_QM - 13.2, 0) ** 3 - 
        0.000086880871 * max(B_QM - 23.45, 0) ** 3 + 
        0.008271271 * B_RSD - 
        0.00000029329635 * max(B_RSD, 0) ** 3 + 
        0.0000009545575 * max(B_RSD - 31, 0) ** 3 - 
        0.0000001021594 * max(B_RSD - 120, 0) ** 3
    if (50 <= AGE && AGE <= 75 && 0 <= B_PV && B_PV <= 80 && 2 <= B_OPSA && B_OPSA <= 88 && 0 <= B_IPSS && B_IPSS <= 25 && 0 <= B_QM && B_QM <= 100 && B_RSD >= 0 ) {
        round((1 - 0.9881902 ** exp(score)) * 100, 0)
    } else {
        "Not Applicable"
    }
}
predict.aur.nodutasteride <- function(B_OPFPS,AGE,SBSRL,B_BMI,IMP,LIB,HIS_PCA,B_IPSS,B_QM,B_NOCOR,B_OPSA,B_PV,B_RSD,B_DRE) {
    score = -1.0281503 - 
        0.00076540945 * AGE - 
        0.000069130129 * max(AGE - 55, 0) ** 3 + 
        0.00013826026 * max(AGE - 63, 0)**3 - 
        0.000069130129 * max(AGE - 71, 0)**3 + 
        0.045963842 * B_PV - 
        0.000017356701 * max(B_PV - 25.52, 0)**3 + 
        0.000029759281 * max(B_PV - 43.47, 0)**3 - 
        0.000012402579 * max(B_PV - 68.59, 0)**3 + 
        0.0023571984 * B_OPSA + 
        0.00008654012 * max(B_OPSA - 3.5, 0)**3 - 
        0.00015000288 * max(B_OPSA - 5.7, 0)**3 + 
        0.000063462755 * max(B_OPSA - 8.7, 0)**3 + 
        0.087108858 * B_IPSS - 
        0.00025960794 * max(B_IPSS - 2, 0)**3 + 
        0.00043267991 * max(B_IPSS - 8, 0)**3 - 
        0.00017307196 * max(B_IPSS - 17, 0)**3 - 
        0.11685329 * B_QM + 
        0.00045782518 * max(B_QM - 7.8, 0)**3 - 
        0.00069902089 * max(B_QM - 13.2, 0)**3 + 
        0.0002411957 * max(B_QM - 23.45, 0)**3 + 
        0.0061259723 * B_RSD - 
        0.00000057253793 * max(B_RSD, 0)**3 + 
        0.00000077196125 * max(B_RSD - 31, 0)**3 - 
        0.00000019942332 * max(B_RSD - 120, 0)**3
    if (50 <= AGE && AGE <= 75 && 0 <= B_PV && B_PV <= 80 && 2 <= B_OPSA && B_OPSA <= 88 && 0 <= B_IPSS && B_IPSS <= 25 && 0 <= B_QM && B_QM <= 100 && B_RSD >= 0) {
        round((1 - 0.9424894 ** exp(score)) * 100, 0)
    } else {
        "Not Applicable"
    }
}
predict.bph.dutasteride <- function(B_OPFPS,AGE,SBSRL,B_BMI,IMP,LIB,HIS_PCA,B_IPSS,B_QM,B_NOCOR,B_OPSA,B_PV,B_RSD,B_DRE) {
    score = -5.1794212 + 0.082837869 * AGE - 
        0.00019166777 * max(AGE - 55, 0)**3 + 
        0.00038333555 * max(AGE - 63, 0)**3 - 
        0.00019166777 * max(AGE - 71, 0)**3 + 
        0.019842467 * B_PV - 
        7.9898849e-06 * max(B_PV - 25.52, 0)**3 + 
        1.3699217e-05 * max(B_PV - 43.47, 0)**3 - 
        5.7093326e-06 * max(B_PV - 68.59, 0)**3 + 
        0.024113451 * B_OPSA + 
        0.0020938172 * max(B_OPSA - 3.5, 0)**3 - 
        0.0036292832 * max(B_OPSA - 5.7, 0)**3 + 
        0.001535466 * max(B_OPSA - 8.7, 0)**3 - 
        0.084429276 * B_IPSS + 
        0.0007641629 * max(B_IPSS - 2, 0)**3 - 
        0.0012736048 * max(B_IPSS - 8, 0)**3 + 
        0.00050944193 * max(B_IPSS - 17, 0)**3 - 
        0.040246013 * B_QM + 
        8.79458e-05 * max(B_QM - 7.8, 0)**3 - 
        0.00013427822 * max(B_QM - 13.2, 0)**3 + 
        4.6332421e-05 * max(B_QM - 23.45, 0)**3 + 
        0.0028358349 * B_RSD - 
        6.8147752e-07 * max(B_RSD, 0)**3 + 
        9.188461e-07 * max(B_RSD - 31, 0)**3 - 
        2.3736857e-07 * max(B_RSD - 120, 0)**3
    if (50 <= AGE && AGE <= 75 && 0 <= B_PV && B_PV <= 80 && 2 <= B_OPSA && B_OPSA <= 88 && 0 <= B_IPSS && B_IPSS <= 25 && 0 <= B_QM && B_QM <= 100 && B_RSD >= 0) {
        round((1 - 0.9880496 ** exp(score)) * 100, 0)
    } else {
        "Not Applicable"
    }
}
predict.bph.nodutasteride <- function(B_OPFPS,AGE,SBSRL,B_BMI,IMP,LIB,HIS_PCA,B_IPSS,B_QM,B_NOCOR,B_OPSA,B_PV,B_RSD,B_DRE) {
    score = -2.5335304 + 0.025530334 * AGE - 
        0.00027794159 * max(AGE - 55, 0)**3 + 
        0.00055588319 * max(AGE - 63, 0)**3 - 
        0.00027794159 * max(AGE - 71, 0)**3 + 
        0.031405179 * B_PV - 
        0.000011141665 * max(B_PV - 25.52, 0)**3 + 
        0.000019103165 * max(B_PV - 43.47, 0)**3 - 
        0.0000079615 * max(B_PV - 68.59, 0)**3 - 
        0.011456454 * B_OPSA + 
        0.0030614148 * max(B_OPSA - 3.5, 0)**3 - 
        0.0053064523 * max(B_OPSA - 5.7, 0)**3 + 
        0.0022450375 * max(B_OPSA - 8.7, 0)**3 + 
        0.17153886 * B_IPSS - 
        0.00050278585 * max(B_IPSS - 2, 0)**3 + 
        0.00083797642 * max(B_IPSS - 8, 0)**3 - 
        0.00033519057 * max(B_IPSS - 17, 0)**3 - 
        0.10624904 * B_QM + 
        0.00037314418 * max(B_QM - 7.8, 0)**3 - 
        0.00056972746 * max(B_QM - 13.2, 0)**3 + 
        0.00019658328 * max(B_QM - 23.45, 0)**3 + 
        0.0047543213 * B_RSD - 
        0.00000044918222 * max(B_RSD, 0)**3 + 
        0.00000060563894 * max(B_RSD - 31, 0)**3 - 
        0.00000015645673 * max(B_RSD - 120, 0)**3
    if (50 <= AGE && AGE <= 75 && 0 <= B_PV && B_PV <= 80 && 2 <= B_OPSA && B_OPSA <= 88 && 0 <= B_IPSS && B_IPSS <= 25 && 0 <= B_QM && B_QM <= 100 && B_RSD >= 0) {
        round((1 - 0.9621862 ** exp(score)) * 100, 0)
    } else {
        "Not Applicable"
    }
}
predict.erectile.dutasteride <- function(B_OPFPS,AGE,SBSRL,B_BMI,IMP,LIB,HIS_PCA,B_IPSS,B_QM,B_NOCOR,B_OPSA,B_PV,B_RSD,B_DRE) {
    score = -0.82555754 + 
        0.0021009936 * AGE - 
        0.00018470233 * max(AGE - 55, 0)**3 + 
        0.00036940465 * max(AGE - 63, 0)**3 - 
        0.00018470233 * max(AGE - 71, 0)**3 + 
        1.0040617 * (SBSRL == "Yes") + 
        0.29803134 * (LIB == "Yes") - 
        0.0028454973 * (IMP == "Yes")
    if (50 <= AGE && AGE<= 75 && SBSRL != "Unknown" && LIB != "Unknown" && IMP != "Unknown") {
        round((1 - 0.8331268 ** exp(score)) * 100, 0)
    } else {
        "Not Applicable"
    }
}
predict.erectile.nodutasteride <- function(B_OPFPS,AGE,SBSRL,B_BMI,IMP,LIB,HIS_PCA,B_IPSS,B_QM,B_NOCOR,B_OPSA,B_PV,B_RSD,B_DRE) {
    score = 0.49218732 - 0.017043475 * AGE - 
        0.000099164052 * max(AGE - 55, 0)**3 + 
        0.0001983281 * max(AGE - 63, 0)**3 - 
        0.000099164052 * max(AGE - 71, 0)**3 + 
        0.67408096 * (SBSRL == "Yes") + 
        0.28603854 * (LIB == "Yes") + 
        0.21585816 * (IMP == "Yes")
    if (50 <= AGE && AGE <= 75 && SBSRL != "Unknown" && LIB != "Unknown" && IMP != "Unknown") {
        round((1 - 0.8792946 ** exp(score)) * 100, 0)
    } else {
        "Not Applicable"
    }
}
predict.gynecomastia.dutasteride <- function(B_OPFPS,AGE,SBSRL,B_BMI,IMP,LIB,HIS_PCA,B_IPSS,B_QM,B_NOCOR,B_OPSA,B_PV,B_RSD,B_DRE) {
    score = -1.6541886 + 
        0.013380387 * AGE - 
        0.000025127812 * max(AGE - 55, 0)**3 + 
        0.000050255624 * max(AGE - 63, 0)**3 - 
        0.000025127812 * max(AGE - 71, 0)**3 + 
        0.030085377 * B_BMI + 
        0.0001100241 * max(B_BMI - 23.15, 0)**3 - 
        0.00018788731 * max(B_BMI - 26.83, 0)**3 + 
        0.00007786321 * max(B_BMI - 32.03, 0)**3
    if (50 <= AGE && AGE <= 75 && 15 <= B_BMI && B_BMI<= 50) {
        round((1 - 0.9634263 ** exp(score)) * 100, 0)
    } else {
        "Not Applicable"
    }
}
predict.gynecomastia.nodutasteride <- function(B_OPFPS,AGE,SBSRL,B_BMI,IMP,LIB,HIS_PCA,B_IPSS,B_QM,B_NOCOR,B_OPSA,B_PV,B_RSD,B_DRE) {
    score = -2.0653904 - 
        0.0019965622 * AGE - 
        0.00001577009 * max(AGE - 55, 0)**3 + 
        0.00003154018 * max(AGE - 63, 0)**3 - 
        0.00001577009 * max(AGE - 71, 0)**3 + 
        0.083659972 * B_BMI - 
        0.0005061525 * max(B_BMI - 23.15, 0)**3 + 
        0.00086435274 * max(B_BMI - 26.83, 0)**3 - 
        0.00035820023 * max(B_BMI - 32.03, 0)**3
    if (50 <= AGE && AGE <= 75 && 15 <= B_BMI && B_BMI <= 50) {
        round((1 - 0.9783186 ** exp(score)) * 100, 0)
    } else {
        "Not Applicable"
    }
}
predict.hgpin.dutasteride <- function(B_OPFPS,AGE,SBSRL,B_BMI,IMP,LIB,HIS_PCA,B_IPSS,B_QM,B_NOCOR,B_OPSA,B_PV,B_RSD,B_DRE) {
    if (50 <= AGE && AGE <= 75 && 0 <= B_PV && B_PV <= 80 && 6 <= B_NOCOR && B_NOCOR <= 12 && 2 <= B_OPSA && B_OPSA <= 10 && 0 <= B_OPFPS && B_OPFPS <= 64 && HIS_PCA != "Unknown" && B_DRE != "Unknown" && 15 <= B_BMI && B_BMI <= 50) {
        paste(round(0.03838831 * 100, 0), '%', sep='')
    } else {
        "Not Applicable" 
    }
}
predict.hgpin.nodutasteride <- function(B_OPFPS,AGE,SBSRL,B_BMI,IMP,LIB,HIS_PCA,B_IPSS,B_QM,B_NOCOR,B_OPSA,B_PV,B_RSD,B_DRE) {
    score = 0.02314685 * AGE + 
        9.462079e-05 * max(AGE - 55, 0)**3 - 
        0.00018924158 * max(AGE - 63, 0)**3 + 
        9.462079e-05 * max(AGE - 71, 0)**3 - 
        0.0076597772 * B_PV + 
        2.1045322e-06 * max(B_PV - 25.52, 0)**3 - 
        3.6083679e-06 * max(B_PV - 43.47, 0)**3 + 
        1.5038357e-06 * max(B_PV - 68.59, 0)**3 + 
        0.024188546 * B_NOCOR + 
        0.00028423913 * max(B_NOCOR - 6, 0)**3 - 
        0.00056847825 * max(B_NOCOR - 9, 0)**3 + 
        0.00028423913 * max(B_NOCOR - 12, 0)**3 - 
        0.035761911 * B_OPSA + 
        0.0018467184 * max(B_OPSA - 3.5, 0)**3 - 
        0.0032009786 * max(B_OPSA - 5.7, 0)**3 + 
        0.0013542602 * max(B_OPSA - 8.7, 0)**3 + 
        0.031267747 * B_OPFPS - 
        0.00013307385 * max(B_OPFPS - 9.6774194, 0)**3 + 
        0.00023761559 * max(B_OPFPS - 16.071429, 0)**3 - 
        0.00010454174 * max(B_OPFPS - 24.210526, 0)**3 + 
        0.096023267 * (HIS_PCA == "Yes") - 
        0.15972617 * (B_DRE == "Yes") - 
        0.046172021 * B_BMI + 
        0.00088524838 * max(B_BMI - 23.15, 0)**3 - 
        0.0015117318 * max(B_BMI - 26.83, 0)**3 + 
        0.00062648347 * max(B_BMI - 32.03, 0)**3
    if (50 <= AGE && AGE <= 75 && 0 <= B_PV && B_PV <= 80 && 6 <= B_NOCOR && B_NOCOR <= 12 && 2 <= B_OPSA && B_OPSA <= 10 && 0 <= B_OPFPS && B_OPFPS <= 64 && HIS_PCA != "Unknown" && B_DRE != "Unknown" && 15 <= B_BMI && B_BMI <= 50) {
        round((1 - 0.9676886 ** exp(score)) * 100, 0)
    } else {
        "Not Applicable" 
    }
}
predict.prostate.dutasteride <- function(B_OPFPS,AGE,SBSRL,B_BMI,IMP,LIB,HIS_PCA,B_IPSS,B_QM,B_NOCOR,B_OPSA,B_PV,B_RSD,B_DRE) {
    score = -3.2873301 + 0.062184251 * AGE - 
        7.1247133e-05 * max(AGE - 55, 0)**3 + 
        0.00014249427 * max(AGE - 63, 0)**3 - 
        7.1247133e-05 * max(AGE - 71, 0)**3 - 
        0.013281746 * B_PV + 
        4.2085264e-08 * max(B_PV - 25.52, 0)**3 - 
        7.2158134e-08 * max(B_PV - 43.47, 0)**3 + 
        3.007287e-08 * max(B_PV - 68.59, 0)**3 - 
        0.020945724 * B_NOCOR - 
        0.0013792832 * max(B_NOCOR - 6, 0)**3 + 
        0.0027585664 * max(B_NOCOR - 9, 0)**3 - 
        0.0013792832 * max(B_NOCOR - 12, 0)**3 + 
        0.092260347 * B_OPSA - 
        0.003146994 * max(B_OPSA - 3.5, 0)**3 + 
        0.0054547896 * max(B_OPSA - 5.7, 0)**3 - 
        0.0023077956 * max(B_OPSA - 8.7, 0)**3 - 
        0.069689053 * B_OPFPS + 
        0.00024776037 * max(B_OPFPS - 9.6774194, 0)**3 - 
        0.0004423989 * max(B_OPFPS - 16.071429, 0)**3 + 
        0.00019463854 * max(B_OPFPS - 24.210526, 0)**3 + 
        0.32320144 * (HIS_PCA == "Yes") - 
        0.091053957 * (B_DRE == "Yes") + 
        0.035915989 * B_BMI - 
        0.0005530593 * max(B_BMI - 23.15, 0)**3 + 
        0.00094445511 * max(B_BMI - 26.83, 0)**3 - 
        0.00039139581 * max(B_BMI - 32.03, 0)**3
    if (50 <= AGE && AGE <= 75 && 0 <= B_PV && B_PV <= 80 && 6 <= B_NOCOR && B_NOCOR <= 12 && 2 <= B_OPSA && B_OPSA <= 10 && 0 <= B_OPFPS && B_OPFPS <= 64 && HIS_PCA != "Unknown" && B_DRE != "Unknown" && 15 <= B_BMI && B_BMI<= 50) {
        round((1 - 0.8443213 ** exp(score)) * 100, 0)
    } else {
        "Not Applicable" 
    }
}
predict.prostate.nodutasteride <- function(B_OPFPS,AGE,SBSRL,B_BMI,IMP,LIB,HIS_PCA,B_IPSS,B_QM,B_NOCOR,B_OPSA,B_PV,B_RSD,B_DRE) {
    score = -2.0022764 + 0.056199639 * AGE- 
        0.000015829258 * max(AGE-55,0) ** 3 + 
        0.000031658515 * max(AGE-63,0) ** 3- 
        0.000015829258 * max(AGE-71,0) ** 3- 
        0.028379627 * B_PV + 
        0.00001559305 * max(B_PV-25.52,0) ** 3- 
        0.000026735376 * max(B_PV-43.47,0) ** 3 + 
        0.000011142327 * max(B_PV-68.59,0) ** 3- 
        0.055600097 * B_NOCOR + 
        0.00089358345 * max(B_NOCOR-6,0) ** 3- 
        0.0017871669 * max(B_NOCOR-9,0) ** 3 + 
        0.00089358345 * max(B_NOCOR-12,0) ** 3 + 
        0.16137068 * B_OPSA- 
        0.0067701874 * max(B_OPSA-3.5,0) ** 3 + 
        0.011734992 * max(B_OPSA-5.7,0) ** 3- 
        0.0049648041 * max(B_OPSA-8.7,0) ** 3 - 
        0.066716939 * B_OPFPS + 
        0.00017396904 * max(B_OPFPS-9.6774194,0) ** 3- 
        0.00031063771 * max(B_OPFPS-16.071429,0) ** 3 +  
        0.00013666867 * max(B_OPFPS-24.210526,0) ** 3 + 
        0.43429612 * (HIS_PCA == "Yes")- 
        0.25508281 * (B_DRE == "Yes")+ 
        0.016145135 * B_BMI- 
        0.00038880393 * max(B_BMI-23.15,0) ** 3 + 
        0.00066395748 * max(B_BMI-26.83,0) ** 3- 
        0.00027515355 * max(B_BMI-32.03,0) ** 3
    if (50 <= AGE && AGE <= 75 && 0 <= B_PV && B_PV <= 80 && 6 <= B_NOCOR && B_NOCOR <= 12 && 2 <= B_OPSA && B_OPSA <= 10 && 0 <= B_OPFPS && B_OPFPS <= 64 && HIS_PCA != "Unknown" && B_DRE != "Unknown" && 15 <= B_BMI && B_BMI<= 50) {
        round((1 - 0.7987971 ** exp(score)) * 100, 0)
    } else {
        "Not Applicable" 
    }
}
predict.uti.dutasteride <- function(B_OPFPS,AGE,SBSRL,B_BMI,IMP,LIB,HIS_PCA,B_IPSS,B_QM,B_NOCOR,B_OPSA,B_PV,B_RSD,B_DRE) {
    score = -0.33966523 + 0.014924564 * B_QM - 
        0.000075239732 * max(B_QM - 7.8, 0)**3 + 
        0.00011487823 * max(B_QM - 13.2, 0)**3 - 
        0.000039638493 * max(B_QM - 23.45, 0)**3 + 
        0.0059938379 * B_RSD - 
        0.00000048861775 * max(B_RSD, 0)**3 + 
        0.00000065881045 * max(B_RSD - 31, 0)**3 - 
        0.0000001701927 * max(B_RSD - 120, 0)**3
    if (0 <= B_QM && B_QM <= 100 && B_RSD >= 0) {
        round((1 - 0.9433828 ** exp(score)) * 100, 0)
    } else {
        "Not Applicable" 
    }
}
predict.uti.nodutasteride <- function(B_OPFPS,AGE,SBSRL,B_BMI,IMP,LIB,HIS_PCA,B_IPSS,B_QM,B_NOCOR,B_OPSA,B_PV,B_RSD,B_DRE) {
    score = 0.66770954 - 0.069385484 * B_QM + 
        0.00028417274 * max(B_QM - 7.8, 0)**3 - 
        0.00043388325 * max(B_QM - 13.2, 0)**3 + 
        0.00014971051 * max(B_QM - 23.45, 0)**3 + 
        0.0061318174 * B_RSD - 
        0.00000062268412 * max(B_RSD, 0)**3 + 
        0.0000008395741 * max(B_RSD - 31, 0)**3 - 
        0.00000021688997 * max(B_RSD - 120, 0)**3
    if (0 <= B_QM && B_QM <= 100 && B_RSD >= 0) {
        round((1 - 0.9433828 ** exp(score)) * 100, 0)
    } else {
        "Not Applicable" 
    }
}
predict.asap.dutasteride <- function(B_OPFPS,AGE,SBSRL,B_BMI,IMP,LIB,HIS_PCA,B_IPSS,B_QM,B_NOCOR,B_OPSA,B_PV,B_RSD,B_DRE) {
    score = -0.0011455882 * AGE + 
        3.4941473e-05 * max(AGE - 55,0) ** 3 - 
        6.9882947e-05 * max(AGE - 63, 0) ** 3 + 
        3.4941473e-05 * max(AGE - 71, 0) ** 3 - 
        0.013058082 * B_PV + 
        2.2486763e-06 * max(B_PV - 25.52, 0) ** 3 - 
        3.855513e-06 * max(B_PV - 43.47, 0) ** 3 + 
        1.6068367e-06 * max(B_PV - 68.59, 0) ** 3 -
        0.11978819 * B_NOCOR + 
        0.0048529883 * max(B_NOCOR - 6, 0) ** 3 - 
        0.0097059765 * max(B_NOCOR - 9, 0) ** 3 + 
        0.0048529883 * max(B_NOCOR - 12, 0) ** 3 + 
        0.17271687 * B_OPSA - 
        0.004776089 * max(B_OPSA - 3.5, 0) ** 3 + 
        0.0082785543 * max(B_OPSA - 5.7, 0) ** 3 - 
        0.0035024653 * max(B_OPSA - 8.7, 0) ** 3 + 
        0.044464692 * B_OPFPS - 
        0.00025552455 * max(B_OPFPS - 9.6774194, 0) ** 3 + 
        0.00045626256 * max(B_OPFPS - 16.071429, 0) ** 3 - 
        0.00020073801 * max(B_OPFPS - 24.210526, 0) ** 3 + 
        0.5100204 * (HIS_PCA == "Yes") - 
        0.2273623 * (B_DRE == "Yes") - 
        0.0047034328 * B_BMI - 
        0.00019338575 * max(B_BMI - 23.15, 0) ** 3 + 
        0.00033024336 * max(B_BMI - 26.83, 0) ** 3 - 
        0.00013685761 * max(B_BMI - 32.03, 0) ** 3
    if (B_OPFPS >= 0 && B_OPFPS <= 64) {
        round((1 - 0.9523463 ** exp(score)) * 100, 0)
    } else {
        "Not Applicable" 
    }
}
pretty_pred = function(prob) {
    if (prob < 1) {
        '<1%'
    } else if (prob > 99) {
        '>99%'
    } else {
        paste(prob, '%', sep='')
    }
}

library(shiny)
shinyServer(function(input, output, session){
    data <- eventReactive(input$goButton, {
        validate(need(is.na(as.numeric(input$B_OPFPS))|(!is.na(as.numeric(input$B_OPFPS))&& as.numeric(input$B_OPFPS)>=2&& as.numeric(input$B_OPFPS)<=64), 'Please input a valid % free PSA'))
        B_OPFPS= ifelse(is.na(as.numeric(input$B_OPFPS)), 16.176, as.numeric(input$B_OPFPS))
        validate(need(!is.na(as.numeric(input$AGE))&& as.numeric(input$AGE)>=50&& as.numeric(input$AGE)<=75, 'Please input a valid age'))
        AGE= as.numeric(input$AGE)
        SBSRL = factor(input$SBSRL, levels = c('No', 'Yes', 'Unknown'))
        validate(need(is.na(as.numeric(input$B_BMI))|(!is.na(as.numeric(input$B_BMI))&& as.numeric(input$B_BMI)>=15&& as.numeric(input$B_BMI)<=50), 'Please input a valid BMI'))
        B_BMI= ifelse(is.na(as.numeric(input$B_BMI)), 26.89, as.numeric(input$B_BMI))
        IMP = factor(input$IMP, levels = c('No', 'Yes', 'Unknown'))
        LIB = factor(input$LIB, levels = c('No', 'Yes', 'Unknown'))
        HIS_PCA = factor(input$HIS_PCA, levels = c('No', 'Yes', 'Unknown'))
        validate(need(is.na(as.numeric(input$B_IPSS))|(!is.na(as.numeric(input$B_IPSS))&& as.numeric(input$B_IPSS)>=0&& as.numeric(input$B_IPSS)<=25), 'Please input a valid IPSS score'))
        B_IPSS= ifelse(is.na(as.numeric(input$B_IPSS)), 8, as.numeric(input$B_IPSS))
        validate(need(is.na(as.numeric(input$B_QM))|(!is.na(as.numeric(input$B_QM))&& as.numeric(input$B_QM)>=0&& as.numeric(input$B_QM)<=50), 'Please input a valid maximum urinary flow rate'))
        B_QM= ifelse(is.na(as.numeric(input$B_QM)), 13.2, as.numeric(input$B_QM))
        validate(need(is.na(as.numeric(input$B_NOCOR))|(!is.na(as.numeric(input$B_NOCOR))&& as.numeric(input$B_NOCOR)>=6&& as.numeric(input$B_NOCOR)<=12), 'Please input a valid number of biopsy cores'))
        B_NOCOR= ifelse(is.na(as.numeric(input$B_NOCOR)), 9, as.numeric(input$B_NOCOR))
        validate(need(!is.na(as.numeric(input$B_OPSA))&& as.numeric(input$B_OPSA)>=2&& as.numeric(input$B_OPSA)<=10, 'Please input a valid PSA'))
        B_OPSA= as.numeric(input$B_OPSA)
        validate(need(is.na(as.numeric(input$B_PV))|(!is.na(as.numeric(input$B_PV))&& as.numeric(input$B_PV)>=15&& as.numeric(input$B_PV)<=75), 'Please input a valid prostate volume'))
        B_PV= ifelse(is.na(as.numeric(input$B_PV)), 43.4, as.numeric(input$B_PV))
        validate(need(is.na(as.numeric(input$B_RSD))|(!is.na(as.numeric(input$B_RSD))&& as.numeric(input$B_RSD)>=0&& as.numeric(input$B_RSD)<=150), 'Please input a valid residual urine volume'))
        B_RSD= ifelse(is.na(as.numeric(input$B_RSD)), 30, as.numeric(input$B_RSD))
        B_DRE = factor(input$B_DRE, levels = c('Normal', 'Abnormal', 'Unknown'))
        data <- data.frame(B_OPFPS = B_OPFPS,
                           AGE = AGE,
                           SBSRL = SBSRL,
                           B_BMI = B_BMI,
                           IMP = IMP,
                           LIB = LIB,
                           HIS_PCA = HIS_PCA,
                           B_IPSS = B_IPSS,
                           B_QM = B_QM,
                           B_NOCOR = B_NOCOR,
                           B_OPSA = B_OPSA,
                           B_PV = B_PV,
                           B_RSD = B_RSD,
                           B_DRE = B_DRE)
        data})
    
    data_expand <- eventReactive(input$goButton, {
        B_OPFPS = if(is.na(as.numeric(input$B_OPFPS))) c(2, 64) else as.numeric(input$B_OPFPS)
        AGE= as.numeric(input$AGE)
        SBSRL = factor(input$SBSRL, levels = c('No', 'Yes', 'Unknown'))
        B_BMI = if(is.na(as.numeric(input$B_BMI))) c(15, 50) else as.numeric(input$B_BMI)
        IMP = factor(input$IMP, levels = c('No', 'Yes', 'Unknown'))
        LIB = factor(input$LIB, levels = c('No', 'Yes', 'Unknown'))
        HIS_PCA = factor(input$HIS_PCA, levels = c('No', 'Yes', 'Unknown'))
        B_IPSS = if(is.na(as.numeric(input$B_IPSS))) c(0, 25) else as.numeric(input$B_IPSS)
        B_QM = if(is.na(as.numeric(input$B_QM))) c(0, 50) else as.numeric(input$B_QM)
        B_NOCOR = if(is.na(as.numeric(input$B_NOCOR))) c(6, 12) else as.numeric(input$B_NOCOR)
        B_OPSA= as.numeric(input$B_OPSA)
        B_PV = if(is.na(as.numeric(input$B_PV))) c(0, 75) else as.numeric(input$B_PV)
        B_RSD = if(is.na(as.numeric(input$B_RSD))) c(0, 150) else as.numeric(input$B_RSD)
        B_DRE = factor(input$B_DRE, levels = c('Normal', 'Abnormal', 'Unknown'))
        data <- expand.grid(B_OPFPS = B_OPFPS,
                            AGE = AGE,
                            SBSRL = SBSRL,
                            B_BMI = B_BMI,
                            IMP = IMP,
                            LIB = LIB,
                            HIS_PCA = HIS_PCA,
                            B_IPSS = B_IPSS,
                            B_QM = B_QM,
                            B_NOCOR = B_NOCOR,
                            B_OPSA = B_OPSA,
                            B_PV = B_PV,
                            B_RSD = B_RSD,
                            B_DRE = B_DRE)
        data})
    
    output$note <- renderText({
        if (input$goButton == 0) return(NULL)
        input$goButton
        isolate({
            if (is.na(as.numeric(input$B_OPFPS))||is.na(as.numeric(input$B_BMI))||is.na(as.numeric(input$B_QM))||
                is.na(as.numeric(input$B_NOCOR))||is.na(as.numeric(input$B_PV))||is.na(as.numeric(input$B_IPSS))||
                is.na(as.numeric(input$B_RSD))) {
                    "NOTE: You have omitted one or more optional predictors.  
                     The predictions above are the most accurate ones we have based on the values provided.  
                     Numbers in parentheses indicate the range of the predictions possible if missing value(s) are obtained."
            } else {
            NULL
        }
        })
    })
    
    output$result <- renderDataTable({
        input$goButton
        isolate({
            data = data()
            data_expand = data_expand()
            
            withProgress(message = 'Calculation in progress',
                         detail = 'This may take a while...', value = 0, {
                             for (i in 1:8) {
                                 incProgress(1/8)
                                 Sys.sleep(0.15)
                             }
                         })
            
            prob.hgpc.d <- do.call(predict.highgrade.dutasteride, data)
            prob.hgpc.nd <- do.call(predict.highgrade.nodutasteride, data)
            prob.aur.d <- do.call(predict.aur.dutasteride, data)
            prob.aur.nd <- do.call(predict.aur.nodutasteride, data)
            prob.bph.d <- do.call(predict.bph.dutasteride, data)
            prob.bph.nd <- do.call(predict.bph.nodutasteride, data)
            prob.erectile.d <- do.call(predict.erectile.dutasteride, data)
            prob.erectile.nd <- do.call(predict.erectile.nodutasteride, data)
            prob.gynecomastia.d <- do.call(predict.gynecomastia.dutasteride, data)
            prob.gynecomastia.nd <- do.call(predict.gynecomastia.nodutasteride, data)
            prob.hgpin.d <- do.call(predict.hgpin.dutasteride, data)
            prob.hgpin.nd <- do.call(predict.hgpin.nodutasteride, data)
            prob.prostate.d <- do.call(predict.prostate.dutasteride, data)
            prob.prostate.nd <- do.call(predict.prostate.nodutasteride, data)
            prob.uti.d <- do.call(predict.uti.dutasteride, data)
            prob.uti.nd <- do.call(predict.uti.nodutasteride, data)
            prob.asap.d <- do.call(predict.asap.dutasteride, data)
            
            if (prob.hgpc.d != "Not Applicable") {
                prob.hgpc.d <- pretty_pred(prob.hgpc.d)
                if (is.na(as.numeric(input$B_OPFPS))||is.na(as.numeric(input$B_BMI))||
                    is.na(as.numeric(input$B_NOCOR))||is.na(as.numeric(input$B_PV))||
                    is.na(as.numeric(input$B_RSD))) {
                    prob.hgpc.d.lower = min(sapply(split(data_expand, 1:nrow(data_expand)), function(x){do.call(predict.highgrade.dutasteride, x)}))
                    prob.hgpc.d.upper = max(sapply(split(data_expand, 1:nrow(data_expand)), function(x){do.call(predict.highgrade.dutasteride, x)}))
                    prob.hgpc.d <- paste(prob.hgpc.d, '(', pretty_pred(prob.hgpc.d.lower), ", ", pretty_pred(prob.hgpc.d.upper), ')', sep='')
                }
            }
            if (prob.hgpc.nd != "Not Applicable") {
                prob.hgpc.nd <- pretty_pred(prob.hgpc.nd)
                if(is.na(as.numeric(input$B_OPFPS))||is.na(as.numeric(input$B_BMI))||
                   is.na(as.numeric(input$B_NOCOR))||is.na(as.numeric(input$B_PV))||
                   is.na(as.numeric(input$B_RSD))) {
                    prob.hgpc.nd.lower = min(sapply(split(data_expand, 1:nrow(data_expand)), function(x){do.call(predict.highgrade.nodutasteride, x)}))
                    prob.hgpc.nd.upper = max(sapply(split(data_expand, 1:nrow(data_expand)), function(x){do.call(predict.highgrade.nodutasteride, x)}))
                    prob.hgpc.nd <- paste(prob.hgpc.nd, '(', pretty_pred(prob.hgpc.nd.lower), ", ", pretty_pred(prob.hgpc.nd.upper), ')', sep='')
                }
            }
            if (prob.aur.d != "Not Applicable") {
                prob.aur.d <- pretty_pred(prob.aur.d)
                if(is.na(as.numeric(input$B_IPSS))||
                   is.na(as.numeric(input$B_QM))||is.na(as.numeric(input$B_PV))||
                   is.na(as.numeric(input$B_RSD))) {
                    prob.aur.d.lower = min(sapply(split(data_expand, 1:nrow(data_expand)), function(x){do.call(predict.aur.dutasteride, x)}))
                    prob.aur.d.upper = max(sapply(split(data_expand, 1:nrow(data_expand)), function(x){do.call(predict.aur.dutasteride, x)}))
                    prob.aur.d <- paste(prob.aur.d, '(', pretty_pred(prob.aur.d.lower), ", ", pretty_pred(prob.aur.d.upper), ')', sep='')
                }
            }
            if (prob.aur.nd != "Not Applicable") {
                prob.aur.nd <- pretty_pred(prob.aur.nd)
                if(is.na(as.numeric(input$B_IPSS))||
                   is.na(as.numeric(input$B_QM))||is.na(as.numeric(input$B_PV))||
                   is.na(as.numeric(input$B_RSD))) {
                    prob.aur.nd.lower = min(sapply(split(data_expand, 1:nrow(data_expand)), function(x){do.call(predict.aur.nodutasteride, x)}))
                    prob.aur.nd.upper = max(sapply(split(data_expand, 1:nrow(data_expand)), function(x){do.call(predict.aur.nodutasteride, x)}))
                    prob.aur.nd <- paste(prob.aur.nd, '(', pretty_pred(prob.aur.nd.lower), ", ", pretty_pred(prob.aur.nd.upper), ')', sep='')
                }
            }
            if (prob.bph.d != "Not Applicable") {
                prob.bph.d <- pretty_pred(prob.bph.d)
                if(is.na(as.numeric(input$B_QM))||is.na(as.numeric(input$B_PV))||is.na(as.numeric(input$B_IPSS))||
                   is.na(as.numeric(input$B_RSD))) {
                    prob.bph.d.lower = min(sapply(split(data_expand, 1:nrow(data_expand)), function(x){do.call(predict.bph.dutasteride, x)}))
                    prob.bph.d.upper = max(sapply(split(data_expand, 1:nrow(data_expand)), function(x){do.call(predict.bph.dutasteride, x)}))
                    prob.bph.d <- paste(prob.bph.d, '(', pretty_pred(prob.bph.d.lower), ", ", pretty_pred(prob.bph.d.upper), ')', sep='')
                }
            }
            if (prob.bph.nd != "Not Applicable") {
                prob.bph.nd <- pretty_pred(prob.bph.nd)
                if(is.na(as.numeric(input$B_QM))||is.na(as.numeric(input$B_PV))||is.na(as.numeric(input$B_IPSS))||
                   is.na(as.numeric(input$B_RSD))) {
                    prob.bph.nd.lower = min(sapply(split(data_expand, 1:nrow(data_expand)), function(x){do.call(predict.bph.nodutasteride, x)}))
                    prob.bph.nd.upper = max(sapply(split(data_expand, 1:nrow(data_expand)), function(x){do.call(predict.bph.nodutasteride, x)}))
                    prob.bph.nd <- paste(prob.bph.nd, '(', pretty_pred(prob.bph.nd.lower), ", ", pretty_pred(prob.bph.nd.upper), ')', sep='')
                }
            }
            if (prob.erectile.d != "Not Applicable") {
                prob.erectile.d <- pretty_pred(prob.erectile.d)
            }
            if (prob.erectile.nd != "Not Applicable") {
                prob.erectile.nd <- pretty_pred(prob.erectile.nd)
            }
            if (prob.gynecomastia.d != "Not Applicable") {
                prob.gynecomastia.d <- pretty_pred(prob.gynecomastia.d)
                if (is.na(as.numeric(input$B_BMI))) {
                    prob.gynecomastia.d.lower = min(sapply(split(data_expand, 1:nrow(data_expand)), function(x){do.call(predict.gynecomastia.dutasteride, x)}))
                    prob.gynecomastia.d.upper = max(sapply(split(data_expand, 1:nrow(data_expand)), function(x){do.call(predict.gynecomastia.dutasteride, x)}))
                    prob.gynecomastia.d <- paste(prob.gynecomastia.d, '(', pretty_pred(prob.gynecomastia.d.lower), ", ", pretty_pred(prob.gynecomastia.d.upper), ')', sep='')
                }
            }
            if (prob.gynecomastia.nd != "Not Applicable") {
                prob.gynecomastia.nd <- pretty_pred(prob.gynecomastia.nd)
                if(is.na(as.numeric(input$B_BMI))) {
                    prob.gynecomastia.nd.lower = min(sapply(split(data_expand, 1:nrow(data_expand)), function(x){do.call(predict.gynecomastia.nodutasteride, x)}))
                    prob.gynecomastia.nd.upper = max(sapply(split(data_expand, 1:nrow(data_expand)), function(x){do.call(predict.gynecomastia.nodutasteride, x)}))
                    prob.gynecomastia.nd <- paste(prob.gynecomastia.nd, '(', pretty_pred(prob.gynecomastia.nd.lower), ", ", pretty_pred(prob.gynecomastia.nd.upper), ')', sep='')
                }
            }
            if (prob.hgpin.nd != "Not Applicable") {
                prob.hgpin.nd <- pretty_pred(prob.hgpin.nd)
                if (is.na(as.numeric(input$B_OPFPS))||is.na(as.numeric(input$B_BMI))||is.na(as.numeric(input$B_IPSS))||
                    is.na(as.numeric(input$B_NOCOR))||is.na(as.numeric(input$B_PV))) {
                    prob.hgpin.nd.lower = min(sapply(split(data_expand, 1:nrow(data_expand)), function(x){do.call(predict.hgpin.nodutasteride, x)}))
                    prob.hgpin.nd.upper = max(sapply(split(data_expand, 1:nrow(data_expand)), function(x){do.call(predict.hgpin.nodutasteride, x)}))
                    prob.hgpin.nd <- paste(prob.hgpin.nd, '(', pretty_pred(prob.hgpin.nd.lower), ", ", pretty_pred(prob.hgpin.nd.upper), ')', sep='')
                }
            }
            if (prob.prostate.d != "Not Applicable") {
                prob.prostate.d <- pretty_pred(prob.prostate.d)
                if (is.na(as.numeric(input$B_OPFPS))||is.na(as.numeric(input$B_BMI))||
                    is.na(as.numeric(input$B_NOCOR))||is.na(as.numeric(input$B_PV))) {
                    prob.prostate.d.lower = min(sapply(split(data_expand, 1:nrow(data_expand)), function(x){do.call(predict.prostate.dutasteride, x)}))
                    prob.prostate.d.upper = max(sapply(split(data_expand, 1:nrow(data_expand)), function(x){do.call(predict.prostate.dutasteride, x)}))
                    prob.prostate.d <- paste(prob.prostate.d, '(', pretty_pred(prob.prostate.d.lower), ", ", pretty_pred(prob.prostate.d.upper), ')', sep='')
                }
            }
            if (prob.prostate.nd != "Not Applicable") {
                prob.prostate.nd <- pretty_pred(prob.prostate.nd)
                if (is.na(as.numeric(input$B_OPFPS))||is.na(as.numeric(input$B_BMI))||
                    is.na(as.numeric(input$B_NOCOR))||is.na(as.numeric(input$B_PV))) {
                    prob.prostate.nd.lower = min(sapply(split(data_expand, 1:nrow(data_expand)), function(x){do.call(predict.prostate.nodutasteride, x)}))
                    prob.prostate.nd.upper = max(sapply(split(data_expand, 1:nrow(data_expand)), function(x){do.call(predict.prostate.nodutasteride, x)}))
                    prob.prostate.nd <- paste(prob.prostate.nd, '(', pretty_pred(prob.prostate.nd.lower), ", ", pretty_pred(prob.prostate.nd.upper), ')', sep='')
                }
            }
            if (prob.uti.d != "Not Applicable") {
                prob.uti.d <- pretty_pred(prob.uti.d)
                if (is.na(as.numeric(input$B_QM))||is.na(as.numeric(input$B_RSD))) {
                    prob.uti.d.lower = min(sapply(split(data_expand, 1:nrow(data_expand)), function(x){do.call(predict.uti.dutasteride, x)}))
                    prob.uti.d.upper = max(sapply(split(data_expand, 1:nrow(data_expand)), function(x){do.call(predict.uti.dutasteride, x)}))
                    prob.uti.d <- paste(prob.uti.d, '(', pretty_pred(prob.uti.d.lower), ", ", pretty_pred(prob.uti.d.upper), ')', sep='')
                }
            }
            if (prob.uti.nd != "Not Applicable") {
                prob.uti.nd <- pretty_pred(prob.uti.nd)
                if (is.na(as.numeric(input$B_QM))||is.na(as.numeric(input$B_RSD))) {
                    prob.uti.nd.lower = min(sapply(split(data_expand, 1:nrow(data_expand)), function(x){do.call(predict.uti.nodutasteride, x)}))
                    prob.uti.nd.upper = max(sapply(split(data_expand, 1:nrow(data_expand)), function(x){do.call(predict.uti.nodutasteride, x)}))
                    prob.uti.nd <- paste(prob.uti.nd, '(', pretty_pred(prob.uti.nd.lower), ", ", pretty_pred(prob.uti.nd.upper), ')', sep='')
                }
            }
            if (prob.asap.d != "Not Applicable") {
                prob.asap.d <- pretty_pred(prob.asap.d)
                if (is.na(as.numeric(input$B_OPFPS))||is.na(as.numeric(input$B_BMI))||
                    is.na(as.numeric(input$B_NOCOR))||is.na(as.numeric(input$B_PV))) {
                    prob.asap.d.lower = min(sapply(split(data_expand, 1:nrow(data_expand)), function(x){do.call(predict.asap.dutasteride, x)}))
                    prob.asap.d.upper = max(sapply(split(data_expand, 1:nrow(data_expand)), function(x){do.call(predict.asap.dutasteride, x)}))
                    prob.asap.d <- paste(prob.asap.d, '(', pretty_pred(prob.asap.d.lower), ", ", pretty_pred(prob.asap.d.upper), ')', sep='')
                }
            }
            res = data.frame(Result = c("4-year probability of high-grade prostate cancer (Gleason Sum 7-10)",
                                        "4-year probability of prostate cancer",
                                        "4-year probability of high-grade prostatic intraepithelial neoplasia (HGPIN) without coexisting ASAP or prostate cancer",
                                        "4-year probability of atypical small acinar proliferation (ASAP) without coexisting prostate cancer",
                                        "4-year probability of acute unirary retention (AUR)",
                                        "4-year probability of urinary tract infection (UTI)",
                                        "4-year probability of BPH-related surgery",
                                        "4-year probability of erectile dysfunction",
                                        "4-year probability of gynecomastia"),
                             Dutasteride = c(prob.hgpc.d, prob.prostate.d, prob.hgpin.d, prob.asap.d, prob.aur.d, prob.uti.d, prob.bph.d, prob.erectile.d, prob.gynecomastia.d),
                             NoDutasteride = c(prob.hgpc.nd, prob.prostate.nd, prob.hgpin.nd, "5%", prob.aur.nd, prob.uti.nd, prob.bph.nd, prob.erectile.nd, prob.gynecomastia.nd))
            names(res) = c("Result","Dutasteride","No Dutasteride")
            
            res})
    }, options = list(
        pageLength = 10,
        lengthMenu = 0,
        
        searching = 0,
        info = 0,
        paging = 0,
        initComplete = I(
            "function(settings, json) {
                    $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
            }")))
})
