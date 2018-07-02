import csv
arr = []
with open('costOfPatent.csv', newline='') as myFile:
    reader = csv.reader(myFile)
    for row in reader:
        if row[0]==
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
