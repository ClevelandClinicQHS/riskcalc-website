# riskcalc-website

![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/ClevelandClinicQHS/riskcalc-website)
![GitHub issues](https://img.shields.io/github/issues/ClevelandClinicQHS/riskcalc-website)
![Repository contributors](https://img.shields.io/github/contributors/ClevelandClinicQHS/riskcalc-website.svg)

https://riskcalc.org/ is a repository of risk calculators for various clinical outcomes built to facilitate prediction and decision making for individual patients. This GitHub repository holds the source code for the calculators.

# Structure

The risk calculators are built from the [R Shiny](https://shiny.posit.co/) web framework. Each sub-directory is itself an [R Shiny](https://shiny.posit.co/) application, in which the live version is accessible by indexing the website's root with the application name (i.e., https://riskcalc.org/<sub-directory>).

For example, the source code for the app https://riskcalc.org/samplesize/ is in the [samplesize](https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/samplesize) sub-directory.

Currently, only the [R](https://www.r-project.org/) code included in each application is stored in this repository.