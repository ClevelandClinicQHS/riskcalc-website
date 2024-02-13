# Created: 2024-02-05
# Author: Alex Zajichek
# Project: GUKI Antibiotic Optimization
# Description: Contains the user interface

# Build the user interface
fluidPage(
  ### DEVELOPMENT INDICATION
  h3("APP CURRENTLY IN DEVELOPMENT", style = "text-align: center; background-color: tomato; color: black"),
  
  # App theme and title
  shinyjs::useShinyjs(),
  theme = shinytheme("flatly"),
  tags$head(tags$link(rel="shortcut icon", href="../assets/icons/favicon.ico", type="image/x-icon")),
  tags$head(tags$link(rel="apple-touch-icon", href="../assets/icons/apple-touch-icon.png", type="image/x-icon")),
  titlePanel("Probability of culture susceptibility & resistance"),

  # Set the layout
  sidebarLayout(
    
    # Sidebar of user inputs
    sidebarPanel(
      id = "sidebar",
      
      # Make a tab panel for the different input types
      tabsetPanel(
        
        # Demographics
        tabPanel(
          title = "Demographics",
          HTML("<br>"),
          
          # Age of patient
          numericInput(
            inputId = "age",
            label = "Age (years)",
            value = NA_real_,
            min = 18,
            max = 100
          ),
          
          # Sex
          selectInput(
            inputId = "sex",
            label = "Sex",
            choices = modeling_dataset_metadata$Sex
          ),
          
          # Living arrangements
          selectInput(
            inputId = "living_arrangement",
            label = "Living Arrangements",
            choices = modeling_dataset_metadata$LivingArrangement
          ),
          
          # Patient mobility
          selectInput(
            inputId = "mobility",
            label = "Mobility",
            choices = modeling_dataset_metadata$MobilityStatus
          )
        ),
        
        # Lab culture information
        tabPanel(
          title = "Specimen Information",
          HTML("<br>"),
          
          # Facility of specimen
          selectInput(
            inputId = "facility",
            label = "Facility",
            choices = modeling_dataset_metadata$Facility
          ),
          
          # Department specialty
          selectInput(
            inputId = "specialty",
            label = "Department specialty",
            choices = modeling_dataset_metadata$DepartmentSpecialty
          ),
          
          # Collection method
          selectInput(
            inputId = "collection",
            label = "Collection method",
            choices = modeling_dataset_metadata$CollectionMethod
          ),
          
          # Days since last resistance
          selectInput(
            inputId = "days_since_resistance",
            label = "Days since previous resistance (any organism)",
            choices = modeling_dataset_metadata$AnyOrganism_DaysSincePreviousResistance
          ),
          
          # History of E.coli
          selectInput(
            inputId = "hx_ecoli",
            label = "History of E. coli urinary tract infection",
            choices = c(Yes = "Y", No = "N", Unknown = "(Unknown)")
          ),
          
          # Culture results
          checkboxInput(inputId = "has_results", label = "Has an organism been identified in your urine specimen?"),
          conditionalPanel(
            condition = "input.has_results",
            selectInput(
              inputId = "culture_results",
              label = "Organism(s) identified",
              multiple = TRUE,
              choices = 
                c(
                  `Escherichia coli` = "Escherichia_Coli_Positive", 
                  `Klebsiella pneumoniae` = "Klebsiella_Pneumoniae_Positive", 
                  `Enterococcus faecalis` = "Enterococcus_Faecalis_Positive", 
                  `Pseudomonas aeruginosa` = "Pseudomonas_Aeruginosa_Positive", 
                  `Proteus mirabilis` = "Proteus_Mirabilis_Positive", 
                  `Enterobacter spp` = "Enterobacter_spp_Positive", 
                  `Coagulase-negative staphylococcus (Staphylococcus saprophyticus, Staphylococcus epidermidis)` = "Coagulase_Negative_Staphylococcus_Positive", 
                  `group B Streptococcus (GBS) (Streptococcus agalactiae)` = "Group_B_Streptococcus_Positive", 
                  `Acinetobacter spp` = "Acinetobacter_spp_Positive", 
                  `Citrobacter spp` = "Citrobacter_spp_Positive", 
                  `Staphylococcus aureus` = "Staphylococcus_Aureus_Positive"
                )
            ),
            HTML('<p style="font-size:65%;"><em>The absence of an organism in selected list indicates it was not identified.</em></p>')
          )
        ),
        
        # Resistance history
        tabPanel(
          title = "Resistance History",
          HTML("<br>"),
          
          # Radio buttons for each antibiotic
          radioButtons(inputId = "hx_ampicillin", label = "Ampicillin", choices = c(Yes = "Y", No = "N", Unknown = "DQ"), selected = "DQ", inline = TRUE),
          radioButtons(inputId = "hx_cefazolin", label = "Cefazolin", choices = c(Yes = "Y", No = "N", Unknown = "DQ"), selected = "DQ", inline = TRUE),
          radioButtons(inputId = "hx_cefepime", label = "Cefepime", choices = c(Yes = "Y", No = "N", Unknown = "DQ"), selected = "DQ", inline = TRUE),
          radioButtons(inputId = "hx_ceftriaxone", label = "Ceftriaxone", choices = c(Yes = "Y", No = "N", Unknown = "DQ"), selected = "DQ", inline = TRUE),
          radioButtons(inputId = "hx_ciprofloxacin", label = "Ciprofloxacin", choices = c(Yes = "Y", No = "N", Unknown = "DQ"), selected = "DQ", inline = TRUE),
          radioButtons(inputId = "hx_gentamicins", label = "Gentamicin", choices = c(Yes = "Y", No = "N", Unknown = "DQ"), selected = "DQ", inline = TRUE),
          radioButtons(inputId = "hx_meropenem", label = "Meropenem", choices = c(Yes = "Y", No = "N", Unknown = "DQ"), selected = "DQ", inline = TRUE),
          radioButtons(inputId = "hx_nitrofurantoin", label = "Nitrofurantoin", choices = c(Yes = "Y", No = "N", Unknown = "DQ"), selected = "DQ", inline = TRUE),
          radioButtons(inputId = "hx_piperacillin", label = "Piperacillin-Tazobactam", choices = c(Yes = "Y", No = "N", Unknown = "DQ"), selected = "DQ", inline = TRUE),
          radioButtons(inputId = "hx_trimethoprim", label = "Trimethoprim-Sulfamethoxazole", choices = c(Yes = "Y", No = "N", Unknown = "DQ"), selected = "DQ", inline = TRUE),
          radioButtons(inputId = "hx_vancomycin", label = "Vancomycin", choices = c(Yes = "Y", No = "N", Unknown = "DQ"), selected = "DQ", inline = TRUE)
        ),
        
        # Urinalysis results
        tabPanel(
          title = "Urinalysis Results",
          HTML("<br>"),
          
          # Add the urinalysis measures
          selectInput(inputId = "urinalysis_ph", label = "pH level", choices = modeling_dataset_metadata$Urinalysis_Results_pH),
          selectInput(inputId = "urinalysis_bacteria_hpf", label = "Bacteria (hpf)", choices = modeling_dataset_metadata$Urinalysis_Results_Bacteria_hpf),
          selectInput(inputId = "urinalysis_color", label = "Color", choices = modeling_dataset_metadata$Urinalysis_Results_Color),
          selectInput(inputId = "urinalysis_blood", label = "Blood", choices = modeling_dataset_metadata$Urinalysis_Results_Blood),
          selectInput(inputId = "urinalysis_protein", label = "Protein", choices = modeling_dataset_metadata$Urinalysis_Results_Protein),
          selectInput(inputId = "urinalysis_specific_gravity", label = "Specific Gravity", choices = modeling_dataset_metadata$Urinalysis_Results_Specific_Gravity),
          selectInput(inputId = "urinalysis_rbc_hpf", label = "RBC (hpf)", choices = modeling_dataset_metadata$Urinalysis_Results_RBC_hpf),
          selectInput(inputId = "urinalysis_nitrite", label = "Nitrite", choices = modeling_dataset_metadata$Urinalysis_Results_Nitrite)
        )
      )
    ),
    
    # Main panel of result output
    mainPanel(
      
      # Button to run calculator upon entry
      actionButton(
        inputId = "goButton",
        label = "Run Calculator"
      ),
      br(),
      hr(),
      tags$head(tags$style(type = "text/css", "tfoot {display:none;}")),
      
      # Result table of prediction(s)
      div(id = "result_panel", DT::dataTableOutput(outputId = "result")),
      br(),
      
      # Contact/citation information
      wellPanel(h3('Click Below for Calculator and Author Contact Information')),
      
      # Disclaimer message
      wellPanel(
        h3('Disclaimer'),
        p("No Medical Advice. ALTHOUGH SOME CONTENT MAY BE PROVIDED BY INDIVIDUALS IN THE MEDICAL PROFESSION, YOU ACKNOWLEDGE THAT PROVISION OF SUCH CONTENT DOES NOT CREATE A MEDICAL PROFESSIONAL-PATIENT RELATIONSHIP AND DOES NOT CONSTITUTE AN OPINION, MEDICAL ADVICE, PROFESSIONAL DIAGNOSIS, SERVICE OR TREATMENT OF ANY CONDITION. Access to general information is provided for educational purposes only, through this site and links to other sites. Content is not recommended or endorsed by any doctor or healthcare provider. The information and Content provided are not substitutes for medical or professional care, and you should not use the information in place of a visit, call, consultation or the advice of your physician or other healthcare provider. You are liable or responsible for any advice, course of treatment, diagnosis or any other information, services or product obtained through this site.")
      ),
      
      # Links
      p(
        a("Homepage", href = "../", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
        " | ",
        a("Contact Us", href = "mailto:rcalcsupport@ccf.org?body=Predicting%20cognitive%20outcomes%20after%20epilepsy%20surgery", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
        " | ",
        a("Add to phone (iOS Safari)", href="https://support.apple.com/guide/iphone/bookmark-favorite-webpages-iph42ab2f3a7/ios#iph4f9a47bbc", target="_blank", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
        " | ", 
        a("Add to phone (Android)", href="https://www.cnet.com/tech/mobile/adding-one-touch-bookmarks-to-your-androids-home-screen/", target="_blank", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
        " | ",
        a("Source Code", 
          href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/AntibioticOptimization", 
          style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
        ),
        style = "text-align: center;"
      ),
      img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;")
    )
  )
)