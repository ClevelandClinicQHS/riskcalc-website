## This App is a simple webpage on the Shiny server to list the selected Shiny risk calculators with
## their description

library(shiny)


shinyUI(basicPage(


         h1("Selected Risk Calculators from QHS, Cleveland Clinic Foundation (CCF)",align = "center",
            style= "color:forestgreen"),
         br(),
         p("These risk calculators are provided as a convenience service only to physicians and ",
           "is not intended to replace the physicians' medical advice. Without a visit to a physician,",
           " this tool must always be considered as an educational service only and are not designed to ",
           "replace a physician's independent judgment about the appropriateness or risks of a procedure or",
"recommendations for a given patient. CCF makes no representation or warranty concerning the accuracy or ",
"reliability of this information and does not warrant the results of using this tool. In no event shall CCF ",
"be liable for any damages, direct, indirect, consequential or otherwise, relating to the use of this information or this tool."),
br(),
tags$ol(
  tags$li(
  h4(a(tags$u("Predicting 2-year Probability of Conversion to Psychosis for Clinical High-risk Patients"),
   href ="http://riskcalc.org:3838/napls", style = "color:DodgerMediumBlue",target = "_blank"))
  ),
  #
  tags$li(
    h4(a(tags$u("Predicting the Discharge Status After Othotopic LIver Transplantation (OLT)"),
         href ="http://riskcalc.org:3838/LiverTransplantDischarge", style = "color:DodgerMediumBlue",target = "_blank"))
  ),
  #
  tags$li(
    h4(a(tags$u("Predicting 5-year Probability of Freedom From Disease Recurrence after Radical Prostatectomy"),
         href ="http://riskcalc.org:3838/PreopProstateRecurrence1998/", style = "color:DodgerMediumBlue",target = "_blank"))
  )
  
)

        )
        )


