create database if not exists insurance;
drop database if exists insurance;

use insurance;
select * from insurance;

# 1. Count for each categories of ‘region
select region, count(region) from insurance group by region;

# 2. Find 50 records of highest ‘age’ and export data/table to desktop
select * from insurance order by age desc limit 50;

# 3. Add index name ‘quick’ on ‘id’
select * from insurance;
create index quick on insurance(id);

# 4. Describe the schema of table
describe insurance;

# 5. Create view name as ‘gender’ where users can not see ‘sex’ [Hint: first run appropriate query then create view]
select * from insurance;
create view gender as (select id,age,bmi,children,smoker,charges from insurance);

# 6. Rename the view as ‘type’
rename table gender to type;
select * from type;

# 7. Count how many are ‘northwest’ insurance holders
select region, count(*) as no_of_holders from insurance where region = 'northwest';

# 8. Count how many insurance holders were ‘female’
select gender, count(*) no_of_female from insurance group by gender;

# 9. Create Primary key on a suitable column
alter table insurance modify id int primary key;

# 10. Create a new column ‘ratio’ which is age multiply by bmi
alter table insurance add column ratio double after bmi;
update insurance set ratio = age * bmi;
select * from insurance;

# 11. Arrange the table from high to low according to charges
select * from insurance order by charges desc;

# 12. Find MAX of ‘charges’
select max(charges) from insurance;

# 13. Find MIN of ‘charges’
select min(charges) from insurance;
select * from insurance where charges = (select min(charges) from insurance);     # different

# 14. Find average of ‘charges’ of male and female
select sex,round(avg(charges),2) as Average_charges from insurance group by sex;

# 15. Write a Query to rename column name sex to Gender
alter table insurance rename column sex to Gender;
select * from insurance;

# 16. Add new column as HL_Charges where more than average charges should be categorized as HIGH and less than average charges should be categorized as LOW
ALTER TABLE insurance ADD COLUMN HL_Charges VARCHAR(10);
select round(avg(charges)) from insurance;
UPDATE insurance SET HL_Charges = CASE WHEN charges >= (SELECT AVG(charges) FROM insurance) THEN 'HIGH' ELSE 'LOW' END;
UPDATE insurance SET HL_Charges = CASE WHEN charges >= 13270 THEN 'HIGH' ELSE 'LOW' END;
select * from insurance;

# 17. Change location/position of ‘smoker’ and bring before ‘children’
alter table insurance add column dummy varchar(10) after ratio;
update insurance set dummy = smoker;
alter table insurance drop column smoker;
alter table insurance rename column dummy to smoker;
select * from insurance;

# 18. Show top 20 records
SELECT * FROM insurance order by charges desc LIMIT 20;

# 19. Show bottom 20 records
SELECT * FROM insurance order by charges asc LIMIT 20;

# 20. Randomly select 20% of records and export to desktop
SELECT * FROM insurance WHERE RAND() <= 0.2;
select round(count(*)*.2) from insurance;
select * from insurance order by rand() limit 268;

# 21. Remove column ‘ratio’
ALTER TABLE insurance DROP COLUMN ratio;

# 22. Create one example of Sub Queries involving ‘bmi’ and ‘sex’ and give explanation in the script itself with remarks by using #
select * from insurance;
#extract those information whose bmi is less then max
select * from insurance where bmi < (select max(bmi) as Max_Bmi from insurance where gender = 'Female');

# 23. Create a view called Female_HL_Charges that shows only those data where HL_Charges is High, Female, Smokers and with 0 children
CREATE VIEW Female_HL_Charges AS (SELECT * FROM insurance WHERE HL_Charges = 'HIGH' AND gender = 'Female' AND smoker = 'Yes' AND children = 0);
select * from Female_HL_Charges;

# 24. Update children column if there is 0 children then make it as Zero Children, if 1 then one_children, if 2 then two_children, if 3 then three_children, if 4 then four_children if 5 then five_children else print it as More_than_five_children.
alter table insurance modify children varchar(20);
UPDATE insurance SET children = CASE 
WHEN children = 0 THEN 'Zero Children'
WHEN children = 1 THEN 'One Child'
WHEN children = 2 THEN 'Two Children'
WHEN children = 3 THEN 'Three Children'
WHEN children = 4 THEN 'Four Children'
WHEN children = 5 THEN 'Five Children'
ELSE 'More than Five Children'END;
select * from insurance;