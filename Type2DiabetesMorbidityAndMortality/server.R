predict.heart.disease <- expression({
    lp <- 0.058631984 * Age -
        2.4216545e-05 * max(Age - 42.3, 0)**3 +
        5.0485339e-05 * max(Age - 61.5, 0)**3 -
        2.6268794e-05 * max(Age - 79.2, 0)**3 +
        0.37956824 * (Gender == "Male") +
        0.37580003 * (Ethnicity == "Other") + 
        0.32877304 * (Ethnicity == "White") -
        0.014435602 * (186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) +
        2.597274e-06 * max((186*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-46.46475, 0)**3 -
        1.2190104e-05*max((186*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-77.305059, 0)**3 +
        9.5928303e-06*max((186*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-85.655121, 0)**3 -
        3.517682*(Med == "MEG")-
        0.31465289*(Med == "SFU")+
        0.22748977*(Med == "TZD")-
        0.0039450703 * LDL +
        3.4227985e-07 * max(LDL - 64, 0)**3 -
        6.0706237e-07 * max(LDL - 105,0)**3 +
        2.6478252e-07 * max(LDL - 158,0)**3 -
        0.0093747011 * HDL + 
        2.8420999e-06 * max(HDL - 31, 0)**3 -
        4.6014951e-06 * max(HDL - 44, 0)**3 + 
        1.7593952e-06 * max(HDL - 65, 0)**3 -
        0.002682503 * HbA1c +
        0.0027857568 * max(HbA1c - 5.8, 0)**3 -
        0.0040438405 * max(HbA1c - 7.2, 0)**3 +
        0.0012580837 * max(HbA1c - 10.3, 0)**3 +
        0.23823918 * (Smoking_Status=="Quit") + 
        0.27175485 * (Smoking_Status=="Yes") - 
        0.0053526256 * BPSystolic + 
        3.258553e-06 * max(BPSystolic - 110, 0)**3 -
        5.8188447e-06 * max(BPSystolic - 132, 0)**3 +
        2.5602917e-06 * max(BPSystolic - 160, 0)**3 -
        0.0057769158 * BPDiastolic -
        5.8556407e-07 * max(BPDiastolic - 60, 0)**3 +
        1.4639102e-06 * max(BPDiastolic - 78, 0)**3 -
        8.783461e-07 * max(BPDiastolic - 90, 0)**3 + 
        0.2198475 * (Insulin == "Yes") +
        0.65608915 * (Plavix == "Yes") +
        0.41416096 * (Aspirin == "Yes") +
        0.093252631 * (ACEI_ARB == "Yes") +
        0.32590241 * (Cholesterol_Med == "Yes") -
        0.45371755 * (New_Diabetes == "Yes") +
        0.057526191 * (log(income)) -
        0.29094624 * max((log(income)) - 10.176906,0)**3 +
        0.62476451 * max((log(income)) - 10.640364,0)**3 -
        0.33381827 * max((log(income)) - 11.044301,0)**3 -
        0.13091068 * (exp(-3.2483828-0.020005391 * Age - 
                              9.2206124e-06*max(Age - 42.3,0)**3 +
                              1.9222633e-05*max(Age - 61.5,0)**3 -
                              1.000202e-05*max(Age - 79.2,0)**3 -
                              0.31070352*(Gender=="Male") +
                              0.02768758*(Ethnicity=="Other") -
                              0.0096165425*(Ethnicity=="White") +
                              0.036384727*(186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) -
                              7.0000467e-06*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-46.46475,0)**3 +
                              3.2854177e-05*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-77.305059,0)**3 -
                              2.585413e-05*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-85.655121,0)**3 -
                              0.0012049665*LDL -
                              1.6341085e-08*max(LDL-64,0)**3 +
                              2.8982301e-08*max(LDL-105,0)**3 -
                              1.2641217e-08*max(LDL-158,0)**3 +
                              0.0057577659*HDL -
                              5.6952734e-06*max(HDL-31,0)**3 +
                              9.2209188e-06*max(HDL-44,0)**3 -
                              3.5256454e-06*max(HDL-65,0)**3 -
                              0.0028497393*HbA1c -
                              0.0010460996*max(HbA1c-5.8,0)**3 +
                              0.0015185316*max(HbA1c-7.2,0)**3 -
                              0.00047243207*max(HbA1c-10.3,0)**3 -
                              0.025989409*(Smoking_Status=="Quit") -
                              0.18832776*(Smoking_Status=="Yes") +
                              0.002705762*BPSystolic -
                              2.8810273e-06*max(BPSystolic-110,0)**3 +
                              5.1446917e-06*max(BPSystolic-132,0)**3 -
                              2.2636643e-06*max(BPSystolic-160,0)**3 +
                              0.014397303*BPDiastolic -
                              5.1728642e-06*max(BPDiastolic-60,0)**3 +
                              1.293216e-05*max(BPDiastolic-78,0)**3 -
                              7.7592963e-06*max(BPDiastolic-90,0)**3 -
                              0.17846733*(Insulin=="Yes") -
                              0.22131809*(Plavix=="Yes") +
                              0.19092382*(Aspirin=="Yes") -
                              0.00045841645*(ACEI_ARB=="Yes") +
                              0.23905786*(Cholesterol_Med=="Yes") +
                              0.91555246*(New_Diabetes=="Yes") +
                              0.047512815*(log(income)) +
                              0.31553645*max((log(income)) - 10.176906,0)**3 -
                              0.6775684*max((log(income)) - 10.640364,0)**3 +
                              0.36203194*max((log(income)) - 11.044301,0)**3)/
                          (exp(-3.2483828 -
                                   0.020005391 * Age -
                                   9.2206124e-06*max(Age -42.3,0)**3 +
                                   1.9222633e-05*max(Age -61.5,0)**3 -
                                   1.000202e-05*max(Age -79.2,0)**3 -
                                   0.31070352*(Gender=="Male") +
                                   0.02768758*(Ethnicity=="Other") -
                                   0.0096165425*(Ethnicity=="White") +
                                   0.036384727*(186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) -
                                   7.0000467e-06*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-46.46475,0)**3 +
                                   3.2854177e-05*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-77.305059,0)**3 -
                                   2.585413e-05*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-85.655121,0)**3 -
                                   0.0012049665*LDL -
                                   1.6341085e-08*max(LDL-64,0)**3 +
                                   2.8982301e-08*max(LDL-105,0)**3 -
                                   1.2641217e-08*max(LDL-158,0)**3 +
                                   0.0057577659*HDL -
                                   5.6952734e-06*max(HDL-31,0)**3 +
                                   9.2209188e-06*max(HDL-44,0)**3 -
                                   3.5256454e-06*max(HDL-65,0)**3 -
                                   0.0028497393*HbA1c -
                                   0.0010460996*max(HbA1c-5.8,0)**3 +
                                   0.0015185316*max(HbA1c-7.2,0)**3 -
                                   0.00047243207*max(HbA1c-10.3,0)**3 -
                                   0.025989409*(Smoking_Status=="Quit") -
                                   0.18832776*(Smoking_Status=="Yes") +
                                   0.002705762*BPSystolic -
                                   2.8810273e-06*max(BPSystolic-110,0)**3 +
                                   5.1446917e-06*max(BPSystolic-132,0)**3 -
                                   2.2636643e-06*max(BPSystolic-160,0)**3 + 
                                   0.014397303*BPDiastolic -
                                   5.1728642e-06*max(BPDiastolic-60,0)**3 +
                                   1.293216e-05*max(BPDiastolic-78,0)**3 -
                                   7.7592963e-06*max(BPDiastolic-90,0)**3 -
                                   0.17846733*(Insulin=="Yes") - 
                                   0.22131809*(Plavix=="Yes") +
                                   0.19092382*(Aspirin=="Yes") - 
                                   0.00045841645*(ACEI_ARB=="Yes") +
                                   0.23905786*(Cholesterol_Med=="Yes") +
                                   0.91555246*(New_Diabetes=="Yes") +
                                   0.047512815*(log(income)) +
                                   0.31553645*max((log(income)) -10.176906,0)**3 -
                                   0.6775684*max((log(income)) - 10.640364,0)**3 +
                                   0.36203194*max((log(income))-11.044301,0)**3)+1)) -
        0.55565093*max((exp(-3.2483828 -
                                0.020005391 * Age -
                                9.2206124e-06*max(Age -42.3,0)**3 +
                                1.9222633e-05*max(Age -61.5,0)**3 -
                                1.000202e-05*max(Age -79.2,0)**3 -
                                0.31070352*(Gender=="Male") +
                                0.02768758*(Ethnicity=="Other") -
                                0.0096165425*(Ethnicity=="White") +
                                0.036384727*(186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) -
                                7.0000467e-06*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-46.46475,0)**3 +
                                3.2854177e-05*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-77.305059,0)**3 -
                                2.585413e-05*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-85.655121,0)**3 -
                                0.0012049665*LDL -
                                1.6341085e-08*max(LDL-64,0)**3 +
                                2.8982301e-08*max(LDL-105,0)**3 -
                                1.2641217e-08*max(LDL-158,0)**3 +
                                0.0057577659*HDL -
                                5.6952734e-06*max(HDL-31,0)**3 +
                                9.2209188e-06*max(HDL-44,0)**3 -
                                3.5256454e-06*max(HDL-65,0)**3 -
                                0.0028497393*HbA1c -
                                0.0010460996*max(HbA1c-5.8,0)**3 +
                                0.0015185316*max(HbA1c-7.2,0)**3 -
                                0.00047243207*max(HbA1c-10.3,0)**3 -
                                0.025989409*(Smoking_Status=="Quit") -
                                0.18832776*(Smoking_Status=="Yes") +
                                0.002705762*BPSystolic -
                                2.8810273e-06*max(BPSystolic-110,0)**3 +
                                5.1446917e-06*max(BPSystolic-132,0)**3 -
                                2.2636643e-06*max(BPSystolic-160,0)**3 +
                                0.014397303*BPDiastolic -
                                5.1728642e-06*max(BPDiastolic-60,0)**3 +
                                1.293216e-05*max(BPDiastolic-78,0)**3 -
                                7.7592963e-06*max(BPDiastolic-90,0)**3 -
                                0.17846733*(Insulin=="Yes") -
                                0.22131809*(Plavix=="Yes") +
                                0.19092382*(Aspirin=="Yes") -
                                0.00045841645*(ACEI_ARB=="Yes") +
                                0.23905786*(Cholesterol_Med=="Yes") +
                                0.91555246*(New_Diabetes=="Yes") +
                                0.047512815*(log(income)) +
                                0.31553645*max((log(income)) -10.176906,0)**3 -
                                0.6775684*max((log(income))-10.640364,0)**3 +
                                0.36203194*max((log(income))-11.044301,0)**3)/
                            (exp(-3.2483828-
                                     0.020005391 * Age -
                                     9.2206124e-06*max(Age -42.3,0)**3 +
                                     1.9222633e-05*max(Age -61.5,0)**3 -
                                     1.000202e-05*max(Age -79.2,0)**3 -
                                     0.31070352*(Gender=="Male") +
                                     0.02768758*(Ethnicity=="Other") -
                                     0.0096165425*(Ethnicity=="White") +
                                     0.036384727*(186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) -
                                     7.0000467e-06*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-46.46475,0)**3 +
                                     3.2854177e-05*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-77.305059,0)**3 -
                                     2.585413e-05*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-85.655121,0)**3 -
                                     0.0012049665*LDL - 
                                     1.6341085e-08*max(LDL-64,0)**3 +
                                     2.8982301e-08*max(LDL-105,0)**3 -
                                     1.2641217e-08*max(LDL-158,0)**3 +
                                     0.0057577659*HDL - 
                                     5.6952734e-06*max(HDL-31,0)**3 + 
                                     9.2209188e-06*max(HDL-44,0)**3 -
                                     3.5256454e-06*max(HDL-65,0)**3 -
                                     0.0028497393*HbA1c -
                                     0.0010460996*max(HbA1c-5.8,0)**3 +
                                     0.0015185316*max(HbA1c-7.2,0)**3 -
                                     0.00047243207*max(HbA1c-10.3,0)**3 -
                                     0.025989409*(Smoking_Status=="Quit") -
                                     0.18832776*(Smoking_Status=="Yes") +
                                     0.002705762*BPSystolic -
                                     2.8810273e-06*max(BPSystolic-110,0)**3 +
                                     5.1446917e-06*max(BPSystolic-132,0)**3 -
                                     2.2636643e-06*max(BPSystolic-160,0)**3 +
                                     0.014397303*BPDiastolic - 
                                     5.1728642e-06*max(BPDiastolic-60,0)**3 +
                                     1.293216e-05*max(BPDiastolic-78,0)**3 -
                                     7.7592963e-06*max(BPDiastolic-90,0)**3 -
                                     0.17846733*(Insulin=="Yes") -
                                     0.22131809*(Plavix=="Yes") +
                                     0.19092382*(Aspirin=="Yes") -
                                     0.00045841645*(ACEI_ARB=="Yes") +
                                     0.23905786*(Cholesterol_Med=="Yes") +
                                     0.91555246*(New_Diabetes=="Yes") + 
                                     0.047512815*(log(income)) +
                                     0.31553645*max((log(income))-10.176906,0)**3 -
                                     0.6775684*max((log(income))-10.640364,0)**3 +
                                     0.36203194*max((log(income))-11.044301,0)**3)+1)) - 0.18817396,0)**3 +
        1.1872237*max((exp(-3.2483828 -
                               0.020005391 * Age -
                               9.2206124e-06*max(Age -42.3,0)**3 +
                               1.9222633e-05*max(Age -61.5,0)**3 -
                               1.000202e-05*max(Age -79.2,0)**3 -
                               0.31070352*(Gender=="Male") +
                               0.02768758*(Ethnicity=="Other") -
                               0.0096165425*(Ethnicity=="White") +
                               0.036384727*(186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) -
                               7.0000467e-06*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-46.46475,0)**3 +
                               3.2854177e-05*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-77.305059,0)**3 -
                               2.585413e-05*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-85.655121,0)**3 -
                               0.0012049665*LDL -
                               1.6341085e-08*max(LDL-64,0)**3 +
                               2.8982301e-08*max(LDL-105,0)**3 -
                               1.2641217e-08*max(LDL-158,0)**3 +
                               0.0057577659*HDL -
                               5.6952734e-06*max(HDL-31,0)**3 +
                               9.2209188e-06*max(HDL-44,0)**3 -
                               3.5256454e-06*max(HDL-65,0)**3 -
                               0.0028497393*HbA1c -
                               0.0010460996*max(HbA1c-5.8,0)**3 +
                               0.0015185316*max(HbA1c-7.2,0)**3 -
                               0.00047243207*max(HbA1c-10.3,0)**3 -
                               0.025989409*(Smoking_Status=="Quit") -
                               0.18832776*(Smoking_Status=="Yes") +
                               0.002705762*BPSystolic -
                               2.8810273e-06*max(BPSystolic-110,0)**3 +
                               5.1446917e-06*max(BPSystolic-132,0)**3 -
                               2.2636643e-06*max(BPSystolic-160,0)**3 +
                               0.014397303*BPDiastolic -
                               5.1728642e-06*max(BPDiastolic-60,0)**3 +
                               1.293216e-05*max(BPDiastolic-78,0)**3 -
                               7.7592963e-06*max(BPDiastolic-90,0)**3 -
                               0.17846733*(Insulin=="Yes") -
                               0.22131809*(Plavix=="Yes") +
                               0.19092382*(Aspirin=="Yes") -
                               0.00045841645*(ACEI_ARB=="Yes") +
                               0.23905786*(Cholesterol_Med=="Yes") +
                               0.91555246*(New_Diabetes=="Yes") +
                               0.047512815*(log(income)) +
                               0.31553645*max((log(income)) -10.176906,0)**3 -
                               0.6775684*max((log(income))-10.640364,0)**3 +
                               0.36203194*max((log(income))-11.044301,0)**3)/
                           (exp(-3.2483828-
                                    0.020005391 * Age -
                                    9.2206124e-06*max(Age -42.3,0)**3 +
                                    1.9222633e-05*max(Age -61.5,0)**3 -
                                    1.000202e-05*max(Age -79.2,0)**3 -
                                    0.31070352*(Gender=="Male") +
                                    0.02768758*(Ethnicity=="Other") -
                                    0.0096165425*(Ethnicity=="White") +
                                    0.036384727*(186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) -
                                    7.0000467e-06*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-46.46475,0)**3 +
                                    3.2854177e-05*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-77.305059,0)**3 -
                                    2.585413e-05*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-85.655121,0)**3 -
                                    0.0012049665*LDL - 
                                    1.6341085e-08*max(LDL-64,0)**3 +
                                    2.8982301e-08*max(LDL-105,0)**3 -
                                    1.2641217e-08*max(LDL-158,0)**3 +
                                    0.0057577659*HDL - 
                                    5.6952734e-06*max(HDL-31,0)**3 + 
                                    9.2209188e-06*max(HDL-44,0)**3 -
                                    3.5256454e-06*max(HDL-65,0)**3 -
                                    0.0028497393*HbA1c -
                                    0.0010460996*max(HbA1c-5.8,0)**3 +
                                    0.0015185316*max(HbA1c-7.2,0)**3 -
                                    0.00047243207*max(HbA1c-10.3,0)**3 -
                                    0.025989409*(Smoking_Status=="Quit") -
                                    0.18832776*(Smoking_Status=="Yes") +
                                    0.002705762*BPSystolic -
                                    2.8810273e-06*max(BPSystolic-110,0)**3 +
                                    5.1446917e-06*max(BPSystolic-132,0)**3 -
                                    2.2636643e-06*max(BPSystolic-160,0)**3 +
                                    0.014397303*BPDiastolic - 
                                    5.1728642e-06*max(BPDiastolic-60,0)**3 +
                                    1.293216e-05*max(BPDiastolic-78,0)**3 -
                                    7.7592963e-06*max(BPDiastolic-90,0)**3 -
                                    0.17846733*(Insulin=="Yes") -
                                    0.22131809*(Plavix=="Yes") +
                                    0.19092382*(Aspirin=="Yes") -
                                    0.00045841645*(ACEI_ARB=="Yes") +
                                    0.23905786*(Cholesterol_Med=="Yes") +
                                    0.91555246*(New_Diabetes=="Yes") + 
                                    0.047512815*(log(income)) +
                                    0.31553645*max((log(income))-10.176906,0)**3 -
                                    0.6775684*max((log(income))-10.640364,0)**3 +
                                    0.36203194*max((log(income))-11.044301,0)**3)+1))-0.46442736,0)**3 -
        0.6315728*max((exp(-3.2483828 -
                               0.020005391 * Age -
                               9.2206124e-06*max(Age -42.3,0)**3 +
                               1.9222633e-05*max(Age -61.5,0)**3 -
                               1.000202e-05*max(Age -79.2,0)**3 -
                               0.31070352*(Gender=="Male") +
                               0.02768758*(Ethnicity=="Other") -
                               0.0096165425*(Ethnicity=="White") +
                               0.036384727*(186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) -
                               7.0000467e-06*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-46.46475,0)**3 +
                               3.2854177e-05*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-77.305059,0)**3 -
                               2.585413e-05*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-85.655121,0)**3 -
                               0.0012049665*LDL -
                               1.6341085e-08*max(LDL-64,0)**3 +
                               2.8982301e-08*max(LDL-105,0)**3 -
                               1.2641217e-08*max(LDL-158,0)**3 +
                               0.0057577659*HDL -
                               5.6952734e-06*max(HDL-31,0)**3 +
                               9.2209188e-06*max(HDL-44,0)**3 -
                               3.5256454e-06*max(HDL-65,0)**3 -
                               0.0028497393*HbA1c -
                               0.0010460996*max(HbA1c-5.8,0)**3 +
                               0.0015185316*max(HbA1c-7.2,0)**3 -
                               0.00047243207*max(HbA1c-10.3,0)**3 -
                               0.025989409*(Smoking_Status=="Quit") -
                               0.18832776*(Smoking_Status=="Yes") +
                               0.002705762*BPSystolic -
                               2.8810273e-06*max(BPSystolic-110,0)**3 +
                               5.1446917e-06*max(BPSystolic-132,0)**3 -
                               2.2636643e-06*max(BPSystolic-160,0)**3 +
                               0.014397303*BPDiastolic -
                               5.1728642e-06*max(BPDiastolic-60,0)**3 +
                               1.293216e-05*max(BPDiastolic-78,0)**3 -
                               7.7592963e-06*max(BPDiastolic-90,0)**3 -
                               0.17846733*(Insulin=="Yes") -
                               0.22131809*(Plavix=="Yes") +
                               0.19092382*(Aspirin=="Yes") -
                               0.00045841645*(ACEI_ARB=="Yes") +
                               0.23905786*(Cholesterol_Med=="Yes") +
                               0.91555246*(New_Diabetes=="Yes") +
                               0.047512815*(log(income)) +
                               0.31553645*max((log(income)) -10.176906,0)**3 -
                               0.6775684*max((log(income))-10.640364,0)**3 +
                               0.36203194*max((log(income))-11.044301,0)**3)/
                           (exp(-3.2483828-
                                    0.020005391 * Age -
                                    9.2206124e-06*max(Age -42.3,0)**3 +
                                    1.9222633e-05*max(Age -61.5,0)**3 -
                                    1.000202e-05*max(Age -79.2,0)**3 -
                                    0.31070352*(Gender=="Male") +
                                    0.02768758*(Ethnicity=="Other") -
                                    0.0096165425*(Ethnicity=="White") +
                                    0.036384727*(186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) -
                                    7.0000467e-06*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-46.46475,0)**3 +
                                    3.2854177e-05*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-77.305059,0)**3 -
                                    2.585413e-05*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-85.655121,0)**3 -
                                    0.0012049665*LDL - 
                                    1.6341085e-08*max(LDL-64,0)**3 +
                                    2.8982301e-08*max(LDL-105,0)**3 -
                                    1.2641217e-08*max(LDL-158,0)**3 +
                                    0.0057577659*HDL - 
                                    5.6952734e-06*max(HDL-31,0)**3 + 
                                    9.2209188e-06*max(HDL-44,0)**3 -
                                    3.5256454e-06*max(HDL-65,0)**3 -
                                    0.0028497393*HbA1c -
                                    0.0010460996*max(HbA1c-5.8,0)**3 +
                                    0.0015185316*max(HbA1c-7.2,0)**3 -
                                    0.00047243207*max(HbA1c-10.3,0)**3 -
                                    0.025989409*(Smoking_Status=="Quit") -
                                    0.18832776*(Smoking_Status=="Yes") +
                                    0.002705762*BPSystolic -
                                    2.8810273e-06*max(BPSystolic-110,0)**3 +
                                    5.1446917e-06*max(BPSystolic-132,0)**3 -
                                    2.2636643e-06*max(BPSystolic-160,0)**3 +
                                    0.014397303*BPDiastolic - 
                                    5.1728642e-06*max(BPDiastolic-60,0)**3 +
                                    1.293216e-05*max(BPDiastolic-78,0)**3 -
                                    7.7592963e-06*max(BPDiastolic-90,0)**3 -
                                    0.17846733*(Insulin=="Yes") -
                                    0.22131809*(Plavix=="Yes") +
                                    0.19092382*(Aspirin=="Yes") -
                                    0.00045841645*(ACEI_ARB=="Yes") +
                                    0.23905786*(Cholesterol_Med=="Yes") +
                                    0.91555246*(New_Diabetes=="Yes") + 
                                    0.047512815*(log(income)) +
                                    0.31553645*max((log(income))-10.176906,0)**3 -
                                    0.6775684*max((log(income))-10.640364,0)**3 +
                                    0.36203194*max((log(income))-11.044301,0)**3)+1))-0.70747212,0)**3 +
        (Med == "MEG")*(0.061048742 * Age -
                 4.9034645e-05*max(Age -42.3,0)**3 +
                 0.00010222477*max( Age -61.5,0)**3 -
                 5.3190123e-05*max( Age -79.2,0)**3)+
        (Med == "SFU")*(0.00081357365* Age - 
                 4.7090447e-06*max( Age -42.3,0)**3+
                 9.8171611e-06*max( Age -61.5,0)**3-
                 5.1081163e-06*max( Age -79.2,0)**3) +
        (Med == "TZD")*(-0.0076018207* Age -
                 1.0839651e-06*max( Age -42.3,0)**3+
                 2.2597917e-06*max( Age -61.5,0)**3-
                 1.1758266e-06*max( Age -79.2,0)**3)+
        (Med == "MEG")*(0.010244557*(186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) -
                 2.4480952e-06*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-46.46475,0)**3 +
                 1.1489945e-05*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-77.305059,0)**3 -
                 9.0418501e-06*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-85.655121,0)**3) +
        (Med == "SFU")*(0.0071164469*(186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) -
                 4.144904e-06*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-46.46475,0)**3 +
                 1.9453786e-05*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-77.305059,0)**3 -
                 1.5308882e-05*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-85.655121,0)**3) +
        (Med == "TZD")*(0.0027294977*(186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) -
                 3.5354378e-07*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-46.46475,0)**3 +
                 1.6593304e-06*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-77.305059,0)**3 -
                 1.3057866e-06*max((186 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black")))-85.655121,0)**3)
    1 - 0.9593254 ^ exp(lp)
})

