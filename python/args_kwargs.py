def my_func(*args, **kwargs):
    print("Positional:", args)
    print("Keyword:", kwargs)

print("for: my_func(1, 2, 3, a=4, b=5) :")
my_func(1, 2, 3, a=4, b=5)