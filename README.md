# A workflow to ensure first reports of alien species from molecular analyses are acted upon
This workflow was developed to ensure molecular observations of alien species are evaluated and acted upon. The workflow was developed using South Africa as a case study. It compares records from the ‘Barcode of Life Data System’ (BOLD) (Ratnasingham and Hebert 2007; Ratnasingham et al. 2024) to three datasets: a watch list of species of concern (Faulkner et al. 2014), a list of high-risk pests detected at-border in imports but not known to occur post-border within South Africa (Saccaggi et al. 2021); and the [Botanical Database of Southern Africa](http://posa.sanbi.org/). The workflow comprises three main steps: 

1. Acquisition, initial inspection, and preparation of the original datasets
2. Taxonomic standardisation of species names across datasets; 
3. Pairwise comparison of standardised lists 

Note that in step 2 the automated workflow to standardise taxon names for South African alien species lists is executed in an iterative way for datasets. Details on the workflow implemented in step 2 can be found in this [GitHub repository](https://github.com/KatelynFaulkner/rsa-ans-workflow)

## Requirements 

The following are required to execute the workflow: 

1. Installed R software (version 4.4.0 or higher) and Rstudio

2. Installed R packages: "tidyr", "dplyr","rgbif", "stringr", "stringdist", "rWCVP", "purrr", "lubridate", "remotes", "rWCVPdata"

3. A stable internet connection

### The R environment

R (version 4.0.0 or higher) and Rstudio need to be installed, which are freely available at: https://cran.r-project.org and https://www.rstudio.com/

### Installing the required packages

Ten R packages and their dependencies must be installed. Nine of these packages can be obtained through the R CRAN, and the remaining package "rWCVPdata" can be obtained from GitHub, using the package "remotes". 

If executed the following code will load and, if required, install the packages.

Specify the packages required from R CRAN:

```{r}
packages = c("tidyr", "dplyr",
             "rgbif", "stringr", "stringdist", "rWCVP", "purrr", "lubridate")
```

Install R CRAN packages (if required) and load:

```{r}
package.check <- lapply(
  packages,
  FUN = function(x) {
    if (!require(x, character.only = TRUE)) {
      install.packages(x, dependencies = TRUE)
      library(x, character.only = TRUE)
    }
  }
)
```

Install (if required) the "remotes" package from R CRAN and the "rWCVPdata" package from GitHub, and load these packages as required:

```{r}
rWCVPcheck<-"rWCVPdata" %in% rownames(installed.packages())
if(rWCVPcheck == FALSE){
remotes.check<-"remotes" %in% rownames(installed.packages()) 
if(remotes.check == FALSE){
  install.packages("remotes") # install remotes if required
}
remotes::install_github('matildabrown/rWCVPdata')
}
require('rWCVPdata')
```

## Installing and running the scripts

This repository can be downloaded onto your computer as a zip file. The downloaded zip file will contain all the required folders. The zip file will need to be extracted. The main folder contains the Rstudio project file (bold-first-report.Rproj) of the workflow. This file should be opened to use the workflow. The subfolder `R/` contains the scripts for each step as annotated .Rmd files. 

## References

Faulkner KT, Robertson MP, Rouget M, Wilson JR (2014) A simple, rapid methodology for developing invasive species watch lists. Biological Conservation 179: 25–32.

Ratnasingham S, Hebert PDN (2007) BOLD: The Barcode of Life Data System (http://www.barcodinglife.org). Molecular Ecology Notes 7: 355–364. https://doi.org/10.1111/j.1471-8286.2007.01678.x.

Ratnasingham S, Wei C, Chan D, Agda J, Agda J, Ballesteros-Mejia L, Ait Boutou H, El Bastami Z M, Ma E, Manjunath R, Rea D, Ho C, Telfer A, McKeowan J, Rahulan M, Steinke C, Dorsheimer J, Milton M, Hebert PDN (2024) BOLD v4: A Centralized Bioinformatics Platform for DNA-Based Biodiversity Data. In DNA Barcoding: Methods and Protocols, pp. 403-441. Chapter 26. New York, NY: Springer US.

Saccaggi DL, Arendse M, Wilson JR, Terblanche JS (2021) Contaminant organisms recorded on plant product imports to South Africa 1994–2019. Scientific data, 8(1), 83. https://doi.org/10.1038/s41597-021-00869-z
