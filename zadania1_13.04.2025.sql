-- 5. Wypisać wszystkie departamenty w których nie ma pracowników

select department_id,
       department_name
  from departments
 where department_id not in (
   select distinct department_id
     from employees
    where department_id is not null
);

-- 6. Skopiuj tabelę Job_grades od użytkownika HR
-- działam na własnej bazie wiec tworze własną tabele

create table job_grades (
   grade       char(1),
   lowest_sal  number(8,2) not null,
   highest_sal number(8,2) not null
);

alter table job_grades add constraint jobgrades_grade_pk primary key ( grade );

insert into job_grades values ( 'A',
                                1000,
                                2999 );
insert into job_grades values ( 'B',
                                3000,
                                5999 );
insert into job_grades values ( 'C',
                                6000,
                                9999 );
insert into job_grades values ( 'D',
                                10000,
                                14999 );
insert into job_grades values ( 'E',
                                15000,
                                24999 );
insert into job_grades values ( 'F',
                                25000,
                                40000 );

commit;

-- 7. Wypisz imię i nazwisko, id pracy, nazwę departamentu, zarobki, oraz odpowiedni grade dla każdego pracownika

select emp.first_name,
       emp.last_name,
       emp.job_id,
       dep.department_name,
       emp.salary,
       grd.grade
  from employees emp
  left join departments dep
on emp.department_id = dep.department_id
  left join job_grades grd
on emp.salary between grd.lowest_sal and grd.highest_sal;

-- 8. Wypisz imię nazwisko oraz zarobki dla osób które zarabiają więcej niż średnia wszystkich, uporządkuj malejąco według zarobków

select first_name,
       last_name,
       salary
  from employees
 where salary > (
   select avg(salary)
     from employees
)
 order by salary desc;

-- 9. Wypisz id, imie i nazwisko osób, które pracują w departamencie z osobami mającymi w nazwisku „u”
select emp.employee_id,
       emp.first_name,
       emp.last_name
  from employees emp
 where emp.department_id in (
   select distinct department_id
     from employees
    where lower(last_name like '%u%')
);

-- 10. Z tabeli employees wyciągnąć informację data zatrudnienia, nazwisko oraz kolumnę podaną przez
--     użytkownika dla osób mających menadżera zatrudnionych w roku 2005. Uporządkować według kolumny
--     podanej przez użytkownika (aby wstawić parametr, należy użyć &nazwaParametru)

define kolumna = email;

select e.hire_date,
       e.last_name,
       e.&kolumna
  from employees e
 where e.manager_id is not null
   and extract(year from hire_date) = 2015
 order by 3;

-- 11. Wypisać imiona i nazwiska razem, zarobki oraz numer telefonu porządkując dane według pierwszej
--     kolumny malejąco a następnie drugiej rosnąco (użyć numerów do porządkowania) dla osób z trzecią
--     literą nazwiska ‘e’ oraz częścią imienia podaną przez użytkownika

define fragment = 'en';

select first_name
       || ' '
       || last_name as full_name,
       salary,
       phone_number
  from employees
 where substr(
      last_name,
      3,
      1
   ) = 'e'
   and lower(first_name) like ( '%&fragment%' )
 order by 1 desc,
          2 asc;

-- 12. Wypisać imię i nazwisko, liczbę miesięcy przepracowanych – funkcje months_between oraz round oraz
--     kolumnę wysokość_dodatku jako (użyć CASE lub DECODE):
--   - 10% wynagrodzenia dla liczby miesięcy do 150
--   - 20% wynagrodzenia dla liczby miesięcy od 150 do 200
--   - 30% wynagrodzenia dla liczby miesięcy od 200, uporządkować według liczby miesięcy

select first_name
       || ' '
       || last_name as full_name,
       round(months_between(
          current_date,
          hire_date
       )) as liczba_miesiecy,
       case
          when round(months_between(
             current_date,
             hire_date
          )) <= 150              then
             salary * 0.1
          when round(months_between(
             current_date,
             hire_date
          )) between 150 and 200 then
             salary * 0.2
          else
             salary * 0.3
       end as wysokość_dodatku
  from employees;