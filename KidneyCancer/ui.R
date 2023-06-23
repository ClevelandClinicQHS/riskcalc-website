

require(shinythemes)
fluidPage(theme = shinytheme("flatly"),
          tags$head(tags$link(rel="shortcut icon", href="../assets/icons/favicon.ico", type="image/x-icon")),
          tags$head(tags$link(rel="apple-touch-icon", href="../assets/icons/apple-touch-icon.png", type="image/x-icon")),
      tags$script(HTML(
    'function myFunction() {
  var txt;
  if (confirm("This is a mailbox for reporting website errors to programmers for the risk calculator website.  If you have questions or concerns about a specific calculator, please use the calculator Author Contact Information found on the publication for that calculator.  Each calculator is documented by a specific publication with a corresponding author.")) {
    window.open("mailto:rcalcsupport@ccf.org");
  }
}'
  )),
    titlePanel('Renal Cell Carcinoma - Outcomes using Post-Op Information'),
    sidebarLayout(
        sidebarPanel(
            id = "sidebar"
            ,
            selectInput(
                'Symptoms',
                'Symptoms/Presentation',
                choices = c('Local', 'Systemic', 'Incidental', 'Unknown')
            ),
            selectInput(
                'Histology',
                'Histology',
                choices = c('Conventional', 'Papillary', 'Chromophobe', 'Unknown')
            ),
            textInput('TumorSize', 'Tumor size (cm)', placeholder = '0.5 - 21'),
            selectInput(
                'PStage97',
                '1997 P Stage',
                choices = c('P1', 'P2', 'P3A', 'P3B/C', 'Unknown')
            ),
            textInput('AgeYr', 'Age (years)', placeholder = '14 - 92'),
            selectInput('Gender', 'Gender', choices = c('Female', 'Male')),
            selectInput('ASA', 'ASA score', choices = c('0,1', '2', '3,4', 'Unknown')),
            textInput('PreOpCR', 'Pre-operative Creatinine (mg/dL)', placeholder = '0 - 8.4'),
            textInput(
                'PerDecreaseKidneyVolume',
                'Percent Change in Kidney Volume (%)',
                placeholder = '-97 - 100'
            ),
            selectInput(
                'x002pT',
                '2002pT',
                choices = c('T1A', 'T1B', 'T2', 'T3A', 'T3B', 'Unknown')
            ),
            selectInput('Grade', 'Grade', choices = c('1', '2', '3', '4', 'Unknown')),
            selectInput('Necrosis', 'Necrosis', choices = c('No', 'Yes', 'Unknown')),
            selectInput('VascInv', ' Microvascular Invasion', choices = c('No', 'Yes', 'Unknown'))
        ),
        mainPanel(
            actionButton("goButton", "Run Calculator"),
            br(),
            hr(),
            tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
            br(),
            wellPanel(
                h3('Click Below for Calculator and Author Contact Information'),
                p(
                    "[1] Kattan MW, Reuter V, Motzer RJ, Katz J, Russo P. ",
                    a(
                        'A postoperative prognostic nomogram for renal cell carcinoma',
                        href = 'http://dx.doi.org/10.1016/S0022-5347(05)66077-6'
                    ),
                    ". J Urol. 2001 Jul;166(1):63-7"
                ),
                p(
                    "[2] Sorbellini M, Kattan MW, Snyder ME, Reuter V, Motzer R, Goetzl M, McKiernan J, Russo P. ",
                    a(
                        'A postoperative prognostic nomogram predicting recurrence for patients with conventional clear cell renal cell carcinoma',
                        href = 'http://dx.doi.org/10.1097/01.ju.0000148261.19532.2c'
                    ),
                    ". J Urol. 2005 Jan;173(1):48-51"
                )
            ),
            wellPanel(h3('Disclaimer'),
                            p("No Medical Advice. ALTHOUGH SOME CONTENT MAY BE PROVIDED BY INDIVIDUALS IN THE MEDICAL PROFESSION, YOU ACKNOWLEDGE THAT PROVISION OF SUCH CONTENT DOES NOT CREATE A MEDICAL PROFESSIONAL-PATIENT RELATIONSHIP AND DOES NOT CONSTITUTE AN OPINION, MEDICAL ADVICE, PROFESSIONAL DIAGNOSIS, SERVICE OR TREATMENT OF ANY CONDITION. Access to general information is provided for educational purposes only, through this site and links to other sites. Content is not recommended or endorsed by any doctor or healthcare provider. The information and Content provided are not substitutes for medical or professional care, and you should not use the information in place of a visit, call, consultation or the advice of your physician or other healthcare provider. You are liable or responsible for any advice, course of treatment, diagnosis or any other information, services or product obtained through this site.")),
p(a("Homepage",
                href = "../", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"), 
              " | ",
              a("Website Error Messages",
                href = "javascript:myFunction()",
 style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"), 
 " | ",
 a("Add to phone (iOS Safari)", href="https://support.apple.com/guide/iphone/bookmark-favorite-webpages-iph42ab2f3a7/ios#iph4f9a47bbc", target="_blank", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
 " | ", 
 a("Add to phone (Android)", href="https://www.cnet.com/tech/mobile/adding-one-touch-bookmarks-to-your-androids-home-screen/", target="_blank", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
              style = "text-align: center;"),
            img(src = '../logo-ccf.png', style = "max-width:30%; max-height:100%;")
        )
    )
)
