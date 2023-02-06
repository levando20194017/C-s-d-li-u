Create table DEPARTMENT (
   DEPT_ID int not null,
   DEPT_NAME varchar(255) not null,
   DEPT_NO varchar(20) not null,
   LOCATION varchar(255),
   primary key (DEPT_ID),
   unique (DEPT_NO)
);