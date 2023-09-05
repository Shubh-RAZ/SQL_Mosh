-- Transactions ~ when multiple tasks are being performed and all need to get done if not then all task will rollback
-- Properties of transactions(ACID)
-- 1. Atomicity 
-- 2. Consitency
-- 3. Isolation
-- 4. Durability

start transaction;

insert into orders (customer_id,order_date, status) 
values (1,'2019-01-01',1);

insert into order_items 
values (last_insert_id(),1,1,1);

commit;

-- Concurrency ~ when two users are performing a task simultaneously then the other user has to wait till the first user commits

start transaction;

update customers
set points = points + 1
where customer_id = 1;
commit;

-- problems in concurrency
-- 1. Lost updates ~ when two users try to update the same transaction then the transaction that commits at last overwrites the previous transaction
-- 2. Dirty Reads ~ If we read uncommitted data
-- 3. Non-repeating Reads ~ If we read same data twice in a transaction and get diffrent data
-- 4. Phantom Reads ~ When we miss on or more row in a query

-- Transaction isolation levels
-- 1. Read uncommitted (Fastest Isolation level)
-- 2. Read Commited ~ Dirty Read
-- 3. Repeatable Read ~ Dirty Read, Lost Updates, Non-repeating Reads(Mostly used)
-- 4. Serializable ~ Dirty Read, Lost Updates, Non-repeating Reads, Phantom Reads(Slowest Isolation level)

-- The more we increase the isolation level, performace will decrease

show variables like 'transaction_isolation';
-- set global transaction isolation level serializable;

-- Deadlocks
-- When diffrent transactions cannot complete because each transaction holds a log that other transaction needs.
-- we can never get completely rid of deadlocks but we can minimize them
-- If the statements are in reverse order we are likely to have a deadlock