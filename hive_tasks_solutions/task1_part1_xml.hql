add jar /home/orienit/Desktop/hive_tasks/jars/hivexmlserde-1.0.5.3.jar;

use taskone;

create table if not exists student1_xml(name string, id int, course string, year int)
row format serde 'com.ibm.spss.hive.serde2.xml.XmlSerDe'
with serdeproperties(
'column.xpath.name' = '/student/name/text()',
'column.xpath.id' = '/student/id/text()',
'column.xpath.course' = '/student/course/text()',
'column.xpath.year' = '/student/year/text()')
stored as
inputformat 'com.ibm.spss.hive.serde2.xml.XmlInputFormat'
outputformat 'org.apache.hadoop.hive.ql.io.IgnoreKeyTextOutputFormat'
location '/hive/xml/task1/part1'
tblproperties('xmlinput.start' = '<student>', 'xmlinput.end' = '</student>');

select * from student1_xml;

create table if not exists student1_xml_op(name string, id int, course string, year int);

insert into student1_xml_op(name, id, course, year) select name, id, course, year from student1_xml where id = 2 and course = 'spark';

select * from student1_xml_op;


