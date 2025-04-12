-- 5g
select count(*) as number_of_departments
  from departments;

-- 5h
select job_id,
       min(salary) as minimalne,
       max(salary) as maksymalne
  from employees
 group by job_id;

-- 5i
select first_name,
       last_name
  from employees
 where extract(year from hire_date) between 2015 and 2017; -- zmiana dat moja baza ma inne dane.

-- 5j
-- Imie nazwisko oraz sumę zarobków (liczoną jako salary + salary * commission_pct) – aby wyeliminować NULL należy użyć funkcji NVL.
select first_name,
       last_name,
       salary + salary * nvl(
          commission_pct,
          0
       )
  from employees;

-- 5k
-- Średnią zarobków dla osób zatrudnionych w latach 2006 – 2010 dla każdego departamentu.
select department_id,
       round(
          avg(salary),
          2
       )
  from employees
 where extract(year from hire_date) between 2015 and 2017 -- zmiana dat moja baza ma inne dane.
 group by department_id
 order by department_id;

 -- 5l
 -- Liczbę pracowników dla każdego departamentu, jeśli ta liczba jest większa od 2.
select department_id,
       count(*) as ilosc_pracownikow
  from employees
 group by department_id
having count(*) > 2
 order by department_id;

-- 5m
-- Liczbę różnych stanowisk dla każdego departamentu.
select department_id,
       count(job_id)
  from employees
 group by department_id
 order by department_id;

 -- 5n
 -- Sumę zarobków dla każdego departamentu, jeśli średnia zarobków jest większa od 5000.
select department_id,
       sum(salary) as total_salary
  from employees
 group by department_id
having avg(salary) > 5000
 order by department_id;