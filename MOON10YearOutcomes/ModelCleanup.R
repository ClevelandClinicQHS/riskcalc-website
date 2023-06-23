#2018-04-26 MOON 10-yr outcomes
#Cleaning up data and rerunning models so they are better formatted for shiny application
#Loaded '/home/chagink/Projects/2016/MOON_10yr_outcomes/r/10_yr_pred_outcomes_20161208.RData' to extract objects
library(plyr);library(dplyr);library(sqldf);library(reshape2);library(rms)

load(file = '/home/chagink/Projects/2016/MOON_10yr_outcomes/r/10_yr_pred_outcomes_20161208.RData')

#####IKDC Models
IKDC_dat <- dat2
sort(unique(c(attr(ikdc.10.fit.step$terms, "term.labels"),attr(ikdc.10.fit.at2$terms, "term.labels"),attr(ikdc.10.fit.at6$terms, "term.labels"))))

#Only selecting columns needed
IKDC_dat <- select(IKDC_dat,
                   ACLateralPathology = ac.lat.imp.t0.2,
                   ReconstructionType = acl.pr.t0,
                   ACMedialPathology = ac.med.imp.t0.2,
                   ACPatellofemoralPathology = ac.pf.imp.t0,
                   BMI0 = bmi.t0,
                   BMI2 = bmi.t2,
                   BMI6 = bmi.t6,
                   IKDC0 = ikdc.t0,
                   IKDC2 = ikdc.t2,
                   IKDC6 = ikdc.t6,
                   IKDC10 = ikdc.imp.t10,
                   MARX0 = marx.t0,
                   MARX2 = marx.t2,
                   MARX6 = marx.t6,
                   PreviousMedialMeniscusSurgery = mpre.su1.imp.t0,
                   Education = school.yrs.imp.t0,
                   Gender = sex.t0,
                   SmokingStatus0 = smoke.imp.t0.2,
                   SmokingStatus2 = smoke.imp.t2.2,
                   SmokingStatus6 = smoke.imp.t6.2,
                   Sport = sport1.ik.imp.t0.2,
                   SubsequentSurgeryContralateral = sub.surgery.cl.imp,
                   SubsequentSurgeryIpsilateral = sub.surgery.il.imp)
#Releveling
IKDC_dat <- mutate(IKDC_dat,
                   ACLateralPathology = relevel(factor(ifelse(ACLateralPathology == 'normal/grade 1', 'Normal',
                                                              ifelse(ACLateralPathology == 'grade 2', 'Grade 2', 'Grade 3/4'))), ref = 'Normal'),
                   ReconstructionType = relevel(factor(ifelse(ReconstructionType == 'primary', 'Primary', 'Revision')), ref = 'Primary'),
                   ACMedialPathology = relevel(factor(ifelse(ACMedialPathology == 'normal/grade 1', 'Normal',
                                                             ifelse(ACMedialPathology == 'grade 2', 'Grade 2', 'Grade 3/4'))), ref = 'Normal'),
                   ACPatellofemoralPathology = relevel(factor(ifelse(ACPatellofemoralPathology == 'normal/grade 1', 'Normal',
                                                                     ifelse(ACPatellofemoralPathology == 'grade 2', 'Grade 2', 'Grade 3/4'))), ref = 'Normal'),
                   PreviousMedialMeniscusSurgery = relevel(PreviousMedialMeniscusSurgery, ref = 'No'),
                   Gender = relevel(factor(ifelse(Gender == 'female', 'Female', 'Male')), ref = 'Female'),
                   SmokingStatus0 = relevel(factor(ifelse(SmokingStatus0 == 'never', 'Never', 
                                                          ifelse(SmokingStatus0 == 'quit', 'Quit', 'Current'))), ref = 'Never'),
                   SmokingStatus2 = relevel(factor(ifelse(SmokingStatus2 == 'never', 'Never', 
                                                          ifelse(SmokingStatus2 == 'quit', 'Quit', 'Current'))), ref = 'Never'),
                   SmokingStatus6 = relevel(factor(ifelse(SmokingStatus6 == 'never', 'Never', 
                                                          ifelse(SmokingStatus6 == 'quit', 'Quit', 'Current'))), ref = 'Never'),
                   Sport = relevel(factor(ifelse(Sport == 'none', 'None',
                                                 ifelse(Sport == 'baseball / softball', 'Baseball/Softball',
                                                        ifelse(Sport == 'basketball', 'Basketball',
                                                               ifelse(Sport == 'football', 'Football',
                                                                      ifelse(Sport == 'soccer', 'Soccer', 'Other')))))), ref = 'None'),
                   SubsequentSurgeryContralateral = relevel(factor(ifelse(SubsequentSurgeryContralateral == 'none', 'None',
                                                                          ifelse(SubsequentSurgeryContralateral == 'CL-ACLR', 'ACL reconstruction', 'Scope'))), ref = 'None'),
                   SubsequentSurgeryIpsilateral = relevel(factor(ifelse(SubsequentSurgeryIpsilateral == 'none', 'None',
                                                                        ifelse(SubsequentSurgeryIpsilateral == 'IL-RACLR', 'Revision ACL reconstruction', 'Scope'))), ref = 'None'))
#Running models
form1 <- formula(paste0('IKDC10~', paste(names(select(IKDC_dat, -BMI2, -BMI6, -IKDC2, -IKDC6, -IKDC10, -MARX2, -MARX6, -SmokingStatus2, -SmokingStatus6, -SubsequentSurgeryContralateral, -SubsequentSurgeryIpsilateral)), collapse = '+')))
ikdc_baseline <- orm(form1,
                     data = IKDC_dat,
                     x = T, y = T)

