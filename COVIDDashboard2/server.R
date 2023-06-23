
server <- function(input, output, session) {
  showLog()
  logjs(paste('today', Sys.Date()))
  logjs(paste('diff', max_diff))
  values <- reactiveValues(State=c(), GEOID=c())
  output$title = renderText({
    ifelse(input$type == 'Count',
           paste("Updated on", update_time),
           paste("per 100,000 Inhabitants, Updated on", update_time))
  })
  output$subtitle1 = renderText({
    ifelse(input$type == 'Count',
           "Total Confirmed",
           "Total Confirmed per 100,000 Inhabitants")
  })
  output$subtitle2 = renderText({
    ifelse(input$type == 'Count',
           "Total Deaths",
           "Total Deaths per 100,000 Inhabitants")
    
  })
  output$note = renderText({
    ifelse(input$type == 'Count',
           "These graphs were developed by Cleveland Clinic researchers to provide a population-based snapshot of COVID-19 infection rtes in the United States. The graphs represent cumulative positive tests. Note:Results may be skewed based on variability in testing availablity and/or turnaround time among different states.",
           "These graphs were developed by Cleveland Clinic researchers to provide a population-based snapshot of COVID-19 infection rtes in the United States. The graphs represent positive tests per 100,000 persons, rather than cumulative positive tests. Note:Results may be skewed based on variability in testing availablity and/or turnaround time among different states.")
  })
  output$note2 = renderText({
    "Filter graph by clicking on a state from the map above"
  })
  
  observeEvent(input$mymap_shape_click, {
    pointId <- input$mymap_shape_click$id
    print(pointId)
    if (length(values$State) < 6 & pointId %notin% values$State) {
      values$State = c(values$State, pointId)
      values$GEOID = c(values$GEOID, usmap$GEOID[usmap$NAME==pointId])
    } else if (length(values$State)== 6 & pointId %notin% values$State){
      values$State = c(values$State[2:6], pointId)
      values$GEOID = c(values$GEOID[2:6], usmap$GEOID[usmap$NAME==pointId])
    }
    print(values$State)
    output$status <- renderUI(lapply(seq_len(length(isolate(values$State))),
                                     function(i){
                                       actionButton(inputId = paste0("btn_", values$GEOID[i]),
                                                    label = values$State[i], icon("times"),
                                                    style="padding-left:1;padding-right:1;padding-top:0;padding-bottom:0;margin:0;color:#fff;background-color:#f08122")
                                     })
    )
    # output$status <- renderUI(actionButton("clicked", paste("Selected State:", pointId), icon('times'),
    #                                        style="padding-left:1;padding-right:1;padding-top:0;padding-bottom:0;margin:0;color:#fff;background-color:#f08122"))
    
  })
  
  observe({
    # Identify all of the buttons in the table.
    # Note that I assumed the same prefix on all buttons, and 
    # they only differ on the number following the underscore
    # This must happen in an observed since the number of rows 
    # in the table is not fixed.
    input_btn <- paste0("btn_", values$GEOID)
    lapply(input_btn,
           function(x){
             observeEvent(
               input[[x]],
               {
                 logjs(x)
                 removeUI(selector = paste("#", x, sep=""))
                 values$State=values$State[values$GEOID!=substr(x,5,6)]
                 values$GEOID=values$GEOID[values$GEOID!=substr(x,5,6)]
               }
             )
           })
  })
  
  output$confirm = DT::renderDataTable({
    if (input$type=="Count") {
      update_df %>% 
        select(Confirmed, State) %>% 
        na.omit() %>% 
        arrange(desc(Confirmed)) %>% 
        head(5)
    } else if (input$type=="Capita") {
      update_df %>% 
        select(Confirmed_capita, State) %>% 
        na.omit() %>% 
        rename(Confirmed = Confirmed_capita) %>% 
        arrange(desc(Confirmed)) %>% 
        head(5) %>% 
        mutate(Confirmed = formatC(Confirmed, format = 'f', digits = 2))
    }
  }, 
  options = list(
    columnDefs = list(list(className = 'dt-center', targets = '_all')),
    pageLength = 5,
    lengthMenu = 0,
    searching = FALSE,
    info = 0,
    paging = 0,
    processing = 0,
    autoWidth = TRUE,
    ordering = FALSE),
  rownames= FALSE)
  
  output$death = DT::renderDataTable({
    if (input$type=="Count") {
      update_df %>% 
        select(Deaths, State) %>% 
        na.omit() %>% 
        arrange(desc(Deaths)) %>% 
        head(5)
    } else if (input$type=="Capita") {
      update_df %>% 
        select(Deaths_capita, State) %>% 
        na.omit() %>% 
        arrange(desc(Deaths_capita)) %>% 
        rename(Deaths = Deaths_capita) %>% 
        mutate(Deaths = formatC(Deaths, format = 'f', digits = 4)) %>% 
        head(5)
    }
  }, options = list(
    columnDefs = list(list(className = 'dt-center', targets = '_all')),
    pageLength = 5,
    lengthMenu = 0,
    searching = FALSE,
    info = 0,
    paging = 0,
    processing = 0,
    autoWidth = TRUE,
    ordering = FALSE),
  rownames= FALSE)
  
  output$cumconf <- renderPlot({
    if (input$type=="Count") {
      if (length(values$State) < 1) {
        temp = data %>% 
          arrange(Last.Update) %>% 
          group_by(Last.Update) %>% 
          summarise(Confirmed = sum(Confirmed)) %>% ungroup()
      } else {
        temp = data %>% 
          filter(State%in% isolate(values$State)) %>% 
          arrange(Last.Update) %>% 
          group_by(Last.Update) %>% 
          summarise(Confirmed = sum(Confirmed)) %>% 
          ungroup()
      }
      print(paste0(values$State, collapse = "+"))
      temp = rbind(temp %>% mutate(Confirmed = Confirmed-lag(Confirmed)) %>% mutate(type='New'), 
                   temp %>% mutate(Confirmed = lag(Confirmed)) %>% mutate(type="Previous"))
      temp = temp %>% mutate(Confirmed = ifelse(is.na(Confirmed)|Confirmed <0, 0, Confirmed)) %>% 
        filter(Last.Update>=ymd("2020-03-01"))
      p = ggplot(temp, aes(fill=type, y=Confirmed, x=Last.Update)) + 
        geom_bar(position="stack", stat="identity")+
        #scale_y_continuous(limits = c(0, max(temp$Confirmed, na.rm = T)+10000))+
        scale_x_date(date_breaks = '2 days')+
        scale_fill_manual("", values = c("New" = "#0091e5", "Previous" = "#0078BF"))+
        xlab("")+theme_bw()+
        theme(legend.position=c(.2,.85),
              axis.text.x = element_text(angle = 90, hjust = 0.5),
              plot.title = element_text(hjust = 0.5),
              plot.subtitle = element_text(hjust = 0.5))+
        labs(title = "Cumulative confirmed cases")
      if (length(values$State) > 0) {
        p + labs(subtitle = paste(values$State,collapse = ", "), y="Confirmed cases")
      } else {
        p + labs(subtitle = "United States", y="Confirmed cases")
      }
    } else if (input$type=="Capita") {
      if (length(values$State) < 1) {
        temp = data %>% 
          select(Last.Update, Confirmed) %>% 
          na.omit() %>% 
          arrange(Last.Update) %>% 
          group_by(Last.Update) %>% 
          summarise(Confirmed = sum(Confirmed)) %>% 
          ungroup() %>% 
          mutate(Confirmed = Confirmed / tot_pop * 100000)
      } else {
        temp = data %>% 
          select(Last.Update, Confirmed_capita, State) %>% 
          rename(Confirmed = Confirmed_capita) %>% 
          na.omit() %>% 
          filter(State %in% isolate(values$State)) %>% 
          arrange(Last.Update) %>% 
          group_by(Last.Update) %>% 
          summarise(Confirmed = sum(Confirmed)) %>% 
          ungroup()
      }
      temp = temp %>%  filter(Last.Update >= ymd("2020-03-04"))
      p =  ggplot(temp, aes(x=Last.Update, y = Confirmed)) + 
        geom_point(colour="#0078BF") + geom_line(colour="#0078BF") + theme_bw() + 
        geom_text(label=formatC(round(temp$Confirmed, 2),format='f',digits=2),vjust=1.5,size=3, color="#0091e5")+
        scale_x_date(date_breaks = '2 days')+
        theme(legend.position=c(.2,.85),
              axis.text.x = element_text(angle = 90, hjust = 0.5),
              plot.title = element_text(hjust = 0.5),
              plot.subtitle = element_text(hjust = 0.5))+
        labs(title="US Cumulative Confirmed Cases of Coronavirus COVID-19",
             x="", y="Cumulative confirmed cases \nper 100,000 Inhabitants")
      if (length(values$State) > 0) {
        p + labs(subtitle = paste(values$State,collapse = ", "), y="Confirmed cases per 100,000 Inhabitants")
      } else {
        p + labs(subtitle = "United States", y="Confirmed cases per 100,000 Inhabitants")
      }
    }
  })
  
  output$cumconf1 <- renderPlot({
    if (input$type == "Count") {
      if (length(values$State) < 1) {
        temp = data %>% arrange(Last.Update) %>% 
          group_by(Last.Update, State) %>% 
          summarise(Confirmed = sum(Confirmed)) %>% 
          ungroup() %>% 
          filter(State %in% (update_df %>% arrange(desc(Confirmed)) %>% head(5) %>% pull(State)))
      } else {
        temp = data %>% arrange(Last.Update) %>% 
          group_by(Last.Update, State) %>% 
          summarise(Confirmed = sum(Confirmed)) %>% 
          ungroup() %>% 
          filter(State %in% c(values$State))
      }
    } else if (input$type == "Capita") {
      if (length(values$State) < 1) {
        temp = data %>% arrange(Last.Update) %>% 
          select(Last.Update, State, Confirmed_capita) %>% 
          rename(Confirmed = Confirmed_capita) %>% na.omit() %>% 
          filter(State %in% (update_df %>% arrange(desc(Confirmed)) %>% head(5) %>% pull(State)))
      } else {
        temp = data %>% arrange(Last.Update) %>% 
          select(Last.Update, State, Confirmed_capita) %>% 
          rename(Confirmed = Confirmed_capita) %>% 
          na.omit() %>% 
          filter(State %in% isolate(values$State))
      }
    }
    
    temp = temp %>% filter(Last.Update>=ymd("2020-03-01"))
    if (nrow(temp)>0) {
      p = ggplot(temp, aes(group=State, y=Confirmed, x=Last.Update)) + 
        geom_line(aes(linetype=State, colour=State),size=1.5)+
        #scale_y_continuous(limits = c(0, max(temp$Confirmed, na.rm = T)+10000))+
        scale_x_date(date_breaks = '2 days')+
        scale_color_manual(values=c("#0078BF", "#00843D", "#F7C612", "#A61F56", "#F08122", "#5C2161"))+
        xlab("")+ylab("Confirmed cases")+theme_bw()+
        theme(legend.position=c(.2,.75),
              axis.text.x = element_text(angle = 90, hjust = 0.5),
              plot.title = element_text(hjust = 0.5),
              plot.subtitle = element_text(hjust = 0.5))+
        labs(title = "US Cumulative Cases of Coronavirus COVID-19",
             x="")
      if (input$type == "Count") {
        if (length(values$State) > 0) {
          p = p + labs(subtitle = paste(values$State,collapse = ", "), y="Cumulative confirmed cases")
        } else {
          p = p + labs(subtitle = paste("Top 5 States on", update_time), y="Cumulative confirmed cases")
        }
      } else if (input$type == 'Capita') {
        if (length(values$State) > 0) {
          p = p + labs(subtitle = paste(values$State,collapse = ", "), y="Cumulative confirmed cases per 100,000 Inhabitants")
        } else {
          p = p + labs(subtitle = paste("Top 5 States on", update_time), y="Cumulative confirmed cases per 100,000 Inhabitants")
        }
      }
      p 
    }
  })
  
  output$cumconf2 <- renderPlot({
    if (input$type == "Count") {
      if (length(values$State) < 1) {
        temp = data %>% arrange(Last.Update) %>% 
          filter(State %in% (update_df %>% arrange(desc(Confirmed)) %>% head(5) %>% pull(State)))
      } else {
        temp = data %>% arrange(Last.Update) %>% 
          filter(State %in% isolate(values$State))
      }
      temp = temp %>% filter(Confirmed > 100) %>% 
        group_by(State) %>% 
        mutate(days = as.numeric(difftime(Last.Update, min(Last.Update), units = 'days'))) %>% 
        ungroup() %>% 
        arrange(State, days)
    } else if (input$type == "Capita") {
      if (length(values$State) < 1) {
        temp = data %>% arrange(Last.Update) %>% 
          select(Last.Update, State, Confirmed_capita, pop) %>% 
          rename(Confirmed = Confirmed_capita) %>% 
          na.omit() %>% 
          filter(State %in% (update_df %>% arrange(desc(Confirmed)) %>% head(5) %>% pull(State)))
      } else {
        temp = data %>% arrange(Last.Update) %>% 
          select(Last.Update, State, Confirmed_capita, pop) %>% 
          rename(Confirmed = Confirmed_capita) %>% 
          na.omit() %>% 
          filter(State %in% isolate(values$State))
      }
      temp = temp %>% 
        filter(Confirmed/100000*pop > 100) %>% 
        group_by(State) %>% 
        mutate(days = as.numeric(difftime(Last.Update, min(Last.Update), units = 'days'))) %>% 
        ungroup() %>% 
        arrange(State, days)
    }
    
    
    if (nrow(temp)>0) {
      p = ggplot(temp, aes(group=State, y=Confirmed, x=days)) + 
        geom_line(aes(linetype=State, colour=State),size=1.5)+
        #scale_y_continuous(limits = c(0, max(temp$Confirmed, na.rm = T)+10000))+
        #scale_x_date(date_breaks = '2 days')+
        xlab("")+ylab("Confirmed cases")+theme_bw()+
        scale_color_manual(values=c("#0078BF", "#00843D", "#F7C612", "#A61F56", "#F08122", "#5C2161"))+
        theme(legend.position=c(.2,.78),
              plot.title = element_text(hjust = 0.5),
              plot.subtitle = element_text(hjust = 0.5))+
        labs(title = "US Cumulative Cases of Coronavirus COVID-19",
             x="Days since 100th confirmed case", y="Cumulative confirmed cases")
      if (input$type == "Count") {
        if (length(values$State) > 0) {
          p = p + labs(subtitle = paste(values$State,collapse = ", "), y="Cumulative confirmed cases")
        } else {
          p = p + labs(subtitle = paste("Top 5 States on", update_time), y="Cumulative confirmed cases")
        }
      } else if (input$type == 'Capita') {
        if (length(values$State) > 0) {
          p = p + labs(subtitle = paste(values$State,collapse = ", "), y="Cumulative confirmed cases per 100,000 Inhabitants")
        } else {
          p = p + labs(subtitle = paste("Top 5 States on", update_time), y="Cumulative confirmed cases per 100,000 Inhabitants")
        }
      }
      p 
    }
    
  })
  
  output$cumdeath <- renderPlot({
    if (input$type == "Count") {
      if (length(values$State)<1) {
        temp = data %>% 
          arrange(Last.Update) %>% 
          group_by(Last.Update) %>% 
          summarise(Deaths = sum(Deaths)) %>% ungroup()
      } else {
        temp = data %>% 
          filter(State %in% isolate(values$State)) %>% 
          arrange(Last.Update) %>% 
          group_by(Last.Update) %>% 
          summarise(Deaths = sum(Deaths)) %>% 
          ungroup()
      }
      temp = rbind(temp %>% mutate(Deaths = Deaths-lag(Deaths)) %>% mutate(type='New'), 
                   temp %>% mutate(Deaths = lag(Deaths)) %>% mutate(type="Previous"))
      temp = temp %>% mutate(Deaths = ifelse(is.na(Deaths)|Deaths <0, 0, Deaths)) %>% 
        filter(Last.Update>=ymd("2020-03-01"))
      
      if (nrow(temp) > 0 & any(temp$Deaths)!=0) {
        p = ggplot(temp, aes(fill=type, y=Deaths, x=Last.Update)) + 
          geom_bar(position="stack", stat="identity")+
          #scale_y_continuous(limits = c(0, max(temp$Confirmed, na.rm = T)+10000))+
          scale_x_date(date_breaks = '2 days')+
          scale_fill_manual("", values = c("New" = "#0091e5", "Previous" = "#0078BF"))+
          xlab("")+theme_bw()+
          theme(legend.position=c(.2,.85),
                axis.text.x = element_text(angle = 90, hjust = 0.5),
                plot.title = element_text(hjust = 0.5),
                plot.subtitle = element_text(hjust = 0.5))+
          labs(title = "Cumulative Deaths of Coronavirus COVID-19", subtitle = "")
        if (length(values$State) > 0) {
          p + labs(subtitle = paste(values$State, collapse = ", "), y="Number of Deaths")
        } else {
          p + labs(subtitle = "United States", y="Number of Deaths")
        }
      } 
    } else if (input$type=="Capita") {
      if (length(values$State) < 1) {
        temp = data %>% 
          select(Last.Update, Deaths) %>% 
          na.omit() %>% 
          group_by(Last.Update) %>% 
          summarise(Deaths = sum(Deaths)) %>% 
          ungroup() %>% 
          mutate(Deaths = Deaths / tot_pop * 100000)
      } else {
        temp = data %>% 
          filter(State %in% isolate(values$State)) %>% 
          select(Last.Update, Deaths_capita) %>% 
          rename(Deaths = Deaths_capita) %>% 
          na.omit() %>% 
          group_by(Last.Update) %>% 
          summarise(Deaths = sum(Deaths)) %>% 
          ungroup()
      }
      temp = temp %>%  filter(Last.Update >= ymd("2020-03-04"))
      p =  ggplot(temp, aes(x=Last.Update, y = Deaths)) + 
        geom_point(colour="#0078BF") + geom_line(colour="#0078BF") + theme_bw() + 
        geom_text(label=formatC(round(temp$Deaths, 4),format='f',digits=4),vjust=1.5,size=3, color="#0091e5")+
        scale_x_date(date_breaks = '2 days')+
        theme(legend.position=c(.2,.85),
              axis.text.x = element_text(angle = 90, hjust = 0.5),
              plot.title = element_text(hjust = 0.5),
              plot.subtitle = element_text(hjust = 0.5))+
        labs(title="US Cumulative Deaths of Coronavirus COVID-19",
             x="", y="Cumulative deaths \nper 100,000 Inhabitants")
      if (length(values$State) > 0) {
        p + labs(subtitle = paste(values$State,collapse = ", "), y="Deaths per 100,000 Inhabitants")
      } else {
        p + labs(subtitle = "United States", y="Deaths per 100,000 Inhabitants")
      }
    }
  })
  
  output$cumdeath1 <- renderPlot({
    if (input$type == "Count") {
      if (length(values$State)<1) {
        temp = data %>% arrange(Last.Update) %>% 
          select(Last.Update, State, Deaths) %>% 
          filter(State %in% (update_df %>% arrange(desc(Deaths)) %>% head(5) %>% pull(State)))
      } else {
        temp = data %>% arrange(Last.Update) %>% 
          select(Last.Update, State, Deaths) %>% 
          filter(State %in% isolate(values$State))
      }
    } else if (input$type == "Capita") {
      if (length(values$State)<1) {
        temp = data %>% arrange(Last.Update) %>% 
          select(Last.Update, State, Deaths_capita) %>% 
          rename(Deaths = Deaths_capita) %>% na.omit() %>% 
          filter(State %in% (update_df %>% arrange(desc(Deaths)) %>% head(5) %>% pull(State)))
      } else {
        temp = data %>% arrange(Last.Update) %>% 
          select(Last.Update, State, Deaths_capita) %>% 
          rename(Deaths = Deaths_capita) %>% na.omit() %>% 
          filter(State %in% isolate(values$State))
      }
    } 
    temp = temp %>% filter(Last.Update>=ymd("2020-03-01"))
    if (nrow(temp) > 0 & any(temp$Deaths)!=0) {
      p = ggplot(temp, aes(group=State, y=Deaths, x=Last.Update)) + 
        geom_line(aes(linetype=State, colour=State),size=1.5)+
        #scale_y_continuous(limits = c(0, max(temp$Confirmed, na.rm = T)+10000))+
        scale_x_date(date_breaks = '2 days')+
        scale_color_manual(values=c("#0078BF", "#00843D", "#F7C612", "#A61F56", "#F08122", "#5C2161"))+
        xlab("")+ylab("Confirmed cases")+theme_bw()+
        theme(legend.position=c(.2,.75),
              axis.text.x = element_text(angle = 90, hjust = 0.5),
              plot.title = element_text(hjust = 0.5),
              plot.subtitle = element_text(hjust = 0.5))+
        labs(title = "US Cumulative Deaths of Coronavirus COVID-19",
             x="")
      if (input$type == "Count") {
        if (length(values$State) > 0) {
          p = p + labs(subtitle = paste(values$State,collapse = ", "), y="Cumulative Deaths")
        } else {
          p = p + labs(subtitle = paste("Top 5 States on", update_time), y="Cumulative Deaths")
        }
      } else if (input$type == 'Capita') {
        if (length(values$State) > 0) {
          p = p + labs(subtitle = paste(values$State,collapse = ", "), y="Cumulative Deaths per 100,000 Inhabitants")
        } else {
          p = p + labs(subtitle = paste("Top 5 States on", update_time), y="Cumulative Deaths per 100,000 Inhabitants")
        }
      }
      p
    }
  })
  
  output$cumdeath2 <- renderPlot({
    if (input$type == "Count") {
      if (length(values$State)<1) {
        temp = data %>% arrange(Last.Update) %>% 
          select(Last.Update, State, Deaths) %>% 
          filter(State %in% (update_df %>% arrange(desc(Deaths)) %>% head(5) %>% pull(State)))
      } else {
        temp = data %>% arrange(Last.Update) %>% 
          select(Last.Update, State, Deaths) %>% 
          filter(State %in% isolate(values$State))
      }
      temp = temp %>% filter(Deaths > 5) %>% 
        group_by(State) %>% 
        mutate(days = as.numeric(difftime(Last.Update, min(Last.Update), units = 'days'))) %>% 
        ungroup() %>% 
        arrange(State, days)
    } else if (input$type == "Capita") {
      if (length(values$State)<1) {
        temp = data %>% arrange(Last.Update) %>% 
          select(Last.Update, State, Deaths_capita, pop) %>% 
          rename(Deaths = Deaths_capita) %>% na.omit() %>% 
          filter(State %in% (update_df %>% arrange(desc(Deaths)) %>% head(5) %>% pull(State)))
      } else {
        temp = data %>% arrange(Last.Update) %>% 
          select(Last.Update, State, Deaths_capita, pop) %>% 
          rename(Deaths = Deaths_capita) %>% na.omit() %>% 
          filter(State %in% isolate(values$State))
      }
      temp = temp %>% 
        filter(Deaths/100000*pop > 5) %>% 
        group_by(State) %>% 
        mutate(days = as.numeric(difftime(Last.Update, min(Last.Update), units = 'days'))) %>% 
        ungroup() %>% 
        arrange(State, days)
    } 
    
    if (nrow(temp) > 0 & any(temp$Deaths)!=0) {
      p = ggplot(temp, aes(group=State, y=Deaths, x=days)) + 
        geom_line(aes(linetype=State, colour=State),size=1.5)+
        #scale_y_continuous(limits = c(0, max(temp$Confirmed, na.rm = T)+10000))+
        #scale_x_date(date_breaks = '2 days')+
        xlab("")+ylab("Confirmed cases")+theme_bw()+
        scale_color_manual(values=c("#0078BF", "#00843D", "#F7C612", "#A61F56", "#F08122", "#5C2161"))+
        theme(legend.position=c(.2,.78),
              plot.title = element_text(hjust = 0.5),
              plot.subtitle = element_text(hjust = 0.5))+
        labs(title = "US Cumulative Deaths of Coronavirus COVID-19",
             x="Days since 5th death case")
      if (input$type == "Count") {
        if (length(values$State) >0) {
          p = p + labs(subtitle = paste(values$State,collapse = ", "), y="Cumulative Deaths")
        } else {
          p = p + labs(subtitle = paste("Top 5 States on", update_time), y="Cumulative Deaths")
        }
      } else if (input$type == 'Capita') {
        if (length(values$State) >0) {
          p = p + labs(subtitle = paste(values$State,collapse = ", "), y="Cumulative Deaths per 100,000 Inhabitants")
        } else {
          p = p + labs(subtitle = paste("Top 5 States on", update_time), y="Cumulative Deaths per 100,000 Inhabitants")
        }
      }
      p 
    }
  })
  
  output$mymap <- renderLeaflet({
    bins1 = c(0,1,50,100,200,500,1000,5000,10000,20000,Inf)
    bins2 = c(0,5,10,15, 20, 30, 50,  70,  100,  250,  Inf)
    pal <- colorBin(c("#d6e9f5","#b2d6ec","#8fc4e3","#6bb1da","#479ed1","#248bc8","#0078bf","#0067a4","#00578a","#004873"),
                    domain={if(input$type=="Count") mymap$Confirmed else mymap$Confirmed_capita}, 
                    bins=if(input$type=="Count") bins1 else bins2)
    leaflet(mymap) %>% 
      addProviderTiles("OpenStreetMap.Mapnik") %>%
      setView(lat = 39.8283, lng = -98.5795, zoom = 4) %>% 
      addLegend(pal = pal, values = ~{if (input$type=="Count") pal(Confirmed) else pal(Confirmed_capita)}, opacity = 0.7, title = NULL,
                position = "bottomright")
  })
  
  observe({
    bins1 = c(0,1,50,100,200,500,1000,5000,10000,20000,Inf)
    bins2 = c(0,5,10,15, 20, 30, 50,  70,  100,  250,  Inf)
    pal <- colorBin(c("#d6e9f5","#b2d6ec","#8fc4e3","#6bb1da","#479ed1","#248bc8","#0078bf","#0067a4","#00578a","#004873"),
                    domain={if(input$type=="Count") mymap$Confirmed else mymap$Confirmed_capita}, 
                    bins=if(input$type=="Count") bins1 else bins2)
    leafletProxy("mymap", data = mymap) %>% 
      addPolygons(fillColor = ~ {if (input$type=="Count") pal(Confirmed) else pal(Confirmed_capita)},
                  layerId = ~NAME,
                  weight = 2,
                  opacity = 1,
                  color = "white",
                  dashArray = "3",
                  fillOpacity = 0.7,
                  highlight = highlightOptions(
                    weight = 5,
                    color = "#666",
                    dashArray = "",
                    fillOpacity = 0.7,
                    bringToFront = TRUE),
                  label = ~{if (input$type=="Count") labels else labels_capita},
                  labelOptions = labelOptions(
                    style = list("font-weight" = "normal", padding = "3px 8px"),
                    textsize = "15px",
                    direction = "auto"))
  })
  
}

