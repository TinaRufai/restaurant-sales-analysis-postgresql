SELECT * FROM menu_items

SELECT * FROM order_details

Use SQL to answer the following questions 


--1. View the menu_items table and write a query to find the number of items on the menu
SELECT COUNT(*) AS number_of_items
FROM menu_items

--2. What are the least and most expensive items on the menu?
--most expensive item
SELECT item_name, price
FROM menu_items
ORDER BY price DESC
LIMIT 1

--least expensive item
SELECT item_name, price
FROM menu_items
ORDER BY price 
LIMIT 1

SELECT item_name, price
FROM menu_items
WHERE price = (SELECT MIN(price) FROM menu_items)

--3. How many Italian dishes are on the menu? What are the least and most expensive Italian dishes on the menu?
SELECT * FROM menu_items

SELECT COUNT(*) AS number_of_italian_dishes
FROM menu_items
WHERE category = 'Italian'

SELECT category,item_name,price
FROM menu_items
WHERE category = 'Italian'
ORDER BY price DESC
LIMIT 1

SELECT category,item_name,price
FROM menu_items
WHERE category = 'Italian'
ORDER BY price
LIMIT 1


--4. How many dishes are in each category? What is the average dish price within each category?
SELECT * FROM menu_items

SELECT category, COUNT(*) AS dishes_count
FROM menu_items
GROUP BY category 

SELECT category, ROUND(AVG(price),2) AS average_price
FROM menu_items
GROUP BY category

--5. View the order_details table. What is the date range of the table?
SELECT * FROM order_details

SELECT
    MIN(order_date) AS earliest_date,
    MAX(order_date) AS latest_date
FROM
    order_details

--6. How many orders were made within this date range? How many items were ordered within this date range?
SELECT COUNT(order_id) AS Number_of_orders, COUNT(item_id) AS items_ordered
FROM order_details
WHERE order_date BETWEEN (SELECT MIN(order_date) FROM order_details) AND 
(SELECT MAX(order_date) FROM order_details);

SELECT COUNT (order_id) AS Number_of_orders, COUNT(item_id) AS items_ordered
FROM order_details
WHERE order_date BETWEEN '2023-01-01' AND '2023-03-31'


--7. Which orders had the most number of items?
SELECT order_id,  COUNT(item_id)
FROM order_details 
GROUP BY order_id
ORDER BY COUNT(item_id) DESC


--8. How many orders had more than 12 items?
SELECT COUNT (*) AS orders_more_than_12 
FROM (SELECT order_id, COUNT(item_id) AS number_of_items
FROM order_details
GROUP BY order_id
HAVING COUNT(item_id) > 12)


--9. Combine the menu_items and order_details tables into a single table
SELECT 
    od.*,
    mi.item_name,
    mi.category,
    mi.price
FROM order_details od
JOIN menu_items mi ON od.item_id = mi.menu_item_id;

--or

SELECT * FROM order_details od
JOIN menu_items mi ON od.item_id = mi.menu_item_id

10. What were the least and most ordered items? What categories were they in?
SELECT mi.category, mi.item_name, COUNT(DISTINCT order_id) AS Ordered_items
FROM order_details od
JOIN menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY mi.category, mi.item_name
ORDER BY ordered_items DESC
LIMIT 1

--least
SELECT mi.category, mi.item_name, COUNT(DISTINCT order_id) AS Ordered_items
FROM order_details od
JOIN menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY mi.category, mi.item_name
ORDER BY ordered_items
LIMIT 1

11.What were the top 5 orders that spent the most money?
SELECT od.order_id, SUM(price) AS most_spent
FROM order_details od JOIN menu_items mi ON mi.menu_item_id = od.item_id
GROUP BY od.order_id
ORDER BY SUM(price) DESC
LIMIT 5


--12. View the details of the highest spend order. Which specific items were purchased?
SELECT category, item_name, od.order_id, SUM(price) AS most_spent
FROM order_details od JOIN menu_items mi ON mi.menu_item_id = od.item_id
GROUP BY category, item_name, od.order_id
ORDER BY SUM(price) DESC
LIMIT 1

SELECT category, item_name, SUM(price) AS most_spent
FROM order_details od JOIN menu_items mi ON mi.menu_item_id = od.item_id
GROUP BY category, item_name
ORDER BY SUM(price) DESC
LIMIT 5

--13. View the details of the top 5 highest spend orders
SELECT category, item_name, od.order_id, SUM(price) AS most_spent
FROM order_details od JOIN menu_items mi ON mi.menu_item_id = od.item_id
GROUP BY category, item_name, od.order_id
ORDER BY SUM(price) DESC
LIMIT 5