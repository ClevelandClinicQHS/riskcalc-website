predict.tmc <- expression({
    lp <- MeanPreVol * MeanPreConc * MeanPreMotil/100
})
predict.sperm.concentration <- expression({
    lp <- exp(0.87392055 + 
                  0.22152682 * LVariGrade + 
                  0.096188016 * MeanPreConc - 
                  0.000049966254 * max(MeanPreConc - 2.84, 0)**3 + 
                  0.000063445113 * max(MeanPreConc - 14.325,0)**3 - 
                  0.000013478859 * max(MeanPreConc - 56.9, 0)**3 +
                  0.0085200656 * MeanPreMotil)
})
predict.sperm.morphology <- expression({
    lp <- exp(2.3769984 - 
                  0.012052008 * AgeYr - 
                  0.15600212 * RVariGrade - 
                  0.050088411 * MeanPreVol + 
                  0.0015557703 * MeanPreConc +
                  0.064033056 * MeanPreMorph - 
                  
                  0.000023034956 * max(MeanPreMorph - 5, 0)**3 + 
                  0.000031673065 * max(MeanPreMorph - 20, 0)**3 - 
                  0.0000086381087 * max(MeanPreMorph - 60, 0)**3)
})
predict.sperm.motility <- expression({
    lp <- exp(1.6959765+0.019159797*AgeYr - 
                  0.00023056183*max(AgeYr -30,0)**3+
                  0.00037466297*max(AgeYr -35,0)**3-
                  0.00014410114*max(AgeYr -43,0)**3+
                  0.084804163*LVariGrade +
                  0.030560285*MeanPreMotil -
                  0.000014686346*max(MeanPreMotil -9.02,0)**3+
                  0.000022523028*max(MeanPreMotil -22.2,0)**3-
                  0.0000078366819*max(MeanPreMotil -46.9,0)**3+
                  0.0061006229*MeanPreMorph +
                  0.0012712082*MeanPreVol *MeanPreConc *MeanPreMotil/100)
})
predict.sperm.volume <- expression({
    lp <- exp(0.095225408 + 
                  0.066425491 * RVariGrade + 
                  0.33407308 * MeanPreVol - 
                  0.01763797 * max(MeanPreVol - 1.5, 0)**3 + 
                  0.028060407 * max(MeanPreVol - 2.8, 0)**3 - 
                  0.010422437 * max(MeanPreVol - 5, 0)**3)
})
predict.motile.count <- expression({
    lp <- exp(-0.67118076 + 
                  0.3078216 * LVariGrade + 
                  0.15905147 * MeanPreVol + 
                  0.097359869 * MeanPreConc - 
                  0.00005102786 * max(MeanPreConc - 2.84, 0)**3 + 
                  0.000064793098 * max(MeanPreConc - 14.325, 0)**3 - 
                  0.000013765237 * max(MeanPreConc - 56.9, 0)**3 + 
                  0.029280634 * MeanPreMotil)
})

library(shiny)
shinyServer(function(input, output) {
    data <- eventReactive(input$goButton, {
        validate(need(
            !is.na(as.numeric(input$AgeYr)) &
                as.numeric(input$AgeYr) >= 20 &
                as.numeric(input$AgeYr) <= 65,
            'Please input a valid AgeYr'
        ))
        AgeYr = as.numeric(input$AgeYr)
        LVariGrade = as.numeric(as.character(input$LVariGrade))
        RVariGrade = as.numeric(as.character(input$RVariGrade))
        validate(
            need(
                !is.na(as.numeric(input$MeanPreConc)) &
                    as.numeric(input$MeanPreConc) >= 0 &
                    as.numeric(input$MeanPreConc) <= 200,
                'Please input a valid MeanPreConc'
            )
        )
        MeanPreConc = as.numeric(input$MeanPreConc)
        validate(
            need(
                !is.na(as.numeric(input$MeanPreVol)) &
                    as.numeric(input$MeanPreVol) >= 0.2 &
                    as.numeric(input$MeanPreVol) <= 9.5,
                'Please input a valid MeanPreVol'
            )
        )
        MeanPreVol = as.numeric(input$MeanPreVol)
        validate(
            need(
                !is.na(as.numeric(input$MeanPreMorph)) &
                    as.numeric(input$MeanPreMorph) >= 0 &
                    as.numeric(input$MeanPreMorph) <= 90,
                'Please input a valid MeanPreMorph'
            )
        )
        MeanPreMorph = as.numeric(input$MeanPreMorph)
        validate(
            need(
                !is.na(as.numeric(input$MeanPreMotil)) &
                    as.numeric(input$MeanPreMotil) >= 0.6 &
                    as.numeric(input$MeanPreMotil) <= 100,
                'Please input a valid MeanPreMotil'
            )
        )
        MeanPreMotil = as.numeric(input$MeanPreMotil)
        data <- data.frame(
            AgeYr = AgeYr,
            LVariGrade = LVariGrade,
            RVariGrade = RVariGrade,
            MeanPreConc = MeanPreConc,
            MeanPreVol = MeanPreVol,
            MeanPreMorph = MeanPreMorph,
            MeanPreMotil = MeanPreMotil
        )
        data
    })
    output$result <- renderDataTable({
        data = data()
        tmc <- paste(ifelse(round(eval(predict.tmc, data), 2) < 1, "<1", ifelse(round(eval(predict.tmc, data), 2) > 99, ">99", round(eval(predict.tmc, data), 2))), "million")
        sperm.concentration <- paste(
            ifelse(round(eval(predict.sperm.concentration, data), 2) < 1, "<1", ifelse(round(eval(predict.sperm.concentration, data), 2) > 99, ">99", round(eval(predict.sperm.concentration, data), 2))), "million/mL")
        sperm.morphology <- paste(ifelse(round(eval(predict.sperm.morphology, data), 0) < 1, "<1", ifelse(round(eval(predict.sperm.morphology, data), 0) > 99, ">99", round(eval(predict.sperm.morphology, data), 0))), "%")
        sperm.motility <- paste(ifelse(round(eval(predict.sperm.motility, data), 0) < 1, "<1", ifelse(round(eval(predict.sperm.motility, data), 0) > 99, ">99", round(eval(predict.sperm.motility, data), 0))), "%")
        sperm.volume <- paste(ifelse(round(eval(predict.sperm.volume, data), 2) < 1, "<1", ifelse(round(eval(predict.sperm.volume, data), 2) > 99, ">99", round(eval(predict.sperm.volume, data), 2))), "mL")
        motile.count <- paste(ifelse(round(eval(predict.motile.count, data), 2) < 1, "<1", ifelse(round(eval(predict.motile.count, data), 2) > 99, ">99", round(eval(predict.motile.count, data), 2))), "million")
        res = data.frame(
            Result = c(
                "Pre-repair TMC",
                "Sperm Concentration",
                "Sperm Morphology",
                "Sperm Motility",
                "Sperm Volume",
                "Total Motile Count"
            ),
            Prediction = c(
                tmc,
                sperm.concentration,
                sperm.morphology,
                sperm.motility,
                sperm.volume,
                motile.count
            )
        )
        res
    }, options = list(
            pageLength = 10,
            lengthMenu = 0,
            
            searching = 0,
            info = 0,
            paging = 0,
        initComplete = I(
            "function(settings, json) {
            $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
}"
)
        ))
})
