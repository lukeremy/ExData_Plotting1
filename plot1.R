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

## create histogram of frequency of Global Active Power, add labels, copy to png file working directory
hist(data$Global_active_power, col="red", family="Times",pointsize=8,
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
par(oma="1,1,1,1")
dev.copy(png, file="./plot1.png",width=480,height=480)
dev.off()









