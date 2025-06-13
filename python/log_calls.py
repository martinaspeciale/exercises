def log_calls(f):
    def wrapper(*args, **kwargs):
        print(f"Calling {f.__name__} with args={args}, kwargs={kwargs}")
        return f(*args, **kwargs)
    return wrapper

@log_calls
def preprocess(data):
    # ...
    return
