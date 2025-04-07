#Read the data
df <- read.csv2("household_power_consumption.txt", stringsAsFactors = FALSE)

#Formatting data
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
df$Global_active_power <- as.numeric(df$Global_active_power)
df$Global_reactive_power <- as.numeric(df$Global_reactive_power)
df$Voltage <- as.numeric(df$Voltage)
df$Global_intensity <- as.numeric(df$Global_intensity)
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)

#Subsetting data
data <- subset(df, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

#Creating datetime variable
datetime <- strptime(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")

#Plotting
##Plot1
png("plot1.png", width = 480, height = 480)
hist(data$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()

##Plot2
png("plot2.png", width = 480, height = 480)
plot(datetime, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)", xaxt = "n")
ticks <- seq(from = as.POSIXct("2007-02-01"), 
             to = as.POSIXct("2007-02-03"), by = "days")
labels <- format(ticks, "%a")  
axis(1, at = ticks, labels = labels)
dev.off()

##Plot3
png("plot3.png", width = 480, height = 480)
plot(datetime, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering",
     xaxt = "n")
lines(datetime, data$Sub_metering_2, col = "red")
lines(datetime, data$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
ticks <- seq(from = as.POSIXct("2007-02-01"), 
             to = as.POSIXct("2007-02-03"), by = "days")
labels <- format(ticks, "%a")  
axis(1, at = ticks, labels = labels)
dev.off()

##Plot4
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
### Top-left
plot(datetime, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power",
     xaxt = "n")
ticks <- seq(from = as.POSIXct("2007-02-01"), 
             to = as.POSIXct("2007-02-03"), by = "days")
labels <- format(ticks, "%a")  
axis(1, at = ticks, labels = labels)

### Top-right
plot(datetime, data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage", xaxt = "n")
ticks <- seq(from = as.POSIXct("2007-02-01"), 
             to = as.POSIXct("2007-02-03"), by = "days")
labels <- format(ticks, "%a")  
axis(1, at = ticks, labels = labels)

### Bottom left
plot(datetime, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", xaxt = "n")
lines(datetime, data$Sub_metering_2, col = "red")
lines(datetime, data$Sub_metering_1, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n", cex = 0.8)
ticks <- seq(from = as.POSIXct("2007-02-01"), 
             to = as.POSIXct("2007-02-03"), by = "days")
labels <- format(ticks, "%a")  
axis(1, at = ticks, labels = labels)

### Bottom right
plot(datetime, data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power", xaxt = "n")
ticks <- seq(from = as.POSIXct("2007-02-01"), 
             to = as.POSIXct("2007-02-03"), by = "days")
labels <- format(ticks, "%a")  
axis(1, at = ticks, labels = labels)
dev.off()