predict.heart.failure <- expression({
    lp <- 0.023714223 * Age +
        1.6200223e-05 * max(Age - 43,     0) ** 3 -
        3.4284194e-05 * max(Age - 62.2, 0) ** 3 +
        1.808397e-05 *     max(Age - 79.4, 0) ** 3 +
        0.20226829 * (Gender == "Male") +
        0.19941925 * (Ethnicity == "Other") - 
        0.03549482 * (Ethnicity == "White") - 
        0.025363642 * (175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) + 
        4.7164444e-06 * max((175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 46.640975, 0) ** 3 - 
        2.1394062e-05 * max((175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 76.946634, 0) ** 3 + 
        1.6677618e-05 * max((175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 85.5171, 0) ** 3 + 
        0.20199046 * (Med == "MEG") + 
        0.88221889 * (Med == "SFU") -
        1.6434377 * (Med == "TZD") +
        0.032715721 * ((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) +
        1.7603732e-05 * max(((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 24.3, 0) ** 3 -
        2.8646074e-05 * max(((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 31.2, 0) ** 3 + 
        1.1042341e-05 * max(((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 42.2, 0) ** 3 - 
        0.029859603 * HbA1c + 
        0.0077205701 * max(HbA1c - 5.8, 0) ** 3 - 
        0.011207279 * max(HbA1c - 7.2, 0) ** 3 + 
        0.0034867091 * max(HbA1c - 10.3, 0) ** 3 + 
        0.48822884 * (CAD == "Yes") + 
        0.31111253 * (Smoking_Status == "Quit") + 
        0.2969239 * (Smoking_Status == "Yes") - 
        0.014403222 * BPSystolic + 
        2.9765937e-06 * max(BPSystolic - 110, 0) ** 3 - 
        5.315346e-06 * max(BPSystolic - 132, 0) ** 3 + 
        2.3387522e-06 * max(BPSystolic - 160, 0) ** 3 - 
        0.01279578 * BPDiastolic + 
        1.205408e-05 * max(BPDiastolic - 60, 0) ** 3 - 
        3.0135199e-05 * max(BPDiastolic - 78, 0) ** 3 +     
        1.8081119e-05 * max(BPDiastolic - 90, 0) ** 3 + 
        0.36110805 * (Insulin == "Yes") + 
        0.10880103 * (Plavix == "Yes") + 
        0.23675213 * (Aspirin == "Yes") + 
        0.38389324 * (ACEI_ARB == "Yes") - 
        0.31667701 * (New_Diabetes == "Yes") + 
        0.088054761 * (log(income)) - 
        0.34799157 * max((log(income)) - 10.184972, 0) ** 3 + 
        0.71132875 * max((log(income)) - 10.644067, 0) ** 3 - 
        0.36333718 * max((log(income)) - 11.083772, 0) ** 3 + 
        0.36158291 * (exp(-4.2616758 - 0.016509512 * Age - 
                              1.0021846e-05 * max(Age - 43, 0) ** 3 + 2.1209024e-05 * max(Age - 62.2, 0) ** 3 - 1.1187177e-05 * max(Age - 79.4, 0) ** 3 - 
                              0.25028451 * (Gender == "Male") + 0.093197993 * (Ethnicity == "Other") - 0.014311437 * (Ethnicity == "White") + 
                              0.038098961 * (175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 
                              8.3085786e-06 * max((175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 46.640975, 0) ** 3 + 
                              3.7688189e-05 * max((175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 76.946634, 0) ** 3 - 
                              2.9379611e-05 * max((175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 85.5171, 0) ** 3 + 
                              0.033146823 * ((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 
                              8.921034e-05 * max(((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 24.3, 0) ** 3 + 
                              0.00014516955 * max(((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 31.2, 0) ** 3 -
                              5.5959213e-05 * max(((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 42.2, 0) ** 3 - 
                              0.0003764071 * HbA1c - 
                              0.0016038641 * max(HbA1c - 5.8, 0) ** 3 + 
                              0.0023281898 * max(HbA1c - 7.2, 0) ** 3 - 
                              0.0007243257 * max(HbA1c - 10.3, 0) ** 3 + 
                              0.013984497 * (CAD == "Yes") - 
                              0.03536975 * (Smoking_Status == "Quit") - 
                              0.18342601 * (Smoking_Status == "Yes") + 
                              0.00080529696 * BPSystolic - 
                              2.4267329e-06 * max(BPSystolic - 110, 0) ** 3 + 
                              4.3334517e-06 * max(BPSystolic - 132, 0) ** 3 - 
                              1.9067187e-06 * max(BPSystolic - 160, 0) ** 3 + 
                              0.011389918 * BPDiastolic - 
                              4.5362964e-06 * max(BPDiastolic - 60, 0) ** 3 + 
                              1.1340741e-05 * max(BPDiastolic - 78, 0) ** 3 -
                              6.8044446e-06 * max(BPDiastolic - 90, 0) ** 3 - 
                              0.12993847 * (Insulin == "Yes") - 
                              0.077020933 * (Plavix == "Yes") +
                              0.21832248 * (Aspirin == "Yes") + 
                              0.058925574 * (ACEI_ARB == "Yes") + 
                              0.89908317 * (New_Diabetes == "Yes") + 
                              0.080586787 * (log(income)) + 
                              0.25730502 * max((log(income)) - 10.184972, 0) ** 3 -
                              0.52595659 * max((log(income)) - 10.644067, 0) ** 3 + 
                              0.26865157 * max((log(income)) - 11.083772, 0) ** 3) / (
                                  exp(-4.2616758 - 0.016509512 * Age - 
                                          1.0021846e-05 * max(Age - 43, 0) ** 3 + 2.1209024e-05 * max(Age - 62.2, 0) ** 3 - 1.1187177e-05 * max(Age - 79.4, 0) ** 3 - 
                                          0.25028451 * (Gender == "Male") + 0.093197993 * (Ethnicity == "Other") - 0.014311437 * (Ethnicity == "White") + 
                                          0.038098961 * (175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 
                                          8.3085786e-06 * max((175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 46.640975, 0) ** 3 + 
                                          3.7688189e-05 * max((175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 76.946634, 0) ** 3 - 
                                          2.9379611e-05 * max((175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 85.5171, 0) ** 3 + 
                                          0.033146823 * ((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 
                                          8.921034e-05 * max(((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 24.3, 0) ** 3 + 
                                          0.00014516955 * max(((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 31.2, 0) ** 3 -
                                          5.5959213e-05 * max(((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 42.2, 0) ** 3 - 
                                          0.0003764071 * HbA1c - 
                                          0.0016038641 * max(HbA1c - 5.8, 0) ** 3 + 
                                          0.0023281898 * max(HbA1c - 7.2, 0) ** 3 - 
                                          0.0007243257 * max(HbA1c - 10.3, 0) ** 3 + 
                                          0.013984497 * (CAD == "Yes") - 
                                          0.03536975 * (Smoking_Status == "Quit") - 
                                          0.18342601 * (Smoking_Status == "Yes") + 
                                          0.00080529696 * BPSystolic - 
                                          2.4267329e-06 * max(BPSystolic - 110, 0) ** 3 + 
                                          4.3334517e-06 * max(BPSystolic - 132, 0) ** 3 - 
                                          1.9067187e-06 * max(BPSystolic - 160, 0) ** 3 + 
                                          0.011389918 * BPDiastolic - 
                                          4.5362964e-06 * max(BPDiastolic - 60, 0) ** 3 + 
                                          1.1340741e-05 * max(BPDiastolic - 78, 0) ** 3 -
                                          6.8044446e-06 * max(BPDiastolic - 90, 0) ** 3 - 
                                          0.12993847 * (Insulin == "Yes") - 
                                          0.077020933 * (Plavix == "Yes") +
                                          0.21832248 * (Aspirin == "Yes") + 
                                          0.058925574 * (ACEI_ARB == "Yes") + 
                                          0.89908317 * (New_Diabetes == "Yes") + 
                                          0.080586787 * (log(income)) + 
                                          0.25730502 * max((log(income)) - 10.184972, 0) ** 3 -
                                          0.52595659 * max((log(income)) - 10.644067, 0) ** 3 + 
                                          0.26865157 * max((log(income)) - 11.083772, 0) ** 3) + 1)) - 
        5.6520525 * max((exp(-4.2616758 - 0.016509512 * Age - 
                                 1.0021846e-05 * max(Age - 43, 0) ** 3 + 2.1209024e-05 * max(Age - 62.2, 0) ** 3 - 1.1187177e-05 * max(Age - 79.4, 0) ** 3 - 
                                 0.25028451 * (Gender == "Male") + 0.093197993 * (Ethnicity == "Other") - 0.014311437 * (Ethnicity == "White") + 
                                 0.038098961 * (175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 
                                 8.3085786e-06 * max((175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 46.640975, 0) ** 3 + 
                                 3.7688189e-05 * max((175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 76.946634, 0) ** 3 - 
                                 2.9379611e-05 * max((175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 85.5171, 0) ** 3 + 
                                 0.033146823 * ((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 
                                 8.921034e-05 * max(((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 24.3, 0) ** 3 + 
                                 0.00014516955 * max(((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 31.2, 0) ** 3 -
                                 5.5959213e-05 * max(((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 42.2, 0) ** 3 - 
                                 0.0003764071 * HbA1c - 
                                 0.0016038641 * max(HbA1c - 5.8, 0) ** 3 + 
                                 0.0023281898 * max(HbA1c - 7.2, 0) ** 3 - 
                                 0.0007243257 * max(HbA1c - 10.3, 0) ** 3 + 
                                 0.013984497 * (CAD == "Yes") - 
                                 0.03536975 * (Smoking_Status == "Quit") - 
                                 0.18342601 * (Smoking_Status == "Yes") + 
                                 0.00080529696 * BPSystolic - 
                                 2.4267329e-06 * max(BPSystolic - 110, 0) ** 3 + 
                                 4.3334517e-06 * max(BPSystolic - 132, 0) ** 3 - 
                                 1.9067187e-06 * max(BPSystolic - 160, 0) ** 3 + 
                                 0.011389918 * BPDiastolic - 
                                 4.5362964e-06 * max(BPDiastolic - 60, 0) ** 3 + 
                                 1.1340741e-05 * max(BPDiastolic - 78, 0) ** 3 -
                                 6.8044446e-06 * max(BPDiastolic - 90, 0) ** 3 - 
                                 0.12993847 * (Insulin == "Yes") - 
                                 0.077020933 * (Plavix == "Yes") +
                                 0.21832248 * (Aspirin == "Yes") + 
                                 0.058925574 * (ACEI_ARB == "Yes") + 
                                 0.89908317 * (New_Diabetes == "Yes") + 
                                 0.080586787 * (log(income)) + 
                                 0.25730502 * max((log(income)) - 10.184972, 0) ** 3 -
                                 0.52595659 * max((log(income)) - 10.644067, 0) ** 3 + 
                                 0.26865157 * max((log(income)) - 11.083772, 0) ** 3) / (
                                     exp(-4.2616758 - 0.016509512 * Age - 
                                             1.0021846e-05 * max(Age - 43, 0) ** 3 + 2.1209024e-05 * max(Age - 62.2, 0) ** 3 - 1.1187177e-05 * max(Age - 79.4, 0) ** 3 - 
                                             0.25028451 * (Gender == "Male") + 0.093197993 * (Ethnicity == "Other") - 0.014311437 * (Ethnicity == "White") + 
                                             0.038098961 * (175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 
                                             8.3085786e-06 * max((175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 46.640975, 0) ** 3 + 
                                             3.7688189e-05 * max((175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 76.946634, 0) ** 3 - 
                                             2.9379611e-05 * max((175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 85.5171, 0) ** 3 + 
                                             0.033146823 * ((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 
                                             8.921034e-05 * max(((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 24.3, 0) ** 3 + 
                                             0.00014516955 * max(((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 31.2, 0) ** 3 -
                                             5.5959213e-05 * max(((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 42.2, 0) ** 3 - 
                                             0.0003764071 * HbA1c - 
                                             0.0016038641 * max(HbA1c - 5.8, 0) ** 3 + 
                                             0.0023281898 * max(HbA1c - 7.2, 0) ** 3 - 
                                             0.0007243257 * max(HbA1c - 10.3, 0) ** 3 + 
                                             0.013984497 * (CAD == "Yes") - 
                                             0.03536975 * (Smoking_Status == "Quit") - 
                                             0.18342601 * (Smoking_Status == "Yes") + 
                                             0.00080529696 * BPSystolic - 
                                             2.4267329e-06 * max(BPSystolic - 110, 0) ** 3 + 
                                             4.3334517e-06 * max(BPSystolic - 132, 0) ** 3 - 
                                             1.9067187e-06 * max(BPSystolic - 160, 0) ** 3 + 
                                             0.011389918 * BPDiastolic - 
                                             4.5362964e-06 * max(BPDiastolic - 60, 0) ** 3 + 
                                             1.1340741e-05 * max(BPDiastolic - 78, 0) ** 3 -
                                             6.8044446e-06 * max(BPDiastolic - 90, 0) ** 3 - 
                                             0.12993847 * (Insulin == "Yes") - 
                                             0.077020933 * (Plavix == "Yes") +
                                             0.21832248 * (Aspirin == "Yes") + 
                                             0.058925574 * (ACEI_ARB == "Yes") + 
                                             0.89908317 * (New_Diabetes == "Yes") + 
                                             0.080586787 * (log(income)) + 
                                             0.25730502 * max((log(income)) - 10.184972, 0) ** 3 -
                                             0.52595659 * max((log(income)) - 10.644067, 0) ** 3 + 
                                             0.26865157 * max((log(income)) - 11.083772, 0) ** 3) + 1)) - 0.19284834, 0)**3 + 
        12.298808 * max((exp(-4.2616758 - 0.016509512 * Age - 
                                 1.0021846e-05 * max(Age - 43, 0) ** 3 + 2.1209024e-05 * max(Age - 62.2, 0) ** 3 - 1.1187177e-05 * max(Age - 79.4, 0) ** 3 - 
                                 0.25028451 * (Gender == "Male") + 0.093197993 * (Ethnicity == "Other") - 0.014311437 * (Ethnicity == "White") + 
                                 0.038098961 * (175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 
                                 8.3085786e-06 * max((175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 46.640975, 0) ** 3 + 
                                 3.7688189e-05 * max((175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 76.946634, 0) ** 3 - 
                                 2.9379611e-05 * max((175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 85.5171, 0) ** 3 + 
                                 0.033146823 * ((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 
                                 8.921034e-05 * max(((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 24.3, 0) ** 3 + 
                                 0.00014516955 * max(((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 31.2, 0) ** 3 -
                                 5.5959213e-05 * max(((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 42.2, 0) ** 3 - 
                                 0.0003764071 * HbA1c - 
                                 0.0016038641 * max(HbA1c - 5.8, 0) ** 3 + 
                                 0.0023281898 * max(HbA1c - 7.2, 0) ** 3 - 
                                 0.0007243257 * max(HbA1c - 10.3, 0) ** 3 + 
                                 0.013984497 * (CAD == "Yes") - 
                                 0.03536975 * (Smoking_Status == "Quit") - 
                                 0.18342601 * (Smoking_Status == "Yes") + 
                                 0.00080529696 * BPSystolic - 
                                 2.4267329e-06 * max(BPSystolic - 110, 0) ** 3 + 
                                 4.3334517e-06 * max(BPSystolic - 132, 0) ** 3 - 
                                 1.9067187e-06 * max(BPSystolic - 160, 0) ** 3 + 
                                 0.011389918 * BPDiastolic - 
                                 4.5362964e-06 * max(BPDiastolic - 60, 0) ** 3 + 
                                 1.1340741e-05 * max(BPDiastolic - 78, 0) ** 3 -
                                 6.8044446e-06 * max(BPDiastolic - 90, 0) ** 3 - 
                                 0.12993847 * (Insulin == "Yes") - 
                                 0.077020933 * (Plavix == "Yes") +
                                 0.21832248 * (Aspirin == "Yes") + 
                                 0.058925574 * (ACEI_ARB == "Yes") + 
                                 0.89908317 * (New_Diabetes == "Yes") + 
                                 0.080586787 * (log(income)) + 
                                 0.25730502 * max((log(income)) - 10.184972, 0) ** 3 -
                                 0.52595659 * max((log(income)) - 10.644067, 0) ** 3 + 
                                 0.26865157 * max((log(income)) - 11.083772, 0) ** 3) / (
                                     exp(-4.2616758 - 0.016509512 * Age - 
                                             1.0021846e-05 * max(Age - 43, 0) ** 3 + 2.1209024e-05 * max(Age - 62.2, 0) ** 3 - 1.1187177e-05 * max(Age - 79.4, 0) ** 3 - 
                                             0.25028451 * (Gender == "Male") + 0.093197993 * (Ethnicity == "Other") - 0.014311437 * (Ethnicity == "White") + 
                                             0.038098961 * (175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 
                                             8.3085786e-06 * max((175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 46.640975, 0) ** 3 + 
                                             3.7688189e-05 * max((175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 76.946634, 0) ** 3 - 
                                             2.9379611e-05 * max((175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 85.5171, 0) ** 3 + 
                                             0.033146823 * ((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 
                                             8.921034e-05 * max(((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 24.3, 0) ** 3 + 
                                             0.00014516955 * max(((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 31.2, 0) ** 3 -
                                             5.5959213e-05 * max(((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 42.2, 0) ** 3 - 
                                             0.0003764071 * HbA1c - 
                                             0.0016038641 * max(HbA1c - 5.8, 0) ** 3 + 
                                             0.0023281898 * max(HbA1c - 7.2, 0) ** 3 - 
                                             0.0007243257 * max(HbA1c - 10.3, 0) ** 3 + 
                                             0.013984497 * (CAD == "Yes") - 
                                             0.03536975 * (Smoking_Status == "Quit") - 
                                             0.18342601 * (Smoking_Status == "Yes") + 
                                             0.00080529696 * BPSystolic - 
                                             2.4267329e-06 * max(BPSystolic - 110, 0) ** 3 + 
                                             4.3334517e-06 * max(BPSystolic - 132, 0) ** 3 - 
                                             1.9067187e-06 * max(BPSystolic - 160, 0) ** 3 + 
                                             0.011389918 * BPDiastolic - 
                                             4.5362964e-06 * max(BPDiastolic - 60, 0) ** 3 + 
                                             1.1340741e-05 * max(BPDiastolic - 78, 0) ** 3 -
                                             6.8044446e-06 * max(BPDiastolic - 90, 0) ** 3 - 
                                             0.12993847 * (Insulin == "Yes") - 
                                             0.077020933 * (Plavix == "Yes") +
                                             0.21832248 * (Aspirin == "Yes") + 
                                             0.058925574 * (ACEI_ARB == "Yes") + 
                                             0.89908317 * (New_Diabetes == "Yes") + 
                                             0.080586787 * (log(income)) + 
                                             0.25730502 * max((log(income)) - 10.184972, 0) ** 3 -
                                             0.52595659 * max((log(income)) - 10.644067, 0) ** 3 + 
                                             0.26865157 * max((log(income)) - 11.083772, 0) ** 3) + 1)) - 0.46772822, 0)**3 - 
        6.6467554 * max((exp(-4.2616758 - 0.016509512 * Age - 
                                 1.0021846e-05 * max(Age - 43, 0) ** 3 + 2.1209024e-05 * max(Age - 62.2, 0) ** 3 - 1.1187177e-05 * max(Age - 79.4, 0) ** 3 - 
                                 0.25028451 * (Gender == "Male") + 0.093197993 * (Ethnicity == "Other") - 0.014311437 * (Ethnicity == "White") + 
                                 0.038098961 * (175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 
                                 8.3085786e-06 * max((175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 46.640975, 0) ** 3 + 
                                 3.7688189e-05 * max((175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 76.946634, 0) ** 3 - 
                                 2.9379611e-05 * max((175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 85.5171, 0) ** 3 + 
                                 0.033146823 * ((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 
                                 8.921034e-05 * max(((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 24.3, 0) ** 3 + 
                                 0.00014516955 * max(((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 31.2, 0) ** 3 -
                                 5.5959213e-05 * max(((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 42.2, 0) ** 3 - 
                                 0.0003764071 * HbA1c - 
                                 0.0016038641 * max(HbA1c - 5.8, 0) ** 3 + 
                                 0.0023281898 * max(HbA1c - 7.2, 0) ** 3 - 
                                 0.0007243257 * max(HbA1c - 10.3, 0) ** 3 + 
                                 0.013984497 * (CAD == "Yes") - 
                                 0.03536975 * (Smoking_Status == "Quit") - 
                                 0.18342601 * (Smoking_Status == "Yes") + 
                                 0.00080529696 * BPSystolic - 
                                 2.4267329e-06 * max(BPSystolic - 110, 0) ** 3 + 
                                 4.3334517e-06 * max(BPSystolic - 132, 0) ** 3 - 
                                 1.9067187e-06 * max(BPSystolic - 160, 0) ** 3 + 
                                 0.011389918 * BPDiastolic - 
                                 4.5362964e-06 * max(BPDiastolic - 60, 0) ** 3 + 
                                 1.1340741e-05 * max(BPDiastolic - 78, 0) ** 3 -
                                 6.8044446e-06 * max(BPDiastolic - 90, 0) ** 3 - 
                                 0.12993847 * (Insulin == "Yes") - 
                                 0.077020933 * (Plavix == "Yes") +
                                 0.21832248 * (Aspirin == "Yes") + 
                                 0.058925574 * (ACEI_ARB == "Yes") + 
                                 0.89908317 * (New_Diabetes == "Yes") + 
                                 0.080586787 * (log(income)) + 
                                 0.25730502 * max((log(income)) - 10.184972, 0) ** 3 -
                                 0.52595659 * max((log(income)) - 10.644067, 0) ** 3 + 
                                 0.26865157 * max((log(income)) - 11.083772, 0) ** 3) / (
                                     exp(-4.2616758 - 0.016509512 * Age - 
                                             1.0021846e-05 * max(Age - 43, 0) ** 3 + 2.1209024e-05 * max(Age - 62.2, 0) ** 3 - 1.1187177e-05 * max(Age - 79.4, 0) ** 3 - 
                                             0.25028451 * (Gender == "Male") + 0.093197993 * (Ethnicity == "Other") - 0.014311437 * (Ethnicity == "White") + 
                                             0.038098961 * (175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 
                                             8.3085786e-06 * max((175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 46.640975, 0) ** 3 + 
                                             3.7688189e-05 * max((175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 76.946634, 0) ** 3 - 
                                             2.9379611e-05 * max((175 * (Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender == "Female")) * (1.21 ^ (Ethnicity == "Black"))) - 85.5171, 0) ** 3 + 
                                             0.033146823 * ((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 
                                             8.921034e-05 * max(((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 24.3, 0) ** 3 + 
                                             0.00014516955 * max(((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 31.2, 0) ** 3 -
                                             5.5959213e-05 * max(((Weight * 0.45359237) / ((Height * 0.0254) ^ 2)) - 42.2, 0) ** 3 - 
                                             0.0003764071 * HbA1c - 
                                             0.0016038641 * max(HbA1c - 5.8, 0) ** 3 + 
                                             0.0023281898 * max(HbA1c - 7.2, 0) ** 3 - 
                                             0.0007243257 * max(HbA1c - 10.3, 0) ** 3 + 
                                             0.013984497 * (CAD == "Yes") - 
                                             0.03536975 * (Smoking_Status == "Quit") - 
                                             0.18342601 * (Smoking_Status == "Yes") + 
                                             0.00080529696 * BPSystolic - 
                                             2.4267329e-06 * max(BPSystolic - 110, 0) ** 3 + 
                                             4.3334517e-06 * max(BPSystolic - 132, 0) ** 3 - 
                                             1.9067187e-06 * max(BPSystolic - 160, 0) ** 3 + 
                                             0.011389918 * BPDiastolic - 
                                             4.5362964e-06 * max(BPDiastolic - 60, 0) ** 3 + 
                                             1.1340741e-05 * max(BPDiastolic - 78, 0) ** 3 -
                                             6.8044446e-06 * max(BPDiastolic - 90, 0) ** 3 - 
                                             0.12993847 * (Insulin == "Yes") - 
                                             0.077020933 * (Plavix == "Yes") +
                                             0.21832248 * (Aspirin == "Yes") + 
                                             0.058925574 * (ACEI_ARB == "Yes") + 
                                             0.89908317 * (New_Diabetes == "Yes") + 
                                             0.080586787 * (log(income)) + 
                                             0.25730502 * max((log(income)) - 10.184972, 0) ** 3 -
                                             0.52595659 * max((log(income)) - 10.644067, 0) ** 3 + 
                                             0.26865157 * max((log(income)) - 11.083772, 0) ** 3) + 1)) - 0.70147167, 0)**3 + 
        (Med == "MEG") * (-0.000524794 * Age - 2.5256683e-05 * max(Age - 43, 0)**3 + 5.3450189e-05 * max(Age - 62.2, 0)**3 - 2.8193506e-05 * max(Age - 79.4, 0)**3) + 
        (Med == "SFU") * (-0.0068668381 * Age - 8.1052006e-06 * max(Age - 43, 0)**3 + 1.7152866e-05 * max(Age - 62.2, 0)**3 - 9.0476658e-06 * max(Age - 79.4, 0)**3) + 
        (Med == "TZD") * (0.026591398 * Age - 1.8107953e-05 * max(Age - 43, 0)**3 + 3.8321483e-05 * max(Age - 62.2, 0)**3 - 2.0213529e-05 * max(Age - 79.4, 0)**3) + 
        (Med == "MEG") * (0.01697257 * (175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 1.9075489e-05 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 46.640975, 0)**3 + 8.6527513e-05 *     max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 76.946634, 0)**3 - 6.7452024e-05 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 85.5171,     0)**3) + 
        (Med == "SFU") * (0.0010310876 * (175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 4.5950889e-07 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 46.640975, 0)**3 + 2.0843587e-06 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 76.946634,     0)**3 - 1.6248498e-06 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 85.5171, 0)**3) + 
        (Med == "TZD") * (0.0025547264 * (175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) + 2.5426269e-06 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) -     46.640975, 0)**3 - 1.1533502e-05 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 76.946634, 0)**3 +     8.9908747e-06 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 85.5171, 0)**3)
    1 - 0.8883752 ^ exp(lp)
})

predict.mortality <- expression({
    lp <- 3.5467088 + 
        0.037615999 * Age - 
        1.2853312e-06 * max(Age - 43.4, 0)**3 + 
        2.7294386e-06 * max(Age - 62.5, 0)**3 - 
        1.4441074e-06 * max(Age - 79.5, 0)**3 + 
        0.025158963 * (Gender == "Male") - 
        0.08442759 * (Ethnicity == "Other") +
        0.20195445 * (Ethnicity == "White") - 
        0.011780099 * (175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) +
        5.312029e-06 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 45.280126, 0)**3 - 
        2.2714637e-05 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 76.050002, 0)**3 + 
        1.7402608e-05 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 85.4423, 0)**3 + 
        2.8592158 * (Med == "MEG") + 
        1.7486139 * (Med == "SFU") + 
        2.0136689 * (Med == "TZD") - 
        0.005792946 * LDL + 
        4.0413849e-07 * max(LDL - 62, 0)**3 - 
        7.0350034e-07 * max(LDL - 102, 0)**3 + 
        2.9936185e-07 * max(LDL - 156, 0)**3 + 
        0.00044294777 * HDL + 
        2.9443587e-06 * max(HDL - 31, 0)**3 - 
        4.8581918e-06 * max(HDL - 44, 0)**3 + 
        1.9138331e-06 * max(HDL - 64, 0)**3 - 
        0.00046938296 * Triglycerides +
        7.0615031e-09 * max(Triglycerides - 78, 0)**3 - 
        1.0028837e-08 * max(Triglycerides - 157, 0)**3 + 
        2.9673337e-09 * max(Triglycerides - 345, 0)**3 - 
        0.027876562 * ((Weight*0.45359237)/((Height*0.0254) ^ 2)) + 
        0.0001065431 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 24.3, 0)**3 - 
        0.00017398782 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 31.2, 0)**3 +     
        6.7444716e-05 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 42.1, 0)**3 - 
        0.07805075 * HbA1c + 
        0.0066781378 * max(HbA1c - 5.8, 0)**3 - 
        0.0097946021 * max(HbA1c - 7.2, 0)**3 + 
        0.0031164643 * max(HbA1c - 10.2, 0)**3 + 
        0.3902157 * (CHF == "Yes") + 
        0.22317074 * (Smoking_Status == "Quit") + 
        0.42038837 * (Smoking_Status == "Yes") - 
        0.012125704 * BPSystolic + 
        3.3258674e-06 * max(BPSystolic - 110, 0)**3 - 
        5.939049e-06 * max(BPSystolic - 132, 0)**3 + 
        2.6131815e-06 * max(BPSystolic - 160, 0)**3 - 
        0.0079724066 * BPDiastolic + 
        2.8300369e-06 * max(BPDiastolic - 60, 0)**3 - 
        7.0750923e-06 * max(BPDiastolic - 78, 0)**3 +
        4.2450554e-06 * max(BPDiastolic - 90, 0)**3 + 
        0.3642741 * (Insulin == "Yes") + 
        0.080094556 * (Plavix == "Yes") +
        0.013347442 * (Aspirin == "Yes") - 
        0.13922953 * (ACEI_ARB == "Yes") - 
        0.22296023 * (Cholesterol_Med == "Yes") + 
        0.34422819 * (New_Diabetes == "Yes") - 
        0.058047237 * (log(income)) - 
        0.17992791 * max((log(income)) - 10.176906, 0)**3 + 
        0.38388469 * max((log(income)) - 10.641369, 0)**3 - 
        0.20395678 * max((log(income)) - 11.051112, 0)**3 - 
        1.6059079 * (exp(-3.6699688 - 
                             0.018889289 * Age - 
                             8.7888158e-06 * max(Age - 43.4, 0)**3 + 
                             1.8663309e-05 * max(Age - 62.5, 0)**3 -
                             9.874493e-06 * max(Age - 79.5, 0)**3 - 
                             0.26775075 * (Gender == "Male") +
                             0.12441848 * (Ethnicity == "Other") + 
                             0.020551255 * (Ethnicity == "White") + 
                             0.038793428 * (175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 
                             7.6778135e-06 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 45.280126, 0)**3 + 
                             3.283091e-05 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 76.050002, 0)**3 - 
                             2.5153096e-05 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 85.4423, 0)**3 - 
                             0.0023106744 * LDL + 8.6281653e-08 * max(LDL - 62, 0)**3 - 1.5019399e-07 * max(LDL - 102, 0)**3 + 6.3912336e-08 * max(LDL - 156, 0)**3 + 
                             0.0065280145 * HDL - 5.840118e-06 * max(HDL - 31, 0)**3 + 9.6361946e-06 * max(HDL - 44, 0)**3 - 3.7960767e-06 * max(HDL - 64, 0)**3 - 
                             0.00048789402 * Triglycerides + 3.5573094e-09 * max(Triglycerides - 78, 0)**3 - 5.0521362e-09 * max(Triglycerides - 157, 0)**3 + 
                             1.4948268e-09 * max(Triglycerides - 345, 0)**3 +        
                             0.032770361 * ((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 
                             8.5850348e-05 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 24.3, 0)**3 + 
                             0.00014019598 * max(((Weight*0.45359237)/((Height*0.0254)   ^   2)) - 31.2, 0)**3 - 
                             5.4345633e-05 * max(((Weight*0.45359237)/((Height*0.0254)   ^   2)) - 42.1, 0)**3 + 
                             0.0062232893 * HbA1c - 0.0011964467 * max(HbA1c - 5.8, 0)**3 + 0.0017547885 * max(HbA1c - 7.2, 0)**3 - 0.00055834179 * max(HbA1c - 10.2, 0)**3 -  
                             0.6064296 * (CHF == "Yes") - 0.043634752 * (Smoking_Status == "Quit") - 0.15477394 * (Smoking_Status == "Yes") + 
                             0.0014815981 * BPSystolic - 2.4321276e-06 * max(BPSystolic - 110, 0)**3 + 4.343085e-06 * max(BPSystolic - 132, 0)**3 - 
                             1.9109574e-06 * max(BPSystolic - 160, 0)**3 + 0.011922801 * BPDiastolic - 3.9439454e-06 * max(BPDiastolic - 60, 0)**3 + 
                             9.8598636e-06 * max(BPDiastolic - 78, 0)**3 - 5.9159182e-06 * max(BPDiastolic - 90, 0)**3 - 
                             0.15390596 * (Insulin == "Yes") - 0.14049418 * (Plavix == "Yes") + 0.17260776 * (Aspirin == "Yes") +
                             0.0021291875 * (ACEI_ARB == "Yes") + 0.23597188 * (Cholesterol_Med == "Yes") + 0.88991843 * (New_Diabetes == "Yes") + 
                             0.011634894 * (log(income)) + 0.32717148 * max((log(income)) - 10.176906, 0)**3 - 0.6980358 * max((log(income)) - 10.641369, 0)**3 + 
                             0.37086431 * max((log(income)) - 11.051112, 0)**3)/
                         (exp(-3.6699688 - 
                              0.018889289 * Age - 
                              8.7888158e-06 * max(Age - 43.4, 0)**3 + 
                              1.8663309e-05 * max(Age - 62.5, 0)**3 -
                              9.874493e-06 * max(Age - 79.5, 0)**3 - 
                              0.26775075 * (Gender == "Male") +
                              0.12441848 * (Ethnicity == "Other") + 
                              0.020551255 * (Ethnicity == "White") + 
                              0.038793428 * (175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 
                              7.6778135e-06 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 45.280126, 0)**3 + 
                              3.283091e-05 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 76.050002, 0)**3 - 
                              2.5153096e-05 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 85.4423, 0)**3 - 
                              0.0023106744 * LDL + 8.6281653e-08 * max(LDL - 62, 0)**3 - 1.5019399e-07 * max(LDL - 102, 0)**3 + 6.3912336e-08 * max(LDL - 156, 0)**3 + 
                              0.0065280145 * HDL - 5.840118e-06 * max(HDL - 31, 0)**3 + 9.6361946e-06 * max(HDL - 44, 0)**3 - 3.7960767e-06 * max(HDL - 64, 0)**3 - 
                              0.00048789402 * Triglycerides + 3.5573094e-09 * max(Triglycerides - 78, 0)**3 - 5.0521362e-09 * max(Triglycerides - 157, 0)**3 + 
                              1.4948268e-09 * max(Triglycerides - 345, 0)**3 +        
                              0.032770361 * ((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 
                              8.5850348e-05 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 24.3, 0)**3 + 
                              0.00014019598 * max(((Weight*0.45359237)/((Height*0.0254)   ^   2)) - 31.2, 0)**3 - 
                              5.4345633e-05 * max(((Weight*0.45359237)/((Height*0.0254)   ^   2)) - 42.1, 0)**3 + 
                              0.0062232893 * HbA1c - 0.0011964467 * max(HbA1c - 5.8, 0)**3 + 0.0017547885 * max(HbA1c - 7.2, 0)**3 - 0.00055834179 * max(HbA1c - 10.2, 0)**3 -  
                              0.6064296 * (CHF == "Yes") - 0.043634752 * (Smoking_Status == "Quit") - 0.15477394 * (Smoking_Status == "Yes") + 
                              0.0014815981 * BPSystolic - 2.4321276e-06 * max(BPSystolic - 110, 0)**3 + 4.343085e-06 * max(BPSystolic - 132, 0)**3 - 
                              1.9109574e-06 * max(BPSystolic - 160, 0)**3 + 0.011922801 * BPDiastolic - 3.9439454e-06 * max(BPDiastolic - 60, 0)**3 + 
                              9.8598636e-06 * max(BPDiastolic - 78, 0)**3 - 5.9159182e-06 * max(BPDiastolic - 90, 0)**3 - 
                              0.15390596 * (Insulin == "Yes") - 0.14049418 * (Plavix == "Yes") + 0.17260776 * (Aspirin == "Yes") +
                              0.0021291875 * (ACEI_ARB == "Yes") + 0.23597188 * (Cholesterol_Med == "Yes") + 0.88991843 * (New_Diabetes == "Yes") + 
                              0.011634894 * (log(income)) + 0.32717148 * max((log(income)) - 10.176906, 0)**3 - 0.6980358 * max((log(income)) - 10.641369, 0)**3 + 
                              0.37086431 * max((log(income)) - 11.051112, 0)**3) +1)) - 
        5.8291758 * max((exp(-3.6699688 - 
                                 0.018889289 * Age - 
                                 8.7888158e-06 * max(Age - 43.4, 0)**3 + 
                                 1.8663309e-05 * max(Age - 62.5, 0)**3 -
                                 9.874493e-06 * max(Age - 79.5, 0)**3 - 
                                 0.26775075 * (Gender == "Male") +
                                 0.12441848 * (Ethnicity == "Other") + 
                                 0.020551255 * (Ethnicity == "White") + 
                                 0.038793428 * (175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 
                                 7.6778135e-06 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 45.280126, 0)**3 + 
                                 3.283091e-05 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 76.050002, 0)**3 - 
                                 2.5153096e-05 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 85.4423, 0)**3 - 
                                 0.0023106744 * LDL + 8.6281653e-08 * max(LDL - 62, 0)**3 - 1.5019399e-07 * max(LDL - 102, 0)**3 + 6.3912336e-08 * max(LDL - 156, 0)**3 + 
                                 0.0065280145 * HDL - 5.840118e-06 * max(HDL - 31, 0)**3 + 9.6361946e-06 * max(HDL - 44, 0)**3 - 3.7960767e-06 * max(HDL - 64, 0)**3 - 
                                 0.00048789402 * Triglycerides + 3.5573094e-09 * max(Triglycerides - 78, 0)**3 - 5.0521362e-09 * max(Triglycerides - 157, 0)**3 + 
                                 1.4948268e-09 * max(Triglycerides - 345, 0)**3 +        
                                 0.032770361 * ((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 
                                 8.5850348e-05 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 24.3, 0)**3 + 
                                 0.00014019598 * max(((Weight*0.45359237)/((Height*0.0254)   ^   2)) - 31.2, 0)**3 - 
                                 5.4345633e-05 * max(((Weight*0.45359237)/((Height*0.0254)   ^   2)) - 42.1, 0)**3 + 
                                 0.0062232893 * HbA1c - 0.0011964467 * max(HbA1c - 5.8, 0)**3 + 0.0017547885 * max(HbA1c - 7.2, 0)**3 - 0.00055834179 * max(HbA1c - 10.2, 0)**3 -  
                                 0.6064296 * (CHF == "Yes") - 0.043634752 * (Smoking_Status == "Quit") - 0.15477394 * (Smoking_Status == "Yes") + 
                                 0.0014815981 * BPSystolic - 2.4321276e-06 * max(BPSystolic - 110, 0)**3 + 4.343085e-06 * max(BPSystolic - 132, 0)**3 - 
                                 1.9109574e-06 * max(BPSystolic - 160, 0)**3 + 0.011922801 * BPDiastolic - 3.9439454e-06 * max(BPDiastolic - 60, 0)**3 + 
                                 9.8598636e-06 * max(BPDiastolic - 78, 0)**3 - 5.9159182e-06 * max(BPDiastolic - 90, 0)**3 - 
                                 0.15390596 * (Insulin == "Yes") - 0.14049418 * (Plavix == "Yes") + 0.17260776 * (Aspirin == "Yes") +
                                 0.0021291875 * (ACEI_ARB == "Yes") + 0.23597188 * (Cholesterol_Med == "Yes") + 0.88991843 * (New_Diabetes == "Yes") + 
                                 0.011634894 * (log(income)) + 0.32717148 * max((log(income)) - 10.176906, 0)**3 - 0.6980358 * max((log(income)) - 10.641369, 0)**3 + 
                                 0.37086431 * max((log(income)) - 11.051112, 0)**3)/
                             (exp(-3.6699688 - 
                                      0.018889289 * Age - 
                                      8.7888158e-06 * max(Age - 43.4, 0)**3 + 
                                      1.8663309e-05 * max(Age - 62.5, 0)**3 -
                                      9.874493e-06 * max(Age - 79.5, 0)**3 - 
                                      0.26775075 * (Gender == "Male") +
                                      0.12441848 * (Ethnicity == "Other") + 
                                      0.020551255 * (Ethnicity == "White") + 
                                      0.038793428 * (175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 
                                      7.6778135e-06 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 45.280126, 0)**3 + 
                                      3.283091e-05 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 76.050002, 0)**3 - 
                                      2.5153096e-05 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 85.4423, 0)**3 - 
                                      0.0023106744 * LDL + 8.6281653e-08 * max(LDL - 62, 0)**3 - 1.5019399e-07 * max(LDL - 102, 0)**3 + 6.3912336e-08 * max(LDL - 156, 0)**3 + 
                                      0.0065280145 * HDL - 5.840118e-06 * max(HDL - 31, 0)**3 + 9.6361946e-06 * max(HDL - 44, 0)**3 - 3.7960767e-06 * max(HDL - 64, 0)**3 - 
                                      0.00048789402 * Triglycerides + 3.5573094e-09 * max(Triglycerides - 78, 0)**3 - 5.0521362e-09 * max(Triglycerides - 157, 0)**3 + 
                                      1.4948268e-09 * max(Triglycerides - 345, 0)**3 +        
                                      0.032770361 * ((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 
                                      8.5850348e-05 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 24.3, 0)**3 + 
                                      0.00014019598 * max(((Weight*0.45359237)/((Height*0.0254)   ^   2)) - 31.2, 0)**3 - 
                                      5.4345633e-05 * max(((Weight*0.45359237)/((Height*0.0254)   ^   2)) - 42.1, 0)**3 + 
                                      0.0062232893 * HbA1c - 0.0011964467 * max(HbA1c - 5.8, 0)**3 + 0.0017547885 * max(HbA1c - 7.2, 0)**3 - 0.00055834179 * max(HbA1c - 10.2, 0)**3 -  
                                      0.6064296 * (CHF == "Yes") - 0.043634752 * (Smoking_Status == "Quit") - 0.15477394 * (Smoking_Status == "Yes") + 
                                      0.0014815981 * BPSystolic - 2.4321276e-06 * max(BPSystolic - 110, 0)**3 + 4.343085e-06 * max(BPSystolic - 132, 0)**3 - 
                                      1.9109574e-06 * max(BPSystolic - 160, 0)**3 + 0.011922801 * BPDiastolic - 3.9439454e-06 * max(BPDiastolic - 60, 0)**3 + 
                                      9.8598636e-06 * max(BPDiastolic - 78, 0)**3 - 5.9159182e-06 * max(BPDiastolic - 90, 0)**3 - 
                                      0.15390596 * (Insulin == "Yes") - 0.14049418 * (Plavix == "Yes") + 0.17260776 * (Aspirin == "Yes") +
                                      0.0021291875 * (ACEI_ARB == "Yes") + 0.23597188 * (Cholesterol_Med == "Yes") + 0.88991843 * (New_Diabetes == "Yes") + 
                                      0.011634894 * (log(income)) + 0.32717148 * max((log(income)) - 10.176906, 0)**3 - 0.6980358 * max((log(income)) - 10.641369, 0)**3 + 
                                      0.37086431 * max((log(income)) - 11.051112, 0)**3) +1)) - 0.17064389, 0)**3 +
        12.641086 * max((exp(-3.6699688 - 
                                 0.018889289 * Age - 
                                 8.7888158e-06 * max(Age - 43.4, 0)**3 + 
                                 1.8663309e-05 * max(Age - 62.5, 0)**3 -
                                 9.874493e-06 * max(Age - 79.5, 0)**3 - 
                                 0.26775075 * (Gender == "Male") +
                                 0.12441848 * (Ethnicity == "Other") + 
                                 0.020551255 * (Ethnicity == "White") + 
                                 0.038793428 * (175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 
                                 7.6778135e-06 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 45.280126, 0)**3 + 
                                 3.283091e-05 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 76.050002, 0)**3 - 
                                 2.5153096e-05 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 85.4423, 0)**3 - 
                                 0.0023106744 * LDL + 8.6281653e-08 * max(LDL - 62, 0)**3 - 1.5019399e-07 * max(LDL - 102, 0)**3 + 6.3912336e-08 * max(LDL - 156, 0)**3 + 
                                 0.0065280145 * HDL - 5.840118e-06 * max(HDL - 31, 0)**3 + 9.6361946e-06 * max(HDL - 44, 0)**3 - 3.7960767e-06 * max(HDL - 64, 0)**3 - 
                                 0.00048789402 * Triglycerides + 3.5573094e-09 * max(Triglycerides - 78, 0)**3 - 5.0521362e-09 * max(Triglycerides - 157, 0)**3 + 
                                 1.4948268e-09 * max(Triglycerides - 345, 0)**3 +        
                                 0.032770361 * ((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 
                                 8.5850348e-05 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 24.3, 0)**3 + 
                                 0.00014019598 * max(((Weight*0.45359237)/((Height*0.0254)   ^   2)) - 31.2, 0)**3 - 
                                 5.4345633e-05 * max(((Weight*0.45359237)/((Height*0.0254)   ^   2)) - 42.1, 0)**3 + 
                                 0.0062232893 * HbA1c - 0.0011964467 * max(HbA1c - 5.8, 0)**3 + 0.0017547885 * max(HbA1c - 7.2, 0)**3 - 0.00055834179 * max(HbA1c - 10.2, 0)**3 -  
                                 0.6064296 * (CHF == "Yes") - 0.043634752 * (Smoking_Status == "Quit") - 0.15477394 * (Smoking_Status == "Yes") + 
                                 0.0014815981 * BPSystolic - 2.4321276e-06 * max(BPSystolic - 110, 0)**3 + 4.343085e-06 * max(BPSystolic - 132, 0)**3 - 
                                 1.9109574e-06 * max(BPSystolic - 160, 0)**3 + 0.011922801 * BPDiastolic - 3.9439454e-06 * max(BPDiastolic - 60, 0)**3 + 
                                 9.8598636e-06 * max(BPDiastolic - 78, 0)**3 - 5.9159182e-06 * max(BPDiastolic - 90, 0)**3 - 
                                 0.15390596 * (Insulin == "Yes") - 0.14049418 * (Plavix == "Yes") + 0.17260776 * (Aspirin == "Yes") +
                                 0.0021291875 * (ACEI_ARB == "Yes") + 0.23597188 * (Cholesterol_Med == "Yes") + 0.88991843 * (New_Diabetes == "Yes") + 
                                 0.011634894 * (log(income)) + 0.32717148 * max((log(income)) - 10.176906, 0)**3 - 0.6980358 * max((log(income)) - 10.641369, 0)**3 + 
                                 0.37086431 * max((log(income)) - 11.051112, 0)**3)/
                             (exp(-3.6699688 - 
                                      0.018889289 * Age - 
                                      8.7888158e-06 * max(Age - 43.4, 0)**3 + 
                                      1.8663309e-05 * max(Age - 62.5, 0)**3 -
                                      9.874493e-06 * max(Age - 79.5, 0)**3 - 
                                      0.26775075 * (Gender == "Male") +
                                      0.12441848 * (Ethnicity == "Other") + 
                                      0.020551255 * (Ethnicity == "White") + 
                                      0.038793428 * (175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 
                                      7.6778135e-06 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 45.280126, 0)**3 + 
                                      3.283091e-05 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 76.050002, 0)**3 - 
                                      2.5153096e-05 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 85.4423, 0)**3 - 
                                      0.0023106744 * LDL + 8.6281653e-08 * max(LDL - 62, 0)**3 - 1.5019399e-07 * max(LDL - 102, 0)**3 + 6.3912336e-08 * max(LDL - 156, 0)**3 + 
                                      0.0065280145 * HDL - 5.840118e-06 * max(HDL - 31, 0)**3 + 9.6361946e-06 * max(HDL - 44, 0)**3 - 3.7960767e-06 * max(HDL - 64, 0)**3 - 
                                      0.00048789402 * Triglycerides + 3.5573094e-09 * max(Triglycerides - 78, 0)**3 - 5.0521362e-09 * max(Triglycerides - 157, 0)**3 + 
                                      1.4948268e-09 * max(Triglycerides - 345, 0)**3 +        
                                      0.032770361 * ((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 
                                      8.5850348e-05 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 24.3, 0)**3 + 
                                      0.00014019598 * max(((Weight*0.45359237)/((Height*0.0254)   ^   2)) - 31.2, 0)**3 - 
                                      5.4345633e-05 * max(((Weight*0.45359237)/((Height*0.0254)   ^   2)) - 42.1, 0)**3 + 
                                      0.0062232893 * HbA1c - 0.0011964467 * max(HbA1c - 5.8, 0)**3 + 0.0017547885 * max(HbA1c - 7.2, 0)**3 - 0.00055834179 * max(HbA1c - 10.2, 0)**3 -  
                                      0.6064296 * (CHF == "Yes") - 0.043634752 * (Smoking_Status == "Quit") - 0.15477394 * (Smoking_Status == "Yes") + 
                                      0.0014815981 * BPSystolic - 2.4321276e-06 * max(BPSystolic - 110, 0)**3 + 4.343085e-06 * max(BPSystolic - 132, 0)**3 - 
                                      1.9109574e-06 * max(BPSystolic - 160, 0)**3 + 0.011922801 * BPDiastolic - 3.9439454e-06 * max(BPDiastolic - 60, 0)**3 + 
                                      9.8598636e-06 * max(BPDiastolic - 78, 0)**3 - 5.9159182e-06 * max(BPDiastolic - 90, 0)**3 - 
                                      0.15390596 * (Insulin == "Yes") - 0.14049418 * (Plavix == "Yes") + 0.17260776 * (Aspirin == "Yes") +
                                      0.0021291875 * (ACEI_ARB == "Yes") + 0.23597188 * (Cholesterol_Med == "Yes") + 0.88991843 * (New_Diabetes == "Yes") + 
                                      0.011634894 * (log(income)) + 0.32717148 * max((log(income)) - 10.176906, 0)**3 - 0.6980358 * max((log(income)) - 10.641369, 0)**3 + 
                                      0.37086431 * max((log(income)) - 11.051112, 0)**3) +1)) - 0.45479155, 0)**3 - 
        6.8119101 * max((exp(-3.6699688 - 
                                 0.018889289 * Age - 
                                 8.7888158e-06 * max(Age - 43.4, 0)**3 + 
                                 1.8663309e-05 * max(Age - 62.5, 0)**3 -
                                 9.874493e-06 * max(Age - 79.5, 0)**3 - 
                                 0.26775075 * (Gender == "Male") +
                                 0.12441848 * (Ethnicity == "Other") + 
                                 0.020551255 * (Ethnicity == "White") + 
                                 0.038793428 * (175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 
                                 7.6778135e-06 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 45.280126, 0)**3 + 
                                 3.283091e-05 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 76.050002, 0)**3 - 
                                 2.5153096e-05 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 85.4423, 0)**3 - 
                                 0.0023106744 * LDL + 8.6281653e-08 * max(LDL - 62, 0)**3 - 1.5019399e-07 * max(LDL - 102, 0)**3 + 6.3912336e-08 * max(LDL - 156, 0)**3 + 
                                 0.0065280145 * HDL - 5.840118e-06 * max(HDL - 31, 0)**3 + 9.6361946e-06 * max(HDL - 44, 0)**3 - 3.7960767e-06 * max(HDL - 64, 0)**3 - 
                                 0.00048789402 * Triglycerides + 3.5573094e-09 * max(Triglycerides - 78, 0)**3 - 5.0521362e-09 * max(Triglycerides - 157, 0)**3 + 
                                 1.4948268e-09 * max(Triglycerides - 345, 0)**3 +        
                                 0.032770361 * ((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 
                                 8.5850348e-05 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 24.3, 0)**3 + 
                                 0.00014019598 * max(((Weight*0.45359237)/((Height*0.0254)   ^   2)) - 31.2, 0)**3 - 
                                 5.4345633e-05 * max(((Weight*0.45359237)/((Height*0.0254)   ^   2)) - 42.1, 0)**3 + 
                                 0.0062232893 * HbA1c - 0.0011964467 * max(HbA1c - 5.8, 0)**3 + 0.0017547885 * max(HbA1c - 7.2, 0)**3 - 0.00055834179 * max(HbA1c - 10.2, 0)**3 -  
                                 0.6064296 * (CHF == "Yes") - 0.043634752 * (Smoking_Status == "Quit") - 0.15477394 * (Smoking_Status == "Yes") + 
                                 0.0014815981 * BPSystolic - 2.4321276e-06 * max(BPSystolic - 110, 0)**3 + 4.343085e-06 * max(BPSystolic - 132, 0)**3 - 
                                 1.9109574e-06 * max(BPSystolic - 160, 0)**3 + 0.011922801 * BPDiastolic - 3.9439454e-06 * max(BPDiastolic - 60, 0)**3 + 
                                 9.8598636e-06 * max(BPDiastolic - 78, 0)**3 - 5.9159182e-06 * max(BPDiastolic - 90, 0)**3 - 
                                 0.15390596 * (Insulin == "Yes") - 0.14049418 * (Plavix == "Yes") + 0.17260776 * (Aspirin == "Yes") +
                                 0.0021291875 * (ACEI_ARB == "Yes") + 0.23597188 * (Cholesterol_Med == "Yes") + 0.88991843 * (New_Diabetes == "Yes") + 
                                 0.011634894 * (log(income)) + 0.32717148 * max((log(income)) - 10.176906, 0)**3 - 0.6980358 * max((log(income)) - 10.641369, 0)**3 + 
                                 0.37086431 * max((log(income)) - 11.051112, 0)**3)/
                             (exp(-3.6699688 - 
                                      0.018889289 * Age - 
                                      8.7888158e-06 * max(Age - 43.4, 0)**3 + 
                                      1.8663309e-05 * max(Age - 62.5, 0)**3 -
                                      9.874493e-06 * max(Age - 79.5, 0)**3 - 
                                      0.26775075 * (Gender == "Male") +
                                      0.12441848 * (Ethnicity == "Other") + 
                                      0.020551255 * (Ethnicity == "White") + 
                                      0.038793428 * (175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 
                                      7.6778135e-06 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 45.280126, 0)**3 + 
                                      3.283091e-05 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 76.050002, 0)**3 - 
                                      2.5153096e-05 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 85.4423, 0)**3 - 
                                      0.0023106744 * LDL + 8.6281653e-08 * max(LDL - 62, 0)**3 - 1.5019399e-07 * max(LDL - 102, 0)**3 + 6.3912336e-08 * max(LDL - 156, 0)**3 + 
                                      0.0065280145 * HDL - 5.840118e-06 * max(HDL - 31, 0)**3 + 9.6361946e-06 * max(HDL - 44, 0)**3 - 3.7960767e-06 * max(HDL - 64, 0)**3 - 
                                      0.00048789402 * Triglycerides + 3.5573094e-09 * max(Triglycerides - 78, 0)**3 - 5.0521362e-09 * max(Triglycerides - 157, 0)**3 + 
                                      1.4948268e-09 * max(Triglycerides - 345, 0)**3 +        
                                      0.032770361 * ((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 
                                      8.5850348e-05 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 24.3, 0)**3 + 
                                      0.00014019598 * max(((Weight*0.45359237)/((Height*0.0254)   ^   2)) - 31.2, 0)**3 - 
                                      5.4345633e-05 * max(((Weight*0.45359237)/((Height*0.0254)   ^   2)) - 42.1, 0)**3 + 
                                      0.0062232893 * HbA1c - 0.0011964467 * max(HbA1c - 5.8, 0)**3 + 0.0017547885 * max(HbA1c - 7.2, 0)**3 - 0.00055834179 * max(HbA1c - 10.2, 0)**3 -  
                                      0.6064296 * (CHF == "Yes") - 0.043634752 * (Smoking_Status == "Quit") - 0.15477394 * (Smoking_Status == "Yes") + 
                                      0.0014815981 * BPSystolic - 2.4321276e-06 * max(BPSystolic - 110, 0)**3 + 4.343085e-06 * max(BPSystolic - 132, 0)**3 - 
                                      1.9109574e-06 * max(BPSystolic - 160, 0)**3 + 0.011922801 * BPDiastolic - 3.9439454e-06 * max(BPDiastolic - 60, 0)**3 + 
                                      9.8598636e-06 * max(BPDiastolic - 78, 0)**3 - 5.9159182e-06 * max(BPDiastolic - 90, 0)**3 - 
                                      0.15390596 * (Insulin == "Yes") - 0.14049418 * (Plavix == "Yes") + 0.17260776 * (Aspirin == "Yes") +
                                      0.0021291875 * (ACEI_ARB == "Yes") + 0.23597188 * (Cholesterol_Med == "Yes") + 0.88991843 * (New_Diabetes == "Yes") + 
                                      0.011634894 * (log(income)) + 0.32717148 * max((log(income)) - 10.176906, 0)**3 - 0.6980358 * max((log(income)) - 10.641369, 0)**3 + 
                                      0.37086431 * max((log(income)) - 11.051112, 0)**3) +1)) - 0.69794606, 0)**3 +
        (Med == "MEG") * (-0.048089282 * Age + 3.2885643e-05 * max(Age - 43.4, 0)**3 - 6.983363e-05 * max(Age - 62.5, 0)**3 + 3.6947987e-05 * max(Age - 79.5, 0)**3) + 
        (Med == "SFU") * (-0.0237419 * Age + 9.5418044e-06 * max(Age - 43.4, 0)**3 - 2.0262302e-05 * max(Age - 62.5, 0)**3 + 1.0720498e-05 * max(Age - 79.5, 0)**3) +  
        (Med == "TZD") * (-0.030250024 * Age + 2.0325216e-05 * max(Age - 43.4, 0)**3 - 4.3161193e-05 * max(Age - 62.5, 0)**3 + 2.2835977e-05 * max(Age - 79.5, 0)**3) +         
        (Med == "MEG") * (0.0026048521 * (175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) + 
                   2.5442232e-07 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 45.280126, 0)**3 - 
                   1.0879291e-06 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 76.050002, 0)**3 + 
                   8.3350673e-07 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 85.4423, 0)**3) + 
        (Med == "SFU") * (0.0032193455 * (175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 
                   2.7592326e-06 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 45.280126, 0)**3 + 
                   1.1798687e-05 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 76.050002, 0)**3 - 
                   9.0394541e-06 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 85.4423, 0)**3) + 
        (Med == "TZD") * (-0.0030033015 * (175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 
                   2.1119635e-09 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 45.280126, 0)**3 + 
                   9.0309153e-09 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 76.050002, 0)**3 - 
                   6.9189518e-09 * max((175*(Creatinine ^ -1.154) * (Age ^ -0.203) * (0.742 ^ (Gender=="Female")) * (1.21 ^ (Ethnicity=="Black"))) - 85.4423, 0)**3) + 
        (CHF == "Yes") * (0.099138972 * (Med == "MEG") - 
                              0.2317111 * (Med == "SFU") - 
                              0.22613974 * (Med == "TZD"))
    1 - 0.865841 ^ exp(lp)
})

predict.stroke <- expression({
    lp <- 0.051174701 * Age - 
        1.8479297e-05 * max(Age - 43,     0)**3 + 
        3.8999913e-05 * max(Age - 62.1, 0)**3 - 
        2.0520615e-05 *     max(Age - 79.3, 0)**3 + 
        0.002425129 * (175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) + 
        5.046344e-06 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 45.728683, 0)**3 - 
        2.2412463e-05 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 76.543594,     0)**3 + 
        1.7366119e-05 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 85.497963, 0)**3 + 
        1.4042994 * (Med == "MEG") + 
        1.5892214 * (Med == "SFU") + 
        2.5694096 * (Med == "TZD") - 
        0.0043052644 * LDL + 6.6137524e-07 * max(LDL - 62, 0)**3 - 1.1635305e-06 * max(LDL - 103, 0)**3 + 5.0215527e-07 * max(LDL - 157, 0)**3 - 
        0.0029816743 * HDL + 1.0728615e-08 * max(HDL - 31, 0)**3 - 1.7702215e-08 * max(HDL - 44, 0)**3 + 6.9735999e-09 * max(HDL - 64, 0)**3 - 
        0.0010947072 * Triglycerides + 1.9022852e-08 * max(Triglycerides - 78, 0)**3 - 2.6974203e-08 * max(Triglycerides - 157, 0)**3 + 
        7.951351e-09 * max(Triglycerides - 346, 0)**3 + 
        0.0064917666 * ((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 
        0.00011695537 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 24.3, 0)**3 + 
        0.00019031828 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 31.2, 0)**3 - 
        7.3362914e-05 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 42.2, 0)**3 + 
        0.045104407 * HbA1c - 0.0058450309 * max(HbA1c - 5.8, 0)**3 + 0.0084847222 * max(HbA1c - 7.2, 0)**3 - 0.0026396914 * max(HbA1c - 10.3, 0)**3 + 
        0.19059593 * (CAD == "Yes") - 0.045839257 * (CHF == "Yes") + 
        0.24127241 * (Smoking_Status == "Quit") + 0.28351727 * (Smoking_Status == "Yes") + 
        0.0077014398 * BPSystolic + 6.8252895e-07 * max(BPSystolic - 110, 0)**3 - 1.2188017e-06 * max(BPSystolic - 132, 0)**3 + 5.3627275e-07 * max(BPSystolic - 160, 0)**3 - 
        0.0098743459 * BPDiastolic + 3.0670553e-06 * max(BPDiastolic - 60, 0)**3 - 7.6676383e-06 * max(BPDiastolic - 78, 0)**3 + 4.600583e-06 * max(BPDiastolic - 90, 0)**3 + 
        0.092702677 * (Insulin == "Yes") + 0.95588559 * (Plavix == "Yes") + 0.30868153 * (Aspirin == "Yes") + 0.23881537 * (Cholesterol_Med == "Yes") + 
        0.03758578 * (New_Diabetes == "Yes") + 
        0.13487558 * (log(income)) - 0.36767191 * max((log(income)) - 10.176906, 0)**3 + 0.75553515 * max((log(income)) - 10.642086, 0)**3 - 
        0.38786324 * max((log(income)) - 11.08305, 0)**3 +  
        0.26917808 * (warfarin == "Yes") - 
        0.49563745 * (exp(-4.0547687 - 
                              0.019245713 * Age - 7.0378916e-06 * max(Age - 43, 0)**3 + 1.4853225e-05 * max(Age - 62.1, 0)**3 - 
                              7.8153331e-06 * max(Age - 79.3, 0)**3 + 
                              0.036085898 * (175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 
                              6.150184e-06 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 45.728683, 0)**3 + 
                              2.7314977e-05 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 76.543594, 0)**3 - 
                              2.1164793e-05 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 85.497963, 0)**3 - 
                              0.0022961162 * LDL + 9.6296232e-08 * max(LDL - 62, 0)**3 - 1.6941004e-07 * max(LDL - 103, 0)**3 + 7.3113806e-08 * max(LDL - 157, 0)**3 + 
                              0.0092680468 * HDL - 7.0154394e-06 * max(HDL - 31, 0)**3 + 1.1575475e-05 * max(HDL - 44, 0)**3 - 4.5600356e-06 * max(HDL - 64, 0)**3 - 
                              0.00043682684 * Triglycerides + 2.5161101e-09 * max(Triglycerides - 78, 0)**3 - 3.5678174e-09 * max(Triglycerides - 157, 0)**3 + 
                              1.0517074e-09 * max(Triglycerides - 346, 0)**3 +       
                              0.035883239 * ((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 
                              8.353176e-05 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 24.3, 0)**3 +         
                              0.00013592896 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 31.2, 0)**3 - 
                              5.2397195e-05 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 42.2, 0)**3 -
                              0.0081333129 * HbA1c - 0.00047820135 * max(HbA1c - 5.8, 0)**3 + 0.00069416325 * max(HbA1c - 7.2, 0)**3 - 0.0002159619 * max(HbA1c - 10.3, 0)**3 -
                              0.050685595 * (CAD == "Yes") - 
                              0.57157166 * (CHF == "Yes") - 
                              0.092138643 * (Smoking_Status == "Quit") - 
                              0.18120576 * (Smoking_Status == "Yes") + 
                              0.0012213694 * BPSystolic - 2.1935964e-06 * max(BPSystolic - 110, 0)**3 + 3.9171364e-06 * max(BPSystolic - 132, 0)**3 - 
                              1.72354e-06 * max(BPSystolic - 160, 0)**3 + 
                              0.01204621 * BPDiastolic - 5.3090258e-06 * max(BPDiastolic - 60, 0)**3 + 1.3272565e-05 * max(BPDiastolic - 78, 0)**3 - 
                              7.9635387e-06 * max(BPDiastolic - 90, 0)**3 - 
                              0.17493817 * (Insulin == "Yes") - 0.16364668 * (Plavix == "Yes") + 
                              0.15769762 * (Aspirin == "Yes") + 0.23961832 * (Cholesterol_Med == "Yes") + 
                              0.910847 * (New_Diabetes == "Yes") + 
                              0.047367865 * (log(income)) + 0.25090184 * max((log(income)) - 10.176906, 0)**3 - 
                              0.51558239 * max((log(income)) - 10.642086, 0)**3 + 
                              0.26468055 * max((log(income)) - 11.08305, 0)**3 - 
                              0.26485486 * (warfarin == "Yes"))/
                          (exp(-4.0547687 - 
                                    0.019245713 * Age - 7.0378916e-06 * max(Age - 43, 0)**3 + 1.4853225e-05 * max(Age - 62.1, 0)**3 - 
                                    7.8153331e-06 * max(Age - 79.3, 0)**3 + 
                                    0.036085898 * (175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 
                                    6.150184e-06 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 45.728683, 0)**3 + 
                                    2.7314977e-05 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 76.543594, 0)**3 - 
                                    2.1164793e-05 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 85.497963, 0)**3 - 
                                    0.0022961162 * LDL + 9.6296232e-08 * max(LDL - 62, 0)**3 - 1.6941004e-07 * max(LDL - 103, 0)**3 + 7.3113806e-08 * max(LDL - 157, 0)**3 + 
                                    0.0092680468 * HDL - 7.0154394e-06 * max(HDL - 31, 0)**3 + 1.1575475e-05 * max(HDL - 44, 0)**3 - 4.5600356e-06 * max(HDL - 64, 0)**3 - 
                                    0.00043682684 * Triglycerides + 2.5161101e-09 * max(Triglycerides - 78, 0)**3 - 3.5678174e-09 * max(Triglycerides - 157, 0)**3 + 
                                    1.0517074e-09 * max(Triglycerides - 346, 0)**3 +       
                                    0.035883239 * ((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 
                                    8.353176e-05 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 24.3, 0)**3 +         
                                    0.00013592896 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 31.2, 0)**3 - 
                                    5.2397195e-05 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 42.2, 0)**3 -
                                    0.0081333129 * HbA1c - 0.00047820135 * max(HbA1c - 5.8, 0)**3 + 0.00069416325 * max(HbA1c - 7.2, 0)**3 - 0.0002159619 * max(HbA1c - 10.3, 0)**3 -
                                    0.050685595 * (CAD == "Yes") - 
                                    0.57157166 * (CHF == "Yes") - 
                                    0.092138643 * (Smoking_Status == "Quit") - 
                                    0.18120576 * (Smoking_Status == "Yes") + 
                                    0.0012213694 * BPSystolic - 2.1935964e-06 * max(BPSystolic - 110, 0)**3 + 3.9171364e-06 * max(BPSystolic - 132, 0)**3 - 
                                    1.72354e-06 * max(BPSystolic - 160, 0)**3 + 
                                    0.01204621 * BPDiastolic - 5.3090258e-06 * max(BPDiastolic - 60, 0)**3 + 1.3272565e-05 * max(BPDiastolic - 78, 0)**3 - 
                                    7.9635387e-06 * max(BPDiastolic - 90, 0)**3 - 
                                    0.17493817 * (Insulin == "Yes") - 0.16364668 * (Plavix == "Yes") + 
                                    0.15769762 * (Aspirin == "Yes") + 0.23961832 * (Cholesterol_Med == "Yes") + 
                                    0.910847 * (New_Diabetes == "Yes") + 
                                    0.047367865 * (log(income)) + 0.25090184 * max((log(income)) - 10.176906, 0)**3 - 
                                    0.51558239 * max((log(income)) - 10.642086, 0)**3 + 
                                    0.26468055 * max((log(income)) - 11.08305, 0)**3 - 
                                    0.26485486 * (warfarin == "Yes")) +1)) - 
        5.2124061 * max((exp(-4.0547687 - 
                                 0.019245713 * Age - 7.0378916e-06 * max(Age - 43, 0)**3 + 1.4853225e-05 * max(Age - 62.1, 0)**3 - 
                                 7.8153331e-06 * max(Age - 79.3, 0)**3 + 
                                 0.036085898 * (175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 
                                 6.150184e-06 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 45.728683, 0)**3 + 
                                 2.7314977e-05 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 76.543594, 0)**3 - 
                                 2.1164793e-05 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 85.497963, 0)**3 - 
                                 0.0022961162 * LDL + 9.6296232e-08 * max(LDL - 62, 0)**3 - 1.6941004e-07 * max(LDL - 103, 0)**3 + 7.3113806e-08 * max(LDL - 157, 0)**3 + 
                                 0.0092680468 * HDL - 7.0154394e-06 * max(HDL - 31, 0)**3 + 1.1575475e-05 * max(HDL - 44, 0)**3 - 4.5600356e-06 * max(HDL - 64, 0)**3 - 
                                 0.00043682684 * Triglycerides + 2.5161101e-09 * max(Triglycerides - 78, 0)**3 - 3.5678174e-09 * max(Triglycerides - 157, 0)**3 + 
                                 1.0517074e-09 * max(Triglycerides - 346, 0)**3 +       
                                 0.035883239 * ((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 
                                 8.353176e-05 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 24.3, 0)**3 +         
                                 0.00013592896 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 31.2, 0)**3 - 
                                 5.2397195e-05 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 42.2, 0)**3 -
                                 0.0081333129 * HbA1c - 0.00047820135 * max(HbA1c - 5.8, 0)**3 + 0.00069416325 * max(HbA1c - 7.2, 0)**3 - 0.0002159619 * max(HbA1c - 10.3, 0)**3 -
                                 0.050685595 * (CAD == "Yes") - 
                                 0.57157166 * (CHF == "Yes") - 
                                 0.092138643 * (Smoking_Status == "Quit") - 
                                 0.18120576 * (Smoking_Status == "Yes") + 
                                 0.0012213694 * BPSystolic - 2.1935964e-06 * max(BPSystolic - 110, 0)**3 + 3.9171364e-06 * max(BPSystolic - 132, 0)**3 - 
                                 1.72354e-06 * max(BPSystolic - 160, 0)**3 + 
                                 0.01204621 * BPDiastolic - 5.3090258e-06 * max(BPDiastolic - 60, 0)**3 + 1.3272565e-05 * max(BPDiastolic - 78, 0)**3 - 
                                 7.9635387e-06 * max(BPDiastolic - 90, 0)**3 - 
                                 0.17493817 * (Insulin == "Yes") - 0.16364668 * (Plavix == "Yes") + 
                                 0.15769762 * (Aspirin == "Yes") + 0.23961832 * (Cholesterol_Med == "Yes") + 
                                 0.910847 * (New_Diabetes == "Yes") + 
                                 0.047367865 * (log(income)) + 0.25090184 * max((log(income)) - 10.176906, 0)**3 - 
                                 0.51558239 * max((log(income)) - 10.642086, 0)**3 + 
                                 0.26468055 * max((log(income)) - 11.08305, 0)**3 - 
                                 0.26485486 * (warfarin == "Yes"))/
                             (exp(-4.0547687 - 
                                      0.019245713 * Age - 7.0378916e-06 * max(Age - 43, 0)**3 + 1.4853225e-05 * max(Age - 62.1, 0)**3 - 
                                      7.8153331e-06 * max(Age - 79.3, 0)**3 + 
                                      0.036085898 * (175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 
                                      6.150184e-06 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 45.728683, 0)**3 + 
                                      2.7314977e-05 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 76.543594, 0)**3 - 
                                      2.1164793e-05 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 85.497963, 0)**3 - 
                                      0.0022961162 * LDL + 9.6296232e-08 * max(LDL - 62, 0)**3 - 1.6941004e-07 * max(LDL - 103, 0)**3 + 7.3113806e-08 * max(LDL - 157, 0)**3 + 
                                      0.0092680468 * HDL - 7.0154394e-06 * max(HDL - 31, 0)**3 + 1.1575475e-05 * max(HDL - 44, 0)**3 - 4.5600356e-06 * max(HDL - 64, 0)**3 - 
                                      0.00043682684 * Triglycerides + 2.5161101e-09 * max(Triglycerides - 78, 0)**3 - 3.5678174e-09 * max(Triglycerides - 157, 0)**3 + 
                                      1.0517074e-09 * max(Triglycerides - 346, 0)**3 +       
                                      0.035883239 * ((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 
                                      8.353176e-05 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 24.3, 0)**3 +         
                                      0.00013592896 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 31.2, 0)**3 - 
                                      5.2397195e-05 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 42.2, 0)**3 -
                                      0.0081333129 * HbA1c - 0.00047820135 * max(HbA1c - 5.8, 0)**3 + 0.00069416325 * max(HbA1c - 7.2, 0)**3 - 0.0002159619 * max(HbA1c - 10.3, 0)**3 -
                                      0.050685595 * (CAD == "Yes") - 
                                      0.57157166 * (CHF == "Yes") - 
                                      0.092138643 * (Smoking_Status == "Quit") - 
                                      0.18120576 * (Smoking_Status == "Yes") + 
                                      0.0012213694 * BPSystolic - 2.1935964e-06 * max(BPSystolic - 110, 0)**3 + 3.9171364e-06 * max(BPSystolic - 132, 0)**3 - 
                                      1.72354e-06 * max(BPSystolic - 160, 0)**3 + 
                                      0.01204621 * BPDiastolic - 5.3090258e-06 * max(BPDiastolic - 60, 0)**3 + 1.3272565e-05 * max(BPDiastolic - 78, 0)**3 - 
                                      7.9635387e-06 * max(BPDiastolic - 90, 0)**3 - 
                                      0.17493817 * (Insulin == "Yes") - 0.16364668 * (Plavix == "Yes") + 
                                      0.15769762 * (Aspirin == "Yes") + 0.23961832 * (Cholesterol_Med == "Yes") + 
                                      0.910847 * (New_Diabetes == "Yes") + 
                                      0.047367865 * (log(income)) + 0.25090184 * max((log(income)) - 10.176906, 0)**3 - 
                                      0.51558239 * max((log(income)) - 10.642086, 0)**3 + 
                                      0.26468055 * max((log(income)) - 11.08305, 0)**3 - 
                                      0.26485486 * (warfarin == "Yes")) +1)) - 0.1768427, 0)**3 + 
        11.368159 * max((exp(-4.0547687 - 
                                 0.019245713 * Age - 7.0378916e-06 * max(Age - 43, 0)**3 + 1.4853225e-05 * max(Age - 62.1, 0)**3 - 
                                 7.8153331e-06 * max(Age - 79.3, 0)**3 + 
                                 0.036085898 * (175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 
                                 6.150184e-06 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 45.728683, 0)**3 + 
                                 2.7314977e-05 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 76.543594, 0)**3 - 
                                 2.1164793e-05 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 85.497963, 0)**3 - 
                                 0.0022961162 * LDL + 9.6296232e-08 * max(LDL - 62, 0)**3 - 1.6941004e-07 * max(LDL - 103, 0)**3 + 7.3113806e-08 * max(LDL - 157, 0)**3 + 
                                 0.0092680468 * HDL - 7.0154394e-06 * max(HDL - 31, 0)**3 + 1.1575475e-05 * max(HDL - 44, 0)**3 - 4.5600356e-06 * max(HDL - 64, 0)**3 - 
                                 0.00043682684 * Triglycerides + 2.5161101e-09 * max(Triglycerides - 78, 0)**3 - 3.5678174e-09 * max(Triglycerides - 157, 0)**3 + 
                                 1.0517074e-09 * max(Triglycerides - 346, 0)**3 +       
                                 0.035883239 * ((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 
                                 8.353176e-05 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 24.3, 0)**3 +         
                                 0.00013592896 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 31.2, 0)**3 - 
                                 5.2397195e-05 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 42.2, 0)**3 -
                                 0.0081333129 * HbA1c - 0.00047820135 * max(HbA1c - 5.8, 0)**3 + 0.00069416325 * max(HbA1c - 7.2, 0)**3 - 0.0002159619 * max(HbA1c - 10.3, 0)**3 -
                                 0.050685595 * (CAD == "Yes") - 
                                 0.57157166 * (CHF == "Yes") - 
                                 0.092138643 * (Smoking_Status == "Quit") - 
                                 0.18120576 * (Smoking_Status == "Yes") + 
                                 0.0012213694 * BPSystolic - 2.1935964e-06 * max(BPSystolic - 110, 0)**3 + 3.9171364e-06 * max(BPSystolic - 132, 0)**3 - 
                                 1.72354e-06 * max(BPSystolic - 160, 0)**3 + 
                                 0.01204621 * BPDiastolic - 5.3090258e-06 * max(BPDiastolic - 60, 0)**3 + 1.3272565e-05 * max(BPDiastolic - 78, 0)**3 - 
                                 7.9635387e-06 * max(BPDiastolic - 90, 0)**3 - 
                                 0.17493817 * (Insulin == "Yes") - 0.16364668 * (Plavix == "Yes") + 
                                 0.15769762 * (Aspirin == "Yes") + 0.23961832 * (Cholesterol_Med == "Yes") + 
                                 0.910847 * (New_Diabetes == "Yes") + 
                                 0.047367865 * (log(income)) + 0.25090184 * max((log(income)) - 10.176906, 0)**3 - 
                                 0.51558239 * max((log(income)) - 10.642086, 0)**3 + 
                                 0.26468055 * max((log(income)) - 11.08305, 0)**3 - 
                                 0.26485486 * (warfarin == "Yes"))/
                             (exp(-4.0547687 - 
                                      0.019245713 * Age - 7.0378916e-06 * max(Age - 43, 0)**3 + 1.4853225e-05 * max(Age - 62.1, 0)**3 - 
                                      7.8153331e-06 * max(Age - 79.3, 0)**3 + 
                                      0.036085898 * (175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 
                                      6.150184e-06 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 45.728683, 0)**3 + 
                                      2.7314977e-05 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 76.543594, 0)**3 - 
                                      2.1164793e-05 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 85.497963, 0)**3 - 
                                      0.0022961162 * LDL + 9.6296232e-08 * max(LDL - 62, 0)**3 - 1.6941004e-07 * max(LDL - 103, 0)**3 + 7.3113806e-08 * max(LDL - 157, 0)**3 + 
                                      0.0092680468 * HDL - 7.0154394e-06 * max(HDL - 31, 0)**3 + 1.1575475e-05 * max(HDL - 44, 0)**3 - 4.5600356e-06 * max(HDL - 64, 0)**3 - 
                                      0.00043682684 * Triglycerides + 2.5161101e-09 * max(Triglycerides - 78, 0)**3 - 3.5678174e-09 * max(Triglycerides - 157, 0)**3 + 
                                      1.0517074e-09 * max(Triglycerides - 346, 0)**3 +       
                                      0.035883239 * ((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 
                                      8.353176e-05 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 24.3, 0)**3 +         
                                      0.00013592896 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 31.2, 0)**3 - 
                                      5.2397195e-05 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 42.2, 0)**3 -
                                      0.0081333129 * HbA1c - 0.00047820135 * max(HbA1c - 5.8, 0)**3 + 0.00069416325 * max(HbA1c - 7.2, 0)**3 - 0.0002159619 * max(HbA1c - 10.3, 0)**3 -
                                      0.050685595 * (CAD == "Yes") - 
                                      0.57157166 * (CHF == "Yes") - 
                                      0.092138643 * (Smoking_Status == "Quit") - 
                                      0.18120576 * (Smoking_Status == "Yes") + 
                                      0.0012213694 * BPSystolic - 2.1935964e-06 * max(BPSystolic - 110, 0)**3 + 3.9171364e-06 * max(BPSystolic - 132, 0)**3 - 
                                      1.72354e-06 * max(BPSystolic - 160, 0)**3 + 
                                      0.01204621 * BPDiastolic - 5.3090258e-06 * max(BPDiastolic - 60, 0)**3 + 1.3272565e-05 * max(BPDiastolic - 78, 0)**3 - 
                                      7.9635387e-06 * max(BPDiastolic - 90, 0)**3 - 
                                      0.17493817 * (Insulin == "Yes") - 0.16364668 * (Plavix == "Yes") + 
                                      0.15769762 * (Aspirin == "Yes") + 0.23961832 * (Cholesterol_Med == "Yes") + 
                                      0.910847 * (New_Diabetes == "Yes") + 
                                      0.047367865 * (log(income)) + 0.25090184 * max((log(income)) - 10.176906, 0)**3 - 
                                      0.51558239 * max((log(income)) - 10.642086, 0)**3 + 
                                      0.26468055 * max((log(income)) - 11.08305, 0)**3 - 
                                      0.26485486 * (warfarin == "Yes")) +1)) - 0.46010848, 0)**3 - 
        6.1557528 * max((exp(-4.0547687 - 
                                 0.019245713 * Age - 7.0378916e-06 * max(Age - 43, 0)**3 + 1.4853225e-05 * max(Age - 62.1, 0)**3 - 
                                 7.8153331e-06 * max(Age - 79.3, 0)**3 + 
                                 0.036085898 * (175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 
                                 6.150184e-06 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 45.728683, 0)**3 + 
                                 2.7314977e-05 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 76.543594, 0)**3 - 
                                 2.1164793e-05 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 85.497963, 0)**3 - 
                                 0.0022961162 * LDL + 9.6296232e-08 * max(LDL - 62, 0)**3 - 1.6941004e-07 * max(LDL - 103, 0)**3 + 7.3113806e-08 * max(LDL - 157, 0)**3 + 
                                 0.0092680468 * HDL - 7.0154394e-06 * max(HDL - 31, 0)**3 + 1.1575475e-05 * max(HDL - 44, 0)**3 - 4.5600356e-06 * max(HDL - 64, 0)**3 - 
                                 0.00043682684 * Triglycerides + 2.5161101e-09 * max(Triglycerides - 78, 0)**3 - 3.5678174e-09 * max(Triglycerides - 157, 0)**3 + 
                                 1.0517074e-09 * max(Triglycerides - 346, 0)**3 +       
                                 0.035883239 * ((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 
                                 8.353176e-05 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 24.3, 0)**3 +         
                                 0.00013592896 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 31.2, 0)**3 - 
                                 5.2397195e-05 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 42.2, 0)**3 -
                                 0.0081333129 * HbA1c - 0.00047820135 * max(HbA1c - 5.8, 0)**3 + 0.00069416325 * max(HbA1c - 7.2, 0)**3 - 0.0002159619 * max(HbA1c - 10.3, 0)**3 -
                                 0.050685595 * (CAD == "Yes") - 
                                 0.57157166 * (CHF == "Yes") - 
                                 0.092138643 * (Smoking_Status == "Quit") - 
                                 0.18120576 * (Smoking_Status == "Yes") + 
                                 0.0012213694 * BPSystolic - 2.1935964e-06 * max(BPSystolic - 110, 0)**3 + 3.9171364e-06 * max(BPSystolic - 132, 0)**3 - 
                                 1.72354e-06 * max(BPSystolic - 160, 0)**3 + 
                                 0.01204621 * BPDiastolic - 5.3090258e-06 * max(BPDiastolic - 60, 0)**3 + 1.3272565e-05 * max(BPDiastolic - 78, 0)**3 - 
                                 7.9635387e-06 * max(BPDiastolic - 90, 0)**3 - 
                                 0.17493817 * (Insulin == "Yes") - 0.16364668 * (Plavix == "Yes") + 
                                 0.15769762 * (Aspirin == "Yes") + 0.23961832 * (Cholesterol_Med == "Yes") + 
                                 0.910847 * (New_Diabetes == "Yes") + 
                                 0.047367865 * (log(income)) + 0.25090184 * max((log(income)) - 10.176906, 0)**3 - 
                                 0.51558239 * max((log(income)) - 10.642086, 0)**3 + 
                                 0.26468055 * max((log(income)) - 11.08305, 0)**3 - 
                                 0.26485486 * (warfarin == "Yes"))/
                             (exp(-4.0547687 - 
                                      0.019245713 * Age - 7.0378916e-06 * max(Age - 43, 0)**3 + 1.4853225e-05 * max(Age - 62.1, 0)**3 - 
                                      7.8153331e-06 * max(Age - 79.3, 0)**3 + 
                                      0.036085898 * (175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 
                                      6.150184e-06 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 45.728683, 0)**3 + 
                                      2.7314977e-05 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 76.543594, 0)**3 - 
                                      2.1164793e-05 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 85.497963, 0)**3 - 
                                      0.0022961162 * LDL + 9.6296232e-08 * max(LDL - 62, 0)**3 - 1.6941004e-07 * max(LDL - 103, 0)**3 + 7.3113806e-08 * max(LDL - 157, 0)**3 + 
                                      0.0092680468 * HDL - 7.0154394e-06 * max(HDL - 31, 0)**3 + 1.1575475e-05 * max(HDL - 44, 0)**3 - 4.5600356e-06 * max(HDL - 64, 0)**3 - 
                                      0.00043682684 * Triglycerides + 2.5161101e-09 * max(Triglycerides - 78, 0)**3 - 3.5678174e-09 * max(Triglycerides - 157, 0)**3 + 
                                      1.0517074e-09 * max(Triglycerides - 346, 0)**3 +       
                                      0.035883239 * ((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 
                                      8.353176e-05 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 24.3, 0)**3 +         
                                      0.00013592896 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 31.2, 0)**3 - 
                                      5.2397195e-05 * max(((Weight*0.45359237)/((Height*0.0254) ^ 2)) - 42.2, 0)**3 -
                                      0.0081333129 * HbA1c - 0.00047820135 * max(HbA1c - 5.8, 0)**3 + 0.00069416325 * max(HbA1c - 7.2, 0)**3 - 0.0002159619 * max(HbA1c - 10.3, 0)**3 -
                                      0.050685595 * (CAD == "Yes") - 
                                      0.57157166 * (CHF == "Yes") - 
                                      0.092138643 * (Smoking_Status == "Quit") - 
                                      0.18120576 * (Smoking_Status == "Yes") + 
                                      0.0012213694 * BPSystolic - 2.1935964e-06 * max(BPSystolic - 110, 0)**3 + 3.9171364e-06 * max(BPSystolic - 132, 0)**3 - 
                                      1.72354e-06 * max(BPSystolic - 160, 0)**3 + 
                                      0.01204621 * BPDiastolic - 5.3090258e-06 * max(BPDiastolic - 60, 0)**3 + 1.3272565e-05 * max(BPDiastolic - 78, 0)**3 - 
                                      7.9635387e-06 * max(BPDiastolic - 90, 0)**3 - 
                                      0.17493817 * (Insulin == "Yes") - 0.16364668 * (Plavix == "Yes") + 
                                      0.15769762 * (Aspirin == "Yes") + 0.23961832 * (Cholesterol_Med == "Yes") + 
                                      0.910847 * (New_Diabetes == "Yes") + 
                                      0.047367865 * (log(income)) + 0.25090184 * max((log(income)) - 10.176906, 0)**3 - 
                                      0.51558239 * max((log(income)) - 10.642086, 0)**3 + 
                                      0.26468055 * max((log(income)) - 11.08305, 0)**3 - 
                                      0.26485486 * (warfarin == "Yes")) +1)) - 0.69996481, 0)**3 + 
        (Med == "MEG") * (-0.020371887 * Age + 1.279871e-05 * max(Age - 43, 0)**3 - 2.7011231e-05 * max(Age - 62.1, 0)**3 + 1.4212521e-05 * max(Age - 79.3, 0)**3) + 
        (Med == "SFU") * (-0.016597229 * Age + 5.46926e-06 * max(Age - 43, 0)**3 - 1.1542683e-05 * max(Age - 62.1, 0)**3 + 6.0734225e-06 * max(Age - 79.3, 0)**3) + 
        (Med == "TZD") * (-0.038166466 * Age + 2.608548e-05 * max(Age - 43, 0)**3 - 5.5052496e-05 * max(Age - 62.1, 0)**3 + 2.8967016e-05 * max(Age - 79.3, 0)**3) + 
        (Med == "MEG") * (-0.0029696404 * (175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) + 
                   5.0561337e-06 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 45.728683, 0)**3 - 
                   2.2455942e-05 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 76.543594,     0)**3 + 
                   1.7399808e-05 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 85.497963, 0)**3) + 
        (Med == "SFU") * (-0.006232694 * (175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 
                   2.4041492e-06 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) -     45.728683, 0)**3 + 
                   1.0677612e-05 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 76.543594, 0)**3 - 
                   8.273463e-06 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 85.497963, 0)**3) + 
        (Med == "TZD") * (-0.0069317317 * (175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) + 
                   2.2774867e-06 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 45.728683,         0)**3 - 
                   1.0115062e-05 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 76.543594, 0)**3 + 
                   7.8375758e-06 * max((175*(Creatinine ^ -1.154)*(Age ^ -0.203)*(0.742 ^ (Gender=="Female"))*(1.21 ^ (Ethnicity=="Black"))) - 85.497963, 0)**3) + 
        (CHF == "Yes") * (0.18699169 * (Med == "MEG") - 
                             0.2701321 * (Med == "SFU") -  
                             0.76030801 * (Med == "TZD"))
    1 - 0.999024 ^ exp(lp)
})

library(shiny)
shinyServer(function(input, output){
    data <- eventReactive(input$goButton, {
        validate(need(!is.na(as.numeric(input$Age))& as.numeric(input$Age)>=40& as.numeric(input$Age)<=85, 'Please input a valid Age'))
        Age= as.numeric(input$Age)
        Gender = factor(input$Gender, levels = c('Female', 'Male'))
        Ethnicity = factor(input$Ethnicity, levels = c('White', 'Black', 'Other'))
        validate(need(!is.na(as.numeric(input$Creatinine))& as.numeric(input$Creatinine)>=0.1& as.numeric(input$Creatinine)<=4.5, 'Please input a valid Creatinine'))
        Creatinine= as.numeric(input$Creatinine)
        validate(need(!is.na(as.numeric(input$LDL))& as.numeric(input$LDL)>=60& as.numeric(input$LDL)<=500, 'Please input a valid LDL'))
        LDL= as.numeric(input$LDL)
        validate(need(!is.na(as.numeric(input$HDL))& as.numeric(input$HDL)>=20& as.numeric(input$HDL)<=100, 'Please input a valid HDL'))
        HDL= as.numeric(input$HDL)
        validate(need(!is.na(as.numeric(input$Triglycerides))& as.numeric(input$Triglycerides)>=50& as.numeric(input$Triglycerides)<=500, 'Please input a valid Triglycerides'))
        Triglycerides= as.numeric(input$Triglycerides)
        validate(need(!is.na(as.numeric(input$Weight))& as.numeric(input$Weight)>=75& as.numeric(input$Weight)<=500, 'Please input a valid Weight'))
        Weight = as.numeric(input$Weight)
        validate(need(!is.na(as.numeric(input$Height))& as.numeric(input$Height)>=50& as.numeric(input$Height)<=82, 'Please input a valid Height'))
        Height = as.numeric(input$Height)
        validate(need(!is.na(as.numeric(input$HbA1c))& as.numeric(input$HbA1c)>=4.5& as.numeric(input$HbA1c)<=13, 'Please input a valid HbA1c'))
        HbA1c = as.numeric(input$HbA1c)
        CHF = factor(input$CHF, levels = c('No', 'Yes'))
        Smoking_Status = factor(input$Smoking_Status, levels = c('No', 'Yes', 'Quit'))
        validate(need(!is.na(as.numeric(input$BPSystolic))& as.numeric(input$BPSystolic)>=60& as.numeric(input$BPSystolic)<=200, 'Please input a valid BPSystolic'))
        BPSystolic= as.numeric(input$BPSystolic)
        validate(need(!is.na(as.numeric(input$BPDiastolic))& as.numeric(input$BPDiastolic)>=40& as.numeric(input$BPDiastolic)<=140, 'Please input a valid BPDiastolic'))
        BPDiastolic= as.numeric(input$BPDiastolic)
        Insulin = factor(input$Insulin, levels = c('No', 'Yes'))
        Plavix = factor(input$Plavix, levels = c('No', 'Yes'))
        Aspirin = factor(input$Aspirin, levels = c('No', 'Yes'))
        Cholesterol_Med = factor(input$Cholesterol_Med, levels = c('No', 'Yes'))
        New_Diabetes = factor(input$New_Diabetes, levels = c('No', 'Yes'))
        validate(need(!is.na(as.numeric(input$income))& as.numeric(input$income)>=0& as.numeric(input$income)<=500000, 'Please input a valid household income'))
        income = as.numeric(input$income)
        CAD = factor(input$CAD, levels = c('No', 'Yes'))
        warfarin = factor(input$warfarin, levels = c('No', 'Yes'))
        ACEI_ARB = factor(input$ACEI_ARB, levels = c('No', 'Yes'))
        
        data <- data.frame(Age = Age,
                           Gender = Gender,
                           Ethnicity = Ethnicity,
                           Creatinine = Creatinine,
                           LDL = LDL,
                           HDL = HDL,
                           Triglycerides = Triglycerides,
                           Weight = Weight,
                           Height = Height,
                           HbA1c = HbA1c,
                           CHF = CHF,
                           Smoking_Status = Smoking_Status,
                           BPSystolic = BPSystolic,
                           BPDiastolic = BPDiastolic,
                           Insulin = Insulin,
                           Plavix = Plavix,
                           Aspirin = Aspirin,
                           Cholesterol_Med = Cholesterol_Med,
                           New_Diabetes = New_Diabetes,
                           income = income,
                           CAD = CAD,
                           warfarin = warfarin,
                           ACEI_ARB = ACEI_ARB,
                           Med = ""
        )
        data})
    
    output$result <- renderDataTable({
        data = data()
        BIG.data = data
        MEG.data = data
        SFU.data = data
        TZD.data = data
        BIG.data$Med = "BIG"
        MEG.data$Med = "MEG"
        SFU.data$Med = "SFU"
        TZD.data$Med = "TZD"

        res_order = function(res) {
            res_order = rep(0, length(res))
            res_num = as.numeric(str_extract(res, "\\d+\\.*\\d*"))
            res_order[res_num == max(res_num)] = 1
            res_order[res_num == min(res_num)] = -1
            res_order
        }
        
        predict.heart.disease.res <- sapply(list(BIG.data, MEG.data, SFU.data, TZD.data), 
                                            function(x) {
                                                i = round(eval(predict.heart.disease, x) * 100, 0)
                                                ifelse(i <= 1, "<= 1%", ifelse(i >= 99, ">= 99%", paste(i, "%")))
                                            })
        
        
        predict.heart.failure.res <- sapply(list(BIG.data, MEG.data, SFU.data, TZD.data), 
                                            function(x) {
                                                i = round(eval(predict.heart.failure, x) * 100, 0)
                                                ifelse(i <= 1, "<= 1%", ifelse(i >= 99, ">= 99%", paste(i, "%")))
                                            })
        
        predict.mortality.res <- sapply(list(BIG.data, MEG.data, SFU.data, TZD.data), 
                                            function(x) {
                                                i = round(eval(predict.mortality, x) * 100, 0)
                                                ifelse(i <= 1, "<= 1%", ifelse(i >= 99, ">= 99%", paste(i, "%")))
                                            })
        predict.mortality.order <- res_order(predict.mortality.res)
        
        predict.stroke.res <- sapply(list(BIG.data, MEG.data, SFU.data, TZD.data), 
                                            function(x) {
                                                i = round(eval(predict.stroke, x) * 100, 0)
                                                ifelse(i <= 1, "<= 1%", ifelse(i >= 99, ">= 99%", paste(i, "%")))
                                            })
        predict.stroke.order <- res_order(predict.stroke.res)
        
        # res = data.frame("Oral Hypoglycemic Agent" = c("Biguanides (BIGs)", "Meglitinides (MEGs)", "Sulfonylureas (SFUs)", "Thiazolidinediones (TZDs)"),
        #                  "Heart Disease Risk" = predict.heart.disease.res,
        #                  "Heart Failure Risk" = predict.heart.failure.res,
        #                  "Mortality Risk" = predict.mortality.res,
        #                  "Stroke Risk" = predict.stroke.res)
        # 
        # res_list = list(predict.heart.disease.res,
        #                 predict.heart.failure.res,
        #                 predict.mortality.res,
        #                 predict.stroke.res)
        # 
        # for (col in 2:5) {
        #     res[col] <- mapply(function(i,j){
        #         ifelse(i > 0, paste0("<span style='color:red'>",j,"</span>"),
        #                ifelse(i<0, paste0("<span style='color:green'>",j,"</span>"),
        #                       j))
        #     },res_order(res_list[[col-1]]),res_list[[col-1]])
        # }
        # 
        # colnames(res) <- c("Oral Hypoglycemic Agent", "5-year Heart Disease Risk", "5-year Heart Failure Risk", "5-year Mortality Risk", "5-year Stroke Risk")

        res = data.frame("Oral Hypoglycemic Agent" = c("Biguanides (BIGs)", "Meglitinides (MEGs)", "Sulfonylureas (SFUs)", "Thiazolidinediones (TZDs)"),
                         "Heart Disease Risk" = predict.heart.disease.res,
                         "Heart Failure Risk" = predict.heart.failure.res,
                         "Mortality Risk" = predict.mortality.res,
                         "Stroke Risk" = predict.stroke.res)
        res = rbind(c("5-year Heart Disease Risk", predict.heart.disease.res),
                    c("5-year Heart Failure Risk", predict.heart.failure.res),
                    c("5-year Mortality Risk", predict.mortality.res),
                    c("5-year Stroke Risk", predict.stroke.res))
        
        res_list = list(predict.heart.disease.res,
                        predict.heart.failure.res,
                        predict.mortality.res,
                        predict.stroke.res)
        
        for (col in 1:4) {
            res[col, 2:5] <- mapply(function(i,j){
                ifelse(i > 0, paste0("<span style='color:red'><b>",j,"</b></span>"),
                       ifelse(i<0, paste0("<span style='color:green'><b>",j,"</b></span>"),
                              j))
            },res_order(res_list[[col]]),res_list[[col]])
        }
        
        colnames(res) = c("Outcome", "Biguanides (BIGs)", "Meglitinides (MEGs)", "Sulfonylureas (SFUs)", "Thiazolidinediones (TZDs)")
        
        res
    }, options = list(
        pageLength = 10,
        lengthMenu = 0,
        processing = 0, 
        
        searching = 0,
        info = 0,
        paging = 0,
        initComplete = I(
            "function(settings, json) {
                    $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
            }")),escape = F)
})
