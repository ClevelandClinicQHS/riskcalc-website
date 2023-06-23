## Code to compute CRT response score 
# Albert Feeny, feenya@ccf.org
# Requires 'crt-score-training.csv' data to train the model

library(e1071)

# Reference table
g1 <- "0 - 0.2"
g2 <- "0.2 - 0.4"
g3 <- "0.4 - 0.6"
g4 <- "0.6 - 0.8"
g5 <- "0.8 - 1"

rate1 <- c(43, 26, 5)
rate2 <- c(59, 33, 10)
rate3 <- c(57, 37, 17)
rate4 <- c(80, 62, 31)
rate5 <- c(82, 71, 47)
ratec1 <- c(76, 57, 31)
ratec2a <- c(61, 42, 16)
ratec2b <- c(45, 16, 8)

# Standardization parameters
ef_mn <- 23.1075
ef_sd <- 9.0848
lvedd_mn <- 6.0675
lvedd_sd <- 1.0870
qrsd_mn <- 158.0184
qrsd_sd <- 28.8009
nyha_mn <- 2.8919
nyha_sd <- 0.4489

# Train Naive Bayes model
trainDat <- read.csv(file="crt-score-training.csv", header=FALSE)
Xtrain <- trainDat[,c(1:12)]
Ytrain <- trainDat[,c(13)]
model <- naiveBayes(Xtrain, Ytrain)


###### INPUT NEW DATA ####################################################################
# The following 9 variables are an example for what may be entered in the website.
# 1. QRS duration (continuous variable in milliseconds, infinite range)
qrsd_in_raw <-200
# 2. QRS morphology (categorical variable: one of four options: LBBB, RBBB, IVCD, or RV-paced)
morph_in <- "RV-paced"
# 3. Left ventricular ejection fraction (continuous variable, 0-100)
ef_in_raw <- 15
# 4. NYHA heart failure classification (continuous variable, range 0-4)
nyha_in_raw <- 3
# 5. Gender (binary, True = male)
gender_in <- FALSE
# 6. Left ventricular end-diastolic diameter (continuous variable)
lvedd_in_raw <- 8
# 7. Ischemic etiology of cardiomyopathy (binary, True = ischemic, false = non-ischemic)
ICM_in <- FALSE
# 8. History of atrial fibrillation (binary, true = yes, false = no)
AF_in <- FALSE
# 9. Placement of epicardial LV lead (binary, true = yes, false = no)
epi_in <- FALSE

############ FORMAT DATA #####################################################
# Standardize continuous variables by mean/standard deviation
ef_in <- (ef_in_raw - ef_mn)/ef_sd
qrsd_in <- (qrsd_in_raw - qrsd_mn)/qrsd_sd
nyha_in <- (nyha_in_raw - nyha_mn)/nyha_sd
lvedd_in <- (lvedd_in_raw - lvedd_mn)/lvedd_sd

# Convert categorical QRS morphology into binary variables
LBBB_in <- FALSE
RBBB_in <- FALSE
IVCD_in <- FALSE
PACE_in <- FALSE
if(morph_in == "LBBB")
  LBBB_in <- TRUE
if(morph_in == "RBBB")
  RBBB_in <- TRUE
if(morph_in == "IVCD")
  IVCD_in <- TRUE
if(morph_in == "RV-paced")
  PACE_in <- TRUE

# Estimate 2013 ACCF/AHA Heart Failure Guidelines
class <- FALSE
if (morph_in == "LBBB" & qrsd_in_raw >= 150 & ef_in_raw <= 35 & nyha_in_raw >= 2)
  class <- "Class I"
if ((ef_in_raw <= 35 & (morph_in == "RBBB" | morph_in == "IVCD") & qrsd_in_raw >= 150 & nyha_in_raw >= 3) |
    (ef_in_raw <= 35 & morph_in == "LBBB" & qrsd_in_raw < 150 & qrsd_in_raw >= 120 & nyha_in_raw >= 2) |
    (ef_in_raw <= 35 & morph_in == "RV-paced"))
  class <- "Class IIa"
if ((ef_in_raw <= 35 & (morph_in == "RBBB" | morph_in == "IVCD")  & qrsd_in_raw < 150 & qrsd_in_raw >= 120 & nyha_in_raw >= 3) |
    (ef_in_raw <= 35 &  (morph_in == "RBBB" | morph_in == "IVCD")  & qrsd_in_raw >= 150 & nyha_in_raw == 2) |
    (ef_in_raw <= 30 & ICM_in == TRUE & morph_in == "LBBB" & qrsd_in_raw >= 150 & nyha_in_raw == 1))
  class <- "Class IIb"

############### RUN MODEL ####################################################################
Xtest <- data.frame(ICM_in, ef_in, lvedd_in, gender_in, qrsd_in, LBBB_in, PACE_in, RBBB_in, IVCD_in, AF_in, nyha_in, epi_in)
names(Xtest) <- c("V1", "V2", "V3", "V4", "V5", "V6", "V7", "V8", "V9", "V10", "V11", "V12")


output <- predict(model,Xtest, type = "raw")

########### FINAL OUTPUT SCORE TO DISPLAY ##################################################
response_score <- round(output[2], digits=3)


########### Format a final additional output message ################
if (response_score <= .2)
  {g <- g1
  rate <- rate1}
if (response_score >.2 & response_score <=.4)
  {g <- g2
  rate <- rate2}
if (response_score >.4 & response_score <=.6)
  {g <- g3
  rate <- rate3}
if (response_score >.6 & response_score <=.8)
  {g <- g4
  rate <- rate4}
if (response_score >.8)
  {g <- g5
  rate <- rate5}

if (class == "Class I")
  ratec <- ratec1
if (class == "Class IIa")
  ratec <- ratec2a
if (class == "Class IIb")
  ratec <- ratec2b


if (class!=FALSE)  
{Message <- paste("Based on input parameters, this patient is most likely to meet 2013 ACCF/AHA",class, "criteria. ",
class, " patients had the following response rates:\n
5% LVEF improvement: ",toString(ratec[1]),"%\n
10% LVEF improvement: ",toString(ratec[2]),"%\n
20% LVEF improvement: ",toString(ratec[3]),"%\n\n

The CRT response score may offer more accurate prediction of outcomes.\n
Based on input parameters, this patient has a CRT response score of ", toString(response_score),
". Patients with a response score between ", g ," had the following response rates:\n
5% LVEF improvement: ",toString(rate[1]),"%\n
10% LVEF improvement: ",toString(rate[2]),"%\n
20% LVEF improvement: ",toString(rate[3]),"%.")}

if (class==FALSE)  
{Message <- paste("Based on input parameters, this patient most likely does not meet 2013 ACCF/AHA Class I, IIa, or IIb criteria.\n\n
                  
The CRT response score may offer more accurate prediction of outcomes.\n
Based on input parameters, this patient has a CRT response score of ", toString(response_score),
". Patients with a response score between ", g ," had the following response rates:\n
5% LVEF improvement: ",toString(rate[1]),"%\n
10% LVEF improvement: ",toString(rate[2]),"%\n
20% LVEF improvement: ",toString(rate[3]),"%.")}


########## FINAL OUTPUT MESSAGE TO DISPLAY #########################################################################

cat(Message)
  
