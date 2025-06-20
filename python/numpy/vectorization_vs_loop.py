import numpy as np 
import time 

def get_time(f):
    def wrapper(*args, **kwargs):
        start = time.time() 
        result = f(*args, **kwargs) 
        end = time.time() 
        print(f"{f.__name__} took {end-start:.2f} seconds")
        return result
    return wrapper 

size = 10_000_000 

@get_time
def pure_loop(a,b):
    c = [] 
    for i in range(size):
        c.append(a[i]+b[i])

@get_time
def with_numpy(a,b): 
     c = a+b

if __name__ == "__main__":
    a = np.random.randint(0, 100, size) 
    b = np.random.randint(0, 100, size) 
    pure_loop(a,b)
    with_numpy(a,b)
