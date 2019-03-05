from imageio import imread
import matplotlib.pyplot as plt
from scipy import misc
from calc_mod import *
import numpy as np
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('-imname', help='Image name')
parser.add_argument('-hz')
parser.add_argument('-dx')
args = parser.parse_args()


def calc_acel(imname, hz, dx):
    
    imc = imread(imname)
    gray = rgb2gray(imc) 
    calc(gray,hz,dx)
    

def rgb2gray(rgb):
    return np.dot(rgb[...,:3], [0.299, 0.587, 0.114])

calc_acel(args.imname,float(args.hz),float(args.dx))
