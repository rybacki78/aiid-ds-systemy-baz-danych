delete from regions;
delete from jobs;

insert into regions values ( 1,
                             'Europa' );

insert into regions values ( 2,
                             'Azja' );

insert into regions values ( 3,
                             'Afryka' );

insert into regions values ( 4,
                             'Ameryka' );

select *
  from regions;

insert into jobs values ( 1,
                          'CEO',
                          10000,
                          50000 );
insert into jobs values ( 2,
                          'CIO',
                          9000,
                          40000 );
insert into jobs values ( 3,
                          'CTO',
                          9500,
                          45000 );
insert into jobs values ( 4,
                          'CSO',
                          8000,
                          35000 );

select *
  from jobs;

update regions
   set
   region_name = 'Euroazja'
 where region_id in ( 1,
                      2 );

select *
  from regions;


update jobs
   set min_salary = min_salary + 1000,
       max_salary = max_salary + 1000
 where job_title like ( '%E%' )
    or job_title like ( '%T%' ); -- zmieniłem bo moje job_title nie miały ani 'a' ani 'o' ;)

select *
  from jobs;

delete from jobs
 where min_salary > 10000; -- zmieniłem na > 10000 bo lepiej płacę ;)

select *
  from jobs;