#########################################
#
# Computer Vision Project 1
# Joel Yuhas
# Feburary 11, 2019
#
#########################################

import cv2
import numpy as np
from matplotlib import pyplot as plt
from skimage.util import random_noise
from scipy import ndimage
#from mpl_toolkits.mplot3d import Axes3D
import os


def colorHistogram(input_image, output_image):
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
        plt.savefig(output_image)
    #plt.show()
    plt.savefig(output_image)

    
def kMeans(input_image):
    img = cv2.imread(input_image)

    #convert from BGR to RGB
    img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

    #get rgb values from image to 1D array
    r, g, b = cv2.split(img)
    r = r.flatten()
    g = g.flatten()
    b = b.flatten()
    

    
    
    
    
    
    
    
    
    
    
    

def highPassFilter(input_image, output_image):
        
    img = plt.imread(input_image)
    image = np.asarray(img,dtype=float)
    
    filterhp = np.array([[-1, -1, -1],
                       [-1,  6, -1],
                       [-1, -1, -1]])
    
    hp_image = ndimage.convolve(image, filterhp, mode ='reflect')
    plt.imsave(output_image,hp_image, cmap = 'Greys_r')
    
    
    
def lowPassFilter(input_image, output_image):
        
    img = plt.imread(input_image)
    image = np.asarray(img,dtype=float)
    
    filterlp = np.array([[0.04, 0.04, 0.04, 0.04, 0.04],
                         [0.04, 0.04, 0.04, 0.04, 0.04],
                         [0.04, 0.04, 0.04, 0.04, 0.04],
                         [0.04, 0.04, 0.04, 0.04, 0.04],
                         [0.04, 0.04, 0.04, 0.04, 0.04]])
    
    lp_image = ndimage.convolve(image, filterlp)   
    plt.imsave(output_image,lp_image, cmap = 'Greys_r')
    
    
def edgeDetection(input_image, output_image):
    img = cv2.imread(input_image)
    
    sobelx = cv2.Sobel(img,cv2.CV_64F,1,0,ksize=5)
    sobely = cv2.Sobel(img,cv2.CV_64F,0,1,ksize=5) 
    final = cv2.hconcat((sobelx, sobely)) 
    
    cv2.imwrite(output_image,final) 
    
    cv2.namedWindow('image', cv2.WINDOW_NORMAL)
    cv2.imshow('image',img) 
    cv2.imwrite(output_image,final) 
    cv2.waitKey(0)
    cv2.destroyAllWindows()
    
    sum_final = cv2.add(sobelx, sobely)                
    cv2.imwrite('lena_sum_final.jpg',sum_final)               
    
    
def saltAndPeperNoise(input_image, output_image):
    img = plt.imread(input_image)
    Salt_pepper_noise = random_noise(img,"s&p",0,1) 
    plt.imsave(output_image,Salt_pepper_noise, cmap = 'Greys_r') 
    
    
def gaussianNoise(input_image, output_image):
    img = plt.imread(input_image)
    final = img + np.random.normal(0,10,img.shape)
    plt.imsave(output_image,final, cmap = 'Greys_r') 
    
    
def filteringImage():
    img = plt.imread('lena.jpg')
    Salt_pepper_noise = random_noise(img,"s&p",0,1)
    
    
    #------ LOW PASS FILTERING --------
    image = np.asarray(Salt_pepper_noise,dtype=float)
    filterlp = np.array([[0.04, 0.04, 0.04, 0.04, 0.04],
                         [0.04, 0.04, 0.04, 0.04, 0.04],
                         [0.04, 0.04, 0.04, 0.04, 0.04],
                         [0.04, 0.04, 0.04, 0.04, 0.04],
                         [0.04, 0.04, 0.04, 0.04, 0.04]])
    
    
    lp_image = ndimage.convolve(image, filterlp)

    plt.imsave('lena_2_lp_snp.jpg',lp_image, cmap = 'Greys_r')
    img = plt.imread('lena.jpg')
    final = img + np.random.normal(0,10,img.shape)

    
      #------ LOW PASS FILTERING --------
    image = np.asarray(final,dtype=float)
    filterlp = np.array([[0.04, 0.04, 0.04, 0.04, 0.04],
                         [0.04, 0.04, 0.04, 0.04, 0.04],
                         [0.04, 0.04, 0.04, 0.04, 0.04],
                         [0.04, 0.04, 0.04, 0.04, 0.04],
                         [0.04, 0.04, 0.04, 0.04, 0.04]])
    
    
    lp_image = ndimage.convolve(image, filterlp)
    
    plt.imsave('lena_2_lp_gn.jpg',lp_image, cmap = 'Greys_r')
    
    
    #------ MEDIAN FILTERING --------
    image_m = cv2.imread('lena_gn.jpg')
    filterMedian = cv2.medianBlur(image_m,3)
    cv2.imwrite('lena_2_median_gn.jpg',filterMedian)
    
    image_m = cv2.imread('lena_snp.jpg')
    filterMedian = cv2.medianBlur(image_m,3)
    cv2.imwrite('lena_2_median_snp.jpg',filterMedian)
    
    #------ EDGE DETECTION ---------
    edgeDetection('lena_gn.jpg', 'lena_2_edge_gn.jpg');
    edgeDetection('lena_snp.jpg', 'lena_2_edge_snp.jpg');
    
    
