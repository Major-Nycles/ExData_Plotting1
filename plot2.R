if(!file.exists("data")) {dir.create("data")}

file_URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(file_URL, destfile = "./data/Electric_power_consumpion.zip")

unzip("./data/Electric_power_consumpion.zip", exdir = "./data")

data <- read.table("./data/household_power_consumption.txt", 
                   header = TRUE,
                   sep = ";")

correct_dates <- data[data$Date == "1/2/2007"| data$Date == "2/2/2007",]

correct_dates[,3] <- as.numeric(correct_dates[,3])

date_time <- paste(correct_dates$Date, correct_dates$Time)

correct_dates$V10 <- strptime(date_time, "%d/%m/%Y %H:%M:%S")

colnames(correct_dates)[10] <- "Date/Time"

png(filename = "plot2.png", width = 480, height = 480)
plot(correct_dates$`Date/Time`, correct_dates$Global_active_power,
     type = "l",
     ylab = "Global Active Power [kilowatts]",
     xlab = "")
dev.off()