library(lubridate)
library(dplyr)



#reading file
Rdata <- read.table("household_power_consumption.txt", head = T, sep = ";")

Rdata$DateTime <- strptime(paste(Rdata$Date, Rdata$Time), format = "%d/%m/%Y %H:%M:%S")
Cdata <- Rdata %>%
        mutate(Date = dmy(Date),
               Time = strptime(Time, format= "%H:%M:%S"))

Cdata <- with(Cdata, Cdata[(Date >= "2007-02-01" & Date <= "2007-02-02"), ])
Cdata[, c(3:9)] <- lapply(Cdata[, c(3:9)], as.numeric)

#Plot1:
png("Plot1.png", width = 480, height = 480)
hist(Cdata$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()

#Plot2:
png("Plot2.png", width = 480, height = 480)
with(Cdata, plot(DateTime, Global_active_power, "l", ylab = "Global Active Power (kilowatts)", xlab = ""))
dev.off()

#Plot3:
png("Plot3.png", width = 480, height = 480)
with(Cdata, plot(DateTime, Sub_metering_1, "l", ylab = "Energy Sub metering", xlab = ""))
with(Cdata, lines(DateTime, Sub_metering_2, col = "red"))
with(Cdata, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1)
dev.off()

#Plot4:
png("Plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
with(Cdata, plot(DateTime, Global_active_power, "l", ylab = "Global Active Power (kilowatts)", xlab = ""))
with(Cdata, plot(DateTime, Voltage, "l"))
with(Cdata, plot(DateTime, Sub_metering_1, "l", ylab = "Energy Sub metering", xlab = ""))
with(Cdata, lines(DateTime, Sub_metering_2, col = "red"))
with(Cdata, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1)
with(Cdata, plot(DateTime, Global_reactive_power, "l"))
dev.off()