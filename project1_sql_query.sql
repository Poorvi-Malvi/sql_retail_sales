-- Sql Retail Project 1 --
create database sql_project;

drop table if exists retail_sales;
create table retail_sales
(
	transactions_id int primary key,
	sale_date date,
	sale_time time,	
    customer_id	int,
    gender varchar(15),
    age int,
	category varchar(15),
	quantiy	int,
    price_per_unit float,
	cogs float,
	total_sale float
);

select * from retail_sales
limit 5

select count(*) from retail_sales

-- Data Exploration --

-- how many sales we have?--
select count(*) as total_sale from retail_sales

-- how many unique customers do we have? --
select count(distinct customer_id) as total_sale from retail_sales

-- how many category we have? --
select distinct category from retail_sales

-- Data Analysis & business key problems--
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing'
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q1 --
select *
from retail_sales
where sale_date='2022-11-05';

-- Q2--
SELECT *
from retail_sales
where category='clothing'
AND 
quantiy>=4

-- Q3--
select category, 
sum(total_sale) as net_sale,
count(*) as total_orders
from retail_sales
group by 1

-- Q4--
select
ROUND(AVG(age),2) as avg_age
from retail_sales
where category='Beauty'

-- Q5--
SELECT * FROM retail_sales
where total_sale >1000

-- Q6--
SELECT category, gender,
count(*) as total_trans
 FROM retail_sales
group by category, gender
group by 1

-- Q7--
SELECT 
EXTRACT(year from sale_date) as year,
EXTRACT( month from sale_date) as month,
avg(total_sale) as avg_sales
 FROM retail_sales
 group by 1,2
 ORDER BY 1,3 DESC
 
 -- Q8--
 SELECT 
 customer_id ,
 sum(total_sale) as sales
 FROM retail_sales
group by 1
order by 2 desc
limit 5

-- Q9--
SELECT 
category, count(distinct customer_id) as uni_customer
 FROM retail_sales
 group by category
 
 -- Q10--
 
 WITH hourly_sales
 as
 (
 SELECT *,
 CASE
 WHEN EXTRACT(HOUR FROM sale_time) < 12  THEN 'Morning'
 WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
 ELSE 'Evening'
 END AS shift
 FROM retail_sales
)
SELECT 
shift,
count(*) as total_orders
from hourly_sale
group by shift





