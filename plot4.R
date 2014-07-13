par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

powerData <- getData()
png(file="plot4.png")

with(powerData, {
# top left
	plot(datetime, global_active_power, main="Global Active Power",  
	     ylab = "Global Active Power (kilowatts)", xlab="", type="l")

# top right
	plot(datetime, Voltage, type="l")

# bottom left
	plot(datetime, sub_metering_1, main="Global Active Power",
		     ylab = "Energy sub metering", xlab="", type="l")
	lines(datetime, sub_metering_2, col="red")
	lines(datetime, sub_metering_3, col="blue")
	legend("topright", lty = 1, col = c("black", "blue", "red"), 
       		legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# bottom right
	plot(datetime, Global_reactive_power, type="l")

})

dev.off()


getData <- function() {
	fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	dateDownloaded <- date()
	dateDownloaded
	download.file(fileUrl, destfile = "exdata_data_household_power_consumption.zip", method = "curl")
	unzip("exdata_data_household_power_consumption.zip")
	feb1row <- 66638
	feb3row <- 69518
	header <- c("date","time","global_active_power","Global_reactive_power",
		    "Voltage","global_intensity","sub_metering_1",
		    "sub_metering_2","sub_metering_3")
	read.delim("household_power_consumption.txt", sep = ";", header = TRUE, 
		   na.strings = "?", skip = feb1row-2, nrows = feb3row-feb1row+1,
		   col.names = header )
	powerData$dt <- as.Date(powerData$date, "%d/%m/%Y")
	powerData$datetime <- strptime(paste(powerData$date, powerData$time), 
				       format="%d/%m/%Y %H:%M:%S")
	
}
