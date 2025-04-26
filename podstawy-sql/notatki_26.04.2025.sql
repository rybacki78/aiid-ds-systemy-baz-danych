-- funkcje okienkowe
select first_name as imie,
       last_name as nazwisko,
       salary as zarobki,
       department_id as departament,
       round(
          avg(salary)
          over(partition by department_id),
          2
       ) as srednia_zar,
       salary - round(
          avg(salary)
          over(partition by department_id),
          2
       ) as roznica_od_sredniej,
       max(salary)
       over(partition by department_id) as max_departamentu,
       max(salary)
       over(partition by department_id) - salary as roznica_od_maks
  from employees;

select *
  from (
   select first_name as imie,
          last_name as nazwisko,
          salary as zarobki,
          max(salary)
          over(partition by department_id) as max_departamentu
     from employees
)
 where zarobki = max_departamentu;



select first_name,
       last_name,
       department_id,
       salary,
       hire_date,
       sum(salary)
       over(partition by department_id
            order by hire_date
       ) as sum_dept_salary
  from employees;

select p.product_name,
       s.price,
       s.sale_date,
       round(
          avg(s.price)
          over(partition by p.product_id
               order by s.sale_date
             rows between 2 preceding and 2 following
          ),
          2
       ) as avg_product_price
  from sales s
  join products p
on s.product_id = p.product_id
 order by p.product_name,
          s.sale_date;


select p.product_name,
       s.sale_date,
       s.quantity * s.price as amount,
       lag(s.quantity * s.price,
           1)
       over(partition by p.product_id
            order by s.sale_date
       ) as prev_amount,
       s.quantity * s.price - lag(s.quantity * s.price,
           1)
                              over(partition by p.product_id
                                   order by s.sale_date
       ) as diff_amount,
       lead(s.quantity * s.price,
            10)
       over(
           order by s.sale_date
       ) as next_amount
  from sales s
 inner join products p
on s.product_id = p.product_id;



-- ranking wynagrodzen
select first_name,
       last_name,
       salary,
       department_id,
       rank()
       over(partition by department_id
            order by salary desc
       ) as ranking_wynagrodzen,
       dense_rank()
       over(partition by department_id
            order by salary desc
       ) as gesty_ranking_wynagrodzen,
       row_number()
       over(partition by department_id
            order by salary desc
       ) as kolejnosc_wynagrodzen
  from employees;