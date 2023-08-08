# Messages and texts in English

# Disclaimer (start page)

disclaimer_en = HTML("<h1>Prostate Cancer Prevention Trial Risk Calculator Version 2.0</h1>
                      <h4>Disclaimer</h4>
                      <p>
                     The original Prostate Cancer Prevention Trial (PCPT) Prostate Cancer Risk Calculator (PCPTRC) posted 
                     in 2006 was developed based upon 5519 men in the placebo group of the Prostate Cancer Prevention Trial. 
                     All of these 5519 men initially had a prostate-specific antigen (PSA) value less than or equal to 3.0 ng/ml 
                     and were followed for seven years with annual PSA and digital rectal examination (DRE). If PSA exceeded 4.0 
                     ng/ml or if an abnormal DRE was noted, a biopsy was recommended. After seven years, all men were recommended 
                     to have a prostate biopsy, regardless of PSA or DRE findings. PSA, family history, DRE findings, and history 
                     of a prior negative prostate biopsy provided independent predictive value to the calculation of risk of a 
                     biopsy that showed presence of cancer. 
                     </p>
                     
                     <p>
                     In 2012, the updated PCPTRC 2.0 was released with the added capability to provide prediction of low-grade 
                     (Gleason grade &lt; 7) versus high-grade prostate cancer via a new more user-friendly display of results.  PCPTRC 
                     2.0 was based on re-analysis of an expanded set of 6664 biopsies from 5826 patients from the PCPT placebo arm. 
                     Characteristics of the patients and biopsies forming PCPTRC 2.0 are similar to those used for the original PCPTRC, 
                     but the new PCPTRC 2.0 generally provides lower risk estimates due to the inclusion of multiple prior negative 
                     biopsies per individual rather than just one biopsy per person. The original PCPTRC is still available for research 
                     purposes on the right hand side of the calculator page, along with prior updates for incorporating other markers for 
                     prostate cancer. 
                     </p>
                     
                     <p>
                     The results of the PCPTRC may not apply to different groups of individuals. As about 80% of men had a prostate biopsy 
                     with six cores, if more than six cores are obtained at biopsy, a greater risk of cancer may be expected. Most men in 
                     this study were white and results may be different with other ethnicities or races. The calculator is in principle 
                     only applicable to men under the following restrictions:
                     </p>   
                     <ul>
                     <li>Age 55 or older</li>
                     <li>No previous diagnosis of prostate cancer</li>
                     <li>DRE and PSA results less than 1 year old</li>
                     </ul>   
                     
                     <p>
                     The PCPTRC is applicable for men who are undergoing prostate cancer screening with PSA and DRE as it was derived from 
                     a group of men in the PCPT who underwent annual PSA and DRE screening. The risk estimate from the calculator does not 
                     reflect an endorsement of either PSA or DRE for screening for prostate cancer. This calculator is designed to provide 
                     a preliminary assessment of risk of prostate cancer if a prostate biopsy is performed. Additional clinical 
                     information may modify this risk. No specific level of risk is recommended for prostate biopsy and this decision 
                     should be an individual choice based upon a physician-patient relationship.
                     </p>

                     <p>
                     (Note there is a newer calculator, the <a href='http://riskcalc.org:3838/PBCG/'>PBCG</a>, that replaces this one.)
                     </p>")
                             

#####################################################
# Warning messanges (Output page)

warning_age_en = HTML("We are sorry, but we can not calculate the risk of prostate cancer. <br />
                        Age has to be 55 or older.")

warning_psa_en = HTML("We are sorry, but we can not calculate the risk of prostate cancer. <br />
                      PSA has to be between 0 and 50 [ng/ml]. Zero is not a valid PSA value.")

warning_fpsa_en = HTML("We are sorry, but we can not calculate the risk of prostate cancer. <br />
                      Percent free PSA has to be between 5 and 75.")

warning_pca_3_en = HTML("We are sorry, but we can not calculate the risk of prostate cancer. <br />
                      PCA3 has to be between 0.3 and 332.5.")
                      
warning_t2erg_en = HTML("We are sorry, but we can not calculate the risk of prostate cancer. <br />
                      T2ERG has to be between 0.0 and 6031.6.")

warning_overall_en = HTML("We are sorry, but we can not calculate the risk of prostate cancer. One or more characteristics are missing.")


warning_t2erg_fill_en = HTML("We are sorry, but we can not calculate your prostate cancer risk. Please provide a value for PCA3.")


warning_pca3_fill_en = HTML("We are sorry, but we can not calculate your prostate cancer risk when %freePSA and PCA3 are selected. Please uncheck %freePSA or PCA3.")


warning_pca3_t2erg_fill_en = HTML("We are sorry, but we can not calculate your prostate cancer risk when %freePSA, PCA3 and T2:ERG are selected. Please uncheck %freePSA or PCA3 and T2:ERG.")

#####################################################
# Tooltips

tooltip_age_en = "Age needs to be between 55 and 90 years."

tooltip_psa_en = "This is the result, in nanograms per mililiter, of the PSA blood test. PSA has to be between 0 and 50 [ng/ml]. Zero is not a valid PSA value."

tooltip_famhist_en = "Choose Yes if a father, brother, or son had prostate cancer."

tooltip_dre_en = "Digital Rectal Examination is a test performed by a health care professional in which a gloved finger is placed in the rectum to feel the surface of the prostate. It is normal if the prostate is smooth and soft. It is abnormal if an area of firmness or a nodule is noted."

tooltip_priobiop_en = "Past Negative Biopsy: One or more prior biopsies, all negative, no prior diagnosis of prostate cancer."

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
# Map page (web staistics)

stats_en = HTML("<h1>PCPT Risk Calculator Users</h1> <br> 
             <iframe marginwidth='0'   frameborder='0'  marginheight='0' width='800' height='639' src='https://datastudio.google.com/embed/reporting/1enIln74vxcXQrBtFnrEWKoyutvkc3Wy6/page/1M' type='text/html'  style='border:0' allowfullscreen scrolling='no' title='Google Analytics Reporting Tool'></iframe>")



#####################################################
# About page

about_en = HTML("<h1>Contact</h1>
                For questions or comments regarding the PCPT Risk Calculator please send us an email at
                <a href='mailto:myprostatecancerrisk@gmail.com'>myprostatecancerrisk@gmail.com</a> 
                <br><br>
                We hope the calculator has helped you today.<br><br><br>
                
                Your PCPT Risk Calculator support team,<br><br>
                
                D.P. Ankerst<br>
                M.W. Goros<br>
                J. Hoefler<br>
                
                <br><br>
                The PCPT Risk Calculator was developed with urologists at <br><br>
                
                UT Health San Antonio<br>
                Department of Urology<br>
                7703 Floyd Curl Drive<br>
                Mail Code 7845<br>
                San Antonio, Texas 78229-3900<br>
                Phone: (210) 567-5643<br>
                <a href='http://urology.uthscsa.edu/' target='_blank'>http://urology.uthscsa.edu/</a><br><br>
                               
                <br><br>
                The PCPT Risk Calculator was hosted at Cleveland Clinic <br><br>

                Cleveland Clinic<br>
                Department of Quantitative Health Sciences<br>
                <a href='http://riskcalc.org:3838/' target='_blank'>Cleveland Clinic Risk Calculator Library</a><br><br>
                ")


#####################################################
# More information tab (main page)

info_en = HTML("<h1>Information about calculator input</h1>
               <h4>Prostate Specific Antigen Level (PSA)</h4>
              <p>This is the result, in nanograms per mililiter, of the PSA blood test.
              PSA has to be between 0 and 50 [ng/ml]. Zero is not a valid PSA value.</p>
              <br>
              <h4>Family History of Prostate Cancer</h4>
              <p>Choose Yes if a father, brother, or son had prostate cancer.</p>
              <br>
              <h4>Digital Rectal Examination (DRE)</h4>
              <p>Digital Rectal Examination is a test performed by a health care professional in which a gloved finger is placed in the rectum to feel the surface of the prostate. 
                It is normal if the prostate is smooth and soft. 
                It is abnormal if an area of firmness or a nodule is noted.</p>
              <br>
              <h4>Prior Prostate Biopsy</h4>
              <p>Past Negative Biopsy: One or more prior biopsies, all negative, no prior diagnosis of prostate cancer.</p>
              <p>Note: The Calculator is only applicable for persons without a previous diagnosis of prostate cancer.</p>
              <br>
              <h4>Percent free PSA</h4>
              <p>Percent free PSA gives the ratio of free PSA to PSA; this value is directly provided by the manufacturer so that it is not necessary for the user to divide by PSA.
              Percent free PSA has to be between 5 and 75.</p>              
              <br>
              <h4>PCA3</h4>
              <p>Prostate cancer antigen 3 (PCA3, also referred to as DD3) is a gene that expresses a non-coding RNA. PCA3 is only expressed in human prostate tissue, and the gene is
              highly overexpressed in prostate cancer.</p>
              <br>
              <h4>T2:ERG</h4>
              <p>T2:ERG is an advanced urine-based prostate cancer marker.</p>
              <br>              
              <h4>First degree relatives with prostate cancer younger than 60</h4>
              <p>This is the number of first degree relatives (biological father, brother or son) who were diagnosed at age younger than 60. Choose between “No”, “Yes, one” or “Yes, two or more”.</p>
              <br>
              <h4>First degree relatives with prostate cancer older than 60</h4>
              <p>This is the number of first degree relatives (biological father, brother or son) who were diagnosed at age 60 or older. Choose between “No”, “Yes, one” or “Yes, two or more”.</p>
              <br>
              <h4>First degree relatives with breast cancer</h4>
              <p>This is the number of first degree relatives (biological mother, sister or daughter) with breast cancer diagnosed at any age. Choose between “No” and “Yes, one or more”.</p>
              <br>
              <h4>Second degree relatives with prostate cancer</h4>
              <p>This is the number of second degree relatives (biological grandfather, uncle, nephew or grandson) with prostate cancer diagnosed at any age. Choose between “No” and “Yes, one or more”. </p>
              <br>
              <span class = 'reference-text'>References: 
              <br>Ankerst DP, Hoefler J, Bock S, Goodman PJ, Vickers A, Hernandez J, Sokoll LJ, Sanda MG, Wei JT, Leach RJ, Thompson IM. The Prostate Cancer Prevention Trial Risk Calculator 2.0 for the prediction of low- versus high-grade prostate cancer. Urology 83(6): 1362-7, 2014.
              <br>Grill S, Fallah M, Leach RJ, Thompson IM, Freedland S, Hemminki K, Ankerst DP, Incorporation of Detailed Family History from the Swedish Family-Cancer Database into the Prostate Cancer Prevention Trial Risk Calculator, The Journal of Urology® (2014), doi: 10.1016/j.juro.2014.09.018.
              <br>
              <a href='https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/PCPTRC'>Source code</a>
              </span><p>
               ")


               
#####################################################
# PCPTRC 1.0 code

pcptrc1.0_en = HTML("<h1>R Code PCPTRC 1.0</h1><br>
                #PCPT risk calculator, 95% confidence interval<br>
                #psa: psa in ng/mL<br>
                #dre: 1 if abnormal suspicious for cancer; 0 otherwise<br>
                #priorbiop: 1 if prior negative biopsy; 0 if no prior negative biopsy<br>
                #famhist: 1 if first degree positive family history; 0 otherwise<br>
                risk <- function(psa,famhist,dre,priorbiop)<br>
                {
                #Order: Intercept lpsa fampca dre priorbiop<br>
                betas <- c(-1.796793671,0.8488458598,0.2692952172,0.9054345656,-0.448331957)<br>
                x=matrix(c(1,log(psa),famhist,dre,priorbiop),ncol=1)<br>
                pred=betas%*%x<br>
                return(exp(pred)/(1+exp(pred)))<br>
                }<br>
                risk.interval <- function(psa,famhist,dre,priorbiop)<br>
                {<br>
                #Order: Intercept lpsa fampca dre priorbiop<br>
                betas <- c(-1.796793671,0.8488458598,0.2692952172,0.9054345656,-0.448331957)<br>
                varbetas <- matrix(<br>
                c(0.0024863856,-0.001228313,-0.001375148,-0.001352417,-0.000654073,<br>
                -0.001228313,0.0021456952,-0.000120004,0.0002151793,-0.001002991,<br>
                -0.001375148,-0.000120004,0.0074681393,0.0000445035,0.0000268546,<br>
                -0.001352417,0.0002151793,0.0000445035,0.0099989763,-0.001093113,<br>
                -0.000654073,-0.001002991,0.0000268546,-0.001093113,0.0100889794),<br>
                nrow=5,ncol=5,byrow=T)<br>
                x<-matrix(c(1,log(psa),famhist,dre,priorbiop),ncol=1)<br>
                pred=betas%*%x<br>
                phat=exp(pred)/(1+exp(pred))<br>
                dpdbeta=matrix(c(x)*exp(pred)/(1+exp(pred))^2,ncol=1)<br>
                varphat=t(dpdbeta)%*%varbetas%*%dpdbeta<br>
                return(c(phat-1.96*sqrt(varphat),phat+1.96*sqrt(varphat)))<br>
                }<br>
                #PCPT high grade risk calculator, 95% confidence interval<br>
                #psa: psa in ng/mL<br>
                #age: age in years<br>
                #dre: 1 if abnormal suspicious for cancer; 0 otherwise<br>
                #priorbiop: 1 if prior negative biopsy; 0 if no prior negative biopsy<br>
                #aa: 1 if African American; 0 otherwise<br>
                hgrisk <- function(psa,age,dre,priorbiop,aa) {<br>
                #Order: Intercept lpsa age dre priorbiop aa<br>
                betas=matrix(c(-6.2461,1.29267,0.030623,1.00083,-0.36335,0.96039),nrow=1)<br>
                x=matrix(c(1,log(psa),age,dre,priorbiop,aa),ncol=1)<br>
                pred=betas%*%x<br>
                return(exp(pred)/(1+exp(pred)))<br>
                }<br>
                #PCPT high grade risk 95% confidence interval<br>
                hgrisk.interval <- function(psa,age,dre,priorbiop,aa) {<br>
                #Order: Intercept lpsa age dre priorbiop aa<br>
                betas=matrix(c(-6.2461,1.29267,0.030623,1.00083,-0.36335,0.96039),nrow=1)<br>
                varbetas=matrix(<br>
                c(0.71992,-0.01344,-0.009964, -0.00711, 0.00829,-0.03171,<br>
                -0.01344,0.00862,0.000073, 0.00068,-0.00373,-0.00009,<br>
                -0.00996,0.00007,0.000141,0.00002,-0.00014,0.00038,<br>
                -0.00711,0.00068,0.000015,0.02769,-0.00216,0.00153,<br>
                0.00829,-0.00373,-0.000139,-0.00216,0.0323,0.0005,<br>
                -0.03171,-0.00009,0.000378,0.00153,0.0005,0.07137),<br>
                nrow=6,ncol=6,byrow=T)<br>
                x=matrix(c(1,log(psa),age,dre,priorbiop,aa),ncol=1)<br>
                pred=betas%*%x<br>
                phat=exp(pred)/(1+exp(pred))<br>
                dpdbeta=matrix(c(x)*exp(pred)/(1+exp(pred))^2,ncol=1)<br>
                varphat=t(dpdbeta)%*%varbetas%*%dpdbeta<br>
                return(c(phat-1.96*sqrt(varphat),phat+1.96*sqrt(varphat)))<br>
                }<br>
                #PCPT finasteride risk<br>
                #Here if check yes to finasteride<br>
                finrisk <-function(psa,famhist,dre,priorbiop) {<br>
                return(risk(2*psa,famhist,dre,priorbiop))<br>
                }<br>
                finrisk.interval <- function(psa,famhist,dre,priorbiop) {<br>
                return(risk.interval(2*psa,famhist,dre,priorbiop))<br>
                }<br>
                #PCPT finasteride high graderisk<br>
                hgfinrisk <-function(psa,age,dre,priorbiop,aa) {<br>
                return(hgrisk(2*psa,age,dre,priorbiop,aa))<br>
                }<br>
                hgfinrisk.interval <- function(psa,age,dre,priorbiop,aa) {<br>
                return(hgrisk.interval(2*psa,age,dre,priorbiop,aa))<br>
                }<br>
                #PCPT risk incorporating PCA3<br>
                #pca3: urine marker PCA3, no units<br>
                pca3risk=function(pca3,psa,famhist,dre,priorbiop,age) {<br>
                meanco= -.6915-.1137*log(psa)+.0577*age-.3345*dre+.1260*priorbiop<br>
                meanca= 1.1926-.0836*log(psa)+.0376*age+.1055*dre+.0658*priorbiop<br>
                sdco=1.0191<br>
                sdca=1.0366<br>
                lr=dnorm(log(pca3),meanca,sdca)/dnorm(log(pca3),meanco,sdco)<br>
                priorrisk=risk(psa,famhist,dre,priorbiop)<br>
                po=lr*priorrisk/(1-priorrisk)<br>
                pr=po/(1+po)<br>
                return(pr)<br>
                }<br>
                #PCPT risk adjusted for BMI<br>
                #unit: 0=standard, 1=metric<br>
                #height: height in inches or cm<br>
                #weight: weight in pounds or kg<br>
                bmirisk=function(unit,height,weight,psa,famhist,dre,priorbiop,race) {<br>
                if (unit==0) { bmi= weight*703/ height^2 } else<br>
                { bmi= weight*10000/ height^2 }<br>
                if (bmi<25) {adjpsa=psa}<br>
                if (bmi>=25 & bmi<30) {adjpsa=psa*1.09}<br>
                if (bmi>=30 & bmi<35) {adjpsa=psa*1.20}<br>
                if (bmi>=35 & bmi<40) {adjpsa=psa*1.50}<br>
                if (bmi>=40) {adjpsa=psa*1.71}<br>
                return(risk(adjpsa,famhist,dre,priorbiop))<br>
                }<br>
                bmirisk.interval=function(unit,height,weight,psa,famhist,dre,priorbiop,race) {<br>
                if (unit==0) { bmi= weight*703/ height^2 } else<br>
                { bmi= weight*10000/ height^2 }<br>
                if (bmi<25) {adjpsa=psa}<br>
                if (bmi>=25 & bmi<30) {adjpsa=psa*1.09}<br>
                if (bmi>=30 & bmi<35) {adjpsa=psa*1.20}<br>
                if (bmi>=35 & bmi<40) {adjpsa=psa*1.50}<br>
                if (bmi>=40) {adjpsa=psa*1.71}<br>
                return(risk.interval(adjpsa,famhist,dre,priorbiop))<br>
                }<br>
                #PCPT high grade risk adjusted for BMI<br>
                #unit: 0=standard, 1=metric<br>
                #height: height in inches or cm<br>
                #weight: weight in pounds or kg<br>
                bmihgrisk=function(unit,height,weight,psa,age,dre,priorbiop,aa) {<br>
                if (unit==0) { bmi= weight*703/ height^2 } else<br>
                { bmi= weight*10000/ height^2 }<br>
                if (bmi<25) {adjpsa=psa}<br>
                if (bmi>=25 & bmi<30) {adjpsa=psa*1.09}<br>
                if (bmi>=30 & bmi<35) {adjpsa=psa*1.20}<br>
                if (bmi>=35 & bmi<40) {adjpsa=psa*1.50}<br>
                if (bmi>=40) {adjpsa=psa*1.71}<br>
                return(hgrisk(adjpsa,age,dre,priorbiop,aa))<br>
                }<br>
                bmihgrisk.interval=function(unit,height,weight,psa,age,dre,priorbiop,aa) {<br>
                if (unit==0) { bmi= weight*703/ height^2 } else<br>
                { bmi= weight*10000/ height^2 }<br>
                if (bmi<25) {adjpsa=psa}<br>
                if (bmi>=25 & bmi<30) {adjpsa=psa*1.09}<br>
                if (bmi>=30 & bmi<35) {adjpsa=psa*1.20}<br>
                if (bmi>=35 & bmi<40) {adjpsa=psa*1.50}<br>
                if (bmi>=40) {adjpsa=psa*1.71}<br>
                return(hgrisk.interval(adjpsa,age,dre,priorbiop,aa))<br>
                }<br>
                #PCPT risk incorporating both %freePSA and [-2]proPSA<br>
                #perfreepsa: percent free PSA<br>
                #propsa: [-2]proPSA in pg/mL<br>
                postrisk=function(perfreepsa,propsa,psa,famhist,dre,priorbiop,age) {<br>
                #order %freePSA, [-2]proPSA<br>
                newmarkers=matrix(c(log(perfreepsa),log(propsa)),nrow=2)<br>
                meanco=matrix(c(3.276295183-0.234577552*log(psa)+0.002135001*age,2.438274781+0.571381464*log(psa)-0.007579198*age),nrow=2)<br>
                meanca=matrix(c(2.66738151-0.36519414*log(psa)+0.01103519*age,1.38475606+0.62748815*<br>
                log(psa)+0.00610934*age),nrow=2)<br>
                varco=matrix(c(0.12784019,0.09661401,0.09661401,0.18780600),nrow=2)<br>
                varca=matrix(c(0.1793767,0.1207655,0.1207655,0.2310282),nrow=2)<br>
                distco=newmarkers-meanco<br>
                distca=newmarkers-meanca<br>
                loglr=-0.5*(log(det(varca))-log(det(varco))+t(distca)%*%solve(varca)%*%distca-t(distco)%*%solve(varco)%*%distco)<br>
                lr=exp(loglr)<br>
                priorrisk=risk(psa,famhist,dre,priorbiop)<br>
                po=lr*priorrisk/(1-priorrisk)<br>
                pr=po/(1+po)<br>
                return(pr)<br>
                }<br>
                #PCPT risk incorporating %freePSA<br>
                #%freePSA: units in percent<br>
                perfreepsarisk=function(perfreepsa,psa,famhist,dre,priorbiop,age) {<br>
                meanco=3.276-0.235*log(psa)+0.002*age<br>
                meanca=2.667-0.365*log(psa)+0.011*age<br>
                sdco=sqrt(0.128)<br>
                sdca=sqrt(0.179)<br>
                lr=dnorm(log(perfreepsa),meanca,sdca)/dnorm(log(perfreepsa),meanco,sdco)<br>
                priorrisk=risk(psa,famhist,dre,priorbiop)<br>
                po=lr*priorrisk/(1-priorrisk)<br>
                pr=po/(1+po)<br>
                return(pr)<br>
                }<br>
                #PCPT risk incorporating [-2]proPSA<br>
                #[-2]proPSA: units in pg/mL<br>
                propsarisk=function(propsa,psa,famhist,dre,priorbiop,age) {<br>
                meanco=2.438+0.571*log(psa)-0.008*age<br>
                meanca=1.385+0.627*log(psa)+0.006*age<br>
                sdco=sqrt(0.188)<br>
                sdca=sqrt(0.231)<br>
                lr=dnorm(log(propsa),meanca,sdca)/dnorm(log(propsa),meanco,sdco)<br>
                priorrisk=risk(psa,famhist,dre,priorbiop)<br>
                po=lr*priorrisk/(1-priorrisk)<br>
                pr=po/(1+po)<br>
                return(pr)<br>
                }<br>
                ####################################################################################<br>
                ##########<br>
                ####################################################################################<br>
                ##########<br>
                # PCPTRC_CLIN: Risk of any prostate cancer incorporating volume and number of cores<br>
                # Score = 0.663 + 2.008L2PSA + 1.408DRE + 0.231FamHist ? 0.567L2VOL<br>
                # -0.241L2PSA?L2VOL + 0.055NCORES<br>
                risk.pcptrc.clin <- function(psa, dre, famhist, vol, ncores)<br>
                {<br>
                #betas. intercept, log2 psa, dre, famhist, log2 vol, interaction log2psa with<br>
                # log2 vol, number of cores<br>
                betas <- c(0.663,2.008,1.408,0.231,-0.567,-0.241,0.056)<br>
                predictors <- c(1, log2(psa), dre, famhist, log2(vol), log2(psa)*log2(vol),<br>
                ncores)<br>
                prediction <- sum(betas*predictors)<br>
                plogis(prediction) # = exp(x) / (1+exp(x))<br>
                }<br>
                # PCPTHG_CLIN: Risk of high-grade disease incorporating volume and number of cores (Gleason grade >= 7)<br>
                # Score = -0.979 + 1.169L2PSA + 1.117DRE + 1.018AA ? 0.855L2VOL<br>
                # + 0.149NCORES<br>
                risk.pcpthg.clin <- function(psa, dre, aa, vol, ncores)<br>
                {<br>
                #betas. intercept, log2 psa, dre, african american, log2 vol, number of cores<br>
                betas <- c(-0.979,1.169,1.117,1.018,-0.855,0.149)<br>
                predictors <- c(1, log2(psa), dre, aa, log2(vol), ncores)<br>
                prediction <- sum(betas*predictors)<br>
                plogis(prediction) # = exp(x) / (1+exp(x))}<br>
                # PCPTRC_AUA: Risk of any prostate cancer incorporating AUA score<br>
                # Score = -1.661 + 0.665L2PSA + 1.067DRE + 0.254FamHist - 0.532PriorBiop<br>
                # - 0.019AUASS<br>
                risk.pcptrc.aua <- function(psa, dre, famhist, priorbiop, auass)<br>
                {<br>
                #betas. intercept, log2 psa, dre, famhist, prior biop, AUA symptom score<br>
                betas <- c(-1.661, 0.665, 1.067, 0.254, -0.532, -.019)<br>
                predictors <- c(1, log2(psa), dre, famhist, priorbiop, auass)<br>
                prediction <- sum(betas*predictors)<br>
                plogis(prediction) # = exp(x) / (1+exp(x))<br>
                <br>}<br>
                # PCPTHG_AUA: Risk of high-grade disease (Gleason grade = 7) incorporating AUA score<br>
                # Score = - 5.881 + 1.115L2PSA + 1.146DRE + 0.919AA ? 0.594PriorBiop<br>
                # + 0.027Age ? 0.035AUASS<br>
                risk.pcpthg.aua <- function(psa, dre, aa, priorbiop, age, auass)<br>
                {<br>
                #betas. intercept, log2 psa, dre, aa, prior biop, age, AUA symptom score<br>
                betas <- c(-5.881, 1.115, 1.146, 0.919, -0.594, 0.027, -0.035)<br>
                predictors <- c(1, log2(psa), dre, aa, priorbiop, age, auass)<br>
                prediction <- sum(betas*predictors)<br>
                plogis(prediction) # = exp(x) / (1+exp(x))<br>
                }<br>
                ####################################################################################<br>
                ##########<br>
                ####################################################################################<br>
                ##########<br>
                ####################################################################################<br>
                ##########<br>
                # finPCPTRC_CLIN: On finasteride, risk of any prostate cancer incorporating volume<br>
                # Score = -0.451 + 0.993L2PSA + 0.929DRE + 0.028Age - 0.622L2VOL<br>
                fin.pcptrc.clin <- function(psa, dre, age, vol)<br>
                {<br>
                score <- -0.451 + 0.993*log2(psa) + 0.929*dre + 0.028*age - 0.622*log2(vol)<br>
                plogis(score)<br>
                }<br>
                # finPCPTHG_CLIN: On finasteride, risk of high grade disease (Gleason grade > 6) incorporating volume<br>
                # Score = -3.104 + 1.220L2PSA + 1.011DRE + 0.045Age - 0.604L2VOL<br>
                fin.pcpthg.clin <- function(psa, dre, age, vol)<br>
                {<br>
                score <- -3.104 + 1.220 * log2(psa) + 1.011 * dre + 0.045 * age - 0.604 *<br>
                log2(vol)<br>
                plogis(score)<br>
                }<br>
                # finPCPTRC_AUA: On finasteride, risk of any prostate cancer incorporating AUA score<br>
                # Score = -2.561 + 0.939L2PSA + 1.062DRE + 0.019Age - 0.454PriorBiop - 0.017AUASS<br>
                fin.pcptrc.clin.aua <- function(psa, dre, age, priorbiop, auass)<br>
                {<br>
                score <- -2.561 + 0.939 * log2(psa) + 1.062 * dre + 0.019 * age - 0.454*priorbiop<br>
                - 0.017*auass<br>
                plogis(score)<br>
                }<br>
                # finPCPTHG_AUA: On finasteride, risk of high-grade disease incorporating AUA score<br>
                # Score = -5.669 + 1.174L2PSA + 1.120DRE + 0.044Age - 0.028AUASS<br>
                fin.pcpthg.clin.aua <- function(psa, dre, age, auass)<br>
                {<br>
                score <- -5.669 + 1.174 * log2(psa) + 1.120 * dre + 0.044 * age - 0.028 * auass<br>
                plogis(score)<br>
                }<br>
                <br><br><br>
                <h1>Nominal logistic regression/standard risk factors</h1>
                PSA: enter prostate-specific antigen in ng/mL<br>
                DRE: enter 1 if digital rectal examination is abnormal, 0 otherwise<br>
                FAMHIST: enter 1 if there is a first-degree family history of prostate cancer, 0 otherwise<br>
                PRIORBIOP: enter 1 if there has been one or more prior biopsies performed (all negative for prostate cancer), 0 otherwise<br>
                AA: enter 1 for African American, 0 otherwise<br>
                AGE: enter age in years<br>
                <br>
                S1 = -3.002 + 0.256L2PSA + 0.016Age + 0.122AA - 0.455PriorBiop - 0.039DRE + 0.272FamHist<br> 
                <br>
                S2 = -7.053 + 0.705L2PSA + 0.048Age + 1.042AA - 0.214PriorBiop + 0.401DRE + 0.225FamHist<br> 
                <br>
                Risk of no cancer = 1/[1 + exp(S1) + exp(S2)]<br>
                Risk of low-grade cancer = exp(S1)/[1 + exp(S1) + exp(S2)]<br>
                Risk of high-grade cancer = exp(S2)/[1 + exp(S1) + exp(S2)]<br>                
                ")


