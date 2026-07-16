name='Sai ram'
s='Hi, ' + name
print(s)
s = ''.join(['Hi, ', name, ' welcome to the session'])
print(s)

reverse_name=name[::-1]
print("Reversed name:", reverse_name)

# write a for loop to reverse the name and print it
reversed_name_r = ''  
for char in name:
    reversed_name_r = char + reversed_name_r    
print("Reversed name using for loop:", reversed_name_r)
