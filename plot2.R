# Libraries

# Download Zip File

if(!file.exists("./data")){dir.create("./data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./data/household_power_consumption.zip")

# Unzip Files in Data Directory

unzip("./data/household_power_consumption.zip", exdir = "./data")

# load power consumption data

fileURL <- paste(getwd(),"/data",sep="")
filename <- "household_power_consumption.txt"
filename.path <- paste(fileURL,"/",filename, sep = "")
hpcData <- read.table(filename.path, header = TRUE, sep = ";", na.strings="?")

# Clean Data

# Convert Date and Time to single Date type - format is day month year hour min sec

hpcData$DateTime <- as.POSIXct(paste(hpcData$Date, hpcData$Time), format="%d/%m/%Y %H:%M:%S")


# Convert remaining fields to numeric 

hpcData$Global_active_power <- as.numeric(hpcData$Global_active_power)
hpcData$Global_reactive_power <- as.numeric(hpcData$Global_reactive_power)
hpcData$Global_intensity <- as.numeric(hpcData$Global_intensity)
hpcData$Voltage <- as.numeric(hpcData$Voltage)
hpcData$Sub_metering_1 <- as.numeric(hpcData$Sub_metering_1)
hpcData$Sub_metering_2 <- as.numeric(hpcData$Sub_metering_2)
hpcData$Sub_metering_3 <- as.numeric(hpcData$Sub_metering_3)

# subset dataset for 1/2/2007 and 2/2/2007 format is day/month/year

hpcDataSmall <- hpcData[hpcData$Date %in% c("1/2/2007", "2/2/2007"),]

# Create Plot 2

if(!file.exists("./plots")){dir.create("./plots")}
png("plots/plot2.png", width = 480, height = 480, units = "px")
plot(hpcDataSmall$DateTime,hpcDataSmall$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)" )
dev.off()
