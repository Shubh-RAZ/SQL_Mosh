USE sql_store;

select first_name,last_name, points, points + 10 as 'bonus point'
from customers ;
-- where customer_id = 1
-- order by first_name;

select state
from customers;

select distinct state
from customers;

select name, unit_price, unit_price * 1.1 as 'New Price'
from products;

select *
from customers
where state != 'VA';

select *
from customers
where birth_date > '1990-01-01';

select *
from orders
where order_date >= '2019-01-01';

select *
from customers
where birth_date > '1990-01-01' and points > 1000;

select * 
from order_items
where order_id = 6 and (quantity*unit_price) > 30;

select *
from customers
where state in('VA','GA','FL')
order by first_name;

select *
from products
where quantity_in_stock in(49,38,72);

select *
from customers
where points between 1000 and 3000;

-- YYYY-MM-DD

select *
from customers
where birth_date between '1990-01-01' and '2000-01-01';

select *
from customers
where last_name like '%b%';
-- % any number of charac
-- _ single character

select *
from customers
-- where address like '%trail%' or address like '%avenue%';
where phone like '%9';

select *
from customers
-- where last_name regexp 'field$';
-- where last_name regexp 'field|mac|rose';
-- where last_name regexp '[gim]e';
where last_name regexp '[a-h]e';
-- ge, ie, me 
-- ^ begining of string
-- $ end of string
-- | used for or

select * 
from customers
-- where first_name regexp 'elka|ambur';
-- where last_name regexp 'ey$|on$';
-- where last_name regexp '^my|se';
where last_name regexp 'b[ru]';

select * 
from orders
where shipped_date is null;

select *
from customers
-- order by state, first_name;
order by state desc, first_name;

select * , (unit_price * quantity ) as total_price
from order_items
where order_id = 2
order by total_price desc;
-- limit 2;

select *
from customers
limit 6,3;

-- page 1: 1-3
-- page 2: 4-6
-- page 3: 7-9 ( limit 6,3 )

select *
from customers
order by points desc
limit 3;
-- limit clause always comes at end


