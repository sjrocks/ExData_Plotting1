library(datasets)

# Clear session
rm(list=ls())

# Download and unzip
if(!file.exists("household_power_consumption.zip")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, destfile = "household_power_consumption.zip", mode="wb")
  unzip("household_power_consumption.zip")
}

#Read the file
power_consumption_ds <- read.table("household_power_consumption.txt", sep = ";", stringsAsFactors = F, header = T, na.strings = c("?"))
power_consumption_ds$DateTime <- as.POSIXct(strptime(paste(power_consumption_ds$Date, power_consumption_ds$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S"))
power_consumption_ds$Date <- as.Date(power_consumption_ds$Date, format = "%d/%m/%Y")

#Subset it for the required date range
workload_ds <-  subset(power_consumption_ds, Date <= as.Date("2007-02-02"))
workload_ds <-  subset(workload_ds, Date >= as.Date("2007-02-01"))

#Create a file & Set the Device
png(filename = "plot3.png", width = 480, height = 480)
#Plot it
plot(workload_ds$DateTime, 
     workload_ds$Sub_metering_1, 
     type="l",
     xlab="", 
     ylab="Energy sub metering", 
     main="")
lines(workload_ds$DateTime,workload_ds$Sub_metering_2, type="l",col="red")
lines(workload_ds$DateTime,workload_ds$Sub_metering_3, type="l",col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty = 1, lwd=1)
dev.off()
