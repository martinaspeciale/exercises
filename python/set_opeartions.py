# Given two lists a and b
a = [1, 2, 3, 4]
b = [3, 4, 5, 6]

# =============================
# UNION: All unique elements from both a and b
# =============================

# Method 1: Using set union operator |
union1 = list(set(a) | set(b))
print("Union (|):", union1)

# Method 2: Using .union() method
union2 = list(set(a).union(b))
print("Union (.union()):", union2)


# =============================
# INTERSECTION: Elements common to both a and b
# =============================

# Method 1: Using set intersection operator &
intersection1 = list(set(a) & set(b))
print("Intersection (&):", intersection1)

# Method 2: Using .intersection() method
intersection2 = list(set(a).intersection(b))
print("Intersection (.intersection()):", intersection2)


# =============================
# DIFFERENCE: Elements in a but not in b
# =============================

# Method 1: Using set difference operator -
difference1 = list(set(a) - set(b))
print("Difference (a - b):", difference1)

# Method 2: Using .difference() method
difference2 = list(set(a).difference(b))
print("Difference (.difference()):", difference2)


# =============================
# SYMMETRIC DIFFERENCE: Elements in a or b but not both
# =============================

# Method 1: Using symmetric difference operator ^
symmetric_diff1 = list(set(a) ^ set(b))
print("Symmetric Difference (^):", symmetric_diff1)

# Method 2: Using .symmetric_difference() method
symmetric_diff2 = list(set(a).symmetric_difference(b))
print("Symmetric Difference (.symmetric_difference()):", symmetric_diff2)
