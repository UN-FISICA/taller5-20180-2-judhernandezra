#import time
from imageio import imread
import matplotlib.pyplot as plt
from cython.view cimport array as cvarray

#start=time.time()

def calc(image,hz,dx):
	narr = image
	cdef double [:,:] carr_view = narr
	
	#print(carr_view.shape[0])
	

	for i in range(carr_view.shape[0]):
		for j in range(carr_view.shape[1]):
			if(carr_view[i][j] > 210):
				carr_view[i][j]=0
			else:
				carr_view[i][j]=255
	
	y=[]
	ycm=[]
	x=[]
	for k in range(carr_view.shape[0]):
		if(carr_view[k][250] == 255) and (carr_view[k+1][250] == 0):
			y.append(k)
			
		elif(carr_view[k][250] == 255) and (carr_view[k-1][250] == 0):
			y.append(k+1)
		else:
			k=k+1	
		
	l=0
	o=0
	while l <= (len(y)-2):
		cm=((y[l]+y[l+1])*dx)/2
		ycm.append(cm)
		l=l+2
	
	while o <= (len(ycm)-1):
		x.append((1/hz)*o)
		o=o+1
	
	#n=len(x)
	
	ycm.pop(0)
	x.pop()
	
	#print(ycm)
	#print(x)
	
	a=[]
	b=[]
	c=[]
	d=[]
	e=[]
	f=[]
	g=len(x)
	h=[]
	m=0
	while m < len(x):
		a.append(x[m]**4)
		b.append(x[m]**3)
		c.append(x[m]**2)
		d.append((x[m]**2)*ycm[m])
		e.append(x[m])
		f.append(x[m]*ycm[m])
		h.append(ycm[m])
		m=m+1
	
	a1=sum(a)
	b1=sum(b)
	c1=sum(c)
	d1=sum(d)
	e1=sum(e)
	f1=sum(f)
	h1=sum(h)
	
	#print(a1)
	#print(d1)
	#print(g)
	acel=((b1*e1*h1)-(b1*f1*g)-(c1*c1*h1)+(c1*d1*g)+(c1*e1*f1)-(d1*e1*e1))/((a1*c1*g)-(a1*e1*e1)-(b1*b1*g)+(2*b1*c1*e1)-(c1*c1*c1))
	aceleracion=acel*2
	print(aceleracion)
	
	#end=time.time()
	#print(end-start)
	
	#plt.imshow(carr_view)
	#plt.show()
