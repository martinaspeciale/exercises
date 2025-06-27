# This function finds the Weakest Strong Link in a matrix.
# A link is the Weakest Strong Link if:
# - It is the weakest (minimum) in its row.
# - It is the strongest (maximum) in its column.
# If such a link exists, return its value; otherwise, return -1.

def weakest_strong_link(strength):
    rows = len(strength)
    cols = len(strength[0])

    for i in range(rows):
        # Find the minimum in row i
        row_min = min(strength[i])

        for j in range(cols):
            if strength[i][j] == row_min:
                # Check if it's the maximum in its column
                col_vals = [strength[r][j] for r in range(rows)]
                if strength[i][j] == max(col_vals):
                    return strength[i][j]

    return -1

# Example usage
strength = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]
print(weakest_strong_link(strength))  # Output: 7

# ----------------------------------------------------------------
import numpy as np

# This function finds the Weakest Strong Link in a matrix of strengths.
# A link (i, j) is the Weakest Strong Link if:
# - It is the minimum in its row (weakest in its row),
# - It is the maximum in its column (strongest in its column).
# If such a link exists, return its value as an integer.
# If no such link exists, return -1.

def weakest_strong_link(strength):
    strength = np.array(strength)
    rows, cols = strength.shape

    # Find the minimum value in each row
    row_mins = np.min(strength, axis=1)
    # Find the maximum value in each column
    col_maxs = np.max(strength, axis=0)

    # Check every cell in the matrix
    for i in range(rows):
        for j in range(cols):
            if strength[i, j] == row_mins[i] and strength[i, j] == col_maxs[j]:
                # Return as a plain Python int
                return int(strength[i, j])

    # If no such link exists
    return -1

# Example usage
strength = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]

result = weakest_strong_link(strength)
print(result)  # Expected output: 7

