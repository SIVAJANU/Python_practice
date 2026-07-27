import os

print("This is a list practice program.")
def clear_terminal():
    # Use 'cls' for Windows, 'clear' for Mac and Linux
    os.system('cls' if os.name == 'nt' else 'clear')

# Call the function
clear_terminal()

list_1=[1,1,2,2,3,3,4,4,5,5,6,6,6,6,6,6]
# get the unique elements from the list
unique_elements = list(set(list_1))
print(unique_elements)  # [1, 2, 3, 4, 5, 6]  

for i in list_1:
    print(i, end=" ")  # Printing each element in list_1 on the same line
print('test...............')
print("Length of the list:", len(list_1))  # Printing the length of list_1
clear_terminal() 
print(range(len(list_1))) # output: range(0, 16)
print("Range of numbers:", list(range(len(list_1))))  # Printing a range of numbers from 0 to 15
for i in range(len(list_1)):
    print('iteration index number is :', i)  # Iterating through the range of indices and printing each index
    print(list_1[i])  # Printing each element in list_1 using indexing on the same line
# duplicate elements in the list
duplicates = []
list_1=[1,1,2,2,3,3,4,4,5,5,6,6,6,6,6,6]
list_2 = []
for i in list_1:
    if i not in list_2:  
        list_2.append(i)  # Adding unique elements to list_2
    else:
        duplicates.append(i)  # Adding duplicate elements to duplicates list  
print("Duplicate elements in the list:", duplicates)  # Printing the duplicate elements
print("Unique elements in the list:", list_2)  # Printing the unique elements
bool_flag=len(duplicates)+len(list_2)==len(list_1)
print(bool_flag)  # Printing the boolean flag indicating if the lengths match
if bool_flag:
    print("The lengths match, the list has been processed correctly.")  # Printing a message if the lengths match

clear_terminal()
num_list=[2,4,8,10]
num_squared=[x**2 for x in num_list]  # Using list comprehension to square each element in num_list
print("Squared numbers:", num_squared)  # Printing the squared numbers
list_3=[]
for i in num_list:
    #print(f' other type {i**2}')# Printing the square of each element in num_list on the same line
    list_3.append(i**2)  # Appending the square of each element to list_3
print("List of squared numbers:", list_3)  # Printing the list of squared numbers

list_unique=[ list_2.append(x)  for x in list_1 if x not in list_2]
print("Unique elements using list comprehension:", list_2)  # Printing the unique elements using list comprehension
list_unique=[]
list_unique_2=[ list_unique.append(x)  for x in list_1 if x in list_unique]
print("Length of the unique elements list:", list_unique)  # Printing the length of the unique elements list