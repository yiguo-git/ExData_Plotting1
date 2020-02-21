## set file path for the raw data
file_path <- ".\\exdata_data_household_power_consumption\\household_power_consumption.txt"
## read the data in as data frame, column classes are character for the first 2 columns and numeric for the rest
df <- read.table(file_path, sep = ';', header = T, colClasses = c("character","character",rep("numeric",7)), na.strings = "?")

## construct date time column as DT
df$DT <- paste(df$Date, df$Time)
df$DT <- strptime(df$DT, "%d/%m/%Y %H:%M:%S")

## subset data frame based on the DT, use only DT between 2007-02-01 and 2007-02-02
df_sub1 <- subset(df, ((as.Date(df$DT) >= as.Date("2007-02-01")) & (as.Date(df$DT) <= as.Date("2007-02-02"))))

## set png as the graphic device
png(file = "plot3.png", width = 480, height = 480)

## plot the lines
plot(df_sub1$DT, df_sub1$Global_active_power, type = "n", ylim = c(0,38),
     main = "", ylab = "Energy sub metering", xlab = "")
with(df_sub1, lines(DT, Sub_metering_1, col = "black"))
with(df_sub1, lines(DT, Sub_metering_2, col = "red"))
with(df_sub1, lines(DT, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#main = "", lty = 10, pch = 20, ylab = "Global Active Power (kilowatts)", xlab = ""

## save as png
##dev.copy(png, file = "plot3.png")
dev.off()