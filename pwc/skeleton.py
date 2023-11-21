#!/usr/bin/env python

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(arr):
    print(f'Input: @arr = ({comma_join(arr)})')
    print(f'Output: ({comma_join(arr)})')

print('Example 1:')
solution()

print('\nExample 2:')
solution()

print('\nExample 3:')
solution()