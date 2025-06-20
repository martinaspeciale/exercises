import numpy as np 

np.random.seed(42)

a = np.arange(12) # array from 0 to 11 
print(a)
print(a.size)
print(a.ndim)

b = a.reshape(4,3) 
print(b)
print(b.size)
print(b.ndim)

flat = b.flatten() 
rvl = b.ravel() 

print(f"flat:\n{flat}, {flat.ndim}")
print(f"\nravel:\n{rvl}, {rvl.ndim}\n\n")

print("Advanced Broadcasting")
A = np.random.randint(1, 10, (2,3))
B = np.random.randint(1, 10, 3) 
print(f"A:\n{A}")
print(f"B:\n{B}")

print(f"A+B=\n{A+B}\n")


C = np.array([10,20,30])
C_reshaped = C.reshape(3,1) 
print(C)
print(C_reshaped)

D = np.array([1,2,3,4]) 

# Dimensioni aggiunte per broadcasting 
result = C_reshaped + D 
print(f"{result}\n")

# exercise 
a = np.arange(0,20).reshape(4,5)
print(a)

b = np.linspace(10, 50, 5)
print(b)

print(a+b)

print(a)
flat = a.flatten() 
print(flat.sum())
a = flat.reshape(4,5)
print(a)