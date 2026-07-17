# sequence or ordered collection of items. 
# It is a mutable data structure that can hold elements 
# of different data types, including other lists. 
# Lists are defined by enclosing elements in square brackets [] 
# and separating them with commas.
num=1
float_num=1.5
string="Hello"  
bolean=True
list_1=[num,float_num,string,bolean]


# tuples are immutable, ordered collections of items.
# tuples are defined by enclosing elements in parentheses () and 
# separating them with commas. 
# tuples can hold elements of different data types, including other tuples.
tuple_1=(num,float_num,string,bolean)

print("List:", list_1)
print("List length of elements in it:", len(list_1))
   
print("Tuple:", tuple_1) 
print("Tuple length of elements in it:", len(tuple_1)) 

# short cut to comment multiple lines in python is ctrl + /

# what is ordered collections of items in list and tuple?
# In both lists and tuples, the order of elements is preserved. 
# This means that the elements are stored in a specific sequence, and you can access
# them using their index positions. 

"""
 what is indexing in list and tuple?
Indexing is a way to access individual elements in a list or tuple using their 
position. """

print(list_1[0])  # Accessing the first element of the list
print(tuple_1[1])     # Accessing the second element of the tuple

list_1[0] = 10  # Modifying the first element of the list
print("Modified List:", list_1)

# difference between list and tuple is that lists are mutable, 
# meaning you can change their elements, 
# while tuples are immutable, meaning their elements cannot be changed after creation.

#tuple_1[0] = 10  # This will raise an error because tuples are immutable

tuple_2 = (1, 2, 3, 4, 5)
list_2= list(tuple_2)  # Converting tuple to list
print("Converted List:", list_2)
list_2[0] = 10  # Modifying the first element of the converted list format of tuple
print("Modified Converted List:", list_2)

# range() function is used to generate a sequence of numbers.
# It can take one, two, or three arguments: start, stop, and step.  
# ragne function returns a range object, which can be converted to a
# list or tuple if needed.
# range(start, stop, step)

for i in list_1:
    print(i)  # Iterating through the list and printing each element

