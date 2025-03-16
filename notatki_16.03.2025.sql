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