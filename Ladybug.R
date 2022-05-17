# DATA 332 Final Project 
# Authors: Kate Martino, Nicole Nguyen, Tran Bui, CLaire Weeks
# Ladybug Data

# Load the required packages 
library(tidyverse)
library(dplyr)
library(readxl)
library(lubridate)
library(readr)

# Set the working directory 
rm(list=ls())
setwd("/Users/katemartino/Desktop/Data 332 Final Project")

# Load Data from Excel 
df_scan_ladybug <- read_excel("data/ScanLadybugData.xls", sheet = 1)
df_ladybug <- read_excel("data/LadybugData.xlsx", sheet = 1) 

# Cleaned the data to fix string inconsistencies in the data for the collector column
unique(df_ladybug$collector)
  df_ladybug$collector <- str_replace(df_ladybug$collector, "J Hughes", "J. Hughes")
  df_ladybug$collector <- str_replace(df_ladybug$collector, "Jack Hughes", "J. Hughes")
  df_ladybug$collector <- str_replace(df_ladybug$collector, "j. Hughes", "J. Hughes")
  df_ladybug$collector <- str_replace(df_ladybug$collector, "J. hughes", "J. Hughes")
  df_ladybug$collector <- str_replace(df_ladybug$collector, "jack hughes", "J. Hughes")
  df_ladybug$collector <- str_replace(df_ladybug$collector, "J. Hughees", "J. Hughes")
  df_ladybug$collector <- str_replace(df_ladybug$collector, "j. hughes", "J. Hughes")
  df_ladybug$collector <- str_replace(df_ladybug$collector, "Olivia Ruffatto", "O. Ruffatto")
  df_ladybug$collector <- str_replace(df_ladybug$collector, "O. ruffatto", "O. Ruffatto")
  df_ladybug$collector <- str_replace(df_ladybug$collector, "o. Ruffatto", "O. Ruffatto")
  df_ladybug$collector <- str_replace(df_ladybug$collector, "Olivia ruffatto", "O. Ruffatto")
  df_ladybug$collector <- str_replace(df_ladybug$collector, "o. ruffattto", "O. Ruffatto")
  df_ladybug$collector <- str_replace(df_ladybug$collector, "o. ruffatto", "O. Ruffatto")
  df_ladybug$collector <- str_replace(df_ladybug$collector, "OliviaRuffatto", "O. Ruffatto")
  df_ladybug$collector <- str_replace(df_ladybug$collector, "m gorsegner", "M. Gorsegner")
  df_ladybug$collector <- str_replace(df_ladybug$collector, "m. gorsegner", "M. Gorsegner")
  df_ladybug$collector <- str_replace(df_ladybug$collector, "M.Gorsegner", "M. Gorsegner")
  df_ladybug$collector <- str_replace(df_ladybug$collector, "Marissa Gorsegner", "M. Gorsegner")
  df_ladybug$collector <- str_replace(df_ladybug$collector, "M. gorsegner", "M. Gorsegner")
  df_ladybug$collector <- str_replace(df_ladybug$collector, "v. cervantes", "V. cervantes")
  df_ladybug$collector <- str_replace(df_ladybug$collector, "Veronica Cervatnes", "V. cervantes")
  df_ladybug$collector <- str_replace(df_ladybug$collector, "Veronica Cervantes", "V. cervantes")
  df_ladybug$collector <- str_replace(df_ladybug$collector, "V. Cervantes", "V. cervantes")
  df_ladybug$collector <- str_replace(df_ladybug$collector, "V. cervantes", "V. cervantes")
  df_ladybug$collector <- str_replace(df_ladybug$collector, "V.Cervantes", "V. cervantes")
  df_ladybug$collector <- str_replace(df_ladybug$collector, "v cervantes", "V. cervantes")

