#########################################
#
# Computer Vision Project 2
# Joel Yuhas
# March 4, 2019
#   

import cv2
import numpy as np
from matplotlib import pyplot as plt
from skimage.util import random_noise
from scipy import ndimage
#from mpl_toolkits.mplot3d import Axes3D
import os

####################################################
# maskCall
####################################################   
#
# calculates the desired mask
#
####################################################

def maskCall(mask1, mask2):
    L5 = np.array([1,4,6,4,1])
    E5 = np.array([-1,-2,0,2,1])
    S5 = np.array([-1,0,2,0,1])
    R5 = np.array([1,-4,6,-4,1])
    
    result = np.array([[0,0,0,0,0],
                       [0,0,0,0,0],
                       [0,0,0,0,0],
                       [0,0,0,0,0],
                       [0,0,0,0,0]])
    
    if mask1 == 'L5':
        a = L5
    elif mask1 == 'E5':    
        a = E5
    elif mask1 == 'S5':    
        a = S5
    elif mask1 == 'R5':    
        a = R5
        
    if mask2 == 'L5':
        b = L5
    elif mask2 == 'E5':    
        b = E5
    elif mask2 == 'S5':    
        b = S5
    elif mask2 == 'R5':    
        b = R5
                
    
    for i in range(5):
        for j in range(5):
            result[i][j] = a[i]*b[j]

    return result





####################################################
# filterImage
####################################################   
#
# opens the image.
# resizes the image.
# filters the image using the specified mask.
# generates the average.
#
#
####################################################

def filterImage(input_image, mask1, mask2, width, height):
    img = cv2.imread(input_image)
    img = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    img2 = cv2.resize(img,(width,height))
    
    mask = maskCall(mask1, mask2)
    filterd_image = cv2.filter2D(img, -1, mask)

    
    average = np.mean(abs(filterd_image))

    return average



    
####################################################
# vectorCalculate
####################################################   
#
# calculates the 9 dimensonal vector from the filtered
# image based on all of the provied 1D vectors.
#
####################################################

def vectorCalculate(input_image, width, height):
    width = int(width)
    height = int(height)
    a1 = filterImage(input_image, 'L5', 'E5', width, height)
    a2 = filterImage(input_image, 'E5', 'L5', width, height)
    af = (a1 + a2)/2
    
    b1 = filterImage(input_image, 'L5', 'R5', width, height)
    b2 = filterImage(input_image, 'R5', 'L5', width, height)
    bf = (b1 + b2)/2
    
    c1 = filterImage(input_image, 'L5', 'S5', width, height)
    c2 = filterImage(input_image, 'S5', 'L5', width, height)
    cf = (c1 + c2)/2
    
    d1 = filterImage(input_image, 'E5', 'R5', width, height)
    d2 = filterImage(input_image, 'R5', 'E5', width, height)
    df = (d1 + d2)/2
    
    e1 = filterImage(input_image, 'E5', 'S5', width, height)
    e2 = filterImage(input_image, 'S5', 'E5', width, height)
    ef = (e1 + e2)/2
    
    f1 = filterImage(input_image, 'S5', 'R5', width, height)
    f2 = filterImage(input_image, 'R5', 'S5', width, height)
    ff = (f1 + f2)/2
    
    gf = filterImage(input_image, 'E5', 'E5', width, height)
    
    hf = filterImage(input_image, 'R5', 'R5', width, height)
    
    iif = filterImage(input_image, 'S5', 'S5', width, height)
       
    vector = [af, bf, cf, df, ef, ff, gf, hf, iif]
    

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
    
    for i in range(9):
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
 
def calculateAndSave(width, height):
    f=open("TextureVectors.txt", 'w+')
    j = 0
    
    # gets all this histograms from folder
    for folder in os.listdir('Texture_Images'):
        for picture in os.listdir('Texture_Images/%s' % folder):
            f.write(str(j))
            f.write(' ')
            f.write(picture)
            f.write(' ')
            for i in vectorCalculate("Texture_Images/{0}/{1}".format(folder, picture), width, height):
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

def vectorCompare(compare_image, width, height):
    allVectors = []        # stores the histograms of all pictures
    names = []                # stores the names of all the pictures based on index
    results = [1000] * 5         # stores top 5 intersection values
    result_names = [0.0] * 5    # stores the names of the top 5 pictures
    distance = [0.0] * 2    # [intersection value][name index]
    temp = [0.0] * 2            # [intersection value][name index] (temp intersection)
    
    
    #----------------------------------------------
    # read vectors from save file
    #---------------------------------------------- 
    f = open("TextureVectors.txt", 'r')
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
                               float(numbers[10])])
    f.close()    
    
    compareVector = vectorCalculate(compare_image, width, height)
    
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
                                     

        
          
                
    


                             
    
    