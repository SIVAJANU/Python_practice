# =====================================================
# 11. Specialized Topics
# Topics covered:
# 1. Functional programming (map, filter, reduce, functools)
# 2. Date & Time handling (datetime, time)
# 3. OS interaction (os, shutil, subprocess)
# 4. Web requests (requests)
# 5. Unit testing (unittest, pytest)
# =====================================================

# =========================================
# 1) Functional programming
# =========================================

from functools import reduce

nums = [1, 2, 3, 4, 5]
print("Map:", list(map(lambda x: x * 2, nums)))
print("Filter:", list(filter(lambda x: x % 2 == 0, nums)))
print("Reduce:", reduce(lambda a, b: a + b, nums))

from functools import wraps

def decorator(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        print(f"Calling {func.__name__}")
        return func(*args, **kwargs)
    return wrapper

@decorator
def greet(name):
    return f"Hello {name}"

print(greet("Alice"))

# =========================================
# 2) Date & Time handling
# =========================================

from datetime import datetime, timedelta
import time

now = datetime.now()
print("Current datetime:", now)
print("Formatted:", now.strftime("%d-%m-%Y %H:%M:%S"))

future = now + timedelta(days=5)
print("Future date:", future)

print("Sleep for 1 second")
time.sleep(1)

# =========================================
# 3) OS interaction
# =========================================

import os
import shutil
import subprocess

print("Current working directory:", os.getcwd())
print("Files in current folder:", os.listdir())

# Create a sample dir and file
os.makedirs("demo_folder", exist_ok=True)
with open("demo_folder/sample.txt", "w", encoding="utf-8") as f:
    f.write("This file was created using Python OS module")

# Copy file
shutil.copy("demo_folder/sample.txt", "demo_folder/sample_copy.txt")
print("Copied file exists:", os.path.exists("demo_folder/sample_copy.txt"))

# Run a shell command
result = subprocess.run(["python", "--version"], capture_output=True, text=True)
print("Python version:", result.stdout.strip())

# =========================================
# 4) Web requests
# =========================================

import requests

response = requests.get("https://api.github.com")
print("Status code:", response.status_code)
print("Response type:", response.headers.get("content-type"))

# =========================================
# 5) Unit testing
# =========================================

# Example test file would be created separately, e.g. test_specialized_topics.py
# Example:
# import unittest
# class TestMath(unittest.TestCase):
#     def test_add(self):
#         self.assertEqual(2 + 2, 4)
#
# if __name__ == "__main__":
#     unittest.main()

# Pytest command:
# pytest -q

# =========================================
# Quick Summary
# =========================================

# - Functional programming makes code shorter and declarative.
# - datetime and time help with scheduling and timestamps.
# - os, shutil, and subprocess handle filesystem and external commands.
# - requests is used for HTTP interactions.
# - Unit testing ensures correctness and reliability.
