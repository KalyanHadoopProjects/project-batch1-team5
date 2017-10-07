add jar /home/orienit/Desktop/hive_tasks/jars/hive-serdes-1.0-SNAPSHOT.jar;

use taskone;

create table if not exists student1_json(name string, id int, course string, year int) row format serde 'com.cloudera.hive.serde.JSONSerDe' location '/hive/json/task1';

select * from student1_json;

create table if not exists student_json_op(name string, id int, course string, year int);

insert into student_json_op(name, id, course, year) select name, id, course, year from student1_json where id = 2 and course = 'spark';

select * from student_json_op;
