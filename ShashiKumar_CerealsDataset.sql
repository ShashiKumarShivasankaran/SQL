create database Cereals;
use cereals;
select * from cereals_data;

# 1. Add index name fast on name
select * from cereals_data;
CREATE INDEX ON cereals_data(name(255));

# 2. Describe the schema of table
describe cereals_data;

# 3. Create view name as see where users can not see type column [first run appropriate query then create view]
select * from cereals_data;
create view see as (select name,mfr,calories,protein,fat,sodium,fiber,carbo,sugars,potass,vitamins,shelf,weight,cups,rating from cereals_data);
select * from see;

# 4. Rename the view as saw
rename table see to saw;
select * from saw;

# 5. Count how many are cold cereals
select type, count(*) as No_of_cereals from cereals_data where type = 'C';

# 6. Count how many cereals are kept in shelf 3
select shelf, count(*) as No_of_cereals from cereals_data where shelf =3;

# 7. Arrange the table from high to low according to ratings 
select * from cereals_data order by rating desc;

# 8. Suggest some column/s which can be Primary key

# 9. Find average of calories of hot cereal and cold cereal in one query
select type , avg(calories) from cereals_data group by type;
select avg(case when type = 'h' then calories END) AS avg_hot_cereal_calories, avg(case when type = 'c' then calories END) AS avg_cold_cereal_calories from cereals_data;  # i tried another way sir

# 10. Add new column as HL_Calories where more than average calories should be categorized as HIGH and less than average calories should be categorized as LOW
alter table cereals_data add column HL_calories char(4);
select round(avg(calories)) from cereals_data;
update cereals_data set HL_calories = case when calories >='107' then 'High' else 'Low' end;
select * from cereals_data;

# 11. List only those cereals whose name begins with B
select * from cereals_data where name like'b%';

# 12. List only those cereals whose name begins with F
select * from cereals_data where name like'f%';

# 13. List only those cereals whose name ends with s
select * from cereals_data where name like'%s';

# 14. Select only those records which are HIGH in column HL_calories and mail to jeevan.raj@imarticus.com [save/name your file as <your first name_cereals_high>]
select * from cereals_data where HL_Calories = 'High';

# 15. Find maximum of ratings
select max(rating) from cereals_data;

# 16. Find average ratings of those were High and Low calories
select calories, avg(calories) AS average_ratings from cereals_data where average_ratings ='high' and 'low';

# 17. Craete two examples of Sub Queries of your choice and give explanation in the script itself with remarks by using #

# 18. Remove column fat
alter table cereals_data drop column fat;

# 19. Count records for each manufacturer [mfr]
select mfr, count(mfr) from cereals_data group by mfr;
select mfr, count(mfr) AS No_of_mfr from cereals_data group by mfr order by count(mfr) desc;

# 20. Select name, calories and ratings only
select name, calories, rating from cereals_data;