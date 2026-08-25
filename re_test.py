import re

text = "Contact amit@example.com and support@company.org"
pattern = r"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}"

matches = re.findall(pattern, text)
print(matches)

print(bool(re.fullmatch(pattern, 'amit@example.com')))
print(re.sub(r'\s+', ' ', 'Python   regex   example'))
