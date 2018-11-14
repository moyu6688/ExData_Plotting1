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
png(filename = "plot4.png",width = 480, height = 480, units = "px")   #open PNG plotting device
par(mfrow=c(2,2))

#plot at the upper left
with(data,
     plot(DateTime,Global_active_power,
          type="l",
          ylab="Global Active Power (kilowatts)", xlab="")
)

#plot at the upper right
with(data,
     plot(DateTime,Voltage,
          type="l",
          xlab="datetime")
)

#plot at the lower left
with(data,
plot(DateTime,Sub_metering_1,
     type="l",
     ylab="Energy sub metering", xlab="")
)
lines(data$DateTime,data$Sub_metering_2, col="red")
lines(data$DateTime,data$Sub_metering_3, col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1),col = c("black", "red","blue")) 

#plot at the lower right
with(data,
     plot(DateTime,Global_reactive_power,
          type="l",
          xlab="datetime")
)
dev.off() #close plotting device