def fourierTransform(input_image, output_image, output_image2, output_image3):
    
    #------ FFT --------
    img = cv2.imread(input_image,0)
    f = np.fft.fft2(img)
    mag_spec = 20*np.log(np.abs(f))
    plt.imsave(output_image,mag_spec, cmap = 'Greys_r')
    
    #------ FFT SHIFTED--------
    f = np.fft.fft2(img)
    fshift = np.fft.fftshift(f)
    mag_spec = 20*np.log(np.abs(fshift))
    plt.imsave(output_image2,mag_spec, cmap = 'Greys_r')
    
    #------ FFT LOG --------
    f = np.fft.fft2(img)
    fshift = np.fft.fftshift(f)
    mag_spec = 20*np.log(np.abs(fshift))
    plt.imsave(output_image3,mag_spec, cmap = 'Greys_r')
    
    
    #------ Inverser FFT ------
    invf = np.fft.ifft2(f)
    reconstructed = 20*np.log(np.abs(invf))
    plt.imsave('lena_3_inverise.jpg',reconstructed, cmap = 'Greys_r')
    
    #------ MSE ------
    mse = (np.square(img - reconstructed)).mean()
    
    #----- Step 3 ------
    #f_1 = np.fft.fft2(img)
    #f_1 = np.fft.fftfreq(1)
    #magnitude_spectrum = 20*np.log(np.abs(f_1))
    #plt.imsave('lena_3b_f_1.jpg',magnitude_spectrum, cmap = 'Greys_r')
    #mse1 = (np.square(img - reconstructed)).mean()
    
    print(mse)

    
def transformsFinal(input_image_1, input_image_2, output_image_1, output_image_2):
    # ----- Fourier transforms ----- 
    img_1 = cv2.imread(input_image_1,0)
    f_1 = np.fft.fft2(img_1)
    fshift_1 = np.fft.fftshift(f_1)
    
    img_2 = cv2.imread(input_image_2,0)
    f_2 = np.fft.fft2(img_2)
    fshift_2 = np.fft.fftshift(f_2)
    
    magnitude_spectrum_1 = 20*np.log(np.abs(fshift_1))
    phase_spectrum_1 = np.angle(fshift_1)
    plt.imsave('cat_mag_1.jpg',magnitude_spectrum_1, cmap = 'Greys_r')
    plt.imsave('cat_phas_1.jpg',phase_spectrum_1, cmap = 'Greys_r')
    
    magnitude_spectrum_2 = 20*np.log(np.abs(fshift_2))
    phase_spectrum_2 = np.angle(fshift_2)
    plt.imsave('face_mag_1.jpg',magnitude_spectrum_2, cmap = 'Greys_r')
    plt.imsave('face_phas_1.jpg',phase_spectrum_2, cmap = 'Greys_r')
    #plt.imsave(output_image_2,magnitude_spectrum_2, cmap = 'Greys_r')

    
    
    #------ Inverser FFT ------ T
    combined_1 = np.multiply(magnitude_spectrum_1,phase_spectrum_2)
    invf_1 = np.fft.ifft2(combined_1)
    reconstructed_1 = 20*np.log(np.abs(invf_1))
    plt.imsave('cat_face.jpg',reconstructed_1, cmap = 'Greys_r')
    
    combined_2 = np.multiply(magnitude_spectrum_2,phase_spectrum_1)
    invf_2 = np.fft.ifft2(combined_2)
    reconstructed_2 = 20*np.log(np.abs(invf_2))
    plt.imsave('face_cat.jpg',reconstructed_2, cmap = 'Greys_r')
    
def varianceOfImage():
    img_1 = cv2.imread('lena.jpg',0)
    img_2 = cv2.imread('cat.jpg',0)
    img_3 = cv2.imread('face.jpg',0)
    var_1 = cv2.meanStdDev(img_1)
    var_2 = cv2.meanStdDev(img_2)
    var_3 = cv2.meanStdDev(img_3)
    print(var_1)
    print(var_2)
    print(var_3)
    
    
    
    
