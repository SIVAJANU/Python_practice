def decarator(func):
    def wrapper(name):
        print(f"Calling {func.__name__} with name={name}")
        result = func(name)
        print(f"{func.__name__} returned {result}")
        return result
    return wrapper

@decarator
def test(name):
    print(f"Inside test function with name={name}")
    return f"Hello, {name}!"

test("Alice")
