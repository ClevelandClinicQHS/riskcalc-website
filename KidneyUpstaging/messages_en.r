# Messages and texts in English
                    

#####################################################
# Warning messanges (Output page)

warning_age_en = HTML("We are sorry, but we can not calculate the risk. <br />
                        Age has to be between 18 and 100.")

warning_bmi_en = HTML("We are sorry, but we can not calculate the risk. <br />
                      BMI has to be between 14 and 75.")

warning_preopsize_en = HTML("We are sorry, but we can not calculate the risk. <br />
                      Pre-operative size has to be between 0.5 and 7.")

warning_fpsa_en = HTML("We are sorry, but we can not calculate the risk of prostate cancer. <br />
                      Percent free PSA has to be between 2 and 50.")

warning_pca_3_en = HTML("We are sorry, but we can not calculate the risk of prostate cancer. <br />
                      PCA3 has to be between 0.3 and 332.5.")
                      
warning_t2erg_en = HTML("We are sorry, but we can not calculate the risk of prostate cancer. <br />
                      T2ERG has to be between 0.0 and 6031.6.")

warning_overall_en = HTML("We are sorry, but we can not calculate the risk. Age, BMI, and Pre-operative size are mandatory.")


warning_t2erg_fill_en = HTML("We are sorry, but we can not calculate your prostate cancer risk. Please provide a value for PCA3.")


warning_pca3_fill_en = HTML("We are sorry, but we can not calculate your prostate cancer risk when %freePSA and PCA3 are selected. Please uncheck %freePSA or PCA3.")


warning_pca3_t2erg_fill_en = HTML("We are sorry, but we can not calculate your prostate cancer risk when %freePSA, PCA3 and T2:ERG are selected. Please uncheck %freePSA or PCA3 and T2:ERG.")

#####################################################
# Tooltips

tooltip_age_en = "Age needs to be between 18 and 100 years."

tooltip_bmi_en = "BMI needs to be between 14 and 75."

tooltip_preopsize_en = "Pre-operative size needs to be between 0.5 and 7."

tooltip_race_en = "Choose Yes if you are black or African American."

tooltip_famhistory1_en = "Choose Yes if a father, brother, or son had prostate cancer."

tooltip_famhistory2_en = "Choose Yes if a grandfather, uncle, nephew, or half-brother had prostate cancer."

tooltip_famhistorybca_en = "Choose Yes if a mother, sister, or daughter had breast cancer."

tooltip_priorpsa_en = "Choose Yes if you had a prior PSA measurement before the current one, independent of the result."

tooltip_hispanic_en = "Choose Yes if you are of hispanic ethnicity."

tooltip_ari_en = "5-alpha-reductase inhibitors are a group of drugs that are used in the treatment of an enlarged prostate gland. Choose Yes if you take them."

tooltip_famhist_en = "Choose Yes if a father, brother, or son had prostate cancer."

tooltip_dre_en = "Digital rectal examination is a test performed by a health care professional in which a gloved finger is placed in the rectum to feel the surface of the prostate. It is normal if the prostate is smooth and soft. It is abnormal if an area of firmness or a nodule is noted."

tooltip_priobiop_en = "Past negative biopsy: one or more prior biopsies, all negative, no prior diagnosis of prostate cancer."

tooltip_fpsa_en = "Percent free PSA gives the ratio of free PSA to PSA; this value is directly provided by the manufacturer so that it is not necessary for the user to divide by PSA. Percent free PSA has to be between 5 and 75."

tooltip_pca3_en = "Prostate cancer antigen 3 (PCA3, also referred to as DD3) is a gene that expresses a non-coding RNA. PCA3 is only expressed in human prostate tissue, and the gene is highly overexpressed in prostate cancer."

tooltip_t2erg_en = "T2:ERG is an advanced urine-based prostate cancer marker."

tooltip_FDR_PC_less60_en = "This is the number of first degree relatives (biological father, brother or son) who were diagnosed at age younger than 60."

tooltip_FDR_PC_60_en = "This is the number of first degree relatives (biological father, brother or son) who were diagnosed at age 60 or older."

tooltip_FDR_BC_en = "This is the number of first degree relatives (biological mother, sister or daughter) with breast cancer diagnosed at any age. "

tooltip_SDR_en = "This is the number of second degree relatives (biological grandfather, uncle, nephew or grandson) with prostate cancer diagnosed at any age. "

#####################################################
# News page

news_en = HTML("<table>
            <tr>
            <td>
               <a href='http://www.ksat.com/content/pns/ksat/lifestyle/health/2014/08/cancer-center-develops-new-prostate-cancer-test.html' target='_blank'>
               <img src='screenshot.jpg', width='300px'>
               </a><br><br>
               <td width='10px'></td>
               <td valign='top'>
               <h4>Risk Calculator in the media</h4>
               <small>[Aug 13, 2014]</small><br>
               Cancer Treatment and Research Center's cancer calculator determines men's risk <br />
               <br>
               Presentation of the Risk Calculator at <a href='http://www.ksat.com/' target='_blank'>KSAT</a>
               </td>
               </tr>
               <tr>
               <td>
               <a href='http://jama.jamanetwork.com/article.aspx?articleid=1894644' target='_blank'>
               <img src='screenshot2.jpg', width='300px'>
               </a></td>
               <td width='10px'></td>
               <td valign='top'>
               <h4>Scientific article in the Journal of the<br> American Medical Association (JAMA)</h4>
               <small>[Aug 04,2014]</small><br>
               Ian M. Thompson Jr, Robin J. Leach, Donna P. Ankerst (2014)<br>
               <b>Focusing PSA Testing on Detection of High-Risk Prostate Cancers <br>
               by Incorporating Patient Preferences Into Decision Making</b><br>
               <i>The Journal of the American Medical Association</i>, Published online August 04, 2014,<br>
               doi:10.1001/jama.2014.9680.
               </td>
               </tr>
               </table>
               <br><br>
               ")


#####################################################
# More information tab (main page)

info_en = HTML("
              <h3>Information about calculator input</h3>
<h4>Age</h4>
<p>This is the age you will be at the time of your surgery, not at the time of the detection of the tumor. </p>
<h4>Body Mass Index (BMI)</h4>
<p>Body mass index (BMI) is a calculated measurement of body fat and is related to disease. This is calculated as either: weight (kg)/height (m<sup>2</sup>) or as weight (lb)/height (in<sup>2</sup>) × 703. This measurement should be calculated based at the time of your kidney tumor diagnosis.</p>
<h4>Pre-operative tumor size (cm)</h4>
<p>This is the maximal dimension of your tumor in centimeters (cm). This size is based on either computed tomography (ie CT) or magnetic resonance imaging (MRI) scan. Ultrasound based tumor measurements are not included.</p>
<h4>Diabetes</h4>
<p>Choose Yes if you have ever been told by your health care provider that you have diabetes. If you were told you have ‘Pre-diabetes’ and are not on any medications for your blood sugar you should select ‘No’. </p>
<h4>Sex</h4>
<p>This refers to your biological sex assigned at birth.</p>
<h4>Intended Surgery</h4>
<p>Choose ‘Radical’ if your health care provider states that they intend to perform a partial nephrectomy (ie removal of only the tumor and saving the remainder of the kidney). Choose ‘Radical’ if your health care provider tells you that you will require the removal of the entire kidney with the tumor. You can also select ‘Radical’ if your provider informs you that there is a very high chance you will require a radical nephrectomy (ie total tumor removal). </p>

<h4>Note: The results of the Calculator pertain to those patients who, upon surgical removal of the tumor, were confirmed to have a pathologic diagnosis of kidney cancer. This calculator was developed based on a large multinational retrospective study of 6196 patients from 11 institutions in 7 countries. While the vast majority of kidney tumors are cancerous a small percentage of tumors will be found to be non-cancerous; the likelihood of kidney cancer increases with increasing tumor size. The Calculator is only applicable for persons who do not have a known hereditary syndrome pre-disposing to them to kidney cancer. </h4>

              <h3>For help please contact <a href='mailto:pruthi@uthscsa.edu'>pruthi@uthscsa.edu</a></h3>
              <br>
              <p><a href='R_code_kidney_upstaging_risk_calculator.R'>Download R code</a></p>
               ")


               
