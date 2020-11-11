/* */

drop table belongs_to;
drop table contains;
drop table catagory;
drop table product;
drop table comments;
drop table completed_transaction;
drop table lists;
drop table bid;
drop table listing;
drop table users;



create table users(
ID char(10),
name varchar2(30),
age int,
gender char(1) check (gender='F' OR gender='M'),
join_date date,
avg_rating number,
primary key (ID)
);

create table listing(
listing_id char(10),
condition varchar2(20),
status varchar2(10),
start_bid number(*,2),
start_time date,
end_time date,
primary key(listing_id));


create table bid(
listing_id char(10),
amount number(*,2),
ID char(10),
primary key(listing_id,amount),
foreign key(listing_id) references listing(listing_id) ON DELETE CASCADE,
foreign key (ID) references users(ID) ON DELETE CASCADE);


create table lists(
ID char(10),
listing_id char(10),
primary key(listing_id),
foreign key (ID) references users(ID) ON DELETE CASCADE,
foreign key (listing_id) references listing(listing_id) ON DELETE CASCADE);


create table completed_transaction(
tid char(10),
sellerid char(10),
buyerid char(10),
listing_id char(10),
price number(*,2),
primary key (tid),
foreign key (sellerid) references users(ID) ON DELETE CASCADE,
foreign key (buyerid) references users(ID) ON DELETE CASCADE,
foreign key (listing_id) references listing(listing_id) ON DELETE CASCADE);

create table comments(
tid char(10),
ratee char(10),
rate int,
primary key(tid,ratee),
foreign key (tid) references completed_transaction(tid) ON DELETE CASCADE,
foreign key(ratee) references users(ID) ON DELETE CASCADE
);


create table product(
pid char(10),
pname varchar2(50),
primary key (pid));

create table contains(
pid char(10),
listing_id char(10),
primary key(pid,listing_id),
foreign key (pid) references product(pid) ON DELETE CASCADE,
foreign key (listing_id) references listing(listing_id) ON DELETE CASCADE);



create table catagory(
label varchar2(50),
primary key (label));


create table belongs_to(
label varchar2(50),
pid char(10),
primary key (label,pid),
foreign key (label) references catagory(label) ON DELETE CASCADE,
foreign key (pid) references product(pid) ON DELETE CASCADE);


create or replace trigger BIDCHECKER
before insert on bid
for each row
DECLARE
MAXBID NUMBER;
STARTBID NUMBER;
AVA VARCHAR2(10);
BEGIN
SELECT status
INTO AVA
FROM LISTING
WHERE listing_id=:new.listing_id;
IF AVA='sold' THEN
RAISE_APPLICATION_ERROR(-20001,'ITEM HAS BEEN SOLD');
END IF;
SELECT MAX(amount)
INTO MAXBID
FROM BID
WHERE listing_id=:new.listing_id;
IF MAXBID>=:new.amount THEN
RAISE_APPLICATION_ERROR(-20001,' AMOUNT LOWER THAN OR EQUAL TO MAX BID FOR NOW');
END IF;
SELECT MAX(start_bid) 
INTO STARTBID
FROM LISTING
WHERE listing_id=:new.listing_id;
IF STARTBID>=:new.amount THEN
RAISE_APPLICATION_ERROR(-20001,' AMOUNT LOWER THAN OR EQUAL TO STARTING BID');
END IF;
END;
/

create or replace trigger CHECKTRANSACTION
before insert on completed_transaction
FOR EACH ROW
DECLARE 
MAXBID NUMBER;
CBUYER CHAR(10);
CSELLER CHAR(10);
BEGIN
SELECT MAX(amount)
INTO MAXBID
FROM BID
WHERE listing_id=:new.listing_id;
IF :new.price!=MAXBID THEN
RAISE_APPLICATION_ERROR(-20001,'WRONG PRICE');
END IF;
SELECT ID
INTO CBUYER
FROM BID
WHERE listing_id=:new.listing_id AND amount=:new.price;
IF CBUYER!=:new.buyerid THEN
RAISE_APPLICATION_ERROR(-20001,'WRONG BUYER BUT RIGHT PRICE');
END IF;
SELECT ID
INTO CSELLER
FROM LISTS
WHERE listing_id=:new.listing_id;
IF CSELLER!=:new.sellerid THEN
RAISE_APPLICATION_ERROR(-20001,'WRONG SELLER');
END IF;
END;
/
/*
// As extremely unstable networking connection to university
// Oracle database and understandably hugh workload for the university 
// database, sometimes changes made by trigger won't be able to commit 
// in one or two hours, so I wrote a function in Java to take 
// place of this trigger. However, when by coincidence I got good 
// connection, meanwhile, university Oracle database is not busy, it works well.
create or replace trigger UPDATERATE
after insert or update or delete on COMMENTS
FOR EACH ROW
DECLARE
PRAGMA AUTONOMOUS_TRANSACTION;
AVGRATING NUMBER;
BEGIN 
SELECT AVG(RATE)
INTO AVGRATING
FROM COMMENTS
WHERE ratee=:new.ratee;
UPDATE USERS SET avg_rating=AVGRATING WHERE ID=:new.ratee;
COMMIT;
END;
/
*/

