#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'connectedCell' function below.
#
# The function is expected to return an INTEGER.
# The function accepts 2D_INTEGER_ARRAY matrix as parameter.
#
def regionCount(matric, row, col):
    if any([row < 0, col < 0, row >= len(matrix), col >= len(matrix[0])]):
        return 0 
    
    if matrix[row][col] == 0:
        return  0
    
    cell_connected_count = 1
    matrix[row][col] = 0
    
    for r in range(row -1, row + 2):
        for c in range( col -1, col + 2):
            if any([r != row, c != col]):
                cell_connected_count += regionCount(matrix, r , c)
            
    return cell_connected_count
def connectedCell(matrix):
    # Write your code here
    max_cell_counter = 0
    
    for row in range(len(matrix)):
        for col in range(len(matrix[0])):
            if matrix[row][col] == 1:
                current_cell_counter = regionCount(matrix, row, col)
                max_cell_counter = max(max_cell_counter, current_cell_counter)
    return max_cell_counter

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    n = int(input().strip())

    m = int(input().strip())

    matrix = []

    for _ in range(n):
        matrix.append(list(map(int, input().rstrip().split())))

    result = connectedCell(matrix)

    fptr.write(str(result) + '\n')

    fptr.close()
