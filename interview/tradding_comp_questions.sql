Scenario:
You have a table in the data warehouse with approximately 1 TB of data. This table contains two types of duplicates:
Exact duplicates: All column values are the same.
Partial duplicates: Some columns differ between duplicate rows.
The table includes an insert_timestamp column.

Question:
How would you approach identifying and cleaning up these duplicates using SQL?

Exact Duplicates -- 

step 1: data back 

	create table temp_table 
  as 
  select * from target_table 
  
step 2: 
	
  truncate table target_table
  
step 3: 
	
  insert into table target_table
  select distinct * 
  from temp_table 
  
Partial Duplicates -- 
step 1: data back 

	create table temp_table 
  as 
  select * from target_table 
  
step 2: 
	
  truncate table target_table
  
step 3:

	insert into table target_table 
  as 
	with temp_table_rn as (
  	
    select *,
    	row_number() over ( partition by order_number order by insert_timestamp desc) as rn
    from temp_table
  
  )
  select 
  	*
  from temp_table_rn
  where rn = 1
  
  
-------------
  
Scenario:
We have a historical salary table (SCD Type 4). For each employee, we need to display their first salary, latest salary, and
latest n-1 salary (salary before the latest). Please note that salary reductions may occur due to team or role changes.  How would you do this in SQL

Question:
How would you write a SQL query to retrieve this information?

with first_salary as (
	select *
  from (
	select 
  	emp_id,
    salary,
    row_number() over ( partition by emp_id order by eff_dt asc) as rn
  from salary_hist_table
  )
  where rn = 1
  
),
n_minus_one_salary as (
select *
from(
select 
  	emp_id,
    salary,
    row_number() over ( partition by emp_id order by eff_dt desc) as rn
  from salary_hist_table
  )
  where rn = 1
)

select 
	c.emp_id,
  f.salary as first_salary,
  c.salary as last_salary,
  nm.salary as n_mns_one_salary
from current_salary_table c 
left join first_salary f 
on c.emp_id = f.emp_id
left join n_minus_one_salary nm 
on c.emp_id = nm.emp_id

-----------------

Scenario:
We would like to introduce a bonus programme, where we reward our clients' wallets with 5% of their initial deposit to encourage them to trade with us.
Assuming we have the following tables:

User table
| id   | name  | signup_time              |
|------|-------|--------------------------|
| 1001 | Omar  | 2021-08-01 05:56:29 UTC  |
| 1003 | David | 2013-05-23 03:56:29 UTC  |
| 1005 | Kimia | 2014-08-09 17:56:29 UTC  |
| 1008 | Trish | 2014-08-09 17:56:29 UTC  |


Transaction table
| id     | user_id | transaction_time           | amount | type |
|--------|---------|----------------------------|--------|------|
| 30001  | 1001    | 2021-08-01 01:56:43 UTC    | 10     | buy  |
| 30002  | 1005    | 2013-05-23 06:55:11 UTC    | 40     | sell |
| 30003  | 1005    | 2018-01-01 02:56:42 UTC    | -30    | buy  |
| 30004  | 1003    | 2014-08-09 03:56:65 UTC    | -80    | buy  |


Payment table
| id     | user_id | transaction_time           | amount | method     | category   |
|--------|---------|----------------------------|--------|------------|------------|
| 20001  | 1001    | 2018-08-01 03:06:27 UTC    | 100    | Visa       | deposit    |
| 20002  | 1005    | 2018-08-02 04:16:43 UTC    | 50     | Mastercard | deposit    |
| 20003  | 1004    | 2013-05-23 05:16:32 UTC    | 300    | Crypto:BTC | withdrawal |
| 20004  | 1001    | 2018-08-02 06:46:43 UTC    | 50     | Mastercard | deposit    |
| 20005  | 1001    | 2015-08-09 02:26:59 UTC    | 300    | Skrill     | withdrawal |
| 10009  | 1009    | 2017-07-09 02:26:59 UTC    | 200    | Skrill     | deposit    |

Question:
Write a SQL query to calculate how much we need to pay in total for this programme.
Example: Based on this sample data, it will be (5 + 2.5 +10) = 17.5 USD for all our clients.


with fist_deposit_amounts as (
	select
  	id,
  	amount
  from (
    select 
    	id,
      amount,
      row_number() over ( partition by id order by transaction_time asc) as rn
    from payment_table
    where category = 'deposit'
  )
  where rn = 1
)
select 
  sum(amount * 0.5) as bonus_amount
from fist_deposit_amounts



  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  