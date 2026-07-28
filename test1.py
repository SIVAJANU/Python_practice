
name_list=['Siva','Harish','Sudeep','Ramesh','naresh','Harsha'] # source systems facebook/instagram/swiggy databeses
name_2='Priya'
for name in name_list:
    if name=='Siva' or name=='Hari':
        for i in name_list:
            print(i)
            print('--------------------------------------',name)
            print('Welcome with buque')
    elif name=='Sudeep' or name=='Harish':
        print('--------------------------------------',name)
        print('Hey how are you...!!')
        age=input('Ask his age:')
        mobile_number=input('Ask his mobile number')
        # offer coupons list and percentage of discounts
        discount=input('How much discount i can give')
        print(f'Give him {discount} percentage discount')
        list_user_details=[age,mobile_number,discount]
        print('list_user_details',list_user_details)  
    elif name=='Harsha' and name_2=='Priya':
        print('--------------------------------------',name)
        print('Happy married life...............💕💕💕💕💕💕💕👍👍👍👍👍😍😍😍')
    else:
        print('--------------------------------------',name)
        print('Dont allow them..STOP')