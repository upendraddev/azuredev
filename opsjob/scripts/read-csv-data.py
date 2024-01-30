import csv  
import sys
import datetime
import os
 
files = os.listdir()
filename=""
for i in files:
    if ".csv" in i:
        filename=i
chipIDs=sys.argv[1].split(",")
csv_data=[]
if filename == "":
    filename=datetime.datetime.now().strftime("%Y%m%d%H%M%S")+"-SO_Outputs.csv"
    csv_data=[["s.no","ChipID","Date","RequestedCount"]]
    count=1
    for j in chipIDs:
        csv_value=[count,j,datetime.datetime.now().strftime("%Y-%m-%d"),1]
        csv_data.append(csv_value)
        count+=1
else:
    with open(filename, mode ='r')as file:  
        csvFile = csv.reader(file)
        for lines in csvFile:  
            csv_data.append(lines)
    for j in chipIDs:
        chipexist=False
        for i in range(len(csv_data)):
            if j in csv_data[i]:
                chipexist=True
                csv_data[i][2]=datetime.datetime.now().strftime("%Y-%m-%d")
                csv_data[i][3]=int(csv_data[i][3])+1            
        if not chipexist:
            csv_data.append([len(csv_data),j,datetime.datetime.now().strftime("%Y-%m-%d"),1])
# print(csv_data)
with open(filename, 'w') as csvfile:  
    csvwriter = csv.writer(csvfile)  
    csvwriter.writerows(csv_data)