# This R script generates plots for the dataset.

########## Read and prep the data set ############

# Read in the entire data file
myClasses <- c('character', 'character', rep('numeric',7))
rawData <- read.table("../household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", skip=0, colClasses=myClasses, stringsAsFactor=FALSE)

# Subset out the rows that we need
desiredRows<-subset(rawData, rawData$Date=="1/2/2007" | rawData$Date=="2/2/2007")

# Combine the the date and time columns into a single string, in a new vector
desiredRows$dateTime <-paste(desiredRows$Date, desiredRows$Time)

# Convert the date/time string to a date/time object
desiredRows$dateTime<-strptime(desiredRows$dateTime, "%d/%m/%Y %H:%M:%S")

# Open the graphics device
png(file="plot4.png")

# Arrange the charts in 2x2
par(mfrow=c(2,2))

# Draw chart 1
plot(desiredRows$dateTime, desiredRows$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")

# Draw chart 2
plot(desiredRows$dateTime, desiredRows$Voltage, type="l", ylab="Voltage", xlab="datetime")

# Draw chart 3
plot(desiredRows$dateTime, desiredRows$Sub_metering_1, col="black", type="l", ylab="Energy sub metering", xlab="")
lines(desiredRows$dateTime, desiredRows$Sub_metering_2, col="red")
lines(desiredRows$dateTime, desiredRows$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black","red","blue"))

# Draw chart 4
plot(desiredRows$dateTime, desiredRows$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")

# Generate the .png file
#dev.copy(png, file="plot4.png")
dev.off()
