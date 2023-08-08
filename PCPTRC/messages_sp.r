# Messages and texts in Spanish

# Disclaimer (start page)

disclaimer_sp = HTML("<h1>Prostate Cancer Prevention Trial Risk Calculator Version 2.0</h1>
                      <h4>Limitación de Responsabilidad</h4>
           
                     <p>
                     La Calculadora del Riesgo de Cáncer de Próstata (Prostate Cancer Risk Calculator-PCPTRC) del Estudio Clínico de la Prevención del Cáncer de Próstata (Prostate Cancer Prevention Trial-PCPT) registrada originalmente en el 2006 fue desarrollada en base de 5519 hombres en el grupo de placebo del Estudio Clínico de la Prevención del Cáncer de Próstata. Todos los 5519 hombres tuvieron inicialmente un antígeno prostático específico (Prostate Specific Antigen-PSA) con un valor menor o igual a 3.0 ng/ml y por siete años se sometieron a exámenes de PSA y examen rectal digital (Digital Rectal Exam-DRE) anualmente. Si el valor de PSA excedía 4.0 ng/ml o si se observaba un examen rectal digital anormal, se les recomendaba una biopsia. Después de siete años, se le recomendó a todos los hombres someterse una biopsia de próstata, independientemente de los resultados de PSA o DRE. El PSA, historia familiar, resultados de DRE, y precedente de una biopsia negativa de próstata previa proveyeron un valor predictivo independiente para el cálculo del riesgo de una biopsia que mostrara la presencia de cáncer. 
                    </p>
                     
                     <p>
                     En el 2012, el PCPTRC actualizado 2.0 fue lanzado con la capacidad adicional de proveer la predicción de cáncer de próstata de grado bajo (grado de Gleason <7) en comparación con alto grado a través de una nueva exposición de los resultados la cual es más fácil de usar. PCPTRC 2.0 se basó en un nuevo análisis de un conjunto ampliado de 6664 biopsias de 5826 pacientes del grupo de placebo del PCPT. Características de los pacientes y las biopsias que constituyen el PCPTRC 2.0 son similares a los utilizados para el PCPTRC original, pero el nuevo PCPTRC 2.0, en general, provee una estimación de riesgo más bajo, debido a la inclusión de múltiples biopsias negativas previas por individuo en lugar de sólo una biopsia por persona. El PCPTRC original todavía está disponible para fines investigativos en el lado derecho de la página de la calculadora, junto con las actualizaciones previas para incorporar otros marcadores del cáncer de próstata. 
                    </p>
                     
                     <p>
                     Puede ser que los resultados de la PCPTRC no apliquen a diferentes grupos de individuos. Debido a que aproximadamente el 80% de los hombres tuvieron una biopsia de la próstata con seis muestras, si más de seis muestras se obtienen en la biopsia, se podría esperar un mayor riesgo de cáncer. La mayoría de los hombres en este estudio eran Caucásicos y resultados pueden ser diferentes con otras etnicidades o razas. La calculadora principalmente sólo aplica a los hombres bajo las siguientes restricciones: 
                    </p>   
                     <ul>
                     <li>Edad de 55 años o más</li>
                     <li>Sin diagnóstico previo de cáncer de próstata</li>
                     <li>Resultados de DRE y PSA más recientes de 1 año</li>
                     </ul>   
                     
                     <p>
                     El PCPTRC aplica para los hombres que son sometidos a exámenes para detectar el cáncer de próstata con PSA y DRE ya que fue derivado de un grupo de hombres en el PCPT que se sometieron a exámenes anuales de PSA y DRE. La estimación del riesgo de la calculadora no refleja un endoso de PSA o DRE para la detección de cáncer de próstata. Esta calculadora está diseñada para proveer una evaluación preliminar del riesgo de cáncer de próstata si se procede con una biopsia de la próstata. Información clínica adicional podría modificar este riesgo. Ningún nivel específico de riesgo se recomienda para proceder con una biopsia de próstata y esta decisión debe ser una selección individual basada en la relación entre el médico y el paciente.
                     </p>")

#####################################################
# Warning messanges (Output page)

warning_age_sp = HTML("TODO: Spanish warning")

warning_psa_sp = HTML("TODO: Spanish warning")

warning_fpsa_sp = HTML("TODO: Spanish warning")

warning_overall_sp = HTML("TODO: Spanish warning")


#####################################################
# Tooltips

tooltip_age_sp = "Edad necesitará ser entre 55 y 90 años de."

tooltip_psa_sp = "Este es el resultado de la prueba de sangre PSA en nanogramos por mililitros."

tooltip_famhist_sp = "Seleccione ''sí'' si su padre, hermano o hijo ha tenido cáncer de la próstata."

tooltip_dre_sp = "El examen rectal digital es una prueba que se lleva a cabo por un profesional de la salud en el cual se explora el recto con un dedo enguantado para palpar la superficie de la próstata. Es normal si la próstata es lisa y suave. Si se observa una zona de firmeza o un nódulo es anormal."

tooltip_priobiop_sp = "Biopsia negativa previa: una o más biopsias previas, todas negativas, sin diagnósticos previos de cáncer de próstata."

tooltip_fpsa_sp = "El porcentaje de APE libre provee la proporción del APE libre al APE total;  este valor se provee directamente con los resultados de modo que no es necesario para el usuario dividir por el APE total."

tooltip_FDR_PC_less60_sp = "Número de miembros de familia (padre biológico, un hermano (no un hermanastro), o hijo biológico) diagnosticados con cáncer de próstata a una edad menor de 60 años. "

tooltip_FDR_PC_60_sp = "Número  de miembros de familia (padre biológico, un hermano (no un hermanastro), o hijo biológico) diagnosticados con cáncer de próstata a una edad de 60 años o más. "

tooltip_FDR_BC_sp = "Número  de miembros de familia (madre biológica, hermana o hija) diagnosticadas con cáncer de mama. "

tooltip_SDR_sp = "Número  de parientes biológicos (tío, abuelo, sobrino o nieto) o un hermanastro diagnosticados con cáncer de próstata. "

#####################################################
# More information tab (main page)

info_sp = HTML("<h1>Información acerca de datos para la calculadora</h1>
               <h4>Nivel de antígeno prostático específico (PSA)</h4>
               <p>Este es el resultado de la prueba de sangre PSA en nanogramos por mililitros.</p>
               <br>
               <h4>Historia familiar de Cáncer de Próstata</h4>
               <p>Seleccione ‘‘sí´ si su padre, hermano o hijo ha tenido cáncer de la próstata.</p>
               <br>
               <h4>Biopsia Prostática Previa</h4>
               <p>Biopsia negativa previa: una o más biopsias previas, todas negativas, sin diagnósticos previos de cáncer de próstata.</p>
               <p>Nota: La calculadora sólo aplica para las personas sin un diagnóstico previo de cáncer de próstata.</p>
               <br>
               <h4>Porcentaje de antígeno prostático específico libre (APE)</h4>
               <p>El porcentaje de APE libre provee la proporción del APE libre al APE total; este valor se provee directamente con los resultados de modo que no es necesario para el usuario dividir por el APE total.</p>
               <br>
               <h4>Examen Rectal Digital (DRE)</h4>
               <p>El examen rectal digital es una prueba que se lleva a cabo por un profesional de la salud en el cual se explora el recto con un dedo enguantado para palpar la superficie de la próstata. Es normal si la próstata es lisa y suave. Si se observa una zona de firmeza o un nódulo es anormal.
              </p>
              <br>
              <h4>Porcentaje de PSA libre</h4>
              <p>El porcentaje de APE libre provee la proporción del APE libre al APE total;  este valor se provee directamente con los resultados de modo que no es necesario para el usuario dividir por el APE total.<p>
              <br>
              <h4>Miembros de familia con cáncer de próstata diagnosticados antes de los 60 años de edad</h4>
              <p>Número de miembros de familia (padre biológico, un hermano (no un hermanastro), o hijo biológico) diagnosticados con cáncer de próstata a una edad menor de 60 años. Decida entre “no”, “sí, uno” o “sí, dos o más”.</p>
              <br>
              <h4>Miembros de familia con cáncer de próstata diagnosticados a los 60 años de edad o más</h4>
              <p>Número  de miembros de familia (padre biológico, un hermano (no un hermanastro), o hijo biológico) diagnosticados con cáncer de próstata a una edad de 60 años o más. Decida entre “no”, “sí, uno” o “sí, dos o más”.</p>
              <br>
              <h4>Miembros de familia con cáncer de mama </h4>
              <p>Número  de miembros de familia (madre biológica, hermana o hija) diagnosticadas con cáncer de mama. Decida entre “no”, “sí, una o más”.</p>
              <br>
              <h4>Parientes con cáncer de próstata</h4>
              <p>Número  de parientes biológicos (tío, abuelo, sobrino o nieto) o un hermanastro diagnosticados con cáncer de próstata. Decida entre “no”, “sí, una o más”.</p>
               <br>
              <span class = 'reference-text'>References:
              <br>Ankerst DP, Hoefler J, Bock S, Goodman PJ, Vickers A, Hernandez J, Sokoll LJ, Sanda MG, Wei JT, Leach RJ, Thompson IM. The Prostate Cancer Prevention Trial Risk Calculator 2.0 for the prediction of low- versus high-grade prostate cancer. Urology 83(6): 1362-7, 2014.
              <br>Grill S, Fallah M, Leach RJ, Thompson IM, Freedland S, Hemminki K, Ankerst DP, Incorporation of Detailed Family History from the Swedish Family-Cancer Database into the Prostate Cancer Prevention Trial Risk Calculator, The Journal of Urology® (2014), doi: 10.1016/j.juro.2014.09.018.
              </span>
              <br>
              <a href='https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/PCPTRC'>Source code</a>
              <p>
               ")
