
# Step 1: Preparation of the R environment

## Install and load R CRAN packages

packages = c("tidyr", "dplyr")

package.check <- lapply(
  packages,
  FUN = function(x) {
    if (!require(x, character.only = TRUE)) {
      install.packages(x, dependencies = TRUE)
      library(x, character.only = TRUE)
    }
  }
)

# Step 2: Load input data

BOLDList<-read.csv("data\\processed\\BOLDList\\Taxon_names_standardised_c.csv") # load species list from BOLD that has been taxonomically standardised (including manual checks)

WatchList<-read.csv("data\\processed\\WatchList\\Taxon_names_standardised_c.csv") # load watch list that has been taxonomically standardised (including manual checks)

InspectList<-read.csv("data\\processed\\InspectionsList\\Taxon_names_standardised_c.csv") # load species list from inspection data that has been taxonomically standardised (including manual checks)

BODATSAList<-read.csv("data\\interim\\BODATSAPrepared.csv") # load species list from BODATSA

# Step 3: Compare species lists

## Compare BOLD to the watch list

### Identify species that are in BOLD and are in the Watch list

BOLDWatchComp<-WatchList%>% filter(scientificName %in% BOLDList$scientificName) # compare lists

## Compare BOLD and BODATSA

### Identify species that are in BOLD, but not in BODATSA

BOLDPlants<-BOLDList %>% filter(phylum == "Tracheophyta" & !is.na(scientificName)) # create a plants subset 

BODATSAFullscientificName<-unique(c(BODATSAList$scientificName, BODATSAList$Accepted)) # get full list of accepted scientific names in BODATSA 

BOLDBODATSAComp<-BOLDPlants%>% filter(!scientificName %in% BODATSAFullscientificName) # compare lists

## Compare BOLD and inspection data

### Identify species that are in BOLD, and in the inspection data as 'absent'

BOLDInspectComp<-InspectList%>% filter(scientificName %in% BOLDList$scientificName) # compare lists

# Step 4: Write prepared data to file

write.csv(BOLDWatchComp, "data//processed//BOLD_WatchList_comparison.csv", row.names=FALSE) # write BOLD and watch list comparison

write.csv(BOLDBODATSAComp, "data//processed//BOLD_BODATSA_comparison.csv", row.names=FALSE) # write BOLD and BODATSA comparison

write.csv(BOLDInspectComp, "data//processed//BOLD_InspectionData_comparison.csv", row.names=FALSE) # write BOLD and inspection data comparison