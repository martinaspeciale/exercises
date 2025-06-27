# This function computes the sum of all natural numbers below the given target
# that are multiples of 3 or 5.
# For example, for target = 10:
# - Multiples of 3 or 5 below 10 are: 3, 5, 6, 9
# - Their sum is 23.
# The function uses a simple generator expression to check each number
# in the range from 1 up to (but not including) the target,
# and sums those divisible by 3 or 5.

def fizz_buzz_sum(target):
    return sum(n for n in range(1, target) if n % 3 == 0 or n % 5 == 0)

# Example usage
print(fizz_buzz_sum(10))  # Output: 23
