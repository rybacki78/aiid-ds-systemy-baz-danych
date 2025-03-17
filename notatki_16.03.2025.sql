-- INSERT, UPDATE, DELETE
-- praca na danych


insert into regions values ( 1,
                             'Asia' );

insert into regions values ( 2,
                             'Europe' );

insert into countries values ( 1,
                               'China',
                               1 );

insert into countries (
   country_id,
   country_name
) values ( 1,
           'Poland' ); -- dodajemy tylko wybrance rekordy, jeśli not null pozwala


insert into countries values ( 2,
                               'Poland',
                               2 );

update countries
   set
   country_name = 'Thailand'
 where country_id = 1; -- pozwala aktualizowac rekordy bazy


delete from countries
 where country_id in ( 1,
                       2 ); -- usuwanie rekordów

delete from regions; -- usuwa wszystko regions


-- SELECT 

select *
  from hr.regions;

insert into regions
   select *
     from hr.regions;

create table employees_1
   as
      select *
        from hr.employees;

select first_name as imie,
       last_name as nazwisko,
       salary as wynagrodzenie,
       department_id as department
  from employees_1
 where 1 = 1
   and salary >= 8000
   and salary <= 15000
   and salary between 8000 and 15000
   and ( last_name like '%v%'
    or last_name like '%o%' )
   and department_id not in ( 60,
                              100 );


select first_name
       || ' '
       || last_name as osoba,
       salary as wynagrodzenie,
       department_id as department
  from employees;

select concat(
   first_name,
   concat(
      ' ',
      last_name
   )
) as osoba,
       hire_date as data_zatrudnienia,
       extract(month from hire_date) as miesiac_zatrudnienia,
       length(last_name) as dlugosc_nazwiska,
       salary as wynagrodzenie,
       department_id as department
  from employees;

select distinct department_id
  from employees
 order by department_id;
select last_name,
       salary,
       department_id
  from employees
 where department_id in ( 30,
                          40,
                          50 )
 order by department_id,
          salary desc;

select last_name,
       salary,
       department_id
  from employees
 where department_id in ( 30,
                          40,
                          50 )
 order by 3,
          2 desc;

select last_name,
       salary,
       department_id
  from employees
 where department_id in ( 30,
                          40,
                          50 )
 order by 3 
--FETCH FIRST 8 ROWS WITH TIES
offset 10 rows fetch next 8 rows only;

SELECT first_name, last_name, salary, department_id FROM employees ORDER BY department_id;

SELECT  department_id, 
        ROUND(AVG(salary),2) as srednia_zarobkow,
        SUM(salary) AS suma_zarobkow, 
        COUNT(*) AS liczba_pracownikow,
        ROUND(SUM(salary)/COUNT(*),2) as srednia_zarobkow_bis
FROM employees 
WHERE department_id IN (10,20,30,40,50,60)
GROUP BY department_id
HAVING COUNT(*) > 1;
