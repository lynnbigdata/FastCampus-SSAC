### Quiz Day1
## World Database

# QUIZ 1. 한국(국가코드:KOR) 도시 중 인구가 100만이 넘는 도시를 조회하여 인구 수 순으로 내림차순으로 출력하세요.
# 출력 컬럼: 도시이름(name), 도시 인구 수(population)
select   name, population
from     city
where    countrycode="KOR" and population >= 1000000
order by population desc;

# QUIZ 2. 도시 인구가 800만~1000만 사이인 도시의 데이터를 국가코드 순으로 오름차순 하세요
# 출력 컬럼: 국가코드(countrycode), 도시이름(name), 도시인구수(population)
select countrycode, name, population
from city
where  population between 800*10000 and 1000*10000
order by countrycode asc;

# QUIZ 3. 1940-1950년도 사이에 독립한 국가들 중 GNP가 10만이 넘는 국가를 GNP의 내림차순으로 출력하세요
# 논리연산자 > 산술연산자
# 출력 컬럼: 국가코드(code), 국가이름(name), 대륙(continent), GNP(gnp)
select code, name, continent, gnp, IndepYear
from country
where (indepyear between 1940 and 1950)
		and (gnp >= 10 * 10000)
order by gnp desc;

# QUIZ 4.스페인어(spanish), 영어(english), 한국어(korean)중에 95% 이상 사용하는 국가코드, 언어, 비율을 출력하세요
# 출력컬럼 : 국가코드(countrycode), 언어(language), 비율(percentage)
select   countrycode, language, percentage
from     countrylanguage
where    language in ("Spanish", "English", "Korean") #in
		 and percentage >= 95
order by percentage desc;

# 국가코드 : ARG, NIC, IRL 국가들만 선별해서 출력
# ARG(120만), NIC(150만), IRL(190만)
# GBR 국가의 인구가 120만일 때 언어별로 사용하는 인구를 출력
select countrycode, language, percentage, 
       (120*10000)*(percentage/100) as populatioin
from   countrylanguage
where  CountryCode = "GBR"; 

# Quiz 5. 국가코드가 'K'로 시작하는 국가 중에 기대수명(lifeexpectancy)이 70세 이상인 국가를 기대수명의 내림차순 순으로 출력하세요.
# 출력컬럼: 국가코드(code), 국가이름(name), 대륙(continent), 기대수명(lifeexpectancy)
select   code, name, continent, lifeexpectancy
from     country
where    code like "K%" 
	     and LifeExpectancy >= 70
order by LifeExpectancy desc;

# USA 미국 국가의 도시 중에서 인구가 가장 많은 도시를 찾아서 인구수를 출력 
# 뉴욕 인구수 8008278
select *
from city
where countrycode = "USA"
order by population desc
limit 1; #가장 인구가 많은 도시

# 해당 도시에 상응하는 언어의 인구수를 출력
# 조건: 도시의 언어 사용 비율은 국가의 언어 사용 비율과 동일함 USA
select *, round(8008278 * percentage/100) as population
from countrylanguage
where countrycode = "USA"
order by percentage desc;

## Sakila Database