form2 <- formula(paste0('IKDC10~', paste(names(select(IKDC_dat, -BMI0, -BMI6, -IKDC0, -IKDC6, -IKDC10, -MARX0, -MARX6, -SmokingStatus0, -SmokingStatus6)), collapse = '+')))
ikdc_2Year <- orm(form2,
                  data = IKDC_dat,
                  x = T, y = T)

form6 <- formula(paste0('IKDC10~', paste(names(select(IKDC_dat, -BMI0, -BMI2, -IKDC0, -IKDC2, -IKDC10, -MARX0, -MARX2, -SmokingStatus0, -SmokingStatus2)), collapse = '+')))
ikdc_6Year <- orm(form6,
                  data = IKDC_dat,
                  x = T, y = T)

#Storing in a list
IKDC <- list('Baseline' = ikdc_baseline,
             'Year2' = ikdc_2Year,
             'Year6' = ikdc_6Year)


#################MARX Models
MARX_dat <- dat2
paste(sort(unique(c(attr(marx.10.fit$terms, "term.labels"),attr(marx.10.fit.at2$terms, "term.labels"),attr(marx.10.fit.at6$terms, "term.labels")))),collapse = ',')

#Only selecting columns needed
MARX_dat <- select(MARX_dat,
                   GraftType = acl.gtype.imp.t0,
                   TibialFixation = acl.tibfix.imp.t0,
                   Age = age.t0,
                   BMI0 = bmi.t0,
                   BMI2 = bmi.t2,
                   BMI6 = bmi.t6,
                   HighGradeLaxity = laxity.imp.t0,
                   CompetitionLevel = level1.ik.imp.t0.2,
                   MARX0 = marx.t0,
                   MARX2 = marx.t2,
                   MARX6 = marx.t6,
                   MARX10 = marx.t10,
                   PreviousMedialMeniscusSurgery = mpre.su1.imp.t0,
                   Education = school.yrs.imp.t0,
                   Gender = sex.t0,
                   SubsequentSurgeryContralateral = sub.surgery.cl.imp.2,
                   SubsequentSurgeryIpsilateral = sub.surgery.il.imp.2)

#Releveling
MARX_dat <- mutate(MARX_dat,
                   GraftType = relevel(factor(ifelse(GraftType == 'allo-btb', 'Allograft BTB',
                                                     ifelse(GraftType == 'allo-soft tissue', 'Allograft soft tissue',
                                                            ifelse(GraftType == 'auto-btb', 'Autograft BTB', 'Autograft soft tissue')))), ref = 'Allograft BTB'),
                   TibialFixation = relevel(factor(ifelse(TibialFixation == 'interference screw (bio)', 'Interference screw (Bio)',
                                                          ifelse(TibialFixation == 'interference screw (metal)', 'Interference screw (Metal)',
                                                                 ifelse(TibialFixation == 'other', 'Other', 'Suture')))), ref = 'Interference screw (Bio)'),
                   HighGradeLaxity = relevel(HighGradeLaxity, ref = 'No'),
                   CompetitionLevel = relevel(factor(ifelse(CompetitionLevel == 'none', 'None', 
                                                            ifelse(CompetitionLevel == 'amateur/semi-pro/pro', 'Amateur/Semi-pro/Pro',
                                                                   ifelse(CompetitionLevel == 'college', 'College',
                                                                          ifelse(CompetitionLevel == 'high school', 'High school', 'Recreational'))))), ref = 'None'),
                   PreviousMedialMeniscusSurgery = relevel(PreviousMedialMeniscusSurgery, ref = 'No'),
                   Gender = relevel(factor(ifelse(Gender == 'female', 'Female', 'Male')), ref = 'Female'),
                   SubsequentSurgeryContralateral = relevel(factor(ifelse(SubsequentSurgeryContralateral == 'none', 'None',
                                                                          ifelse(SubsequentSurgeryContralateral == 'CL-RACLR/TKA', 'Revision ACL reconstruction/TKA', 'Scope'))), ref = 'Revision ACL reconstruction/TKA'),
                   SubsequentSurgeryIpsilateral = relevel(factor(ifelse(SubsequentSurgeryIpsilateral == 'none', 'None',
                                                                        ifelse(SubsequentSurgeryIpsilateral == 'IL-RACLR/TKA', 'Revision ACL reconstruction/TKA', 'Scope'))), ref = 'Revision ACL reconstruction/TKA'))


#Running models
form1 <- formula(paste0('MARX10~', paste(names(select(MARX_dat, -BMI2, -BMI6, -MARX2, -MARX6, -MARX10, -SubsequentSurgeryContralateral, -SubsequentSurgeryIpsilateral)), collapse = '+')))
marx_baseline <- orm(form1,
                     data = MARX_dat,
                     x = T, y = T)

form2 <- formula(paste0('MARX10~', paste(names(select(MARX_dat, -BMI0, -BMI6, -MARX0, -MARX6, -MARX10)), collapse = '+')))
marx_2Year <- orm(form2,
                  data = MARX_dat,
                  x = T, y = T)

form6 <- formula(paste0('MARX10~', paste(names(select(MARX_dat, -BMI0, -BMI2, -MARX0, -MARX2, -MARX10)), collapse = '+')))
marx_6Year <- orm(form6,
                  data = MARX_dat,
                  x = T, y = T)

#Storing in a list
MARX <- list('Baseline' = marx_baseline,
             'Year2' = marx_2Year,
             'Year6' = marx_6Year)


