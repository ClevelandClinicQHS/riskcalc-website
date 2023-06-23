library(shiny)
library(shinyjs)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyWidgets)
library(shinycssloaders)
library(leaflet)
library(tidyverse)
library(lubridate)
library(sf)

# library(tidycensus)
# library(tidyverse)
# library(rmapshaper)
# 
# census_api_key("1f9ec8043c07df314c33eb363518931cc231aa05", install = T)
# 
# pop = get_acs("state", variables = "B01003_001", year = 2017)
# usmap= us_boundaries(type = "state")
# usmap = states(cb=F, resolution="20m")
# usmap = sf::st_as_sf(usmap)
# usmap = left_join(usmap, pop %>% select(NAME, estimate) %>% rename(pop = estimate))
# usmap = rmapshaper::ms_simplify(usmap)
# saveRDS(usmap, 'usmap.RDS', version=2)

load("covid.RData")
`%notin%` <- Negate(`%in%`)
usmap = readRDS("usmap.RDS")
tot_pop = sum(usmap$pop, na.rm=T)

i = 0
max_diff = as.numeric(Sys.Date() - update_time)
message(Sys.Date())
while (i < max_diff) {
  prev_day = paste(substr(as.character(Sys.Date()-days(i)),6,7),"-",
                   substr(as.character(Sys.Date()-days(i)),9,10), "-",
                   substr(as.character(Sys.Date()-days(i)),1,4), ".csv", sep = '')
  print(prev_day)
  file = paste("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/", 
               prev_day, sep="")
  tryCatch(download.file(file, paste("./data/", prev_day,sep = ''), mode = "w", quiet = FALSE), 
           error = function(e) print(paste(file, 'did not work out')))  
  i = i + 1
}

temp = list.files(path="./data/",pattern="*.csv")
if (length(temp) > 0) {
  myfiles = lapply(paste("./data/", temp, sep=""), read.csv)
  file.remove(paste("./data/", temp, sep=""))
  myfiles = lapply(1:length(myfiles), function(x) {
    df = myfiles[[x]]
    names(df) = make.names(names(df), allow_ = FALSE)
    df = df %>% select("Province.State","Country.Region","Last.Update","Confirmed",
                       "Deaths","Recovered")
    df$Last.Update = str_replace(temp[x], ".csv", "")
    df
  })
  
  df = do.call("rbind", myfiles)
  df = df %>% 
    filter(Country.Region == "US") %>% 
    mutate(Last.Update = mdy(Last.Update)) %>% 
    # mutate(Last.Update = str_replace(Last.Update, "[ T].*$", "")) %>% 
    # mutate(Last.Update = ifelse(str_detect(Last.Update, "/"), 
    #                             paste("2020-",str_extract(Last.Update, "^[0-9]+"), "-", str_extract("1/20/20", "(?<=/)[0-9]+"), sep=""),
    #                             Last.Update)) %>% 
    mutate(Deaths = ifelse(is.na(Deaths), 0, Deaths),
           Recovered = ifelse(is.na(Recovered), 0, Recovered),
           Confirmed = ifelse(is.na(Confirmed), 0, Confirmed)) %>% 
    mutate(Last.Update = ymd(Last.Update)) %>% 
    mutate(State = case_when(
      str_detect(Province.State, "Diamond") ~ "Diamond Princess",
      str_detect(Province.State, "Puerto Rico") ~ "Puerto Rico",
      str_detect(Province.State, "Grand Princess") ~ "Grand Princess",
      str_detect(Province.State, "Chicago") ~ "Illinois",
      str_detect(Province.State, "Virgin Islands") ~ "United States Virgin Islands",
      TRUE                                     ~ as.character(Province.State)),
      State = as.character(State))
  for (i in 1:nrow(usmap)) {
    df = df %>% mutate(State = ifelse(str_detect(State, usmap$STUSPS[i]), usmap$NAME[i], State))
  }
  df = df %>% mutate(State = ifelse(State %in% c("Grand Princess", "Diamond Princess", usmap$NAME), State, "Other"))
  df = left_join(df, usmap %>% select(NAME, pop) %>% filter(!is.na(pop)), by=c("State"="NAME"))
  df$geometry=NULL
  df = df %>% 
    group_by(Last.Update, State, pop) %>% 
    summarise(Confirmed = sum(Confirmed),
              Deaths = sum(Deaths)) %>% 
    ungroup() %>% 
    mutate(Confirmed_capita = Confirmed / pop * 100000,
           Deaths_capita = Deaths / pop * 100000)
  
  data = rbind(data, df)
}

