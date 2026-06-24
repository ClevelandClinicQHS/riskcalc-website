# riskcalc-website

![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/ClevelandClinicQHS/riskcalc-website)
![GitHub issues](https://img.shields.io/github/issues/ClevelandClinicQHS/riskcalc-website)
![Repository contributors](https://img.shields.io/github/contributors/ClevelandClinicQHS/riskcalc-website.svg)

https://riskcalc.org/ is a repository of risk calculators for various clinical outcomes built to facilitate prediction and decision making for individual patients. This GitHub repository holds the source code for the calculators.

# Structure

The risk calculators are built from the [R Shiny](https://shiny.posit.co/) web framework. Each sub-directory is itself an [R Shiny](https://shiny.posit.co/) application, in which the live version is accessible by indexing the website's root with the application name (i.e., https://riskcalc.org/ _\<sub-directory\>_).

For example, the source code for the app https://riskcalc.org/samplesize/ is in the [samplesize](https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/samplesize) sub-directory.

Currently, only the [R](https://www.r-project.org/) code included in each application is stored in this repository.


# Disclaimer

riskcalc.org is made available for academic, research, teaching, public-health, and other noncommercial purposes under the PolyForm Noncommercial License 1.0.0.

Commercial use is not permitted without prior written permission. This includes incorporation into paid products or services, commercial clinical decision-support platforms, proprietary EHR integrations, revenue-generating hosted services, or paid analytics/consulting offerings.

The calculators are provided for research and educational purposes. They are not a substitute for professional medical judgment and are not authorized for direct clinical use unless separately validated and approved for that purpose.
