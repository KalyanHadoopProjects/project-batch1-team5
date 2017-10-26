
#! NoSQLTask_7 - Task # 07 :: Create a table in Cassandra and copy data into an output file ::

CREATE KEYSPACE kalyan WITH replication = {'class': 'SimpleStrategy', 'replication_factor' : 1};

DESC KEYSPACES ;

USE kalyan;

CREATE TABLE IF NOT EXISTS student1_csv(
name text,
id int ,
course text,
year int,
PRIMARY KEY (name, id)
);

DESC TABLE student1_csv ;
	
COPY student1_csv(name, id, course, year) FROM '/home/orienit/kalyan/nosql/student1.csv' WITH DELIMITER=',';

select * from student1_csv;

paging off;

select * from student1_csv WHERE id > 2 AND course = 'spark' ALLOW FILTERING;

CREATE MATERIALIZED VIEW kalyan.student1_csv_op2 
AS SELECT * FROM kalyan.student1_csv 
WHERE id IS NOT NULL AND id > 2 AND course IS NOT NULL 
PRIMARY KEY (name, id)
WITH caching = { 'keys' : 'ALL', 'rows_per_partition' : '10' }
AND comment = 'Student Information' ;
   
#! executed this file at cqlsh with command source '/home/orienit/NosqlTask_07.sh'





