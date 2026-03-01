create database sql_sales_project;
CREATE TABLE retailsales
     (
		transactions_id INT,
		sale_date DATE,
		sale_time TIME,
		customer_id INT,
		gender VARCHAR(15),
		age INT,
        category VARCHAR(15),
		quantity INT,
		price_per_unit FLOAT,	
		cogs FLOAT,
		total_sale FLOAT
	);
    select * from retailsales;
    
    
SELECT * FROM retailsales
WHERE transactions_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR gender IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;

#data exploration 
#how many sales we have?
SELECT COUNT(*) AS total_sale FROM retailsales;

#how many unique customers we have?
SELECT COUNT(DISTINCT customer_id) AS total_sale 
FROM retailsales;

SELECT DISTINCT category FROM retailsales;

#data analysis & business key problems & answers

 #Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
 SELECT * 
 FROM retailsales
 WHERE sale_date = '2022-11-05';
 
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than  in the month of Nov-2022
SELECT * FROM retailsales
WHERE category = 'Clothing' AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
 AND quantity >= 4;

-- Q.3 Write a SQL query to calculate the total sales  for each category.
SELECT category, SUM(total_sale) AS net_sale
FROM retailsales
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
SELECT ROUND(AVG(age),2) AS avg_age 
FROM retailsales
WHERE category = 'beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retailsales
WHERE total_sale>1000;

-- Q.6 Write a SQL query to find the total number of transactions made by each gender in each category.
SELECT category,gender,COUNT(*) AS total_transactions
FROM retailsales
GROUP BY category,gender
order by 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT * FROM(
SELECT year(sale_date) AS year,
month(sale_date) AS month,
ROUND(AVG(total_sale),2) As avg_sale,
RANK() OVER(
PARTITION BY YEAR (sale_date) 
ORDER BY AVG(total_sale) DESC) AS sales_rank
from retailsales
group by 1,2
)as t1
WHERE sales_rank = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT customer_id,SUM(total_sale)as total_sales
FROM retailsales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT category,COUNT(DISTINCT customer_id) as unique_customers
FROM retailsales
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders 
WITH hourly_sale
AS(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retailsales
)
SELECT shift,COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;
-- end of project 
   

    

    
    
    
    
    

    