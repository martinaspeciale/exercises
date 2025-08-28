from __future__ import annotations
from functools import wraps
from typing import Callable, Any

def log_calls(print_result: bool = True) -> Callable:
    """Log function calls and maintain a call count attribute."""
    def decorator(func: Callable) -> Callable:
        count = {"n": 0}

        @wraps(func)
        def wrapper(*args: Any, **kwargs: Any) -> Any:
            count["n"] += 1
            print(f"[{func.__name__} call #{count['n']}] args={args} 
kwargs={kwargs}")
            result = func(*args, **kwargs)
            if print_result:
                print(f"[{func.__name__} result] {result!r}")
            return result

        # expose the counter
        wrapper.call_count = count  # type: ignore[attr-defined]
        return wrapper
    return decorator

# Demo
@log_calls(print_result=True)
def multiply(a: int, b: int) -> int:
    return a * b

if __name__ == "__main__":
    multiply(2, 5)
    multiply(3, 7)
    print("Total calls:", multiply.call_count["n"])  # type: 
ignore[attr-defined]

