pretty_risk = function(df) {
    df = df[, order(df[1,])]
    df2 = df
    order_df = df
    j = 1
    for (i in c(1:ncol(df))) {
        if (df[, i] * 100 < 0.1) {
            df2[, i] = "< 0.1%"
        }  else if (df[, i] * 100 > 99.9) {
            df2[, i] = "> 99.9%"
        } else {
            df2[, i] = paste(round(df[, i] * 100, 1), "%", sep="")
        }
        if (i == 1) {
            order_df[,i]=j
        } else if (df2[,i] == df2[,(i-1)]) {
            order_df[,i]=j
        } else {
            order_df[,i]=j+1
            j=j+1
        }
    }
    return(list(df = df2, order_df=order_df))
}

death = function(data) {
    lp.dpp4 = -3.3728037 - 
        0.043965322 * data$TimeBetweenMetforminToSecond + 0.063732887 * data$Age+ 
        1.3809833e-06 * max(data$Age- 42.367739, 0)**3 - 2.8747483e-06 * max(data$Age- 59.506731, 0)**3 + 
        1.493765e-06 * max(data$Age- 75.3517, 0)**3 + 0.25032091 * (data$Gender== "Male") - 
        0.23568334 * (data$Race== "Black race") - 0.52008029 * (data$Race== "Asians") - 
        0.20728644 * (data$Race== "Other/Unknown") + 0.32836692 * (data$FinancialClass== "Medicaid") - 
        0.047327032 * (data$FinancialClass== "Medicare") + 0.61351932 * (data$FinancialClass== "Other") + 
        0.3146565 * data$Hx.Stroke+ 0.19157002 * data$Hx.HTN+ 0.070012829 * 
        data$Hx.HTN.Med+ 0.28466548 * data$Hx.RenalFailure + 0.0094412599 * 
        data$ADI - 2.4590634e-06 * max(data$ADI - 77.47865, 0)**3 + 4.3529079e-06 * 
        max(data$ADI - 99.30301, 0)**3 - 1.8938445e-06 * max(data$ADI - 127.64086, 0)**3 - 0.035633081 * data$BMI + 
        0.00013752965 * max(data$BMI - 25.63, 0)**3 - 0.00022769714 * max(data$BMI - 33.07, 0)**3 + 
        9.0167486e-05 * max(data$BMI - 44.418, 0)**3 - 0.024004082 * data$Diastolic + 
        2.1134768e-05 * max(data$Diastolic - 66.5, 0)**3 - 
        4.3600861e-05 * max(data$Diastolic - 77.75, 0)**3 + 2.2466092e-05 * 
        max(data$Diastolic - 88.333333, 0)**3 + 0.006756759 * data$Systolic - 
        8.8029434e-07 * max(data$Systolic - 116, 0)**3 + 1.5655534e-06 * 
        max(data$Systolic - 130.44444, 0)**3 - 6.8525907e-07 * max(data$Systolic - 149, 0)**3 + 
        0.70374152 * (data$SmokingHistory == "Current Smoker") + 
        0.34506919 * (data$SmokingHistory == "Former smoker") + 0.57746878 * 
        data$HeartDisease + 0.63076744 * data$HF - 0.27136829 * data$Dyslipidemia
    lp.glp1 = lp.dpp4 - 0.5570305
    lp.insulin = lp.dpp4 + 0.919721
    lp.sglt2 = lp.dpp4 - 1.1854692
    lp.sulf = lp.dpp4 + 0.30107865
    lp.thia = lp.dpp4 + 0.041959745
    return(pretty_risk(data.frame(dpp4    = 1 - 0.9517272 ** exp(lp.dpp4),
                                  glp1    = 1 - 0.9517272 ** exp(lp.glp1),
                                  insulin = 1 - 0.9517272 ** exp(lp.insulin),
                                  sglt2   = 1 - 0.9517272 ** exp(lp.sglt2),
                                  sulf    = 1 - 0.9517272 ** exp(lp.sulf),
                                  thia    = 1 - 0.9517272 ** exp(lp.thia))))
}

