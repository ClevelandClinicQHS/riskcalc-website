
### Preliminaries
BaseDir  <- "/home/tuc/projects/GeneralSurgery/Walsh/pSerousCyst/"
DataDir  <- paste(BaseDir,"data/",sep="")
GraphDir <- paste(BaseDir,"graphs/",sep="")
OtherDir <- paste(BaseDir,"others/",sep="")
OriginDir   <- paste(BaseDir, "orig_data/",sep="")
RDir     <- paste(BaseDir,"s_plus/",sep="")
SASDir   <- paste(BaseDir,"sas/",sep="")
Date     <- "yyyymmdd"

################################################################################
## Begin Main Program
################################################################################

library(lubridate)
library(rms)


dat = read.csv(file = paste0(OriginDir,"Serous Cystadenoma.csv"), header = T)

dat$ID = c(1:length(dat$MRN))
dat$group = cut(dat$Cyst.Size..1, breaks = c(-Inf, 20, 50, Inf), labels = c("small", "medium", "large"), right = T)

dat_long =  reshape(dat, direction='long', 
                    varying=c("First.Imaging" , "Cyst.Size..1",  "Second.Imaging", "Cyst.Size..2",   "Third.Imaging",  "Cyst.Size..3",  
                              "Forth.Imaging",  "Cyst.Size..4"), 
                    timevar='var',
                    times=c('first', 'second','third','forth'),
                    v.names=c('imaging', 'size'),
                    idvar='MRN')

dat_long = dat_long[complete.cases(dat_long$size),]
dat_long$var = factor(dat_long$var, levels = c("first","second","third","forth"))

dat_long = dat_long[order(dat_long$MRN, dat_long$var),]


dat_long$tdiff <- unlist(tapply(mdy(as.character(dat_long$imaging)), INDEX = dat_long$MRN,
                                FUN = function(x) c(0, diff(x)/dyears(1))))

dat_long$tdiff_month = 12*dat_long$tdiff

baseline = dat_long[dat_long$var %in% c("first"),]
baseline = baseline[,c("ID","size")]
names(baseline)= c("ID","baseline")
dat_b = merge(dat_long[dat_long$var %in% c("second","third","forth"),], baseline, by = "ID")

dat_b = dat_b[complete.cases(dat_b$tdiff_month),]

dd = datadist(dat_b)
options(datadist='dd')

# Collin creat a correlation structure
source("/home/tuc/R function/corCSCAR.R")


mod     = Gls(size ~ rcs(tdiff_month) + 
                rcs(baseline) + rcs(baseline) %ia% rcs(tdiff_month) , 
              data = dat_b, 
              correlation = corCSCAR(form=~tdiff_month|ID),
              # weights = varPower(form=~fitted(.)), 
              verbose = TRUE, x=T)

