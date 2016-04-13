# Delete all variables.
rm(list=ls())
# Load libraries
library(lubridate)
library(dplyr)
# Read file. 
e <- read.csv("./household_power_consumption.txt",sep=";",stringsAsFactors = FALSE,na.strings = c("?"),
              colClasse= c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
# Concatenate date and time together into a new character column
e <-mutate(e,date_time=paste(e$Date,e$Time))
# Create a new POSIXct column from column above.
e <-mutate(e,Date_Time_Pos=dmy_hms( date_time,tz="GMT"))

#remove unncessary columns
e <- select(e,-(Date:Time))
e <- select(e,-(date_time))

#nrow(e)
# Get rows between two dates specified.
e <- filter(e,Date_Time_Pos >= as.POSIXct("2007-02-01 00:00:00",tz="GMT"),  Date_Time_Pos < as.POSIXct("2007-02-03 00:00:00",tz="GMT")  )


# 69518-66638
#summary(x$Global_active_power)

#par(mfrow=c(1,1),mar=c(2,2,2,2),oma=c(0,0,0,0))

# Generate plot
with(e,plot(Date_Time_Pos,Global_active_power,type="n",ylim=c(0,38),ylab="Global Active Power (killowatts)",xlab=""))

with(e,points(Date_Time_Pos,Sub_metering_1,col="black",type="l"))
with(e,points(Date_Time_Pos,Sub_metering_2 ,col="red",type="l"))
with(e,points(Date_Time_Pos,Sub_metering_3 ,col="blue",type="l"))

legend("topright", # places a legend at the appropriate place 
      c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), # puts text in the legend
       lty=c(1,1,1), # gives the legend appropriate symbols (lines)
       lwd=c(2.5,2.5,2.5),col=c("black","red","blue")) # gives the legend lines the correct color and width




# Generate file
dev.copy(png,file="plot3.png",width = 480, height = 480)
# Close device
dev.off()