#############################KOOS Models######################################
##ADL
ADL_dat <- dat2
sort(unique(c(attr(koos.adl.10.fit$terms, "term.labels"),attr(koos.adl.10.fit.at2$terms, "term.labels"),attr(koos.adl.10.fit.at6$terms, "term.labels"))))

#Only selecting columns needed
ADL_dat <- select(ADL_dat,
                   GraftType = acl.gtype.imp.t0,
                   TibialFixation = acl.tibfix.imp.t0,
                   Age = age.t0,
                   BMI0 = bmi.t0,
                   BMI2 = bmi.t2,
                   BMI6 = bmi.t6,
                   ADL0 = koos.adl.t0,
                   ADL2 = koos.adl.t2,
                   ADL6 = koos.adl.t6,
                   ADL10 = koos.adl.t10,
                   MARX0 = marx.t0,
                   MARX2 = marx.t2,
                   MARX6 = marx.t6,
                   CompetitionLevel = level1.ik.imp.t0.2,
                   PreviousMedialMeniscusSurgery = mpre.su1.imp.t0,
                   PreviousACLRContralateralKnee = prev.aclr.contra.imp.t0,
                   Education = school.yrs.imp.t0,
                   Gender = sex.t0,
                   Sport = sport1.ik.imp.t0.2,
                   SubsequentSurgeryContralateral = sub.surgery.cl.imp,
                   SubsequentSurgeryIpsilateral = sub.surgery.il.imp)
#Releveling
ADL_dat <- mutate(ADL_dat,
                   GraftType = relevel(factor(ifelse(GraftType == 'allo-btb', 'Allograft BTB',
                                                     ifelse(GraftType == 'allo-soft tissue', 'Allograft soft tissue',
                                                            ifelse(GraftType == 'auto-btb', 'Autograft BTB', 'Autograft soft tissue')))), ref = 'Allograft BTB'),
                   TibialFixation = relevel(factor(ifelse(TibialFixation == 'interference screw (bio)', 'Interference screw (Bio)',
                                                          ifelse(TibialFixation == 'interference screw (metal)', 'Interference screw (Metal)',
                                                                 ifelse(TibialFixation == 'other', 'Other', 'Suture')))), ref = 'Interference screw (Bio)'),
                   CompetitionLevel = relevel(factor(ifelse(CompetitionLevel == 'none', 'None', 
                                                            ifelse(CompetitionLevel == 'amateur/semi-pro/pro', 'Amateur/Semi-pro/Pro',
                                                                   ifelse(CompetitionLevel == 'college', 'College',
                                                                          ifelse(CompetitionLevel == 'high school', 'High school', 'Recreational'))))), ref = 'None'),
                   PreviousMedialMeniscusSurgery = relevel(PreviousMedialMeniscusSurgery, ref = 'No'),
                   PreviousACLRContralateralKnee = relevel(PreviousACLRContralateralKnee, ref = 'No'),
                   Gender = relevel(factor(ifelse(Gender == 'female', 'Female', 'Male')), ref = 'Female'),
                   Sport = relevel(factor(ifelse(Sport == 'none', 'None',
                                                 ifelse(Sport == 'baseball / softball', 'Baseball/Softball',
                                                        ifelse(Sport == 'basketball', 'Basketball',
                                                               ifelse(Sport == 'football', 'Football',
                                                                      ifelse(Sport == 'soccer', 'Soccer', 'Other')))))), ref = 'None'),
                   SubsequentSurgeryContralateral = relevel(factor(ifelse(SubsequentSurgeryContralateral == 'none', 'None',
                                                                          ifelse(SubsequentSurgeryContralateral == 'CL-ACLR', 'ACL reconstruction', 'Scope'))), ref = 'None'),
                   SubsequentSurgeryIpsilateral = relevel(factor(ifelse(SubsequentSurgeryIpsilateral == 'none', 'None',
                                                                        ifelse(SubsequentSurgeryIpsilateral == 'IL-RACLR', 'Revision ACL reconstruction', 'Scope'))), ref = 'None'))
#Running models
form1 <- formula(paste0('ADL10~', paste(names(select(ADL_dat, -BMI2, -BMI6, -ADL2, -ADL6, -ADL10, -MARX2, -MARX6, -SubsequentSurgeryContralateral, -SubsequentSurgeryIpsilateral)), collapse = '+')))
adl_baseline <- orm(form1,
                    data = ADL_dat,
                    x = T, y = T)

form2 <- formula(paste0('ADL10~', paste(names(select(ADL_dat, -BMI0, -BMI6, -ADL0, -ADL6, -ADL10, -MARX0, -MARX6)), collapse = '+')))
adl_2Year <- orm(form2,
                    data = ADL_dat,
                    x = T, y = T)

form6 <- formula(paste0('ADL10~', paste(names(select(ADL_dat, -BMI0, -BMI2, -ADL0, -ADL2, -ADL10, -MARX0, -MARX2)), collapse = '+')))
adl_6Year <- orm(form6,
                 data = ADL_dat,
                 x = T, y = T)

#Storing in a list
ADL <- list('Baseline' = adl_baseline,
            'Year2' = adl_2Year,
            'Year6' = adl_6Year)

##KRQOL
QOL_dat <- dat2
sort(unique(c(attr(koos.qol.10.fit$terms, "term.labels"),attr(koos.qol.10.fit.at2$terms, "term.labels"),attr(koos.qol.10.fit.at6$terms, "term.labels"))))

