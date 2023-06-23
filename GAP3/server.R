load("./data.RData")
# source("./predictrms.s")
require(rms)
# predict.progression <- expression({
#     lp <-
#         0.023515626 * age - 0.0001011952 * max(age - 55, 0)**3 + 
#         0.00022768919 * max(age - 65, 0)**3 - 0.00012649399 * max(age - 73, 0)**3 + 
#         0.022569929 * Year.Of.Diagnosis.After1990 + 
#         0.00030527426 * max(Year.Of.Diagnosis.After1990 - 13, 0)**3 - 
#         0.00083950422 * max(Year.Of.Diagnosis.After1990 - 20, 0)**3 + 
#         0.00053422996 * max(Year.Of.Diagnosis.After1990 - 24, 0)**3 + 
#         0.1150706 * psa - 0.0030375769 * max(psa - 2.7, 0)**3 + 
#         0.0050379325 * max(psa - 5.4, 0)**3 - 0.0020003555 * max(psa - 9.5, 0)**3 + 
#         0.12245624 * nr_cores_ca - 0.16858288 * (gl_grade == "3+4") - 
#         0.1512798 * (gl_grade == "4+3")
#     lp
# })
# predict.ww <- expression({
#     lp <-
#         0.050275461 * age + 0.00029058029 * max(age - 55, 0)**3 - 
#         0.00065380566 * max(age - 65, 0)**3 + 0.00036322537 * max(age - 73, 0)**3 + 
#         0.17898451 * Year.Of.Diagnosis.After1990 - 
#         0.0016383191 * max(Year.Of.Diagnosis.After1990 - 13, 0)**3 + 
#         0.0045053776 * max(Year.Of.Diagnosis.After1990 - 20, 0)**3 - 
#         0.0028670585 * max(Year.Of.Diagnosis.After1990 - 24, 0)**3 + 
#         0.12103168 * psa - 0.0027610297 * max(psa - 2.7, 0)**3 + 
#         0.0045792687 * max(psa - 5.4, 0)**3 - 0.001818239 * max(psa - 9.5, 0)**3 - 
#         0.069198868 * nr_cores_ca - 0.63372705 * (gl_grade == "3+4") - 10.178801 * (gl_grade == "4+3")
#     lp
# })
# predict.choice <- expression({
#     lp <-
#         - 0.008558346 * age + 1.1027366e-05 * max(age - 55, 0)**3 - 
#         2.4811572e-05 * max(age - 65, 0)**3 + 1.3784207e-05 * max(age - 73, 0)**3 - 
#         0.072644901 * Year.Of.Diagnosis.After1990 + 
#         0.00018707597 * max(Year.Of.Diagnosis.After1990 - 13, 0)**3 - 
#         0.0005144589 * max(Year.Of.Diagnosis.After1990 - 20, 0)**3 + 
#         0.00032738294 * max(Year.Of.Diagnosis.After1990 - 24, 0)**3 + 
#         0.13678702 * psa - 0.0023929235 * max(psa - 2.7, 0)**3 + 
#         0.0039687512 * max(psa - 5.4, 0)**3 - 0.0015758277 * max(psa - 9.5, 0)**3 + 
#         0.032268439 * nr_cores_ca + 0.26757159 * (gl_grade == "3+4") + 0.85185627 * (gl_grade == "4+3")
#     lp
# })
# predict.death <- expression(({
#     lp <-
#         0.10709923 * age - 6.2197859e-05 * max(age - 55, 0)**3 + 
#         0.00013994518 * max(age - 65, 0)**3 - 7.7747324e-05 * max(age - 73, 0)**3 - 
#         0.082494074 * Year.Of.Diagnosis.After1990 - 
#         0.00064891932 * max(Year.Of.Diagnosis.After1990 - 13, 0)**3 + 
#         0.0017845281 * max(Year.Of.Diagnosis.After1990 - 20, 0)**3 - 
#         0.0011356088 * max(Year.Of.Diagnosis.After1990 - 24, 0)**3 - 
#         0.10666089 * psa + 0.0030504026 * max(psa - 2.7, 0)**3 - 
#         0.0050592042 * max(psa - 5.4, 0)**3 + 0.0020088017 * max(psa - 9.5, 0)**3 + 
#         0.044398918 * nr_cores_ca + 0.61328944 * (gl_grade == "3+4") + 1.0306154 * (gl_grade == "4+3")
#     lp
# }))

