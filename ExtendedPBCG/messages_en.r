# Messages and texts in English
                    

#####################################################
# Warning messanges (Output page)

warning_age_en = HTML("We are sorry, but we can not calculate the risk of prostate cancer. <br />
                        Age has to be 40 or older.")

warning_psa_en = HTML("We are sorry, but we can not calculate the risk of prostate cancer. <br />
                      PSA has to be between 2 and 50 [ng/ml].")

warning_prosvol_en = HTML("We are sorry, but we can not calculate the risk of prostate cancer. <br />
                      Prostate volume has to be between 15 and 300 [cc]. (leave blank if unknown)")

warning_fpsa_en = HTML("We are sorry, but we can not calculate the risk of prostate cancer. <br />
                      Percent free PSA has to be between 2 and 50.")

warning_pca_3_en = HTML("We are sorry, but we can not calculate the risk of prostate cancer. <br />
                      PCA3 has to be between 0.3 and 332.5.")
                      
warning_t2erg_en = HTML("We are sorry, but we can not calculate the risk of prostate cancer. <br />
                      T2ERG has to be between 0.0 and 6031.6.")

warning_overall_en = HTML("We are sorry, but we can not calculate the risk of prostate cancer. Age and PSA are mandatory.")


warning_t2erg_fill_en = HTML("We are sorry, but we can not calculate your prostate cancer risk. Please provide a value for PCA3.")


warning_pca3_fill_en = HTML("We are sorry, but we can not calculate your prostate cancer risk when %freePSA and PCA3 are selected. Please uncheck %freePSA or PCA3.")


warning_pca3_t2erg_fill_en = HTML("We are sorry, but we can not calculate your prostate cancer risk when %freePSA, PCA3 and T2:ERG are selected. Please uncheck %freePSA or PCA3 and T2:ERG.")

#####################################################
# Tooltips

tooltip_age_en = "Age needs to be between 40 and 90 years."

tooltip_psa_en = "This is the result, in nanograms per mililiter, of the PSA blood test. PSA has to be between 2 and 50 [ng/ml]."

tooltip_prosvol_en = "This is the result, in cubic centimeter of prostate volume. Prostate volume has to be between 15 and 300 cc (leave blank if unknown)"

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
              <h2>Reference</h2>
              <p>Neumair, M., Kattan, M.W., Freedland, S.J. et al. Accommodating heterogeneous missing data patterns for prostate cancer risk prediction. BMC Med Res Methodol 22, 200 (2022). <a href='https://doi.org/10.1186/s12874-022-01674-x'>https://doi.org/10.1186/s12874-022-01674-x</a></p>
              <h2>Information about calculator input</h2>
               <h4>Prostate Specific Antigen Level (PSA)</h4>
              <p>This is the result, in nanograms per mililiter, of the PSA blood test.
              PSA has to be between 2 and 50 [ng/ml].</p>
              <h4>Digital Rectal Examination (DRE)</h4>
              <p>Digital Rectal Examination is a test performed by a health care professional in which a gloved finger is placed in the rectum to feel the surface of the prostate. 
                It is normal if the prostate is smooth and soft. 
                It is abnormal if an area of firmness or a nodule is noted.</p>
              <h4>African ancestry</h4>
              <p>Choose Yes if you are black or African American.</p>
              <h4>Hispanic</h4>
              <p>Choose Yes if you are of Hispanic ethnicity.</p>
              <h4>Prior Prostate Biopsy</h4>
              <p>Past Negative Biopsy: One or more prior biopsies, all negative, no prior diagnosis of prostate cancer.</p>
              <h4>Prior PSA</h4>
              <p>Choose Yes if you had a prior PSA measurement before the current one, independent of the result.</p>
              <h4>Family history</h4>
              <p>First-degree: Choose Yes if a father, brother, or son had prostate cancer.</p>
              <p>Second-degree: Choose Yes if a grandfather, uncle, nephew, or half-brother had prostate cancer.</p>
              <p>Breast cancer: Choose Yes if a mother, sister, or daughter had breast cancer.</p>
              <h4>5-ARI</h4>
              <p>5-alpha-reductase inhibitors are a group of drugs that are used in the treatment of an enlarged prostate gland. Choose Yes if you take them.</p>
              <br>
              <h3>Note: The Calculator is only applicable for persons without a previous diagnosis of prostate cancer.</h3>
              <h3>For help please contact <a href='mailto:ankerst@tum.de'>ankerst@tum.de</a></h3>
              <br>
              <a href='R_code_PBCG_risk_calculator.R'>Download R code</a>
              </span><p>
               ")


               
