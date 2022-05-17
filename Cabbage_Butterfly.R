# DATA 332 Final Project 
# Authors: Kate Martino, Nicole Nguyen, Tran Bui, Claire Weeks
# Cabbage Butterfly Data

# Load the required packages 
library(tidyverse)
library(dplyr)
library(readxl)
library(lubridate)
library(readr)

# Set the working directory 
rm(list=ls())
setwd("/Users/katemartino/Desktop/Data 332 Final Project")

# Load Data from excel 
df_cleaned_cabbage <- read_excel("data/CleanedDataLWA.xlsx", sheet = 1, .name_repair="universal")
df_complete_pieris_data <- read_excel("data/CompletePierisData_2022-03-09.xlsx", sheet = 1) %>%
  # Cleaned the data in a dynamic manner
  # Changed the column names to get rid of the special characters 
  dplyr::rename("continent" = "dwc:continent","country" = "dwc:country", "stateprovince" = "dwc:stateProvince", 
                "Latitude" = "DecimalLatitudeUpdated", "Longitude" = "DecimalLongitudeUpdated") %>%
  # Used the function mutate to get rid of string inconsistencies 
  dplyr::mutate(country = str_replace(country, pattern = "USA", replacement = "United States"))

# Created initial data frame with the specific column we wanted to use from the unclean data 
df_initial <- df_complete_pieris_data %>%
  dplyr::select("coreid", "YearUpdated", "continent", "country", "Latitude", "Longitude") 

# Used a left join to add the above selected columns to the clean data set to have all the column needed for analysis
df_final <- df_cleaned_cabbage %>%
  left_join(df_initial, by=c("coreid")) %>%
  # drops NA's in the data set to make it more usable for analysis portion of the project 
  drop_na()

# VISUAL 1: Double Line graph showing wing width change over time
# Creating a data frame with the specifications needed for the visual (data prep)
# Chose specific columns, grouped by countries, and calculated the average width of each wing for each country 
df_wing_width <- df_final %>%
  select(YearUpdated, LW.width, RW.width) %>%
  group_by(YearUpdated) %>%
  summarise(lw_width_average = mean(LW.width),
            rw_width_average = mean(RW.width))
# Made the double line graph using the package ggplot
ggplot(df_wing_width, aes(x=YearUpdated)) + 
  geom_line(aes(y = lw_width_average), color = "steelblue") + 
  geom_point(aes(y = lw_width_average), color = "steelblue") +
  geom_line(aes(y = rw_width_average), color= "darkred") +
  geom_point(aes(y = rw_width_average), color = "darkred") +
  xlab("Year")  +
  ylab("Wing Width") +
  ggtitle("Wing Width Over Time") 

# Purpose of this visual: 
  # We chose a line graph so we can see the change over time when it comes to the average 
  # wing width. The multiple lines allows us to compare both the right wing and the left 
  # wing on the same plane. It is interesting to see how this specific aspect of the Cabbage 
  # butterfly's anatomy has changed from 1865 to 2015. This information could be valuable when
  # it comes to forecasting what the butterfly's wing width may be in the future. It also makes us wonder/ 
  # want to dive deeper in regards to what is causing the peaks and valleys in the data. 

# VISUAL 2: Line graph showing Average Length for the Right Wing by Country over time
# Creating a data frame with the specifications needed for the visual (data prep)
df_wing_length_country <- df_final %>%
  select(country, LW.length, RW.length, YearUpdated) %>%
  group_by(country, YearUpdated) %>%
  summarise(lw_length_average = mean(LW.length),
            rw_length_average = mean(RW.length))

# Right Wing length by Country over time
ggplot(data = df_wing_length_country, aes(YearUpdated, rw_length_average)) +
  geom_line(color = "darkred", size = 1) +
  geom_point(color="darkred") + 
  labs(title = "Average Right Wing Length by Country over time",
       y = "Right Wing Average Length", x = "") + 
  facet_wrap(~ country)

