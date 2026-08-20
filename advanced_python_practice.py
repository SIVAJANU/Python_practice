# =====================================================
# Advanced Python Practice
# Topics covered:
# 1. Iterators & Generators (yield) [1,2,3,4,5,6,7,8,9,10] 
# 2. Decorators
# 3. Context managers (with)
# 4. Regular Expressions (re module)
# 5. Logging
# 6. Virtual environments (venv)
# 7. Multithreading & Multiprocessing
# 8. Memory management & garbage collection
# =====================================================

# =========================================
# 1) Iterators & Generators (yield)
# =========================================

# Iterator example
class MyIterator:
    def __init__(self, data):
        self.data = data
        self.index = 0

    def __iter__(self):
        return self

    def __next__(self):
        if self.index >= len(self.data):
            raise StopIteration
        value = self.data[self.index]
        self.index += 1 
        return value

it = MyIterator([10, 20, 30])
print("Iterator output:")
for x in it:
    print(x)

# Generator example using yield

def square_numbers(n):
    for i in range(1, n + 1):
        yield i * i

print("Generator output:")
for sq in square_numbers(5):
    print(sq)

# Generator expression
print("Generator expression:")
nums = (x * 2 for x in range(1, 6))
for n in nums:
    print(n)

# =========================================
# 2) Decorators
# =========================================

# Decorator example: logging function execution

def debug_decorator(func):
    def wrapper(*args, **kwargs):
        print(f"Calling {func.__name__} with args={args}, kwargs={kwargs}")
        result = func(*args, **kwargs)
        print(f"{func.__name__} returned {result}")
        return result
    return wrapper

@debug_decorator
def add(a, b):
    return a + b

print("Decorator output:")
print(add(3, 4))

# Decorator with arguments

def repeat(times):
    def decorator(func):
        def wrapper(*args, **kwargs):
            for _ in range(times):
                result = func(*args, **kwargs)
            return result
        return wrapper
    return decorator

@repeat(3)
def greet(name):
    print(f"Hello, {name}!")

print("Repeat decorator output:")
greet("Alice")

# =========================================
# 3) Context managers (with)
# =========================================

# Custom context manager using class

class FileManager:
    def __init__(self, filename, mode):
        self.filename = filename
        self.mode = mode
        self.file = None

    def __enter__(self):
        self.file = open(self.filename, self.mode)
        return self.file

    def __exit__(self, exc_type, exc_value, traceback):
        if self.file:
            self.file.close()
        return False

with FileManager("sample_context.txt", "w") as f:
    f.write("This is written using a context manager.\n")

# Context manager using contextlib
from contextlib import contextmanager

@contextmanager
def open_file(path, mode):
    f = open(path, mode)
    try:
        yield f
    finally:
        f.close()

with open_file("sample_context2.txt", "w") as f:
    f.write("Using contextlib manager.\n")

# =========================================
# 4) Regular Expressions (re module)
# =========================================

import re

text = "Contact us at amit@example.com or support@company.org"
pattern = r"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}"

matches = re.findall(pattern, text)
print("Regex matches:", matches)

email = "amit@example.com"
print("Is valid email?", bool(re.fullmatch(pattern, email)))

# Replace patterns
clean = re.sub(r"\s+", " ", "Python   regex    demo")
print("Cleaned string:", clean)

# Search pattern
if re.search(r"example", text):
    print("Found example domain in text")

# =========================================
# 5) Logging
# =========================================

import logging

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

logging.info("This is an info message")
logging.warning("This is a warning message")
logging.error("This is an error message")

# Custom logger example
logger = logging.getLogger("custom_logger")
logger.setLevel(logging.DEBUG)

handler = logging.StreamHandler()
handler.setFormatter(logging.Formatter('%(levelname)s:%(name)s:%(message)s'))
logger.addHandler(handler)

logger.debug("Debug message from custom logger")
logger.info("Info message from custom logger")

# =========================================
# 6) Virtual environments (venv)
# =========================================

# Virtual environment commands
# python -m venv myenv
# .\myenv\Scripts\activate
# pip install flask
# deactivate

# Notes:
# - Keeps dependencies isolated per project
# - Avoids version conflicts between projects
# - Recommended for all Python projects

# =========================================
# 7) Multithreading & Multiprocessing
# =========================================

import threading
import multiprocessing
import time

# Multithreading example

def worker(name):
    print(f"Thread {name} started")
    time.sleep(1)
    print(f"Thread {name} finished")

threads = [threading.Thread(target=worker, args=(f"T{i}",)) for i in range(3)]
print("Starting threads:")
for t in threads:
    t.start()
for t in threads:
    t.join()

# Multiprocessing example

def square(x):
    return x * x

with multiprocessing.Pool(processes=3) as pool:
    result = pool.map(square, [1, 2, 3, 4, 5])
    print("Multiprocessing result:", result)

# Notes:
# - Threading is useful for I/O-bound tasks
# - Multiprocessing is useful for CPU-bound tasks
# - GIL limits CPU parallelism in CPython threads

# =========================================
# 8) Memory management & garbage collection
# =========================================

import gc

# Creating objects
x = [1, 2, 3]
y = x

print("Reference count example:")
print("x is y:", x is y)

# Delete object reference
x = None

gc.collect()
print("Garbage collection executed")

# Simple memory-related example
nums = [i for i in range(100000)]
print("List length:", len(nums))

# Notes:
# - Python manages memory automatically via reference counting and cyclic GC
# - gc module can trigger collection manually
# - Avoid reference cycles and large unnecessary object retention

# =========================================
# Quick Summary
# =========================================

# Iterators and generators help process data lazily.
# Decorators modify or extend function behavior.
# Context managers ensure resource cleanup automatically.
# Regular expressions help pattern matching and validation.
# Logging helps monitor and debug applications.
# Virtual environments isolate project dependencies.
# Multithreading and multiprocessing improve concurrency for different workloads.
# Garbage collection and memory awareness are important for efficient programs.
