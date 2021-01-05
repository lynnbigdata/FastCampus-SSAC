# Sakila : DVD 대여정보
select database();
use sakila;

# QUIZ 6. film_text 테이블에서 title이 ICE가 들어가고 description에 Drama 가 들어간 데이터를 출력하세요.
# 출력 컬럼: 필름아이디(film_id), 제목(title), 설명(description)
select film_id, title, description
from film_text
where title like "%ice%" and description like "%drama%";

# Quiz 7. actor 테이블에서 이름(first_name)의 가장 앞글자가 "A", 성(last_name)의 가장 마지막 글자가 'N'으로 끝나는 배우의 데이터를 출력하세요.
select actor_id, first_name, last_name
from actor
where first_name like "A%" and last_name like "%N";

# Quiz 8. film 테이블에서 rating이 "R"등급인 film 데이터를 상영시간(length)이 가장 긴 상위 10개의 film을 상영시간의 내림차순 순으로 출력하세요.
select *
from   film
where  rating = "R"
order by length desc
limit 10;

# film 테이블에서 어떤 등급이 있는지 출력하세요.
select distinct rating
from   film;

# QUIZ 9. 상영시간(length)이 60분~120분인 필름 데이터에서 영화설명(description)에 robot이 들어있는 영화를 상영시간(length)이 짧은 순으로 오름차순하여 정렬하고, 
# 11위에서 13위까지의 영화를 출력하세요.
select film_id, title, description, length
from film
where (length between 60 and 120) 
  and (description like "%robot%") 
order by length 
limit 10, 3;
-- limit 3 offset 10; 

# QUIZ 10. film_list view에서 카테고리(category)가 sci-fi, animation, drama가 아니고
# 배우(actors)가 "ed chase","kevin bloom"이 둘 중 하나 포함된 영화리스트에서 상영시간(length)이 긴 순서대로 5개의 영화리스트를 출력하세요
# view는 테이블이라고 생각하면 됩니다.
select title, description, category, length, actors
from film_list
where category not in ("sci-fi", "animation", "drama")
  and (actors like "%ed chase%" or actors like "%kevin bloom%") #괄호 반드시 필요
order by length desc
limit 5;