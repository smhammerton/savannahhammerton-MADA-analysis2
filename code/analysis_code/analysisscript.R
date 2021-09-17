###############################
# analysis script
#
#this script loads the processed, cleaned data, does a simple analysis
#and saves the results to the results folder

#load needed packages. make sure they are installed.
library(ggplot2) #for plotting
library(here) #for data loading/saving
library(tidyverse) #for help with managing data
library(scales) #for cleaner illustration of data

#path to data
#note the use of the here() package and not absolute paths
data_location <- here::here("data","processed_data","processeddata.rds")

#load data. 
mydata <- readRDS(data_location)

######################################
#Data exploration/description
######################################

#Our outcome of interest is COVID-19 deaths
#Variables that will serve as predictors of outcome include age group and sex

#Plot 1, Plotting COVID-19 deaths by age group 

plot_1 <- mydata %>%
  ggplot(aes(x=age.group, y=covid19.deaths)) +
  geom_bar(stat = "identity") +
  ggtitle("COVID-19 Deaths by Age Group in the United States")+
  geom_smooth(method='lm')+
  scale_x_discrete(guide = guide_axis(n.dodge = 1, check.overlap = TRUE))+
  scale_y_continuous(labels = comma)+
  theme(axis.text.x = element_text(angle = 90, size=8))

  
#Examine plot
plot(plot_1)


#Note that due to the sequential nature of ordering, some variables
#(such as 5-14) are mistakenly in the middle of the chart.


#Save the plot
figure_file1 = here::here("results","resultfigure1.png")
ggsave(filename = figure_file1, plot = plot_1)

#Plot 2, Plotting COVID-19 deaths by sex
  
plot_2 <-mydata %>%
  ggplot(aes(x=sex, y=covid19.deaths))+
  geom_bar(stat = "identity") +
  ggtitle("COVID-19 Deaths by Sex in the United States")+
  geom_smooth(method='lm')+
  scale_y_continuous(labels = comma)


#Examine the Plot
plot(plot_2)

#Save the plot
figure_file2 = here::here("results","resultfigure2.png")
ggsave(filename = figure_file2, plot = plot_2)

  
  


  