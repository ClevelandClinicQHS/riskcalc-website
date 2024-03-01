require(knitr)
library(shinyBS)

source("messages.r", encoding="UTF-8")

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
#0: German
globalLanguage = 1

# Function to switch the language of a text
langSwitch <- function(eng, ger, type="text", mylang = globalLanguage){
  if(type=="text"){
    span(div(`data-display-if` = ifelse(mylang,"!(input.lang%2)","(input.lang%2)"),eng,style='display: inline'),
         div(`data-display-if` = ifelse(mylang,"(input.lang%2)","!(input.lang%2)"),ger,style='display: inline'))
  }
  else if(type=="warning"){
    div(div(`data-display-if` = ifelse(mylang,"!(input.lang%2)","(input.lang%2)"),eng,style='display: inline'),
        div(`data-display-if` = ifelse(mylang,"(input.lang%2)","!(input.lang%2)"),ger,style='display: inline'),
        br(),br(),
        class="warning_text")
  }
}

source(file = "riskcalc.R")



calcSmiley = function(risk, lang){
  start = "<table><tr><td width='50%' height=400 valign='top'>"
  greenMan = "<td> <img src='Man_green.png' height='42' height='71' alt='green man'> <span class='tab'></span> </td>"  
  orangeMan = "<td> <img src='Man_orange.png' height='42' height='71' alt='orange man'> <span class='tab'></span> </td>"
  end = "</tr></table>"
  
  res1_eng = "Based on the provided risk factors a prostate biopsy\n performed would have a: <span class='tab'></span> "
  res1_ger = "Basierend auf den angegebenen Risikofaktoren würde eine Prostata Biopsie eine: <span class='tab'></span> "
 
  res2_eng = "<br>
            <table height=80% width=90%>
               <tbody><tr>
                <td ><img src='Man_orange.png' height='42' height='71' alt='orange man'></td><td> "

  res2_ger = "<br>
          <table height=80% width=90%>
               <tbody><tr>
                <td ><img src='Man_orange.png' height='42' height='71' alt='orange man'></td><td> "

  res3_eng = "% chance of csPCa, and a </td>   
               </tr><tr>
                  <td class='center'><img src='Man_green.png' height='42' height='71' alt='green man'></td><td>"
  
  res3_ger = "% Chance auf csPCa und eine </td>   
               </tr><tr>
                  <td class='center'><img src='Man_green.png' height='42' height='71' alt='green man'></td><td>  "
  
  res3_ex_eng = "% or higher chance of csPCa, and a </td>   
               </tr><tr>
                  <td class='center'><img src='Man_green.png' height='42' height='71' alt='green man'></td><td> "
  
  res3_ex_ger = "% oder eine höhere Chance auf csPCa und eine</td>   
               </tr><tr>
                  <td class='center'><img src='Man_green.png' height='42' height='71' alt='green man'></td><td> "
  
  res4_eng = "% chance that the biopsy is negative for csPCa.</td>"
  
  res4_ger = "% Chance, dass die Biopsie csPCa negativ ausfällt.</td>"  
  
  res4_ex_eng = "% or lower chance that the biopsy is negative for csPCa.</td>"
  
  res4_ex_ger = "% oder eine kleiner Chance, dass die Biopsie csPCa negativ ausfällt.</td>"  

  div_eng = ifelse(globalLanguage, "<div data-display-if='!(input.lang%2)' style='display: inline-block; height:100%'>", "<div data-display-if='(input.lang%2)' style='display: inline-block; height:100%'>")
  div_ger = ifelse(globalLanguage,"<div data-display-if='(input.lang%2)' style='display: inline-block; height:100%'>","<div data-display-if='!(input.lang%2)' style='display: inline-block; height:100%'>")
  div_engd = "</div>"
  
  #htmlString = start
  #info_text_eng = "Please consult your physician concerning these results."
  if(risk[2] < 75){
      htmlString_eng = paste(res1_eng,res2_eng,round(risk[2],2),res3_eng,round(risk[1],2),res4_eng,end, sep="")
      htmlString_ger = paste(res1_ger,res2_ger,round(risk[2],2),res3_ger,round(risk[1],2),res4_ger,end, sep="")
  }
  else{
      htmlString_eng = paste(res1_eng,res2_eng,round(risk[2],2),res3_ex_eng,round(risk[1],2),res4_ex_eng,end, sep="")
      htmlString_ger = paste(res1_ger,res2_ger,round(risk[2],2),res3_ex_ger,round(risk[1],2),res4_ex_ger,end, sep="")
  }
  
  htmlString = paste(start,div_eng,htmlString_eng,div_engd,div_ger,htmlString_ger,div_engd, sep="")
  htmlString = paste(htmlString, "</td><td><table><tbody><tr>", sep="")
  
  mysample = sample(100,3)
  
  no_csPCa_c=round(risk[1])
  csPCa_c=round(risk[2])
  
  counter=1
  if(no_csPCa_c > 0){
      for(i in 1:no_csPCa_c){
        htmlString = paste(htmlString,greenMan,sep="")
        if(counter %% 10 == 0 & counter != 100){
          htmlString = paste(htmlString,"</tr><tr>",sep="")
        }
        counter = counter + 1
      }
  }
  if(csPCa_c > 0){
      for(i in seq_len(csPCa_c)){
        htmlString = paste(htmlString,orangeMan,sep="")
        if(counter %% 10 == 0 & counter != 100){
          htmlString = paste(htmlString,"</tr><tr>",sep="")
        }
        counter = counter + 1
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
