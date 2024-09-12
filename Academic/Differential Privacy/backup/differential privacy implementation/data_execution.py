# data_exectuion.py
# executes all the test needed
# specific to individuals pc based on where the data is saved (not generaciesed)
# format:
# data path, learning rate, noise multiplier, batch size, microbatchsize, epochs, dp toggle (1 on 0 off)


import os

#-------------------------
### DP
#-------------------------

#Epochs
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.15 1.1 128 1 1 1')
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.15 1.1 128 1 10 1')
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.15 1.1 128 1 50 1')
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.15 1.1 128 1 100 1')
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.15 1.1 128 1 500 1')
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.15 1.1 128 1 1000 1')
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.15 1.1 128 1 2000 1')

#Learngin Rate
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.15 1.1 128 1 100 1')
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.30 1.1 128 1 100 1')
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.50 1.1 128 1 100 1')
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.75 1.1 128 1 100 1')
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.60 1.1 128 1 100 1')
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.90 1.1 128 1 100 1')

#Batch Size
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.15 1.1 128 1 100 1')
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.15 1.1 256 1 100 1')
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.15 1.1 1024 1 100 1')
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.15 1.1 512 1 100 1')
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.15 1.1 2048 1 100 1')

#Noise Multiplier
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.15 1.1 128 1 100 1')
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.15 1.5 128 1 100 1')
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.15 2.0 128 1 100 1')
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.15 4.0 128 1 100 1')
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.15 8.1 128 1 100 1')

#-------------------------
### NON DP
#-------------------------

#Epochs No DP
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.15 1.1 128 1 1 0')
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.15 1.1 128 1 10 0')
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.15 1.1 128 1 50 0')
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.15 1.1 128 1 100 0')
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.15 1.1 128 1 500 0')

#Learngin Rate No DP
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.15 1.1 128 1 100 0')
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.30 1.1 128 1 100 0')
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.50 1.1 128 1 100 0')
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.75 1.1 128 1 100 0')

#Batch Size
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.15 1.1 128 1 100 0')
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.15 1.1 256 1 100 0')
os.system('python census_example.py "D:\Spooky\A-Documents\Code\Differential Privacy\data" 0.15 1.1 1024 1 100 0')