update_time = max(data$Last.Update)
update_df = data %>% 
  filter(Last.Update == update_time) %>% 
  mutate(labels = paste("<strong>", State,"</strong><br/>Confirmed: ",
                        formatC(Confirmed,format="d", big.mark=","),
                        "<br/>Death:",
                        formatC(Deaths,format="d", big.mark=","), sep="") %>% 
           lapply(htmltools::HTML)) %>% 
  mutate(labels_capita = paste("<strong>", State,"</strong><br/>Confirmed: ",
                               formatC(Confirmed_capita,format="f", digits=2, big.mark=","),
                               "<br/>Death:",
                               formatC(Deaths_capita,format="f", digits=4, big.mark=","), sep="") %>% 
           lapply(htmltools::HTML))

mymap = inner_join(usmap, update_df %>% filter(!is.na(Confirmed_capita)) %>% select(-pop), by=c("NAME"="State"))

save(list = c("data", "update_time"), file = "covid.RData", version = 2)

dropdownActionMenu <- function (..., title=NULL, icon = NULL, .list = NULL, header=NULL) {
  items <- c(list(...), .list)
  lapply(items, shinydashboard:::tagAssert, type = "li")
  type <- "notifications" 
  dropdownClass <- paste0("dropdown ", type, "-menu")
  
  tags$li(class = dropdownClass, style="padding:0;margin:0;",
          a(href = "#", class = "dropdown-toggle",
            `data-toggle` = "dropdown", icon, title), tags$ul(class = "dropdown-menu",
                                                              if(!is.null(header)) tags$li(class="header",header),
                                                              tags$li(tags$ul(class = "menu", items))))
}

message(paste("Date", update_time))


