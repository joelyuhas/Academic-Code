#########################################
#
# Computer Vision Project 2
# Joel Yuhas
# March 4, 2019
######################################### 

import cv2
import numpy as np
from matplotlib import pyplot as plt
from skimage.util import random_noise
from scipy import ndimage
#from mpl_toolkits.mplot3d import Axes3D
import os




####################################################
# generateGaborFilter()
####################################################   
#
# create a gabor filter
# return that filter
#
# http://vision.psych.umn.edu/users/kersten/kersten-lab/courses/Psy5036W2017/Lectures/17_PythonForVision/Demos/html/2b.Gabor.html
###################################################
def generateGaborFilter(sz, omega, theta, func=np.cos, K=np.pi):
    radius = (int(sz[0]/2.0), int(sz[1]/2.0))
    [x, y] = np.meshgrid(range(-radius[0], radius[0]+1), range(-radius[1], radius[1]+1))

    x1 = x * np.cos(theta) + y * np.sin(theta)
    y1 = -x * np.sin(theta) + y * np.cos(theta)
    
    gauss = omega**2 / (4*np.pi * K**2) * np.exp(- omega**2 / (8*K**2) * ( 4 * x1**2 + y1**2))
#     myimshow(gauss)
    sinusoid = func(omega * x1) * np.exp(K**2 / 2)
#     myimshow(sinusoid)
    gabor = gauss * sinusoid
    
    return gabor



####################################################
# generateGaborBank
####################################################   
#
# create a gabor filter
# return that filter
#
# http://vision.psych.umn.edu/users/kersten/kersten-lab/courses/Psy5036W2017/Lectures/17_PythonForVision/Demos/html/2b.Gabor.html
###################################################
def generateGaborBank():
    g = generateGaborFilter((256,256), 0.5, np.pi/4, func=np.cos)
    #plt.figure();
    #plt.axis('off')
    #plt.imshow(g, cmap=plt.gray())
    #plt.savefig('blyat.jpg')
    

    theta = np.arange(0, np.pi, np.pi/4) # range of theta
    omega = np.arange(0.2, 0.6, 0.1) # range of omega
    params = [(t,o) for o in omega for t in theta]
    sinFilterBank = []
    cosFilterBank = []
    gaborParams = []
    for (theta, omega) in params:
        gaborParam = {'omega':omega, 'theta':theta, 'sz':(128, 128)}
        sinGabor = generateGaborFilter(func=np.sin, **gaborParam)
        cosGabor = generateGaborFilter(func=np.cos, **gaborParam)
        sinFilterBank.append(sinGabor)
        cosFilterBank.append(cosGabor)
        gaborParams.append(gaborParam)

    #plt.figure()
    #n = len(sinFilterBank)
    #for i in range(n):
    #    plt.subplot(4,4,i+1)
    #    # title(r'$\theta$={theta:.2f}$\omega$={omega}'.format(**gaborParams[i]))
    #    plt.axis('off'); plt.imshow(sinFilterBank[i])
        
    #plt.figure()
    #for i in range(n):
    #    plt.subplot(4,4,i+1)
    #    # title(r'$\theta$={theta:.2f}$\omega$={omega}'.format(**gaborParams[i]))
    #    plt.axis('off'); plt.imshow(cosFilterBank[i])

    
    
    
    
    
    return sinFilterBank


####################################################
# filterImage
####################################################   
#
# opens the image.
# filters the image using the specified mask.
# generates the average.
#
#
####################################################

def filterImage(input_image, filterNumber):
    img = cv2.imread(input_image)
    img = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    sinFilterBank = generateGaborBank()
    
    filterd_image = cv2.filter2D(img, -1, sinFilterBank[filterNumber])

    #plt.figure();
    #plt.axis('off')
    #plt.imshow(filterd_image, cmap=plt.gray())
    #plt.savefig('blyat2.jpg')
    
    average = np.mean(abs(filterd_image))

    return average



    
####################################################
# vectorCalculate
####################################################   
#
# calculates the 12 dimensonal vector from the filtered
# image based on all of the provied 1D vectors.
#
####################################################

