## merge øKOKYST climate data with cdom and light
---
  title: "Merge datasets for ØKOKYST reporting"
author: "Therese Harvey"
date: "16 february 2021"
output: R script
---
library(tidyverse)
library(readr)
getwd()


#Read in files
folderin<-"Datasett"

aqm <- read.table("Datasett/OKOKYST_Klima_cleaned.csv", quote='"',sep=",", header=TRUE,stringsAsFactors=F) # median values per lab and station
cdom <- read.table("Datasett/results_all_spectras_OKOKYST2021_final.csv", quote='"',sep=",", header=TRUE,stringsAsFactors=F) # median values per lab and station

names(df)
df<- select(df, -X)
cdom <- cdom %>% rename(Depth1=Depth, StationId=Station_code, Slope=S_mod1) %>%
mutate(Depth2=Depth1)

#change dates to dates

# df$Date<-as.character(rs2$Date)

#first row needed sometimes
cdom$Date<-strptime(cdom$Date,format="%d/%m/%Y") #defining what is the original format of your date
cdom$Date<- as.Date(cdom$Date,format="%Y-%m-%d")  #defining what is the desired format of your date

df$Date<-as.Date(df$Date,format="%Y-%m-%d") #defining what is the desired format of your date

#select columns that should be merged
cdom<- select(cdom, a_443, Slope, Depth1, Depth2, Date, StationID)

merge<- left_join(df, cdom, by=c("Depth1", "Depth2", "Date",   "StationId")) 

names (df)