ui <- dashboardPage(
  dashboardHeader(title = "COVID-19 Coronavirus US Cases", 
                  titleWidth = '100%',
                  dropdownActionMenu(title=h4(textOutput("title"),style="padding:0;margin:0;width:200px;")
                  )),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    useShinyjs(),
    tags$head(tags$style(HTML('
        .content-wrapper { height: 1550px !important;}
        .navbar-custom-menu {padding-top:4px !important;padding-bottom:4px !important; margin:0 !important}
        .nav .navbar-nav {padding-top:4px !important;padding-bottom:4px !important; margin:0 !important}
        .dropdown .notifications-menu {padding-top:4px !important;padding-bottom:4px !important; margin:0 !important}
        .dropdown-toggle {padding-top:4px !important;padding-bottom:4px !important; margin:0 !important}
        
        /* logo */
        .skin-blue .main-header .logo {
                              background-color: #384d5f;
                              min-height:55px !important;
                              padding-top: 5px !important;
                              font-weight: 450;
                              }

        /* logo when hovered */
        .skin-blue .main-header .logo:hover {
                              background-color: #384d5f;
                              min-height:55px !important;
                              padding-top: 5px !important;
                              font-weight: 450;
                              }

        /* navbar (rest of the header) */
        .skin-blue .main-header .navbar {
                              background-color: #384d5f;
                              min-height:55px !important;
                              }        

        /* main sidebar */
        .skin-blue .main-sidebar {
                              background-color: #f4b943;
                              }

        /* active selected tab in the sidebarmenu */
        .skin-blue .main-sidebar .sidebar .sidebar-menu .active a{
                              background-color: #ff0000;
                              }

        /* other links in the sidebarmenu */
        .skin-blue .main-sidebar .sidebar .sidebar-menu a{
                              background-color: #00ff00;
                              color: #000000;
                              }

        /* other links in the sidebarmenu when hovered */
         .skin-blue .main-sidebar .sidebar .sidebar-menu a:hover{
                              background-color: #ff69b4;
                              }
        /* toggle button when hovered  */                    
         .skin-blue .main-header .navbar .sidebar-toggle:hover{
                              background-color: #ff69b4;
                              }
                              '))),
    style="padding-top:1;marging-top:0;boader-width:0",
    column(3,
           style="padding:0;marging:0;",
           column(12, align="center",
             style="display:inline-block",
             radioGroupButtons(
               inputId = "type",
               label = NULL, 
               choices = c("Absolute Counts" = "Count", "Per Capita" = "Capita"),
               status = "primary"
             )
           ),
           box(
             style="text-align:center;padding:0;marging:0;",
             solidHeader = F,
             title = h3(textOutput("subtitle1"), style="text-align:center;padding:0;margin:0;"),
             background = NULL,
             width = 12,
             status = "danger",
             
             conditionalPanel(
               condition = "input.type == 'Count'",
               descriptionBlock(
                 number = formatC(sum(update_df %>% pull(Confirmed))-sum(data %>% filter(Last.Update==update_time-days(1)) %>% pull(Confirmed)),format="d", big.mark=","), 
                 number_color = "red", 
                 number_icon = "fa fa-caret-up",
                 header = h1(formatC(sum(update_df %>% pull(Confirmed)),format="d", big.mark=","),style="font:bold;padding:0;margin:0"),
                 right_border = FALSE,
                 margin_bottom = FALSE
               )
             ),
             conditionalPanel(
               condition = "input.type == 'Capita'",
               descriptionBlock(
                 header = h1(formatC(sum(update_df$Confirmed,na.rm=T) / tot_pop * 100000, format='f', digits = 2),style="font:bold;padding:0;margin:0"),
                 right_border = FALSE,
                 margin_bottom = FALSE
               )
             ),
             
             br(),
             p("- Top 5 -", style="text-align:center;padding:0;marging:0;"),
             div(DT::dataTableOutput("confirm") %>% withSpinner(color="#0dc5c1"), style="padding:0;margin:0;font-align:center;font-size:100%;width:100%")
           ),
           box(
             style="text-align:center;padding:0;marging:0;",
             solidHeader = F,
             title = h3(textOutput("subtitle2"), style="text-align:center;padding:0;margin:0;"),
             background = NULL,
             width = 12,
             status = "danger",
             
             conditionalPanel(
               condition = "input.type == 'Count'",
               descriptionBlock(
                 number = formatC(sum(update_df %>% pull(Deaths))-sum(data %>% filter(Last.Update==update_time-days(1)) %>% pull(Deaths)),format="d", big.mark=","), 
                 number_color = "red", 
                 number_icon = "fa fa-caret-up",
                 header = h1(formatC(sum(update_df %>% pull(Deaths)),format="d", big.mark=","),style="font:bold;padding:0;margin:0"),
                 right_border = FALSE,
                 margin_bottom = FALSE
               )
             ),
             conditionalPanel(
               condition = "input.type == 'Capita'",
               descriptionBlock(
                 header = h1(formatC(sum(update_df$Deaths) / tot_pop * 100000, format='f', digits = 4),style="font:bold;padding:0;margin:0"),
                 right_border = FALSE,
                 margin_bottom = FALSE
               )
             ),
             br(),
             p("- Top 5 -", style="text-align:center;padding:0;marging:0;"),
             div(DT::dataTableOutput("death") %>% withSpinner(color="#0dc5c1"), style="padding:0;margin:0;font-size:100%;width:100%")
           ),
           box(
             style="text-align:center;padding:1;marging:0;",
             solidHeader = F,
             title = NULL,
             background = NULL,
             width = 12,
             status = "primary",
             
             h4("Data obtained from ", a("Johns Hopkins CSSE", href='https://github.com/CSSEGISandData/COVID-19'), paste("on", Sys.Date()), br(),br(),
                "Quantitative Health Sciences Department", br(),
                "Center for Populations Health Research", br(),
                "Lerner Research Institute, Cleveland Clinic", style="text-align:left;padding:0;marging:0;")
           )
    ),
    column(9,
           style="padding:0;marging:0;",
           div(
             textOutput("note"),
             leafletOutput("mymap", height=650) %>% withSpinner(color="#0dc5c1"),
             div(textOutput('note2'), style="text-align:center;padding:0;margin:0;")
           ),
           div(
             style="height:40px;",
             div(id="status_update",
                 style="padding:0;marging:0;",
                 uiOutput("status")
             )
           ),
           column(4,style="text-align:center;padding:0;marging:0;",plotOutput("cumconf") %>% withSpinner(color="#0dc5c1")),
           column(4,style="text-align:center;padding:0;marging:0;",plotOutput("cumconf1") %>% withSpinner(color="#0dc5c1")),
           column(4,style="text-align:center;padding:0;marging:0;",plotOutput("cumconf2") %>% withSpinner(color="#0dc5c1")),
           br(),
           column(4,style="text-align:center;padding:0;marging:0;",plotOutput("cumdeath") %>% withSpinner(color="#0dc5c1")),
           column(4,style="text-align:center;padding:0;marging:0;",plotOutput("cumdeath1") %>% withSpinner(color="#0dc5c1")),
           column(4,style="text-align:center;padding:0;marging:0;",plotOutput("cumdeath2") %>% withSpinner(color="#0dc5c1"))
    )
  )
)

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
          select(Last.Update, Confirmed_capita) %>% 
          na.omit() %>% 
          arrange(Last.Update) %>% 
          group_by(Last.Update) %>% 
          rename(Confirmed = Confirmed_capita) %>% 
          summarise(Confirmed = sum(Confirmed)) %>% 
          ungroup() 
      } else {
        temp = data %>% 
          select(Last.Update, Confirmed_capita, State) %>% 
          rename(Confirmed = Confirmed_capita) %>% 
          na.omit() %>% 
          filter(State %in% values$State) %>% 
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
          select(Last.Update, Deaths_capita) %>% 
          rename(Deaths = Deaths_capita) %>% 
          na.omit() %>% 
          group_by(Last.Update) %>% 
          summarise(Deaths = sum(Deaths)) %>% 
          ungroup()
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

# Run the application 
shinyApp(ui = ui, server = server)