# Left Wing length by Country over time
ggplot(data = df_wing_length_country, aes(YearUpdated, lw_length_average)) +
  geom_line(color = "steelblue", size = 1) +
  geom_point(color="steelblue") + 
  labs(title = "Average Right Wing Length by Country over time",
       y = "Right Wing Average Length", x = "") + 
  facet_wrap(~ country)

# Purpose of this visual: 
  # This visual is helpful in examining how the wing length of the cabbage butterfly
  # differs between various countries. It can be seen in this visual that over time all
  # four countries collected in the data have varying average length for both
  # the right wing and the left wing. It also shows us that some countries only 
  # have data collected from certain years. Byusing the facet wrap function 
  # we can easily compare the countries to one another in a single visual. 

# VISUAL 3: Bar graph that shows wing apex by sex
# Creating a data frame with the specifications needed for the visual (data prep)
# Calculated the average of each wings apex
df_apex_sex <- df_final %>%
  select(sex, LW.apex.A, RW.apex.A) %>%
  group_by(sex) %>%
  summarise(lw_apex_average = mean(LW.apex.A),
            rw_apex_average = mean(RW.apex.A))

# Created chart using package ggplot for the Left Wing
ggplot(data = df_apex_sex, aes(x =sex, y=lw_apex_average, fill=sex)) +
  geom_bar(stat="identity")+
  xlab("Sex") +
  ylab("Left Wing Apex A") + 
  ggtitle("Left Wing Apex by Sex")

# Created chart using package ggplot for the Right Wing
ggplot(data = df_apex_sex, aes(x =sex, y=rw_apex_average, fill=sex)) +
  geom_bar(stat="identity")+
  xlab("Sex") +
  ylab("Right Wing Apex A") + 
  ggtitle("Right Wing Apex by Sex")

# Purpose of this visual:
  # The purpose of this visual is to analyze the location of the apex differs 
  # among male and female cabbage butterflies. It is seen here that the male 
  # apex is much larger than that of a female. When you look at both wings you 
  # will find similar distribution. This makes sense because butterfly wings 
  # are symmetrical. 
  

# T-TEST 
# Here we created vectors to separate the left and right data so we can preform 
# a paired t-test. A t-test is  used to determine whether the mean of a dependent 
# variable is the same in  two related groups. In this case we looked at the right 
# and left wing if the cabbage butterfly where we found high correlation between 
# the two.
left_data = c(df_final$LW.length, df_final$LW.width, df_final$LW.apex.A)
right_data = c(df_final$RW.length, df_final$RW.width, df_final$RW.apex.A)

# Here us where we preformed the paired t-test
# EXPLAIN WHAT THIS SHOWS US 
t.test(left_data, right_data, paired = TRUE)

# VISUAL FOR MEAN, MEDIAN, MAX, MIN
# Data prep for the visual 
# We created two separate data frames that encompassed the left and right wing data separately 
right_table = data.frame(df_final$`RW.length`, df_final$`RW.width`, df_final$`RW.apex.A`)
left_table = data.frame(df_final$`LW.length`, df_final$`LW.width`, df_final$`LW.apex.A`)


Llength_median = df_final$LW.length
Lwidth_median = df_final$LW.width
Lapex_median = df_final$LW.apex.A

#left_median_total = c(left_median, left_median1, left_median2)

#right_median_total = c(right_median, right_median1, right_median2)

Rlength_median = df_final$RW.length
Rwidth_median = df_final$RW.width
Rapex_median = df_final$RW.apex.A

median_df = data.frame(Llength_median, Lwidth_median, Lapex_median, Rlength_median, Rwidth_median, Rapex_median)
median_df

plot.ts(median_df)

plot(left_data, right_data)
lines(left_data, right_data, type = "o", col = 4)

plot(left_data, left_median)

t.test(left_data, right_data, paired = TRUE)

model1 = lm(left_data ~ right_data)
#summary(model1)
#plot(model1)

max(left_data)
min(left_data)

max(right_data)
min(right_data)

#The left plot is for the left data. The top line is the max value (28.75).
#The bottom line is the min value (0.18).

#The right plot is for the right data. The top line is the max value (28.57).
#The bottom line is the min value (0).
boxplot(left_data, right_data)





  

