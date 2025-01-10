# Retail-Sales-Analysis-SQL-Project

## Project Overview

<strong> Project Title: Retail Sales Analysis </strong> <br>
<strong> Level: Beginner </strong> <br>

<p dir="auto">
This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.
</p>

## Objectives
<p dir="auto">
 <strong> 1. Set up a retail sales database:</strong> Create and populate a retail sales database with the provided sales data. <br>
 <strong> 2. Data Cleaning:</strong> Identify and remove any records with missing or null values.<br>
 <strong> 3. Exploratory Data Analysis (EDA):</strong> Perform basic exploratory data analysis to understand the dataset.<br>
 <strong> 4. Business Analysis:</strong> Use SQL to answer specific business questions and derive insights from the sales data.<br>
</p>

## Project Structure
<strong>1. Database Setup</strong>
<ul dir="auto">
<li>
<strong> Database Creation:</strong> The project starts by creating a database named <code>sql_project_1</code>.
</li>
<li>
<strong> Table Creation:</strong> A table named retail_sales is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.
</li>
</ul>

```sql
create database sql_project_1;
use sql_project_1;

-- Create Table
drop table if exists retail_sales;
create table retail_sales (
	transactions_id int primary key,
	sale_date date,
	sale_time time,
	customer_id int,
	gender varchar(15),
	age int,
	category varchar(15),
	quantiy int,
	price_per_unit float,
	cogs float,
	total_sale float
);
```

<strong>2. Data Exploration & Cleaning</strong>
<ul dir="auto">
<li>
<strong>Record Count:</strong> Determine the total number of records in the dataset.
</li>
<li>
<strong>Customer Count:</strong> Find out how many unique customers are in the dataset.
</li>
<li>
<strong>Category Count:</strong> Identify all unique product categories in the dataset.
</li>
<li>
<strong>Null Value Check:</strong> Check for any null values in the dataset and delete records with missing data.
</li>
</ul>

```sql
SELECT * FROM retail_sales
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
```

<strong>3. Data Analysis & Findings</strong>
<p dir="auto">The following SQL queries were developed to answer specific business questions:</p>
<ol dir="auto">
<li>
  <strong>Write a SQL query to retrieve all columns for sales made on '2022-11-05:</strong>
</li>
  
```sql
select * 
	from retail_sales
where sale_date = '2022-11-05';
```
<li><strong>Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:</strong></li>

```sql
select * 
	from retail_sales
where 
	category = 'Clothing' and 
	quantiy >= 3 and
	sale_date between '2022-11-01' and '2022-11-30'
order by sale_date;
```
<li><strong>Write a SQL query to calculate the total sales (total_sale) for each category.:</strong></li>

```sql
select 
	category, 
	sum(total_sale) as Total_Sale,
	count(quantiy) as Total_Order 
from retail_sales
group by 1;
```

<li><strong>Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:</strong></li>

```sql
select
	round(avg(age),2) as Average_Age 
from retail_sales
where 
category = 'Beauty';
```

<li><strong>Write a SQL query to find all transactions where the total_sale is greater than 1000.:</strong></li>

```sql
select * from retail_sales
where total_sale >= 1000;
```

<li><strong>Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:</strong></li>

```sql
select 
	category,
	gender,
	count(transactions_id) as Total_Transaction
from retail_sales
group by category, gender
order by 1;
```


<li><strong>Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:</strong></li>

```sql
select
	year(sale_date) as year,
	month(sale_date) as month,
	round(avg(total_sale),2) as AVG_sales,
    rank() over(partition by year(sale_date) order by avg(total_sale) desc) as rnk
from retail_sales
 group by 1,2
 ) as r_table
 where 
 rnk = 1;
```

<li><strong>Write a SQL query to find the top 5 customers based on the highest total sales:</strong></li>

```sql
select 
	customer_id, 
	sum(total_sale) as Total_sale
from retail_sales
group by 1
order by 2 desc
limit 5;
```


<li><strong>Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:</strong></li>

```sql
select 
	category,
	count(distinct(customer_id))
from retail_sales
group by 1;
```


<li><strong>Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):</strong></li>

```sql
with hourly_sale
as (
	select 
		case
			when hour(sale_time) <12 then 'Morning'
			when hour(sale_time) between 12 and 17 then 'Afternoon'
		else
			'Evening'
		end as Shift
	from retail_sales
)
select 
	shift,
	count(*) as total_orders
from hourly_sale
group by 1;

```
</ol>

## Findings

<ul dir="auto">
  <li><strong>Customer Demographics:</strong> The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.</li>
<li><strong>High-Value Transactions:</strong> Several transactions had a total sale amount greater than 1000, indicating premium purchases.</li>
<li><strong>Sales Trends:</strong> Monthly analysis shows variations in sales, helping identify peak seasons.</li>
<li><strong>Customer Insights:</strong> The analysis identifies the top-spending customers and the most popular product categories.</li>
</ul>

## Reports
<ul dir="auto">
  <li><strong>Sales Summary:</strong> A detailed report summarizing total sales, customer demographics, and category performance.</li>
 <li><strong>Trend Analysis:</strong> Insights into sales trends across different months and shifts.</li>
 <li><strong>Customer Insights:</strong> Reports on top customers and unique customer counts per category.</li>
</ul>

## Conclusion
<p dir="auto">
This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.
</p>
