-- insert data into multiple table

insert into orders (customer_id, order_date, status)
values(1,'2019-01-01',1);

insert into order_items
values ( last_insert_id(),1,1,2.95),
	   (last_insert_id(),2,1,4.95);
       
-- create a copy of table but it won't copy the atributes such as primary key and auto increment

create table orders_archived as
select * from orders;

-- insert using subquery

insert into orders_archived
select * from orders where order_date < '2019-01-01';

create table invoices_archived as
select inv.invoice_id, inv.number,c.name as client_name, inv.payment_total, inv.invoice_date, inv.due_date, inv.payment_date
from invoices as inv
join clients as c
using (client_id)
where payment_date is not null;

update customers
set points = (points + 50)
where birth_date < '1990-01-01';

update orders
set comments = 'Gold Customer'
where customer_id in (select customer_id from customers where points > 3000 );


