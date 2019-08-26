#############################################
## Data screening                           #
## by using "metagear" & "revtools"         #
##                                          #
## by WhatsUpSis                            #
## 8/25/2019                                #
#############################################

## Install packages
# install.packages(c("BiocManager","gWidgetsRGtk2","RGtk2","gWidgets","cairoDevice",
#                     "metagear","revtools"))
# BiocManager::install("EBImage")

# Load packages
library(metagear)
library(revtools)


## Set up the working directory 
setwd("C:/Users/Downloads/Youtube_Demonstration")

## Open the ris file that you exported from Zotero
dat.raw <- read_bibliography("ForScreening.ris")

View(dat.raw) # View opened data



## Assign the work
theTeam <- c("WS", "SP")

assigned.dat= effort_distribute(aDataFrame = dat.raw, dual = FALSE, 
                         reviewers = theTeam, 
                         column_name = "REVIEWERS", 
                         effort = NULL, initialize = TRUE, 
                         save_split = TRUE, directory = getwd())



# Review article of SP 
abstract_screener(file="effort_SP.csv", 
                  aReviewer = "SP", reviewerColumnName="REVIEWERS", 
                  abstractColumnName = "abstract", unscreenedColumnName = "INCLUDE", 
                  unscreenedValue="not vetted", titleColumnName = "title")







# Merge the csv files including the screening information
screened.dat = effort_merge(directory = getwd(), reviewers = theTeam, dual = FALSE)



# Make a subset of the selected reference 
screened.dat.YES = subset(screened.dat,  INCLUDE =="YES")
 

# Export the data frame in R to RIS file 
screened.dat.YES = screened.dat.YES[,-c(1:3)]

str(screened.dat.YES)

screened.dat.YES = data.frame(lapply(screened.dat.YES, as.character), stringsAsFactors = F)
str(screened.dat.YES)


write_bibliography(screened.dat.YES, "screened_dat_YES.ris", format = "ris")



