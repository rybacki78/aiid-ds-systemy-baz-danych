--1. Z tabeli employees wypisz w jednej kolumnie last_name i salary – nazwij kolumnę wynagrodzenie, dla
--osób z departamentów 20 i 50 z zarobkami pomiędzy 2000 a 7000, uporządkuj kolumny według nazwiska

select last_name
       || ' '
       || salary as wynagrodzenie
  from employees
 where department_id in ( 20,
                          50 )
   and salary between 2000 and 7000
 order by last_name;

--2. Wypisać nazwisko, numer departamentu, nazwę departamentu, id pracy, dla osób z pracujących Toronto
select e.last_name,
       e.department_id,
       d.department_name,
       e.job_id
  from employees e
 inner join departments d
on e.department_id = d.department_id
 inner join locations l
on d.location_id = l.location_id
 where l.city = 'Toronto';


--3. Dla każdego działów w których minimalna płaca jest wyższa niż 5000 wypisz sumę oraz średnią zarobków
--zaokrągloną do całości nazwij odpowiednio kolumny

select d.department_name,
       sum(e.salary) as suma_zarobkow,
       round(
          avg(e.salary),
          0
       ) as srednia_zarobkow
  from departments d
 inner join employees e
on d.department_id = e.department_id
 inner join jobs j
on e.job_id = j.job_id
having j.min_salary > 5000
 group by d.department_name,
          j.min_salary;



--4. Dla pracowników o imieniu „Jennifer” wypisz imię i nazwisko tego pracownika oraz osoby które z nim
--współpracują

select e.first_name,
       e.last_name,
       ee.first_name
       || ' '
       || ee.last_name as wspolpracownik
  from employees e
  join employees ee
on e.department_id = ee.department_id
 where e.first_name = 'Jennifer';