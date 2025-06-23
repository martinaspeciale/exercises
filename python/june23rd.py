
import numpy as np 
import pandas as pd 
from faker import Faker 

np.random.seed(42)
Faker.seed(42)

def filter_and_sort_evens(numbers):
    if not isinstance(numbers, list):
        return f"input should be a list, {numbers} is not"

    return sorted([n for n in numbers if n%2 == 0])



if __name__ == '__main__' :
    result = filter_and_sort_evens([1039, 3234 , 324 , 12, 56, 2])  
    # print(result)

    n = 5
    fake = Faker()
    data = pd.DataFrame({
        'name' : [fake.first_name() for _ in range(n)], 
        'city' : [fake.city() for _ in range(n)],
        'howmuch' : np.random.randint(50, 200, n)
    })
    print(data)