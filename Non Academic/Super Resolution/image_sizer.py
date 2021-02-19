### 2/6/19
### conda implemtation
## envrionment name = "base"



import cv2
import numpy as np
from matplotlib import pyplot as plt


#input_image = 'D:\Spooky\Pictures\Avatars 2\Renders\Final_06.png'
input_image = 'D:/Spooky/Pictures/Avatars 2/Renders/test.png'
#input_image = "D:\Spooky\Pictures\01_Source\Avatars_S\test.png"
output_image = "D:\Spooky\A-Documents\Code\Super Resolution\images\image"
scaled_down_image = "D:\Spooky\A-Documents\Code\Super Resolution\images_scaled_down\image"
rejoined_images = "D:/Spooky/A-Documents/Code/Super Resolution/images_rejoined"
rejoined_image = "D:/Spooky/A-Documents/Code/Super Resolution/images_rejoined/rejoined.png"
C_DIMENSION = 128
C_ORIGINAL  = 4

result = np.array([[0,0,0,0,0],
                   [0,0,0,0,0],
                   [0,0,0,0,0],
                   [0,0,0,0,0],
                   [0,0,0,0,0]])

result = np.array([[0,0,0],
                   [0,0,0],
                   [0,0,0],
                   [0,0,0],
                   [0,0,0],
                   [0,0,0],
                   [0,0,0],
                   [0,0,0],
                   [0,0,0],
                   [0,0,0],
                   [0,0,0],
                   [0,0,0],
                   [0,0,0],
                   [0,0,0],
                   [0,0,0],
                   [0,0,0],])






img = cv2.imread(input_image)
dimensions = img.shape # height, width, depth
height = dimensions[0]//C_DIMENSION
width = dimensions[1]//C_DIMENSION



print(height)
print(width)
print(dimensions) 




#################################################################
## splitting up the images to 32 x 32 and scalling down as well
#################################################################
def split():
    i = 0
    j = 0
    counter = 0

    while i < height: 
        while j < width: 
            img2 = img[i*C_DIMENSION : (i*C_DIMENSION)+C_DIMENSION, j*C_DIMENSION : (j*C_DIMENSION)+C_DIMENSION]
            cv2.imwrite((output_image + str(counter) + "_" + str(i) + str(j) + ".jpg"),img2) 
            small = cv2.resize(img2,(int(C_DIMENSION/2),int(C_DIMENSION/2)))
            cv2.imwrite((scaled_down_image + str(counter) + "_" + str(i) + str(j) + ".jpg"),small) 
            
            j += 1
            counter += 1
        i += 1
        j = 0
    
    
#################################################################
## rejoining the outputed images into one file
#################################################################
def rejoin():
    img2 = np.zeros((height*C_DIMENSION,width*C_DIMENSION,3),np.uint8)
    i = 0
    j = 0
    counter = 0
    
    while i < height: 
        while j < width: 
            img = cv2.imread(output_image + str(counter) + "_" + str(i) + str(j) + ".jpg")
            img2[i*C_DIMENSION : (i*C_DIMENSION)+C_DIMENSION, j*C_DIMENSION : (j*C_DIMENSION)+C_DIMENSION] = img

            j += 1
            counter += 1
        i += 1
        j = 0

    cv2.imwrite(rejoined_image,img2)
    
    
    
    
    
#split()
rejoin()


print("Done")

