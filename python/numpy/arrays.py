import numpy as np 
import random 

a = np.random.randint(1, 101, size=10)
print(a)
print(f"mean = {a.mean()}")
print(f"max = {a.max()}")
print(f"min = {a.min()}")
print(f"sum = {a.sum()}")

b = a[a > a.mean()]
print(f"a \t: {a} \na > 11\t: {b}")

