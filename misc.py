# int, str, bool, list, tuple, -----> variables
var_1=10  # Integer variable
var_2="Hello"  # String variable    

list_1=[1, 'siva', 3.5, True, 3, 4,88,100.5]  # List variable
list_1.append([11,22,33])  # Appending a new list to list_1
print("List after appending a new list:", list_1)  # Printing the modified list
# output: List after appending a new list: [1, 'siva', 3.5, True, 3, 4, 88, 100.5, [11, 22, 33]]
print("Length of the list after appending:", len(list_1))  # Printing the length of the modified list
list_1.extend([44,55,66])  # Extending list_1 with new elements
print("List after extending with new elements:", list_1)  # Printing the modified list
print("Length of the list after extending:", len(list_1))  # Printing the length of the modified list

print(list_1[8][0])  # Accessing the newly appended list at index 8 




