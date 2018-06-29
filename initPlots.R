getRowPosition <- function(y, m, startYear)  #get the position of a row given parameters year and month
{
  return (as.integer(((y-startYear)*12 + m)))
}
getPrevMonth <- function(y, m, startYear)
{
  return (getRowPosition(y,m, startYear)-1)
}
getPrevYear <- function(y, m, startYear)
{
  return (getRowPosition(y,m, startYear)-12)
}

dataStartDate = 2010
############################################################################
origVolData = read.csv("filingVolumes.csv", header=T)
volData = origVolData[getRowPosition(dataStartDate,0, 1900):getRowPosition(2016,0, 1900),] ##only consider data from startDate-2016

#Month vs. Number of Patents Filed
require(xts)
PCP <- ts(volData$numTimes, frequency = 12, start = dataStartDate)
plot(as.xts(PCP), major.format = "%Y-%m", xlab = "Month", ylab = "Number of Patents Filed", main="Month vs. Number of Patents Filed")



############################################################################
origCostOfPatent = read.csv("costOfPatent.csv", header = T) ##data starts on Jan, 2004
costOfPatent = origCostOfPatent[getRowPosition(dataStartDate,0, 2004):getRowPosition(2016,0, 2004),] ##only consider data from startDate-2016

# Month vs. Number of Patents Filed
# require(xts)
# PCP2 <- ts(costOfPatent$Index, frequency = 12, start = dataStartDate)
# plot(as.xts(PCP2), major.format = "%Y-%m", xlab = "Month", ylab = "'Cost of Patents' Trends Search Term", main="Month vs. 'Cost of Patents' Trends Search Term")


############################################################################
origPatentApplicationProcess = read.csv("patentApplicationProcess.csv", header = T) ##data starts on Jan, 2004
patentApplicationProcess = origPatentApplicationProcess[getRowPosition(dataStartDate,0, 2004):getRowPosition(2016,0, 2004),] ##only consider data from startDate-2016

# Month vs. Number of Patents Filed
# require(xts)
# PCP2 <- ts(patentApplicationProcess$Index, frequency = 12, start = dataStartDate)
# plot(as.xts(PCP2), major.format = "%Y-%m", xlab = "Month", ylab = "'Patent Application Process' Trends Search Term", main="Month vs. 'Patent Application Process' Trends Search Term")












