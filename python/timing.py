import time

def timing(f):
    def wrapper(*args, **kwargs):
        start = time.time()
        result = f(*args, **kwargs)
        end = time.time()
        print(f"{f.__name__} took {end - start:.2f} seconds")
        return result
    return wrapper

@timing
def load_data():
    # ...
    return