plot.stacked <- function(x,
                         y,
                         order.method = "as.is",
                         ylab = "",
                         xlab = "",
                         border = NULL,
                         lwd = 1,
                         col = rainbow(length(y[1, ])),
                         ylim = NULL,
                         ...) {
    if (sum(y < 0) > 0)
        error("y cannot contain negative numbers")
    
    if (is.null(border))
        border <- par("fg")
    border <- as.vector(matrix(border, nrow = ncol(y), ncol = 1))
    col <- as.vector(matrix(col, nrow = ncol(y), ncol = 1))
    lwd <- as.vector(matrix(lwd, nrow = ncol(y), ncol = 1))
    
    if (order.method == "max") {
        ord <- order(apply(y, 2, which.max))
        y <- y[, ord]
        col <- col[ord]
        border <- border[ord]
    }
    
    if (order.method == "first") {
        ord <- order(apply(y, 2, function(x)
            min(which(x > 0))))
        y <- y[, ord]
        col <- col[ord]
        border <- border[ord]
    }
    
    top.old <- x * 0
    polys <- vector(mode = "list", ncol(y))
    for (i in seq(polys)) {
        top.new <- top.old + y[, i]
        polys[[i]] <-
            list(x = c(x, rev(x)), y = c(top.old, rev(top.new)))
        top.old <- top.new
    }
    
    if (is.null(ylim))
        ylim <-
        range(sapply(polys, function(x)
            range(x$y, na.rm = TRUE)), na.rm = TRUE)
    plot(
        x,
        y[, 1],
        ylab = ylab,
        xlab = xlab,
        ylim = ylim,
        t = "n",
        ...
    )
    for (i in seq(polys)) {
        polygon(
            polys[[i]],
            border = border[i],
            col = col[i],
            lwd = lwd[i],
            ...
        )
    }
}


library(shiny)

