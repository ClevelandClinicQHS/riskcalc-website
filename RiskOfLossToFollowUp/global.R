
library(dplyr)
library(DT)

predict_ltfu <- function(Age, Sex, Race, Education, Smoking, Surgeon) {
  
  lp <- 0.442773 +
    Age * -0.007771 +
    (Sex == "M") * 0.460863 +
    (Race == "Black") * 0.580620 +
    (Race == "Other") * 0.309251 +
    Education * -0.054400 +
    (Smoking == "Quit") * 0.079806 +
    (Smoking == "Current") * 0.708935 +
    (Surgeon == "High Volume") * -0.530999 +
    (Surgeon == "Median Volume") * -0.332028
  
  100/(1+exp(-lp))
}


high_vol <- c(
  "Saluan, Paul M", "Farrow, Lutul D", "Spindler, Kurt P",
  "Leo, Brian M", "Rosneck, James T"
)

median_vol <- c(
  "Scarcella, Michael J",
  "Serna, Alfred"
)


low_vol <- c(
  "Sabo, Frank M", "Matko, Andrew J", "Mackechnie, Michael",
  "Kolczun, Michael W", "Kantaras, Anthony T", "Silko, Christopher P",
  "Nemeth, Victor A", "Pinkowski, John L", "Yang, Jeffrey", 
  "Pierce, Bradley A", 
  "Masin, Richard R", 
  "Wilcox, Philip G", "Krahe, David H",
  "Sziraky, Patrick E",
  "Joesph Trammer", "Sercan Yalcin", "Jose Vega"
)
all_surgeons <-  c(high_vol, median_vol, low_vol)

surgeon_volume <- function(surgeon_name) {
  dplyr::case_when(
    surgeon_name %in% high_vol   ~ "High Volume",
    surgeon_name %in% median_vol ~ "Median Volume",
    surgeon_name %in% low_vol    ~ "Low Volume",
    TRUE ~ NA_character_
  )
}
