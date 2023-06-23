library(shiny)
library(ggplot2)

formula.dvt.prob <- expression({
    lp <- -7.6648143 + 
        0.29706802 * (Age == "<1 Month - 23 Month") - 
        0.11771082 * (Age == "13 Years - 18 Years") - 
        0.20681425 * (Race == "Other") - 
        0.088198723 * (Race == "White") - 
        0.39191756 * (Post.Operative == "Yes") + 
        0.96053141 * (Airway.InvasiveVentilation == "Yes") + 
        0.94210932 * (CardiacCatheterization.Diagnostic == "Yes") + 
        0.72690996 * (CardiacCatheterization.Therapeutic == "Yes") - 
        0.21088059 * (CardiacSurgery.CongenitalDefectRepair == "Yes") + 
        0.23821143 * (CardiacSurgery.Miscellaneous == "Yes") + 
        0.41685169 * (CardiorespiratorySupport == "Yes") + 
        0.62040848 * (Neuro.Neurosurgical == "Yes") + 
        0.71251351 * (PlasticSurgery == "Yes") + 
        0.67096526 * (Surgical.Other == "Yes") + 
        0.44435249 * (ThoracicSurgery == "Yes") + 
        0.75443837 * (TransplantSurgery == "Yes") + 
        0.4900081 * (Otorhinolaryngology == "Yes") + 
        1.3526178 * (picc == "Yes") + 
        0.4608894 * (broviac == "Yes") + 
        0.52299515 * (hemodialysis == "Yes") + 
        1.3332928 * (percutaneous == "Yes") + 
        0.60457617 * (transthoracic == "Yes") + 
        0.57512092 * (umbilical == "Yes") - 
        0.031915846 * (Cardiovascular_primary == "Yes") + 
        0.99410043 * (Endocrinologic_primary == "Yes") + 
        0.19018882 * (Gastrointestinal_primary == "Yes") - 
        1.4639757 * (Genetic_primary == "Yes") + 
        0.43602878 * (Hematologic_primary == "Yes") + 
        1.7702918 * (Immunologic_primary == "Yes") + 
        0.33265503 * (Injury.Poisoning.Adverse.Effects_primary == "Yes") + 
        0.2757972 * (Neurologic_primary == "Yes") + 
        0.5111476 * (Oncologic_primary == "Yes") - 
        0.36297755 * (Orthopedic_primary == "Yes") + 
        0.41036067 * (Renal.Genitourinary_primary == "Yes") + 
        1.1224402 * (Transplant_primary == "Yes") + 
        0.28679554 * (Cardiovascular_history == "Yes") + 
        0.21155185 * (Dermatologic_history == "Yes") + 
        0.22763156 * (Endocrinologic_history == "Yes") + 
        0.15701215 * (Gastrointestinal_history == "Yes") + 
        0.13596466 * (Genetic_history == "Yes") + 
        0.3953507 * (Hematologic_history == "Yes") - 
        0.33240927 * (Immunologic_history == "Yes") + 
        0.38336796 * (Infectious_history == "Yes") + 
        0.37325796 * (Metabolic_history == "Yes") + 
        0.19351309 * (Orthopedic_history == "Yes") + 
        0.2378011 * (Psychiatric_history == "Yes") + 
        0.11034595 * (Respiratory_history == "Yes") - 
        0.61116409 * (Transplant_history == "Yes")
    1 / (1 + exp(-lp))
})

