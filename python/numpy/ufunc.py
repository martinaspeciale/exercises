'''
Universal functions operate
on every single element in a vectorial fashion 
which makes it very efficient 
'''

import numpy as np 
np.random.seed(42)

a = np.random.randint(-10,10,(3,3))
print(a)
print(np.sqrt(a**2))
#print(np.log10(10**a))
print(np.exp(a))
print(np.abs(a))

# Advanced masking 
mask = (a > -5) & (a < 80) & (a%2 == 0)
filtered = a[mask]
print(a)
print(filtered)

print(np.where(a>0,1,0))


# exercise 
a = np.random.randint(0, 101, 50) 
print(a.mean())
print(np.median(a))
print(a.std())
print(np.percentile(a, 90))

mask = (a > a.mean()) & (a % 2 == 0) & (a % 3 == 0) 
print(a[mask])

b = np.where(a > 50, 1, 0) 
print(b)