# Cleaned the data to fix string inconsistencies in the data for the Species column 
unique(df_ladybug$Species)
  df_ladybug$Species <- str_replace(df_ladybug$Species, "Propylea quatuordecimpuncata", "Propylea quatuordecimpunctata")
  df_ladybug$Species <- str_replace(df_ladybug$Species, "Harmonia axyrisis", "Harmonia axyridis")
  df_ladybug$Species <- str_replace(df_ladybug$Species, "harmonia axyridis", "Harmonia axyridis")
  df_ladybug$Species <- str_replace(df_ladybug$Species, "harmonia axyrids", "Harmonia axyridis")
  df_ladybug$Species <- str_replace(df_ladybug$Species, "Harminia axyridis", "Harmonia axyridis")
  df_ladybug$Species <- str_replace(df_ladybug$Species, "Colemegilla maculata", "Coleomegilla maculata")
  df_ladybug$Species <- str_replace(df_ladybug$Species, "coleomegilla maculata", "Coleomegilla maculata")
  df_ladybug$Species <- str_replace(df_ladybug$Species, "Cycloneda munda", "Cycloneda Munda")
  df_ladybug$Species <- str_replace(df_ladybug$Species, "cycloneda munda", "Cycloneda Munda")
  df_ladybug$Species <- str_replace(df_ladybug$Species, "coccinella septempunctata", "Coccinella Septempunctata")
  df_ladybug$Species <- str_replace(df_ladybug$Species, "Coccinella septempunctata", "Coccinella Septempunctata")
  df_ladybug$Species <- str_replace(df_ladybug$Species, "hippodamia parenthesis", "Hippodamia parenthesis")
  df_ladybug$Species <- str_replace(df_ladybug$Species, "Hippodamia covergence", "Hippodamia convergens")
  df_ladybug$Species <- str_replace(df_ladybug$Species, "hippodamia convergens", "Hippodamia convergens")
  df_ladybug$Species <- str_replace(df_ladybug$Species, "Coccinella septempunctata", "Coccinella Septempunctata")
  df_ladybug$Species <- str_replace(df_ladybug$Species, "Coccinella semtempuncata", "Coccinella Septempunctata")
  
# VISULAIZATION #1: Count By Collector
# Created data frame to calculate the count of lady bugs by collectors
df_collector_count <- df_ladybug %>%
  select(collector) %>%
  count(collector) %>%
  drop_na()

# Created a bar graph to show how many lady bugs each person collected
ggplot(data = df_collector_count, aes(x = n, y= collector, fill= collector)) +
  geom_bar(stat="Identity")+
  xlab("Count") +
  ggtitle("Count by Collector")

# Purpose of this Visualization: 
  # The purpose of this visualization is to show the distribution of lady bug 
  # collection by each person. Here you can see that all four collectors collected
  # around the same amount but O. Ruffatto collected the most by about 7 lady bugs. 
  
# VIZUALIZATION #2: Count by Species
# Created a new data frame that selects the column species from the main data frame
# df_ladybug  and creates a unique count for each species.
df_species_count <- df_ladybug %>%
  select(Species) %>%
  count(Species) 

# Created a colored bar that shows the species and their counts. Used  the  function 
# geom_bar() and rotated thex axis forbetter readability.  
ggplot(data = df_species_count, aes(x = Species, y= n, fill=Species)) +
  geom_bar(stat="identity")+
  xlab("Species")+
  ylab("Count")+
  ggtitle("Count by Species")+
  theme(axis.text.x = element_text(angle = 90))+
  theme(legend.position="none")

# Purpose of Visualization 
  # The purpose of this visualization is to show the overall distribution
  # of what species were collected at the highest frequency. We can see that 
  # the Harmonia axyridis was most collected at 179 and the Colemegilla Maculata 
  # was not far behind at  a count of 128. 

# VISULAIZATION 3: Collector and Species 
# Created data frame that selects the columns Collector and Species. Then we grouped
# by collector and dropped the NA values. 
df_collector_species <- df_ladybug %>%
  dplyr:: select(collector, Species) %>%
  group_by(collector)%>%
  drop_na()

# Stacked Bar graph that shows which person collected the different species.
ggplot(data = df_collector_species, aes(x = collector, y= Species, fill= Species)) +
  geom_bar(position = "stack", stat="identity") +
  xlab("Collector") +
  ggtitle("Relationship between Collector and Species") +
  theme(axis.text.x = element_text(angle = 90))

#VISUALIZATION 4: Date Frequency Bar Graph  
Date = df_ladybug$date

#Graph Shows how many lady bugs were caught each day.
ggplot(df_ladybug, aes(Date)) +
  geom_bar(color = "purple", fill = "white")
 
date_table = table(Date)
View(date_table)

#Min, Median, Max amount caught within a day
least = names(date_table[date_table==min(date_table)]) #day with least caught
most = names(date_table[date_table==max(date_table)]) #day with most caught
middle = names(date_table[date_table==median(date_table)]) #day with middle amount caught

least
View(data.frame(least, middle, most))


#First day, middle day, and last day that a bug was caught
first_date = min(Date)
last_date = max(Date)
median_date = median(Date)

View(data.frame(first_date, median_date, last_date))


#Chi Squared Test, Alternative to a t-test due to categoorical variables
chisq.test(Species, Collector,  correct=FALSE, simulate.p.value=TRUE)
chisq.test(Species, Corrdinates,  correct=FALSE, simulate.p.value=TRUE)


chisq.test(Collector, Date,   correct=FALSE, simulate.p.value=TRUE)
chisq.test(Species, Date,   correct=FALSE, simulate.p.value=TRUE)
chisq.test(Species, Corrdinates,   correct=FALSE, simulate.p.value=TRUE)
chisq.test(Corrdinates, Species,   correct=FALSE, simulate.p.value=TRUE)

