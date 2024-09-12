#########################################
#
# Computer Vision Project 2
# Joel Yuhas
# March 4, 2019
#
#########################################

import cv2
import numpy as np
from matplotlib import pyplot as plt
from scipy.ndimage import imread
import question1
import question2
import question3
import question4


def q1():
    
    ## Question 1
    
    question1.colorHistogram('Color_Images/306.jpg')
    print("1a) done")
    
    question1.kMeansBlackAndWhite('Color_Images/306.jpg', 4, "Output_Images/kmeansBW.jpg")
    print("1c) done")
    
    question1.kMeansBlackAndWhite('Color_Images/306.jpg', 2, "Output_Images/smallkBW.jpg") 
    question1.kMeansBlackAndWhite('Color_Images/306.jpg', 10, "Output_Images/largeKBW.jpg")
    print("1d) done")
    
    question1.kMeansColor('Color_Images/306.jpg', 2, "Output_Images/samllKColor.jpg")
    question1.kMeansColor('Color_Images/306.jpg', 10, "Output_Images/largeKColor.jpg")
    print("1e) done")
    
    
    
def q2():
    
    ## Question 2
    
    question2.histogramCompare('Color_Images/239.jpg')
    question2.histogramCompare('Color_Images/302.jpg')
    question2.histogramCompare('Color_Images/532.jpg')
    question2.histogramCompare('Color_Images/644.jpg')
    question2.histogramCompare('Color_Images/707.jpg')
    question2.histogramCompare('Color_Images/852.jpg')
    question2.histogramCompare('Color_Images/949.jpg')
    print("2b) done") 
    
    question2.histogramCompare('Color_Images/240.jpg')
    question2.histogramCompare('Color_Images/303.jpg')
    question2.histogramCompare('Color_Images/533.jpg')
    question2.histogramCompare('Color_Images/645.jpg')
    question2.histogramCompare('Color_Images/708.jpg')
    question2.histogramCompare('Color_Images/853.jpg')
    question2.histogramCompare('Color_Images/950.jpg')
    print("2c) done")


    
def q3():
    
    ## Question 3 
    
    question3.calculateAndSave('640','480')
    question3.vectorCompare('Texture_Images/T01_bark1/T01_37.jpg','640','480')
    question3.vectorCompare('Texture_Images/T05_wood2/T05_02.jpg','640','480')
    question3.vectorCompare('Texture_Images/T12_pebbles/T12_23.jpg','640','480')
    question3.vectorCompare('Texture_Images/T13_wall/T13_17.jpg' ,'640','480')
    question3.vectorCompare('Texture_Images/T18_carpet1/T18_20.jpg','640','480')
    question3.vectorCompare('Texture_Images/T25_plaid/T25_36.jpg','640','480')
    print("3b) done")
    
    question3.vectorCompare('Texture_Images/T01_bark1/T01_38.jpg','640','480')
    question3.vectorCompare('Texture_Images/T05_wood2/T05_03.jpg','640','480')
    question3.vectorCompare('Texture_Images/T12_pebbles/T12_24.jpg','640','480')
    question3.vectorCompare('Texture_Images/T13_wall/T13_18.jpg' ,'640','480')
    question3.vectorCompare('Texture_Images/T18_carpet1/T18_21.jpg','640','480')
    question3.vectorCompare('Texture_Images/T25_plaid/T25_37.jpg','640','480')
    print("3c) done")   
    
    question3.calculateAndSave('250','250')
    question3.vectorCompare('Texture_Images/T01_bark1/T01_37.jpg','250','250')
    question3.vectorCompare('Texture_Images/T05_wood2/T05_02.jpg','250','250')
    question3.vectorCompare('Texture_Images/T12_pebbles/T12_23.jpg','250','250')
    question3.vectorCompare('Texture_Images/T13_wall/T13_17.jpg' ,'250','250')
    question3.vectorCompare('Texture_Images/T18_carpet1/T18_20.jpg','250','250')
    question3.vectorCompare('Texture_Images/T25_plaid/T25_36.jpg','250','250')
    print("3d) size 250 done")
    
    question3.calculateAndSave('800','400')
    question3.vectorCompare('Texture_Images/T01_bark1/T01_37.jpg','800','400')
    question3.vectorCompare('Texture_Images/T05_wood2/T05_02.jpg','800','400')
    question3.vectorCompare('Texture_Images/T12_pebbles/T12_23.jpg','800','400')
    question3.vectorCompare('Texture_Images/T13_wall/T13_17.jpg' ,'800','400')
    question3.vectorCompare('Texture_Images/T18_carpet1/T18_20.jpg','800','400')
    question3.vectorCompare('Texture_Images/T25_plaid/T25_36.jpg','800','400')
    print("3d) size 800 done") 
    
    question3.calculateAndSave('200','800')
    question3.vectorCompare('Texture_Images/T01_bark1/T01_37.jpg','400','800')
    question3.vectorCompare('Texture_Images/T05_wood2/T05_02.jpg','400','800')
    question3.vectorCompare('Texture_Images/T12_pebbles/T12_23.jpg','400','800')
    question3.vectorCompare('Texture_Images/T13_wall/T13_17.jpg' ,'400','800')
    question3.vectorCompare('Texture_Images/T18_carpet1/T18_20.jpg','400','800')
    question3.vectorCompare('Texture_Images/T25_plaid/T25_36.jpg','400','800')
    print("3d) size 200 done")
       
    
def q4():
    question4.calculateAndSave()
    question4.vectorCompare('Texture_Images/T01_bark1/T01_03.jpg')
    question4.vectorCompare('Texture_Images/T05_wood2/T05_15.jpg')
    question4.vectorCompare('Texture_Images/T12_pebbles/T12_23.jpg')
    question4.vectorCompare('Texture_Images/T13_wall/T13_28.jpg')
    question4.vectorCompare('Texture_Images/T18_carpet1/T18_20.jpg')
    question4.vectorCompare('Texture_Images/T25_plaid/T25_01.jpg')
    print("4c) done")
    
    
    question4.vectorCompare('Texture_Images/T01_bark1/T01_04.jpg')
    question4.vectorCompare('Texture_Images/T05_wood2/T05_16.jpg')
    question4.vectorCompare('Texture_Images/T12_pebbles/T12_24.jpg')
    question4.vectorCompare('Texture_Images/T13_wall/T13_29.jpg')
    question4.vectorCompare('Texture_Images/T18_carpet1/T18_21.jpg')
    question4.vectorCompare('Texture_Images/T25_plaid/T25_02.jpg')
    print("4d) done")
    
    
def main():
    #########################################################
    # Note:
    # each question can be commented out to run other questions
    # seperatly as well.
    #########################################################
    
    
    q1()
    q2()
    q3()
    q4()

    
    print("done")