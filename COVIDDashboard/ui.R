
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

ui <- dashboardPage(
  dashboardHeader(title = "COVID-19 Coronavirus US Cases", 
                  titleWidth = '100%',
                  dropdownActionMenu(title=h4(textOutput("title"),style="padding:0;margin:0;width:200px;")
                  )),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    useShinyjs(),
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
    ),
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
           radioGroupButtons(
             inputId = "scale",
             label = NULL, 
             choices = c("Raw" = "Raw", "Log10" = "Log"),
             status = "info"
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

