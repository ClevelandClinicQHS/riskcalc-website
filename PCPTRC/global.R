#require(shinyIncubator)
require(knitr)
library(shinyBS)

source("messages_en.r", encoding="UTF-8")
source("messages_sp.r", encoding="UTF-8")
source("JS.r")
snpdat = read.table(file = "SNPinformation_riskallele_links_pubmedUTF.txt", header = T,stringsAsFactors = F,encoding = "UTF-8")

encode <- function(x){
  Encoding(x) <- "UTF-8"
  x
}

actionButton <- function(inputId, label, btn.style = "" , css.class = "") {
  if ( btn.style %in% c("primary","info","success","warning","danger","inverse","link")) {
    btn.css.class <- paste("btn",btn.style,sep="-")
  } else btn.css.class = ""
  
  tags$button(id=inputId, type="button", class=paste("btn action-button",btn.css.class,css.class,collapse=" "), label)
}  


#toggle inital language
#1: English
#0: Spanish
globalLanguage = 1

# Function to switch the language of a text
langSwitch <- function(en, sp, type="text",mylang = globalLanguage){
  if(type=="text"){
    span(div(`data-display-if` = ifelse(mylang,"!(input.lang%2)","(input.lang%2)"), en,style='display: inline'),
        div(`data-display-if` = ifelse(mylang,"(input.lang%2)","!(input.lang%2)"),sp,style='display: inline'))
  }
  else if(type=="warning"){
    div(div(`data-display-if` = ifelse(mylang,"!(input.lang%2)","(input.lang%2)"), en,style='display: inline'),
        div(`data-display-if` = ifelse(mylang,"(input.lang%2)","!(input.lang%2)"),sp,style='display: inline'),
        br(),br(),
        class="warning_text")
  }
}

# Function to switch the language of a text
famhistSwitch <- function(text1, text2, type="text"){
    span(div(`data-display-if` = "!(input.famhist_avail%2)", text1,style='display: inline'),
         div(`data-display-if` = "(input.famhist_avail%2)",text2,style='display: inline'))
  }

# Function to switch the language of a text
snpSwitch <- function(text1, text2, type="text"){
  span(div(`data-display-if` = "!(input.snp_avail%2)", text1,style='display: inline'),
       div(`data-display-if` = "(input.snp_avail%2)",text2,style='display: inline'))
}


source(file = "riskcalc_20180105.r")



