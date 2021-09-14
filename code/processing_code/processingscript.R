###############################
# processing script
#
#this script loads the raw data, processes and cleans it 
#and saves it as Rds file in the processed_data folder

#load needed packages. make sure they are installed.
library(readxl) #for loading Excel files
library(dplyr) #for data processing
library(here) #to set paths

#here is the link to the source of the dataset:
#https://data.cdc.gov/NCHS/Provisional-COVID-19-Deaths-by-Sex-and-Age/9bhg-hcku

#path to data
#note the use of the here() package and not absolute paths
data_location <- here::here("data","raw_data",
                            "Provisional_COVID-19_Deaths_by_sex_and_Age.xlsx")

#load data
#after a couple attempts of loading the data and noticing that one or more
#variable was imported as the wrong data type, so I manually, explicitly 
#entered the data type for each variable (column)
rawdata <- readxl::read_xlsx(data_location, sheet = 1, col_names = TRUE, 
                             col_types = c('date', 'date', 'date', 'text', 
                                           'numeric', 'numeric', 'text', 'text',
                                           'text','numeric', 'numeric', 
                                           'numeric', 'numeric', 
                                           'numeric', 'numeric', 'text'))

#take a look at the data
dplyr::glimpse(rawdata)

#renaming the columns to get rid of spaces and capitalization
colnames(rawdata) [1] <- 'date.as.of'
colnames(rawdata) [2] <- 'start.date'
colnames(rawdata) [3] <- 'end.date'
colnames(rawdata) [4] <- 'group'
colnames(rawdata) [5] <- 'year'
colnames(rawdata) [6] <- 'month'
colnames(rawdata) [7] <- 'state'
colnames(rawdata) [8] <- 'sex'
colnames(rawdata) [9] <- 'age.group'
colnames(rawdata) [10] <- 'covid19.deaths'
colnames(rawdata) [11] <- 'total.dealths'
colnames(rawdata) [12] <- 'pneumonia.deaths'
colnames(rawdata) [13] <- 'pneumonia.and.covid19.deaths'
colnames(rawdata) [14] <- 'influenza.deaths'
colnames(rawdata) [15] <- 'pneu.influ.covid.deaths'
colnames(rawdata) [16] <- 'footnote'


#Viewing the dataframe in it's own tab to do a final check
View(rawdata)

#Since I am only interested in some of the included variables in the dataset, 
#I will narrow it down to just those variables
#The outcome I am interested in is COVID-19 deaths, so I have included that 
#I am particularly interested in sex and age group as the predictors so those 
#are included as well
#I have included some time variables (whether the measurement is overall, by 
#month, or by year, and when those months and years are) so I have the option 
#of seeing whether the results vary by time
#Finally, for simplicity's sake, I chose to use only the data for the US overall
processeddata <- rawdata %>%
  select(start.date, end.date, group, year, month, state, sex, age.group, 
         covid19.deaths) %>%
  filter(state == 'United States')
#Checking the new object to make sure it looks right
dplyr::glimpse(processeddata)



# save data as RDS
# I suggest you save your processed and cleaned data as RDS or RDA/Rdata files. 
# This preserves coding like factors, characters, numeric, etc. 
# If you save as CSV, that information would get lost.
# See here for some suggestions on how to store your processed data:
# http://www.sthda.com/english/wiki/saving-data-into-r-data-format-rds-and-rdata

# location to save file
save_data_location <- here::here("data","processed_data","processeddata.rds")

saveRDS(processeddata, file = save_data_location)






