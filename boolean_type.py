# bool and float
x = True
y = 3.14
z = False

time_now= 19 #am

if time_now >18:
    print("Turn off AC in school calssrooms")
    
# Use Case: Checking if a customer qualifies for a special discount
# tenure_of_employee= sql.fetch_tenure() # fetched from database
# member_in_company_duration=tenure_of_employee
# if member_in_company_duration>=5:  # assuming 5 years is the threshold
#     is_member = True
is_member = True
has_coupon = False

# 'and' requires BOTH to be True
print("Gets VIP discount?", is_member and has_coupon)

# 'or' requires AT LEAST ONE to be True
print("Gets standard discount?", is_member or has_coupon)

# 'not' reverses the Boolean
print("Is NOT a member?", not is_member)

print('Verify the numbers are equal or not using == operator:',2==2)  # True
print('Verify the numbers are equal or not using != operator:',2!=2)  # False
print('Verify the numbers are equal or not using > operator:',2>2)   # False
print('Verify the numbers are equal or not using < operator:',2<2)   # False
print('Verify the numbers are equal or not using >= operator:',2>=2)  # True
print('Verify the numbers are equal or not using <= operator:',2<=2)  # True