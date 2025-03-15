create table regions (
   region_id   number(2),
   region_name varchar(20)
);

alter table regions add primary key ( region_id );

create table countries (
   country_id   decimal(2) primary key,
   country_name varchar(20),
   region_id    number(2)
);

alter table countries
   add foreign key ( region_id )
      references regions ( region_id );

create table locations (
   location_id    int primary key,
   street_address varchar(150) not null,
   postal_code    varchar(10) not null,
   city           varchar(15) not null,
   state_province varchar(20) not null,
   country_id     decimal(2)
);

alter table locations
   add foreign key ( country_id )
      references countries ( country_id );

create table departments (
   department_id int primary key,
   department    varchar(50),
   manager_id    int,
   location_id   int,
   foreign key ( location_id )
      references locations ( location_id )
);

create table jobs (
   job_id     int primary key,
   job_title  varchar(25),
   min_salary int,
   max_salary int
);

alter table jobs
   add constraint salary_check check ( min_salary < max_salary - 2000 );

create table job_history (
   employee_id   int,
   start_date    date,
   end_date      date,
   job_id        int,
   department_id int,
   primary key ( employee_id,
                 start_date ),
   foreign key ( job_id )
      references jobs ( job_id ),
   foreign key ( department_id )
      references departments ( department_id )
);

create table employees (
   employee_id    int primary key,
   first_name     varchar(60),
   last_name      varchar(60),
   email          varchar(40),
   phone_number   varchar(40),
   hire_date      date,
   job_id         int,
   salary         decimal(9,2),
   commission_pct varchar(20),
   manager_id     int,
   department_id  int,
   foreign key ( manager_id )
      references employees ( employee_id ),
   foreign key ( department_id )
      references departments ( department_id )
);

alter table job_history add foreign key ( employee_id )
      references employees ( employee_id );


alter table departments add foreign key ( manager_id )
      references employees ( employee_id );