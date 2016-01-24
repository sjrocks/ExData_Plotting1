library(datasets)

# Clear session
rm(list=ls())

# Download and unzip
if(!file.exists("household_power_consumption.zip")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, destfile = "household_power_consumption.zip", mode="wb")
  unzip("household_power_consumption.zip")
}

power_consumption_ds <- read.table("household_power_consumption.txt", sep = ";", stringsAsFactors = F, header = T, na.strings = c("?"))
power_consumption_ds$Date <- as.Date(power_consumption_ds$Date, format = "%d/%m/%Y")
power_consumption_ds$Time <- strptime(power_consumption_ds$Time, format = "%H:%M:%S")

workload_ds <-  subset(power_consumption_ds, Date <= as.Date("2007-02-02"))
workload_ds <-  subset(workload_ds, Date >= as.Date("2007-02-01"))


png(filename = "plot1.png", width = 480, height = 480)
hist(workload_ds$Global_active_power,  
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power",
     col="red"
)
dev.off()
