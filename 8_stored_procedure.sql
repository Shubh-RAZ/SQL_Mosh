delimiter $$
create procedure get_clients()
begin
	select * from clients;
end $$
delimiter ;

call get_clients();

delimiter $$
create procedure get_invoices_with_balance()
begin
	select *, (invoice_total - payment_total) as balance
	from invoices
	where (invoice_total - payment_total) > 0;
end $$

delimiter ;

call get_invoices_with_balance();
