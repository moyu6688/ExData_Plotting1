rm(list=ls())

#set working directory 
setwd("C:/Users/Y/Desktop/Coursera/Data Science/Exploratory Data Analysis/Week1/Project")

#set working directory 
setwd("C:/Users/Y/Desktop/Coursera/Data Science/Exploratory Data Analysis/Week1/Project")

#download data if not download before
if(!file.exists("data.zip")){
  url<-"http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
  download.file(url,destfile = "data.zip")
}

#unzip file if not unzip before
if(!file.exists("household_power_consumption.txt")){
  unzip("data.zip") 
}

#read in data only from the 1/2/2007 and 2/2/2007
file <- file("household_power_consumption.txt")

library(sqldf)
data<- sqldf("select * from file where Date = '1/2/2007' or Date = '2/2/2007'",
             file.format = list(header = TRUE, sep = ";"))
close(file)

#Generate the plot 
png(filename = "plot1.png",width = 480, height = 480, units = "px")   #open PNG plotting device
with(data2,
hist(Global_active_power,
     col="red",
     xlab="Global Active Power (kilowatts)", ylab="Frequency",
     main = "Global Active Power")
)
dev.off() #close plotting device

