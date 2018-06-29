import csv

total = 0
datedict = {x:[0 for y in range(12)] for x in range(1900,2019)}

with open('input.csv', newline='') as myFile:
    reader = csv.reader(myFile)
    for row in reader:
        if row==[] or row==['filing_date']:
            continue
        date = row[0]
        try:
            datedict[int(date[0:4])][int(date[5:7])-1]+=1
            total+=1
        except:
            x=0
print(datedict)
print(sum([sum(datedict[x]) for x in datedict]))

with open('filingVolumes.csv', 'w') as csvfile:
    fieldnames = ['Date', 'numTimes']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames, lineterminator = '\n')

    writer.writeheader()
    for year in datedict:
        for month in range(12):
            numTimes = datedict[year][month]
            m = str(month+1)
            y = str(year)
            if len(m)==1:
                m="0"+m
            writer.writerow({'Date': y+"-"+m, "numTimes":numTimes})
