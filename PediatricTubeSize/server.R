library(dplyr)
library(kableExtra)

server <- function(input, output) {
    
    output$OICalculation =  renderText({
        prettyNum(input$MAP * input$FiO2 / input$PaO2, big.mark=",", digits=3)
    })
    
    output$MAPCalculation =  renderText({
        prettyNum(formatC(input$Freq * input$Ti / 60 * (input$PIP - input$PEEP) + input$PEEP, format = 'g', digits = 4), big.mark=",")
    })
    
    output$PICUInfo = function() {
        ETTSize = (input$Age + 16) / 4
        ETTDepth = ETTSize * 3
        Stylet = ifelse(ETTSize < 5.5, "6 Fr", "14 Fr")
        CO2Detector = ifelse(input$Weight < 15, "Pedi-Cap", "EZ-Cap")
        LMA = case_when(input$Weight < 5    ~ "NA",
                        input$Weight < 10   ~ "1",
                        input$Weight < 20   ~ "1.5",
                        input$Weight < 30   ~ "2",
                        input$Weight < 50   ~ "2.5",
                        input$Weight < 70   ~ "3",
                        input$Weight < 100  ~ "4",
                        input$Weight >= 100 ~ "5")
        dta = data.frame(
            V1 = c("ETT Size", "Depth of ETT insertion lip to tip", "cuffed", "uncuffed", "Stylet", HTML('CO<sub>2</sub> Detector'), "LMA", "Suction Catheter"),
            V2 = c(ETTSize, ETTDepth, ETTSize - 0.5, ETTSize, Stylet, CO2Detector, LMA, paste(ETTSize*2, "Fr")),
            V3 = c('', '', ETTSize, ETTSize + 0.5, '', '', '', '')
        ) %>% 
        kable(format = "html", escape = F, col.names = NULL, align = 'lcc', digits = 2) %>% 
            kable_styling("striped", "responsive") %>%
            column_spec(1:3, bold = T) %>%
            pack_rows("Recommended Tube kit contents", 3, 7, label_row_css = "background-color: #d7f3fa; color: #000;")
    }
    
    output$PICUVent = function() {
        rate = case_when(input$Age < 1   ~ "NA",
                         input$Age < 4   ~ '20-30',
                         input$Age < 12  ~ '15-20',
                         input$Age < 20  ~ '12-15',
                         input$Age >= 20 ~ '10-12')
        Ti = case_when(input$Age < 1   ~ "NA",
                       input$Age < 4   ~ '0.5-0.6',
                       input$Age < 12  ~ '0.6-0.8',
                       input$Age < 20  ~ '0.8-1.0',
                       input$Age >= 20 ~ '1.0-1.2')
        dta = data.frame(
            V1 = c("Mode", "Rate", "PC setting", "Target Vt", "PEEP", "FiO<sub>2</sub>", "Ti"),
            V2 = c("SIMV-PC/PS or SIMV PRVC/PS", paste(rate, "mandatory breaths per minute"), "Titrate to achieve exh. Vt of 6-8mL/kg", paste('<font color="red">6mL/kg:</font>', input$Weight * 6, '  <font color="red">8mL/kg:</font>', input$Weight * 8), "5-8cm H<sub>2</sub>O (use higher PEEP if lungs are stiff)", "Titrate to maintain SpO<sub>2</sub> > 90%", paste(Ti, "seconds"))
        ) %>% 
            kable(format = "html", escape = F, col.names = NULL, align = 'rl', digits = 2) %>% 
            kable_styling("striped", "responsive") %>%
            column_spec(1, border_right = "1px dotted lightgray", bold = T) %>% 
            column_spec(2, bold = T)
    }
    
    output$aerosol = function() {
        alb = round(input$albutoroldose / 5 * input$hour, 2)
        output = c(30, 5, 8, 10, 25, 4, 20)
        NS = round(output * input$hour - alb, 2)
        dta = data.frame(
            V1 = c("Device", "AirLife Misty Finity", "Aeroneb neonate", "Aeroneb pediatric", "Aeroneb adolesant", "IV Heart", "Uni Heart", "Mini Heart"),
            V2 = c("4H Alb", rep(alb, 7)),
            V3 = c("NS", NS),
            V4 = c("Flow", 11, "N/A", "N/A", "N/A", 10, 2, 8),
            V5 = c("output", output),
            V6 = c("Alb mg/mL", round(input$albutoroldose/output, 2))
        )%>% 
            kable(format = "html", escape = F, col.names = NULL, align = 'rccccc', digits = 2) %>% 
            kable_styling("striped", "responsive", full_width = F) %>%
            column_spec(1:5, border_right = "1px dotted lightgray", bold = T) %>% 
            column_spec(6, bold = T) %>% 
            row_spec(1, background = "#abe8f7")
    }
    
    output$NICUInfo = function() {
        ETTSizeAge = case_when(input$AgeNeo < 23  ~ 'NA',
                               input$AgeNeo < 28  ~ "2.5",
                               input$AgeNeo < 35  ~ "3",
                               input$AgeNeo < 44  ~ "3.5",
                               input$AgeNeo >= 44 ~ "3.5-4.0")
        ETTSizeWt = case_when(input$WeightNeo < 400   ~ "NA",
                              input$WeightNeo < 1000  ~ "2.5",
                              input$WeightNeo < 2000  ~ "3",
                              input$WeightNeo < 3000  ~ "3.5",
                              input$WeightNeo >= 3000 ~ "3.5-4.0")
        ETTDepth = input$WeightNeo /1000 + 6
        infasurfdose = input$WeightNeo * 3 /1000
        dta = data.frame(
            V1 = c("ETT Size", "Depth of ETT insertion lip to tip", "Infasurf dose", "Suction Catheter"),
            V2 = c(paste("By weight:", ETTSizeWt, "<br/>By GA:", ETTSizeAge), paste(ETTDepth, "cm"), paste(infasurfdose, "mL"), paste(as.numeric(ETTSizeWt)*2, "Fr"))
        ) %>% 
            kable(format = "html", escape = F, col.names = NULL, align = 'rc', digits = 2) %>% 
            kable_styling("striped", "responsive", full_width = F) %>%
            column_spec(1, border_right = "1px dotted lightgray", bold = T) %>% 
            column_spec(2, bold = T)
    }
    
    output$NICUVent = function() {
        peep = case_when(input$AgeNeo < 25 ~ "4",
                         input$AgeNeo < 28 ~ '5',
                         input$AgeNeo >= 28 ~ '5')
        dta = data.frame(
            V1 = c("Mode", "Rate", "PC setting", "Target Vt", "PEEP", "FiO<sub>2</sub>", "Ti"),
            V2 = c("SIMV-PC/PS", "set mandatory rate 30-40/min", "Titrate to achieve 4-6 mL/kg (set 15-20 cm H<sub>2</sub>O)", paste('<font color="red">4mL/kg:</font>', input$WeightNeo / 1000 * 4, '  <font color="red">6mL/kg:</font> ', input$WeightNeo / 1000 * 6), paste(peep, "cm H<sub>2</sub>O"), "Titrate to maintain SpO<sub>2</sub> > 90%", "0.3-0.35 sec")
        ) %>% 
            kable(format = "html", escape = F, col.names = NULL, align = 'rl', digits = 2) %>% 
            kable_styling("striped", "responsive") %>%
            column_spec(1, border_right = "1px dotted lightgray", bold = T) %>% 
            column_spec(2, bold = T)
    }
    
    output$cylinder = function() {
        v1 = input$psig * 0.283 / input$flow 
        v2 = input$psig * 3.14 / input$flow 
        v3 = input$psig * 0.283 / (input$flow * 1.6)
        v4 = input$psig * 3.14 / (input$flow * 1.8)
        dta = data.frame(
            V1 = c("O<sub>2</sub> E-cylinder", "O<sub>2</sub> H-cylinder", "70/30 HeOx E-cylinder", "70/30 HeOx H-cylinder"),
            V2 = c(paste(round(v1/60,2), "hours or", round(v1,1), 'minutes'),
                   paste(round(v2/60,2), "hours or", round(v2,1), 'minutes'),
                   paste(round(v3/60,2), "hours or", round(v3,1), 'minutes'),
                   paste(round(v4/60,2), "hours or", round(v4,1), 'minutes'))
        ) %>% 
            kable(format = "html", escape = F, col.names = NULL, align = 'rl', digits = 2) %>% 
            kable_styling("striped", "responsive", full_width = F) %>%
            column_spec(1, border_right = "1px dotted lightgray", bold = T) %>% 
            column_spec(2, bold = T)
    }
    
    output$cylinderDuration = renderText({
        v1 = ifelse(input$CylinderType == 'T', 8500, 6348)
        v2 = round(max(c((80/(100-input$o2) * ((input$CylinderPressure-250)/2000) * v1 / input$vapo), 0)), 0)
        HTML(c(paste(round(v2, 0), '(min)<br/>', floor(v2/60), ' hours ', v2%%60, ' minutes', sep = '')))
    })
}
