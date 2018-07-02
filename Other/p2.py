import csv

with open('filingVolumes.csv', newline='') as myFile:
    reader = csv.reader(myFile)
    for row in reader:
        if row==[] or row==['filing_date']:
            continue
