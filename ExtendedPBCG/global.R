require(knitr)
library(shinyBS)

source("messages_en.r", encoding="UTF-8")
source("JS.r")
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

source(file = "R_code_PBCG_risk_calculator.R")
globalLanguage = 1

calcSmiley = function(risk){
    start = "<table><tr><td width='50%' height=400 valign='top'>"
    greenFace = "<td> <img src='man_green.png' width='23 height='47' alt='green face'> </td>"  
    yellowFace = "<td> <img src='man_yellow.png' width='23 height='47' alt='yellow face'> </td>"  
    redFace = "<td> <img src='man_red.png' width='23 height='47' alt='red face'> </td>"
    greenFaceT = "<td> <img src='man_green.png' width='23 height='47' alt='green face'> </td>"  
    yellowFaceT = "<td> <img src='man_yellow.png' width='23 height='47' alt='yellow face'> </td>"  
    redFaceT = "<td> <img src='man_red.png' width='23 height='47' alt='red face'> </td>" 
    orangeFace = "<td> <img src='man_orange.png' width='23 height='47' alt='orange face'> </td>"
    orangeFaceT = "<td> <img src='man_orange.png' width='23 height='47' alt='orange face'> </td>"
    end = "</tr></table>"
    
    
    
    res0_en = "Based on the provided risk factors a prostate biopsy performed would have a:"

    res1_en = "<br>
    <table height=80% width=90%>
    <tbody><tr>
    <td ><img src='man_green.png' width='23 height='47' alt='red face'></td><td>"
    
    res1_mod_en = "<br>
    <table height=80% width=90%>
    <tbody><tr>
    <td ><img src='man_orange.png' width='35' height='35' alt='red face'></td><td>"
    
    res2_en = "% chance of no or low-grade prostate cancer,</td>
    </tr><tr>
    <td class='center'><img src='man_red.png' width='23 height='47' alt='yellow face'></td><td>"

    res3_en = "% chance of high-grade cancer,</td>   
    </tr><tr>
    <td class='center'><img src='man_red.png' width='23 height='47' alt='green face'></td><td>"

    res3_mod_en = "% chance of cancer,</td>   
    </tr><tr>
    <td class='center'><img src='man_green.png' width='35' height='35' alt='green face'></td><td>"
    
    res3_mod_ex_en = "% or higher chance of cancer,</td>   
    </tr><tr>
    <td class='center'><img src='man_green.png' width='35' height='35' alt='green face'></td><td>"
    
    res4_en = "% chance of high-grade cancer.</td>"
    
    res4_ex_en = "% or lower chance that the biopsy is negative for cancer.</td>"
    
    res4_mod_en = "% chance that the biopsy is negative for cancer.</td>"
    res4_mod_sp = "% de probabilidad de que la biopsia no demuestre cáncer</td>"   
    
    res5_en = "</tr><tr>
    <td colspan=2>Please consult your physician concerning these results.</td>"
    #</tr>
    #</table>"
    
    div_en = "<div style='display: inline-block; height:100%; width:95%'>"
    # div_sp = ifelse(globalLanguage,"<div data-display-if='(input.lang%2)' style='display: inline-block; height:100%'>","<div data-display-if='!(input.lang%2)' style='display: inline-block; height:100%'>")
    div_end = "</div>"
    
    htmlString_en = paste(res0_en,res1_en,risk[1],res2_en,risk[2],res4_en,res5_en,end, sep="")
    
    htmlString = paste(start,div_en,htmlString_en,div_end,sep="")
    htmlString = paste(htmlString, "</td><td><table><tbody><tr>", sep="")

    counter = 1
    
    if(risk[1] > 0){
        for(i in 1:risk[1]){
            htmlString = paste(htmlString,greenFace,sep="")
            if(counter %% 10 == 0 & counter != 100){
                htmlString = paste(htmlString,"</tr><tr>",sep="")
            }
            counter = counter + 1
        }
    }
    # if(risk[2] > 0){
    #     for(i in seq_len(risk[2])){
    #         htmlString = paste(htmlString,yellowFace,sep="")
    #         if(counter %% 10 == 0 & counter != 100){
    #             htmlString = paste(htmlString,"</tr><tr>",sep="")
    #         }
    #         counter = counter + 1
    #     }
    # }
    if(risk[2] > 0){
        for(i in seq_len(risk[2])){
            htmlString = paste(htmlString,redFace,sep="")
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

stats_en = HTML("<h1>Extended PBCG Risk Calculator Users</h1> <br> 
             <iframe marginwidth='0'   frameborder='0'  marginheight='0' width='800' height='639' src='https://datastudio.google.com/embed/reporting/1MVph-tKShhqH6wKaNY9d7A1yRj-1V2PD/page/Y0dT' type='text/html'  style='border:0' allowfullscreen scrolling='no' title='Google Analytics Reporting Tool'></iframe>")


