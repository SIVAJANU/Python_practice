# You tie a string named 'x' to a new balloon containing "Hello"
x = "Hello"  # Reference count = 1

# You tie a second string named 'y' to the same balloon
y = x        # Reference count = 2

# You cut the string 'x'
del x        # Reference count = 1
print("Reference count example:", y)  # This will raise an error because 'x' is deleted
# You cut the string 'y'. Count hits 0! 
del y        # Python instantly destroys the balloon and frees memory.
print("Garbage collection executed",y)  # This will raise an error because 'y' is deleted
