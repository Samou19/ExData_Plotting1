# Package
library(dplyr)
library(lubridate)
# Download data

if (!file.exists("data")){
  dir.create("data")
}

adres <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(adres, destfile = "./data/exdata%2Fdata%2Fhousehold_power_consumption.zip", method = "curl")
#unzip the dataset
unzip("./data/exdata%2Fdata%2Fhousehold_power_consumption.zip", exdir = "./data")
list.files("./data")
# read the data
df <- read.csv2("./data/household_power_consumption.txt")
dim(df) # 2075259       9
str(df)

# We are just need the data for 2007-02-01 and 2007-02-02
mydf = subset(df, (Date=="1/2/2007"|Date=="2/2/2007"))

# Transforming the Date and Time vars from characters into objects of type Date and POSIXlt respectively
mydf$Date <- as.Date(mydf$Date, format="%d/%m/%Y")
mydf$Time <- strptime(mydf$Time, format="%H:%M:%S")


mydf[1:1440,"Time"] <- format(mydf[1:1440,"Time"],"2007-02-01 %H:%M:%S")
mydf[1441:2880,"Time"] <- format(mydf[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


# cPlot2
png(filename = "plot2.png",width = 480, height = 480)
plot(mydf$Time,as.numeric(as.character(mydf$Global_active_power)),type="l",xlab="",ylab="Global Active Power (kilowatts)")

# annotating graph
title(main="Global Active Power Vs Time")
dev.off()
