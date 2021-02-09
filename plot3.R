if(!file.exists("data")) {dir.create("data")}

file_URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(file_URL, destfile = "./data/Electric_power_consumpion.zip")

unzip("./data/Electric_power_consumpion.zip", exdir = "./data")

data <- read.table("./data/household_power_consumption.txt", 
                   header = TRUE,
                   sep = ";")

correct_dates <- data[data$Date == "1/2/2007"| data$Date == "2/2/2007",]

correct_dates$Sub_metering_1 <- as.numeric(correct_dates$Sub_metering_1)
correct_dates$Sub_metering_2 <- as.numeric(correct_dates$Sub_metering_2)
correct_dates$Sub_metering_3 <- as.numeric(correct_dates$Sub_metering_3)

date_time <- paste(correct_dates$Date, correct_dates$Time)

correct_dates$V10 <- strptime(date_time, "%d/%m/%Y %H:%M:%S")

colnames(correct_dates)[10] <- "Date/Time"

png(filename = "plot3.png", width = 480, height = 480)

plot(correct_dates$`Date/Time`, correct_dates$Sub_metering_1,
        type = "l", 
        col = "black",
        xlab = "",
        ylab = "Energy sub metering")
lines(correct_dates$`Date/Time`, correct_dates$Sub_metering_2,
      type = "l",
      col = "red")
lines(correct_dates$`Date/Time`, correct_dates$Sub_metering_3,
      type = "l",
      col = "blue")
legend("topright", 
       col = c("black","red","blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1)

dev.off()



        

