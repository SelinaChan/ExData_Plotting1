# loading the dataset of household_power_consumption
# and then making plot1

#read the data in
household <- read.table("household_power_consumption.txt",header = TRUE,
                        col.names = c("Date", "Time", "Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                        sep = ";",colClasses = c('character','character' ,'numeric','numeric','numeric','numeric','numeric','numeric','numeric'),
                        na.strings = "?")

#using data from the dates 2007-02-02 and 2007-02-01

startdate <- strptime("1/2/2007", format = "%d/%m/%Y")
enddate <- strptime("2/2/2007", format = "%d/%m/%Y")

#change Date from character class to date class
household$Date <- strptime(household$Date, format = "%d/%m/%Y")

household_seb <- household[household$Date==startdate|household$Date==enddate, ]


#plot1  
###plot a histogram , 
###set the filled color red
###set the title for the x & title for this plot
###save it to png file
hist(household_seb$Global_active_power, col = "red",
     xlab = "Global Active Power(kilowatts)",
     main = "Global Active Power")

dev.copy(png,file = "plot1.png")
dev.off()