stroke = function(data) {
    lp.dpp4 = - 0.027095817 * 
        data$TimeBetweenMetforminToSecond + 0.051782281 * data$Age - 2.891053e-05 * 
        max(data$Age - 42.367739, 0)**3 + 6.0182117e-05 * max(data$Age - 59.506731, 0)**3 - 
        3.1271587e-05 * max(data$Age - 75.3517, 0)**3 + 0.18908175 * 
        (data$Gender == "Male") - 0.090583437 * (data$Marital == "Married or demestic parter") + 
        0.0084921776 * (data$Marital == "Divorced/Separated/Widow") - 
        0.077578268 * (data$Marital == "Other/Unknown") + 0.43549833 * 
        (data$FinancialClass == "Medicaid") + 0.27578937 * (data$FinancialClass == "Medicare") - 
        0.05721039 * (data$FinancialClass == "Other") + 
        2.4968089 * data$Hx.Stroke + 0.43328796 * data$Hx.HTN + 0.064232003 * 
        data$Hx.HTN.Med - 0.01424351 * data$BMI + 5.1361084e-06 * max(data$BMI - 25.63, 0)**3 - 
        8.5034547e-06 * max(data$BMI - 33.07, 0)**3 + 3.3673463e-06 * 
        max(data$BMI - 44.418, 0)**3 + 0.049304739 * data$A1c - 0.0021731476 * 
        max(data$A1c - 6.3, 0)**3 + 0.0031609419 * max(data$A1c - 7.8, 0)**3 - 
        0.00098779435 * max(data$A1c - 11.1, 0)**3 - 0.00025981796 * data$HDL + 
        1.0338202e-07 * max(data$HDL - 32, 0)**3 - 1.2224225e-07 * max(data$HDL - 59, 0)**3 + 
        1.8860233e-08 * max(data$HDL - 207, 0)**3 - 0.01814974 * 
        data$Diastolic + 2.2225864e-05 * max(data$Diastolic - 66.5, 0)**3 - 
        4.5851783e-05 * max(data$Diastolic - 77.75, 0)**3 + 2.3625919e-05 * 
        max(data$Diastolic - 88.333333, 0)**3 + 0.0020195176 * data$Systolic + 
        1.0945435e-05 * max(data$Systolic - 116, 0)**3 - 1.9465834e-05 * 
        max(data$Systolic - 130.44444, 0)**3 + 8.5203987e-06 * max(data$Systolic - 149, 0)**3 + 
        0.2876716 * (data$SmokingHistory == "Current Smoker") + 
        0.16277598 * (data$SmokingHistory == "Former smoker") + 0.24714605 * 
        data$Statin + 0.089866565 * data$HF - 0.066911158 * data$Dyslipidemia
    lp.glp1 = lp.dpp4 + 0.18534745
    lp.insulin = lp.dpp4 + 0.24152591 
    lp.sglt2 = lp.dpp4 - 0.087663189
    lp.sulf = lp.dpp4 + 0.085961485
    lp.thia = lp.dpp4 - 0.0036232125
    return(pretty_risk(data.frame(dpp4    = 1 - 0.9959177 ** exp(lp.dpp4),
                                  glp1    = 1 - 0.9959177 ** exp(lp.glp1),
                                  insulin = 1 - 0.9959177 ** exp(lp.insulin),
                                  sglt2   = 1 - 0.9959177 ** exp(lp.sglt2),
                                  sulf    = 1 - 0.9959177 ** exp(lp.sulf),
                                  thia    = 1 - 0.9959177 ** exp(lp.thia))))
}

