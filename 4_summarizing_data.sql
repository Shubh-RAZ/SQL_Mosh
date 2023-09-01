-- Aggregate functions

select
	max(invoice_total) as highest,
    min(invoice_total) as lowest,
    avg(invoice_total) as average,
    -- count(invoice_total) as number_of_invoices,
    count(*) as total_records,
    count( distinct client_id) as total_clients
    -- count(payment_date) as count_of_payments, gives value of 15 as 2 values are null
from invoices;
    

select 
	'First half of 2019' as date_range,
	sum(invoice_total) as total_sales,
    sum(payment_total) as total_payments,
    sum(invoice_total -payment_total) as what_we_expect
from invoices
where invoice_date between '2019-01-01' and '2019-06-30'
union
select 
	'second half of 2019' as date_range,
	sum(invoice_total) as total_sales,
    sum(payment_total) as total_payments,
    sum(invoice_total -payment_total) as what_we_expect
from invoices
where invoice_date between '2019-07-01' and '2019-12-31'
union
select
	'total sales' as date_range,
    sum(invoice_total) as total_sales,
    sum(payment_total) as total_payments,
    sum(invoice_total - payment_total) as what_we_expect
from invoices;


-- Group by

-- group by clause is always after where and before order by

select state,city,sum(invoice_total) as total_sales
from invoices iv
join clients
using (client_id)
group by city,state;

select p.date, pm.name as payment_method, sum(amount) as total_payments
from payments p
join payment_methods pm
on p.payment_method = pm.payment_method_id
group by date, pm.name
order by date;

-- having clause

-- To filter without grouping we use WHERE clause while to filter with grouping we use having clause 
-- In having clause we cannot use columns which are not used in select statement
-- whereas in where clause we can use any column

select 
	client_id,
    sum(invoice_total) as total_Sales,
    count(*) as number_of_invoices
from invoices
 -- where total_sales > 500 this won't work as total_sales is undefined
 group by client_id
 having total_sales > 500 and number_of_invoices > 5;
 
 
 -- As a rule of thumb when using group by clause with aggregate function use all the columns in select statement for grouping except aggregate column
 
 select
	c.customer_id,
    c.first_name,
    c.last_name,
    c.state,
    sum(oi.quantity * oi.unit_price) as amount_spent
from customers c
join orders o
using (customer_id)
join order_items oi
using (order_id)
group by c.state,c.customer_id,c.first_name,c.last_name
having c.state = 'VA' and amount_spent >100;

-- Roll up only for mysql
  
select 
	client_id,
    sum(invoice_total) as total_sales
from invoices
group by client_id with rollup;

