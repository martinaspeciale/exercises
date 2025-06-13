'''
memoize.py -> Decorator di memoization fatto a mano (senza functools.lru_cache)
Perché è utile?
✅ In Data Science a volte vuoi cache manuale per:

funzioni lente

funzioni pure (senza side-effect)

ottimizzare algoritmi ricorsivi

Esempio classico: Fibonacci.
'''

def memoize(f):
    cache = {}
    def wrapper(*args):
        if args in cache:
            print(f"Using cached result for {args}")
            return cache[args]
        else:
            result = f(*args)
            cache[args] = result
            return result
    return wrapper

@memoize
def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)

if __name__ == "__main__":
    print(fibonacci(10))

'''
Output example:
Using cached result for (1,)
Using cached result for (2,)
Using cached result for (3,)
...
55

'''