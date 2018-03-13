# -*- coding: utf-8 -*-
"""
Created on Sat Feb 06 20:35:49 2016

@author: Andrew
"""

def sortwithloops(input):
    for i in range(len(input)):
        for j in range(len(input)-1-i):
            if input[j] > input[j+1]:
                input[j], input[j+1] = input[j+1],input[j]
    return input

def sortwithoutloops(input):
    return sorted(input)

def searchwithloops(input, value):
    for x in input:
        if x == value:
            return True
    return False

def searchwithoutloops(input, value):
    if value in input:
        return True
    return False

if __name__ == "__main__":	
    L = [5,3,6,3,13,5,6]	

    print sortwithloops(L) # [3, 3, 5, 5, 6, 6, 13]
    print sortwithoutloops(L) # [3, 3, 5, 5, 6, 6, 13]
    print searchwithloops(L, 5) #true
    print searchwithloops(L, 11) #false
    print searchwithoutloops(L, 5) #true
    print searchwithoutloops(L, 11) #false
