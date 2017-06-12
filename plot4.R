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



#plot4

par(mfcol= c(2,2),mar = c(4,4,2,1))
#plot4.1
with(household_seb, plot(DT,Global_active_power,type = "l",xlab = ""))
with(
        household_seb, 
        
        plot(DT,Sub_metering_1, col = "black", type = "l",
             main = NULL, xlab = "",ylab = "Energy sub metering")
)
#plot4.2
lines(household_seb$DT,household_seb$Sub_metering_2, col = "red")
lines(household_seb$DT,household_seb$Sub_metering_3, col = "blue")
legend(x=strptime("2007-02-01 13:00:00",format = "%Y-%m-%d %H:%M:%S"),
       y=40,
       lty = 1,col = c("black", "red","blue"), 
       lwd = c(1,1,1),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
      )

#plot4.3
with(household_seb, plot(DT,Voltage,type = "l",main = NULL, xlab = "datetime"))

#plot4.4
with(household_seb, plot(DT,Global_reactive_power, type = "l",main = NULL,xlab = "datetime"))

dev.copy(png,file = "plot4.png")
dev.off()

