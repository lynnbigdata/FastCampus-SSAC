##Quiz
#Quiz 1. 국가 코드별 도시의 갯수를 출력하세요. (상위 5개를 출력)
#rank 컬럼을 적용해보자
use world;
select *
from city;

set @RANK = 0;
select   @RANK := @RANK +1 as ranking, countrycode, count(*) as count
from     city
group by countrycode # rank가 매겨진 상태에서 groupby를 하니 ranking이 꼬임
order by count desc
limit 5;

##???
select   @RANK := @RANK +1 as ranking, countrycode, count(*) as count
from (
	select   countrycode, count(*) as count
	from     city
	group by countrycode # rank가 매겨진 상태에서 groupby를 하니 ranking이 꼬임
	order by count desc
	limit 5
    ) as sub;

#Quiz 2. 대륙별 몇개의 국가가 있는지 대륙별 국가의 갯수로 내림차순하여 출력하세요.
select   continent, count(continent) as count
from     country
group by continent
order by count desc;

#Quiz 3. 대륙별 인구가 1000만명 이상인 국가의 수와 GNP의 평균을 소수 둘째 자리에서 반올림하여 첫째자리까지 출력하세요.
select   continent, count(continent) as count, round(sum(gnp)/count(gnp),1) as avg_gnp  # avg(gnp) = sum(gnp)/count(gnp)
from     country
where    population >= 1000*10000
group by continent 
order by avg_gnp desc;

#Quiz 4. city 테이블에서 국가코드(CountryCode) 별로 총인구가 몇명인지 조회하고 총인구 순으로 내림차순하세요. (총인구가 5천만 이상인 도시만 출력)
select   countrycode, sum(population) as population
from     city
group by countrycode
order by population desc;

#Quiz 5. countrylanguage 테이블에서 언어별 사용하는 국가수를 조회하고 많이 사용하는 언어를 6위에서 10위까지 조회하세요.
select   language, count(language) as count
from     countrylanguage
group by language # 특정 
order by count desc
limit    5 offset 5; # offset 5: 5개를 스킵하고 limit 5: 5개를 출력

#Quiz 6. countrylanguage 테이블에서 언어별 20개 국가 이상에서 사용되는 언어를 조회하고 언어별 사용되는 국가수에 따라 내림차순하세요.
#where: groupby 시행 전 & having: groupby 시행 후

select   language, count(*) as count
from     countrylanguage
group by language
having   count >= 20
order by count desc;

## where 절로 하면 오류 뜸 !!!!!
select   language, count(*) as count
from     countrylanguage
where    count >= 20
group by language
order by count desc;


#Quiz 7. country 테이블에서 대륙별 전체 표면적크기를 구하고 표면적 크기 순으로 내림차순하세요.
select   Continent, round(sum(SurfaceArea), 0) as SurfaceArea
from     country
group by Continent
order by SurfaceArea desc;

#혼자풀어보기
#Quiz 8. World 데이터 베이스의 countrylanguage에서 언어의 사용 비율이 90%대(90 ~99.9)의 사용율을 갖는 언어의 갯수를 출력하세요.
select count(distinct(language))
from   countrylanguage
where  percentage between 90 and 99.9;

select language, percentage, truncate(percentage * 0.1,0)*10
from   countrylanguage;

select language, percentage
from   countrylanguage
where  truncate(percentage * 0.1,0)*10=90;

#어려운 문제
#다시 풀어보기
#계속 오류남
#Quiz 9. 1800년대에 독립한 국가의 수와 1900년대에 독립한 국가의 수를 출력하세요.
-- 1. indepyear: 1800, 1900으로 출력되는 컬럼을 만든다.
-- 2. 만든 컬럼으로 group by, count()
-- 3. 만든 컬럼에서 1800, 1900년대 데이터를 남깁니다.

select count(indepyear),
case
when indepyear >= 1900 then 1900
when indepyear >= 1800 then 1800
else "0"
end as indepyear_ages
from country
group by indepyear_ages
having indepyear_ages > 0;

-- having indepyear_ages in (1800,1900);
-- having ipa >0;
-- where  indepyear >= 1800

#Quiz 10. sakila의 payment 테이블에서 월별 총 수입을 출력하세요.
# payment_date를 date_format 함수로 "년-월" 포맷으로 변경
# 변경된 포맷 컬럼으로 group by

use sakila;
select   date_format(payment_date,"%Y-%m") as monthly,
	     sum(amount) as amount
from     payment
group by monthly;

select   category, sum(price) as price2
from     film_list
group by category
order by price2 desc
limit 3;

#Quiz 11. actor 테이블에서 가장 많이 사용된 first_name을 아래와 같이 출력하세요.
-- 가장 많이 사용된 first_name의 횟수를 먼저 구하고, 횟수를 Query에 넣어서 결과를 출력하세요.
select   first_name, count(*) as count
from     actor
group by first_name
order by count desc
limit 1;

select   first_name
from     actor
group by first_name
having   count(*) = 4;

#Quiz 12. film_list 뷰에서 카테고리별 가장 많은 매출을 올린 카테고리 3개를 매출순으로 정렬하여 아래와 같이 출력하세요.
select   category
from     film_list
group by category
order by sum(price) desc
limit 3;