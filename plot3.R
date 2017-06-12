# loading the dataset of household_power_consumption
# and then making plot2

#read the data in
household <- read.table("household_power_consumption.txt",header = TRUE,
                        col.names = c("Date", "Time", "Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                        sep = ";",colClasses = c('character','character' ,'numeric','numeric','numeric','numeric','numeric','numeric','numeric'),
                        na.strings = "?")

#set time format
household$DT <- strptime(paste(household$Date,household$Time), format = "%d/%m/%Y %H:%M:%S")
household$wd <- weekdays(household$DT,abbreviate = TRUE)


#using data from the dates 2007-02-02 and 2007-02-01
startdate <- strptime("1/2/2007", format = "%d/%m/%Y")
enddate <- strptime("2/2/2007", format = "%d/%m/%Y")

#change Date from character class to date class
household$Date <- strptime(household$Date, format = "%d/%m/%Y")

household_seb <- household[household$Date==startdate|household$Date==enddate, ]



#plot3
##  use plot(x, y)
##  set the ylab
##  set the margin
##  save it to png file
par(mar = c(3,4, 3, 3))
with(
        household_seb, 
       
        plot(DT,Sub_metering_1, col = "black", type = "l",
             main = NULL, xlab = NULL,ylab = "Energy sub metering")
)

lines(household_seb$DT,household_seb$Sub_metering_2, col = "red")
lines(household_seb$DT,household_seb$Sub_metering_3, col = "blue")
legend("topright", lty = 1,col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png,file = "plot3.png")
dev.off()

