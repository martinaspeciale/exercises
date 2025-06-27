# FOR LOOP VERSION 
import numpy as np

def is_same_stripes(matrix):
    matrix = np.array(matrix)
    rows, cols = matrix.shape

    # We want to check if all elements on each diagonal are the same.
    # That means matrix[i, j] must equal matrix[i+1, j+1] everywhere.
    # We loop over all valid (i, j) pairs that allow this comparison.

    for i in range(rows - 1):
        for j in range(cols - 1):
            # Compare current element with the one down and to the right.
            if matrix[i, j] != matrix[i + 1, j + 1]:
                return False

    # If all comparisons pass, the matrix has constant diagonals (Toeplitz)
    return True

# NUMPY SLICING VERSION 
import numpy as np

def is_same_stripes(matrix):
    matrix = np.array(matrix)
    
    # matrix[1:, 1:] is the submatrix excluding first row and column.
    # For example, in a 3x3 matrix:
    # Original:
    #  A B C
    #  D E F
    #  G H I
    #
    # matrix[1:, 1:] gives:
    #  E F
    #  H I
    
    # matrix[:-1, :-1] is the submatrix excluding last row and column:
    #  A B
    #  D E

    # We compare these two slices element-wise:
    #  E == A?
    #  F == B?
    #  H == D?
    #  I == E?

    # For the matrix to have constant diagonals, all these must be True.

    return np.all(matrix[1:, 1:] == matrix[:-1, :-1])

