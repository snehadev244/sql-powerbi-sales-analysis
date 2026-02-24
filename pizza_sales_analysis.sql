--CREATING DATABASE

CREATE DATABASE pizza_sales_analysis

--use db
USE pizza_sales_analysis

SELECT *
from row_dataset

CREATE TABLE pizza_sales_data(
	 pizza_id  int,
	 order_id   int,
	 pizza_name_id nvarchar(50),
	 quantity   int,
	 order_date   date,
	 order_time   time (7),
	 unit_price   decimal (18, 10),
	 total_price   decimal (18, 10),
	 pizza_size   nvarchar (50),
	 pizza_category   nvarchar (50)  ,
	 pizza_ingredients   nvarchar (100)  ,
	 pizza_name   nvarchar (50)  
)  

INSERT INTO pizza_sales_data(
	 pizza_id,
	 pizza_name,
	 pizza_category,
	 pizza_size,
	 pizza_ingredients,
	 order_id,
	 pizza_name_id,
	 quantity,
	 order_date,
	 order_time,
	 unit_price,
	 total_price
)
Select
	 pizza_id,
	 pizza_name,
	 pizza_category,
	 pizza_size,
	 pizza_ingredients,
	 order_id,
	 pizza_name_id,
	 quantity,
	 order_date,
	 order_time,
	 CAST(unit_price AS decimal(10,2)) AS unit_price,
	 CAST(total_price AS decimal(10,2)) AS total_price
FROM row_dataset

--1. Total Revenue

SELECT
	CAST(SUM(total_price) AS DECIMAL(10,2))AS Total_revenue
FROM pizza_sales_data

--2. Average Order Value
SELECT
 CAST((SUM(total_price)/COUNT( DISTINCT order_id))AS decimal(10,2)) as AOV
 FROM pizza_sales_data

 --3. Total Pizzas Sold
 SELECT 
	SUM(quantity) AS Total_pizza_sold
 FROM pizza_sales_data

 --4. Total Orders
 SELECT
	COUNT(DISTINCT order_id) AS Total_orders
 FROM pizza_sales_data

 --5. Average Pizzas Per Order
 SELECT 
	CAST(CAST(SUM(quantity)AS decimal(10,2))/CAST(COUNT(DISTINCT order_id)AS decimal(10,2))AS decimal(10,2))as APO 
 FROM pizza_sales_data

 --6 Daily Trend for Total Orders
 SELECT
	DATENAME(DW,order_date) AS order_day,
	COUNT(DISTINCT order_id) AS Total_orders
 FROM pizza_sales_data
 GROUP BY DATENAME(DW,order_date) 
 ORDER BY Total_orders DESC

 --7. Monthly Trend for Orders
 SELECT
	DATENAME(MONTH,order_date) AS Month,
	COUNT(DISTINCT order_id) AS Total_orders
 FROM pizza_sales_data
 GROUP BY DATENAME(MONTH,order_date)
 ORDER BY Total_orders DESC

 --8. % of Sales by Pizza Category

 SELECT 
	pizza_category,
	CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales_data) AS DECIMAL(10,2)) AS percent_sales
 FROM pizza_sales_data
 GROUP BY pizza_category
 ORDER BY percent_sales desc

 -- 9. % of Sales by Pizza size
 
 SELECT 
	pizza_size,
	CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales_data) AS DECIMAL(10,2)) AS percent_sales
 FROM pizza_sales_data
 GROUP BY pizza_size
 ORDER BY percent_sales desc

 --10. Total Pizzas Sold by Pizza Category
 SELECT
	pizza_category,
	CAST(SUM(quantity)AS decimal(10,2)) AS Total_pizza
 FROM pizza_sales_data
 GROUP BY pizza_category
 ORDER BY Total_pizza desc

 --11. Top 5 Pizzas by Revenue
 SELECT TOP 5 pizza_name,
		CAST(SUM(total_price) as decimal(10,2)) as Total_revenue
 FROM pizza_sales_data
 GROUP BY pizza_name
 ORDER BY Total_revenue desc

 
 --12. Bottom 5 Pizzas by Revenue
 SELECT TOP 5 pizza_name,
		CAST(SUM(total_price) as decimal(10,2)) as Total_revenue
 FROM pizza_sales_data
 GROUP BY pizza_name
 ORDER BY Total_revenue 

 --13. Top 5 Pizzas by Quantity
 SELECT TOP 5 pizza_name,
		CAST(SUM(quantity) as decimal(10,2)) as Total_revenue
 FROM pizza_sales_data
 GROUP BY pizza_name
 ORDER BY Total_revenue DESC

 
 --14. Bottom 5 Pizzas by Quantity
 SELECT TOP 5 pizza_name,
		CAST(SUM(quantity) as decimal(10,2)) as Total_revenue
 FROM pizza_sales_data
 GROUP BY pizza_name
 ORDER BY Total_revenue 

 --15. TOP 5 Pizzas by total Order
 SELECT TOP 5 pizza_name,
		COUNT(DISTINCT order_id) AS total_order
 FROM pizza_sales_data
 GROUP BY pizza_name
 ORDER BY total_order desc

  --16. bottom 5 Pizzas by total Order
 SELECT TOP 5 pizza_name,
		COUNT(DISTINCT order_id) AS total_order
 FROM pizza_sales_data
 GROUP BY pizza_name
 ORDER BY total_order 