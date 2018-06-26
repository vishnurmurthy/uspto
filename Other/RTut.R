
####Constants
startyear = 1900
endyear = 2018
yearrange = endyear-startyear


####Functions
getRowPosition <- function(y, m)
{
  return (as.integer(((y-startyear)*12 + m)))
}

####Main Code



year =  c (rep(c(startyear:endyear), times=1, each=12))
month = c (rep(c(1:12),     times=yearrange+1, each=1))
numTimes = c(rep(0, times=12*(yearrange+1)))

data <- data.frame(year, month, numTimes, stringsAsFactors = FALSE)

MyData <- read.csv(file="input.csv", header=TRUE, sep=",")
readableData = MyData$filing_date


for (dat in readableData)
{
  new_year = as.integer(substr(dat, 1, 4))
  new_month = as.integer(substr(dat, 6, 7))
  rc = getRowPosition(new_year, new_month)
  data[rc,3] <- data[rc, 3] + 1
  print(data[rc,])
}
print(head(data))

write.csv(data, file="volumeData.csv")
print(data[1203:1213,])