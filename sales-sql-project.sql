/************************
Project: Retail Store Sales and Customer Analysis
Objective: Extract business insights regarding high-value transactions and geographic distribution
************************/

select top 5 * from customers;

select top 5 * from orders;

select top 5 * from products;

--"customers" connected to "orders" by "customer_id"
--"orders" connected to "products" by "product_id"
--since "customers" and "products" are connected to "orders" both are connected as well

--Which product categories are bringing the most revenue and how much each have units sold?

select products.category, sum(orders.quantity) as total_units_sold, sum(orders.quantity * products.price) as total_revenue
from orders 
join products on orders.product_id = products.product_id
group by products.category
order by total_revenue desc;

--We can see that the "Home" category is bringing the most revenue (approx 473002) even though they do not have the most units sold

--Who are the most valued customers?

with customer_spending as 
(
    select orders.customer_id, sum(orders.quantity * products.price) as total_spent
    from orders
    join products on orders.product_id = products.product_id
    group by orders.customer_id
)
select customer_id, total_spent
from customer_spending
order by total_spent desc;

--We can see that the customer with the ID of C0299 has spent the most (5124)

--Which cities place the most orders?

select city, count(customer_id) as total_customers_in_city
from customers
group by city
order by total_customers_in_city desc;

--We can see that Sheffiled has the most customers (163)

--Which single order was the largest?

select orders.order_id, orders.customer_id, (orders.quantity * products.price) as order_total_cost
from orders
join products on orders.product_id = products.product_id
order by order_total_cost desc;

--We can see that the largest order by revenue is approx. 1449 which is ordered by multiple customers
