drop database if exists org;
create database org;
use org;

select * from worker;
select * from bonus;
select * from title;

# Q-1. Write An SQL Query To Fetch “FIRST_NAME” From Worker Table Using The Alias Name As <WORKER_NAME>.
select First_name AS WORKER_NAME FROM worker;

# Q-2. Write An SQL Query To Fetch “FIRST_NAME” From Worker Table In Upper Case.
select upper(first_name) from worker;

# Q-3. Write An SQL Query To Fetch Unique Values Of DEPARTMENT From Worker Table.
select distinct department from worker;

# Q-4. Write An SQL Query To Print The First Three Characters Of FIRST_NAME From Worker Table.
select first_name,substr(first_name,1,3) AS nick_name from worker; 

# Q-5. Write An SQL Query To Find The Position Of The Alphabet (‘A’) In The First Name Column ‘Amitabh’ From Worker Table.
select first_name, position('a' in first_name) from worker where first_name = 'Amitabh';

# Q-6. Write An SQL Query To Print The FIRST_NAME From Worker Table After Removing White Spaces From The Right Side.
select rtrim(first_name) AS FIRST_NAME from worker;

#Q-7. Write An SQL Query To Print The DEPARTMENT From Worker Table After Removing White Spaces From The Left Side.
select ltrim(department) AS DEPARTMENT from worker;

# Q-8. Write An SQL Query That Fetches The Unique Values Of DEPARTMENT From Worker Table And Prints Its Length.
select distinct department, length(department) as Len_of_dept from worker;

# Q-9. Write An SQL Query To Print The FIRST_NAME From Worker Table After Replacing ‘a’ With ‘K’. (for replacing char is case-sensitive)
select first_name,replace(first_name, 'a', 'K') as FIRST_NAME from worker;

# Q-10. Write An SQL Query To Print The FIRST_NAME And LAST_NAME From Worker Table Into A Single Column COMPLETE_NAME. A Space Char Should Separate Them.
select concat(first_name," ", Last_name) AS COMPLETE_NAME from worker;

# Q-11. Write An SQL Query To Print All Worker Details From The Worker Table Order By FIRST_NAME Ascending.
select * from worker order by first_name Asc;

# Q-12. Write An SQL Query To Print All Worker Details From The Worker Table Order By DEPARTMENT Descending FIRST_NAME Ascending
select * from worker order by department desc, first_name Asc;

# Q-13. Write An SQL Query To Print Details For Workers With The First Name As “Vipul” And “Satish” From Worker Table.
select * from worker where first_name in ('Vipul','Satish');
select * from worker where first_name = 'Vipul'or first_name = 'Satish';

# Q-14. Write An SQL Query To Print Details Of Workers Excluding First Names, “Vipul” And “Satish” From Worker Table.
select * from worker where first_name not in ('Vipul','Satish');

# Q-15. Write An SQL Query To Print Details Of Workers With DEPARTMENT Name As “Admin”.
select * from worker where department = 'Admin';

# Q-16. Write An SQL Query To Print Details Of The Workers Whose FIRST_NAME Contains ‘A’.
select * from worker where first_name like '%A%';

# Q-17. Write An SQL Query To Print Details Of The Workers Whose FIRST_NAME Ends With ‘A’.
select * from worker where first_name like '%A';

# Q-18. Write An SQL Query To Print Details Of The Workers Whose FIRST_NAME Ends With ‘H’ And Contains Six Alphabets.
select * from worker where first_name like '_____H';
select * from worker where length(first_name) = 6 and first_name like '%h';

# Q-19. Write An SQL Query To Print Details Of The Workers Whose SALARY Lies Between 100000 And 500000.
select * from worker where salary between 100000 And 500000;
select * from worker where salary >= 100000 and salary <= 500000;

# Q-20. Write An SQL Query To Print Details Of The Workers Who Have Joined In Feb’2014.
select * from worker where month(joining_date) = 2 and year(joining_date) = 2014;
select * from worker where joining_date like '2014-02%';

# Q-21. Write An SQL Query To Fetch The Count Of Employees Working In The Department ‘Admin’.
select department, count(department) AS No_of_worker from worker where department = 'Admin';
select department, count(department) AS No_of_worker from worker where department = 'Admin' group by department;

# Q-22. Write An SQL Query To Fetch Worker Names With Salaries >= 50000 And <= 100000.
select concat(first_name,' ', last_name) As Worker_Names, salary from worker where salary >= 50000 And salary <= 100000;
select concat(first_name,' ', last_name) As Worker_Names, salary from worker where salary between 50000 and 100000;

# Q-23. Write An SQL Query To Fetch The No. Of Workers For Each Department In The Descending Order.
select department, count(department) AS No_of_worker from worker group by department order by department desc;

# Q-24. Write An SQL Query To Print Details Of The Workers Who Are Also Managers.
select * from worker where worker_id in (select worker_ref_id from title where worker_title = 'Manager');
select w.*,t.worker_title from worker w inner join title t on worker_id = worker_ref_id where worker_title = 'Manager';

# Q-25. Write An SQL Query To Fetch Duplicate Records Having Matching Data In Some Fields Of A Table.
select worker_title, Affected_from, count(*) as Dup from title group by worker_title, Affected_from having Dup > 1;