insert into users values('0000000001','AAA',23,'M',TO_DATE( '10-OCT-2016', 'DD-MON-YYYY' ),0);
insert into users values('0000000002','AAB',25,'M',TO_DATE( '11-OCT-2016', 'DD-MON-YYYY' ),0);
insert into users values('0000000003','AAC',35,'F',TO_DATE( '15-OCT-2016', 'DD-MON-YYYY' ),0);
insert into users values('0000000004','AAD',53,'M',TO_DATE( '12-OCT-2015', 'DD-MON-YYYY' ),0);
insert into users values('0000000005','AAE',43,'F',TO_DATE( '23-OCT-2012', 'DD-MON-YYYY' ),0);
insert into users values('0000000006','AAF',23,'M',TO_DATE( '10-OCT-2016', 'DD-MON-YYYY' ),0);
insert into users values('0000000007','AAG',53,'M',TO_DATE( '10-OCT-2016', 'DD-MON-YYYY' ),0);
insert into users values('0000000008','BBB',22,'M',TO_DATE( '12-OCT-2016', 'DD-MON-YYYY' ),0);
insert into users values('0000000009','CCC',24,'M',TO_DATE( '11-OCT-2015', 'DD-MON-YYYY' ),0);
insert into users values('0000000010','DDD',43,'F',TO_DATE( '21-OCT-2016', 'DD-MON-YYYY' ),0);

insert into listing values('0000000001','new','available',23.54,TO_DATE( '21-OCT-2016', 'DD-MON-YYYY' ),TO_DATE( '25-OCT-2016', 'DD-MON-YYYY'));
insert into listing values('0000000002','new','available',53.54,TO_DATE( '12-OCT-2016', 'DD-MON-YYYY' ),TO_DATE( '26-OCT-2016', 'DD-MON-YYYY'));
insert into listing values('0000000003','new','available',153.54,TO_DATE( '12-OCT-2016', 'DD-MON-YYYY' ),TO_DATE( '26-OCT-2016', 'DD-MON-YYYY'));
insert into listing values('0000000004','new','available',53.54,TO_DATE( '12-OCT-2016', 'DD-MON-YYYY' ),TO_DATE( '26-OCT-2016', 'DD-MON-YYYY'));
insert into listing values('0000000005','new','available',543.54,TO_DATE( '11-OCT-2016', 'DD-MON-YYYY' ),TO_DATE( '29-OCT-2016', 'DD-MON-YYYY'));
insert into listing values('0000000006','pre-ownered','available',1543.54,TO_DATE( '11-OCT-2015', 'DD-MON-YYYY' ),TO_DATE( '29-OCT-2016', 'DD-MON-YYYY'));
insert into listing values('0000000007','new','available',31.24,TO_DATE( '11-OCT-2016', 'DD-MON-YYYY' ),TO_DATE( '29-OCT-2016', 'DD-MON-YYYY'));
insert into listing values('0000000008','new','available',341.24,TO_DATE( '10-OCT-2016', 'DD-MON-YYYY' ),TO_DATE( '29-OCT-2016', 'DD-MON-YYYY'));
insert into listing values('0000000009','broken','available',3.43,TO_DATE( '11-OCT-2016', 'DD-MON-YYYY' ),TO_DATE( '29-OCT-2016', 'DD-MON-YYYY'));	
insert into listing values('0000000010','broken','available',13.43,TO_DATE( '11-OCT-2016', 'DD-MON-YYYY' ),TO_DATE( '29-OCT-2016', 'DD-MON-YYYY'));	


insert into bid values ('0000000001',25.42,'0000000001');
insert into bid values ('0000000001',27.42,'0000000002');
insert into bid values ('0000000001',29.42,'0000000003');
insert into bid values ('0000000001',31.42,'0000000004');
insert into bid values ('0000000001',35.42,'0000000001');
insert into bid values ('0000000001',45.42,'0000000001');
insert into bid values ('0000000001',47.42,'0000000002');
insert into bid values ('0000000001',49.42,'0000000003');
insert into bid values ('0000000001',51.42,'0000000004');
insert into bid values ('0000000001',75.42,'0000000001');	
insert into bid values ('0000000007',32.42,'0000000006');
insert into bid values ('0000000007',35.42,'0000000004');	
insert into bid values ('0000000007',37.42,'0000000006');	
insert into bid values ('0000000007',39.42,'0000000002');	
insert into bid values ('0000000007',42.42,'0000000006');	
insert into bid values ('0000000003',165.32,'0000000001');
insert into bid values('0000000003',170.00,'0000000005');
insert into bid values('0000000003',171.43,'0000000001');

insert into lists values('0000000010','0000000001');
insert into lists values('0000000001','0000000007');
insert into lists values('0000000002','0000000003');

insert into completed_transaction values('t000000001','0000000010','0000000001','0000000001',75.42);
insert into completed_transaction values('t000000002','0000000002','0000000001','0000000003',171.43);

insert into comments values('t000000001','0000000001',4);
insert into comments values('t000000001','0000000010',3);
insert into comments values('t000000002','0000000001',2);
insert into comments values('t000000002','0000000002',1);

insert into product values ('0000000001','cheese');
insert into product values ('0000000002','ramen');
insert into product values ('0000000003','TV');

insert into contains values ('0000000001','0000000001');
insert into contains values ('0000000002','0000000001');
insert into contains values ('0000000003','0000000001');

insert into catagory values ('All');

insert into belongs_to values ('All','0000000001');


-- (3). a. 
(select distinct listing_id from listing
minus
select distinct listing_id from bid);
-- (3). b. 
select * from users
where avg_rating=(
select max(avg_rating)
from users);
-- (3). c.
create view ubids as 
select ID ,count(listing_id) as counts
from bid
group by ID;
select * from users NATURAL JOIN ubids
where counts=(
select max(counts)
from ubids);
-- (3). d.
select * from completed_transaction
where price=(
select max(price)
from completed_transaction);
-- (3). e.
create view cbids as
select listing_id, count(bid_no) as counts
from bid
group by listing_id;
select * from listing NATURAL JOIN cbids
where counts=(select max(counts) from cbids);

