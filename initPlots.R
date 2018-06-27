startYear = 1900  #data starts from Jan, 1900

getRowPosition <- function(y, m)  #get the position of a row given parameters year and month
{
  return (as.integer(((y-startYear)*12 + m)))
}
getPrevMonth <- function(y, m)
{
  return (getRowPosition(y,m)-1)
}
getPrevYear <- function(y, m)
{
  return (getRowPosition(y,m)-12)
}

############################################################################
origVolData = read.csv("filingVolumes.csv", header=T)
#data = origData[getRowPosition(2003,0):nrow(origData),]
volData = origVolData[getRowPosition(2003,0):getRowPosition(2016,0),] ##only consider data from 2003-2016
volDataRows = volData[,c("Year", "Month", "numTimes")]

origTrendData = read.csv("multiTimeline.csv", header=T)
trendData = origTrendData[]


#Month vs. Number of Patents Filed
require(xts)
pcp <- volDataRows$numTimes
PCP <- ts(pcp, frequency = 12, start = 2003)
plot(as.xts(PCP), major.format = "%Y-%m", xlab = "Month", ylab = "Number of Patents Filed", main="Month vs. Number of Patents Filed")

