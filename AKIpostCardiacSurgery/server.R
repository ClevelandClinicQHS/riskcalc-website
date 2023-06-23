aki_8 = expression({
  lp = 12.342 - 1.4256 * crPre + 5.0949 * max(crPre - 0.71, 0)**3 - 8.6128 * max(crPre - 1, 0)**3 + 3.5179 * max(crPre - 1.42, 0)**3 + 
     6.9663 * crDelta + 20.232 * max(crDelta + 0.23, 0)**3 - 33.46 * max(crDelta + 0.06, 0)**3 + 13.228 * max(crDelta - 0.2, 0)**3 - 
     1.1809 * albPost + 0.4449 * max(albPost - 2.2, 0)**3 - 0.96395 * max(albPost - 2.9, 0)**3 + 0.51905 * max(albPost - 3.5, 0)**3 + 
     0.12287 * bunPost - 0.00045724 * max(bunPost - 10, 0)**3 + 0.00066508 * max(bunPost - 15, 0)**3 - 0.00020784 * max(bunPost - 26, 0)**3 - 
     0.72529 * kPost + 0.56744 * max(kPost - 3.9, 0)**3 - 1.1349 * max(kPost - 4.4, 0)**3 + 0.56744 * max(kPost - 4.9, 0)**3 - 
     0.060986 * naPost + .001592 * max(naPost - 134, 0)**3 - 0.0037146 * max(naPost - 138, 0)**3 + .0021226 * max(naPost - 141, 0)**3 - 
     0.084125 * hco3Post + 0.0019239 * max(hco3Post - 20, 0)**3 - 0.0033669 * max(hco3Post - 23, 0)**3 + 0.0014429 * max(hco3Post - 27, 0)**3 - 
     0.08461 * timing + crDelta * (-5.3224 * crPre + 8.75 * max(crPre - 0.71, 0)**3 - 14.792 * max(crPre - 1, 0)**3 + 6.0416 * max(crPre - 1.42, 0)**3) + 
     crPre * (23.855 * max(crDelta + 0.23, 0)**3 - 39.453 * max(crDelta + 0.06, 0)**3 + 15.598 * max(crDelta - 0.2, 0)**3) + 
     timing * (0.191 * crDelta - 0.73663 * max(crDelta + 0.23, 0)**3 + 1.2183 * max(crDelta + 0.06, 0)**3 - 0.48164 * max(crDelta - 0.2, 0)**3)
  1/(1+exp(-lp))
})

aki_14 = expression({
  lp = 13.597 - 2.1615 * crPre + 5.9958 * max(crPre - 0.71, 0)**3 - 10.136 * max(crPre - 1, 0)**3 + 4.14 * max(crPre - 1.42, 0)**3 + 
     5.2654 * crDelta + 20.985 * max(crDelta + 0.23, 0)**3 - 34.705 * max(crDelta + 0.06, 0)**3 + 13.721 * max(crDelta - 0.2, 0)**3 - 
     1.1467 * albPost + 0.42637 * max(albPost - 2.2, 0)**3 - 0.92381 * max(albPost - 2.9, 0)**3 + 0.49744 * max(albPost - 3.5, 0)**3 + 
     0.11522 * bunPost - 0.00040489 * max(bunPost -10, 0)**3 + 0.00058893 * max(bunPost - 15, 0)**3 - 0.00018404 * max(bunPost - 26, 0)**3 - 
     0.67352 * kPost + 0.52195 * max(kPost - 3.9, 0)**3 - 1.0439 * max(kPost - 4.4, 0)**3 + 0.52195 * max(kPost - 4.9, 0)**3 - 
     0.064931 * naPost + 0.0016568 * max(naPost - 134, 0)**3 - 0.003866 * max(naPost - 138, 0)**3 + 0.0022091 * max(naPost - 141, 0)**3 - 
     0.08513 * hco3Post + 0.0020457 * max(hco3Post - 20, 0)**3 - 0.0035799 * max(hco3Post - 23, 0)**3 + 0.0015342 * max(hco3Post - 27, 0)**3 - 
     0.080271 * timing + crDelta * (-4.2371 * crPre + 6.4089 * max(crPre - 0.71, 0)**3 - 10.834 * max(crPre - 1, 0)**3 + 
                                      4.4252 * max(crPre - 1.42, 0)**3) + 
     crPre * (17.473 * max(crDelta + 0.23, 0)**3 - 28.897 * max(crDelta +  0.06, 0)**3 + 11.425 * max(crDelta - 0.2, 0)**3) + 
     timing *  (0.16085 * crDelta - 0.80933 * max(crDelta + 0.23, 0)**3 + 1.3385 * max(crDelta + 0.06, 0)**3 - 0.52918 * max(crDelta - 0.2, 0)**3)
  1/(1+exp(-lp))
})

