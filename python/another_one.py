# This function increments a number represented as a list of digits.
# For example:
#   [1, 2, 3] -> [1, 2, 4]
#   [1, 2, 9] -> [1, 3, 0]
#   [9, 9, 9] -> [1, 0, 0, 0]
#
# It works by checking the last digit:
# - If it's not 9, just add 1.
# - If it is 9, set it to 0 and carry over by recursively incrementing the rest.
# - If all digits were 9 (i.e., recursion hits an empty list), return [1].

def another_one(digits):
    if not digits:
        return [1]
    if digits[-1] != 9:
        digits[-1] += 1
        return digits
    else:
        return another_one(digits[:-1]) + [0]

# Example usage:
print(another_one([1, 2, 3]))  # Output: [1, 2, 4]
print(another_one([1, 2, 9]))  # Output: [1, 3, 0]
print(another_one([9, 9, 9]))  # Output: [1, 0, 0, 0]