# Q-26. Write An SQL Query To Show Only Odd Rows From A Table.
select * from worker where worker_id %2 != 0;

# Q-27. Write An SQL Query To Show Only Even Rows From A Table.
select * from worker where worker_id %2 = 0;

# Q-28. Write An SQL Query To Clone A New Table From Another Table.
create table Clone_table As select * from worker;
select * from clone_table;
create table clone_info like worker;
select * from clone_info;

# Q-29. Write An SQL Query To Fetch Intersecting Records Of Two Tables.
select * from worker w inner join bonus b on w.worker_id = b.worker_ref_id;
select * from worker where worker_id in (select worker_ref_id from bonus);            #it doesn't print duplicates

-- write an SQL query to extract worker's information who have not received the bonus
select * from worker where worker_id not in (select worker_ref_id from bonus);

# Q-30. Write An SQL Query To Show Records From One Table That Another Table Does Not Have.
select * from worker w left join bonus b on w.worker_id = b.worker_ref_id where b.worker_ref_id is null;

# Q-31. Write An SQL Query To Show The Current Date And Time.
select now(), sysdate();

# Q-32. Write An SQL Query To Show The Top N (Say 10) Records Of A Table.
SELECT * FROM worker LIMIT 10; 

# Q-33. Write An SQL Query To Determine The Nth (Say N=5) Highest Salary From A Table.
select * from worker order by salary desc limit 4,1;
select *,row_number() over(order by salary desc) as Row_Number_info,        # it prints numbers in order
rank() over(order by salary desc) as Rank_info,                             # it skips the value and print the number
dense_rank() over(order by salary desc) as Dense_rank_info from worker;     # it doesn't skips the value and print the number / it is preferable than rank

# Q-34. Write An SQL Query To Determine The 5th Highest Salary Without Using TOP Or Limit Method.
select * from(select *,dense_rank() over(order by salary desc) as dense_rank_info from worker) t where t.Dense_rank_info = 5;

# Q-35. Write An SQL Query To Fetch The List Of Employees With The Same Salary.
SELECT * FROM worker WHERE salary IN (SELECT salary FROM worker GROUP BY salary HAVING COUNT(*) > 1);

# Q-36. Write An SQL Query To Show The Second Highest Salary From A Table.
SELECT MAX(salary) AS second_highest_salary FROM worker WHERE salary < (SELECT MAX(salary) FROM worker);
select * from (select *, dense_rank() over(order by salary desc) as Dense_rank_info from worker) t where i.dense_rank_info;

# Q-37. Write An SQL Query To Show One Row Twice In Results From A Table.
SELECT * FROM worker union all select * from worker order by worker_id;

# Q-38. Write An SQL Query To Fetch Intersecting Records Of Two Tables.
SELECT * FROM worker w INNER JOIN bonus ON t1.employee_id = t2.employee_id;
select * from worker where worker_id in(select worker_id_id from bonus);

# Q-39. Write An SQL Query To Fetch The First 50% Records From A Table.
select * from worker where worker_id <= (select round(count(WORKER_ID)/2) from worker);

# Q-40. Write An SQL Query To Fetch The Departments That Have Less Than three/Five People In It.
SELECT department, COUNT(*) AS num_emp FROM worker GROUP BY department HAVING num_emp < 5;
SELECT department, COUNT(*) AS num_emp FROM worker GROUP BY department HAVING num_emp < 3;

# Q-41. Write An SQL Query To Show All Departments Along With The Number Of People In There.
SELECT department, COUNT(*) AS num_emp FROM worker GROUP BY department;

# Q-42. Write An SQL Query To Show The Last Record From A Table.
SELECT * FROM worker ORDER BY WORKER_ID DESC LIMIT 1;

# Q-43. Write An SQL Query To Fetch The First Row Of A Table.
SELECT * FROM worker ORDER BY WORKER_ID asc LIMIT 1;

# Q-44. Write An SQL Query To Fetch The Last Five Records From A Table.
SELECT * FROM worker ORDER BY WORKER_ID desc LIMIT 5;
select * from (SELECT * FROM worker ORDER BY WORKER_ID desc LIMIT 5) t order by t.WORKER_ID asc;

# Q-45. Write An SQL Query To Print The Name Of Employees Having The Highest Salary In Each Department.
select * from(select*, dense_rank() over(partition by department order by salary desc) dr from worker) t where t.dr=1;

# Q-46. Write An SQL Query To Fetch Three Max Salaries From A Table.
SELECT DISTINCT salary FROM worker ORDER BY salary DESC LIMIT 3;

# Q-47. Write An SQL Query To Fetch Three Min Salaries From A Table.
SELECT DISTINCT salary FROM worker ORDER BY salary ASC LIMIT 3;

# Q-48. Write An SQL Query To Fetch Nth Max Salaries From A Table. (4th)
select * from(SELECT *, DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_rank FROM worker) t WHERE salary_rank = 4;

# Q-49. Write An SQL Query To Fetch Departments Along With The Total Salaries Paid
SELECT department, sum(salary) as Highest_salary from worker group by department;

# Q-50. Write An SQL Query To Fetch The Names Of Workers Who Earn The Highest Salary.
SELECT concat(first_name,last_name) as worker_name, salary FROM worker WHERE salary = (SELECT MAX(salary) FROM worker);