shinyServer(function(input, output) {

    datasetInput <- reactive({
        central_lines <- as.vector(input$checkGroup1)
        post_operative <- as.vector(input$checkGroup2)
        cardiac_catheterization <- as.vector(input$checkGroup3)
        primary_diagnosis <- as.vector(input$checkGroup4)
        history_diagnosis <- as.vector(input$checkGroup5)
        df <- data.frame(
            Age = factor(input$Age,c("<1 Month - 23 Month", "2 Years - 12 Years", "13 Years - 18 Years")),
            Race = factor(input$Race, c("White", "Black", "Other")),
            Airway.InvasiveVentilation = factor(input$Airway.InvasiveVentilation, c("Yes", "No")),
            picc = ifelse("picc" %in% central_lines, "Yes", "No"),
            broviac = ifelse("broviac" %in% central_lines, "Yes", "No"),
            hemodialysis = ifelse("hemodialysis" %in% central_lines, "Yes", "No"),
            percutaneous = ifelse("percutaneous" %in% central_lines, "Yes", "No"),
            transthoracic = ifelse("transthoracic" %in% central_lines, "Yes", "No"),
            umbilical = ifelse("umbilical" %in% central_lines, "Yes", "No"),
            Post.Operative = ifelse(length(post_operative) > 0, "Yes", "No"),
            CardiacSurgery.CongenitalDefectRepair = ifelse("CardiacSurgery.CongenitalDefectRepair" %in% post_operative, "Yes", "No"),
            CardiacSurgery.Miscellaneous = ifelse("CardiacSurgery.Miscellaneous" %in% post_operative, "Yes", "No"),
            CardiorespiratorySupport = ifelse("CardiorespiratorySupport" %in% post_operative, "Yes", "No"),
            Neuro.Neurosurgical = ifelse("Neuro.Neurosurgical" %in% post_operative, "Yes", "No"),
            PlasticSurgery = ifelse("PlasticSurgery" %in% post_operative, "Yes", "No"),
            ThoracicSurgery = ifelse("ThoracicSurgery" %in% post_operative, "Yes", "No"),
            TransplantSurgery = ifelse("TransplantSurgery" %in% post_operative, "Yes", "No"),
            Otorhinolaryngology = ifelse("Otorhinolaryngology" %in% post_operative, "Yes", "No"),
            Surgical.Other = ifelse("Surgical.Other" %in% post_operative, "Yes", "No"),
            CardiacCatheterization.Diagnostic = ifelse("CardiacCatheterization.Diagnostic" %in% cardiac_catheterization, "Yes", "No"),
            CardiacCatheterization.Therapeutic = ifelse("CardiacCatheterization.Therapeutic" %in% cardiac_catheterization, "Yes", "No"),
            Cardiovascular_primary = ifelse("Cardiovascular_primary" %in% primary_diagnosis, "Yes", "No"),
            Endocrinologic_primary = ifelse("Endocrinologic_primary" %in% primary_diagnosis, "Yes", "No"),
            Gastrointestinal_primary = ifelse("Gastrointestinal_primary" %in% primary_diagnosis, "Yes", "No"),
            Genetic_primary = ifelse("Genetic_primary" %in% primary_diagnosis, "Yes", "No"),
            Hematologic_primary = ifelse("Hematologic_primary" %in% primary_diagnosis, "Yes", "No"),
            Immunologic_primary = ifelse("Immunologic_primary" %in% primary_diagnosis, "Yes", "No"),
            Injury.Poisoning.Adverse.Effects_primary = ifelse("Injury.Poisoning.Adverse.Effects_primary" %in% primary_diagnosis, "Yes", "No"),
            Neurologic_primary = ifelse("Neurologic_primary" %in% primary_diagnosis, "Yes", "No"),
            Oncologic_primary = ifelse("Oncologic_primary" %in% primary_diagnosis, "Yes", "No"),
            Orthopedic_primary = ifelse("Orthopedic_primary" %in% primary_diagnosis, "Yes", "No"),
            Renal.Genitourinary_primary = ifelse("Renal.Genitourinary_primary" %in% primary_diagnosis, "Yes", "No"),
            Transplant_primary = ifelse("Transplant_primary" %in% primary_diagnosis, "Yes", "No"),
            Cardiovascular_history = ifelse("Cardiovascular_history" %in% history_diagnosis, "Yes", "No"),
            Dermatologic_history = ifelse("Dermatologic_history" %in% history_diagnosis, "Yes", "No"),
            Endocrinologic_history = ifelse("Endocrinologic_history" %in% history_diagnosis, "Yes", "No"),
            Gastrointestinal_history = ifelse("Gastrointestinal_history" %in% history_diagnosis, "Yes", "No"),
            Genetic_history = ifelse("Genetic_history" %in% history_diagnosis, "Yes", "No"),
            Hematologic_history = ifelse("Hematologic_history" %in% history_diagnosis, "Yes", "No"),
            Immunologic_history = ifelse("Immunologic_history" %in% history_diagnosis, "Yes", "No"),
            Infectious_history = ifelse("Infectious_history" %in% history_diagnosis, "Yes", "No"),
            Metabolic_history = ifelse("Metabolic_history" %in% history_diagnosis, "Yes", "No"),
            Orthopedic_history = ifelse("Orthopedic_history" %in% history_diagnosis, "Yes", "No"),
            Psychiatric_history = ifelse("Psychiatric_history" %in% history_diagnosis, "Yes", "No"),
            Respiratory_history = ifelse("Respiratory_history" %in% history_diagnosis, "Yes", "No"),
            Transplant_history = ifelse("Transplant_history" %in% history_diagnosis, "Yes", "No")
        )
        df
    }) 
    
    output$text <- renderText({
        new.dat <- datasetInput()
        prob.dvt <- eval(formula.dvt.prob, envir = new.dat)
        prob.dvt <- round(prob.dvt*100, 3)
        paste("Probability is: ",as.character(prob.dvt),"%", sep="")
    })

    output$plot <- renderPlot({
        new.dat <- datasetInput()
        prob.dvt <- eval(formula.dvt.prob, envir = new.dat)
        prob.dvt <- round(prob.dvt*100, 3)
        res <- data.frame(factor = "a", prob = prob.dvt, sign = ifelse(prob.dvt<0.32037, "low", ifelse(prob.dvt <0.80114, "moderate", "high")))
        ggplot(res, aes(x = factor, y = prob,fill = sign)) + geom_bar(width= 0.3, stat = 'identity')+scale_fill_manual(values = c("low" = "green3", "moderate" = "#D55E00", "high" = "red3"), breaks = c("low", "moderate", "high"), labels = c("low", "moderate", "high"), name = "risk") + theme(axis.text.x = element_blank()) +coord_cartesian(ylim=c(0,4))+xlab("Patient") + ylab("Probability (%)")
    })
    
})