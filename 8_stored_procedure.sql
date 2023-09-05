delimiter $$
create procedure get_clients()
begin
	select * from clients;
end $$
delimiter ;

call get_clients();

-- -------------------------------------------------- 
delimiter $$
create procedure get_invoices_with_balance()
begin
	select *, (invoice_total - payment_total) as balance
	from invoices
	where (invoice_total - payment_total) > 0;
end $$

delimiter ;

call get_invoices_with_balance();

--  ---------------------------------------------------

drop procedure get_clients;
drop procedure if exists get_clients;

-- ----------------------------------------------------

drop procedure if exists get_clients_by_state;

delimiter $$

create procedure get_clients_by_state
(
	state CHAR(2)
)
begin
	select * from clients c
    where c.state = state;
    
end $$

delimiter ;

call get_clients_by_state('CA');

-- -------------------------------------------------------

delimiter $$

create procedure get_invoices_by_id(
	client_id int
)

begin 
	select * from invoices iv
    where iv.client_id = client_id;
end $$

delimiter ;

call get_invoices_by_id(5);

-- -----------------------------------------------------------

-- setting default value for a parameter

drop procedure if exists get_clients_by_state;

delimiter $$

create procedure get_clients_by_state
(
	state CHAR(2)
)
begin
	if state is null then
    set state = 'CA';
    end if;
    
	select * from clients c
    where c.state = state;
    
end $$

delimiter ;

call get_clients_by_state(null);

-- -------------------------------------------------

drop procedure if exists get_clients_by_state;

delimiter $$

create procedure get_clients_by_state
(
	state CHAR(2)
)
begin
	select * from clients c
    where c.state = ifnull(state,c.state);
    
end $$

delimiter ;

call get_clients_by_state(null);

-- ------------------------------------------------------

delimiter $$

create procedure get_payment_by_para(
	client_id int,
    payment_method tinyint 
)

begin 
	select * from payments pm
    where pm.client_id = ifnull(client_id,pm.client_id) and pm.payment_method = ifnull(payment_method,pm.payment_method);
end $$

delimiter ;

call get_payment_by_para(5,1);

-- -----------------------------------------------

-- parameters are placeholders in stored procedure while arguments are the values that we pass

-- ------------------------------------------------

-- valiating parameters

drop procedure update_payment;

delimiter $$

create procedure update_payment(
invoice_id int,
payment_amount decimal(9,2),
payment_date date
)

begin 
	if payment_amount <= 0 then
    signal sqlstate '22003'set message_text = 'Invalid payment ampunt';
    end if;
		update invoices iv
        set 
        iv.payment_total = payment_amount,
        iv.payment_date = payment_date;
end $$

delimiter ; 

call update_payment(2,-500,'2019-01-01');

-- ---------------------------------------------------

-- output parameters -- we should avoid them
drop procedure get_unpaid_invoices_for_client;

delimiter $$

create procedure get_unpaid_invoices_for_client(
client_id int
)

begin 

	select count(*), sum(invoice_total)
    from invoices iv
    where iv.client_id = client_id and payment_total = 0;
    
end $$

delimiter ;

call get_unpaid_invoices_for_client(3);


-- -------------------------------------------
-- declaring variables

delimiter $$

create procedure get_risk_factor()
begin
	declare risk_factor decimal(9,2) default 0;
    declare invoices_total decimal(9,2);
    declare invoices_count int;
    
    select count(*), sum(invoice_total)
    into invoices_count, invoices_total
    from invoices;
    
end $$

delimiter ;

-- --------------------------------------------
-- functions can only return single value unlike stored procedures they cannot return multiple rows

-- Attributes of functions
-- 1. Deterministic ~ same output for same input
-- 2. reads sl data ~ we will have select statement in our function to read some data
-- 3. modifies ~ insert, update, delete statement in out=r function 

delimiter $$

create function get_risk_factor_for_client( 
client_id int
)
returns integer
reads sql data
begin
	return 1;
end $$

delimiter ;

-- ------------------------------------------------------

drop function if exists get_risk_factor_for_client;

-- -------------------------------------------------------
