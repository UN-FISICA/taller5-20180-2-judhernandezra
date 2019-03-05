#import time
from imageio import imread
import matplotlib.pyplot as plt
from cython.view cimport array as cvarray
cimport cython

#start=time.time() 

@cython.boundscheck(False)
@cython.wraparound(False)

def calc(image, double hz,double dx):
	narr = image
	cdef double [:,:] carr_view = narr
	
	cdef int i
	
	cdef int j

	for i in range(carr_view.shape[0]):
		for j in range(carr_view.shape[1]):
			if(carr_view[i][j] > 210):
				carr_view[i][j]=0
			else:
				carr_view[i][j]=255
	
	y=[]
	ycm=[]
	x=[]
	
	cdef int k
	
	for k in range(carr_view.shape[0]):
		if(carr_view[k][250] == 255) and (carr_view[k+1][250] == 0):
			y.append(k)
			
		elif(carr_view[k][250] == 255) and (carr_view[k-1][250] == 0):
			y.append(k+1)
		else:
			k=k+1	
		
	
	cdef int l=0
	cdef int o=0
	
	while l <= (len(y)-2):
		cm=((y[l]+y[l+1])*dx)/2
		ycm.append(cm)
		l=l+2
	
	while o <= (len(ycm)-1):
		x.append((1/hz)*o)
		o=o+1
	
	ycm.pop(0)
	x.pop()
	
	a=[]
	b=[]
	c=[]
	d=[]
	e=[]
	f=[]
	cdef int g=len(x)
	h=[]
	cdef int m=0
	
	while m < len(x):
		a.append(x[m]**4)
		b.append(x[m]**3)
		c.append(x[m]**2)
		d.append((x[m]**2)*ycm[m])
		e.append(x[m])
		f.append(x[m]*ycm[m])
		h.append(ycm[m])
		m=m+1
	
	cdef double a1=sum(a)
	cdef double b1=sum(b)
	cdef double c1=sum(c)
	cdef double d1=sum(d)
	cdef double e1=sum(e)
	cdef double f1=sum(f)
	cdef double h1=sum(h)
	cdef double acel=((b1*e1*h1)-(b1*f1*g)-(c1*c1*h1)+(c1*d1*g)+(c1*e1*f1)-(d1*e1*e1))/((a1*c1*g)-(a1*e1*e1)-(b1*b1*g)+(2*b1*c1*e1)-(c1*c1*c1))
	cdef double aceleracion=acel*2
	print(aceleracion)
	
	#end=time.time()
	#print(end-start)
	
	#plt.imshow(carr_view)
	#plt.show()
	

	
