# This R script generates a plot for the dataset

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

# Draw the chart
plot(desiredRows$dateTime, desiredRows$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")

# Generate the .png file
dev.copy(png, file="plot2.png")
dev.off()
