library(shiny)
library(shinyBS)
library(shinyjs)
library(shinythemes)


fluidPage(
  useShinyjs(),
  tags$script(HTML(
    'function myFunction() {
  var txt;
  if (confirm("This is a mailbox for reporting website errors to programmers for the risk calculator website.  If you have questions or concerns about a specific calculator, please use the calculator Author Contact Information found on the publication for that calculator.  Each calculator is documented by a specific publication with a corresponding author.")) {
    window.open("mailto:rcalcsupport@ccf.org");
  }
}'
  )),
  theme = shinytheme("flatly"),
  titlePanel('Predict side-specific seizure outcomes'),
  sidebarLayout(
    sidebarPanel(
      id = "sidebar",
      h4("Please fill in all input fields to get predictions.", style="color:blue;"),
      selectInput(
        'side',
        'Side',
        choices = c("Left", "Right")
      ),
      selectInput(
        'sex',
        'Sex',
        choices = c("Male", "Female")
      ),
      numericInput(
        'Epilepsy_duration',
        'Epilepsy Duration',
        value = NA,
        min = 0,
        max = 58
      ),
      bsTooltip("Epilepsy_duration", "Range: 0 - 58", "right", options = list(container = "body")),
      numericInput(
        'sz_freq_pre_op',
        'Pre-op seizure frequency MR',
        value = NA,
        min = 0,
        max = 300
      ),
      bsTooltip("sz_freq_pre_op", "Range: 0 - 300", "right", options = list(container = "body")),
      selectInput(
        'Presence_of_GTC_seizures',
        'Presence of GTC seizures',
        choices = c("No", "Yes")
      ),
      selectInput(
        'causes_of_seizures',
        'Causes of seizures',
        choices = c("MTS", "Tumor", "Other")
      ),
      selectInput(
        'Type_of_surgery',
        'Type of surgery',
        choices = c("TLY w/ Resection of Mesial Structures", "TLY Sparing Mesial Structures", "Amygdalohippocampectomy")
      ),
      selectInput(
        'MRI',
        'MRI',
        choices = c("Normal", "Abnormal")
      ),
      numericInput(
        'Parahippocampal_Right',
        'Parahippocampal Right Norm Percentile',
        value = NA,
        min = 1,
        max = 99
      ),
      bsTooltip("Parahippocampal_Right", "Range: 1 - 99", "right", options = list(container = "body")),
      conditionalPanel(
        condition = "input.side == 'Right'",
        numericInput(
          'Entorhinal_Cortex_Right',
          'Entorhinal Cortex Right Norm Percentile',
          value = NA,
          min = 1,
          max = 99
        ),
        bsTooltip("Entorhinal_Cortex_Right", "Range: 1 - 99", "right", options = list(container = "body")),
        numericInput(
          'Isthmus_Cingulate_Asymmetry',
          'Isthmus Cingulate Asymmetry Norm Percentile',
          value = NA,
          min = 1,
          max = 99
        ),
        bsTooltip("Isthmus_Cingulate_Asymmetry", "Range: 1 - 99", "right", options = list(container = "body")),
        numericInput(
          'Medial_Parietal_Left',
          'Medial Parietal Left Norm Percentile',
          value = NA,
          min = 1,
          max = 99
        ),
        bsTooltip("Medial_Parietal_Left", "Range: 1 - 99", "right", options = list(container = "body")),
        numericInput(
          'Middle_Temporal_Right',
          'Middle Temporal Right Norm Percentile',
          value = NA,
          min = 1,
          max = 99
        ),
        bsTooltip("Middle_Temporal_Right", "Range: 1 - 99", "right", options = list(container = "body")),
        numericInput(
          'Nucleus_Accumbens_Asymmetry',
          'Nucleus Accumbens Asymmetry Norm Percentile',
          value = NA,
          min = 1,
          max = 99
        ),
        bsTooltip("Nucleus_Accumbens_Asymmetry", "Range: 1 - 99", "right", options = list(container = "body")),
        numericInput(
          'Paracentral_Asymmetry',
          'Paracentral Asymmetry Norm Percentile',
          value = NA,
          min = 1,
          max = 99
        ),
        bsTooltip("Paracentral_Asymmetry", "Range: 1 - 99", "right", options = list(container = "body")),
        numericInput(
          'Pericalcarine_Right',
          'Pericalcarine Right Norm Percentile',
          value = NA,
          min = 1,
          max = 99
        ),
        bsTooltip("Pericalcarine_Right", "Range: 1 - 99", "right", options = list(container = "body")),
        numericInput(
          'TT_Right',
          'Transverse Temporal Right Norm Percentile',
          value = NA,
          min = 1,
          max = 99
        ),
        bsTooltip("TT_Right", "Range: 1 - 99", "right", options = list(container = "body")),
        numericInput(
          'Inferior_Frontal_Right',
          'Inferior Frontal Right Norm Percentile',
          value = NA,
          min = 1,
          max = 99
        ),
        bsTooltip("Inferior_Frontal_Right", "Range: 1 - 99", "right", options = list(container = "body")),
        numericInput(
          'Pericalcarine_Left',
          'Pericalcarine Left Norm Percentile',
          value = NA,
          min = 1,
          max = 99
        ),
        bsTooltip("Pericalcarine_Left", "Range: 1 - 99", "right", options = list(container = "body")),
        numericInput(
          'Primary_Motor_Left',
          'Primary Motor Left Norm Percentile',
          value = NA,
          min = 1,
          max = 99
        ),
        bsTooltip("Primary_Motor_Left", "Range: 1 - 99", "right", options = list(container = "body")),
        numericInput(
          'RAC_Left',
          'Rostral Anterior Cingulate Left Norm Percentile',
          value = NA,
          min = 1,
          max = 99
        ),
        bsTooltip("RAC_Left", "Range: 1 - 99", "right", options = list(container = "body")),
        numericInput(
          'Superior_Parietal_Asymmetry',
          'Superior Parietal Asymmetry Norm Percentile',
          value = NA,
          min = 1,
          max = 99
        ),
        bsTooltip("Superior_Parietal_Asymmetry", "Range: 1 - 99", "right", options = list(container = "body"))
      ),
      conditionalPanel(
        condition = "input.side == 'Left'",
        numericInput(
          'Anterior_Cingulate_Asymmetry',
          'Anterior Cingulate Asymmetry Norm Percentile',
          value = NA,
          min = 1,
          max = 99
        ),
        bsTooltip("Anterior_Cingulate_Asymmetry", "Range: 1 - 99", "right", options = list(container = "body")),
        numericInput(
          'Middle_Frontal_Right',
          'Middle Frontal Right Norm Percentile',
          value = NA,
          min = 1,
          max = 99
        ),
        bsTooltip("Middle_Frontal_Right", "Range: 1 - 99", "right", options = list(container = "body")),
        numericInput(
          'Middle_Frontal_Asymmetry',
          'Middle Frontal Asymmetry Norm Percentile',
          value = NA,
          min = 1,
          max = 99
        ),
        bsTooltip("Middle_Frontal_Asymmetry", "Range: 1 - 99", "right", options = list(container = "body")),
        numericInput(
          'Pallidum_Left',
          'Pallidum Left Norm Percentile',
          value = NA,
          min = 1,
          max = 99
        ),
        bsTooltip("Pallidum_Left", "Range: 1 - 99", "right", options = list(container = "body")),
        numericInput(
          'Premotor_Right',
          'Premotor Right Norm Percentile',
          value = NA,
          min = 1,
          max = 99
        ),
        bsTooltip("Premotor_Right", "Range: 1 - 99", "right", options = list(container = "body")),
        numericInput(
          'Putamen_Right',
          'Putamen Right Norm Percentile',
          value = NA,
          min = 1,
          max = 99
        ),
        bsTooltip("Putamen_Right", "Range: 1 - 99", "right", options = list(container = "body")),
        numericInput(
          'VD_Asymmetry',
          'Ventral Diencephalon Asymmetry Norm Percentile',
          value = NA,
          min = 1,
          max = 99
        ),
        bsTooltip("VD_Asymmetry", "Range: 1 - 99", "right", options = list(container = "body")),
        numericInput(
          'Lateral_Orbitofrontal_Left',
          'Lateral Orbitofrontal Left Norm Percentile',
          value = NA,
          min = 1,
          max = 99
        ),
        bsTooltip("Lateral_Orbitofrontal_Left", "Range: 1 - 99", "right", options = list(container = "body")),
        numericInput(
          'CWMH_Asymmetry',
          'Cerebral WM Hypointensities Asymmetry Norm Percentile',
          value = NA,
          min = 1,
          max = 99
        ),
        bsTooltip("CWMH_Asymmetry", "Range: 1 - 99", "right", options = list(container = "body")),
        numericInput(
          'Pars_Orbitalis_Right',
          'Pars Orbitalis Right Norm Percentile',
          value = NA,
          min = 1,
          max = 99
        ),
        bsTooltip("Pars_Orbitalis_Right", "Range: 1 - 99", "right", options = list(container = "body")),
        numericInput(
          'Occipital_Lobe_Asymmetry',
          'Occipital Lobe Asymmetry Norm Percentile',
          value = NA,
          min = 1,
          max = 99
        ),
        bsTooltip("Occipital_Lobe_Asymmetry", "Range: 1 - 99", "right", options = list(container = "body")),
        numericInput(
          'Medial_Parietal_Asymmetry',
          'Medial Parietal Asymmetry Norm Percentile',
          value = NA,
          min = 1,
          max = 99
        ),
        bsTooltip("Medial_Parietal_Asymmetry", "Range: 1 - 99", "right", options = list(container = "body")),
        numericInput(
          'Inferior_Parietal_Asymmetry',
          'Inferior Parietal Asymmetry Norm Percentile',
          value = NA,
          min = 1,
          max = 99
        ),
        bsTooltip("Inferior_Parietal_Asymmetry", "Range: 1 - 99", "right", options = list(container = "body")),
        numericInput(
          'TT_Left',
          'Transverse Temporal Left Norm Percentile',
          value = NA,
          min = 1,
          max = 99
        ),
        bsTooltip("TT_Left", "Range: 1 - 99", "right", options = list(container = "body"))
      )
    ),
    mainPanel(
      actionButton("goButton", "Run Calculator"),
      br(),
      br(),
      DT::dataTableOutput('result'),
      br(),
      # wellPanel(
      #   h3('Click Below for Calculator and Author Contact Information'),
      #   p(
      #     "Jehi L, Ji X, Milinovich A, Erzurum S, Rubin B, Gordon S, Young J, Kattan MW. ",
      #     a(
      #       "Individualizing risk prediction for positive COVID-19 testing: results from 11,672 patients. ",
      #       href = "https://www.ncbi.nlm.nih.gov/pubmed/32533957/"
      #     ),
      #     "Chest. 2020 Jun 10;. doi: 10.1016/j.chest.2020.05.580. [Epub ahead of print] PubMed PMID: 32533957."
      #   )
      # ),
      wellPanel(
        h3('Disclaimer'),
        p(
          "No Medical Advice. ALTHOUGH SOME CONTENT MAY BE PROVIDED BY INDIVIDUALS IN THE MEDICAL PROFESSION, YOU ACKNOWLEDGE THAT PROVISION OF SUCH CONTENT DOES NOT CREATE A MEDICAL PROFESSIONAL-PATIENT RELATIONSHIP AND DOES NOT CONSTITUTE AN OPINION, MEDICAL ADVICE, PROFESSIONAL DIAGNOSIS, SERVICE OR TREATMENT OF ANY CONDITION. Access to general information is provided for educational purposes only, through this site and links to other sites. Content is not recommended or endorsed by any doctor or healthcare provider. The information and Content provided are not substitutes for medical or professional care, and you should not use the information in place of a visit, call, consultation or the advice of your physician or other healthcare provider. You are liable or responsible for any advice, course of treatment, diagnosis or any other information, services or product obtained through this site."
        )
      ),
      p(
        a(
          "Homepage",
          href = "../",
          style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
        ),
        " | ",
        a(
          "Website Error Messages",
          href = "javascript:myFunction()",
          #href = "mailto:rcalcsupport@ccf.org",
          style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
        ),
        style = "text-align: center;"
      ),
      img(src = '../logo-ccf.png', style = "max-width:50%; max-height:100%;")
    )
  )
)
