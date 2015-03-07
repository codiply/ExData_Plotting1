# I load the data. 
# The dates we are interested in are in the first 70000 lines.
data <- read.table("household_power_consumption.txt", header=TRUE, 
                   sep=";", na.strings="?", nrows=70000)

# I parse the date and time.
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# I keep the rows for the selected dates.
startDate <- as.Date("01/02/2007", format="%d/%m/%Y")
endDate <- as.Date("02/02/2007", format="%d/%m/%Y")
toKeep = startDate <= data$Date & data$Date <= endDate
data <- data[toKeep,]

# The default size for this device is 480x480 pixels.
png(filename="plot4.png", bg="transparent")
# I create a 2x2 matrix of plots and fill in by column
par(mfcol=c(2,2))
# 1st subplot
plot(x=data$DateTime, y=data$Global_active_power, type="l",
     xlab="", ylab="Global Active Power")
# 2nd subplot
yrange<- range(c(data$Sub_metering_1,data$Sub_metering_2,data$Sub_metering_3))
plot(x=data$DateTime, y=data$Sub_metering_1, type="l", col="black", 
     xlab="", ylim=yrange, ylab="Energy sub metering")
lines(x=data$DateTime, y=data$Sub_metering_2, type="l", col="red")
lines(x=data$DateTime, y=data$Sub_metering_3, type="l", col="blue")
legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1,1),lwd=c(2,2,2), col=c('black', 'red', 'blue'), bty = "n")
# 3rd subplot
plot(x=data$DateTime, y=data$Voltage, type="l", 
     xlab="datetime", ylab="Voltage")
# 4th subplot
plot(x=data$DateTime, y=data$Global_reactive_power, type="l", 
     xlab="datetime", ylab="Global_reactive_power")
# I close the device
dev.off()
