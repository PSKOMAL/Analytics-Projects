create database pizzza;
use pizzza;


-- KPIS
-- 1) 1 TReve Total Revenue

	select * from orders;
    select * from order_details;
    select * from pizza_types;
    select * from pizzas;
    
    select * from order_details as o
    join pizzas as p
    on p.pizza_id = o.pizza_id ;
    
    select sum(quantity * price) as Total_Revenue from order_details as o
    join pizzas as p
    on p.pizza_id = o.pizza_id ;
    
    
-- 2) Average Order Value

	select round(sum(quantity * price)/count(distinct order_id)) as Average_Order_Value
    from order_details as o
    join pizzas as p
    on p.pizza_id = o.pizza_id ;


-- 3) Total Pizzas Sold
	select sum(quantity) as Total_Pizzas_Sold from order_details;
	
    
-- 4) Total Orders	
	select count( distinct order_id) as Total_Orders from orders;
    
    
-- 5) Average Pizza per Order
	select round(sum(quantity)/count(distinct order_id)) as Average_Pizza_per_Order
	from order_details;


-- QUESTIONS TO ANSWER
-- 1) Daily Trends for Total Orders

	SELECT DAYNAME(date) AS DayOfWeek,
    COUNT(DISTINCT order_id) AS Total_Orders
    FROM orders 
    GROUP BY DayOfWeek
    ORDER BY Total_Orders DESC;


-- 2) Hourly Trend for Total Orders

	select hour(time) as Hourr,
	count(distinct order_id) as Total_Orders from orders
    group by hourr
    order by hourr ;


-- 3) Percentage of Sales by Pizza Category

	select category, sum(quantity * price) as Revenue,
    round(sum(quantity * price)*100/ ( select sum(quantity * price) 
		from pizzas as p2 
        join order_details as od2 on od2.pizza_id = p2.pizza_id), 2) as Percentage
    from pizzas as p
    Join pizza_types AS pt on p.pizza_type_id = pt.pizza_type_id
    Join order_details as od on od.pizza_id = p.pizza_id
    group by category;


-- 4) Percentage of Sales by Pizza Size

	select size, sum(quantity * price) as Total_Revenue,
    round(sum(quantity * price)*100/(select sum(quantity * price) from pizzas as p2
    Join order_details as od2 on od2.pizza_id = p2.pizza_id), 2)  as Percentage_Sales
    from order_details as o
    join pizzas as p
    on p.pizza_id = o.pizza_id
    group by size
    order by size;
    
    
-- 5) Total Pizzas Sold by Pizza Category

	select category, sum(quantity) as Quantity_Sold 
    from pizzas as p
    join pizza_types as pt on p.pizza_type_id = pt.pizza_type_id
    join order_details as od on p.pizza_id = od.pizza_id
    group by category
    order by category;


-- 6) Top 5 Best Sellers by Total Pizzas sold

	
	select  name, sum(Quantity) as Total_Pizzas_sold
	from pizzas as p
    join pizza_types as pt on p.pizza_type_id = pt.pizza_type_id
    join order_details as od on p.pizza_id = od.pizza_id
    group by name
    order by Total_Pizzas_sold
    LIMIT 5;