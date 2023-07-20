require(shinythemes)
require(shinyjs)

fluidPage(theme = shinytheme("flatly"),
          useShinyjs(),
            tags$script(HTML(
    'function myFunction() {
  var txt;
  if (confirm("This is a mailbox for reporting website errors to programmers for the risk calculator website.  If you have questions or concerns about a specific calculator, please use the calculator Author Contact Information found on the publication for that calculator.  Each calculator is documented by a specific publication with a corresponding author.")) {
    window.open("mailto:rcalcsupport@ccf.org");
  }
}'
  )),
          
          titlePanel('Breast Cancer - Arm Volume Calculator'),
          
          sidebarLayout(
              sidebarPanel(id = "sidebar",
                           h3("Left Arm Circumferences (cm)", style = "font-weight:bold"),
                           textInput("Left_A", "Point A (cm)"),
                           textInput("Left_B", "Point B (cm)"),
                           textInput("Left_C", "Point C (cm)"),
                           textInput("Left_D", "Point D (cm)"),
                           textInput("Left_E", "Point E (cm)"),
                           textInput("Left_F", "Point F (cm)"),
                           h3("Right Arm Circumferences (cm)", style = "font-weight:bold"),
                           textInput("Right_A", "Point A (cm)"),
                           textInput("Right_B", "Point B (cm)"),
                           textInput("Right_C", "Point C (cm)"),
                           textInput("Right_D", "Point D (cm)"),
                           textInput("Right_E", "Point E (cm)"),
                           textInput("Right_F", "Point F (cm)")
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
                      h3("Instruction"),
                      p("HOW TO USE: ", style="font-weight:bold"),
                      p("Using a tape measure, measure the circumferences (in centimeters) at each point (A, B, C, D, E, and F) on both arms (see figure). Then, include these measures in the calculator."),
                      p("COMMENTS: ", style="font-weight:bold"),
                      HTML("<p>The volume of each arm is estimated using the formula for the volume of the frustum of a cone: V = h * (C<sup>2</sup> + Cc + c<sup>2</sup>)/(12 * &#960), where V is the volume of a segment of the upper extremity, C and c are the circumferences (in cm) at determined segments of the arm, and h is the distance between circumferences (C, c) in each segment (h = 7 cm was used). The arm circumference is measured at multiple segments. Each adjacent pair of measurements is used to estimate the volume of that segment. The volume estimates of all segments of each arm is summed to compute the estimated arm volume (See Figure).</p>"),
                      img(src="capture.PNG", style="max-width:80%")
                  ),
                  wellPanel(
                      h3('Click Below for Calculator and Author Contact Information'),
                      p("[1] José Luiz B. Bevilacqua, Michael W. Kattan, Yu Changhong, et al. ",a('Nomograms for Predicting the Risk of Arm Lymphedema after Axillary Dissection in Breast Cancer.', href='https://link.springer.com/article/10.1245%2Fs10434-012-2290-x')," Annals of Surgical Oncology, 2012, Volume 19, Number 8, Page 2580"),
                      p("[2] Casley-Smith JR. ", a("Measuring and representing peripheral oedema and its alterations.", href="https://journals.uair.arizona.edu/index.php/lymph/article/view/17566/17294")," Lymphology 1994;27(2):56-70.")
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
                    a("Source Code", 
                      href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/BreastCancerArmLymphedemaArmVolume", 
                      style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
                    ),
                    style = "text-align: center;"),
                  
                  img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;")
              )
          )
)
