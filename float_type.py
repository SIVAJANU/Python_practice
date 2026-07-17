num=5.5
print(num.is_integer())

# datatype casting
num = 5.2
print(num)  # Output: 5.2
num2=int(num)  # casting float to int
print(num2)  # Output: 5 data loss of decimal part ---> high level to low level data type conversion


import math

# Let's use a float that is close to the next number up
my_float = 8.7

print("Original float:", my_float)

# 1. int() - just chops off the .7
number_int = int(my_float)
print("Using int():", number_int)

# 2. round() - rounds up to 9 because .7 is closer to 9
number_round = round(my_float)
print("Using round():", number_round)

# 3. math.floor() - forces it down to 8
number_floor = math.floor(my_float)
print("Using math.floor():", number_floor)

# 4. math.ceil() - forces it up to 9
number_ceil = math.ceil(my_float)
print("Using math.ceil():", number_ceil)