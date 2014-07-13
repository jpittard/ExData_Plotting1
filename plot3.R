powerData <- getData()
png(file="plot3.png")
with(powerData, plot(datetime, sub_metering_1, main="Global Active Power",
	ylab = "Energy sub metering", xlab="", type="l"))
with(powerData, lines(datetime, sub_metering_2, col="red"))
with(powerData, lines(datetime, sub_metering_3, col="blue"))
legend("topright", lty = 1, col = c("black", "blue", "red"), 
        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

getData <- function() {
	fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	dateDownloaded <- date()
	dateDownloaded
	download.file(fileUrl, destfile = "exdata_data_household_power_consumption.zip", method = "curl")
	unzip("exdata_data_household_power_consumption.zip")
	feb1row <- 66638
	feb3row <- 69518
	header <- c("date","time","global_active_power","global_reactive_power",
		    "voltage","global_intensity","sub_metering_1",
		    "sub_metering_2","sub_metering_3")
	read.delim("household_power_consumption.txt", sep = ";", header = TRUE, 
		   na.strings = "?", skip = feb1row-2, nrows = feb3row-feb1row+1,
		   col.names = header )
	powerData$dt <- as.Date(powerData$date, "%d/%m/%Y")
	powerData$datetime <- strptime(paste(powerData$date, powerData$time), 
				       format="%d/%m/%Y %H:%M:%S")
	
}
