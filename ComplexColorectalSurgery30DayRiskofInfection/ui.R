
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

          titlePanel('Complex Colorectal Surgery - 30-day Risk of Postoperative Organ Space Surgical Site Infection'),
          sidebarLayout(
              sidebarPanel(id = "sidebar"
                           ,
                           textInput('AgeYr', 'Age (years)', placeholder = '18 - 90'),
                           selectInput('Gender', 'Gender', choices = c('Male', 'Female')),
                           textInput('BMI', 'Body Mass Index (kg/m^2)', placeholder = '15 - 50'),
                           selectInput('Smoke', 'Smoke', choices = c('No', 'Yes')),
                           selectInput('SurgSite', 'Surgical Site', choices = c('Rectum', 'Small Bowel', 'Colon')),
                           selectInput('ASAClass', 'ASA Class', choices = c('1 Normal', '2 Mild Systemic Disease', '3 Severe Systemic Disease', '4-5 Life Threatening Disease or Moribund')),
                           selectInput('WoundClass', 'Wound Class', choices = c('1-2 Clean-Clean/Contaminated', '3 Contaminated', '4 Dirty/Infected')),
                           selectInput('Diabetes2', 'Diabetic?', choices = c('No', 'Yes')),
                           selectInput('Steroid', 'Steroid Medication?', choices = c('No', 'Yes')),
                           selectInput('Proper30', 'Prior Surgery in the Past 30 Days?', choices = c('No', 'Yes')),
                           selectInput('Radio', 'Radiotherapy?', choices = c('No', 'Yes')),
                           selectInput('Technique', 'Surgical Technique', choices = c('Open', 'Laparoscopic')),
                           textInput('Creatinine', 'Serum Creatinine (mg/dL)', placeholder = '0.1 - 6'),
                           textInput('Albumin', 'Serum Albumin (g/dL)', placeholder = '1 - 6'),
                           selectInput('Transfusion', 'Transfusion?', choices = c('No', 'Yes')),
                           textInput('OpTime', 'Duration of Surgery (minutes)', placeholder = '0 - 540')),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  hr(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  dataTableOutput('result'),
                  br(),
                  wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] de Campos-Lobato LF, Wells B, Wick E, Pronty K, Kiran R, Remzi F, Vogel JD. ",a('Predicting organ space surgical site infection with a nomogram', href='http://www.springerlink.com/content/b655l7655850l444/fulltext.pdf'),". J Gastrointest Surg. 2009 Nov;13(11):1986-92. doi: 10.1007/s11605-009-0968-6. Epub 2009 Sep 16. Erratum in: J Gastrointest Surg. 2011 Mar;15(3):540. Campos-Lobato, Luiz F [corrected to de Campos-Lobato, Luiz F]")),
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