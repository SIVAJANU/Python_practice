# =====================================================
# Data Handling & Libraries
# Topics covered:
# 1. Working with JSON
# 2. Working with CSV
# 3. NumPy basics
# 4. Pandas basics
# 5. Matplotlib basics
# =====================================================

import json
import csv
from pathlib import Path

# =========================================
# 1) Working with JSON
# =========================================

# Write JSON
sample_data = {
    "name": "Alice",
    "age": 28,
    "city": "Delhi",
    "skills": ["Python", "SQL", "Power BI"]
}

json_path = Path("sample_data.json")
with open(json_path, "w", encoding="utf-8") as f:
    json.dump(sample_data, f, indent=2)

# Read JSON
with open(json_path, "r", encoding="utf-8") as f:
    loaded_data = json.load(f)

print("JSON loaded:", loaded_data)

# =========================================
# 2) Working with CSV
# =========================================

csv_path = Path("sample_data.csv")
rows = [
    ["Name", "Age", "City"],
    ["Alice", 28, "Delhi"],
    ["Bob", 32, "Mumbai"],
    ["Charlie", 25, "Bengaluru"],
]

with open(csv_path, "w", newline="", encoding="utf-8") as file:
    writer = csv.writer(file)
    writer.writerows(rows)

with open(csv_path, "r", newline="", encoding="utf-8") as file:
    reader = csv.reader(file)
    for row in reader:
        print("CSV row:", row)

# =========================================
# 3) NumPy basics
# =========================================

import numpy as np

arr = np.array([1, 2, 3, 4, 5])
print("NumPy array:", arr)
print("Mean:", arr.mean())
print("Sum:", arr.sum())
print("Squared:", np.square(arr))

matrix = np.array([[1, 2], [3, 4]])
print("Matrix:", matrix)
print("Matrix transpose:\n", matrix.T)

# =========================================
# 4) Pandas basics
# =========================================

import pandas as pd

student_data = {
    "Name": ["Alice", "Bob", "Charlie"],
    "Marks": [88, 76, 95],
    "City": ["Delhi", "Mumbai", "Bengaluru"]
}

student_df = pd.DataFrame(student_data)
print("\nPandas DataFrame:\n", student_df)
print("Average marks:", student_df["Marks"].mean())
print("Top marks:\n", student_df.sort_values("Marks", ascending=False))

# Read CSV with pandas
pandas_csv = pd.read_csv(csv_path)
print("\nCSV via pandas:\n", pandas_csv)

# =========================================
# 5) Matplotlib basics
# =========================================

import matplotlib.pyplot as plt

plt.plot([1, 2, 3, 4], [10, 20, 25, 30], marker='o')
plt.title("Sample Line Chart")
plt.xlabel("X Axis")
plt.ylabel("Y Axis")
plt.grid(True)
plt.show()

# Bar chart example
plt.bar(["A", "B", "C"], [10, 15, 12])
plt.title("Sample Bar Chart")
plt.show()

# =========================================
# Quick Summary
# =========================================

# - JSON and CSV are commonly used for data interchange.
# - NumPy is useful for numeric arrays and vectorized computing.
# - Pandas helps with tabular data analysis.
# - Matplotlib is useful for charting and visualizations.