#Only selecting columns needed
QOL_dat <- select(QOL_dat,
                  ACLateralFracturePathology = ac.fx.lat.imp.t0,
                  SurgicalExposure = acl.exp.imp.t0,
                  GraftType = acl.gtype.imp.t0,
                  ReconstructionType = acl.pr.t0,
                  ACMedialPathology = ac.med.imp.t0.2,
                  ACPatellofemoralPathology = ac.pf.imp.t0,
                  Age = age.t0,
                  BMI0 = bmi.t0,
                  BMI2 = bmi.t2,
                  BMI6 = bmi.t6,
                  QOL0 = koos.krqol.t0,
                  QOL2 = koos.krqol.t2,
                  QOL6 = koos.krqol.t6,
                  QOL10 = koos.krqol.t10,
                  MARX0 = marx.t0,
                  MARX2 = marx.t2,
                  MARX6 = marx.t6,
                  PreviousMedialMeniscusSurgery = mpre.su1.imp.t0,
                  PreviousILKneeSurgery = lpre.su1.imp.t0,
                  LateralMeniscalPathology = ltreat.imp.t0.2,
                  SmokingStatus0 = smoke.imp.t0.2,
                  SmokingStatus2 = smoke.imp.t2.2,
                  SmokingStatus6 = smoke.imp.t6.2,
                  Sport = sport1.ik.imp.t0.2,
                  SubsequentSurgeryContralateral = sub.surgery.cl.imp.2,
                  SubsequentSurgeryIpsilateral = sub.surgery.il.imp.2)
#Releveling
QOL_dat <- mutate(QOL_dat,
                  ACLateralFracturePathology = relevel(ACLateralFracturePathology, ref = 'No'),
                  SurgicalExposure = relevel(factor(ifelse(SurgicalExposure == '1 incision', '1 incision', '2 incisions')), ref = '1 incision'),
                  GraftType = relevel(factor(ifelse(GraftType == 'allo-btb', 'Allograft BTB',
                                                    ifelse(GraftType == 'allo-soft tissue', 'Allograft soft tissue',
                                                           ifelse(GraftType == 'auto-btb', 'Autograft BTB', 'Autograft soft tissue')))), ref = 'Allograft BTB'),
                  ReconstructionType = relevel(factor(ifelse(ReconstructionType == 'primary', 'Primary', 'Revision')), ref = 'Primary'),
                  ACMedialPathology = relevel(factor(ifelse(ACMedialPathology == 'normal/grade 1', 'Normal',
                                                            ifelse(ACMedialPathology == 'grade 2', 'Grade 2', 'Grade 3/4'))), ref = 'Normal'),
                  ACPatellofemoralPathology = relevel(factor(ifelse(ACPatellofemoralPathology == 'normal/grade 1', 'Normal',
                                                                    ifelse(ACPatellofemoralPathology == 'grade 2', 'Grade 2', 'Grade 3/4'))), ref = 'Normal'),
                  PreviousMedialMeniscusSurgery = relevel(PreviousMedialMeniscusSurgery, ref = 'No'),
                  PreviousILKneeSurgery = relevel(PreviousILKneeSurgery, ref = 'No'),
                  LateralMeniscalPathology = relevel(factor(ifelse(LateralMeniscalPathology == 'no tear/no treat for tear', 'No tear/No treatment for tear',
                                                                   ifelse(LateralMeniscalPathology == 'excision', 'Excision', 'Repair/Other'))), ref = 'No tear/No treatment for tear'),
                  SmokingStatus0 = relevel(factor(ifelse(SmokingStatus0 == 'never', 'Never', 
                                                         ifelse(SmokingStatus0 == 'quit', 'Quit', 'Current'))), ref = 'Never'),
                  SmokingStatus2 = relevel(factor(ifelse(SmokingStatus2 == 'never', 'Never', 
                                                         ifelse(SmokingStatus2 == 'quit', 'Quit', 'Current'))), ref = 'Never'),
                  SmokingStatus6 = relevel(factor(ifelse(SmokingStatus6 == 'never', 'Never', 
                                                         ifelse(SmokingStatus6 == 'quit', 'Quit', 'Current'))), ref = 'Never'),
                  Sport = relevel(factor(ifelse(Sport == 'none', 'None',
                                                ifelse(Sport == 'baseball / softball', 'Baseball/Softball',
                                                       ifelse(Sport == 'basketball', 'Basketball',
                                                              ifelse(Sport == 'football', 'Football',
                                                                     ifelse(Sport == 'soccer', 'Soccer', 'Other')))))), ref = 'None'),
                  SubsequentSurgeryContralateral = relevel(factor(ifelse(SubsequentSurgeryContralateral == 'none', 'None',
                                                                         ifelse(SubsequentSurgeryContralateral == 'CL-RACLR/TKA', 'Revision ACL reconstruction/TKA', 'Scope'))), ref = 'Revision ACL reconstruction/TKA'),
                  SubsequentSurgeryIpsilateral = relevel(factor(ifelse(SubsequentSurgeryIpsilateral == 'none', 'None',
                                                                       ifelse(SubsequentSurgeryIpsilateral == 'IL-RACLR/TKA', 'Revision ACL reconstruction/TKA', 'Scope'))), ref = 'Revision ACL reconstruction/TKA'))
#Running models
form1 <- formula(paste0('QOL10~', paste(names(select(QOL_dat, -BMI2, -BMI6, -QOL2, -QOL6, -QOL10, -MARX2, -MARX6, -SmokingStatus2, -SmokingStatus6, -SubsequentSurgeryContralateral, -SubsequentSurgeryIpsilateral)), collapse = '+')))
qol_baseline <- orm(form1,
                    data = QOL_dat,
                    x = T, y = T)

