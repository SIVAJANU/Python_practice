list_1=[1, 'siva', 3.5, True, 3, 4,88,100.5]
print("List:", list_1)
# using indexing to access elements in the list
# print(list_1[0])  # Printing the first element of the list
# print(list_1[1])  # Printing the second element of the list
# print(list_1[2])  # Printing the third element of the list      
# print(list_1[3])  # Printing the fourth element of the list
# print(list_1[4])  # Printing the fifth element of the list
# print(list_1[5])  # Printing the sixth element of the list
# print(list_1[6])  # Printing the seventh element of the list
# print(list_1[7])  # Printing the eighth element of the list

for i in list_1:
    #print('iteration number is :', i)  # Iterating through the list and printing each element
    print(i)  # Iterating through the list and printing each element

# Len=len(list_1)  # Getting the length of the list
# print("Length of the list:", Len)

# print("Range of numbers:", range(10))  # Printing a range of numbers from 0 to 9

count_3 = list_1.count(3)  # Counting the occurrences of the number 3 in the list
print("Count of 3 in the list:", count_3)

# difference between extend() and append() methods in list
list_2 = [5, 6, 7]      
# append() adds its argument as a single element to the end of a list. The length of the list itself will increase by one.
list_1.append(list_2)  # Appending list_2 to list_1
# extend() iterates over its argument adding each element to the list, extending the list. The length of the list will increase by however many elements were in the iterable argument.
list_1.extend(list_2)  # Extending list_1 with elements from list_2
print("List after append and extend:", list_1)  # Printing the modified list    
