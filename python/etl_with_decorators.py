# etl_with_decorators.py

import time
import random

# Timing decorator
def timing(f):
    def wrapper(*args, **kwargs):
        start = time.time()
        result = f(*args, **kwargs)
        end = time.time()
        print(f"{f.__name__} took {end - start:.2f} seconds")
        return result
    return wrapper

# Retry decorator
def retry(n_attempts=3):
    def decorator(f):
        def wrapper(*args, **kwargs):
            for attempt in range(1, n_attempts + 1):
                try:
                    print(f"Attempt {attempt}...")
                    return f(*args, **kwargs)
                except Exception as e:
                    print(f"Attempt {attempt} failed: {e}")
                    time.sleep(1)
            raise Exception("All retries failed")
        return wrapper
    return decorator

# Simulated ETL step
@timing
@retry(n_attempts=5)
def extract_data():
    # Simula un'operazione che può fallire casualmente
    if random.random() < 0.3:
        raise ValueError("Random extraction error!")
    print("Data extracted successfully.")
    return ["Alice", "Bob", "Charlie"]

@timing
def transform_data(data):
    print("Transforming data...")
    return [name.upper() for name in data]

@timing
def load_data(data):
    print("Loading data...")
    for item in data:
        print(f"- {item}")
    print("Load complete.")

if __name__ == "__main__":
    data = extract_data()
    transformed = transform_data(data)
    load_data(transformed)
