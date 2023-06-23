library(dplyr)
library(ggplot2)
library(httr)
library(jsonlite)
library(readr)

adi <- read_csv("adi.csv", show_col_types = FALSE)
adi = adi %>% 
    mutate(adi_natrank = as.numeric(adi_natrank)) %>% 
    filter(!is.na(adi_natrank))

adult_koops = read_csv("Map.Adult_KOOPS.csv", show_col_types = FALSE)

# function model 1
predict.func1 <- expression({
    bmi = bmi**2
    -21.61855 + 0.65967735 * baseline_func + 0.22447953 * baseline_mcs - 
        0.0049779862 * bmi + 0.42516094 * educ_yrs + 2.8028656 * 
        (gender == "Male") - 0.10572501 * ADI_national
})
# function model 2
predict.func2 <- expression({
    13.706942 + 0.66200886 * baseline_func + 0.21091679 * baseline_mcs - 
        1.8329744 * bmi + 0.022518571 * bmi**2 + 0.3976305 * educ_yrs + 
        2.6541634 * (gender == "Male") - 0.10616847 * ADI_national - 
        2.8270326 * naveen_4level_mtp2 - 5.9819618 * (tearside == "Lateral") - 
        2.8923361 * (tearside == "Both")
})
# function model 3
predict.func3 <- expression({
    7.0104244 + 0.66793642 * baseline_func + 0.22209455 * baseline_mcs - 
        1.8128867 * bmi + 0.022167764 * bmi**2 + 0.48536649 * 
        educ_yrs + 3.3356645 * (gender == "Male") - 0.099825159 * 
        ADI_national - 7.7261823 * (align_tf_surgery == "Varus") - 
        3.1201379 * (align_tf_surgery == "Valgus")
})
# function model 4
predict.func4 <- expression({
    12.849872 + 0.66733005 * baseline_func + 0.21022142 * baseline_mcs - 
        1.823214 * bmi + 0.022455857 * bmi**2 + 0.44971885 * educ_yrs + 
        2.7264886 * (gender == "Male") - 0.10346466 * ADI_national - 
        2.3848125 * naveen_4level_mtp2 - 5.9798736 * (tearside == "Lateral") - 
        2.6717676 * (tearside == "Both") - 6.5905161 * 
        (align_tf_surgery == "Varus") - 2.6234344 * (align_tf_surgery == "Valgus")
})

# pain model 1
predict.pain1 <- expression({
    79.77677 - 0.66072093 * baseline_pain + 0.24776562 * baseline_mcs - 
        1.575517 * bmi + 0.018043166 * bmi**2 - 2.3013967 * (insurancetype2 == "Medicare/Private") + 
        0.060609825 * ADI_national - 0.002040452 * 
        ADI_national**2
})
# pain model 2
predict.pain2 <- expression({
    86.597995 - 0.6683537 * baseline_pain + 0.23344555 * baseline_mcs - 
        1.5676029 * bmi + 0.0182338 * bmi**2 - 2.029567 * (insurancetype2 == "Medicare/Private") + 
        0.056913022 * ADI_national - 0.0020242185 * 
        ADI_national**2 - 3.6224929 * naveen_4level_mtp2 - 5.9983944 * 
        (tearside == "Lateral") - 2.0666274 * (tearside == "Both")
})
# pain model 3
predict.pain3 <- expression({
    81.62149 - 0.66682238 * baseline_pain + 0.24839316 * baseline_mcs - 
        1.5530374 * bmi + 0.017887565 * bmi**2 - 2.5902808 * (insurancetype2 == "Medicare/Private") + 
        0.038046902 * ADI_national - 0.0017799973 * 
        ADI_national**2 - 7.9506342 * (align_tf_surgery == "Varus") - 
        4.4413723 * (align_tf_surgery == "Valgus")
})
# pain model 4
predict.pain4 <- expression({
    87.910149 - 0.67188232 * baseline_pain + 0.23600932 * baseline_mcs - 
        1.5812886 * bmi + 0.018510832 * bmi**2 - 2.277222 * (insurancetype2 == "Medicare/Private") + 
        0.03748029 * ADI_national - 0.0017919422 * 
        ADI_national**2 - 3.1830483 * naveen_4level_mtp2 - 5.8966375 * 
        (tearside == "Lateral") - 1.6411236 * (tearside == "Both") - 
        6.2899497 * (align_tf_surgery == "Varus") - 3.9272384 * 
        (align_tf_surgery == "Valgus")
})

