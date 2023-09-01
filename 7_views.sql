-- A column alias cannot be used in a SELECT, WHERE, GROUP BY or HAVING clause due to the order of execution

create view sales_by_client as
select 
	c.client_id,
    c.name,
    sum(invoice_total) as total_sales
from clients c
join invoices i using (client_id)
group by client_id,name;

select *
from sales_by_client;

create view balance_by_client as
select 
	iv.client_id,
    c.name,
    sum(invoice_total - payment_total) as balance
from invoices iv
join clients c using (client_id)
group by iv.client_id,c.name;

select *
from balance_by_client;

-- Drop a view

drop view sales_by_client;

-- Replace a view

create or replace view balance_by_client as
select 
	iv.client_id,
    c.name,
    sum(invoice_total - payment_total) as balance
from invoices iv
join clients c using (client_id)
group by iv.client_id,c.name;

-- We can update the views only if they lack the following below conditions
-- 1. DISTINT
-- 2. Aggregate Functions (MIN,MAX,SUM, ... )
-- 3. GROUP BY/ HAVING
-- 4. UNION

-- delete from invoices_with_balance
-- where invoice_id = 1;

-- When we update or delete a row from a view some of it's row may disappear so to prevent this use the following

create or replace view balance_by_client as
select 
	iv.client_id,
    c.name,
    sum(invoice_total - payment_total) as balance
from invoices iv
join clients c using (client_id)
group by iv.client_id,c.name
with check  option;

-- Views offers us abstraction too which reduces impact of changes
-- suppose if we make any changes in the table name then we don't have to change the query for all
-- of it's instance
-- Views offer restrict access to the data

create view my_view as
	select 
		payment_date as payment_due
	from invoices;