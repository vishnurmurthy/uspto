getRowPosition <- function(y, m)
{
  return (as.integer(((y-startyear)*12 + m)))
}
getPrevMonthVolume <- function(y, m)
{
  
}

############################################################################
data = read.csv("filingVolumes.csv", header=T)

volData = data[,c("Year", "Month", "numTimes")]