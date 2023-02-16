
--verchar2 -> 영어는 1byte 한글은 3byte
create table market(
store_id number(5) primary key,
store_name varchar2(30) not null,
store_addr varchar2(50)not null,
store_tel char(13),
store_sales number(6) check(store_sales>=1000)
);

drop table market;

Insert into market
values (12345,'털보네슈퍼','대구시 중국 중앙대로','053-123-4567',1000);

select *
from market;

create table product(
product_id number(4) primary key,
product_name varchar2(30) not null,
product_price number(5) check (product_price>=100),
product_keep char(1) check (product_keep in('F', 'C')),
                                    --(product_keep = 'F' or (product_keep = 'C'),
store_id number(5),
constraint market_store_id_fk foreign key (store_id) references market(store_id)
);

insert into product
values(1000,'귤',2000,'C',12345);

insert into product
values(1001,'사과',3000,'C',12345);

insert into product
values(1002,'고등어',4000,'F',12345);

insert into product
values(1003,'만두',10000,'F',12345);


insert into product
values(1004,'얼음',500,'F',12345);

select *
from product;

create table info(
info_id number(15) primary key,
info_name varchar2(9)not null,
info_pw number(10) not null,
store_id number(5) references market(store_id)
);

insert into info
values(1234567,'두식', 123456,12345);

insert into info
values(1234568,'행식', 12345456,12345);

insert into info
values(1234577,'필식', 12344356,12345);

select *
from info;

drop table info;

create table prolist(
prolist_id varchar2(10) primary key,
product_id number(4) references product(product_id),
prolist_count number(1) not null,
store_id number(5) references market(store_id),
info_id number(15) references info(info_id),
prolist_delivery char(1) default 'R' check (prolist_delivery in ('R', 'D', 'F'))
);

drop table prolist;

insert into prolist
values('cart0001', 1000, 9, 12345, 1234567, 'R');

insert into prolist
values('cart0002', 1003, 5, 12345, 1234568, 'D');

insert into prolist
values('cart0003', 1004, 1, 12345, 1234568, 'R');

insert into prolist
values('cart0004', 1003, 3, 12345, 1234567, 'R');

insert into prolist
values('cart0005', 1002, 7, 12345, 1234577, 'F');

insert into prolist
values('cart0006', 1003, 3, 12345, 1234568, 'F');

insert into prolist
values('cart0007', 1000, 3, 12345, 1234577, 'D');

insert into prolist
values('cart0008', 1004, 1, 12345, 1234568, 'R');

insert into prolist
values('cart0009', 1000, 6, 12345, 1234567, 'R');

insert into prolist
values('cart0010', 1001, 1, 12345, 1234577, 'F');

insert into prolist
values('cart0011', 1002, 3, 12345, 1234567, 'R');

insert into prolist
values('cart0012', 1003, 7, 12345, 1234567, 'D');

insert into prolist
values('cart0013', 1000, 4, 12345, 1234568, 'D');

insert into prolist
values('cart0014', 1001, 3, 12345, 1234577, 'R');

insert into prolist
values('cart0015', 1003, 2, 12345, 1234567, 'F');


select *
from market
where store_id = 12345;

select m.store_name,m.store_sales, p.product_name
from market m, product p
where m.store_id = p.store_id
and m.store_id=12345;

select p.prolist_id, p.prolist_count, r.product_name, (r.product_price*p.prolist_count), p.prolist_delivery
from prolist p natural join product r
where store_id = (
                        select store_id
                        from market
                        where store_name = '털보네슈퍼'
                        );

select p.prolist_id, p.prolist_count, r.product_name, (r.product_price*p.prolist_count), p.prolist_delivery
from prolist p natural join product r
where info_id = (
                        select info_id
                        from info
                        where info_name = '두식'
                        );

select sum(prolist_count)
from prolist
where product_id = 1000;






