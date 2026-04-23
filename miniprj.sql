create database BookStoreDB;
use BookStoreDB;

CREATE TABLE Category (
    category_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    category_name VARCHAR(100) NOT NULL,
    description VARCHAR(255)
);

CREATE TABLE Book (
    book_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL,
    status INT DEFAULT 1,
    publish_date DATE ,
    price DECIMAL(10 , 2 ),
    category_id INT,
    FOREIGN KEY (category_id)
        REFERENCES Category (category_id)
);

CREATE TABLE BookOrder (
    order_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    book_id INT,
    order_date DATE  ,
    delivery_date DATE,
    FOREIGN KEY (book_id)
        REFERENCES Book (book_id)
        ON DELETE CASCADE
);

alter table Book 
add column author_name varchar(100) not null;

alter table BookOrder
modify column customer_name varchar(200) not null;

alter table BookOrder
modify column delivery_date date check (delivery_date > order_date);

insert into Category 
values 
(1,'IT & Tech','Sách lập trình'),
(2,'Business','Sách kinh doanh'),
(3,'Novel','Tiểu thuyết');

insert into Book
values
(1,'Clean Code',1,'2020-05-10',500000,1,'Robert C.Martin'),
(2,'Đắc Nhân Tâm',0,'2018-08-20',150000,2,'Dale Carnegie'),
(3,'JavaScript Nâng cao',1,'2023-01-15',350000,1,'Kyle Simpson'),
(4,'Nhà Giả Kim',0,'2015-11-25',120000,3,'Paulo Coelho');

insert into BookOrder
values
(101,'Nguyen Hai Nam',1,'2025-01-10','2025-01-15'),
(102,'Tran Bao Ngoc',3,'2025-02-05','2025-02-10'),
(103,'Le Hoang Yen',4,'2025-03-12',NULL);

update Book
set price = price + 50000
where category_id = 1;

update BookOrder
set delivery_date = '2025-12-31'
where delivery_date is null;

set sql_safe_updates = 0;

delete from BookOrder
where order_date < '2025-02-01';

select title,author_name,
case 
	when status = 1 then 'Còn hàng'
	else 'Hết hàng'
    end as status_name
from Book;

select upper(title) as title ,(year(now())- Year(publish_date)) as year  from Book ;

select b.title , b.price , c.category_name 
from Book b
join Category c 
on b.category_id = c.category_id ;

select book_id,title from Book 
order by price desc
limit 2;

select c.category_name from Category c
join Book b 
on b.category_id = c.category_id 
group by c.category_name
having count(b.category_id) >= 2;

select * from Book 
where price > (select avg(price) from Book);

select * from Book b
where b.book_id in (select b1.book_id from BookOrder b1 
						where b1.book_id = b.book_id);

select * from Book b
where b.price = ( select max(b1.price) from Book b1
					where b1.category_id = b.category_id);








