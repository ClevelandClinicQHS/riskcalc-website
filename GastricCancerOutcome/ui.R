library(shiny)
library(shinyBS)
library(shinyjs)
fluidPage(
  useShinyjs(),
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
      # Application title
      titlePanel("Predicting overall survival and disease-specific mortality for pretreatment gastric cancer patient"),
      
      # Sidebar with a slider input for number of bins 
      sidebarLayout(
        sidebarPanel(
               numericInput("Age", "Age (years)", min = 18, max = 90, value = 20),
               bsTooltip("Age", "Range: 18 - 90", "bottom", options = list(container = "body")),
               numericInput("PreSize", "Tumor size (mm)", min = 2, max = 250, value = 20),
               bsTooltip("PreSize", "Range: 2 - 250", "bottom", options = list(container = "body")),
               numericInput("NumRegioLN", "cN (number)", min = 0, max = 42, value = 0),
               bsTooltip("NumRegioLN", "Range: 0 - 42", "bottom", options = list(container = "body")),
               numericInput("SerumCEA", "Serum CEA (ng/ml)", min = 0.5, max = 35000, value = 2),
               bsTooltip("SerumCEA", "Range: 0.5 - 35,000", "bottom", options = list(container = "body")),
               numericInput("SerumCA", "Serum CA19-9 (U/ml)", min = 2, max = 700000, value = 8),
               bsTooltip("SerumCA", "Range: 2 - 700,000", "bottom", options = list(container = "body")),
               selectInput("LocCox", "Location", 
                           choices = c("Lower (antrum, pylorus)" = "L",
                                       "Middle (body)" = "M",
                                       "Upper (cardia, fundus)" = "U",
                                       "Entire (overlapping stomach)" = "Entire",
                                       "EGJ (esophago-gastric junction tumor)" = "EGJ")),
               selectInput("cT", "cT", 
                           choices = c("cT1a=mucosa" = "T1a",
                                       "cT1b=submucosa" = "T1b",
                                       "cT2=propria musclaris" = "T2",
                                       "cT3=subserosa" = "T3",
                                       "cT4a=serosal invasion" = "T4a",
                                       "cT4b=adjacent organ involvement" = "T4b")),
               selectInput("cNJPN", "cN (Location)", 
                           choices = c("cN0" = "N0",
                                       "cN1 (perigastric or No.110 if EGJ)" = "N1",
                                       "cN2a (No.7, 8a, 9)" = "N2a",
                                       "cN2b (No 10,11p,11d,12a or 19, 20, 111 if EGJ)" = "N2b",
                                       "cNM (intra-abdominal non-regional LN)" = "NM")),
               selectInput("Liver", "Liver metastasis", choices = c("Negative", "Solitary", "Multiple")),
               selectInput("Peritoneum", "Peritoneum", choices = c("Negative", "Positive")),
               selectInput("cM", "cM", choices = c("Negative", "Positive")),
               selectInput("MacroType", "Macroscopic type", 
                           choices = c("Type0", "Type1", "Type2", "Type3", "Type4")),
               selectInput("Histology", "Histology", 
                           choices = c("G1 (well differentiated type)" = "G1",
                                       "G2 (moderately differentiated type)" = "G2",
                                       "G3 (poorly differentiated or Undifferentiated type)" = "G3")),
               selectInput("ECOGPS", "ECOG performance status", choices = c("0", "1", "2", "3 or 4")),
               selectInput("Sex", "Sex", choices = c("Female"="F", "Male"="M"))
        ),
        
        # Show a plot of the generated distribution
      mainPanel(
               #actionButton("goButton", "Run Calculator"),
               #br(),
               #br(),
               tags$head(tags$style(type = "text/css", "tfoot {display:none;}")),
               DT::dataTableOutput('result'),
               br(),
               uiOutput("TotalPoint1"),
               br(),
               wellPanel(h3('Reference'),
                         p("[1] Bando E, Ji X, Kattan MW, Seo HS, Song KY, Park CH, Bencivenga M, de Manzoni G, Terashima M. Development and validation of a pretreatment nomogram to predict overall survival in gastric cancer. Cancer Med. 2020 Aug;9(16):5708-5718"),
                         p("[2] Bando E, Ji X, Kattan MW, Bencivenga M, de Manzoni G, Terashima M. Development and validation of pretreatment nomogram for disease-specific mortality in gastric cancer-A competing risk analysis. Cancer Med. 2021 Oct 10. doi: 10.1002/cam4.4279. Online ahead of print.")),
               wellPanel(h3('Disclaimer'),
                         p("No Medical Advice. ALTHOUGH SOME CONTENT MAY BE PROVIDED BY INDIVIDUALS IN THE MEDICAL PROFESSION, YOU ACKNOWLEDGE THAT PROVISION OF SUCH CONTENT DOES NOT CREATE A MEDICAL PROFESSIONAL-PATIENT RELATIONSHIP AND DOES NOT CONSTITUTE AN OPINION, MEDICAL ADVICE, PROFESSIONAL DIAGNOSIS, SERVICE OR TREATMENT OF ANY CONDITION. Access to general information is provided for educational purposes only, through this site and links to other sites. Content is not recommended or endorsed by any doctor or healthcare provider. The information and Content provided are not substitutes for medical or professional care, and you should not use the information in place of a visit, call, consultation or the advice of your physician or other healthcare provider. You are liable or responsible for any advice, course of treatment, diagnosis or any other information, services or product obtained through this site.")),
               p(a("Homepage",
                   href = "../", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                                   font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
                 " | ",
                 a(
                   "Website Error Messages",
                   href = "javascript:myFunction()",
                   #href = "mailto:rcalcsupport@ccf.org",
                   style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
                 ),
                 " | ",
                 a("Add to phone (iOS Safari)", href="https://support.apple.com/guide/iphone/bookmark-favorite-webpages-iph42ab2f3a7/ios#iph4f9a47bbc", target="_blank", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
                 " | ", 
                 a("Add to phone (Android)", href="https://www.cnet.com/tech/mobile/adding-one-touch-bookmarks-to-your-androids-home-screen/", target="_blank", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
                 " | ",
                 a("Source Code", 
                   href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/GastricCancerOutcome", 
                   style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
                 ),
                 style = "text-align: center;"
               ),
               img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;")
               
        )
)
)