# pass model 1
predict.pass1 <- expression({
    lp = 2.5693592 - 0.055806663 * baseline_func + 0.026956203 * diff_func_pred1 + 
        0.00056117487 * diff_func_pred1**2
    100 / (1+exp(-lp))
})
# pass model 2
predict.pass2 <- expression({
    lp = 2.5805109 - 0.061113357 * baseline_func + 0.04276802 * diff_func_pred2 + 
        0.00042931206 * diff_func_pred2**2;
    100 / (1+exp(-lp))
})
# pass model 3
predict.pass3 <- expression({
    lp = 2.6071676 - 0.059697767 * baseline_func + 0.034908158 * diff_func_pred3 + 
        0.00054410054 * diff_func_pred3**2
    100 / (1+exp(-lp))
})
# pass model 4
predict.pass4 <- expression({
    lp = 2.6120409 - 0.062968152 * baseline_func + 0.045237756 * diff_func_pred4 + 
        0.00044701135 * diff_func_pred4**2
    100 / (1+exp(-lp))
})

shinyServer(function(input, output, session) {
    observeEvent({list(input$baseline_pain, input$baseline_func, input$baseline_mcs, 
                       input$bmi, input$educ_yrs, input$insurancetype2, input$gender, 
                       input$naveen_4level_mtp, input$tearside,
                       input$align_tf_surgery)},
                 {
                     shinyjs::hide("result_panel")
                 })
    
    observeEvent(input$goButton, {shinyjs::show('result_panel')})
    
    
    ADIHolder <- reactiveVal(NULL)
    
    observeEvent(input$find_address, {
        params = list(address = input$my_address, benchmark = "Public_AR_Current", format = "json", vintage = "Current_Current", layers = "10")
        resp = GET("https://geocoding.geo.census.gov/geocoder/geographies/onelineaddress", query = params)
        if (resp$status_code == 200) {
            json_content <- fromJSON(content(resp, as = "text"))
            if (length(json_content$result$addressMatches) != 0) {
                geoid = json_content$result$addressMatches$geographies$`Census Block Groups`[[1]]$GEOID[1]
                if (geoid %in% adi$fips_code) {
                    ADIHolder(adi[adi$fips_code==geoid,]$adi_natrank[1])
                } else {
                    geoid = substr(geoid, 1, 11)
                    adi_natrank = adi %>% mutate(fips = substr(fips_code, 1, 11)) %>% filter(fips == geoid) %>% summarise(adi_natrank = mean(adi_natrank)) %>% pull(adi_natrank)
                    ADIHolder(adi_natrank)
                }
                adi_value = ADIHolder()
                output$address_output = renderText(paste("Matched Address: ", json_content$result$addressMatches$matchedAddress[1], "; National ADI: ", adi_value, sep=""))
                return()
            }
        }
        output$address_output = renderText("Please enter a valid US address. It is important to note that some addresses may not have been recorded in previous census, so please consider providing a nearby address as an alternative.")
        updateTextInput(session, "my_address", value = "")
        ADIHolder(NULL)
    })

    # input
    data <- eventReactive(input$goButton, {
        
        # validate the inputs
        if (input$metric == "English") {
            shiny::validate(need(!is.na(input$height_feet) & input$height_feet>=0 & input$height_feet <=10, 'Please input a valid feet'))
            shiny::validate(need(!is.na(input$height_inch) & input$height_inch>=0 & input$height_inch <12, 'Please input a valid inch'))
            shiny::validate(need(!is.na(input$weight_pound) & input$weight_pound>=60 & input$weight_pound <=500, 'Please input a valid weight'))
        } else {
            shiny::validate(need(!is.na(input$height_cm) & input$height_cm>=80 & input$height_cm <=240, 'Please input a valid height'))
            shiny::validate(need(!is.na(input$weight_kg) & input$weight_kg>=30 & input$weight_kg <=250, 'Please input a valid weight'))
        }
        shiny::validate(need(!is.na(input$educ_yrs) & input$educ_yrs>=5 & input$educ_yrs <=24, 'Please input a valid number of years of schooling'))
        shiny::validate(need(!is.null(input$pat0_koos_p1),'Please complete questions ask for your view about your knee'))
        shiny::validate(need(!is.null(input$pat0_koos_p2),'Please complete questions ask for your view about your knee'))
        shiny::validate(need(!is.null(input$pat0_koos_p3),'Please complete questions ask for your view about your knee'))
        shiny::validate(need(!is.null(input$pat0_koos_p4),'Please complete questions ask for your view about your knee'))
        shiny::validate(need(!is.null(input$pat0_koos_p5),'Please complete questions ask for your view about your knee'))
        shiny::validate(need(!is.null(input$pat0_koos_p6),'Please complete questions ask for your view about your knee'))
        shiny::validate(need(!is.null(input$pat0_koos_p7),'Please complete questions ask for your view about your knee'))
        shiny::validate(need(!is.null(input$pat0_koos_p8),'Please complete questions ask for your view about your knee'))
        shiny::validate(need(!is.null(input$pat0_koos_p9),'Please complete questions ask for your view about your knee'))
        shiny::validate(need(!is.null(input$pat0_koosps_1),'Please complete questions concern your level of function'))
        shiny::validate(need(!is.null(input$pat0_koosps_2),'Please complete questions concern your level of function'))
        shiny::validate(need(!is.null(input$pat0_koosps_3),'Please complete questions concern your level of function'))
        shiny::validate(need(!is.null(input$pat0_koosps_4),'Please complete questions concern your level of function'))
        shiny::validate(need(!is.null(input$pat0_koosps_5),'Please complete questions concern your level of function'))
        shiny::validate(need(!is.null(input$pat0_koosps_6),'Please complete questions concern your level of function'))
        shiny::validate(need(!is.null(input$pat0_koosps_7),'Please complete questions concern your level of function'))
        shiny::validate(need(!is.null(input$pat0_vr12_1),'Please complete questions concern your mental health'))
        shiny::validate(need(!is.null(input$pat0_vr12_2a),'Please complete questions concern your mental health'))
        shiny::validate(need(!is.null(input$pat0_vr12_2b),'Please complete questions concern your mental health'))
        shiny::validate(need(!is.null(input$pat0_vr12_3a),'Please complete questions concern your mental health'))
        shiny::validate(need(!is.null(input$pat0_vr12_3b),'Please complete questions concern your mental health'))
        shiny::validate(need(!is.null(input$pat0_vr12_4a),'Please complete questions concern your mental health'))
        shiny::validate(need(!is.null(input$pat0_vr12_4b),'Please complete questions concern your mental health'))
        shiny::validate(need(!is.null(input$pat0_vr12_5),'Please complete questions concern your mental health'))
        shiny::validate(need(!is.null(input$pat0_vr12_6a),'Please complete questions concern your mental health'))
        shiny::validate(need(!is.null(input$pat0_vr12_6b),'Please complete questions concern your mental health'))
        shiny::validate(need(!is.null(input$pat0_vr12_6c),'Please complete questions concern your mental health'))
        shiny::validate(need(!is.null(input$pat0_vr12_7),'Please complete questions concern your mental health'))
        
        
        adi_value = ADIHolder()
        shiny::validate(need(!is.null(adi_value), "Please input a valid US address"))
        shiny::validate(need(!is.null(input$naveen_4level_mtp), "Please select a valid cartilage status"))
        shiny::validate(need(!is.null(input$tearside), "Please select a valid tearside"))
        
        baseline_pain = 100 - 100 * (as.numeric(input$pat0_koos_p1) + as.numeric(input$pat0_koos_p2) + as.numeric(input$pat0_koos_p3) + as.numeric(input$pat0_koos_p4) + as.numeric(input$pat0_koos_p5) + as.numeric(input$pat0_koos_p6) + as.numeric(input$pat0_koos_p7) + as.numeric(input$pat0_koos_p8) + as.numeric(input$pat0_koos_p9)) / (9*4)
        mcs_func = function(gh1, pf02, pf04, rp2, rp3, re2, re3, bp2, mh3, vt2, mh4, sf2) {
            gh1 = c(100,85,60,35,0)[c(1,2,3,4,5)==as.numeric(gh1)]
            pf02 = (as.numeric(pf02)-1) * 50
            pf04 = (as.numeric(pf04)-1) * 50
            rp2 = (5-as.numeric(rp2)) * 25
            rp3 = (5-as.numeric(rp3)) * 25
            re2 = (5-as.numeric(re2)) * 25
            re3 = (5-as.numeric(re3)) * 25
            bp2 = (5-as.numeric(bp2)) * 25
            mh3 = (6-as.numeric(mh3)) * 20
            vt2 = (6-as.numeric(vt2)) * 20
            mh4 = (as.numeric(mh4)-1) * 20
            sf2 = (as.numeric(sf2)-1) * 25
            -0.000915925018489361*gh1 + 
                -0.0354986488819122*pf02 + 
                -0.0315771400928497*pf04 + 
                -0.0251735001802444*rp2 + 
                -0.0246522277593613*rp3 + 
                0.126686096191406*re2 + 
                0.0808723568916321*re3 + 
                -0.0243713706731796*bp2 + 
                0.109408497810364*mh3 + 
                0.0694271326065063*vt2 + 
                0.149378895759583*mh4 + 
                0.108573436737061*sf2 + 
                12.6620483398438
        }
        baseline_mcs = mcs_func(input$pat0_vr12_1, input$pat0_vr12_2a, input$pat0_vr12_2b, input$pat0_vr12_3a, input$pat0_vr12_3b, input$pat0_vr12_4a, input$pat0_vr12_4b, input$pat0_vr12_5, input$pat0_vr12_6a, input$pat0_vr12_6b, input$pat0_vr12_6c, input$pat0_vr12_7)
        baseline_func = as.numeric(input$pat0_koosps_1)+as.numeric(input$pat0_koosps_2)+as.numeric(input$pat0_koosps_3)+as.numeric(input$pat0_koosps_4)+as.numeric(input$pat0_koosps_5)+as.numeric(input$pat0_koosps_6)+as.numeric(input$pat0_koosps_7)
        baseline_func = adult_koops$KOOSPS_PF[adult_koops$KOOSPS_RAW == baseline_func]
        baseline_pain = round(baseline_pain, 1)
        baseline_mcs = round(baseline_mcs, 1)
        baseline_func = round(baseline_func, 1)
        output$baseline_output = renderText(paste("baseline pain score: ", baseline_pain, ", baseline mcs score: ", baseline_mcs, ", baseline function score: ", baseline_func, sep=""))
        
        # clean inputs
        naveen_4level_mtp2 = ifelse(
          ("2 cm or larger in size (large)" %in% input$naveen_4level_mtp) | sum(input$naveen_4level_mtp == "1 cm to less than 2 cm in size (moderate)") == 2,
          3,
          ifelse(
            ("1 cm to less than 2 cm in size (moderate)" %in% input$naveen_4level_mtp) | (("2 mm to less than 1 cm in size (small)" %in% input$naveen_4level_mtp) & ("Less than 1 cm in size (small)" %in% input$naveen_4level_mtp)),
            2,
            ifelse(
              ("1 cm or larger in size" %in% input$naveen_4level_mtp) | ("2 mm to less than 1 cm in size (small)" %in% input$naveen_4level_mtp) | ("Less than 1 cm in size (small)" %in% input$naveen_4level_mtp),
              1, 0
            )
          )
        )
        # naveen_4level_mtp2 = ifelse(input$naveen_4level_mtp == "Negligible", 1,
        #                            ifelse(input$naveen_4level_mtp == "Mild", 2,
        #                                   ifelse(input$naveen_4level_mtp == "Moderate", 3,4)))
        if (input$metric == "English") {
            bmi = input$weight_pound / (input$height_feet*12 + input$height_inch)^2 * 703
        } else (
            bmi = input$weight_kg / (input$height_cm/100)^2
        )
        
        
        # create data frame from input
        data <- data.frame(baseline_func = baseline_func,
                           baseline_pain = baseline_pain,
                           baseline_mcs = baseline_mcs,
                           bmi = bmi,
                           educ_yrs = input$educ_yrs,
                           insurancetype2 = input$insurancetype2,
                           gender = input$gender,
                           ADI_national = adi_value,
                           naveen_4level_mtp2 = naveen_4level_mtp2,
                           tearside = input$tearside)
        data})

    # output table
    output$result <- DT::renderDataTable({
        data = data()
        

        predict_pain = round(eval(predict.pain2, data), 0)
        predict_func = round(eval(predict.func2, data), 0)
        data$diff_func_pred2 = eval(predict.func2, data)
        predict_pass = eval(predict.pass2, data)
        
        
        res = data.frame(
            Result = c("Predicted change in pain score",
                       "Predicted change in function score",
                       "Predicted probability of pass"),
            Value = c(ifelse(predict_pain < 1, "<1", ifelse(predict_pain > 99, ">99", predict_pain)),
                      ifelse(predict_func < 1, "<1", ifelse(predict_func > 99, ">99", predict_func)),
                      ifelse(predict_pass < 1, "<1%", ifelse(predict_pass > 99, ">99%", paste(round(predict_pass,1), "%", sep=""))))
        )
        
        res
    }, options = list(
        pageLength = 10,
        lengthMenu = 0,
        
        searching = 0,
        processing = 0,
        info = 0,
        paging = 0,
        initComplete = I(
            "function(settings, json) {
                    $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
            }")))
    
    output$plot <- renderPlot({
        data = data()
        
        plot_pass = c()
        plot_func = c()
        
        predict_func = round(eval(predict.func2, data), 0)
        data$diff_func_pred2 = eval(predict.func2, data)
        predict_pass = eval(predict.pass2, data)
        plot_func = seq(min(-40, predict_func), max(80, predict_func))
        for (i in plot_func) {
            data$diff_func_pred2 = i
            plot_pass = c(plot_pass, eval(predict.pass2, data))
        }
        
        data.frame(
            plot_pass = plot_pass,
            plot_func = plot_func,
            y = 1
        ) %>% 
            ggplot(aes(x = plot_func, y = y, fill = plot_pass)) +
            geom_tile(alpha = 0.75, height = 0.1) +      
            scale_fill_gradient2(low='red', high='green', mid = 'yellow',midpoint = 50, limits=c(0,100)) +
            scale_y_continuous(limits = c(0.95,1.05))+
            scale_x_continuous(breaks = seq(-100, 100, 20)) +
            theme_minimal() +
            theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                  panel.border = element_blank(),axis.text.y = element_blank()) +
            labs(x = "Change in function score", y = "",
                 fill = "Probability of PASS") +
            geom_vline(xintercept = predict_func, linetype="dashed", 
                       color = "blue", size=1.5)
    }, res = 96)
})
