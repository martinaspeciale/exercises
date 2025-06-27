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

