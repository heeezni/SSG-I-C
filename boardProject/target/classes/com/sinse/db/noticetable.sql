-- DBA (데이터베이스, 계정생성)
create database spring4;
use spring4;
create user 'spring4'@'%' identified by '1234';
grant all privileges on spring4.* to 'spring4'@'%' with grant option;
flush privileges 
-- notice table생성
create table notice(
    notice_id int primary key auto_increment,
    title varchar(100),
    writer varchar(20),
    content text,
    regdate timestamp default now(),
    hit int default 0
 );
