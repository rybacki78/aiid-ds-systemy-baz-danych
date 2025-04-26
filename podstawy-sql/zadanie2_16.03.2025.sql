-- SELECT
-- 1
delete from jobs;
delete from regions;

-- 2
insert into regions
   select *
     from hr.regions;

select *
  from regions;

-- 3
drop table if exists countries cascade constraints;
drop table if exists departments cascade constraints;
drop table if exists employees cascade constraints;
drop table if exists jobs cascade constraints;
drop table if exists job_history cascade constraints;
drop table if exists locations cascade constraints;

-- 4
create table countries
   as
      select *
        from hr.countries;

create table departments
   as
      select *
        from hr.departments;

create table employees
   as
      select *
        from hr.employees;

create table jobs
   as
      select *
        from hr.jobs;

create table job_history
   as
      select *
        from hr.job_history;

create table locations
   as
      select *
        from hr.locations;

-- 5a
select first_name,
       last_name
  from employees;

-- 5b
select first_name
       || ' '
       || last_name as employee
  from employees
 where salary > 4000;

-- 5c
select first_name,
       last_name,
       salary
  from employees
 where salary between 3000 and 7000
   and ( last_name like ( '%a%' )
    or last_name like ( '%e%' ) );

-- 5d
select first_name,
       last_name,
       department_id
  from employees
 where department_id in ( 10,
                          20,
                          50,
                          70,
                          80,
                          100 );

-- 5e
select distinct department_id
  from employees;

-- 5f
select first_name,
       last_name,
       hire_date
  from employees
 order by hire_date
 fetch first 5 rows with ties;
