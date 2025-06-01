library(ggplot2) # Load ggplot2 library for data visualization
library(zoo) # Load zoo library for time series manipulation

options(stringsAsFactors = FALSE) # Set option to prevent automatic conversion of strings to factors

# Read the CSV file containing the data into the variable pty_des
pty_des <- read.csv("R-code-example/PTY desiccation.csv") 

# Format the date
pty_des$Date.Time <- as.POSIXct(pty_des$Date.Time, format = "%m/%d/%y %H:%M:%S") 

# Calculate time intervals
pty_des$ddif <- as.numeric(pty_des$Date.Time - pty_des$Date.Time[1])/60

# Smooth the data to remove noise (moving average, 20 points)
pty_des <- transform(pty_des, avg = rollapplyr(Ptychostomum, 20, mean, fill = NA))

# Plot the data
plot(pty_des$ddif, pty_des$Ptychostomum,
     xlab="Time (minutes)", ylab="Impedance (KOhm)", type= "l")

# Plot the smoothed data
lines(pty_des$ddif, pty_des$avg, type= "l", add = T, col = "red")

# Convert impedance to conductance 1/R (Siemens)
pty_des$cond <- 1/pty_des$avg

# Rescale the conductance values with respect to the maximum
pty_des$cond100 <- (pty_des$cond-min(pty_des$cond, na.rm = TRUE))/(max(pty_des$cond, na.rm = TRUE)-min(pty_des$cond, na.rm = TRUE))

# Plot the conductance data
plot(pty_des$ddif, pty_des$cond100,
     xlab="Time (minutes)", ylab="Impedance (KOhm)", type= "l")

