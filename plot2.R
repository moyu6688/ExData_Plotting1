rm(list=ls())

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

#Creat a column for continuous time of the two days
data$DateTime<-paste(data$Date,data$Time)
data$DateTime<-strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")

#Generate the plot 
png(filename = "plot2.png",width = 480, height = 480, units = "px")   #open PNG plotting device
with(data,
plot(DateTime,Global_active_power,
     type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
)
dev.off() #close plotting device

