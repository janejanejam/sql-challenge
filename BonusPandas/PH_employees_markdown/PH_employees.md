```python
# Import libraries and config
from sqlalchemy import create_engine
from config import username
from config import password
import pandas as pd
import matplotlib.pyplot as plt
from scipy import stats
import numpy as np
```


```python
# Connect to postgresql database
engine = create_engine(f'postgresql://{username}:{password}@localhost:5432/ph_employee_db')
connection = engine.connect()
```


```python
# Create pandas database from tables
departments_db = pd.read_sql_query('select * from "departments"', con=engine)
dept_manager_db = pd.read_sql_query('select * from "dept_manager"', con=engine)
dept_emp_db = pd.read_sql_query('select * from "dept_emp"', con=engine)
salaries_db = pd.read_sql_query('select * from "salaries"', con=engine)
titles_db = pd.read_sql_query('select * from "titles"', con=engine)
employees_db = pd.read_sql_query('select * from "employees"', con=engine)
```


```python
# Create a histogram to visualize the most common salary ranges for employees.
salaries = salaries_db['salary']

plt.hist(salaries)
plt.xlabel('Salaries')
plt.ylabel('Counts')
plt.show()
```


![png](output_3_0.png)



```python
# Calculate measures of central tendency for common salary ranges for employees.
mean_numpy = np.mean(salaries)
median_numpy = np.median(salaries)
mode_scipy = stats.mode(salaries)

print(f"The mean salary at Pewlett Hackard is ${round(mean_numpy):,}")
print(f"The median salary at Pewlett Hackard is ${round(median_numpy):,}")
print(f"The mode salary at Pewlett Hackard is {mode_scipy}")

```

    The mean salary at Pewlett Hackard is $52,971
    The median salary at Pewlett Hackard is $48,681.0
    The mode salary at Pewlett Hackard is ModeResult(mode=array([40000]), count=array([95346]))



```python
# Setup dataframes to create bar chart of avg salary by title

# Merge dataframes for salary, title and employee
employees_db2 = employees_db.rename(columns={'emp_title_id': 'title_id'})
salary_employees = employees_db2.merge(salaries_db, how = 'inner', on='emp_no')
salary_title_employees = salary_employees.merge(titles_db, how = 'inner', on='title_id')
salary_title_employees_2 = salary_title_employees[['title', 'salary']]

# Groupby title and calculate avg salary
groupby = salary_title_employees_2.groupby(['title']).mean()
groupby['salary'] = round(groupby['salary'])
groupby

```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>salary</th>
    </tr>
    <tr>
      <th>title</th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Assistant Engineer</th>
      <td>48564.0</td>
    </tr>
    <tr>
      <th>Engineer</th>
      <td>48535.0</td>
    </tr>
    <tr>
      <th>Manager</th>
      <td>51531.0</td>
    </tr>
    <tr>
      <th>Senior Engineer</th>
      <td>48507.0</td>
    </tr>
    <tr>
      <th>Senior Staff</th>
      <td>58550.0</td>
    </tr>
    <tr>
      <th>Staff</th>
      <td>58465.0</td>
    </tr>
    <tr>
      <th>Technique Leader</th>
      <td>48583.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
# Create a bar chart of average salary by title.

bar = groupby.plot(kind='bar', figsize=(10,6), color="blue", fontsize=10)
bar.set_title("Average Salary by Title", fontsize=22)
bar.set_xlabel("Titles", fontsize=15)
bar.set_ylabel("Salary", fontsize=15)
plt.show()
```


![png](output_6_0.png)



```python
# Epilogue
first_name = employees_db[employees_db.emp_no == 499942].first_name.values[0]
last_name = employees_db[employees_db.emp_no == 499942].last_name.values[0]

print(f"My badge id says my name as {first_name} {last_name}. My boss fooled me!")
      
```


```python

```


```python

```