akid_3 = expression({
  lp = 14.587 + 2.2829 * crPre - 1.5644 * max(crPre - 0.71, 0)**3 + 2.6446 * max(crPre - 1, 0)**3 - 1.0802 * max(crPre - 1.42, 0)**3 + 
    5.3246 * crDelta + 22.387 * max(crDelta + 0.23, 0)**3 - 37.024 * max(crDelta + 0.06, 0)**3 + 14.637 * max(crDelta - 0.2, 0)**3 - 
    1.3983 * albPost + 0.4289 * max(albPost - 2.2, 0)**3 - 0.92928 * max(albPost - 2.9, 0)**3 + 0.50038 * max(albPost - 3.5, 0)**3 + 
    0.1363 * bunPost - 0.00043721 * max(bunPost - 10, 0)**3 + 0.00063595 * max(bunPost - 15, 0)**3 - 0.00019873 * max(bunPost - 26, 0)**3 - 
    0.9968 * kPost + 0.80164 * max(kPost - 3.9, 0)**3 - 1.6033 * max(kPost - 4.4, 0)**3 + 0.80164 * max(kPost - 4.9, 0)**3 - 
    0.089465 * naPost + 0.0026258 * max(naPost - 134, 0)**3 - 0.0061269 * max(naPost - 138, 0)**3 + 0.0035011 * max(naPost - 141, 0)**3 - 
    0.14885 * hco3Post + 0.0032249 * max(hco3Post - 20, 0)**3 - 0.0056436 * max(hco3Post - 23, 0)**3 + 0.0024187 * max(hco3Post - 27, 0)**3 - 
    0.13955 * timing + crDelta * (-5.1422 * crPre + 9.75 * max(crPre - 0.71, 0)**3 - 16.482 * max(crPre - 1, 0)**3 + 6.7322 * max(crPre - 1.42, 0)**3) + 
    crPre * (26.582 * max(crDelta + 0.23, 0)**3 - 43.962 * max(crDelta + 0.06, 0)**3 + 17.38 * max(crDelta - 0.2, 0)**3) + 
    timing * (0.11486 * crDelta - 0.5174 * max(crDelta + 0.23, 0)**3 + 0.8557 * max(crDelta + 0.06, 0)**3 - 0.3383 * max(crDelta - 0.2, 0)**3)
  1/(1+exp(-lp))
})

akid_14 = expression({
  lp = 15.366 + 1.682 * crPre - 0.74761 * max(crPre - 0.71, 0)**3 + 1.2638 * max(crPre - 1, 0)**3 - 0.51621 * max(crPre - 1.42, 0)**3 + 
    4.016 * crDelta + 26.28 * max(crDelta + 0.23, 0)**3 - 43.464 * max(crDelta + 0.06, 0)**3 + 17.183 * max(crDelta - 0.2, 0)**3 - 
    1.3636 * albPost + 0.44539 * max(albPost - 2.2, 0)**3 - 0.96502 * max(albPost - 2.9, 0)**3 + 0.51963 * max(albPost -     3.5, 0)**3 + 
    0.082107 * bunPost - 0.00018355 * max(bunPost - 10, 0)**3 + 0.00026698 * max(bunPost - 15, 0)**3 - 8.3432e-05 * max(bunPost - 26, 0)**3 - 
    0.91404 * kPost + 0.70399 * max(kPost - 3.9, 0)**3 - 1.408 * max(kPost - 4.4, 0)**3 + 0.70399 * max(kPost - 4.9, 0)**3 - 
    0.085823 * naPost + 0.0024639 * max(naPost - 134, 0)**3 - 0.005749 * max(naPost - 138, 0)**3 + 0.0032851 * max(naPost - 141, 0)**3 - 0.15519 * hco3Post + 0.0036026 * max(hco3Post - 20, 0)**3 - 0.0063046 * max(hco3Post - 23, 0)**3 + 0.002702 * max(hco3Post - 27, 0)**3 - 0.1416 * timing + crDelta * (-4.6808 *       crPre + 9.1579 * max(crPre - 0.71, 0)**3 - 15.481 * max(crPre - 1, 0)**3 + 6.3233 * max(crPre - 1.42, 0)**3) + crPre * (24.967 * max(crDelta + 0.23, 0)**3 - 41.292 * max(crDelta + 0.06, 0)**3 + 16.325 * max(crDelta - 0.2, 0)**3) + timing * (0.068463 * crDelta - 0.40343 * max(crDelta + 0.23, 0)**3 + 0.66721 * max(crDelta + 0.06, 0)**3 - 0.26378 * max(crDelta -  0.2, 0)**3)
  1/(1+exp(-lp))
})


