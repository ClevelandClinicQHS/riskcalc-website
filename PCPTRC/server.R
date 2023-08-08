
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
options(shiny.reactlog=TRUE)
library(shiny)

shinyServer(function(input, output,session) {
#   myprogress <- Progress$new(session, min=0, max=1)
  
  
  data <- reactive({
    input$calcRisk
    isolate({
      if (input$race != "" & ((!input$famhist_avail%%2 & input$famhist != "") | (input$famhist_avail%%2 & input$FDR_PC_less60 !="" & input$FDR_PC_60 !="" & input$FDR_BC !="" & input$SDR !="")) 
          & input$dre != "" & input$priobiop != "" & input$psa <= 50 & input$psa > 0 & input$age>=55 & input$age <=90){
        race = ifelse(input$race == "African American",1,0)
        #famhist = ifelse(input$famhist == "Yes",1,0)
        if((input$famhist_avail%%2) & (input$race %in% c("Caucasian", "Caucásico"))){
          famhist = 0
          FDR_PC_less60 = ifelse(input$FDR_PC_less60 == "No", 0, ifelse(input$FDR_PC_less60 == "Yes, one", 1, 2) )
          FDR_PC_60 = ifelse(input$FDR_PC_60 == "No", 0, ifelse(input$FDR_PC_60 == "Yes, one", 1, 2) )
          FDR_BC = ifelse(input$FDR_BC == "No",0,1)
          SDR = ifelse(input$SDR == "No",0,1)
        }
        else {
          
          famhist = ifelse(input$famhist == "Yes",1,0)
          FDR_PC_less60 = NA
          FDR_PC_60 = NA
          FDR_BC = NA
          SDR = NA

        }
        
        if((input$snp_avail%%2 & (input$race %in% c("Caucasian", "Caucásico")))){
          
          allele = c("0 risk alleles", "1 risk allele", "2 risk alleles")
          
          SNP = c(sapply(input$snps, function(x) which(x == snpdat$SNP)))

          ll = length(SNP)
          gtmp = sapply(1:ll, function(x) eval(parse(text=paste0("input$g",x))))
          
          genotype = sapply(gtmp, function(x) which(x == allele)) - 1
         
        }
        else{            
          SNP = NA
          genotype = NA
        }
        
        dre = ifelse(input$dre == "Abnormal",1,0)
        
        priobiop = ifelse(input$priobiop == "Prior negative biopsy",1,
                   ifelse(input$priobiop == "Not sure",NA,0))
           
        psa = input$psa
        age = input$age
        
        
        fpsa = ifelse(input$fpsa_avail, input$fpsa, NA)
        pca_3 = ifelse(input$pca3_avail, input$pca_3, NA)
        t_2erg = ifelse(input$pca3_t2erg_avail, input$t_2erg, NA)
        
        myrisk = risk(psa = psa, age=age, race=race, priorbiopsy=priobiop, dre=dre, famhistory=famhist, 
                      pct_freePSA=fpsa, pca3=pca_3, t2erg=t_2erg, FDR_PC_less60=FDR_PC_less60, FDR_PC_60=FDR_PC_60, FDR_BC = FDR_BC,
                      SDR=SDR, SNP = SNP, genotype = genotype) 
        myrisk
        
      }
      else {
        # this case should never be reached but just in case
        warning(test)
        langSwitch("Error", "Error", type="warning")
      }
    })
    
  })
  
  output$view <- renderTable({
    dat = data()
    if(sum(dat) >= 99 & sum(dat) <= 101){
#       myprogress$set(message = 'Calculation in progress',
#                      detail = 'Almost there...', value = 0.33)
      dat = as.matrix(dat)
#       myprogress <<- Progress$new(session, min=0, max=1)
      t(as.matrix(apply(dat,2 ,function(x) paste(x, "%", sep=""))))
    }
    
    
  }, include.rownames=FALSE)
  
  
  output$smile_en <- renderUI({
#     on.exit(myprogress$close(),T)
    out = ""
    if(input$goButton){
      if(input$calcRisk){
#         myprogress <<- Progress$new(session, min=0, max=1)
#         myprogress$set(message = 'Calculation in progress',
#                        detail = 'Almost there...', value = 0.66)
        
#         isolate({
#           if(!input$famhist_avail%%2 | !(input$race %in% c("Caucasian", "Caucásico") ))
#             famhist_avail = 0
#           else
#             famhist_avail = 1
#           
#           if(!input$snp_avail%%2 | !(input$race %in% c("Caucasian", "Caucásico") ))
#             snp_avail = 0
#           else
#             snp_avail = 1
        
        isolate({
          if(input$famhist_avail%%2 & (input$race %in% c("Caucasian", "Caucásico") ))
            famhist_avail = 1
          else
            famhist_avail = 0
          
          if(input$snp_avail%%2 & (input$race %in% c("Caucasian", "Caucásico") ))
            snp_avail = 1
          else
            snp_avail = 0
          
              
          if(!is.na(input$age) & !is.na(input$psa) & (input$race !="") &
               ((!famhist_avail & input$famhist !="") | (famhist_avail & input$FDR_PC_less60 !="" & input$FDR_PC_60 !="" & input$FDR_BC !="" & input$SDR !="")) & 
               (input$dre !="") & (input$priobiop !="") & (!input$fpsa_avail | input$fpsa_avail & !is.na(input$fpsa )) & (!input$pca3_avail | input$pca3_avail & !is.na(input$pca_3 )) & (!input$pca3_t2erg_avail | input$pca3_t2erg_avail & !is.na(input$t_2erg )))
          {
            if(input$age<55)
            {
              out = langSwitch(warning_age_en, warning_age_en, type="warning")
            }
            else if(input$psa<=0 | input$psa>50)
            {
              out = langSwitch(warning_psa_en, warning_psa_en, type="warning")
            }
            else if(input$fpsa_avail & (input$fpsa<5 | input$fpsa>75))
            {
              out = langSwitch(warning_fpsa_en, warning_fpsa_en, type="warning")
            }
            else if(input$pca3_avail & (input$pca_3<0.3 | input$pca_3>332.5))
            {
              out = langSwitch(warning_pca_3_en, warning_pca_3_en, type="warning")
            }
            else if(input$pca3_t2erg_avail & (input$t_2erg<0.0 | input$t_2erg>6031.6))
            {
              out = langSwitch(warning_t2erg_en, warning_t2erg_en, type="warning")
            }            
            else if((input$fpsa_avail) & (input$pca3_avail))
            {
              out = langSwitch(warning_pca3_fill_en, warning_pca3_fill_en, type="warning")
            }                        
            else if((input$fpsa_avail) & (input$pca3_t2erg_avail))
            {
              out = langSwitch(warning_pca3_t2erg_fill_en, warning_pca3_t2erg_fill_en, type="warning")
            }  
            else if((!input$pca3_avail) & (input$pca3_t2erg_avail))
            {
              out = langSwitch(warning_t2erg_fill_en, warning_t2erg_fill_en, type="warning")
            }                                     
            else
            {                                  
              dat = data()
              if(sum(dat) >= 99 & sum(dat) <= 101){
                h1("Individualized Risk Assessment of Prostate Cancer")
                br()
                out = HTML(calcSmiley(unlist(dat), input$lang, famhist_avail | snp_avail))
#                 myprogress$set(message = 'Calculation in progress',
#                                detail = 'Almost there...', value = 1)
                
              }
            }
          }
          else
          {
            # Warnings are so far only in English available; if available change second variable to warning_overall_sp
            out=langSwitch(warning_overall_en, warning_overall_en, type="warning")
          }
        })
      }
      
    }
    
    out
  })
  
  observe({
    #if(input$lang > 0){
    if( ifelse(globalLanguage,!(input$lang%%2),(input$lang%%2)))
    {
      isolate({
        race1 = c("","African American", "Caucasian", "Hispanic", "Other")[which(c("","African American", "Caucasian", "Hispanic", "Other") == input$race)]
        famhist1 = c("", "Yes", "No", "Do not know")[which(c("", "Yes", "No", "Do not know") == input$famhist)]
        dre1 = c("", "Abnormal", "Normal", "Not performed or not sure")[which(c("", "Abnormal", "Normal", "Not performed or not sure") == input$dre)]
        priobiop1 = c("", "Never had a prior biopsy", "Prior negative biopsy", "Not sure")[which(c("", "Never had a prior biopsy", "Prior negative biopsy", "Not sure") == input$priobiop)]
        # when we have a spanish translation for the new parts we need this
        FDR_PC_less60_1 = c("", "No", "Yes, one", "Yes, two or more")[which(c("", "No", "Yes, one", "Yes, two or more") == input$FDR_PC_less60)]
        FDR_PC_60_1 = c("", "No", "Yes, one", "Yes, two or more")[which(c("", "No", "Yes, one", "Yes, two or more") == input$FDR_PC_60)]
        FDR_BC1 = c("", "No", "Yes, at least one")[which(c("", "No", "Yes, at least one") == input$FDR_BC)]
        SDR1 = c("", "No", "Yes, at least one")[which(c("", "No", "Yes, at least one") == input$SDR)]
      })
      updateSelectInput(session = session, inputId = "race", selected = race1,
                        choices = c("","African American", "Caucasian", "Hispanic", "Other"))
      updateSelectInput(session = session, inputId = "famhist", selected = famhist1,
                        choices = c("", "Yes", "No", "Do not know"))
      updateSelectInput(session = session, inputId = "dre", selected = dre1, 
                        choices = c("", "Abnormal", "Normal", "Not performed or not sure"))
      updateSelectInput(session = session, inputId = "priobiop", selected = priobiop1,
                        choices = c("", "Never had a prior biopsy", "Prior negative biopsy", "Not sure"))
      # when we have a spanish translation for the new parts we need this
      updateSelectInput(session = session, inputId = "FDR_PC_less60", selected = FDR_PC_less60_1,
                        choices = c("", "No", "Yes, one", "Yes, two or more"))
      updateSelectInput(session = session, inputId = "FDR_PC_60", selected = FDR_PC_60_1,
                        choices = c("", "No", "Yes, one", "Yes, two or more"))
      updateSelectInput(session = session, inputId = "FDR_BC", selected = FDR_BC1,
                        choices = c("", "No", "Yes, at least one"))
      updateSelectInput(session = session, inputId = "SDR", selected = SDR1,
                        choices = c("", "No", "Yes, at least one"))
      
      removePopover(session = session, "age")
      addPopover(session = session, id = "age",title= "Age", content = tooltip_age_en, placement = "right", trigger = "hover")
      removePopover(session = session, "psa") 
      addPopover(session = session, id = "psa", title = "PSA", content = tooltip_psa_en, placement = "right", trigger = "hover")
      removePopover(session = session, "famhist")
      addPopover(session = session, id = "famhist", title = "Family History", content = tooltip_famhist_en, placement = "right", trigger = "hover")
      removePopover(session = session, "dre")
      addPopover(session = session, id = "dre", title = "DRE", content = tooltip_dre_en, placement = "right", trigger = "hover")
      removePopover(session = session, "priobiop")
      addPopover(session = session, id = "priobiop", title ="Prior Biopsy", content = tooltip_priobiop_en, placement = "right", trigger = "hover")
      removePopover(session = session, "fpsa")
      addPopover(session = session, id = "fpsa", title = "Percent free PSA", content = tooltip_fpsa_en, placement = "right", trigger = "hover")
      removePopover(session = session, "pca_3")
      addPopover(session = session, id = "pca_3", title = "PCA3", content = tooltip_pca3_en, placement = "right", trigger = "hover")
      removePopover(session = session, "t_2erg")
      addPopover(session = session, id = "t_2erg", title = "T2:ERG", content = tooltip_t2erg_en, placement = "right", trigger = "hover")
      
      # when we have a spanish translation for the new parts we need this
      removePopover(session = session, "FDR_PC_less60")
      addPopover(session = session, id = "FDR_PC_less60", title = "Detailed Family History", content = tooltip_FDR_PC_less60_en, placement = "right", trigger = "hover")
      removePopover(session = session, "FDR_PC_60")
      addPopover(session = session, id = "FDR_PC_60", title = "Detailed Family History", content = tooltip_FDR_PC_60_en, placement = "right", trigger = "hover")
      removePopover(session = session, "FDR_BC")
      addPopover(session = session, id = "FDR_BC", title = "Detailed Family History", content = tooltip_FDR_BC_en, placement = "right", trigger = "hover")
      removePopover(session = session, "SDR")
      addPopover(session = session, id = "SDR", title = "Detailed Family History", content = tooltip_SDR_en, placement = "right", trigger = "hover")

      
    }
    else
    {
      isolate({
        race1 = c("","African American", "Caucasian", "Hispanic", "Other")[which(c("","African American", "Caucasian", "Hispanic", "Other") == input$race)]
        famhist1 = c("", "Yes", "No", "Do not know")[which(c("", "Yes", "No", "Do not know") == input$famhist)]
        dre1 = c("", "Abnormal", "Normal", "Not performed or not sure")[which(c("", "Abnormal", "Normal", "Not performed or not sure") == input$dre)]
        priobiop1 = c("", "Never had a prior biopsy", "Prior negative biopsy", "Not sure")[which(c("", "Never had a prior biopsy", "Prior negative biopsy", "Not sure") == input$priobiop)]
        # Here some further lines when we have the spanish translation for the new part  
        # when we have a spanish translation for the new parts we need this
        FDR_PC_less60_1 = c("", "No", "Yes, one", "Yes, two or more")[which(c("", "No", "Yes, one", "Yes, two or more") == input$FDR_PC_less60)]
        FDR_PC_60_1 = c("", "No", "Yes, one", "Yes, two or more")[which(c("", "No", "Yes, one", "Yes, two or more") == input$FDR_PC_60)]
        FDR_BC1 = c("", "No", "Yes, at least one")[which(c("", "No", "Yes, at least one") == input$FDR_BC)]
        SDR1 = c("", "No", "Yes, at least one")[which(c("", "No", "Yes, at least one") == input$SDR)]
        
      })      
      updateSelectInput(session = session, inputId = "race", selected = race1,
                        choices = c("","Afroamericano"="African American", "Caucásico"="Caucasian", "Hispano"="Hispanic", "Otro"="Other"))
      updateSelectInput(session = session, inputId = "famhist", selected = famhist1,
                        choices = c("", "Si"="Yes", "No", "No Sé"="Do not know"))
      updateSelectInput(session = session, inputId = "dre", selected = dre1,
                        choices = c("", "Anormal"="Abnormal", "Normal", "No se ha realizado o No Sé"="Not performed or not sure"))
      updateSelectInput(session = session, inputId = "priobiop",selected = priobiop1,
                        choices = c("","no biopsia previa"="Never had a prior biopsy", "biopsia previa negativa"="Prior negative biopsy", "no estoy seguro"="Not sure"))
      # Here some further lines when we have the spanish translation for the new part 
      updateSelectInput(session = session, inputId = "FDR_PC_less60", selected = FDR_PC_less60_1,
                        choices = c("", "no"="No","sí, uno"="Yes, one", "sí, dos o más"="Yes, two or more"))
      updateSelectInput(session = session, inputId = "FDR_PC_60", selected = FDR_PC_60_1,
                        choices = c("", "no"="No","sí, uno"="Yes, one", "sí, dos o más"="Yes, two or more"))
      updateSelectInput(session = session, inputId = "FDR_BC", selected = FDR_BC1,
                        choices = c("", "no"="No", "sí, una o más"="Yes, at least one"))
      updateSelectInput(session = session, inputId = "SDR", selected = SDR1,
                        choices = c("", "no"="No","sí, una o más"="Yes, at least one"))
      
      
      removePopover(session = session, "age")
      addPopover(session = session, id = "age",title= "Edad", content = tooltip_age_sp, placement = "right", trigger = "hover")
      removePopover(session = session, "psa") 
      addPopover(session = session, id = "psa", title = "PSA", content = tooltip_psa_sp, placement = "right", trigger = "hover")
      removePopover(session = session, "famhist")
      addPopover(session = session, id = "famhist", title = "Historia Familiar", content = tooltip_famhist_sp, placement = "right", trigger = "hover")
      removePopover(session = session, "dre")
      addPopover(session = session, id = "dre", title = "DRE", content = tooltip_dre_sp, placement = "right", trigger = "hover")
      removePopover(session = session, "priobiop")
      addPopover(session = session, id = "priobiop", title ="Biopsia Prostática Previa", content = tooltip_priobiop_sp, placement = "right", trigger = "hover")
      removePopover(session = session, "fpsa")
      addPopover(session = session, id = "fpsa", title = "Porcentaje de PSA libre", content = tooltip_fpsa_sp, placement = "right", trigger = "hover")
      # when we have a spanish translation for the new parts we need this
      removePopover(session = session, "FDR_PC_less60")
      addPopover(session = session, id = "FDR_PC_less60", title = "Historial familiar detallado", content = tooltip_FDR_PC_less60_sp, placement = "right", trigger = "hover")
      removePopover(session = session, "FDR_PC_60")
      addPopover(session = session, id = "FDR_PC_60", title = "Historial familiar detallado", content = tooltip_FDR_PC_60_sp, placement = "right", trigger = "hover")
      removePopover(session = session, "FDR_BC")
      addPopover(session = session, id = "FDR_BC", title = "Historial familiar detallado", content = tooltip_FDR_BC_sp, placement = "right", trigger = "hover")
      removePopover(session = session, "SDR")
      addPopover(session = session, id = "SDR", title = "Historial familiar detallado", content = tooltip_SDR_sp, placement = "right", trigger = "hover")
    }
    #}
    
  })

snpsdat <- reactive({
  input$snps
})

output$snpsui <- renderUI({
vec = snpsdat()
ll = length(vec)
if(length(vec > 0)){
lapply(1:ll, function(i) {
  selectInput(paste0("g",i), div(vec[i],a(subset(snpdat,SNP == vec[i])$Reference, href = subset(snpdat,SNP == vec[i])$doi,target="_blank")),
              choices = c("","0 risk alleles", "1 risk allele", "2 risk alleles"))
  
})
}
})
  
  
  output$switchTab1 <- renderUI({
    if(input$videoLink){
      HTML("<script> {
  					 tabs = $('.tabbable .nav.nav-tabs li')
					 	 tabs.each(function() {
							$(this).removeClass('active')
					 	 })
						 $(tabs[1]).addClass('active')
						
						 tabsContents = $('.tabbable .tab-content .tab-pane')
					 	 tabsContents.each(function() {
							$(this).removeClass('active')
					 	 })
						 $(tabsContents[1]).addClass('active')
 
						$('#summary').trigger('change').trigger('shown');
						 
					 }</script>
			")
    }
  })
  output$switchTab2 <- renderUI({
    if(input$calcRisk){
      HTML("<script> {
    				 tabs = $('.tabbable .nav.nav-tabs li')
					 	 tabs.each(function() {
							$(this).removeClass('active')
					 	 })
						 $(tabs[0]).addClass('active')
						
						 tabsContents = $('.tabbable .tab-content .tab-pane')
					 	 tabsContents.each(function() {
							$(this).removeClass('active')
					 	 })
						 $(tabsContents[0]).addClass('active')
 
						$('#summary').trigger('change').trigger('shown');
						 
					 }</script>
			")
    }
  })
  
  
})
