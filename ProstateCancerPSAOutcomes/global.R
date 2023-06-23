#Comparing the risk of all cause mortality, prostate-cancer specific mortality, and prostate cancer diagnosis for patients screened vs. those unscreened (MODELS)
#Risk of same three evens but only patients who have previously had a PSA done (MODELS_SCREENED)


#Global file loading in objects needed in application
#Loads in 3 models contained in a list object built on screened and unscreened patients
load("MODELS_ALL_10-23-17.RData")

#Loads in 3 models contained in a list object built on screened patients only
load("MODELS_SCREENED_10-23-17.RData")

#Edited version of QHScrnomo.predict.cmprsk (had to make a small change to make it work)
source("predict.cmprsk.R")