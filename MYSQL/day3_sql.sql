###1. Join 
-- 여러 개의 테이블을 모아서 보여줄 때 사용한다.
-- INNER JOIN, LEFT JOIN, RIGHT JOIN
-- OUTER JOIN은 UNION을 이용해서 할 수 있다.

# create table
create database test2;
use    test2;

create table user (
	user_id int primary key auto_increment,
    name varchar(30)
);

create table addr(
	addr_id int primary key auto_increment,
    addr varchar(30),
    user_id int
);

show tables;

# insert data
insert into user(name)
values("jin"), ("po"), ("alice");
select * from user;

insert into addr(addr, user_id)
values      ("seoul",1), ("pusan",2), ("daegu",4), ("seoul",5);
select * from addr;

 ## INNER JOIN
 -- 두 테이블 사이에 공통된 값이 없는 ROW는 출력하지 않습니다.
 
 # JOIN 쿼리만 실행하면 user와 addr 테이블의 모든 데이터를 매핑하여 출력합니다.
 # user의 row가 3개, addr의 row가 4개이므로 총 3*4=12개의 row가 출력됩니다.
 
 select *
 from   user
 join   addr;
 
 # user_id를 기준으로 JOIN하여 결과를 출력하려면 WHERE 절 또는 ON 절에서 user 테이블과 addr 테이블의 같은 user_id 만 출력해야 합니다.
 select *
 from   user
 join   addr
 where  user.user_id = addr.user_id;
 
 select     *
 from       user
 inner join addr
 on         user.user_id = addr.user_id;
 
 select *
 from   user, addr #,addr2,addr3
 where  user.user_id = addr.user_id;
 
 ## LEFT JOIN(차집합)
 -- 왼쪽 테이블을 기준으로 왼쪽 테이블의 모든 데이터가 출력되고 매핑되는 키값이 없으면 NULL로 출력됩니다.
 
 # 두 테이블을 합쳐 id, name, addr 출력
 select    user.user_id, user.name, addr.addr
 from      user
 left join addr
 on        user.user_id = addr.user_id;
 
 ## RIGHT JOIN(차집합)
 -- 오른쪽 테이블을 기준으로 오른쪽 테이블의 모든 데이터가 출력되고 매핑되는 키값이 없으면 NULL로 출력된다.
 select     addr.user_id, user.name, addr.addr
 from       user
 right join addr
 on         user.user_id = addr.user_id;
 
 ## 2. UNION
-- UNION은 SELECT 문의 결과 데이터를 하나로 합쳐서 출력합니다. 이 때, 컬럼의 갯수와 타입, 순서가 같아야 합니다.
-- UNION은 자동으로 distinct를 하여 중복을 제거해 줍니다. 
-- 중복제거를 안하고 컬럼 데이터를 합치고 싶으면 UNION ALL을 사용합니다.
-- 또한 UNION을 이용하면 Full Outer Join을 구현할수 있습니다.

# UNION
# user 테이블의 name 컬럼과 addr 테이블의 addr 컬럼의 데이터를 하나로 합쳐서 출력
 select name #, user_id :컬럼의 개수가 맞지 않으므로 오류
 from   user 
 union
 select addr
 from   addr;
 
# UNION ALL
# 중복데이터를 제거하지 않고 결과 데이터 합쳐서 출력
 select name 
 from   user 
 union all
 select addr
 from   addr;
 
 ## FULL OUTER JOIN(합집합)
 # union을 이용하여 full outer join 구현
 select    user.user_id, user.name, addr.addr
 from      user
 left join addr
 on        user.user_id = addr.user_id
 union 
 select     addr.user_id, user.name, addr.addr
 from       user
 right join addr
 on         user.user_id = addr.user_id;
 
 -- 혼자 풀어보기
 ## JOIN 실습문제
 # 국가코드, 국가이름, 도시이름, 국가인구, 도시인구 출력
 # 국가 0, 도시 x : inner join
 # 컬럼추가 : 해당 도시가 국가에서 몇 %의 인구가 거주하는지 출력(소수 둘째자리까지)
 # 도시 인구가 900만 이상이 사는 도시를 도시인구수 순으로 내림차순하여 정렬하고 출력
 use world;
 select   city.countrycode, 
		  country.name                                      as country_name,
		  city.name                                         as city_name,
          country.population                                as country_population,
          city.population 								    as city_population,
          round(city.population/country.population * 100,2) as rate
 from     city
 join     country
 on       city.countrycode = country.code
 having   city.population >= 900*10000 #where: from 다음에 사용
 order by rate desc;
 -- order by city.population desc;
 -- where은 기본적인 조건절로서 우선적으로 모든 필드를 조건에 둘 수 있다. 
 -- 하지만 having은 group by 된 이후 특정한 필드로 그룹화 되어진 새로운 테이블에 조건을 줄 수 있다.
 
 select *
 from   country;
 
 # Error Code: 1222. The used SELECT statements have a different number of columns
 select name as city_name, population as city_population
 from   city
 union
 select code as country_code, name as country_name, population as country_population
 from   country;
 
 # staff_id, staff_fullname, amount를 출력
 use sakila;
 
 select   payment.staff_id, 
		  concat(staff.first_name," ",staff.last_name) as full_name, 
          payment.amount
 from     payment
 join     staff
 on       payment.staff_id = staff.staff_id
 group by full_name;
 
 select staff_id, amount
 from   payment;
 
 select staff_id, first_name, last_name
 from   staff;
 
