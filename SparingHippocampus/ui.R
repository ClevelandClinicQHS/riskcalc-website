#Created: 2019-08-21
#Author: Alex Zajichek
#Project: Sparing or resecting the hippocampus
#Description: Holds user interface objects

#Load packages
require(shiny)
require(shinyBS)
require(shinythemes)
require(DT)
require(dplyr)

fluidPage(
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
  
  #Add title
  titlePanel(
    title = "Temporal lobe resections that spare versus remove a MRI-normal hippocampus: chance of seizure-freedom one year after surgery and risk of naming decline"
  ),
  
  #Make a side panel and main display
  sidebarLayout(
    
    #Create the side panel
    sidebarPanel(
      
      ##Add inputs for pre-op model
      HTML("<font size='+1'>Pre-op patient characteristics</font>"),
      HTML("<br>"),
      
      #Age at surgery
      numericInput(
        inputId = "age",
        label = "Current age (years)",
        value = 20
      ),
      bsTooltip(
        id = "age",
        title = "Age at surgery",
        placement = "right"
      ),
      
      #Age at epilepsy onset
      numericInput(
        inputId = "duration",
        label = "Age at epilepsy onset (years)",
        value = 10
      ),
      
      #Gender
      radioButtons(
        inputId = "gender",
        label = "Gender",
        choices = c(
          "Male",
          "Female"
        )
      ),
      
      #Education
      numericInput(
        inputId = "education",
        label = "Education (years)",
        value = 13
      ),
      
      #Surgery side
      radioButtons(
        inputId = "side",
        label = "Side of surgery",
        choices = 
          c(
            "Dominant", 
            "Non-dominant"
          )
      ),
      bsTooltip(
        id = "side",
        title = "Dominance was based on available language testing or handedness",
        placement = "right"
      ),
      
      #MRI
      radioButtons(
        inputId = "mri",
        label = "MRI",
        choices = 
          c(
            "Normal",
            "Abnormal"
          )
      ),
      bsTooltip(
        id = "mri",
        title = "MRI findings outside the hippocampus",
        placement = "right"
      ),
      
      #Check to add additional variables
      checkboxInput(
        inputId = "postop",
        label = HTML("<font size='+1'>Add post-op information</font>")
      ),
      
      #Add additional inputs if box is checked
      conditionalPanel(
        condition = "input.postop",
        
        #Pathology
        radioButtons(
          inputId = "pathology",
          label = "Pathology",
          choices =
            c(
              "Normal",
              "Abnormal"
            )
        ),
        bsTooltip(
          id = "pathology",
          title = "Pathology findings outside the hippocampus",
          placement = "right"
        ),
        
        #Acute seizures
        radioButtons(
          inputId = "acuteseizures",
          label = "Acute post-op seizures?",
          choices = 
            c(
              "No",
              "Yes"
            )
        ),
        bsTooltip(
          id = "acuteseizures",
          title = "Seizures occurring during the one month following surgery",
          placement = "bottom"
        )
        
      )
      
    ),
    
    #Main content
    mainPanel(
      
      #Button to run calculator
      actionButton(
        inputId = "run",
        label = "Run calculator",
        style="color: #fff; background-color: #337ab7; border-color: #2e6da4"
      ),
      HTML("<br><br><br>"),
      
      HTML("<font size='+2'>Seizure freedom</font>"),
      
      #Table of predictions
      dataTableOutput(
        outputId = "table"
      ),
      
      HTML("<br><br><br>"),
      
      HTML("<font size='+2'>Naming decline*</font>"),
      
      #Table of predictions
      dataTableOutput(
        outputId = "table2"
      ),
      
      HTML("<br>"),
      
      p("* risk of clinically meaningful naming decline  (<=5 points) calculated based on a pre-existing model: Busch RM, Hogue O, Kattan MW, et al. ", a('Nomograms to predict naming decline after temporal lobe surgery in adults with epilepsy.', href='https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6282231/'), " Neurology 2018;91(23):e2144–e2152. For this model resecting or not the hippocampus did not predict naming decline (p=0.52)"),
      wellPanel(h3('Reference'),p("Morita-Sherman, M., Louis, S., Vegh, D., Busch, R.M., Ferguson, L., Yardi, R., Bingaman, J., Bingaman, W., Gonzalez-Martinez, J., Bulacio, J., Najm, I., Jones, S., Zajicheck, A., Kattan, M., Blumcke, I., Cendes, F., & Jehi, L. (2020). Seizure and cognitive outcomes following temporal lobe resections that spare versus remove a MRI-normal hippocampus. Epilepsia. 61(11): 2545-2557, PMID: 33063852.")),
      wellPanel(h3('Disclaimer'),
                p("No Medical Advice. ALTHOUGH SOME CONTENT MAY BE PROVIDED BY INDIVIDUALS IN THE MEDICAL PROFESSION, YOU ACKNOWLEDGE THAT PROVISION OF SUCH CONTENT DOES NOT CREATE A MEDICAL PROFESSIONAL-PATIENT RELATIONSHIP AND DOES NOT CONSTITUTE AN OPINION, MEDICAL ADVICE, PROFESSIONAL DIAGNOSIS, SERVICE OR TREATMENT OF ANY CONDITION. Access to general information is provided for educational purposes only, through this site and links to other sites. Content is not recommended or endorsed by any doctor or healthcare provider. The information and Content provided are not substitutes for medical or professional care, and you should not use the information in place of a visit, call, consultation or the advice of your physician or other healthcare provider. You are liable or responsible for any advice, course of treatment, diagnosis or any other information, services or product obtained through this site.")),
      p(
        a("Homepage",
          href = "../", 
          style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
        ), 
        " | ",
        a("Website Error Messages",
          href = "javascript:myFunction()",
          style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
        ),
        " | ",
        a("Source Code", 
          href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/SparingHippocampus", 
          style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
        ),
        style = "text-align: center;"
      )
      
      
    )
    
  )
  
)
