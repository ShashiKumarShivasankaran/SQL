create database Movie;
use movie;

# i. Write a SQL query to find when the movie 'American Beauty' released. Return movie release year. 
select mov_title, mov_year from movie where mov_title = 'American Beauty';

# ii. Write a SQL query to find those movies, which were released before 1998. Return movie title.
select mov_title, mov_year from movie where mov_year <= 1998;

# iii. Write a query where it should contain all the data of the movies which were released after 1995 and their movie duration was greater than 120.
select * from movie where mov_year >= 1995 and mov_time > 120;

# iv. Write a query to determine the Top 7 movies which were released in United Kingdom. Sort the data in ascending order of the movie year.
select * from movie where mov_rel_country = 'United Kingdom' order by mov_year Asc limit 7;
select * from (select * from movie where mov_rel_country = "UK" order by mov_title desc limit 7)t order by mov_year asc;
select m.* from movie as m inner join ratings as r on m.mov_id = r.mov_id where m.mov_title = 'United Kingdom' order by m.mov_year asc limit 7;

# v. Set the language of movie language as 'Chinese' for the movie which has its existing language as Japanese and the movie year was 2001.
update movie set mov_lang = 'chinese' where mov_lang = 'Japanese' and mov_year = 2001;
select * from movie;

# vi. Write a SQL query to find name of all the reviewers who rated the movie 'Slumdog Millionaire'.
select * from reviewer;
select m.mov_title,re.rev_name from movie as m inner join ratings as r using (mov_id) inner join reviewer as re using (rev_id) where mov_title =  'Slumdog Millionaire';

# vii. Write a query which fetch the first name, last name & role played by the actor where output should all exclude Male actors. 
select a.act_fname,a.act_lname, a.act_gender,c.role from actor as a  inner join cast as c on c.act_id=a.act_id where act_gender != 'M';

# viii. Write a SQL query to find the actors who played a role in the movie 'Annie Hall'. Fetch all the fields of actor table. (Hint: Use the IN operator). 
select a.*, m.mov_title from actor as a inner join cast as c using (act_id) inner join movie as m on m.mov_id = c.mov_id where mov_title = 'Annie Hall';

# ix. Write a SQL query to find those movies that have been released in countries other than the United Kingdom. Return movie title, movie year, movie time, and date of release, releasing country.
select m.mov_title,m.mov_year,m.mov_time,m.mov_dt_rel,m.mov_rel_country from movie as m where mov_rel_country<> 'UK';

# x. Print genre title, maximum movie duration and the count the number of movies in each genre. (HINT: By using inner join)
select g.gen_title, max(m.mov_title) AS max_mov_duration, count(g.gen_title) AS mov_count
from movie m inner join movie_genres AS mg ON m.mov_id = mg.mov_id inner join genres AS g on g.gen_id = mg.gen_id group by g.gen_title;

# xi. Create a view which should contain the first name, last name, title of the movie & role played by particular actor.
select * from movie;
create view duplicate as (select a.act_fname,a.act_lname,m.mov_title ,c.role from actor as a inner join cast  as c  using (act_id) inner join movie as m using (mov_id));
select * from duplicate;

# xii. Write a SQL query to find the movies with the lowest ratings
select * from ratings;(select m.*,r.num_o_ratings from movie as m inner join ratings as r on r.mov_id= m.mov_id order by num_o_ratings limit 1);
