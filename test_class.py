class Name:
    def __init__(self, name, age):
        self.name = name
        self.age = age
    def get_names(self):
        return self.name
# calling the class and assigning the class atributes to the object
name1=Name('Siva',22)
print(name1.name,name1.age)

dict1={'name':['Siva','ravi','Latha'],'age':[22,25,100]}
print('names of people:',dict1['name'])

for i in range(len(dict1['name'])):
    name_obj=Name(dict1['name'][i],dict1['age'][i]) # Name(Siva,22) Name(ravi,25) Name(Latha,100)
    #print(name_obj.get_names(),name_obj.age)

# write for loop in the class to get the names and ages of people from the dictionary
class NameList:
    def __init__(self, name_dict):
        self.name_dict = name_dict

    def get_names_and_ages(self):
        for i in range(len(self.name_dict['name'])):
            name_obj = Name(self.name_dict['name'][i], self.name_dict['age'][i])
            print(name_obj.get_names(), name_obj.age)

name_list = NameList(dict1)
name_list.get_names_and_ages()  

# class vs functions difference
# class is a blueprint for creating objects, while functions are blocks of code that perform specific tasks.
# Classes can contain multiple methods (functions) and attributes (data), allowing for encapsulation and 
# organization of related functionality. Functions, on the other hand, are standalone and can be called 
# independently without the need for an object.

# functions are used to perform specific tasks, 
# while classes are used to create objects that can have their own state and behavior. 
# Functions can be called multiple times with different inputs, 
# while classes can be instantiated multiple times to create different objects with their own 
# unique attributes and methods.
