create database if not exists sales_project;
use sales_project ;
  -- CREATE TABLES  
-- * CUSTOMERS TABLE 
create table if not exists customers ( customers_id int primary key , customer_name varchar(50),
					city varchar(50));
-- * ORDERS TABLE 
create table  if not exists orders( order_id int primary key , customers_id int, 
						order_amount decimal(10,2) , order_date date, 
                        foreign key (customers_id) references customers(customers_id) ) ;
--  * PRODUCTS TABLE 
create table if not exists products(product_id int primary key, product_name varchar(50) ,
				price decimal(10,2) , stock int ) ;
							
  -- INSERT DATA ( DML START)
insert into customers values ( 1, 'rahul' , 'delhi'), ( 2, 'kavita' , 'pune') ,
			( 3 , 'rohan' ,'mumbai') , ( 4 , 'amit' ,'noida') ;
select * from customers;
insert into orders values ( 101 , 1 , 5000 , '2025-02-01'),
					(102 , 2 , 7000 , '2025-02-03'), (103 , 3 , 3000 , '2025-02-05'),
                    (104 , 4 , 8000 , '2025-02-07');
select * from orders ;  
insert into products values (1, 'laptop' , 50000, 10),(2,'mobile',20000,20);
select * from products;
  -- TRANSACTION PRACTICE  
start transaction;
update orders set order_amount = 8000 where order_id = 101;  
start transaction;
update products set stock = stock - 1 where product_id = 1;
insert into orders values(104, 1 , 50000 ,'2025-02-10' );
select * from products;
select * from orders; 
commit;
  -- DELETE WITH TRANSACTION 
start transaction ;
delete from orders where order_id = 103;
select * from orders;  
rollback;
  -- SALES REPORT QUERY
-- * Total Sales
select sum(order_amount) as total_sales from orders;  
-- * Customer-wise Sales
select c.customer_name , sum(o.order_amount) as total_spent from customers c
		join orders o on c.customers_id =o.customers_id
        group by c.customer_name ;