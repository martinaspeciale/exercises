'''
chaining_decorators.py → Esempio di funzione decorata da più di un decorator
Perché è utile?
✅ In Data Engineering / Data Science spesso combini decorators:

@timing

@retry

@log_calls

Vedere come si "combinano" ti fa capire bene il flow.
'''

# chaining_decorators.py

import time

def timing(f):
    def wrapper(*args, **kwargs):
        start = time.time()
        result = f(*args, **kwargs)
        end = time.time()
        print(f"{f.__name__} took {end - start:.2f} seconds")
        return result
    return wrapper

def log_calls(f):
    def wrapper(*args, **kwargs):
        print(f"Calling {f.__name__} with args={args}, kwargs={kwargs}")
        return f(*args, **kwargs)
    return wrapper

@timing
@log_calls
def compute(x):
    time.sleep(0.5)
    return x ** 2

if __name__ == "__main__":
    print(compute(4))

'''
Output Example:
Calling compute with args=(4,), kwargs={}
compute took 0.50 seconds
16

'''