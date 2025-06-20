import numpy as np

np.random.seed(42)
'''a = np.random.randint(1, 101, (3,3))
print(a)'''

#slicing 
'''print(a[0:2, 1:3])'''

#broadcasting 
b = np.array([[10],[20],[30]]) # 3x1 
c = np.array([1,2,3]) # 1x3 


'''result = b+c 
print("\n\n column vector + row vector")
print(f"{b}\t+\t{c}\t =\n1n{result}")'''


# exercise slicing 
arr = np.random.randint(10, 100, (5,5))
print(arr)

print(f"third row: {arr[2]}")
print(f"fourth column: {arr[:,3]}")
print(f"3x3 center sub-array:\n {arr[1:4, 1:4]}")

# exercise broadcasting 
print(f"{arr[1:4,1:4]+ 100}")