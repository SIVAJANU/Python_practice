from My_Package_1 import my_module,my_module_2
##
print(my_module.add(5, 6))  # Output: 11
print(my_module.greet("Siva"))  # Output: Hello, Siva!
try:
    print(my_module.multiply(5, 6))  # Output: 30
except AttributeError:
    print("Print error: multiply function is not available in my_module.")
finally:
    print("This is the end of the test for my_module.")


print(my_module_2.subtract(10, 4))  # Output: 6