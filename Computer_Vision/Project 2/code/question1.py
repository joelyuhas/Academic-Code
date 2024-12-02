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
from mpl_toolkits.mplot3d import Axes3D
import math


####################################################
# colorHistogram
####################################################   
#
# provides the appropriate histograms
#
#################################################### 
def colorHistogram(input_image):
    #img = cv2.imread(input_image,0)
    #histogram = cv2.calcHist([img],[0],None,[384],[0,384])
    #plt.hist(img.ravel(),256,[0,256])
    #plt.show()
    #print(histogram)
    img = cv2.imread(input_image)
    color = ('b','g','r')

    histr2 = cv2.calcHist([img],[0],None,[384],[0,384])
    plt.plot(histr2,'b')
    plt.xlim([0,384])
    plt.savefig("Output_Images/blue.jpg")
    plt.close()   
        
    histr3 = cv2.calcHist([img],[1],None,[384],[0,384])
    plt.plot(histr3,'g')
    plt.xlim([0,384])
    plt.savefig("Output_Images/green.jpg")
    plt.close()
    
    histr1 = cv2.calcHist([img],[2],None,[384],[0,384])
    plt.plot(histr1,'r')
    plt.xlim([0,384])
    plt.savefig("Output_Images/red.jpg")
    plt.close()
    
    for i,col in enumerate(color):
        histr = cv2.calcHist([img],[i],None,[384],[0,384])
        plt.plot(histr,color = col)
        plt.xlim([0,384])
        plt.savefig('Output_Images/color.jpg')
    #plt.show()
    plt.savefig('color.jpg')
    
    
    
####################################################
# kMeansBlackAndWhite
####################################################   
#
# kMeans for black and white images
#
#################################################### 
def kMeansBlackAndWhite(input_image, k, output_image):
    img = cv2.imread(input_image)
    imgBW = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    
    cv2.imwrite("Output_Images/greyscale.jpg",imgBW)
    
    img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
      
    histr2 = cv2.calcHist([img],[0],None,[384],[0,384])
    
    #plotting 
    plt.plot(histr2)
    plt.xlim([0,384])
    plt.savefig("Output_Images/grey.jpg")
    plt.close()   
    centroid = []
    for i in range(k):
        centroid.append(np.random.randint(0,384))
        
    centroid = centroidCalc(centroid,k,histr2, 0)
    distance = [0] * k
    
    # converting image values with new centroids
    
    for i in range(len(img)):
        for x in range(len(img[i])):
            for j in range(len(centroid)):
                distance[j] = (img[i][x]-centroid[j])**2
            for w in range(len(distance)):
                temp = min(distance)
                if temp == distance[w]:
                    img[i][x] = centroid[w]
    cv2.imwrite(output_image, img)
    
    
    
####################################################
# centroidCalc
####################################################   
#
# calculates the new centroidss
#
####################################################       
def centroidCalc(centroid, k, histr2, iterations):
    old_centroid = centroid
    cluster = [None] * 384
    cluster_weight = 0
    distance = [0] * k
   
    ## CREATING CLUSTERS
    
    # find nearest data point
    for i in range(len(histr2)):
        for j in range(len(centroid)):
            distance[j] = (i-centroid[j])**2
        for w in range(len(distance)):
            temp = min(distance)
            if temp == distance[w]:
                cluster[i] = w
           
                
    ## UPDATNG CENTROIDS
    for w in range(k):
        weight = 0
        cluster_weight =0
        for i in range(len(histr2)):
            if cluster[i] == w:
                weight += histr2[i]
        for i in range(len(histr2)):
            if cluster[i] == w:
                if weight == 0:
                    cluster_weight = 0
                else:
                    cluster_weight += (histr2[i]/weight) * (i+1)
                
                #print("pop: " ,histr2[i], " : " ,weight, " : " ,cluster_weight)

        centroid[w]=cluster_weight
  
    # check if centroids have changed enough
    # only if all centroids are the same as the old ones, the flag array will be true
    flag = [False] * k
    for i in range(len(centroid)):
        if centroid[i] == old_centroid[i]:
            flag[i] = True

    # done
    if (iterations > 50):
        for i in range(len(histr2)):
            histr2[i] = centroid[cluster[i]]
    
        plt.plot(histr2,'b')
        plt.xlim([0,384])
        plt.savefig("Output_Images/ohno.jpg")
        plt.close()  
        return centroid

    # Not done, keep going
    else:
        iterations += 1
        centroidCalc(centroid,k,histr2, iterations)
    
    return centroid     
            
    