mi = function(data) {
    lp.dpp4 = 0.043505915 * data$Age- 2.1277965e-05 * max(data$Age- 42.367739, 0)**3 + 4.4293652e-05 * 
        max(data$Age- 59.506731, 0)**3 - 2.3015687e-05 * max(data$Age- 75.3517, 0)**3 + 
        0.37862175 * (data$Gender== "Male") - 0.030845286 * (data$Race== "Black race") - 
        1.0429387 * (data$Race== "Asians") - 0.12264641 * 
        (data$Race== "Other/Unknown") - 0.0297715 * (data$Marital== "Married or demestic parter") + 
        0.15127006 * (data$Marital== "Divorced/Separated/Widow") + 0.035663649 * 
        (data$Marital== "Other/Unknown") + 0.35664778 * (data$FinancialClass== "Medicaid") - 
        0.016050964 * (data$FinancialClass== "Medicare") - 
        0.26952284 * (data$FinancialClass== "Other") + 0.21997722 * data$Hx.Stroke+ 
        2.8333058 * data$Hx.MI+ 0.22332615 * data$Hx.HTN+ 0.064877916 * data$Hx.HTN.Med- 
        0.0060638265 * data$ADI+ 5.1995493e-06 * max(data$ADI- 77.47865, 0)**3 - 
        9.2039756e-06 * max(data$ADI- 99.30301, 0)**3 + 4.0044263e-06 * 
        max(data$ADI- 127.64086, 0)**3 + 0.11436707 * data$A1c- 0.0042187997 * 
        max(data$A1c- 6.3, 0)**3 + 0.0061364359 * max(data$A1c- 7.8, 0)**3 - 
        0.0019176362 * max(data$A1c- 11.1, 0)**3 - 0.001521685 * data$LDL+ 
        3.7805514e-07 * max(data$LDL- 54, 0)**3 - 6.5416283e-07 * max(data$LDL- 93, 0)**3 + 
        2.7610769e-07 * max(data$LDL- 146.4, 0)**3 - 0.0026570301 * 
        data$Diastolic- 1.969347e-05 * max(data$Diastolic- 66.5, 0)**3 + 
        4.0627473e-05 * max(data$Diastolic- 77.75, 0)**3 - 2.0934004e-05 * 
        max(data$Diastolic- 88.333333, 0)**3 - 0.0092194852 * data$Systolic+ 
        1.7578497e-05 * max(data$Systolic- 116, 0)**3 - 3.1262357e-05 * 
        max(data$Systolic- 130.44444, 0)**3 + 1.368386e-05 * max(data$Systolic- 149, 0)**3 + 
        0.23465272 * (data$SmokingHistory== "Current Smoker") + 
        0.20374905 * (data$SmokingHistory== "Former smoker") + 0.16028102 * 
        data$HeartDisease+ 0.3391337 * data$HF+ 0.10886303 *data$Dyslipidemia
    lp.glp1 = lp.dpp4 - 0.31510026
    lp.insulin = lp.dpp4 + 0.22990429
    lp.sglt2 = lp.dpp4 - 0.069402374
    lp.sulf = lp.dpp4 - 0.042814601
    lp.thia = lp.dpp4 - 0.19457143
    return(pretty_risk(data.frame(dpp4    = 1 - 0.9959739 ** exp(lp.dpp4),
                                  glp1    = 1 - 0.9959739 ** exp(lp.glp1),
                                  insulin = 1 - 0.9959739 ** exp(lp.insulin),
                                  sglt2   = 1 - 0.9959739 ** exp(lp.sglt2),
                                  sulf    = 1 - 0.9959739 ** exp(lp.sulf),
                                  thia    = 1 - 0.9959739 ** exp(lp.thia))))
    
}

htn = function(data) {
    lp.dpp4 = - 0.055151215 * data$TimeBetweenMetforminToSecond+ 
        0.015495153 * data$Age- 4.9718085e-06 * max(data$Age- 42.367739, 0)**3 + 
        1.0349653e-05 * max(data$Age- 59.506731, 0)**3 - 5.3778447e-06 * 
        max(data$Age- 75.3517, 0)**3 + 0.16061163 * (data$Race== "Black race") - 
        0.018544751 * (data$Race== "Asians") - 0.10404328 * (data$Race== "Other/Unknown") + 
        0.16028846 * (data$FinancialClass== "Medicaid") + 
        0.13521322 * (data$FinancialClass== "Medicare") - 0.086655741 * 
        (data$FinancialClass== "Other") + 0.22975195 * data$Hx.Stroke+ 0.48230375 * 
        data$Hx.MI+ 0.22177209 * data$Hx.HTN- 1.0853714 * data$Hx.HTN.Med- 0.01317596 * 
        max(data$Hx.HTN.Med, 0)**3 + 0.026351919 * max(data$Hx.HTN.Med- 2, 0)**3 - 
        0.01317596 * max(data$Hx.HTN.Med- 4, 0)**3 + 0.24114872 * 
        data$Hx.RenalFailure+ 0.00086414215 * data$ADI+ 6.0284292e-07 * max(data$ADI- 77.47865, 0)**3 - 
        1.0671216e-06 * max(data$ADI- 99.30301, 0)**3 + 
        4.642787e-07 * max(data$ADI- 127.64086, 0)**3 + 0.0036999542 * 
        data$BMI+ 1.6717876e-05 * max(data$BMI- 25.63, 0)**3 - 2.7678485e-05 * 
        max(data$BMI- 33.07, 0)**3 + 1.0960609e-05 * max(data$BMI- 44.418, 0)**3 - 
        0.00015199743 * data$HDL+ 4.3167296e-08 * max(data$HDL- 32, 0)**3 - 
        5.1042411e-08 * max(data$HDL- 59, 0)**3 + 7.8751148e-09 * 
        max(data$HDL- 207, 0)**3 + 0.024222147 * data$Systolic- 6.7563404e-06 * 
        max(data$Systolic- 116, 0)**3 + 1.2015767e-05 * max(data$Systolic- 130.44444, 0)**3 - 
        5.2594266e-06 * max(data$Systolic- 149, 0)**3 + 
        0.049195201 * (data$SmokingHistory== "Current Smoker") + 0.11402705 * 
        (data$SmokingHistory== "Former smoker") + 0.13790264 * data$HeartDisease+ 
        0.19991732 * data$HF- 0.25135091 * data$Dyslipidemia
    lp.glp1 = lp.dpp4 - 0.042839645
    lp.insulin = lp.dpp4 + 0.26769875
    lp.sglt2 = lp.dpp4 - 0.17520298
    lp.sulf = lp.dpp4 + 0.058766425
    lp.thia = lp.dpp4 - 0.02833733
    return(pretty_risk(data.frame(dpp4    = 1 - 0.9860941 ** exp(lp.dpp4),
                                  glp1    = 1 - 0.9860941 ** exp(lp.glp1),
                                  insulin = 1 - 0.9860941 ** exp(lp.insulin),
                                  sglt2   = 1 - 0.9860941 ** exp(lp.sglt2),
                                  sulf    = 1 - 0.9860941 ** exp(lp.sulf),
                                  thia    = 1 - 0.9860941 ** exp(lp.thia))))
}

