
library(shiny)
library(shinyBS)
library(shinythemes)
library(shinyjs)


fluidPage(
    shinyjs::useShinyjs(), theme = shinytheme("flatly"),
    titlePanel('Predicts the risk of cardiogenic shock in electrical storm'),
    sidebarLayout(
        sidebarPanel(id = "sidebar",
                     selectInput('CVP', 'CVP > 10.5 mmHg', choices = c("No", "Yes")),
                     selectInput('LVEF', 'LVEF< 32.5%', choices = c("No", "Yes")),
                     selectInput('ICD', 'ICD-present', choices = c("No", "Yes")),
                     selectInput('lactate', 'Lactate > 2.15 mmol', choices = c("No", "Yes"))
        ),
        mainPanel(
            actionButton("goButton", "Run Calculator"),
            br(),
            hr(),
            tags$head(
                tags$style(type="text/css", "tfoot {display:none;}")
            ),
            
            DT::dataTableOutput('result'),
            br(),
            #wellPanel(h3('Click Below for Calculator and Author Contact Information'),
            #          p("[1] Busch, R. M., Hogue, O., Kattan, M. W., Hamberger, M., Drane, D. L., Hermann, B., Kim, M., Ferguson, L., Bingaman, W., Gonzalez-Martinez, J., Najm, I. M., & Jehi, L. (2018). ",a('Nomograms to predict naming decline after temporal lobe surgery in adults with epilepsy.', href='https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6282231/')," Neurology, 91(23), e2144–e2152. https://doi.org/10.1212/WNL.0000000000006629"),
            #          p("[2] Busch, R.M., Hogue, O., Miller, M., Ferguson, L., McAndrews, M.P., Hamberger, M., Kim, M., McDonald, C.R., Reyes, A., Drane, D.L., Hermann, B.P., Bingaman, W., Najm, I.M., Kattan, M.W., & Jehi, L. (2021).  Nomograms to predict verbal memory decline after temporal lobe resection in adults with epilepsy. Neurology. PMID: 34011574. DOI: 10.1212/WNL.0000000000012221")),
            wellPanel(h3('Disclaimer'),
                      p("No Medical Advice. ALTHOUGH SOME CONTENT MAY BE PROVIDED BY INDIVIDUALS IN THE MEDICAL PROFESSION, YOU ACKNOWLEDGE THAT PROVISION OF SUCH CONTENT DOES NOT CREATE A MEDICAL PROFESSIONAL-PATIENT RELATIONSHIP AND DOES NOT CONSTITUTE AN OPINION, MEDICAL ADVICE, PROFESSIONAL DIAGNOSIS, SERVICE OR TREATMENT OF ANY CONDITION. Access to general information is provided for educational purposes only, through this site and links to other sites. Content is not recommended or endorsed by any doctor or healthcare provider. The information and Content provided are not substitutes for medical or professional care, and you should not use the information in place of a visit, call, consultation or the advice of your physician or other healthcare provider. You are liable or responsible for any advice, course of treatment, diagnosis or any other information, services or product obtained through this site.")),
            p(a("Homepage",
                href = "../", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                                   font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
              " | ",
              a("Contact Us",
                href = "mailto:rcalcsupport@ccf.org?body=Predicting%20cognitive%20outcomes%20after%20epilepsy%20surgery", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                            font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
              style = "text-align: center;"),
            img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;")
        )
    )
)