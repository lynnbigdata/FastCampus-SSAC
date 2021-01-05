use ssac;
show tables;
desc items;

use world;

# 인코딩, 디코딩 
# 인코딩 : ascii(영문, 특수문자, 숫자), euc-kr. utf-8
-- 사람:쿼리(코드).   컴퓨터
-- a    (인코딩) ->  0001    
-- a    <-(디코딩)   0001  

-- a    (인코딩) ->  1111

## 5. SELECT FROM 
# 전체 컬럼 데이터 조회
SELECT *
FROM   world.country;

# code, name 세 개의 컬럼 데이터 조회
SELECT code, name
FROM   world.country;

# 데이터베이스 선택 : FROM 절에 world. 을 사용할 필요가 없습니다.
USE    world;
SELECT *
FROM   country;

# alias: 컬럼의 이름을 변경할 수 있습니다.
SELECT code AS country_code, 
       name AS country_name
FROM   country;

# 데이터 베이스, 테이블, 컬럼리스트 확인
show databases;
show tables;
desc city;

## MYSQL의 주석
-- -- : 한줄 주석, --을 한 후에 반드시 한 칸을 띄어서 사용한다.
-- /**/ : 블럭주석  

-- 국가코드와 국가이름을 출력합니다.
/* SELECT code, population
FROM   country;*/

SELECT code, population
FROM   country;

## 7. Operators
# 산술연산자: + 덧셈, - 뺄셈, * 곱셈, / 나눗셈, % 나머지, DIV 몫

# world 데이터베이스에서 각 국가의 국가코드, 국가이름, 인구밀도(1 제곱미터 당 인구수)를 출력하는 쿼리를 작성하세요.

# world 데이터베이스에서 각 국가의 국가코드, 국가이름, 1인당 GNP를 출력하는 쿼리를 작성하세요.

# Like : 특정 문자열이 포함된 데이터를 출력
select code, name, population
from    country
where  code like "%K";

# ORDER BY : 정렬
# 오름차순으로 인구수 순 국가 데이터를 출력해보자
select   code,name, population
from     country
order by population DESC;

# 인구수가 8천만~1억 사이의 국가를 출력
# 인구수 순으로 내림차순해서 출력
select code, name, population
from   country
where  population between 7000*10000 and 10000*10000
order by population desc;

# 여러 컬럼에 sorting 조건을 주어서 출력하는 방법
SELECT   countrycode, name, population
FROM     city
ORDER BY countrycode asc, population asc;

# LIMIT : 조회하는 데이터의 수를 제한할 때 사용
# 인구가 0을 초과하는 국가들 중에서
# 국가의 크기가 가장 큰 국가 상위 5개 국가를 출력하세요
SELECT code, name, surfacearea, population
FROM   country
WHERE  population>0
ORDER BY surfacearea desc
LIMIT 5;

SELECT 
    code, name, surfacearea, population
FROM
    country
WHERE
    population > 0
ORDER BY surfacearea DESC
LIMIT 3 OFFSET 5;
-- LIMIT 5,3; #5개의 데이터를 스킵, 3개의 데이터를 출력 (6-8위)

# DISTINCT : 중복 데이터를 제거해서 출력하는 예약어
# 대륙 이름을 출력