calcSmiley = function(risk, lang, famhist_avail){
  start = "<table><tr><td width='50%' height=400 valign='top'>"
  greenFace = "<td> <img src='smiley_green.jpg' width='45' height='45' alt='green face'> </td>"  
  yellowFace = "<td> <img src='smiley_yellow.jpg' width='45' height='45' alt='yellow face'> </td>"  
  redFace = "<td> <img src='smiley_red.jpg' width='45' height='45' alt='red face'> </td>"
  greenFaceT = "<td> <img src='smiley_green_temp.jpg' width='45' height='45' alt='green face'> </td>"  
  yellowFaceT = "<td> <img src='smiley_yellow_temp.jpg' width='45' height='45' alt='yellow face'> </td>"  
  redFaceT = "<td> <img src='smiley_red_temp.jpg' width='45' height='45' alt='red face'> </td>" 
  orangeFace = "<td> <img src='smiley_orange.jpg' width='45' height='45' alt='orange face'> </td>"
  orangeFaceT = "<td> <img src='smiley_orange_temp.jpg' width='45' height='45' alt='orange face'> </td>"
  end = "</tr></table>"
    
  
  
  res0_en = "Based on the provided risk factors a prostate biopsy performed would have a:"
  res0_sp = "En base a los factores de riesgo proveídos, proceder con una biopsia de la próstata conllevaría:"
  
  res1_en = "<br>
            <table height=80% width=90%>
               <tbody><tr>
                <td ><img src='smiley_red.jpg' width='45' height='45' alt='red face'></td><td>"
  
  res1_mod_en = "<br>
            <table height=80% width=90%>
               <tbody><tr>
                <td ><img src='smiley_orange.jpg' width='35' height='35' alt='red face'></td><td>"
  
  res1_sp = "<br>
          <table height=80% width=90%>
               <tbody><tr>
                <td ><img src='smiley_red.jpg' width='45' height='45' alt='red face'></td><td>un "
  
  res1_mod_sp = "<br>
          <table height=80% width=90%>
               <tbody><tr>
                <td ><img src='smiley_orange.jpg' width='35' height='35' alt='red face'></td><td>un "

  res2_en = "% chance of high-grade prostate cancer,</td>
               </tr><tr>
                <td class='center'><img src='smiley_yellow.jpg' width='45' height='45' alt='yellow face'></td><td>"
  res2_sp = "% de probabilidad de cáncer de la próstata de alto grado,</td>
               </tr><tr>
                <td class='center'><img src='smiley_yellow.jpg' width='45' height='45' alt='yellow face'></td><td>un "

  res3_en = "% chance of low-grade cancer,</td>   
               </tr><tr>
                  <td class='center'><img src='smiley_green.jpg' width='45' height='45' alt='green face'></td><td>"
  res3_sp = "% de probabilidad de cáncer de la próstata de bajo grado,</td>   
               </tr><tr>
                  <td class='center'><img src='smiley_green.jpg' width='45' height='45' alt='green face'></td><td>un "

  res3_mod_en = "% chance of cancer,</td>   
               </tr><tr>
                  <td class='center'><img src='smiley_green.jpg' width='35' height='35' alt='green face'></td><td>"
  
  res3_mod_sp = "% de probabilidad de cáncer de la próstata,</td>   
               </tr><tr>
                  <td class='center'><img src='smiley_green.jpg' width='35' height='35' alt='green face'></td><td>un "
  
  res3_mod_ex_en = "% or higher chance of cancer,</td>   
               </tr><tr>
                  <td class='center'><img src='smiley_green.jpg' width='35' height='35' alt='green face'></td><td>"
  
  res3_mod_ex_sp = "% o mayor probabilidad de cáncer de la próstata,</td>   
               </tr><tr>
                  <td class='center'><img src='smiley_green.jpg' width='35' height='35' alt='green face'></td><td>un "
  
  res4_en = "% chance that the biopsy is negative for cancer.</td>   
               </tr><tr>
                  <td class='center'><img src='thermometer.jpg' width='40' height='58' alt='thermometer'></td><td>
                  About 2 to 4% of men undergoing biopsy will have an infection that may require hospitalization.</td>"
  
  res4_sp = "% de probabilidad de que la biopsia no demuestre cáncer</td>   
               </tr><tr>
                  <td class='center'><img src='thermometer.jpg' width='40' height='58' alt='thermometer'></td><td>
                  Aproximadamente de un 2 a 4% de hombres que se someten a una biopsia sufrirán de una infección que puede que requiera hospitalización.</td> "  
  
  res4_ex_en = "% or lower chance that the biopsy is negative for cancer.</td>   
               </tr><tr>
                  <td class='center'><img src='thermometer.jpg' width='40' height='58' alt='thermometer'></td><td>
                  About 2 to 4% of men undergoing biopsy will have an infection that may require hospitalization.</td>"
  
  res4_ex_sp = "% o menor probabilidad de que la biopsia no demuestre cáncer</td>   
               </tr><tr>
                  <td class='center'><img src='thermometer.jpg' width='40' height='58' alt='thermometer'></td><td>
                  Aproximadamente de un 2 a 4% de hombres que se someten a una biopsia sufrirán de una infección que puede que requiera hospitalización.</td> "  
  
  
  res4_mod_en = "% chance that the biopsy is negative for cancer.</td>"
  res4_mod_sp = "% de probabilidad de que la biopsia no demuestre cáncer</td>"   
  
  res5_en = "</tr><tr>
              <td colspan=2>Please consult your physician concerning these results.</td>"
            #</tr>
            #</table>"

  res5_sp = "</tr><tr>
              <td colspan=2>Por favor, consulte con su médico acerca de estos resultados. </td>"
              #</tr>
              #</table>"
  

  div_en = ifelse(globalLanguage, "<div data-display-if='!(input.lang%2)' style='display: inline-block; height:100%'>", "<div data-display-if='(input.lang%2)' style='display: inline-block; height:100%'>")
  div_sp = ifelse(globalLanguage,"<div data-display-if='(input.lang%2)' style='display: inline-block; height:100%'>","<div data-display-if='!(input.lang%2)' style='display: inline-block; height:100%'>")
  div_end = "</div>"
  
  #htmlString = start
  #info_text_en = "Please consult your physician concerning these results."
  if(!famhist_avail){
    htmlString_en = paste(res0_en,res1_en,risk[3],res2_en,risk[2],res3_en,risk[1],res4_en,res5_en,end, sep="")
    htmlString_sp = paste(res0_sp,res1_sp,risk[3],res2_sp,risk[2],res3_sp,risk[1],res4_sp,res5_sp,end, sep="")
  }
  else {
    if(risk[2] < 75){
      htmlString_en = paste(res0_en,res1_mod_en,risk[2],res3_mod_en,risk[1],res4_en,res5_en,end, sep="")
      htmlString_sp = paste(res0_sp,res1_mod_sp,risk[2],res3_mod_sp,risk[1],res4_sp,res5_sp,end, sep="")
    }
    else{
      htmlString_en = paste(res0_en,res1_mod_en,risk[2],res3_mod_ex_en,risk[1],res4_ex_en,res5_en,end, sep="")
      htmlString_sp = paste(res0_sp,res1_mod_sp,risk[2],res3_mod_ex_sp,risk[1],res4_ex_sp,res5_sp,end, sep="")
    }
      
  }
  
  htmlString = paste(start,div_en,htmlString_en,div_end,div_sp,htmlString_sp,div_end, sep="")
  htmlString = paste(htmlString, "</td><td><table><tbody><tr>", sep="")

  mysample = sample(100,3)
  
  counter = 1
  if(!famhist_avail){
    if(risk[3] > 0){
    for(i in 1:risk[3]){
      if(counter %in% mysample){
        htmlString = paste(htmlString,redFaceT,sep="")
      }
      else
        htmlString = paste(htmlString,redFace,sep="")
      if(counter %% 10 == 0 & counter != 100){
        htmlString = paste(htmlString,"</tr><tr>",sep="")
      }
      counter = counter + 1
    }
    }
    if(risk[2] > 0){
    for(i in seq_len(risk[2])){
      if(counter %in% mysample){
        htmlString = paste(htmlString,yellowFaceT,sep="")
      }
      else
        htmlString = paste(htmlString,yellowFace,sep="")
      if(counter %% 10 == 0 & counter != 100){
        htmlString = paste(htmlString,"</tr><tr>",sep="")
      }
      counter = counter + 1
    }
    }
    if(risk[1] > 0){
    for(i in seq_len(risk[1])){
      if(counter %in% mysample){
        htmlString = paste(htmlString,greenFaceT,sep="")
      }
      else
        htmlString = paste(htmlString,greenFace,sep="")
      if(counter %% 10 == 0 & counter != 100){
        htmlString = paste(htmlString,"</tr><tr>",sep="")
      }
      counter = counter + 1
    }
    }
  }
  else {  # if detailed famhist available use other icons
    if(risk[1] > 0){
    for(i in seq_len(risk[1])){
      if(counter %in% mysample){
        htmlString = paste(htmlString,greenFaceT,sep="")
      }
      else
      htmlString = paste(htmlString,greenFace,sep="")
      if(counter %% 10 == 0 & counter != 100){
        htmlString = paste(htmlString,"</tr><tr>",sep="")
      }
      counter = counter + 1
    }
    }
    if(risk[2] > 0){
    for(i in seq_len(risk[2])){
      if(counter %in% mysample){
        htmlString = paste(htmlString,orangeFaceT,sep="")
      }
      else
      htmlString = paste(htmlString,orangeFace,sep="")
      if(counter %% 10 == 0 & counter != 100){
        htmlString = paste(htmlString,"</tr><tr>",sep="")
      }
      counter = counter + 1
    }
  }
  }
  htmlString = paste(htmlString,"</table>",sep="")

  htmlString = paste(htmlString,end,sep="")
  htmlString  
}





helpPopup <- function(title, content,
                      placement=c('right', 'top', 'left', 'bottom'),
                      trigger=c('click', 'hover', 'focus', 'manual')) {
  tagList(
    singleton(
      tags$head(
        tags$script("$(function() { $(\"[data-toggle='popover']\").popover(); })")
      )
    ),
    tags$a(
      href = "#", class = "btn btn-mini", `data-toggle` = "popover",
      title = title, `data-content` = content, `data-animation` = TRUE,
      `data-placement` = match.arg(placement, several.ok=TRUE)[1],
      `data-trigger` = match.arg(trigger, several.ok=TRUE)[1],
      
      tags$i(class="icon-question-sign")
    )
  )
}
