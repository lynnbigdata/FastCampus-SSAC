### DDL
# 1byte = 8bit = 0000 0000 = 2^8 = 256

use ssac;
show tables;

##1. DATATYPE: 컴퓨터의 자원을 효율적으로 사용하기 위해 사용되는 방법/숫자형,문자형,날짜형 등/저장할 데이터의 타입을 지정하면 저장공간의 할당을 효율적으로 할 수 있어 DBMS의 성능을 증가시킬 수 있는 장점이 있다.
#(1)Numberic: 숫자형 데이터 타입 
#**integer types: 정수 타입**
#TINYINT  : 1 Bytes, -128~127(Minimum/Maximum Value Signed),     0~255(Minimum/Maximum Value Unsigned)
#SMALLINT : 2 Bytes, -32678~32767(Minimum/Maximum Value Signed), 0~65535(Minimum/Maximum Value Unsigned)
#MEDIUMINT: 3 Bytes, -8388608~8388607(Minimum/Maximum Value Signed), 0~1677215(Minimum/Maximum Value Unsigned)
#INT      : 4 Bytes, -2147483648~2147483647(Minimum/Maximum Value Signed), 0~4294967295(Minimum/Maximum Value Unsigned)
#BIGINT   : 8 Bytes, -2^63~2^63-1(Minimum/Maximum Value Signed), 0~2^64-1(Minimum/Maximum Value Unsigned)
-- 테이블의 컬럼에 어느 정도 범위로 데이터가 들어가는지 확인하여 컬럼의 데이터 타입을 결정해야 합니다.

# TINYINT 테이블을 생성해서 해당 범위 값이 들어가는지 확인하자
create table number1(
	data tinyint
);
desc number1; # type tinyint 
-- < DESC>. : 특정 테이블에 어떤 칼럼이 있는지 구조가 무엇인지 조회하는 명령어.
#-128~127
insert into number1 value (127);
select *
from   number1;
#insert into number1 value (128); # out of values

create table number2(
	data tinyint unsigned
);
desc number2;
#0~255
insert into number2 value (128);
select * 
from   number2;
 
#**float types: 실수 타입**
# 소수점을 나타내기 위한 데이터 타입
# FLOAT (4byte)
# DOUBLE(8byte)

create table number3(
	data float
);
desc number3;
insert into number3 value (12.3456789);
select * from number3;

create table number4(
	data double
);
desc number4;
insert into number4 value (1234567890.1234567890);
select * from number4;

# 전체 자리수와 소수점 자리를 설정
# DECIMAL, NUMERIC
# DECIMAL(5,2): 전체 자리수 5개, 소수점 2개
create table number5(
	data decimal(5,2)
);
desc number5;
insert into number5 value(1234.56789); #out of range value for column 'data' at row 1
insert into number5 value(123.456789); #Data truncated for column 'data' at row 1
select * from number5;

### CHAR & VARCHAR
## CHAR:  고정길이 문자열 데이터 타입으로 255(2의 8승)자 까지 입력 가능/
## VARCHAR: 가변길이 65535(2의16승)까지 입력 가능 /글자 개수보다 1바이트 더 사용/

# CHAR
create table str1(
	data char(256)
); # column length too big for column 'data'(max=255)
create table str1(
	data varchar(255)
);
insert into str1 value("문자열입력");

#TEXT : 크기가 큰 문자열을 저장할 때 사용한다.

### DATE & DATETIME
## DATE : 날짜를 저장하는 데이터 타입이며, 기본 포멧은 "년-월-일"
## DATETIME : 날짜와 시간을 저장하는 데이터 타입, 기본 포맷은 "년-월-일 시:분:초"alter
## TIMESTAMP : 날짜와 시간을 저장하는 데이터 타입/ 날짜를 입력하지 않으면 현재 날짜와 시간을 자동으로 저장할 수 있다.
## TIME : 시간을 저장하는 데이터 타입, 기본 포멧은 "시:분:초"
## YEAR :

### 2. Constraint: 제약조건
## NOT NULL: NULL 값(비어있는 값)을 저장할 수 없다.
## UNIQUE: 같은 값을 저장할 수 없다.
## PRIMARY KEY: NOT NULL과 UNIQUE 제약조건을 동시에 만족해야 한다. 컬럼에 비어있는 값과 동일한 값을 저장할 수 없다. 하나의 테이블에 하나의 컬럼만 조건을 설정할 수 있다.
## FOREIGN KEY: 다른 테이블과 연결되는 값이 저장된다.
## DEFAULT: 데이터를 저장할 때 해당 컬럼에 별도의 저장값이 없으면 DEFAULT로 설정된 값이 저장된다.
## AUTO_INCREMENT: 주로 테이블의 PRIMARY KEY 데이터를 저장할 때 자동으로 숫자를 1씩 증가시켜 주는 기능으로 사용한다.

# CREATE
# 데이터 베이스 생성
create database test;

# 테이블 생성
# 제약조건이 없는 테이블 생성
use test;
create table user1(
	user_id int(20),
    name varchar(30),
    email varchar(30),
    age int,
    rdate date
);
desc user1;
# 제약조건이 있는 테이블 생성
create table user2(
	user_id int primary key auto_increment, #nullx primary key #1씩 증가하면서 데이터 들어감
    name varchar(30) not null, # name값이 비어있으면 쿼리문 에러c
    email varchar(30) not null unique, # unique값만 저장된다
    age int default 30, #
    rdate timestamp
);
desc user2;
select now(); #2021-01-06 10:37:09

