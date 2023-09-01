-- select order_id,first_name,last_name
-- select order_id,customer_id,last_name this will throw error as sql is ambigous about customer id
select order_id, first_name, last_name
from orders
join customers on orders.customer_id = customers.customer_id;

select order_id, first_name, last_name
from orders o 
join customers c on o.customer_id = c.customer_id;

select order_id, oi.product_id, quantity, oi.unit_price
from order_items oi
join products p on oi.product_id = p.product_id;

select *
from order_items oi
join sql_inventory.products p
on oi.product_id = p.product_id;

-- use sql_hr;

-- select e.employee_id,e.first_name,m.first_name
-- from employees e
-- join employees m
-- on e.reports_to = m.employee_id;

select order_id, order_date, first_name, last_name, name as status
from orders od
join order_statuses odst on odst.order_status_id = od.status
join customers c on c.customer_id = od.customer_id;

-- compound join conditions

select cl.name,p.date,p.amount,pm.name as payment_method
from payments p 
join clients cl on cl.client_id = p.client_id
join payment_methods pm on pm.payment_method_id = p.payment_method;

-- implicit join syntax

select *
from orders o, customers c
where o.customer_id = c.customer_id;


-- Outer join

-- Left join

select  c.customer_id,c.first_name,o.order_id
from customers c
left join orders o
on c.customer_id = o.customer_id
order by c.customer_id;

-- right join

select  c.customer_id,c.first_name,o.order_id
from customers c
right join orders o
on c.customer_id = o.customer_id
order by c.customer_id;

select p.product_id, p.name, oi.quantity
from products p
left join order_items oi on p.product_id = oi.product_id;

select p.product_id, p.name, oi.quantity
from order_items oi
right join products p on p.product_id = oi.product_id;

select o.order_date,o.order_id,c.first_name,s.name,os.name as status
from orders o
left join customers c 
-- on o.customer_id = c.customer_id
using (customer_id)
left join shippers s
-- on o.shipper_id = s.shipper_id
using (shipper_id)
left join order_statuses os
on o.status = os.order_status_id;

select *
from order_items oi
join order_item_notes oin
using (order_id, product_id);

select p.date,c.name,p.amount,pm.name
from payments p
join clients c
using (client_id)
join payment_methods pm
on pm.payment_method_id = p.payment_method;


-- Natural join

select o.order_id,c.first_name
from orders o
natural join customers c;

-- Cross join

select c.first_name as customer, p.name as product
from customers c
-- from customers c, products p
cross join products p
order by c.first_name;

-- Unions

select order_id,order_date,'Active' as status
from orders
where order_date >= '2019-01-01'
Union
select order_id,order_date,'Archive' as status
from orders
where order_date <= '2019-01-01';

select customer_id,first_name,points, 'Gold' as Type
from customers 
where points >= 3000
union
select customer_id,first_name,points, 'Silver' as Type
from customers 
where points between 2000 and 3000
union
select customer_id,first_name,points, 'Bronze' as Type
from customers 
where points < 2000
order by first_name;