shinyServer(function(input, output) {
    data <- reactive({
        # validate(need(!is.na(as.numeric(input$age)) &as.numeric(input$age) >= 40 &as.numeric(input$age) <= 80,'Please input a valid Age'))
        # age = as.numeric(input$age)
        gl_grade = ifelse(input$gl_grade == "6 or lower", "6", input$gl_grade)
        # validate(need(!is.na(as.numeric(input$Year.Of.Diagnosis)) &as.numeric(input$Year.Of.Diagnosis) >= 1990 &as.numeric(input$Year.Of.Diagnosis) <= 2017,'Please input a valid Year Of Diagnosis'))
        # Year.Of.Diagnosis.After1990 = as.numeric(input$Year.Of.Diagnosis) - 1990
        # validate(need(!is.na(as.numeric(input$psa)) &as.numeric(input$psa) >= 0 &as.numeric(input$psa) <= 30,'Please input a valid PSA'))
        # psa = as.numeric(input$psa)
        # validate(need(!is.na(as.numeric(input$nr_cores_ca)) &as.numeric(input$nr_cores_ca) >= 1 &as.numeric(input$nr_cores_ca) <= 30,'Please input a valid Number of cores with prostate cancer'))
        # nr_cores_ca = as.numeric(input$nr_cores_ca)
        data <- data.frame(
            age = input$age,
            gl_grade = gl_grade,
            Year.Of.Diagnosis.After1990 = 14,
            psa = input$psa,
            nr_cores_ca = input$nr_cores_ca
        )
        data
    })
    
    pstate <- reactive({
        data = data()
        cov1 <- predict(test.progression$cph.f,data,type="x")
        lhat.progression <- cumsum(exp(sum(cov1 * test.progression$coef))*test.progression$bfitj)
        lhat.progression <- cbind(test.progression$uftime,1-exp(-lhat.progression))
        cov2 <- predict(test.ww$cph.f,data,type="x")
        lhat.ww <- cumsum(exp(sum(cov2 * test.ww$coef))*test.ww$bfitj)
        lhat.ww <- cbind(test.ww$uftime,1-exp(-lhat.ww))
        cov3 <- predict(test.death$cph.f,data,type="x")
        lhat.death <- cumsum(exp(sum(cov3 * test.death$coef))*test.death$bfitj)
        lhat.death <- cbind(test.death$uftime,1-exp(-lhat.death))
        cov4 <- predict(test.choice$cph.f,data,type="x")
        lhat.choice <- cumsum(exp(sum(cov4 * test.choice$coef))*test.choice$bfitj)
        lhat.choice <- cbind(test.choice$uftime,1-exp(-lhat.choice))
        time = seq(0.26, 10, 0.01)
        pstate <- data.frame(
            progression = sapply(time, FUN = function(x) lhat.progression[max(which(lhat.progression[,1]<=x)), 2]),
            choice = sapply(time, FUN = function(x) lhat.choice[max(which(lhat.choice[,1]<=x)), 2]),
            ww = sapply(time, FUN = function(x) lhat.progression[max(which(lhat.ww[,1]<=x)), 2]),
            death = sapply(time, FUN = function(x) lhat.death[max(which(lhat.death[,1]<=x)), 2])
        )
        pstate$as = 1 - pstate$progression - pstate$choice - pstate$ww - pstate$death
        pstate = rbind(data.frame(progression = 0, choice = 0, ww = 0, death = 0, as = 0), pstate)
        pstate
    })
    
    output$result <- DT::renderDataTable({
        pstate = pstate()
        prob.progression.1yr <-
            paste(round(pstate$progression[length(pstate$progression) - 900], 3) * 100, "%")
        prob.progression.5yr <-
            paste(round(pstate$progression[length(pstate$progression) - 500], 3) * 100, "%")
        prob.progression.10yr <-
            paste(round(pstate$progression[length(pstate$progression)], 3) * 100, "%")
        prob.ww.1yr <-
            paste(round(pstate$ww[length(pstate$progression) - 900], 3) * 100, "%")
        prob.ww.5yr <-
            paste(round(pstate$ww[length(pstate$progression) - 500], 3) * 100, "%")
        prob.ww.10yr <-
            paste(round(pstate$ww[length(pstate$progression)], 3) * 100, "%")
        prob.choice.1yr <-
            paste(round(pstate$choice[length(pstate$progression) - 900], 3) * 100, "%")
        prob.choice.5yr <-
            paste(round(pstate$choice[length(pstate$progression) - 500], 3) * 100, "%")
        prob.choice.10yr <-
            paste(round(pstate$choice[length(pstate$progression)], 3) * 100, "%")
        prob.death.1yr <-
            paste(round(pstate$death[length(pstate$progression) - 900], 3) * 100, "%")
        prob.death.5yr <-
            paste(round(pstate$death[length(pstate$progression) - 500], 3) * 100, "%")
        prob.death.10yr <-
            paste(round(pstate$death[length(pstate$progression) - 900], 3) * 100, "%")
        prob.as.1yr <-
            round(pstate$as[length(pstate$progression) - 900], 3) * 100
        prob.as.1yr <- ifelse(prob.as.1yr > 0, paste(prob.as.1yr, "%"), "0 %")
        prob.as.5yr <-
            round(pstate$as[length(pstate$progression) - 500], 3) * 100
        prob.as.5yr <- ifelse(prob.as.5yr > 0, paste(prob.as.5yr, "%"), "0 %")
        prob.as.10yr <-
            round(pstate$as[length(pstate$progression)], 3) * 100
        prob.as.10yr <- ifelse(prob.as.10yr > 0, paste(prob.as.10yr, "%"), "0 %")
        res = data.frame(
            Result = c(
                "Remain on Active Surveillance",
                "Death from Other Cause",
                "Convert to Watchful Waiting",
                "Active Treatment",
                "Disease Progression"
            ),
            Probability.1yr = c(
                prob.as.1yr,
                prob.death.1yr,
                prob.ww.1yr,
                prob.choice.1yr,
                prob.progression.1yr
            ),
            Probability.5yr = c(
                prob.as.5yr,
                prob.death.5yr,
                prob.ww.5yr,
                prob.choice.5yr,
                prob.progression.5yr
            ),
            Probability.10yr = c(
                prob.as.10yr,
                prob.death.10yr,
                prob.ww.10yr,
                prob.choice.10yr,
                prob.progression.10yr
            )
            
        )
        colnames(res) <-
            c("Outcome", "1 year risk", "5 year risk", "10 year risk")
        res
    }, options = list(
        
        pageLength = 10,
        lengthMenu = 0,
        processing = 0,
        searching = 0,
        info = 0,
        paging = 0, columnDefs=list(list(targets = 2:4, className="dt-right")),
        initComplete = I(
            "function(settings, json) {
            $(this.api().table().header()).css({'background-color': '#606060', 'color': '#fff'});
}")))
    
    output$plot <- renderPlot({
        pstate = pstate()
        time = c(0, seq(0.26, 10, 0.01))
        l = (pstate$as >= 0)
        time = time[l]
        pstate = pstate[l, ]
        plot.stacked(
            time,
            pstate,
            lty = 0,
            xlab = "Time (years)",
            ylab = "Probability",
            col = c("red", "purple", "blue", "orange", "white"),
            xlim = c(0, max(time)),
            xaxs = "i",
            yaxs = "i",
            xaxt = "n"
        )
        if (max(time) < 10) {
            axis(1, at = c(0, max(time)), labels = T)
        } else {
            axis(1, at = c(0, 5, 10), labels = T)
        }
        rect(0, 0, max(time), 1)
        legend(
            "topleft",
            legend = c(
                "Remain on Active Surveillance","Death from Other Cause","Convert to Watchful Waiting","Active Treatment",
                "Disease Progression"
            ),
            fill = c("white", "orange", "blue","purple", "red"),
            border = c("black", "white", "white", "white", "white"),
            bty = "n"
        )
    })
})
