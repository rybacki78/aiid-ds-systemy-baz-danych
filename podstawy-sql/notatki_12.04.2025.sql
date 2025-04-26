select department_id,
       job_id,
       sum(salary) as suma_zarobkow
  from employees
 where department_id not in ( 80,
                              90 )
 group by department_id,
          job_id
having sum(salary) > 20000
 order by department_id,
          job_id
 fetch first 3 rows only;

 --- łączenie tabel
select prod_name,
       s.time_id,
       s.amount_sold as amount,
       c.cust_first_name
       || ' '
       || c.cust_last_name
  from products p
 inner join sales s
on p.prod_id = s.prod_id
 inner join customers c
on s.cust_id = c.cust_id
 where s.time_id = '17/03/19';

select *
  from sales
natural join products; -- okropny ;) twór. 