## ALTER: 데이터 베이스나 테이블을 수정할 때 사용한다.
# 데이터 베이스의 인코딩 방식 수정
show variables like "character_set_database"; #utf8mb4
alter database test character set = ascii; ## 안바뀌는데???
alter database test character set = utf8mb4;

# 테이블 데이터 수정
# ADD, MODIFY, DROP
desc user2;
alter table user2 add tmp TEXT;
alter table user2 modify column tmp int;
alter table user2 drop tmp;

# DROP
# 데이터 베이스를 생성해서 삭제
create database tmp;
show databases;
drop database tmp;

# 테이블 생성 후 삭제
create table tmp (id int);
show tables;
drop table tmp;

# CRUD : C(create) : INSERT
desc user1;
insert into user1(user_id, name, email, age, rdate) 
value (1,"jin","jin@gmail.com",32,now());
select * from user1;
insert into user1(user_id, name, email, age, rdate) 
value (2,"andy","andy@gmail.com",25,'2017-02-23')
,(3,"peter","peter@gmail.com",45,'2018-02-23')
,(4,"john","john@gmail.com",26,'2019-02-23')
,(5,"angela","angela@gmail.com",27,'2020-02-23')
,(6,"po","po@gmail.com",35,'2021-02-23')
;
select * from user1;

select * 
from user1
where rdate >= "2019-01-01";

desc user2;

insert into user2(name, email)
value ("alice", "alice@naver.com");

select * from user2;

insert into user2(name,email,age)
value ("alice2","alice@naver.com", 25); #Duplicate entry

# select된 결과 insert
use world;

select countrycode, name, population
from city
where population >= 900*10000
order by population;

create table city_900(
	countrycode char(3),
    name varchar(20),
    population int
);

desc city_900;

insert into city_900
select countrycode, name, population
from city
where population >= 900*10000
order by population;

select * from city_900;

##연습문제
# 한국 도시의 도시 이름, 인구 수를 저장하는 테이블을 생성
# 생성된 테이블에 데이터를 저장
use world;

select name, population
from city
where countrycode = "kor";

desc city;

create table city_kor(
	name varchar(35),
    population int
);

insert into city_kor
select name, population
from city
where countrycode = "kor";

select * from city_kor;

# 미국에서 사용되는 언어와 해당 언어의 비율을 저장하는 테이블을 생성
# 생성된 테이블에 데이터를 저장

select language, percentage
from countrylanguage
where countrycode = "USA";

desc countrylanguage;

create table languages_usa(
	language varchar(30),
    percentage decimal (4,1)
);
desc languages_usa;

insert into languages_usa
select language, percentage
from countrylanguage
where countrycode = "USA";

select * from languages_usa;


## UPDATE SET
use test;
select * from user1;

# jin 이름을 가지고 있는 사람의 나이를 20으로 변경
update user1
set age=20
where name="jin"
limit 1;

desc user1;

select * from user1 where name="jin";

select * from user1;

# 쿼리 프로세스 확인
show processlist;
kill 11;

# 나이가 30세 이하인 경우 나이를 모두 21세로 변경하고 rdate를 현재 날짜로 변경하세요.
select * from user1;

update user1
set age=21, rdate=now()
where age <= 30
limit 4;

select version();

## 6. DELETE & TRUNCATE
## DELETE : 데이터 삭제
select * from user1;

# 이름의 가장 앞글자가 j로 시작하는 데이터 삭제
delete from user1
where name like "j%"
limit 5;

select * from user1 where name like "j%";

## TRUNCATE: 테이블의 스키마를 남기고 모든 데이터를 삭제 (테이블 초기화)
truncate user1;
select * from user1;

# CRUD : insert, select, update, delete

## 7. FOREIGN KEY(외래키)
# 데이터의 무결성(data integrity)을 지킬 수 있다.
# 데이터 무결성: 완전한 수명 주기를 거치며 데이터의 정확성과 일관성을 유지하고 보증하는 것

# user  : user_id(pk), name(varchar), addr(varchar)
# money : money_id(pk), income(int), user_id(fk)

# user  : user_id : 1,2,3
# money : user_id : 1,2,4(무결성이 깨졌다!)

# fk : money.user_id -> (참조) user.user_id

create table user(
	user_id int primary key auto_increment,
    name varchar(20),
    addr varchar(20)
);
desc user;
create table money(
	money_id int primary key auto_increment,
    income int,
    user_id int
);
desc money;

insert into user(name, addr)
values ("andy","seoul"),("po","pusan");
select * from user;

insert into money(income, user_id)
values (1000,1),(2000,2); #(2000,3)
select * from money;
truncate money;

# fk 설정 : alter, create table
alter table money add constraint fk_user
foreign key (user_id)
references user (user_id);

desc money;

# fk 설정 : create table
drop table money;
create table money(
	money_id int primary key auto_increment,
    income int,
    user_id int,
    foreign key (user_id) references user (user_id)
);
desc money;
insert into money(income, user_id)
values (1000,1),(2000,3); #(2000,3)
select * from money;