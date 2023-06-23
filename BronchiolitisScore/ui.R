library(shiny)
ui <- fluidPage(
    fluidPage(
        titlePanel("Bronchiolitis Score"),
        fluidRow(
            column(4,
                   wellPanel(
                       h4("Upload your data"),
                   fileInput('file1', 'Choose CSV File',
                             accept=c('text/csv', 
                                      'text/comma-separated-values,text/plain', 
                                      '.csv')),
                   tags$hr(),
                   radioButtons('sep', 'Separator',
                                c(Comma=',',
                                  Semicolon=';',
                                  Tab='\t'),
                                ','),
                   radioButtons('quote', 'Quote',
                                c(None='',
                                  'Double Quote'='"',
                                  'Single Quote'="'"),
                                '"')
                   ),
                   wellPanel(
                       h4("Download data with prediction"),
                       downloadButton('downloadData', 'Download')
                   )
            ),
            column(8,
                   wellPanel(
                       h3("Instruction"),
                       h4("The uploaded file must have the following columns (headers are case sensitive): "),
                       p("Weight"),
                       p("Comorbid: 0 if no, 1 if yes"),
                       p("EarlyIntubation: 0 if no, 1 if yes"),
                       p("Time.from.Hospital.Admission.to.ICU.Admission in hours"),
                       p("High.HR"),
                       p("Low.HR"),
                       p("High.RR"),
                       p("High.T"),
                       p("Low.T"),
                       p("Lowest.pH"),
                       p("Highest.PCO2"),
                       p("Lowest.Bicarb"),
                       p("High.Blood.Urea.Nitrogen"),
                       p("Worst.Glascow.Coma.Score"),
                       p("Low.White.Blood.Cell.Count"),
                       p("RSV.Positive: 0 if no, 1 if yes"),
                       hr(),
                       h4("Include the following columns to get predictions based on updated models:"),
                       p("FiO2"),
                       p("MINSpO2"),
                       hr(),
                       h5("We don't store your data.")
                   )
            )
        )
    )
)
