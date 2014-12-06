## NOTE: replace my working directory with your desired path
setwd("~/R/Coursera/ExploreData/project1/")

## load needed packages for code to work, install if needed
install.packages("sqldf")
library(sqldf)

## download zipped data from web, unzip folder
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "./compressed_data.zip")
unzip("./compressed_data.zip")

## find data file name, create R object with that name, then use sqldf package to selectively read in
## only the data for the dates we are interested in
list.files()
df <- "./household_power_consumption.txt"
data <- read.csv.sql(df, sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", sep = ";")

## replace "?" in dataset with NA, remove NA rows
data[data == "?"] <- NA
data <- na.omit(data)

## convert Date/Time formats, create new variable with Date & Time info
data$Date <- as.Date(data$Date, "%d/%m/%Y")
datetime <- paste(data$Date, data$Time, sep = " ")
data$datetime <- as.POSIXct(datetime)

png("./plot3.png",width=480,height=480)

plot(data$datetime, data$Sub_metering_1,
     type="l",col="black",xlab = "", ylab = "Energy sub metering")
lines(data$datetime,data$Sub_metering_2, col="red")
lines(data$datetime,data$Sub_metering_3, col="blue")
legend("topright", col=c("black","red","blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, lwd = c(2.5,2.5))

dev.off()




