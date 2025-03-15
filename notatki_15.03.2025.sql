alter user sp_rybackip identified by nowehaslo; -- zmiana hasła

-- DDL Data Definition Language
-- CREATE, ALTER, DROP
create table products (
   product_id        int primary key,
   product_name      varchar(150) not null,
   products_category varchar(250) default 'zywnosc',
   price             decimal(12,2),
   quantity          int,
   unit              varchar(10),
   last_order_date   date
);  -- stwórz tabelę products

drop table products cascade constraints;  --usuwanie tabeli

create table customers (
   pesel        varchar(11) primary key,
   first_name   varchar(60) not null,
   last_name    varchar(60) not null,
   phone_number varchar(20),
   birth_date   date not null
); -- stwórz tabelę customers

create table sales (
   sale_id  int,
   quantity number(6,0),
   price    decimal(12,2)
); -- stwórz tabelę sales

alter table sales add primary key ( sale_id ); -- dodaje klucz głowny do tabeli

alter table sales modify
   quantity number(6,0) not null; -- modyfikuje pole tabeli quantity

alter table sales modify
   price real not null; -- modyfikuje pole tabeli real

alter table sales add product_id int not null; -- dodaje pole do tabeli

alter table sales
   add foreign key ( product_id )
      references products ( product_id );  --dodaje klucz obcy

alter table sales add pesel int not null; -- dodaje pole do tabeli

alter table sales
   add foreign key ( pesel )
      references customers ( pesel );  --dodaje klucz obcy (rozne typy danych błąd)

alter table sales modify
   pesel varchar(11); -- modyfikuje pole tabeli real


alter table sales
   add foreign key ( pesel )
      references customers ( pesel );  --dodaje klucz obcy (teraz działa)