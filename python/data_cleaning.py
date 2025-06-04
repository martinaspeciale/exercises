import pandas as pd

# Sample data cleaning
df = pd.DataFrame({
    'name': ['Alice', 'Bob', None],
    'age': ['25', 'thirty', '40']
})

df['name'].fillna('Unknown', inplace=True)
df['age'] = pd.to_numeric(df['age'], errors='coerce')
print(df)
