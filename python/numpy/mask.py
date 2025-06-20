import numpy as np

np.random.seed(42) 

a = np.random.randint(1, 10, (5,5))
print(a)

mask = a > 50 
print(mask)

# print(a[mask]) # it return a 1 dimensional array with the elements satisfying the condition

print(a[mask].sum())
print(a.sum(axis = 0)) # som over columns -> a[0] : sum of all elems in col 0
print(a.sum(axis = 1)) # sum over rows 

# exercise 
arr = np.random.randint(1, 201, (6,6))
print(f"total sum: {arr.sum()}")
print(f"sum over columns: {arr.sum(axis = 0)}")
print(f"max over rows : {arr.max(axis = 1)}")

mask = (arr >= 50) & (arr <= 150)
print(f"{arr[mask]}")