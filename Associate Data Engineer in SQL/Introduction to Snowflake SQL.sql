-- Select pizza_type_id, pizza_size, and price from pizzas table
SELECT pizza_type_id, 
	pizza_size, 
    price 
FROM pizzas

-- Count all pizza entries
SELECT COUNT(*) AS count_all_pizzas
FROM pizza_type
-- Apply filter on category for Classic pizza types
WHERE category = 'Classic'

-- Get information about the orders table
DESC TABLE orders


-- Convert order_id to VARCHAR aliasing to order_id_string
SELECT CAST(order_id AS VARCHAR) AS order_id_string 
FROM orders

SELECT price, 
-- Convert price to NUMBER data type
price::NUMBER AS price_dollars
FROM pizzas

-- Capitalize each word in pizza_type_id
SELECT INITCAP(pizza_type_id) AS capitalized_pizza_id 
FROM pizza_type;


-- Combine the name and category columns
SELECT CONCAT(name, ' - ', category) AS name_and_category
FROM pizza_type

-- Select the current date, current time
SELECT CURRENT_DATE, CURRENT_TIME

-- Count the number of orders per day
SELECT COUNT(*) AS orders_per_day, 
-- Extract the day of the week and alias to order_day
	EXTRACT(weekday FROM order_date) AS order_day
FROM orders
GROUP BY order_day
ORDER BY orders_per_day DESC

-- Get the month from order_date
SELECT EXTRACT(month FROM order_date) AS order_month, 
    p.pizza_size,
    -- Calaculate revenue
    SUM(p.price * od.quantity) AS revenue
FROM orders o
INNER JOIN order_details od USING(order_id)
INNER JOIN pizzas p USING(pizza_id)
-- Appropriately group the query
GROUP BY ALL
-- Sort by revenue in descending order
ORDER BY revenue DESC;


SELECT 
	-- Get the pizza category
    pt.category,
    SUM(p.price * od.quantity) AS total_revenue
FROM order_details AS od
NATURAL JOIN pizzas AS p
-- NATURAL JOIN the pizza_type table
NATURAL JOIN pizza_type AS pt
-- GROUP the records by category
GROUP BY pt.category
-- ORDER by total_revenue and limit the records
ORDER BY total_revenue DESC
LIMIT 1


SELECT COUNT(o.order_id) AS total_orders,
        AVG(p.price) AS average_price,
        -- Calculate total revenue
        SUM(p.price * od.quantity) AS total_revenue	
FROM orders AS o
LEFT JOIN order_details AS od
ON o.order_id = od.order_id
-- Use an appropriate JOIN with the pizzas table
RIGHT JOIN pizzas AS p
ON od.pizza_id = p.pizza_id



SELECT COUNT(o.order_id) AS total_orders,
        AVG(p.price) AS average_price,
        -- Calculate total revenue
        SUM(p.price * od.quantity) AS total_revenue,
        -- Get the name from the pizza_type table
		pt.name AS pizza_name
FROM orders AS o 
LEFT JOIN order_details AS od
ON o.order_id = od.order_id
-- Use an appropriate JOIN with the pizzas table
RIGHT JOIN pizzas p
ON od.pizza_id = p.pizza_id
-- NATURAL JOIN the pizza_type table
NATURAL JOIN pizza_type AS pt
GROUP BY pt.name, pt.category
ORDER BY total_revenue desc, total_orders desc































