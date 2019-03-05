from imageio import imread
import matplotlib.pyplot as plt
import numpy as np
from scipy import ndimage

def calc(image,hz,dx):
    for i in range(image.shape[0]):
        for j in range(image.shape[1]):
            if(image[i][j] > 210):
                image[i][j] = 0
            else:
                image[i][j] = 255
    filtrada,n = ndimage.label(image)
    #print(n)
    #print(filtrada)
    CM = ndimage.center_of_mass(image,filtrada,range(2,n+1))
    y=[]
    x=[]
    for i in range(n-1):
        y.append(CM[i][0]*dx)
        x.append((1/hz)*(i))
    #print(y)
    #print(x)
    z = np.polyfit(x, y, 2)
    a=2*z[0] #aceleración
    b=z[1]
    c=z[2]
    print(a)
    #print(b)
    #print(c)
    
    #t=np.arange(0,(n-1)/hz,0.02) 
    #plt.plot(t, c+t*b+(t**2)*a) #(Gráfica linealizada)
    #plt.plot(x,y)
    
    plt.imshow(filtrada)
    plt.show()
