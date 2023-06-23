require(shinythemes)
fluidPage(theme = shinytheme("flatly"),
    tags$script(HTML(
    'function myFunction() {
  var txt;
  if (confirm("This is a mailbox for reporting website errors to programmers for the risk calculator website.  If you have questions or concerns about a specific calculator, please use the calculator Author Contact Information found on the publication for that calculator.  Each calculator is documented by a specific publication with a corresponding author.")) {
    window.open("mailto:rcalcsupport@ccf.org");
  }
}'
  )),
          titlePanel('CRT response score calculator'),
          sidebarLayout(
              sidebarPanel(id = "sidebar",
                           textInput('qrsd_in_raw', 'QRS duration (milliseconds)', placeholder = '>= 0'),
                           selectInput('morph_in', 'QRS morphology', choices = c("LBBB", "RBBB", "IVCD", "RV-paced")),
                           textInput('ef_in_raw', 'Left ventricular ejection fraction', placeholder = '0 - 100'),
                           textInput('nyha_in_raw', 'NYHA heart failure classification', placeholder = '0 - 4'),
                           selectInput('gender_in', 'Gender', choices = c('Male', 'Female')),
                           textInput('lvedd_in_raw', 'Left ventricular end-diastolic diameter (cm)', placeholder = '>= 0'),
                           selectInput('ICM_in', 'Ischemic etiology of cardiomyopathy', choices = c('non-ischemic', 'ischemic')),
                           selectInput('AF_in', 'History of atrial fibrillation', choices = c('No', 'Yes')),
                           selectInput('epi_in', 'Placement of epicardial LV lead', choices = c('No', 'Yes'))),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  br(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  wellPanel(htmlOutput('result')),
                  br(),
                  # wellPanel(h3('Click Below for Calculator and Author Contact Information'),p("[1] Kumbhani DJ, Wells BJ, Lincoff AM, Jain A, Arrigain S, Yu C, Goormastic M, Ellis SG, Blackstone E, Kattan MW. ",a('Predictive models for short- and long-term adverse outcomes following discharge in a contemporary population with acute coronary syndromes', href='http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3584647/pdf/ajcd0003-0039.pdf'),". Am J Cardiovasc Dis. 2013;3(1):39-52. Epub 2013 Feb 17")),
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
                    style = "text-align: center;"),
                  img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;"))))