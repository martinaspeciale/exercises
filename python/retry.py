import time

def retry(n_attempts=3):
    def decorator(f):
        def wrapper(*args, **kwargs):
            for attempt in range(n_attempts):
                try:
                    return f(*args, **kwargs)
                except Exception as e:
                    print(f"Attempt {attempt+1} failed: {e}")
                    time.sleep(1)
            raise Exception("All retries failed")
        return wrapper
    return decorator

@retry(n_attempts=5)
def fetch_from_api():
    # ...
    return