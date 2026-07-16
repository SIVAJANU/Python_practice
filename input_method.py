name_candidate=input('Enter name of person:')
print(f'Hello welcome to session: {name_candidate}')
print(f'Length of the name is: {len(name_candidate)}')
age_candidate=int(input('Enter age of person:'))
if age_candidate>=18:      
    print(f'Hello {name_candidate}, you are eligible for voting.')  