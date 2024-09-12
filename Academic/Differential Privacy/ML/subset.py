import csv
import random


with open('adult.csv') as csv_file:
    data_list = list(csv.reader(csv_file, delimiter=','))


rand_list_1=[]
i = 2000
with open('adult_2000.csv', 'w') as csv_file:
    w = csv.writer(csv_file, delimiter=',', lineterminator = '\n')
    # writing header
    w.writerow(data_list[0])
    while i > 0:
        r = random.randint(1,32562)
        if r not in rand_list_1:
            rand_list_1.append(r)
            w.writerow(data_list[r])
            i = i - 1

rand_list_2=[]
i = 350
with open('adult_350.csv', 'w') as csv_file:
    w = csv.writer(csv_file, delimiter=',', lineterminator = '\n')
    # writing header
    w.writerow(data_list[0])
    while i > 0:
        r = random.randint(1,32562)
        if r not in rand_list_1:
            rand_list_1.append(r)
            w.writerow(data_list[r])
            i = i - 1



val = input("right here bb")
print(val)