form2 <- formula(paste0('QOL10~', paste(names(select(QOL_dat, -BMI0, -BMI6, -QOL0, -QOL6, -QOL10, -MARX0, -MARX6, -SmokingStatus0, -SmokingStatus6)), collapse = '+')))
qol_2Year <- orm(form2,
                 data = QOL_dat,
                 x = T, y = T)

form6 <- formula(paste0('QOL10~', paste(names(select(QOL_dat, -BMI0, -BMI2, -QOL0, -QOL2, -QOL10, -MARX0, -MARX2, -SmokingStatus0, -SmokingStatus2)), collapse = '+')))
qol_6Year <- orm(form6,
                 data = QOL_dat,
                 x = T, y = T)

#Storing in a list
QOL <- list('Baseline' = qol_baseline,
            'Year2' = qol_2Year,
            'Year6' = qol_6Year)

##Pain
pain_dat <- dat2
sort(unique(c(attr(koos.pain.10.fit$terms, "term.labels"),attr(koos.pain.10.fit.at2$terms, "term.labels"),attr(koos.pain.10.fit.at6$terms, "term.labels"))))

#Only selecting columns needed (Kevin used baseline pain at all time points, will switch to correct timepoint so coefficients won't match)
pain_dat <- select(pain_dat,
                  ACLateralPathology = ac.lat.imp.t0.2,
                  GraftType = acl.gtype.imp.t0,
                  ReconstructionType = acl.pr.t0,
                  ACMedialPathology = ac.med.imp.t0.2,
                  ACPatellofemoralPathology = ac.pf.imp.t0,
                  Age = age.t0,
                  BMI0 = bmi.t0,
                  BMI2 = bmi.t2,
                  BMI6 = bmi.t6,
                  Pain0 = koos.pain.t0,
                  Pain2 = koos.pain.t2,
                  Pain6 = koos.pain.t6,
                  Pain10 = koos.pain.t10,
                  PreviousMedialMeniscusSurgery = mpre.su1.imp.t0,
                  SmokingStatus0 = smoke.imp.t0.2,
                  SmokingStatus2 = smoke.imp.t2.2,
                  SmokingStatus6 = smoke.imp.t6.2,
                  Sport = sport1.ik.imp.t0.2,
                  SubsequentSurgeryContralateral = sub.surgery.cl.imp,
                  SubsequentSurgeryIpsilateral = sub.surgery.il.imp)
#Releveling
pain_dat <- mutate(pain_dat,
                   ACLateralPathology = relevel(factor(ifelse(ACLateralPathology == 'normal/grade 1', 'Normal',
                                                              ifelse(ACLateralPathology == 'grade 2', 'Grade 2', 'Grade 3/4'))), ref = 'Normal'),
                   GraftType = relevel(factor(ifelse(GraftType == 'allo-btb', 'Allograft BTB',
                                                     ifelse(GraftType == 'allo-soft tissue', 'Allograft soft tissue',
                                                            ifelse(GraftType == 'auto-btb', 'Autograft BTB', 'Autograft soft tissue')))), ref = 'Allograft BTB'),
                   ReconstructionType = relevel(factor(ifelse(ReconstructionType == 'primary', 'Primary', 'Revision')), ref = 'Primary'),
                   ACMedialPathology = relevel(factor(ifelse(ACMedialPathology == 'normal/grade 1', 'Normal',
                                                             ifelse(ACMedialPathology == 'grade 2', 'Grade 2', 'Grade 3/4'))), ref = 'Normal'),
                   ACPatellofemoralPathology = relevel(factor(ifelse(ACPatellofemoralPathology == 'normal/grade 1', 'Normal',
                                                                     ifelse(ACPatellofemoralPathology == 'grade 2', 'Grade 2', 'Grade 3/4'))), ref = 'Normal'),
                   PreviousMedialMeniscusSurgery = relevel(PreviousMedialMeniscusSurgery, ref = 'No'),
                   SmokingStatus0 = relevel(factor(ifelse(SmokingStatus0 == 'never', 'Never', 
                                                          ifelse(SmokingStatus0 == 'quit', 'Quit', 'Current'))), ref = 'Never'),
                   SmokingStatus2 = relevel(factor(ifelse(SmokingStatus2 == 'never', 'Never', 
                                                          ifelse(SmokingStatus2 == 'quit', 'Quit', 'Current'))), ref = 'Never'),
                   SmokingStatus6 = relevel(factor(ifelse(SmokingStatus6 == 'never', 'Never', 
                                                          ifelse(SmokingStatus6 == 'quit', 'Quit', 'Current'))), ref = 'Never'),
                   Sport = relevel(factor(ifelse(Sport == 'none', 'None',
                                                 ifelse(Sport == 'baseball / softball', 'Baseball/Softball',
                                                        ifelse(Sport == 'basketball', 'Basketball',
                                                               ifelse(Sport == 'football', 'Football',
                                                                      ifelse(Sport == 'soccer', 'Soccer', 'Other')))))), ref = 'None'),
                   SubsequentSurgeryContralateral = relevel(factor(ifelse(SubsequentSurgeryContralateral == 'none', 'None',
                                                                          ifelse(SubsequentSurgeryContralateral == 'CL-ACLR', 'ACL reconstruction', 'Scope'))), ref = 'None'),
                   SubsequentSurgeryIpsilateral = relevel(factor(ifelse(SubsequentSurgeryIpsilateral == 'none', 'None',
                                                                        ifelse(SubsequentSurgeryIpsilateral == 'IL-RACLR', 'Revision ACL reconstruction', 'Scope'))), ref = 'None'))
