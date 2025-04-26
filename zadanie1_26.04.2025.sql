-- 2. Dla każdego wiersza z tabeli sales wypisać nazwisko klienta, nazwę produktu, ilość sprzedanego produktu,
-- sumę zapłaconą danego dnia za produkty, poprzednią cenę oraz kolejną cenę danego produktu.

select c.cust_last_name,
       p.prod_name,
       s.quantity_sold,
       s.amount_sold,
       lag(s.amount_sold,
           1)
       over(partition by s.prod_id
            order by s.time_id
       ),
       lead(s.amount_sold,
            1)
       over(partition by s.prod_id
            order by s.time_id
       )
  from sales s
  left join customers c
on s.cust_id = c.cust_id
  left join products p
on s.prod_id = p.prod_id;