# 테이블 세개 조인하기
# 국가별, 도시별, 언어의 사용율을 출력
use world;
select * 
from   countrylanguage;
select *
from   country;
select *
from   city;

select   country.name       		as country_name, 
		 city.name          		as city_name, 
         countrylanguage.language   as language,
         countrylanguage.percentage as percentage,
         country.population 		as country_population, 
         city.population    		as city_population
from     country
join     city
on       country.code = city.countrycode
join     countrylanguage
on       country.code = countrylanguage.countrycode;

# join on 구문 없이 join하기
select   country.name       		as country_name, 
		 city.name          		as city_name, 
         country.population 		as country_population, 
         city.population    		as city_population,
         countrylanguage.language   as language,
         countrylanguage.percentage as percentage
from     country, city, countrylanguage
where    country.code = city.countrycode = country.code = countrylanguage.countrycode;

select   country.name       						  			as country_name, 
		 city.name          									as city_name, 
         countrylanguage.language   							as language,
         countrylanguage.percentage 							as percentage,
         city.population    									as city_population,
         round(city.population*countrylanguage.percentage/100)  as language_population
from     country
join     city
on       country.code = city.countrycode
join     countrylanguage
on       country.code = countrylanguage.countrycode;

## 3. subquery
-- sub query는 query 문 안에 있는 query를 의미합니다. 
-- SELECT절 FROM절, WHERE 등에 사용이 가능합니다.

# select
# 1개의 row에 컬럼으로 전체 국가 수, 전체 도시 수, 전체 언어 수를 출력
# 가로로 출력
use world;
select
	(select count(*) 				 from country)			as total_country,
	(select count(*) 				 from city)				as total_city,
	(select count(distinct(language))from countrylanguage)  as total_lang
from dual;

# 컬럼명을 바꿀 순 없을까?
# 위의 결과를 피봇해서 출력 (세로로 출력)
select "total_country", (select count(*) from country) as count
from dual
union
select "total_city", (select count(*) from city) as count
from dual
union
select "total_lang", (select count(distinct(language)) from countrylanguage) as count
from   dual;

###보충###
# FROM
# 인구가 800만 이상이 되는 도시의 국가콛, 국가이름, 도시이름, 도시인구수 출력



# where
# 900만 이상의 인구가 있는 도시 국가의 국가코드, 국가이름, 대통령이름을 출력하세요.
select countrycode from city where population >= 900*10000;
select code, name, headofstate
from country
where code in (
	select countrycode
    from   city
    where  population >= 900*10000
);


# 지역과 대륙별 사용하는 언어의 개수를 출력

##########

## 4. VIEW
-- 가상 테이블로 특정한 쿼리를 실행한 결과 데이터(주소값에 해당하는 데이터)만 보고자 할때 사용합니다. 
-- 실제 데이터를 저장하고 있지는 않습니다. 
-- 한마디로 특정 컬럼의 데이터(주소값에 해당하는 데이터)를 보여주는 역할만 합니다. 
-- 뷰를 사용 함으로 쿼리를 더 단순하게 만들수 있습니다. - 자주 사용하는 쿼리를 줄여준다.
-- 한번 생성된 뷰는 수정이 불가능 하며 인덱스 설정이 불가능 합니다. - 참조기능이므로

# 국가코드, 국가이름, 도시이름이 있는 뷰를 생성
# join 만들고 --> create로 view 만들기
create	view city_country as # 뷰 생성
select  city.countrycode, 
		country.name as country_name, 
        city.name 	 as city_name
from	city, country
where	city.countrycode = country.code;

select * from city_country;

# 국가코드, 국가이름, 도시이름, 사용언어를 출력
select	country.code,
		country.name as country_name,
        city.name as city_name, 
        countrylanguage.language
from	city,country,countrylanguage
where	country.code=city.countrycode
		and city.countrycode = countrylanguage.countrycode;
        
select	cc.countrycode, cc.country_name, cc.city_name, countrylanguage.language
from	city_country as cc, countrylanguage
where	cc.countrycode = countrylanguage.countrycode;

## View 실습 문제
# step 1. 한국의 인구수보다 많은 국가의 국가코드, 국가이름, 국가 인구수, 도시이름, 도시 인구수를 출력하고 도시 인구수 순으로 정렬하여 출력
-- 1. 한국의 인구수를 출력 : query1
select population from country where code = "KOR";
-- 2. country: where > (query1) : query2
select 	code, name, population
from	country
where	population >= (select population from country where code = "KOR");
-- 3. city join (query2)
select	city.countrycode, sub.name, sub.population, city.name, city.population
from	city
join	(
	select 	code, name, population
	from	country
	where	population >= (select population from country where code = "KOR")
) as sub
on city.countrycode = sub.code
order by city.population desc;

