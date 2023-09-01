select * 
from products
where unit_price > (
					select unit_price
                    from products
                    where product_id = 3 );
                    
select *
from employees
where salary > ( 
				select avg(salary)
				from employees
                );
                
select *
from products
where product_id not in (
						select p.product_id
                        from products p
                        join order_items oi
                        using (product_id)
                        );
                        
                        
-- or

select *
from products
where product_id not in (
						select distinct product_id
                        from order_items 
                        );
                        
select *
from clients 
where client_id not in (
						select
                        distinct client_id 
                        from invoices
                        );
                        
select 
	c.customer_id,
    c.first_name,
    c.last_name
from customers c
join orders o using (customer_id)
join order_items oi using (order_id)
where oi.product_id = 3; 

select *
from invoices
where invoice_total > ( 
						select max(invoice_total)
                        from invoices
                        where client_id = 3 );
    
-- Alternate way using ALL keyword

select *
from invoices
where invoice_total > all ( 
						select invoice_total
                        from invoices
                        where client_id = 3 );
select *
from clients
where client_id in (
					select client_id
					from invoices
					group by client_id
					having count(*) > 2
                    );
                      
-- Alternate way using ANY keyword

select *
from clients
where client_id = any (
					select client_id
					from invoices
					group by client_id
					having count(*) > 2
                    );
                    
-- correlated subquery

select *
from employees e
where salary > (
				select avg(salary)
                from employees
                where office_id = e.office_id );
                
select * 
from invoices iv
where invoice_total > (
						select avg(invoice_total)
                        from invoices
                        where client_id = iv.client_id);
                        
-- exist operator is more fast and efficient especially for large data

select *
from clients c
where exists (
				select client_id
                from invoices
                where client_id =c.client_id );
                
select *
from products p 
where not exists ( 
					select product_id
                    from order_items
                    where p.product_id = product_id
                    );
    
-- This is wrong as we are using aggregate function without grouping

select
	invoice_id,
    invoice_total,
	avg(invoice_total)
from invoices;

-- we cannot use the alias in select hence we are using select to capture the alias used

select 
	invoice_id,
    invoice_total,
    (select avg(invoice_total) from invoices) as invoice_average,
    invoice_total - (select invoice_average) as diiffrence
from invoices;

select 
	client_id,
    name,
    sum(iv.invoice_total) as total_sales,
    (select avg(invoice_total) from invoices) as average,
    (sum(iv.invoice_total) - (select avg(invoice_total) from invoices) ) as diifrence
from clients
left join invoices iv using (client_id)
group by client_id,name;

-- Alternate way

select 
	client_id,
    name,
    (select sum(invoice_total)
	from invoices
    where client_id = c.client_id ) as total_sales,
    (select avg(invoice_total) from invoices) as average,
    (select total_sales - average ) as diifrence
from clients c;

-- subquery inside from clause 
-- it requires alias to be given

select * 
from ( select 
	client_id,
    name,
    (select sum(invoice_total)
	from invoices
    where client_id = c.client_id ) as total_sales,
    (select avg(invoice_total) from invoices) as average,
    (select total_sales - average ) as diifrence
from clients c) as sales_summary;

select * 
from ( select 
	client_id,
    name,
    (select sum(invoice_total)
	from invoices
    where client_id = c.client_id ) as total_sales,
    (select avg(invoice_total) from invoices) as average,
    (select total_sales - average ) as diifrence
from clients c) as sales_summary
where total_sales is not null;