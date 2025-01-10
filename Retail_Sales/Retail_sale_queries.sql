-- SQL Retail Sales Analysis
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

select * from retail_sales;

-- Data Cleaning
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
    
-- Data Exploration

-- How many sales we have?
SELECT 
	COUNT(*) as total_sale 
FROM retail_sales;

-- How many uniuque customers we have ?

SELECT 
	COUNT(DISTINCT customer_id) as Total_Sale 
FROM retail_sales;

-- How many uniuque Categories we have ?

select distinct category from retail_sales;

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select * 
	from retail_sales
where sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
select * 
	from retail_sales
where 
	category = 'Clothing' and 
	quantiy >= 3 and
	sale_date between '2022-11-01' and '2022-11-30'
order by sale_date;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select 
	category, 
	sum(total_sale) as Total_Sale,
	count(quantiy) as Total_Order 
from retail_sales
group by 1;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select
	round(avg(age),2) as Average_Age 
from retail_sales
where 
category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select 
	* 
from retail_sales
where 
total_sale >= 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select 
	category,
	gender,
	count(transactions_id) as Total_Transaction
from retail_sales
group by category, gender
order by 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select year,month,AVG_sales from
(
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

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select 
	customer_id, 
	sum(total_sale) as Total_sale
from retail_sales
group by 1
order by 2 desc
limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select 
	category,
	count(distinct(customer_id))
from retail_sales
group by 1;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
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

