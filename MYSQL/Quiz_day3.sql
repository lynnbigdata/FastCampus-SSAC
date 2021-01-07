# Quiz 1. 멕시코(Mexico)보다 인구가 많은 나라이름과 인구수를 조회하시고 인구수 순으로 내림차순하세요.
use world;

select name, population
from country
where population > (select population from country where name = "Mexico")
order by population desc;

# Quiz 2. 국가별 몇 개의 도시가 있는지 조회하고 도시수 순으로 10위까지 내림차순하세요.
-- city country join 먼저 하기
-- 그 후 city 같은 나라끼리 group by

select 		country.name , 
            count(country.name) as count
from   		city
join		country
on			city.countrycode = country.code
group by	country.name
order by	count desc
limit 10;

# QUIZ 3. 언어별 사용인구를 출력하고 언어 사용인구 순으로 10위까지 내림차순하세요.
-- country countrylanguage 합치기
-- country의 인구수 language 인구수 퍼센트 결과출력
-- language로 group by한 후 언어별로 출력된 인구수를 sum? 함수

select * from countrylanguage;

select		countrylanguage.language,
			sum(round(country.population * countrylanguage.percentage/100)) as population
from		country 
join		countrylanguage
on			country.code = countrylanguage.countrycode
group by 	countrylanguage.language
order by 	population desc
limit 10 ;

# select 절의 sub query, union
select "population" as "category",
	(select population from country where code = "KOR") as KOR,
	(select population from country where code = "USA") as USA
union
select "gnp" as "category",
	(select gnp from country where code = "KOR") as KOR,
	(select gnp from country where code = "USA") as USA;

# QUIZ 4. 나라 전체 인구의 10%이상인 도시에서 /도시인구가 500만이 넘는 도시를 아래와 같이 조회 하세요.

# Quiz 5. 면적이 10000km^2 이상인 국가의 인구밀도(1km^2 당 인구수)를 구하고 인구밀도(density)가 200이상인 국가들의 사용하고 있는 언어가 2가지인 나라를 조회 하세요.
-- 출력 : 국가 이름, 인구밀도, 언어 수 출력

# Quiz 6. 사용하는 언어가 3가지 이하인 국가중 도시인구가 300만 이상인 도시를 아래와 같이 조회하세요.
-- GROUP_CONCAT(LANGUAGE) 을 사용하면 group by 할때 문자열을 합쳐서 볼수 있습니다.
-- VIEW를 이용해서 query를 깔끔하게 수정하세요.

# Quiz 7. 한국와 미국의 인구와 GNP를 세로로 아래와 같이 나타내세요. (쿼리문에 국가 코드명을 문자열로 사용해도 됩니다.)

# Quiz 8. sakila 데이터 베이스의 payment 테이블에서 수입(amount)의 총합을 아래와 같이 출력하세요.

# Quiz 9. 위의 결과에서 payment 테이블에서 월별 렌트 횟수 데이터를 추가하여 아래와 같이 출력하세요.