#Modeling
form1 <- formula(paste0('Pain10~', paste(names(select(pain_dat, -BMI2, -BMI6, -Pain2, -Pain6, -Pain10, -SmokingStatus2, -SmokingStatus6, -SubsequentSurgeryContralateral, -SubsequentSurgeryIpsilateral)), collapse = '+')))
pain_baseline <- orm(form1,
                    data = pain_dat,
                    x = T, y = T)

form2 <- formula(paste0('Pain10~', paste(names(select(pain_dat, -BMI0, -BMI6, -Pain0, -Pain6, -Pain10, -SmokingStatus0, -SmokingStatus6)), collapse = '+')))
pain_2Year <- orm(form2,
                     data = pain_dat,
                     x = T, y = T)

form6 <- formula(paste0('Pain10~', paste(names(select(pain_dat, -BMI0, -BMI2, -Pain0, -Pain2, -Pain10, -SmokingStatus0, -SmokingStatus2)), collapse = '+')))
pain_6Year <- orm(form6,
                  data = pain_dat,
                  x = T, y = T)

#Storing in a list
Pain <- list('Baseline' = pain_baseline,
            'Year2' = pain_2Year,
            'Year6' = pain_6Year)


##Sports & recreation
SAR_dat <- dat2
sort(unique(c(attr(koos.sport.10.fit$terms, "term.labels"),attr(koos.sport.10.fit.at2$terms, "term.labels"),attr(koos.sport.10.fit.at6$terms, "term.labels"))))

#Only selecting columns needed (Kevin used baseline pain at all time points, will switch to correct timepoint so coefficients won't match)
SAR_dat <- select(SAR_dat,
                   ACLateralPathology = ac.lat.imp.t0.2,
                   ReconstructionType = acl.pr.t0,
                   ACMedialPathology = ac.med.imp.t0.2,
                   ACPatellofemoralPathology = ac.pf.imp.t0,
                   Age = age.t0,
                   BMI0 = bmi.t0,
                   BMI2 = bmi.t2,
                   BMI6 = bmi.t6,
                   SAR0 = koos.sports.rec.t0,
                   SAR2 = koos.sports.rec.t2,
                   SAR6 = koos.sports.rec.t6,
                   SAR10 = koos.sports.rec.t10,
                   PreviousMedialMeniscusSurgery = mpre.su1.imp.t0,
                   Gender = sex.t0,
                   SmokingStatus0 = smoke.imp.t0.2,
                   SmokingStatus2 = smoke.imp.t2.2,
                   SmokingStatus6 = smoke.imp.t6.2,
                   Sport = sport1.ik.imp.t0.2,
                   SubsequentSurgeryContralateral = sub.surgery.cl.imp,
                   SubsequentSurgeryIpsilateral = sub.surgery.il.imp)
#Releveling
SAR_dat <- mutate(SAR_dat,
                   ACLateralPathology = relevel(factor(ifelse(ACLateralPathology == 'normal/grade 1', 'Normal',
                                                              ifelse(ACLateralPathology == 'grade 2', 'Grade 2', 'Grade 3/4'))), ref = 'Normal'),
                   ReconstructionType = relevel(factor(ifelse(ReconstructionType == 'primary', 'Primary', 'Revision')), ref = 'Primary'),
                   ACMedialPathology = relevel(factor(ifelse(ACMedialPathology == 'normal/grade 1', 'Normal',
                                                             ifelse(ACMedialPathology == 'grade 2', 'Grade 2', 'Grade 3/4'))), ref = 'Normal'),
                   ACPatellofemoralPathology = relevel(factor(ifelse(ACPatellofemoralPathology == 'normal/grade 1', 'Normal',
                                                                     ifelse(ACPatellofemoralPathology == 'grade 2', 'Grade 2', 'Grade 3/4'))), ref = 'Normal'),
                   PreviousMedialMeniscusSurgery = relevel(PreviousMedialMeniscusSurgery, ref = 'No'),
                   Gender = relevel(factor(ifelse(Gender == 'female', 'Female', 'Male')), ref = 'Female'),
                   SmokingStatus0 = relevel(factor(ifelse(SmokingStatus0 == 'never', 'Never', 
                                                          ifelse(SmokingStatus0 == 'quit', 'Quit', 'Current'))), ref = 'Never'),
                   SmokingStatus2 = relevel(factor(ifelse(SmokingStatus2 == 'never', 'Never', 
                                                          ifelse(SmokingStatus2 == 'quit', 'Quit', 'Current'))), ref = 'Never'),
                   SmokingStatus6 = relevel(factor(ifelse(SmokingStatus6 == 'never', 'Never', 
                                                          ifelse(SmokingStatus6 == 'quit', 'Quit', 'Current'))), ref = 'Never'),
                   Sport = relevel(factor(ifelse(Sport == 'none', 'None',
                                                 ifelse(Sport == 'baseball / softball', 'Baseball/Softball',
                                                        ifelse(Sport == 'basketball', 'Basketball',
                                                               ifelse(Sport == 'football', 'Football',
                                                                      ifelse(Sport == 'soccer', 'Soccer', 'Other')))))), ref = 'None'),
                   SubsequentSurgeryContralateral = relevel(factor(ifelse(SubsequentSurgeryContralateral == 'none', 'None',
                                                                          ifelse(SubsequentSurgeryContralateral == 'CL-ACLR', 'ACL reconstruction', 'Scope'))), ref = 'None'),
                   SubsequentSurgeryIpsilateral = relevel(factor(ifelse(SubsequentSurgeryIpsilateral == 'none', 'None',
                                                                        ifelse(SubsequentSurgeryIpsilateral == 'IL-RACLR', 'Revision ACL reconstruction', 'Scope'))), ref = 'None'))
