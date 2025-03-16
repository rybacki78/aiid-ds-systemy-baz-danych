create table regions (
   region_id   int primary key,
   region_name varchar(20) not null
);

create table countries (
   country_id   int primary key,
   country_name varchar(20) not null,
   region_id    number(2) not null,
   foreign key ( region_id )
      references regions ( region_id )
);

create table locations (
   location_id    int primary key,
   street_address varchar(150) not null,
   postal_code    varchar(10) not null,
   city           varchar(15) not null,
   state_province varchar(20) not null,
   country_id     decimal(2) not null,
   foreign key ( country_id )
      references countries ( country_id )
);

create table departments (
   department_id int primary key,
   department    varchar(50) not null,
   manager_id    int not null,
   location_id   int not null,
   foreign key ( location_id )
      references locations ( location_id )
);

create table jobs (
   job_id     int primary key,
   job_title  varchar(25) not null,
   min_salary int not null,
   max_salary int not null
);

alter table jobs
   add constraint salary_check check ( min_salary < max_salary - 2000 );

create table job_history (
   employee_id   int not null,
   start_date    date not null,
   end_date      date,
   job_id        int not null,
   department_id int not null,
   primary key ( employee_id,
                 start_date ),
   foreign key ( job_id )
      references jobs ( job_id ),
   foreign key ( department_id )
      references departments ( department_id )
);

create table employees (
   employee_id    int primary key,
   first_name     varchar(60) not null,
   last_name      varchar(60) not null,
   email          varchar(40) not null,
   phone_number   varchar(40) not null,
   hire_date      date not null,
   job_id         int not null,
   salary         decimal(9,2) not null,
   commission_pct varchar(20) not null,
   manager_id     int not null,
   department_id  int not null,
   foreign key ( manager_id )
      references employees ( employee_id ),
   foreign key ( department_id )
      references departments ( department_id ),
   foreign key ( job_id )
      references jobs ( job_id )
);

alter table job_history
   add foreign key ( employee_id )
      references employees ( employee_id );


alter table departments
   add foreign key ( manager_id )
      references employees ( employee_id );