#이게 맞나? 결과값 다르게 나옴 -- 왜 아닌지 해보기!
select	*
from	country;

select  country.code,
		country.name,
        country.population,
        city.name,
        city.population
from	country, city
where	country.population >= (select population from country where code = "KOR")
order by city.population desc;

# step 2. 한국의 인구수보다 많은 국가의 국가코드, 국가이름, 인구수를 저장하는 뷰를 생성
create 	view morethan_kor_pop as
select 	code, name, population
from	country
where	population >= (select population from country where code = "KOR");

select * from morethan_kor_pop;

# step 3. 생성한 뷰를 활용하여 step 1의 결과를 출력
select		city.countrycode, sub.name, sub.population, city.name, city.population
from		city
join		morethan_kor_pop as sub
on 			city.countrycode = sub.code
order by	city.population desc;

## INDEX
-- 테이블에서 데이터를 검색할때 빠르게 찾을수 있도록 해주는 기능입니다.
-- 장점: 검색속도가 빨라짐
-- 단점: 1) 저장공간을 10% 정도 더 많이 차지. 2)INSERT, DELETE, UPDATE 할때 속도가 느려짐
-- 사용법: SELECT시 WHERE 절에 들어가는 컬럼을 Index로 설정하면 좋다.
-- 내부 작동 원리 (B-Tree): 루트노드와 리프노드의 계층적 구조로 루트노드를 이용하여 리프노드에서의 데이터를 빠르게 찾을수 있는 자료구조 알고리즘.

# employees 데이터 저장하기
create	database employees;
show  	databases;
# employees 데이터 베이스에서 실행
use	   	employees;
show	tables;
select	count(*) from salaries; # Error Code: 2013. Lost connection to MySQL server during query: 데이터가 많아서 뜨는 에러
select * from salaries limit 10;

# 인덱스 확인
show	index from salaries;
-- * Primary key로 설정된 컬럼은 클러스터형 인덱스가 자동으로 생성됩니다.

# 쿼리 실행
# workbench 사용시 데이터 출력 속도가 느려 인덱스의 성능을 정확하게 확인할수 없습니다.
# sequal pro 또는 heidisql 을 사용해서 확인해보시면 좋습니다.
select * from salaries where from_date < "1986-01-01"; # 45.5
select * from salaries where to_date < "1986-01-01"; # 788

# 실행 계획
-- 실행계획 : 쿼리를 실행 할 때 어떻게 내부적으로 실행되는지 확인
# index를 사용하지 않는것을 확인할수 있습니다.
explain select * from salaries where from_date < "1986-01-01";
explain select * from salaries where to_date   < "1986-01-01";

# 인덱스 생성
create index fdate on salaries (from_date); 
create index tdate on salaries (to_date); 

## 6. TRIGGER 
-- 특정 테이블을 감시하고 있다가 설정한 조건에 감지되면 지정해 놓은 쿼리가 자동으로 실행되도록 하는 방법
create 	database tr;
use 	tr;

# table 두 개 생성 : chat, backup
create table chat(
	chat_id int primary key auto_increment,
    msg varchar(200)
);

create table backup(
	backup_id	int primary key auto_increment,
    chat_id 	int,
    backup_msg 	varchar(200),
    backup_date timestamp default current_timestamp
);
show tables;

# 트리거 생성
delimiter |
	create trigger chat_backup
	before delete on chat for each row
	begin
		insert into backup(chat_id, backup_msg)
		values (old.chat_id, old.msg);
end
|

# 트리거 리스트 확인
show triggers;

# chat 테이블에 데이터 추가
insert into chat(msg)
values ("hello"),("hi"),("hello");
select * from chat;

# delete 쿼리 실행해서 트리거 동작 확인
delete from chat 
where		msg = "hello"
limit 		10;
select * from chat;

# 백업 테이블 확인
select * from backup;

## 7.backup
# workbench를 이용해서 백업하기
# .csv, .sql

#(1) Backup의 종류

# Hot Backup
-- 데이터 베이스를 중지하지 않은 상태로 데이터 백업
-- 백업하는 동안 서비스가 실행
-- 백업하는 동안 데이터가 변경되어 완전한 백업이 안될수 있음

# Cold Backup
-- 데이터 베이스를 중지한 상태로 데이터 백업
-- 안정적으로 백업이 가능
-- 백업하는 동안 서비스가 중단되어야 함

# Logical Backup
-- SQL 문으로 백업
-- 느린 속도의 백업과 복원
-- 디스크 용량을 적게 사용
-- 작업시 시스템 자원을 많이 사용
-- 문제 발생에 대한 파악이 쉬움
-- 서버 OS 호환이 잘됨

# Physical Backup
-- 파일 차체를 백업
-- 빠른 속도의 백업과 복원
-- 디스크 용량 많이 사용
-- 작업시 시스템 자원을 적게 사용
-- 문제 발생에 대한 파악과 검토가 어려움
-- 서버 OS 호환이 잘안될수 있음

use world;

create 	database backup;
use		backup;
show	tables;
select * from backup;