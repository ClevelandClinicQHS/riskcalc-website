info_ger = HTML("<h1>TUM Prostatakrebs Rechner</h1>
                     <big><p>
                     Der TUM Prostatakrebsrechner schätzt das Risiko eines klinisch signifikanten Prostatakarzinoms (csPCa).
                     Das Risiko-Tool basiert auf einem logistischen Regressionsmodell basierend auf den Daten von 603 
                     Prostatabiopsie von 603 Patienten am Klinikum der Technischen Universität Rechts der Isar in München, 
                     einer Spezialklinik, in der Patienten mit Auffälligkeiten von ihrem Urologen überwiesen wurden. Das 
                     Modell umfasst die folgenden Risikofaktoren: Alter, prostataspezifisches Antigen (PSA) in ng/ml, 
                     Prostatavolumen in ml, Pi-RADS score und vorherige negative Biopsiegeschichte. Diese Risikofaktoren 
                     lieferten einen unabhängigen prädiktiven Wert für die Risikoabschätzung einer Prostatabiopsie, die das 
                     Vorhandensein eines klinisch signifikanten Prostatakarzinoms einschätzt. Höheres Alter, PSA, und Pi-RADS 
                     sind mit einem höheren Risiko für csPCa verbunden, während eine vorherige negative Biopsie und eine 
                     größere Prostata dieses Risiko senken. 
                     </p>

                     <p>
                     Die Ergebnisse dieses Rechners gelten möglicherweise nicht für alle Gruppen von Patienten. Etwa 35 % der
                     Männer hatten einen ISUP Wert > 2, was eine abnormal hohe Anzahl einer Kohorte ist. Das lässt sich darauf 
                     zurückführen, dass da es sich um eine Spezialklinik handelt. Die meisten Männer in dieser Studie waren 
                     weiß und die Ergebnisse können bei anderen Ethnien oder Rassen anders ausfallen. Der Rechner ist im Prinzip 
                     nur unter den folgenden Einschränkungen anwendbar:
                     </p>  
                     
                     <ul>
                     <li>Keine vorherige positive Prostata-Biopsie</li>
                     <li>Aktuelle PSA, Prostata Volumen, und Pi-RADS Werte</li>
                     </ul>   
                     
                     <p>
                     Der TUM Rechner ist für Männer gedacht, die ein Prostatakrebs-Screening mit PSA und Pi-RADS hatten. Die 
                     Risikoschätzung des Rechners spiegelt nicht die tatsächliche Prävalenz von Prostatakarzinomen wider, sondern 
                     schätzt lediglich das Risiko einer csPCa-Diagnose ein. Zusätzliche klinische Informationen können dieses 
                     Risiko verändern. Für die Prostatabiopsie wird kein bestimmtes Risikoniveau empfohlen, und diese 
                     Entscheidung sollte eine individuelle Entscheidung auf der Grundlage einer Arzt-Patienten-Beziehung sein.
                     </p></big>")

info_eng = HTML("<h1>TUM Prostate Cancer Calculator</h1>
                     <big><p>
                     The TUM Prostate Cancer Calculator estimates the risk of clinically signficiant prostate cancer (csPCa) 
                     defined as ISUP>2. The risk tool is based on a logistic regression model fit on 603 patients that 
                     underwent a prostate biopsy at the Technical University Rechts der Isar hospital in Munich, a specialist 
                     clinic where patients with abnormalities are referred to from their urologist. Patients with special 
                     conditions, such as a prior positive csPCa diagnosis, acute prostatitis, ASAP, adenocarcinoma, or prostate 
                     imaging with PSMA-PET-CT were excluded. The model includes the following risk factors: Age, prostate-specific 
                     antigen (PSA) in ng/ml, prostate volume in ml, Pi-RADS score, and prior negative biopsy history. 
                     These risk factors provided independent predictive value to the risk estimation of a prostate biopsy that 
                     showed presence of clinically signiciant cancer. Higher Age, PSA, and Pi-RADS are associated with a higher 
                     risk of csPCa, whereas a prior negative biopsy, and a larger prostate decreases this risk. 
                     </p>
                     
                     <p>
                     The results of this calculator may not apply to different groups of people. About 35% of the men in this 
                     cohort had an ISUP score > 2, which is an abnormally high rate. This can be attributed to the fact that 
                     this is a specialist clinic. Most of the men in this study were white and the results may be different for other 
                     ethnicities or races. In principle, the calculator is only applicable under the following restrictions:
                     </p>  
                     
                     <ul>
                     <li>No previous diagnosis of prostate cancer</li>
                     <li> Current PSA, prostate volume, and Pi-RADS results</li>
                     </ul>   
                     
                     <p>
                     The TUM calculator is applicable to men undergoing prostate cancer screening with PSA and Pi-RADS.
                     The calculator's risk estimate does not reflect the actual prevalence of prostate cancer, but only
                     estimates the risk of a csPCa diagnosis. Additional clinical information may change this risk. No 
                     specific level of risk is recommended for prostate biopsy and this decision should be an individual 
                     choice based upon a physician-patient relationship.
                     </p></big>")

about_eng = HTML("<h1>Contact</h1>
                <big>For questions or comments regarding the TUM Risk Calculator please contact Matthias Jahnen:
                <a href='mailto:matthias.jahnen@tum.de'>matthias.jahnen@tum.de</a> 
                <br><br>
                
                Technical University Rechts der Isar hospital Munich<br>
                Department of Urology<br>
                Ismaninger Str. 22<br>
                81675 Munich<br>
                Germany<br></big>
                ")


about_ger = HTML("<h1>Kontakt</h1>
                <big>Bei Fragen oder Kommentaren bezüglich des TUM Risiko-Rechners senden Sie gerne eine E-Mail an Matthias Jahnen:
                <a href='mailto:matthias.jahnen@tum.de'>matthias.jahnen@tum.de</a> 
                <br><br>
                
                Technische Universität Rechts der Isar Klinikum München<br>
                Klinik und Poliklinik für Urologie<br>
                Ismaninger Str. 22<br>
                81675 München<br>
                Germany<br></big>
                ")


factors_eng = HTML("<h1>Information about calculator input: risk factors</h1>
              <p><b>Prostate Specific Antigen Level (PSA)</b> is the result, in nanograms per mililiter, of the PSA blood test.
              PSA has to be between 0 and 100 [ng/ml]. Zero is not a valid PSA value.</p>
              <br>
              <p><b>Prostate volume</b> in mililiter from the prostate mpMRI.
              The volume has to be between 0 and 100 [ml]. Zero is not a valid volume.</p>
              <br>
              <p>If available, please tick the box and specify the <b>PSA density</b>, otherwise, it is calculated by PSA/Volume.
              If available, the PSA density has to be between 0 and 10, Zero is not a valid value.</p>
              <br>
              <p><b>Pi-RADS</b> score from the prostate mpMRI, an integer between 1-5. </p>
              <br>
              <p><b>Past Negative Biopsy</b>: One or more prior biopsies, all negative, no prior diagnosis of prostate cancer. Note: The Calculator is only applicable for persons without a previous diagnosis of prostate cancer.</p>
              <br></big>")



factors_ger = HTML("<h1>Informationen über die Eingabewerte für den Rechner: Risiko Faktoren</h1>
              <p><b>Prostataspezifisches Antigen Level (PSA)</b>, ein Resultat in Nanogramm pro Mililiter des PSA Bluttests.
              Der PSA Wert sollte zwischen 0 und 100 [ng/ml] liegen, Null ist kein zugelassener Wert.</p>
              <br>
              <p><b>Prostata Volumen</b> in Mililiter vom Prostata MRT.
              Das Volumen sollte zwischen 0 und 100 [ml] liegen, Null ist kein zugelassener Wert.</p>
              <br>
              <p><big> Falls verfügbar, checken Sie bitte die Box und geben die <b>PSA Dichte</b> angegeben werden, ansonsten wird sie berechnet durch PSA/Volume. 
              Die PSA Dichte sollte zwischen 0 und 10 liegen, Null ist kein zugelassener Wert.</p>
              <p><b>Pi-RADS</b> Ergebnis vom Prostata MRT, eine ganze Zahl zwischen 1 und 5. </p>
              <br>
              <p><b>Vorherige negative Prostata-Biopsie</b>: Eine oder mehr vorherige Biopsien, die alle negative ausgefallen sind. <p>
              <p>Keine vorherige Diagnose eines Prostatakarzinoms. Anmerkung:  Der Rechner funktioniert nur für Männer, bei denen kein Prostatakarzinoms bisher diagnostiziert wurde.</p>
              <br></big>
               ")

# Tooltips

tooltip_Age_eng = "Age needs to be between 55 and 90 years."
tooltip_Age_ger = "Alter muss zwischen 55 und 90 Jahren liegen."

tooltip_PSA_eng = "This is the result, in nanograms per mililiter, of the PSA blood test. PSA has to be between 0 and 100 [ng/ml]. Zero is not a valid PSA value."
tooltip_PSA_ger = "Der Wert in Nanogramm pro Mililiter, des PSA Bluttests. Der PSA Wert sollte zwischen 0 und 100 [ng/ml] liegen, Null ist kein zugelassener Wert."

tooltip_Volume_eng = "Prostate volume in cc from the prostate mpMRI. The volume has to be between 0 and 100 [ml]. Zero is not a valid volume."
tooltip_Volume_ger = "Prostata Volumen in cc vom Prostata MRT. Das Volumen sollte zwischen 0 und 100 [ml] liegen, Null ist kein zugelassener Wert."

tooltip_PIRADS_eng = "Pi-RADS score (an integer between 1-5) obtained by the prostate mpMRI."
tooltip_PIRADS_ger = "Pi-RADS Ergebnis (eine ganze Zahl zwischen 1-5) vom Prostata MRT."

tooltip_priobiop_eng = "Past Negative Biopsy: One or more prior biopsies, all negative, no prior diagnosis of prostate cancer."
tooltip_priobiop_ger = "Vorherige negative Prostata-Biopsie: Eine oder mehr vorherige Biopsien, die alle negative ausgefallen sind. Keine vorhergegange Prostatakarzinoms Diagnose."

tooltip_dpsa_avail_eng = "If available, please specify the PSA density."
tooltip_dpsa_avail_ger = "Falls vorhanden, bitte geben Sie die PSA Dichte an."

# Warnings

warning_overall_eng = HTML("<big>fatal error</big>")
warning_overall_ger = HTML("<big>fatal error</big>")


warning_Age_eng = HTML("<big>Sorry, but it is not possible to calculate the risk. <br />
                        Age has to be 55 or older.</big>")
warning_Age_ger = HTML("<big>Bitte entschuldigen Sie, es ist nicht möglich das Risiko zu berechnen. <br />
                        Das Alter muss mindestens 55 Jahre betragen.</big>")

warning_PSA_eng = HTML("<big>Sorry, but it is not possible to calculate the risk. <br />
                        PSA has to lie between 0 und 100 ng/ml, 0 is not a valid value.</big>")
warning_PSA_ger = HTML("<big>Bitte entschuldigen Sie, es ist nicht möglich das Risiko zu berechnen. <br />
                        PSA muss zwischen 0 und 100 ng/ml liegen, 0 ist kein zulässiger Wert.</big>")

warning_Volume_eng = HTML("<big>Sorry, but it is not possible to calculate the risk. <br />
                           The value of prostate volume has to lie between 0 und 100 ml, 0 is not a valid value.</big>")
warning_Volume_ger = HTML("<big>Bitte entschuldigen Sie, es ist nicht möglich das Risiko zu berechnen. <br />
                        Das Volumen muss zwischen 0 und 100 ml liegen, 0 ist kein zulässiger Wert.</big>")

warning_dpsa_eng = HTML("<big>Sorry, but it is not possible to calculate the risk. <br />
                           The value of the PSA density has to lie between 0 und 10, 0 is not a valid value.</big>")
warning_dpsa_ger = HTML("<big>Bitte entschuldigen Sie, es ist nicht möglich das Risiko zu berechnen. <br />
                        Die PSA Dichte muss zwischen 0 und 10 liegen, 0 ist kein zulässiger Wert.</big>")

warning_PIRADS_eng = HTML("<big>Sorry, but it is not possible to calculate the risk. <br />
                        Please enter the Pi-RADS score 1, 2, 3, 4 or 5.</big>")
warning_PIRADS_ger = HTML("<big>Bitte entschuldigen Sie, es ist nicht möglich das Risiko zu berechnen. <br />
                        Das Pi-RADS Ergebnis muss eine ganze Zahl sein, bitte geben Sie einen der folgenden Werte an: 1, 2, 3, 4 oder 5.</big>")

warning_priorbiop0_eng = HTML("<big>Sorry, but it is not possible to calculate the risk, if no information on prior prostate biopsies is provided.</big>")
warning_priorbiop0_ger = HTML("<big>Bitte entschuldigen Sie, es ist nicht möglich das Risiko zu berechnen, wenn keine Angaben zu vorherigen Prostata-Biopsien gemacht werden.</big>")

warning_priorbiop1_eng = HTML("<big>Sorry, but it is not possible to calculate the risk, if there was a prior positive prostate cancer diagnosis.</big>")
warning_priorbiop1_ger = HTML("<big>Bitte entschuldigen Sie, es ist nicht möglich das Risiko bei einer vorherigen Prostatakrebs Diagnose zu berechnen.</big>")