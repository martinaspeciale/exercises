
import numpy as np 
import pandas as pd 
from faker import Faker 
import os 
import datetime 

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

    if not os.path.exists('data/data.csv'):
        data = pd.DataFrame({
            'name' : [fake.first_name() for _ in range(n)], 
            'city' : [fake.city() for _ in range(n)],
            'bought' : np.random.randint(50, 200, n)
        })
        print(data)
        data.to_csv('data/data.csv')

    df = pd.read_csv('data/data.csv') 
    # print(df)


    # cleaner version 
    filename = f"data/cleaned_data_{datetime.datetime.now().strftime('%Y%m%d_%H%M%S')}.csv"
    df.to_csv(filename, index=False)
    print(f"File {filename} created successfully")