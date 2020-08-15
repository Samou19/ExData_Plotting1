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

# convert
df$Date <- dmy(df$Date)
#aa = paste(df$Date, df$Time)
df$Time <- hms(df$Time)
df$Global_active_power <- as.numeric(df$Global_active_power)

# We are just need the data for 2007-02-01 and 2007-02-02
df1 <- tbl_df(df)
mydf = filter(df1, (Date=="2007-02-01"|Date=="2007-02-02"))

# Plot 1
png(filename = "plot1.png",width = 480, height = 480)
hist(mydf$Global_active_power, xlab = "Global Active Power(Kilowatts)", main = "Global Active Power", col = "red")
dev.off()



