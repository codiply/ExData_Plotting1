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

# The default size for png device is 480x480 pixels.
png(filename="plot1.png", bg="transparent")
hist(data$Global_active_power, col="red", 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.off()
