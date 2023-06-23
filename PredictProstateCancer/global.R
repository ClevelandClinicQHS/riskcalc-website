require(knitr)
library(rms)
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

source(file = "R_code_risk_calculator.R")
globalLanguage = 1

calcSmiley = function(risk){
    start = "<table><tr><td width='30%' height=400 valign='top'>"
    greenFace = "<td> <img src='man_green.png' width='23 height='47' alt='green face'> </td>"  
    yellowFace = "<td> <img src='man_yellow.png' width='23 height='47' alt='yellow face'> </td>"  
    redFace = "<td> <img src='man_red.png' width='23 height='47' alt='red face'> </td>"
    greenFaceT = "<td> <img src='man_green.png' width='23 height='47' alt='green face'> </td>"  
    yellowFaceT = "<td> <img src='man_yellow.png' width='23 height='47' alt='yellow face'> </td>"  
    redFaceT = "<td> <img src='man_red.png' width='23 height='47' alt='red face'> </td>" 
    orangeFace = "<td> <img src='man_orange.png' width='23 height='47' alt='orange face'> </td>"
    orangeFaceT = "<td> <img src='man_orange.png' width='23 height='47' alt='orange face'> </td>"
    end = "</tr></table>"
    
    
    
    res_en = "Based on the provided risk factors:"
    
    res0_en = "
    <table height=80% width=80%>"
    
    res1_en = "
    <tbody><tr>
    <td ><img src='man_green.png' width='23 height='47' alt='green face'></td><td>"
    
    res1_mod_en = "<br>
    <table height=80% width=90%>
    <tbody><tr>
    <td ><img src='man_orange.png' width='35' height='35' alt='red face'></td><td>"
    
    res2_en = "1% chance that the biopsy is negative for cancer,</td>
    <td class='center'><img src='man_yellow.png' width='23 height='47' alt='yellow face'></td><td>"
    
    res3_en = "1% chance of low-grade cancer,</td>   
    <td class='center'><img src='man_red.png' width='23 height='47' alt='red face'></td><td>"
    
    res3_mod_en = "1% chance of cancer,</td>   
    <td class='center'><img src='man_green.png' width='35' height='35' alt='green face'></td><td>"
    
    res3_mod_ex_en = "1% or higher chance of cancer,</td>   
    <td class='center'><img src='man_green.png' width='35' height='35' alt='green face'></td><td>"
    
    res4_en = "1% chance of high-grade prostate cancer.</td>"
    
    res4_ex_en = "% or lower chance that the biopsy is negative for cancer.</td>"
    
    res4_mod_en = "1% chance that the biopsy is negative for cancer.</td>"
    res4_mod_sp = "% de probabilidad de que la biopsia no demuestre cáncer</td>"   
    
    res5_en = "</tr><tr>
    <td colspan=6>Please consult your physician concerning these results.</td>"
    #</tr>
    #</table>"
    
    div_en = "<div style='display: inline-block; height:100%; width:95%'>"
    # div_sp = ifelse(globalLanguage,"<div data-display-if='(input.lang%2)' style='display: inline-block; height:100%'>","<div data-display-if='!(input.lang%2)' style='display: inline-block; height:100%'>")
    div_end = "</div>"
    

    div_en_start = "<td width='30%' height=400 valign='top'><div style='display: inline-block; height:100%; width:95%'><table height=80% width=80%>"
    div_en_end = "</table></div></td>"
    
    # htmlString_en1 = paste(div_en_start, "<h4>Age + Familty History</h4>", res1_en,risk[3],res2_en,risk[2],res3_en,risk[1],res4_en,div_en_end, sep="")
    # htmlString_en2 = paste(div_en_start, "<h4>Age + Familty History + Prompt</h4>", res1_en,risk[6],res2_en,risk[5],res3_en,risk[4],res4_en,div_en_end, sep="")
    # htmlString_en3 = paste(div_en_start, "<h4>Age + PSA + DRE</h4>", res1_en,risk[9],res2_en,risk[8],res3_en,risk[7],res4_en,div_en_end, sep="")
    # htmlString_en4 = paste(div_en_start, "<h4>Age + PSA + DRE + Prompt</h4>", res1_en,risk[12],res2_en,risk[11],res3_en,risk[10],res4_en,div_en_end, sep="")
    # 
    # htmlString = paste(res_en, "<table><tr>")
    # htmlString = paste(htmlString, htmlString_en1)
    # htmlString = paste(htmlString, htmlString_en2)
    # htmlString = paste(htmlString, "<tr>")
    # htmlString = paste(htmlString, htmlString_en3)
    # htmlString = paste(htmlString, htmlString_en4)
    # htmlString = paste(htmlString, "</tr></table>")
    
    htmlString = paste(res_en, "<table><tr>", res1_en,res2_en,res3_en,res4_en, res5_en, "</tbody></tr>", sep="")

    plot_100 = function(n) {
        counter = 1
        i = n
        htmlString = ""
        risk1 = round(risk[1+(n-1)*3] / 10)
        risk2 = round(risk[2+(n-1)*3] / 10)
        risk3 = 100-risk1-risk2
        
        if(risk1 > 0){
            for(i in 1:risk1){
                htmlString = paste(htmlString,greenFace,sep="")
                if(counter %% 10 == 0 & counter != 100){
                    htmlString = paste(htmlString,"</tr><tr>",sep="")
                }
                counter = counter + 1
            }
        }
        if(risk2 > 0){
            for(i in seq_len(risk2)){
                htmlString = paste(htmlString,yellowFace,sep="")
                if(counter %% 10 == 0 & counter != 100){
                    htmlString = paste(htmlString,"</tr><tr>",sep="")
                }
                counter = counter + 1
            }
        }
        if(risk3 > 0){
            for(i in seq_len(risk3)){
                htmlString = paste(htmlString,redFace,sep="")
                if(counter %% 10 == 0 & counter != 100){
                    htmlString = paste(htmlString,"</tr><tr>",sep="")
                }
                counter = counter + 1
            }
        }
        htmlString
    }
    

    
    htmlString = paste(htmlString, "<tr>", "<td colspan=3><h4>Age + Family History (", risk[1]/10, "%N, ", risk[2]/10, "%L, ", risk[3]/10, "%H)", 
                       "</h4></td><td colspan=3><h4>Age + Family History + Prompt (", risk[4]/10, "%N, ", risk[5]/10, "%L, ", risk[6]/10, "%H)",
                       "</h4></td>", sep="")
    htmlString = paste(htmlString, "<tr><td colspan=3><table><tbody><tr>", plot_100(1), "</tr></tbody></table></td>", "<td colspan=3><table><tbody><tr>", plot_100(2), "</tr></tbody></table></td></tr>")
    htmlString = paste(htmlString, "<tr>", "<td colspan=3><h4>Age + Family History + PSA + DRE (", risk[7]/10, "%N, ", risk[8]/10, "%L, ", risk[9]/10, "%H)", 
                       "</h4></td><td colspan=3><h4>Age + Family History + PSA + DRE + Prompt (", risk[10]/10, "%N, ", risk[11]/10, "%L, ", risk[12]/10, "%H)", 
                       "</h4></td>", sep="")
    htmlString = paste(htmlString, "<tr><td colspan=3><table><tbody><tr>", plot_100(3), "</tr></tbody></table></td>", "<td colspan=3><table><tbody><tr>", plot_100(4), "</tr></tbody></table></td></tr>")
    htmlString = paste(htmlString, "<tr>", "<td colspan=3><h4>Age + Family History + PSA + DRE (Toronto) (",risk[13]/10, "%N, ", risk[14]/10, "%L, ", risk[15]/10, "%H)",
                       "</h4></td><td colspan=3><h4>Age + Family History + PSA + DRE + Prompt (Toronto) (", risk[16]/10, "%N, ", risk[17]/10, "%L, ", risk[18]/10, "%H)",
                       "</h4></td>", sep="")
    htmlString = paste(htmlString, "<tr><td colspan=3><table><tbody><tr>", plot_100(5), "</tr></tbody></table></td>", "<td colspan=3><table><tbody><tr>", plot_100(6), "</tr></tbody></table></td></tr>")
    htmlString = paste(htmlString, "</tr></table>", sep="")
    
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


