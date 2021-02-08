if(!file.exists("data")) {dir.create("data")}

file_URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(file_URL, destfile = "./data/Electric_power_consumpion.zip")

unzip("./data/Electric_power_consumpion.zip", exdir = "./data")

data <- read.table("./data/household_power_consumption.txt", 
                   header = TRUE,
                   sep = ";")

correct_dates <- data[data$Date == "1/2/2007"| data$Date == "2/2/2007",]

correct_dates[,3] <- as.numeric(correct_dates[,3])

png(filename = "plot1.png")

with(correct_dates, hist(Global_active_power, 
                         col = "red", 
                         xlab = "Global Active Power [kilowatts]",
                         main = "Global Active Power"))

dev.off()
