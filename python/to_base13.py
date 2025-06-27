# This function converts an integer num to its string representation in base 13.
# It uses digits 0-9 plus A, B, C for 10, 11, 12.
# For example:
#   29 -> "23"
#   13 -> "10"
#   12 -> "C"
# Negative numbers get a leading '-'.

def to_base13(num):
    if num == 0:
        return "0"
    
    digits = '0123456789ABC'
    result = ''
    negative = num < 0
    num = abs(num)
    
    while num > 0:
        result = digits[num % 13] + result
	# repeatedly divide by base to reduce the number
        num //= 13
    
    if negative:
        result = '-' + result
    
    return result

# Example usage
print(to_base13(29))   # Output: "23"
print(to_base13(13))   # Output: "10"
print(to_base13(12))   # Output: "C"
print(to_base13(-29))  # Output: "-23"
print(to_base13(0))    # Output: "0"

