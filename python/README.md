# Python Exercises
## Python Decorators and Generators - ETL Examples

This folder contains examples of using **Python decorators** and **generators** for common patterns in Data Engineering and Data Science:

### Examples included:

- `pipeline_generators.py` → Example of building a **lazy pipeline** using `yield`, to process large CSV files efficiently.
- `etl_with_decorators.py` → Simulated ETL pipeline with:
    - `@timing` decorator → measures how long each step takes
    - `@retry` decorator → retries an ETL step if it fails
- `log_calls.py` → Example of a `@log_calls` decorator to log function calls.
- `retry.py` → Standalone example of a `@retry` decorator with configurable attempts.
- `timing.py` → Standalone example of a `@timing` decorator.
- `caching.py` → Example of caching function results with `@lru_cache` (useful for expensive computations).
- `args_kwargs.py` → Example of using `*args` and `**kwargs` in functions and decorators.
- `yield.py` → Small example to illustrate how `yield` works.

## Why these patterns matter:

In real-world Data Engineering / Data Science pipelines, decorators and generators help you to:

✅ Make ETL pipelines **robust** → automatic retries, logging, timing  
✅ Process **large datasets** efficiently with `yield`  
✅ Build **modular and reusable components**  
✅ Understand key Python advanced features used in frameworks (TensorFlow, PyTorch, Airflow, etc.)
