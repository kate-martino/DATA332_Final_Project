# DATA 332 Final Project
## Authors: Kate Martino, Nicole Nguyen, Tran Bui, Claire Weeks

# Cabbage Butterfly Data
### Introduction 
We recieved this data from the Augustana College Biology department. This data has to do with the Cabbage Butterfly and differnt attributes regarding the butterfly that were collected over the years 1865 and 2015. We took this data and made a variety of visualizations and calculations to better undertsand the data and practice our newly learned skills in R.

### Data Cleaning Process 
We were sure to keep the integrety of the raw and clean data files we were provided by making the data tidy in using R. Some of the things we did clean the data in R. We renamed the the columns that had spaces in them so they were easy to use. We renames the column names that had a special charcter in them. We also fixed a variety of string inconsitencies to ensure we were able to use all of the data in each column. Next, we used a left join to combine the clean data and the raw and selected the spesific columns that we wanted to use to make our final data frame.

## Visualization #1 
Purpose of this Visual: We chose a line graph so we can see the change over time when it comes to the average wing width. The multiple lines allows us to compare both the right wing and the left wing on the same plane. It is interesting to see how this specific aspect of the Cabbage butterfly's anatomy has changed from 1865 to 2015. This information could be valuable when it comes to forecasting what the butterfly's wing width may be in the future. It also makes us wonder/ want to dive deeper in regards to what is causing the peaks and valleys in the data. 

<img src = "Images/Wing_Width_Over_Time" height="500" width="700">

## Visualization #2
Prupose of this Visual: This visual is helpful in examining how the wing length of the cabbage butterfly differs between various countries. It can be seen in this visual that over time all four countries collected in the data have varying average length for both the right wing and the left wing. It also shows us that some countries only have data collected from certain years. Byusing the facet wrap function we can easily compare the countries to one another in a single visual. 

### Right Wing Length
<img src = "Images/LW_width_country" height="500" width="700">

### Left Wing Length
<img src = "Images/RW_width_country.png" height="500" width="700">

## Visualization #3
Purpose of this visual: This visual is helpful in examining how the wing length of the cabbage butterfly differs between various countries. It can be seen in this visual that over time all four countries collected in the data have varying average length for both the right wing and the left wing. It also shows us that some countries only have data collected from certain years. Byusing the facet wrap function we can easily compare the countries to one another in a single visual. 

### Left Wing
<img src = "Images/LW_apex_sex" height="500" width="700">

### Right Wing
<img src = "Images/RW_apex_sex" height="500" width="700">

## T-Test 

## Mean, Median, Max, Min
<img src = "Images/Median_by_decade" height="500" width="700">
<img src = "Images/Corr_Left_Right" height="500" width="700">
<img src = "Images/Boxplot_Right_Left_Data" height="500" width="700">






