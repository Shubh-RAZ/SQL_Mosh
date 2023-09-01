-- Numeric fucntions

select round(5.73,1);
select truncate(5.78242,2);
select ceiling(5.2);
select floor(2.4);

-- String functions

select length('sky');
select upper('sky');
select lower('SKY');
select ltrim('       sky');
select rtrim('sky    ');
select trim('   sky  ');
select left('kindergarten',4);
select right('kindergarten',6);
select substring('kindergarten',3,5);
select substring('kindergarten',3);
select locate('n','kindergarten');
-- if we search for characters which doesn't exist in string we get 0
select replace('kindergarten','garten','garden');
select concate('first','last') ;

-- Date and time

select now(), curdate(), curtime();
-- All these return integer value

select year(now());
select month(now());
select day(now());
select hour(now());

-- All these return string value

select dayname(now());
select monthname(now());
select extract(day from now());
select extract(year from now());


select *
from orders
where year(order_date) = year(now()); 

select date_format(now(),'%m %d %y');
select date_format(now(),'%d %M %y');

-- Calculations on dates and time

select date_add(now(),interval 1 day);
select date_add(now(),interval -1 year);
select date_sub(now(),interval 1 year);
select datediff('2019-01-05','2019-01-01');

-- If null and coa

select 
	order_id,
    ifnull(shipper_id,'Not assigned') as shipper
from orders;

select 
	order_id,
    coalesce(shipper_id, comments, 'Not Assigned') as shipper
from orders;

select
	concat(first_name,' ',last_name) as full_name,
    ifnull(phone,'Unknown') as phone
from customers;

select 
	order_id,
    order_date,
    if (year(order_date) = '2019', 'Active','Archive') as category
from orders;

select 
	product_id,
    name,
    count(*) as orders,
    if ( count(*) = 1 ,'Once','Many') as frequency
from products 
join order_items using (product_id)
group by product_id,name; 

select 
	order_id,
    order_date,
    case
		when year(order_date) = '2019' then 'Active'
        when year(order_date) = '2018' then 'Last year'
        when year(order_date) < '2018' then 'Archive'
        else 'Future'
	end as category
from orders;

select 
	concat(first_name, ' ', last_name) as customer,
    points,
    case
		when points > 3000 then 'Gold'
        when points >= 2000 then 'Silver'
        else 'Bronze'
	end as category
from customers;