#Modeling
form1 <- formula(paste0('SAR10~', paste(names(select(SAR_dat, -BMI2, -BMI6, -SAR2, -SAR6, -SAR10, -SmokingStatus2, -SmokingStatus6, -SubsequentSurgeryContralateral, -SubsequentSurgeryIpsilateral)), collapse = '+')))
sar_baseline <- orm(form1,
                     data = SAR_dat,
                     x = T, y = T)

form2 <- formula(paste0('SAR10~', paste(names(select(SAR_dat, -BMI0, -BMI6, -SAR0, -SAR6, -SAR10, -SmokingStatus0, -SmokingStatus6)), collapse = '+')))
sar_2Year <- orm(form2,
                 data = SAR_dat,
                 x = T, y = T)

form6 <- formula(paste0('SAR10~', paste(names(select(SAR_dat, -BMI0, -BMI2, -SAR0, -SAR2, -SAR10, -SmokingStatus0, -SmokingStatus2)), collapse = '+')))
sar_6Year <- orm(form6,
                 data = SAR_dat,
                 x = T, y = T)

#Storing in a list
SAR <- list('Baseline' = sar_baseline,
             'Year2' = sar_2Year,
             'Year6' = sar_6Year)

##Symptom
SYMP_dat <- dat2
sort(unique(c(attr(koos.symptom.10.fit.step$terms, "term.labels"),attr(koos.symptom.10.fit.at2$terms, "term.labels"),attr(koos.symptom.10.fit.at6$terms, "term.labels"))))

#Only selecting columns needed (Kevin used baseline pain at all time points, will switch to correct timepoint so coefficients won't match)
SYMP_dat <- select(SYMP_dat,
                  ACLateralPathology = ac.lat.imp.t0.2,
                  GraftType = acl.gtype.imp.t0,
                  ReconstructionType = acl.pr.t0,
                  ACPatellofemoralPathology = ac.pf.imp.t0,
                  Age = age.t0,
                  BMI0 = bmi.t0,
                  BMI2 = bmi.t2,
                  BMI6 = bmi.t6,
                  SYMP0 = koos.symptom.t0,
                  SYMP2 = koos.symptom.t2,
                  SYMP6 = koos.symptom.t6,
                  SYMP10 = koos.symptom.t10,
                  PreviousMedialMeniscusSurgery = mpre.su1.imp.t0,
                  Education = school.yrs.imp.t0,
                  SmokingStatus0 = smoke.imp.t0.2,
                  SmokingStatus2 = smoke.imp.t2.2,
                  SmokingStatus6 = smoke.imp.t6.2,
                  Sport = sport1.ik.imp.t0.2,
                  SubsequentSurgeryContralateral = sub.surgery.cl.imp,
                  SubsequentSurgeryIpsilateral = sub.surgery.il.imp)
#Releveling
SYMP_dat <- mutate(SYMP_dat,
                  ACLateralPathology = relevel(factor(ifelse(ACLateralPathology == 'normal/grade 1', 'Normal',
                                                             ifelse(ACLateralPathology == 'grade 2', 'Grade 2', 'Grade 3/4'))), ref = 'Normal'),
                  GraftType = relevel(factor(ifelse(GraftType == 'allo-btb', 'Allograft BTB',
                                                    ifelse(GraftType == 'allo-soft tissue', 'Allograft soft tissue',
                                                           ifelse(GraftType == 'auto-btb', 'Autograft BTB', 'Autograft soft tissue')))), ref = 'Allograft BTB'),
                  ReconstructionType = relevel(factor(ifelse(ReconstructionType == 'primary', 'Primary', 'Revision')), ref = 'Primary'),
                  ACPatellofemoralPathology = relevel(factor(ifelse(ACPatellofemoralPathology == 'normal/grade 1', 'Normal',
                                                                    ifelse(ACPatellofemoralPathology == 'grade 2', 'Grade 2', 'Grade 3/4'))), ref = 'Normal'),
                  PreviousMedialMeniscusSurgery = relevel(PreviousMedialMeniscusSurgery, ref = 'No'),
                  SmokingStatus0 = relevel(factor(ifelse(SmokingStatus0 == 'never', 'Never', 
                                                         ifelse(SmokingStatus0 == 'quit', 'Quit', 'Current'))), ref = 'Never'),
                  SmokingStatus2 = relevel(factor(ifelse(SmokingStatus2 == 'never', 'Never', 
                                                         ifelse(SmokingStatus2 == 'quit', 'Quit', 'Current'))), ref = 'Never'),
                  SmokingStatus6 = relevel(factor(ifelse(SmokingStatus6 == 'never', 'Never', 
                                                         ifelse(SmokingStatus6 == 'quit', 'Quit', 'Current'))), ref = 'Never'),
                  Sport = relevel(factor(ifelse(Sport == 'none', 'None',
                                                ifelse(Sport == 'baseball / softball', 'Baseball/Softball',
                                                       ifelse(Sport == 'basketball', 'Basketball',
                                                              ifelse(Sport == 'football', 'Football',
                                                                     ifelse(Sport == 'soccer', 'Soccer', 'Other')))))), ref = 'None'),
                  SubsequentSurgeryContralateral = relevel(factor(ifelse(SubsequentSurgeryContralateral == 'none', 'None',
                                                                         ifelse(SubsequentSurgeryContralateral == 'CL-ACLR', 'ACL reconstruction', 'Scope'))), ref = 'None'),
                  SubsequentSurgeryIpsilateral = relevel(factor(ifelse(SubsequentSurgeryIpsilateral == 'none', 'None',
                                                                       ifelse(SubsequentSurgeryIpsilateral == 'IL-RACLR', 'Revision ACL reconstruction', 'Scope'))), ref = 'None'))
