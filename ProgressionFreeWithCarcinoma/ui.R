
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

          titlePanel('Predicted 12-Month Progression-Free Survival for Patients with Metastatic Renal Cell Carcinoma'),
          sidebarLayout(
              sidebarPanel(id = "sidebar",
                           textInput('CCA', 'Corrected Calcium (mg/dL)', placeholder = '7-14'),
                           textInput('METSITE', 'Number of Metastatic Sites', placeholder = '1-7'),
                           selectInput('LUNGGP', 'Lung Metastases', choices = c("No", "Yes")),
                           selectInput('LIVERGP', 'Liver Metastases', choices = c("No", "Yes")),
                           selectInput('METBONYN', 'Bone Metastases', choices = c("No", "Yes")),
                           selectInput('NEPGP', 'Prior Nephrectomy', choices = c("No", "Yes")),
                           selectInput('THRGRP', 'Thrombocytosis', choices = c("No", "Yes")),
                           selectInput('ECOGGP', 'ECOG PS', choices = c("0", "1")),
                           selectInput('neutrophil', 'Neutrophil Count', choices = c(">= ULN", "< ULN")),
                           selectInput('HGBGP', 'Hemoglobin g/L', choices = c(">= LLN", "< LLN")),
                           textInput('Time', 'Time From Diagnosis to Treatment (months)', placeholder = '0 - 300'),
                           textInput('ALB_PLC', 'Serum Albumin (g/dL)', placeholder = '0 - 6'),
                           textInput('ALK', 'Alkaline Phosphatase (ALP) Upper Limit of Normal', placeholder = '0 - 8'),
                           textInput('LDHULN', 'Lactate Dehydrogenase (LDH), Upper Limit of Normal', placeholder = '0.2-4')),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
                  br(),
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),
                            p("[1] Motzer RJ, Bukowski RM, Figlin RA, Hutson TE, Michaelson MD, Kim ST, Baum CM, Kattan MW. ",a('Prognostic nomogram for sunitinib in patients with metastatic renal cell carcinoma', href='http://onlinelibrary.wiley.com/doi/10.1002/cncr.23776/abstract;jsessionid=3553F12176B232EEDFE400C34A87BCFF.f04t01'),".  Cancer. 2008 Oct 1;113(7):1552-8. doi: 10.1002/cncr.23776."),
                            p("[2] Kattan M.W., Sternberg C.N., Mehmud F., Bhatt K., McCann L., Motzer R.J.", a(" Development and Validation of a Prognostic Nomogram for Progression-Free Survival in Patients with Advanced Renal Cell Carcinoma Treated with Pazopanib", href = "http://www.karger.com/Article/FullText/430989"), ". Oncology. 2015 Jun 17.")),
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
                  img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;"))))