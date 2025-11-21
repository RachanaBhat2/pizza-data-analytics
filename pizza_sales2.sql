use [Pizza DB];
select * from pizza_sales;

-- kpi requirements
-- total revenue
select sum(total_price) as Total_Revenue from pizza_sales;

--average order value
select sum(total_price) / count(distinct order_id) as Average_Order from pizza_sales;

--total pizza sold(total sales)
select sum(quantity) as Total_sales from pizza_sales;

--total orders
select count(distinct order_id) as Total_orders from pizza_sales;

--Average Pizzas Per Order 
select sum(quantity) / count(distinct order_id) as Average_pizza_per_order from pizza_sales;

--convert to decimal
select cast(sum(quantity) as decimal(10,2))/
cast(count(distinct order_id) as decimal(10,2)) as average_pizza_per_order from pizza_sales;

select cast(cast(sum(quantity) as decimal(10,2))/
cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) as average_pizza_per_order from pizza_sales;

-- daily trends on orders
select datename(dw,order_date) as order_day, count(distinct order_id) as total_orders from pizza_sales 
group by datename(dw,order_date);

-- monthly trends on total order
select datename(month,order_date) as month_name, count(distinct order_id) as total_orders from pizza_sales 
group by datename(month,order_date)
order by total_orders;

-- hourly trends on total orders
select datepart(hour,order_time) as order_hour, count(distinct order_id) as total_orders from pizza_sales
group by datepart(hour,order_time)
order by datepart(hour,order_time);

-- total pizzas sold by pizza category
select pizza_category, sum(quantity) as total_sales from pizza_sales
group by pizza_category
order by pizza_category;

-- top 3 orders
select top 3 datename(month,order_date) as month_name, count(distinct order_id) as total_orders from pizza_sales 
group by datename(month,order_date) order by total_orders desc;

-- bottom 3 orders
select top 3 datename(month,order_date) as month_name, count(distinct order_id) as total_orders from pizza_sales 
group by datename(month,order_date) order by total_orders;

-- percentage of revenue by category
select pizza_category, sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as PCT from pizza_sales 
group by pizza_category;

-- percentage of revenue by category -- to check based on particular month
select pizza_category, sum(total_price) * 100 / (select sum(total_price) from pizza_sales where month(order_date) = 2) as PCT from pizza_sales 
where month(order_date) = 2
group by pizza_category;

-- percentage of revenue by pizza size
select pizza_size, sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as PCT from pizza_sales 
group by pizza_size;

-- total orders by pizza size
select pizza_size,count(distinct order_id) as total_orders from pizza_sales 
group by pizza_size
order by total_orders desc;

-- top 5 best selling pizza by revenue
select top 5 pizza_name , sum(total_price) as total_revenue from pizza_sales
group by pizza_name
order by total_revenue desc;








