delimiter $$

create trigger payment_after_insert
	after insert on payments
    for each row
begin 
	update invoices
    set payment_total = payment_total + new.amount
    where invoice_id = new.invoice_id;
end $$

delimiter ;

delimiter $$

-- -------------------------------------------------

create trigger payment_after_insert
	after delete on payments
    for each row
begin 
	update invoices
    set payment_total = payment_total - old.amount
    where invoice_id = old.invoice_id;
end $$

delimiter ;

-- ----------------------------------------------

show triggers;
show triggers like 'payments%';
drop trigger if exists payments_after_insert;

-- ------------------------------------------------
-- events

show variables like 'event%';
-- set global event_scheduler = OFF;

delimiter $$

create event yearly_delete_stale_audit_rows
on schedule
	-- '2023-09-03'
    every 1 year starts '2023-09-03' ends '2029-09-03'
do begin
	delete from payments_audit
    where action_date < now() - interval 1 year;
-- deletes all aduit record older than 1 year
end $$

-- to update the event
delimiter $$

alter event yearly_delete_stale_audit_rows
on schedule
	-- '2023-09-03'
    every 1 year starts '2023-09-03' ends '2029-09-03'
do begin
	delete from payments_audit
    where action_date < now() - interval 1 year;
-- deletes all aduit record older than 1 year
end $$
    
-- To disable the event
alter event yearly_delete_stale_audit_rows disable;