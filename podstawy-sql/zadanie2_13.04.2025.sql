--a. Stwórz widok dla tabeli employees zawierający: employee_id, last_name, first_name, dla
--   pracowników z departamentu o nazwie Sales (weź pod uwagę nazwę, a nie department_id)

create or replace view sales_employees as
   select e.employee_id,
          e.first_name,
          e.last_name
     from employees e
     left join departments d
   on e.department_id = d.department_id
    where department_name = 'Sales';

-- b. Stwórz widok dla tabeli employees zawierający: employee_id, last_name, first_name, salary,
--    job_id, email, hire_date dla pracowników mających zarobki pomiędzy 3000 a 10000.

create or replace view salary_employees as
   select e.employee_id,
          e.first_name,
          e.last_name,
          e.salary,
          e.job_id,
          e.email,
          e.hire_date
     from employees e
    where salary between 3000 and 10000;

-- d. Stwórz widok zawierający informację o nazwie departamentu, średniej zarobków oraz sumie
--    zarobków dla każdego departamentu, który zatrudnia co najmniej dwóch pracowników

create or replace view department_names as
   select d.department_name,
          round(avg(e.salary),2) as average,
          sum(e.salary) as sum
     from departments d
     left join employees e
   on d.department_id = e.department_id
   having count(e.department_id) > 2
    group by d.department_name;