#Modeling
form1 <- formula(paste0('SYMP10~', paste(names(select(SYMP_dat, -BMI2, -BMI6, -SYMP2, -SYMP6, -SYMP10, -SmokingStatus2, -SmokingStatus6, -SubsequentSurgeryContralateral, -SubsequentSurgeryIpsilateral)), collapse = '+')))
symp_baseline <- orm(form1,
                    data = SYMP_dat,
                    x = T, y = T)

form2 <- formula(paste0('SYMP10~', paste(names(select(SYMP_dat, -BMI0, -BMI6, -SYMP0, -SYMP6, -SYMP10, -SmokingStatus0, -SmokingStatus6)), collapse = '+')))
symp_2Year <- orm(form2,
                     data = SYMP_dat,
                     x = T, y = T)

form6 <- formula(paste0('SYMP10~', paste(names(select(SYMP_dat, -BMI0, -BMI2, -SYMP0, -SYMP2, -SYMP10, -SmokingStatus0, -SmokingStatus2)), collapse = '+')))
symp_6Year <- orm(form6,
                  data = SYMP_dat,
                  x = T, y = T)

#Storing in a list
SYMP <- list('Baseline' = symp_baseline,
            'Year2' = symp_2Year,
            'Year6' = symp_6Year)

####STORING ALL MODELS
KOOS <- list('ADL' = ADL,
             'QOL' = QOL,
             'PAIN' = Pain,
             'SAR' = SAR,
             'SYMP' = SYMP)
MOON_MODELS <- list('KOOS' = KOOS,
                    'MARX' = MARX,
                    'IKDC' = IKDC)

save(MOON_MODELS, file = '/home/zajicha/Projects/Orthopedics-Spindler/MOON/10YrShinyApplication/MOON_MODELS.RData')

###Creating list of levels/summaries for each variable
get_summary <- function(v) {
  if(class(v) %in% c('numeric', 'integer')) {
    c(round(min(v, na.rm = T)), round(mean(v, na.rm = T)), round(max(v, na.rm = T)))
  } else {
    levels(v)
  }
}


variable_summaries <- list('Age' = get_summary(MARX_dat$Age),
                           'BMI' = get_summary(MARX_dat$BMI0),
                           'CompetitionLevel' = get_summary(MARX_dat$CompetitionLevel),
                           'Education' = get_summary(MARX_dat$Education),
                           'Gender' = get_summary(MARX_dat$Gender),
                           'GraftType' = get_summary(MARX_dat$GraftType),
                           'HighGradeLaxity' = get_summary(MARX_dat$HighGradeLaxity),
                           'MARX' = get_summary(MARX_dat$MARX0),
                           'PreviousMedialMeniscusSurgery' = get_summary(SAR_dat$PreviousMedialMeniscusSurgery),
                           'SubsequentSurgeryContralateral1' = get_summary(SAR_dat$SubsequentSurgeryContralateral),
                           'SubsequentSurgeryIpsilateral1' = get_summary(SAR_dat$SubsequentSurgeryIpsilateral),
                           'TibialFixation' = get_summary(MARX_dat$TibialFixation),
                           'ACLateralPathology' = get_summary(IKDC_dat$ACLateralPathology),
                           'ACMedialPathology' = get_summary(IKDC_dat$ACMedialPathology),
                           'ACPatellofemoralPathology' = get_summary(IKDC_dat$ACPatellofemoralPathology),
                           'IKDC' = get_summary(IKDC_dat$IKDC0),
                           'ReconstructionType' = get_summary(IKDC_dat$ReconstructionType),
                           'SmokingStatus' = get_summary(IKDC_dat$SmokingStatus0),
                           'Sport' = get_summary(IKDC_dat$Sport),
                           'ADL' = get_summary(ADL_dat$ADL0),
                           'PreviousACLRContralateralKnee' = get_summary(ADL_dat$PreviousACLRContralateralKnee),
                           'ACLateralFracturePathology' = get_summary(QOL_dat$ACLateralFracturePathology),
                           'LateralMeniscalPathology' = get_summary(QOL_dat$LateralMeniscalPathology),
                           'PreviousILKneeSurgery' = get_summary(QOL_dat$PreviousILKneeSurgery),
                           'QOL' = get_summary(QOL_dat$QOL0),
                           'SurgicalExposure' = get_summary(QOL_dat$SurgicalExposure),
                           'SubsequentSurgeryContralateral2' = get_summary(QOL_dat$SubsequentSurgeryContralateral),
                           'SubsequentSurgeryIpsilateral2' = get_summary(QOL_dat$SubsequentSurgeryIpsilateral),
                           'Pain' = get_summary(pain_dat$Pain0),
                           'SAR' = get_summary(SAR_dat$SAR0),
                           'SYMP' = get_summary(SYMP_dat$SYMP0))
save(variable_summaries, file = '/home/zajicha/Projects/Orthopedics-Spindler/MOON/10YrShinyApplication/variable_summaries.RData')




