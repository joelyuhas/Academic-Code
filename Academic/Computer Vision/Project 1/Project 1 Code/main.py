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
from scipy.ndimage import imread
import functions

def main():
    #########################################################
    # Note, some funcitons will manually show the 
    # images, and requires the user to hit enter to continue.
    # The remaining images are saved locally.
    #########################################################
    
    # Question 1

    functions.highPassFilter('lena.jpg', 'lena_hp.jpg')
    functions.lowPassFilter('lena.jpg', 'lena_lp.jpg')
    functions.edgeDetection('lena.jpg', 'lena_ed.jpg')
    
    # Question 2
    
    functions.saltAndPeperNoise('lena.jpg', 'lena_snp.jpg')
    functions.gaussianNoise('lena.jpg', 'lena_gn.jpg')
    functions.filteringImage()
    functions.fourierTransform('lena.jpg','lena_3_fft.jpg','lena_3_fft_log.jpg', 'lena_3_sfft.jpg' )
    functions.transformsFinal('cat.jpg', 'face.jpg', 'cat_4_fft.jpg', 'face_4_fft.jpg')

    
    functions.varianceOfImage()
    
    print("done")