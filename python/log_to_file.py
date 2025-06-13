# log_to_file.py

def log_to_file(f):
    def wrapper(*args, **kwargs):
        result = f(*args, **kwargs)
        with open("function_calls.log", "a") as log_file:
            log_file.write(f"Called {f.__name__} with args={args}, kwargs={kwargs}, result={result}\n")
        return result
    return wrapper

@log_to_file
def multiply(a, b):
    return a * b

if __name__ == "__main__":
    multiply(2, 3)
    multiply(4, 5)
    multiply(6, 7)

'''
Output nel file function_calls.log:

Called multiply with args=(2, 3), kwargs={}, result=6
Called multiply with args=(4, 5), kwargs={}, result=20
Called multiply with args=(6, 7), kwargs={}, result=42
'''