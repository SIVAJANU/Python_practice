# =====================================================
# 12. Expert-Level Topics
# Topics covered:
# 1. AsyncIO (asynchronous programming)
# 2. Memory optimization techniques
# 3. Design patterns in Python
# 4. Type hinting (typing module)
# 5. Packaging Python applications (setup.py, pip install)
# 6. Deploying Python projects
# =====================================================

# =========================================
# 1) AsyncIO
# =========================================

import asyncio

async def fetch_data(name, delay):
    await asyncio.sleep(delay)
    return f"{name} completed after {delay} seconds"

async def main():
    tasks = [
        fetch_data("Task1", 1),
        fetch_data("Task2", 2),
        fetch_data("Task3", 0.5)
    ]
    results = await asyncio.gather(*tasks)
    print(results)

asyncio.run(main())

# =========================================
# 2) Memory optimization techniques
# =========================================

# Use generators to avoid storing huge sets of objects in memory.

def generate_numbers():
    for i in range(1, 1000000):
        yield i

# Consume lazily instead of building a full list.
for x in generate_numbers():
    if x > 5:
        break
    print(x)

# Avoid unnecessary copies and store only needed data.

# =========================================
# 3) Design patterns in Python
# =========================================

# Singleton pattern example
class Singleton:
    _instance = None

    def __new__(cls):
        if cls._instance is None:
            cls._instance = super().__new__(cls)
        return cls._instance

s1 = Singleton()
s2 = Singleton()
print("Singleton objects same:", s1 is s2)

# Factory pattern example
class Dog:
    def speak(self):
        return "Woof!"

class Cat:
    def speak(self):
        return "Meow!"

class AnimalFactory:
    @staticmethod
    def create(animal_type):
        if animal_type == "dog":
            return Dog()
        if animal_type == "cat":
            return Cat()
        raise ValueError("Unknown animal type")

animal = AnimalFactory.create("dog")
print(animal.speak())

# =========================================
# 4) Type hinting (typing module)
# =========================================

from typing import List, Dict, Optional, Tuple


def add_numbers(a: int, b: int) -> int:
    return a + b


def get_user() -> Dict[str, Optional[str]]:
    return {"name": "Alice", "email": None}


def process_items(items: List[int]) -> Tuple[int, int]:
    return sum(items), len(items)

print(add_numbers(3, 4))
print(get_user())
print(process_items([1, 2, 3, 4]))

# =========================================
# 5) Packaging Python applications
# =========================================

# Example setup.py snippet:
#
from setuptools import setup, find_packages

setup(
    name="myapp",
    version="0.1.0",
    packages=find_packages(),
    install_requires=[]
)

# Then install via:
# pip install .
# or
# pip install -e .

# =========================================
# 6) Deploying Python projects
# =========================================

# Common deployment options:
# - Web apps: Heroku, Render, Railway, Azure App Service
# - APIs: FastAPI / Flask on cloud servers
# - Containers: Docker + Kubernetes
# - Serverless: AWS Lambda, Azure Functions
#
# Example commands:
# pip install fastapi uvicorn
# uvicorn app:app --host 0.0.0.0 --port 8000

# =========================================
# Quick Summary
# =========================================

# - AsyncIO allows efficient concurrent I/O workflows.
# - Memory optimization reduces unnecessary usage and helps large-scale apps.
# - Design patterns improve code maintainability.
# - Type hints increase clarity and tooling support.
# - Packaging and deployment help ship apps for real-world use.
