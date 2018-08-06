getRowPosition <- function(y, m, startYear)  #get the position of a row given parameters year and month
{
  return (as.integer(((y-startYear)*12 + m)) + 1)
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
dataEndDate = 2016

##### Import Google Trends Data
origGoogle = read.csv("costOfPatent.csv", header = T) ##data starts on Jan, 2004
google = origGoogle[getRowPosition(dataStartDate,0, 2004):getRowPosition(dataEndDate,11, 2004),] ##only consider data from startDate-2016
google$month = as.Date(google$month, "%m/%d/%Y")

##### Import volume Data
origDat = read.csv("filingVolumes.csv", header=T)
dat = origDat[getRowPosition(dataStartDate,0, 1900):getRowPosition(dataEndDate,11, 1900),] ##only consider data from startDate-2016
dat$month = as.Date(dat$month, "%m/%d/%Y")

##### get ready for the forecasting;
dat = rbind(dat, dat[nrow(dat), ]);
dat[nrow(dat), 'month'] = as.Date('2017-01-01');
dat[nrow(dat), -1] = rep(NA, ncol(dat)-1);

##### Define Predictors - Time Lags;
dat$s1 = c(NA, dat$volume[1:(nrow(dat)-1)]);
dat$s12 = c(rep(NA, 12), dat$volume[1:(nrow(dat)-12)]);

rownames(google) <- 1:nrow(google)
rownames(dat) <- 1:nrow(dat)

##### Plot volume & Google Trends data;
par(mfrow=c(2,1));
plot(dat$volume ~ dat$month, data= dat, lwd=2, type='l', main='Patent Volume',
     ylab='Volume', xlab='Time');
plot(google$trends ~ google$month, data= google, lwd=2, type='l', main='Google Trends: Cost of Patent',
     ylab='Percentage Change', xlab='Time');



##### Merge volume Data w/ Google Trends Data
google$month = as.Date(paste(substr(google$month, 1, 7), '01', sep='-'))
dat = merge(dat, google);

##Define Predictor - Google Trends
##### t.lag defines the time lag between the research and purchase.
########## t.lag = 0 if you want to include last week of the previous month and
################# 1st-2nd week of the corresponding month
########## t.lag = 1 if you want to include 1st-3rd week of the corresponding month

t.lag = 1;
id = which(dat$month[-1] != dat$month[-nrow(dat)]);
mdat = dat[id + 1, c('month', 'volume', 's1', 's12')];
mdat$trends1 = dat$trends[id + t.lag];
mdat$trends2 = dat$trends[id + t.lag + 1];
mdat$trends3 = dat$trends[id + t.lag + 2];

##### Divide data by two parts - model fitting & prediction
dat1 = mdat[1:(nrow(mdat)-1), ]
dat2 = mdat[nrow(mdat), ]

##### Fit Model;
fit = lm(log(sales) ~ log(s1) + log(s12) + trends1, data=dat1);
summary(fit)

##### Diagnostic Plot
par(mfrow=c(2,2))
plot(fit)

#### Prediction for the next month;
predict.fit = predict(fit, newdata=dat2, se.fit=TRUE)