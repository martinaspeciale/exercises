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


# --------------------------------------------------------------------------

import numpy as np

# Given two NumPy arrays
a = np.array([1, 2, 3, 4])
b = np.array([3, 4, 5, 6])

# =============================
# UNION: All unique elements from both arrays
# =============================

# np.union1d returns the sorted unique union
union = np.union1d(a, b)
print("Union:", union)

# =============================
# INTERSECTION: Elements common to both arrays
# =============================

# np.intersect1d returns the sorted unique intersection
intersection = np.intersect1d(a, b)
print("Intersection:", intersection)

# =============================
# DIFFERENCE: Elements in a but not in b
# =============================

# np.setdiff1d returns sorted unique elements in a not in b
difference_a_b = np.setdiff1d(a, b)
print("Difference (a - b):", difference_a_b)

# np.setdiff1d for b - a
difference_b_a = np.setdiff1d(b, a)
print("Difference (b - a):", difference_b_a)

# =============================
# SYMMETRIC DIFFERENCE: Elements in a or b but not both
# =============================

# Compute symmetric difference manually with union and intersection
symmetric_difference = np.setxor1d(a, b)
print("Symmetric Difference:", symmetric_difference)

