def count_down(n, how_many):
    if how_many > n :
        return 
    while how_many > 0:
        yield n
        n -= 1
        how_many -= 1

n = int(input("number: "))
how_many = int(input("how many steps back: "))
gen = count_down(n, how_many)

while True:
    try:
        value = next(gen)
        print(value)
    except StopIteration:
        print("Generator is exhausted.")
        break
