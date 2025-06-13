# count_calls.py

def count_calls(f):
    def wrapper(*args, **kwargs):
        wrapper.calls += 1
        print(f"Call #{wrapper.calls} of {f.__name__}")
        return f(*args, **kwargs)
    wrapper.calls = 0
    return wrapper

@count_calls
def process_data(x):
    return x ** 2

if __name__ == "__main__":
    for i in range(5):
        print(process_data(i))

'''
Example Output:
Call #1 of process_data
0
Call #2 of process_data
1
Call #3 of process_data
4
Call #4 of process_data
9
Call #5 of process_data
16

'''