# ==========================================
# PYTHON OPERATORS PRACTICE PLAYGROUND
# Run this script to see all operators in action!
# ==========================================

# --- 1. ARITHMETIC OPERATORS ---
# Used for mathematical calculations
x = 10
y = 3

print("--- 1. Arithmetic Operators ---")
print(f"Addition (x + y):        {x + y}")        # 13
print(f"Subtraction (x - y):     {x - y}")        # 7
print(f"Multiplication (x * y):  {x * y}")        # 30
print(f"Division (x / y):        {x / y}")        # 3.3333333333333335 (always float)
print(f"Floor Division (x // y): {x // y}")       # 3 (rounds down, drops decimal)
print(f"Modulus (x % y):         {x % y}")        # 1 (remainder of 10 / 3)
print(f"Exponentiation (x ** y): {x ** y}\n")     # 1000 (10 cubed)


# --- 2. RELATIONAL OPERATORS ---
# Used to compare values; always returns True or False
a = 15
b = 20

print("--- 2. Relational Operators ---")
print(f"Equal to (a == b):              {a == b}")   # False
print(f"Not equal to (a != b):          {a != b}")   # True
print(f"Greater than (a > b):           {a > b}")    # False
print(f"Less than (a < b):              {a < b}")    # True
print(f"Greater than or equal (a >= 15): {a >= 15}") # True
print(f"Less than or equal (a <= b):    {a <= b}\n") # True


# --- 3. LOGICAL OPERATORS ---
# Used to combine multiple conditional statements
age = 25
has_license = True

print("--- 3. Logical Operators ---")
print(f"Logical AND (age > 18 and has_license): {age > 18 and has_license}") # True (both true)
print(f"Logical OR (age < 18 or has_license):   {age < 18 or has_license}")   # True (one is true)
print(f"Logical NOT (not has_license):          {not has_license}\n")          # False (inverts True)


# --- 4. ASSIGNMENT OPERATORS ---
# Used to assign or modify variable values
num = 5

print("--- 4. Assignment Operators ---")
num += 3
print(f"Add & Assign (num += 3):       {num}")  # 8 (same as num = num + 3)

num *= 2
print(f"Multiply & Assign (num *= 2):  {num}")  # 16 (same as num = num * 2)

num /= 4
print(f"Divide & Assign (num /= 4):    {num}\n") # 4.0 (same as num = num / 4)


# --- 5. IDENTITY OPERATORS ---
# Checks if variables point to the exact same object in memory
list_a = [1, 2, 3]
list_b = [1, 2, 3]
list_c = list_a

print("--- 5. Identity Operators ---")
print(f"Value Equality Check (list_a == list_b): {list_a == list_b}") # True (contents match)
print(f"Identity Check IS (list_a is list_b):    {list_a is list_b}") # False (different memory locations)
print(f"Identity Check IS (list_a is list_c):    {list_a is list_c}") # True (same memory object)
print(f"Identity Check IS NOT (list_a is not b): {list_a is not list_b}\n") # True


# --- 6. MEMBERSHIP OPERATORS ---
# Checks if a value exists within a sequence (list, string, tuple, etc.)
fruits = ["apple", "banana", "cherry"]
message = "Hello World"

print("--- 6. Membership Operators ---")
print(f"Is 'banana' in fruits list?     {'banana' in fruits}")       # True
print(f"Is 'orange' not in fruits list? {'orange' not in fruits}")   # True
print(f"Is 'W' in 'Hello World' string? {'W' in message}")           # True