rf = function(data) {
    lp.dpp4 = 
        1.4485863 * data$RF + 0.033844409 * data$Age - 
        1.2396984e-05 * max(data$Age - 42.376979, 0)**3 + 
        2.5709355e-05 * max(data$Age - 59.629877, 0)**3 - 
        1.331237e-05 * max(data$Age - 75.696429, 0)**3 + 
        0.23757715 * (data$Race == "Black race") + 0.11626605 * (data$Race == "Asians") - 
        0.23645635 * (data$Race == "Other/Unknown") - 
        0.15182634 * (data$Marital == "Married or demestic parter") - 
        0.055704655 * (data$Marital == "Divorced/Separated/Widow") + 
        0.10364768 * (data$Marital == "Other/Unknown") - 
        4.1463847e-06 * data$MedianIncome + 
        3.574581e-16 * max(data$MedianIncome - 32090, 0)**3 - 
        6.171213e-16 * max(data$MedianIncome - 52665, 0)**3 + 
        2.596632e-16 * max(data$MedianIncome - 80989, 0)**3 + 
        0.6023353 * (data$FinancialClass == "Medicaid") + 0.56658156 * (data$FinancialClass == "Medicare") + 
        0.24889853 * (data$FinancialClass == "Other") + 
        0.34140231 * data$Hx.HTN + 0.14822139 * data$Hx.HTN.Med - 0.12910262 * 
        data$A1c + 0.0068924741 * max(data$A1c - 6.3, 0)**3 - 0.010123321 * max(data$A1c - 7.8, 0)**3 + 
        0.0032308473 * max(data$A1c - 11, 0)**3 - 
        0.028684689 * data$Diastolic + 2.7623658e-05 * max(data$Diastolic - 66.333333, 0)**3 - 
        5.6973794e-05 * max(data$Diastolic - 77.666667, 0)**3 + 
        2.9350136e-05 * max(data$Diastolic - 88.333333, 0)**3 + 
        0.009955952 * data$Systolic + 3.9916655e-08 * max(data$Systolic - 116, 0)**3 - 
        7.0379365e-08 * max(data$Systolic - 130.5, 0)**3 + 
        3.046271e-08 * max(data$Systolic - 149.5, 0)**3 + 0.098398862 * (data$SmokingHistory == "Current Smoker") + 
        0.11005589 * (data$SmokingHistory == "Former smoker") + 
        0.35162861 * data$HeartDisease + 0.47685204 * data$HF - 
        0.27211205 * data$Dyslipidemia 
    lp.glp1 = lp.dpp4 - 0.35710319 - 0.6668524 * data$RF 
    lp.insulin = lp.dpp4 + 0.66782984 - 0.30679918 * data$RF
    lp.sglt2 = lp.dpp4 + 0.091879197 - 1.4295781 * data$RF
    lp.sulf = lp.dpp4 + 0.20892157 - 0.19370968 * data$RF
    lp.thia = lp.dpp4 
    return(pretty_risk(data.frame(dpp4    = 1 - 0.9808751 ** exp(lp.dpp4),
                                  glp1    = 1 - 0.9808751 ** exp(lp.glp1),
                                  insulin = 1 - 0.9808751 ** exp(lp.insulin),
                                  sglt2   = 1 - 0.9808751 ** exp(lp.sglt2),
                                  sulf    = 1 - 0.9808751 ** exp(lp.sulf),
                                  thia    = 1 - 0.9808751 ** exp(lp.thia))))
}
