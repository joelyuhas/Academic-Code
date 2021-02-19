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
from skimage.util import random_noise
from scipy import ndimage
#from mpl_toolkits.mplot3d import Axes3D
import os

####################################################
# histogramTotal
####################################################   
#
# the demomonator portion of the histogram intersection
# equation
#
####################################################
def histogramTotal(hist):
    red = 0
    blue = 0
    green = 0
    total = 0
    for i in range(96):
        red += hist[0][i]
        blue += hist[1][i]
        green += hist[2][i]
        
    total = red + blue + green
    
    return total

    
####################################################
# histogramIntersection
####################################################   
#
# 96 bin length
# intersection for R, G, B
# add them up at the end
# largest number = better intersection
#
#
####################################################

def histogramIntersection(hist1,hist2): 
    red = 0
    blue = 0
    green = 0
    total_intersection = 0
    for i in range(96):
        red += min(hist1[0][i], hist2[0][i])
        blue += min(hist1[1][i], hist2[1][i])
        green += min(hist1[2][i], hist2[2][i])


    total_intersection = red + blue + green

    
    return total_intersection  


####################################################
# histogramCalculate
####################################################
#
# gets the histogram of an image
# 2d arraay, 
#     first array = r, g, b
#     second array = 96 bins
#
#   returns histogram
#
####################################################

def histogramCalculate(input_image):
    #w, h = 96, 3;
    #histogram = [[0 for x in range(w)] for y in range(h)]
    histogram = [0] * 3
    
    img = cv2.imread(input_image)
    #img2 = cv2.resize(img,(552,552))
    color = ('b','g','r')
    
    histr1 = cv2.calcHist([img],[0],None,[96],[0,96])  
    histr2 = cv2.calcHist([img],[1],None,[96],[0,96])
    histr3 = cv2.calcHist([img],[2],None,[96],[0,96])
    
    histogram[0] = histr1
    histogram[1] = histr2
    histogram[2] = histr3
    

    return histogram
    
    

    
####################################################
# histogramCompare
####################################################
#
# goes through a folder
# finds the histogram over every image
# stores the histogram in a large array (all histograms)
# then picks one and finds the 4 best matches
# 
#   returns allHistograms
#
####################################################

def histogramCompare(compare_image):
    allHistograms = []        # stores the histograms of all pictures
    names = []                # stores the names of all the pictures based on index
    results = [0.0] * 5         # stores top 5 intersection values
    result_names = [0.0] * 5    # stores the names of the top 5 pictures
    intersection = [0.0] * 2    # [intersection value][name index]
    temp = [0.0] * 2            # [intersection value][name index] (temp intersection)
    
    
    # gets all this histograms from folder
    for picture in os.listdir('Color_Images'):
        allHistograms.append(histogramCalculate('Color_Images/%s' % picture))
        names.append(picture)
        
    # gets histogram for target compare image    
    compareHist = histogramCalculate(compare_image)
            
    # compares target histogram to all other histograms    
    for i in range(len(allHistograms)):
        
        hist_intersection_value = histogramIntersection(compareHist,allHistograms[i])
        hist_total_value = histogramTotal(allHistograms[i])
        hist_final_value = hist_intersection_value/hist_total_value

        
        intersection[0] = hist_intersection_value
        intersection[1] = i
            
        
        for j in range(len(results)):

            if results[j] <= intersection[0]:

                # putting intersectin value into results
                temp[0] = intersection[0]
                temp[1] = intersection[1]
                
                intersection[0] = results[j]
                intersection[1] = result_names[j]
                
                results[j] = temp[0]
                result_names[j] = temp[1]
                

    # match names to indiceeis           
    for i in range(len(result_names)):
        result_names[i] = names[result_names[i]]
                
                
              
    print(result_names)   
                             
                             

                             
    
    