shinyServer(function(input, output, session){
  # input
  data = reactive({
    shiny::validate(
      need(input$timing>=0&input$timing<=48, "Range of duration from end of surgery to metabolic panel draw: 0 - 48 hour"),
      need(input$crPre>=0&input$crPre<=4, "Range of Pre-operative serum creatinine: 0 - 4 mg/dl"),
      need(input$crPost>=0&input$crPost<=4, "Range of Post-operative serum creatinine: 0 - 4 mg/dl"),
      need(input$albPost>=0&input$albPost<=10, "Range of Post-operative serum albumin: 0 - 10 mg/dl"),
      need(input$bunPost>=0&input$bunPost<=200, "Range of Post-operative BUN: 0 - 200 mg/dl"),
      need(input$kPost>=0&input$kPost<=10, "Range of Post-operative serum potassium: 0 - 10 mmol/L"),
      need(input$naPost>=80&input$naPost<=200, "Range of Post-operative serum sodium: 80 - 200 mmol/L"),
      need(input$hco3Post>=0&input$hco3Post<=80, "Range of Post-operative serum bicarbonate: 0 - 80 mmol/L")
    )
    
    timing = input$timing
    crDelta = input$crPost - input$crPre
    crPre = input$crPre
    crPost = input$crPost
    albPost = input$albPost
    bunPost = input$bunPost
    kPost = input$kPost
    naPost = input$naPost
    hco3Post = input$hco3Post
    
    data = data.frame(
      timing = timing, 
      crDelta = crDelta,
      crPre = crPre,
      crPost = crPost,
      albPost = albPost,
      bunPost = bunPost,
      kPost = kPost,
      naPost = naPost,
      hco3Post = hco3Post
    )
    data
  })
  
  # output table
  output$result <- DT::renderDataTable({
    data = data()
    pred.aki_8 = eval(aki_8, data)
    pred.aki_14 = eval(aki_14, data)
    pred.akid_3 = eval(akid_3, data)
    pred.akid_14 = eval(akid_14, data)
    
    pred.aki_8 = ifelse(pred.aki_8<0.001,"<0.1%", ifelse(pred.aki_8>0.999, ">99.9%", paste(round(pred.aki_8*100,1), "%", sep="")))
    pred.aki_14 = ifelse(pred.aki_14<0.001,"<0.1%", ifelse(pred.aki_14>0.999, ">99.9%", paste(round(pred.aki_14*100,1), "%", sep="")))
    pred.akid_3 = ifelse(pred.akid_3<0.001,"<0.1%", ifelse(pred.akid_3>0.999, ">99.9%", paste(round(pred.akid_3*100,1), "%", sep="")))
    pred.akid_14 = ifelse(pred.akid_14<0.001,"<0.1%", ifelse(pred.akid_14>0.999, ">99.9%", paste(round(pred.akid_14*100,1), "%", sep="")))
    
    res = data.frame(
      Result = c("<p>AKI<sup>2/3</sup> in 3 days</p>",
                 "<p>AKI<sup>2/3</sup> in 14 days</p>",
                 "<p>AKI<sup>D</sup> in 3 days</p>",
                 "<p>AKI<sup>D</sup> in 14 days</p>"),
      Probability = c(
        pred.aki_8,
        pred.aki_14,
        pred.akid_3,
        pred.akid_14
      )
    )
  }, escape = FALSE, options = list(
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
})

pvalr <- function(pvals, sig.limit = .001, digits = 3, html = FALSE) {
  
  roundr <- function(x, digits = 1) {
    res <- sprintf(paste0('%.', digits, 'f'), x)
    zzz <- paste0('0.', paste(rep('0', digits), collapse = ''))
    res[res == paste0('-', zzz)] <- zzz
    res
  }
  
  sapply(pvals, function(x, sig.limit) {
    if (x < sig.limit)
      if (html)
        return(sprintf('&lt; %s', format(sig.limit))) else
          return(sprintf('< %s', format(sig.limit)))
    if (x > .1)
      return(roundr(x, digits = 2)) else
        return(roundr(x, digits = digits))
  }, sig.limit = sig.limit)
}