def vectorCalculate(input_image):
    a1 = filterImage(input_image, 0)
    a2 = filterImage(input_image, 1)
    a3 = filterImage(input_image, 2)
    a4 = filterImage(input_image, 3)
    a5 = filterImage(input_image, 4)
    a6 = filterImage(input_image, 5)
    a7 = filterImage(input_image, 6)
    a8 = filterImage(input_image, 7)
    a9 = filterImage(input_image, 8)
    a10 = filterImage(input_image, 9)
    a11 = filterImage(input_image, 10)
    a12 = filterImage(input_image, 11)
       
    vector = [a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12]
    
    return vector
    
    
    
    
        
####################################################
# chaiSquareDistance
####################################################   
#
# calculates the chi square distance
#
####################################################
    
def chaiSquareDistance(vector1,vector2): 
    sm = 0

    for i in range(12):
        num = vector1[i]-vector2[i]
        den = vector1[i]+vector2[i]
        sm += (num*num)/den
    
    sm = sm/2
    
    return sm
    
    

####################################################
# calculateAndSave
####################################################   
#
# goes through all folders.
# calculates the 9 dimensonal vector for all images.
# saves those images into a save file.
#
# calculations of all pictures is time consuming.
# saving the results to a file drastically saves
# time while testing.
#
####################################################
 
def calculateAndSave():
    f=open("TextureVectors_Gabor.txt", 'w+')
    j = 0
    
    # gets all this histograms from folder
    for folder in os.listdir('Texture_Images'):
        for picture in os.listdir('Texture_Images/%s' % folder):
            f.write(str(j))
            f.write(' ')
            f.write(picture)
            f.write(' ')
            for i in vectorCalculate("Texture_Images/{0}/{1}".format(folder, picture)):
                f.write(str(i))
                f.write(' ')
            f.write('\n')
            j += 1    

    f.close()


    
####################################################
# vectorCompare
####################################################
#
# goes through a folder
# reads the 9 dimensonal vector from the save file
# stores vectors in a large array (allVectors)
# recievs one picks one and finds the 5 best matches
# 
#   prints the top 5 results
#
####################################################

def vectorCompare(compare_image):
    allVectors = []        # stores the histograms of all pictures
    names = []                # stores the names of all the pictures based on index
    results = [1000] * 5         # stores top 5 intersection values
    result_names = [0.0] * 5    # stores the names of the top 5 pictures
    distance = [0.0] * 2    # [intersection value][name index]
    temp = [0.0] * 2            # [intersection value][name index] (temp intersection)
    
    
    #----------------------------------------------
    # read vectors from save file
    #---------------------------------------------- 
    f = open("TextureVectors_Gabor.txt", 'r')
    lines = f.read().split('\n')
    for w in lines:
        numbers = w.split(' ')
        if len(numbers) >= 11:
            names.append(numbers[1])
            allVectors.append([float(numbers[2]),
                               float(numbers[3]),
                               float(numbers[4]),
                               float(numbers[5]),
                               float(numbers[6]),
                               float(numbers[7]),
                               float(numbers[8]),
                               float(numbers[9]),
                               float(numbers[10]),
                               float(numbers[11]),
                               float(numbers[12]),
                               float(numbers[13])])
    f.close()    
    
    compareVector = vectorCalculate(compare_image)
    
    for i in range(len(allVectors)):
        distance[0] = chaiSquareDistance(compareVector,allVectors[i])
        distance[1] = i
        
        for j in range(len(results)):

            if results[j] > distance[0]:        
                # putting intersectin value into results
                temp[0] = distance[0]
                temp[1] = distance[1]
            
                distance[0] = results[j]
                distance[1] = result_names[j]
                
                results[j] = temp[0]
                result_names[j] = temp[1]
                
    # match names to indiceeis           
    for i in range(len(result_names)):
        result_names[i] = names[result_names[i]]
                          
                    

    print(result_names)   
                                     

        
          
             


                             
    
    