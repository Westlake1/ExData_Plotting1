## My R program script for the 
## Exploratory Data Analysis course
## Course Project 1, plot 3
## June, 2015


# --- Create my Working Directory if it doesn't exist
if(!file.exists("c:/J_Files")){dir.create("c:/J_Files")}
if(!file.exists("c:/J_Files/Coursera")){dir.create("c:/J_Files/Coursera")}
if(!file.exists("c:/J_Files/Coursera/EDA")){dir.create("c:/J_Files/Coursera/EDA")}

# --- set the working directory
setwd("c:/J_Files/Coursera/EDA")

# --- get the working directory to verify it is set correctly
getwd()

# --- create a directory called original_Downloaded_Data to keep the original data (if the directory doesn't exist)
if(!file.exists("original_Downloaded_Data")){dir.create("original_Downloaded_Data")}

# --- Set the URL name for the data source
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# --- download the data file
download.file(fileUrl, dest="./original_Downloaded_Data/dataset.zip", mode="wb")

# --- unzip the file --- re-start here
unzip("./original_Downloaded_Data/dataset.zip", files = NULL, list = FALSE, overwrite = TRUE,
      junkpaths = FALSE, unzip = "internal", setTimes = FALSE)

# --- read Consumption Data (cd) file into R
cd = read.table("./household_power_consumption.txt", header=TRUE, sep = ';') 

# --- Extract Data (ed) records for Feb 1st and 2nd, 2007 from Consumption Data (cd) file
# Date field format is dd/mm/YYYY)
ed1 <- cd[cd$Date  ==  "1/2/2007", ]
ed2 <- cd[cd$Date  ==  "2/2/2007", ]

# --- Combine the Extracted Data (ed) records into 1 dataset (ed)
ed <- rbind(ed1,ed2)

# --- Add the combined date/time field
ed$TS <- strptime(paste(ed$Date,ed$Time),"%d/%m/%Y %H:%M:%S")

# --- install packages and plot it to the screen
# install.packages("ggplot2")
library(ggplot2)

with(ed, plot(TS, Sub_metering_1, type = "l",  xlab = " ", ylab = "Energy sub metering"))  # main = "Plot 3",
with(subset(ed), points(TS, Sub_metering_2, col = "red", type = "l"))
with(subset(ed), points(TS, Sub_metering_3, col = "blue", type = "l"))
legend("topright", lwd=2, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# --- copy the plot to a PNG file
dev.copy(device = png, filename = 'plot3.png', width = 480, height = 480)

# --- close the PNG device
dev.off()

# --- end of my script -- 06-05-2015 -- jc Westlake1 --