####################################################
# kMeansColor
####################################################   
#
# gets the KMean for color image
#
####################################################    
def kMeansColor(input_image, k, output_image):
    img = cv2.imread(input_image)
   
    centroid = [0] * k

    ## Creating Centroids
    
    for i in range(k):
        centroid[i] = [0] * 3
        centroid[i][0] = np.random.randint(0,384)
        centroid[i][1] = np.random.randint(0,384)
        centroid[i][2] = np.random.randint(0,384)
        
    ## Converting image to 3D color space    
    
    colorHist = [0]*3

    histr1 = cv2.calcHist([img],[0],None,[384],[0,384])
    histr2 = cv2.calcHist([img],[1],None,[384],[0,384])
    histr3 = cv2.calcHist([img],[2],None,[384],[0,384])

    colorHist[0] = histr1
    colorHist[1] = histr2
    colorHist[2] = histr3
    
    
    ## Performinc K-Means
    
    centroid = centroidCalcColor(centroid,k,colorHist, 0)
    distance = [0] * k
    
    # converting image values with new centroids

    
    for i in range(len(img)):
        for x in range(len(img[i])):

            
            for j in range(len(centroid)):
                d1 = (img[i][x][0]-centroid[j][0])**2
                d2 = (img[i][x][1]-centroid[j][1])**2
                d3 = (img[i][x][2]-centroid[j][2])**2
                distance[j] = math.sqrt(d1 + d2 + d3)
            for w in range(len(distance)):
                temp = min(distance)
                if temp == distance[w]:
                    boof1 = centroid[j][0]
                    boof2 = centroid[j][1]
                    boof3 = centroid[j][2]
                    centroid[j][0] = boof1 #blue
                    centroid[j][1] = boof2 # green
                    centroid[j][2] = boof3 # red
                    img[i][x] = centroid[w]

    cv2.imwrite(output_image, img)
    

    
####################################################
# centroidCalcColor
####################################################   
#
# calculates the 3d Centroid
#
####################################################

def centroidCalcColor(centroid, k, histr2, iterations):
    old_centroid = centroid
    clusterR = [None] * 384
    clusterB = [None] * 384
    clusterG = [None] * 384
    cluster_weight = 0
    distanceR = [0] * k
    distanceB = [0] * k
    distanceG = [0] * k


    ## CREATING CLUSTERS

    
    # find nearest data point

    for i in range(len(histr2[0])):

        ## RED Distnace

        for j in range(k):
            distanceR[j] = (i-centroid[j][0])**2
        for w in range(len(distanceR)):
            temp = min(distanceR)
            if temp == distanceR[w]:
                clusterR[i] = w

        ## BLUE Distance

        for j in range(k):
            distanceB[j] = (i-centroid[j][1])**2
        for w in range(len(distanceB)):
            temp = min(distanceB)
            if temp == distanceB[w]:
                clusterB[i] = w

        ## GREEN Distance

        for j in range(k):
            distanceG[j] = (i-centroid[j][2])**2
        for w in range(len(distanceG)):
            temp = min(distanceG)
            if temp == distanceG[w]:
                clusterG[i] = w
                
                
    ## UPDATNG CENTROIDS
    
    ## RED CENTROID
    
    for w in range(k):
        weight = 0
        cluster_weight =0
        for i in range(len(histr2[0])):
            if clusterR[i] == w:
                weight += histr2[0][i]
        for i in range(len(histr2[0])):
            if clusterR[i] == w:
                if weight == 0:
                    cluster_weight = 0
                else:
                    cluster_weight += (histr2[0][i]/weight) * (i+1)
                
        centroid[w][0]=cluster_weight
    
    ## BLUE CENTORID
    
    for w in range(k):
        weight = 0
        cluster_weight =0
        for i in range(len(histr2[1])):
            if clusterB[i] == w:
                weight += histr2[1][i]
        for i in range(len(histr2[1])):
            if clusterB[i] == w:
                if weight == 0:
                    cluster_weight = 0
                else:
                    cluster_weight += (histr2[1][i]/weight) * (i+1)
                
        centroid[w][1]=cluster_weight
    
    
    ## GREEN CENTORID
    
    for w in range(k):
        weight = 0
        cluster_weight =0
        for i in range(len(histr2[2])):
            if clusterG[i] == w:
                weight += histr2[2][i]
        for i in range(len(histr2[2])):
            if clusterG[i] == w:
                if weight == 0:
                    cluster_weight = 0
                else:
                    cluster_weight += (histr2[2][i]/weight) * (i+1)
                
        centroid[w][2]=cluster_weight
    

    # done
    if (iterations > 50):
        for i in range(len(histr2[0])):
            histr2[0][i] = centroid[clusterR[i]][0]
            histr2[1][i] = centroid[clusterG[i]][1]
            histr2[2][i] = centroid[clusterB[i]][2]
         
        plt.plot(histr2[0],'r')
        plt.xlim([0,384])
        plt.savefig("Output_Images/ohnoR.jpg")
        plt.close()  
        plt.plot(histr2[1],'g')
        plt.xlim([0,384])
        plt.savefig("Output_Images/ohnoG.jpg")
        plt.close()  
        plt.plot(histr2[2],'b')
        plt.xlim([0,384])
        plt.savefig("Output_Images/ohnoB.jpg")
        plt.close()  
        
        return centroid

    # Not done, keep going
    else:
        iterations += 1
        centroidCalcColor(centroid,k,histr2, iterations)
    
    return centroid     