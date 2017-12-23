--Solution for json file

--1. Using serde

--downloaded pre built version of the JSON serde 'hive-serdes-1.0-SNAPSHOT.jar'

ADD jar /home/orienit/work/input/hive/hive-serdes-1.0-SNAPSHOT.jar;

{Added [/home/orienit/work/input/hive/hive-serdes-1.0-SNAPSHOT.jar] to class path
Added resources: [/home/orienit/work/input/hive/hive-serdes-1.0-SNAPSHOT.jar]
}
create external table hivetask.student1_json (
name STRING,
id INT,
course STRING,
YEAR INT
)
ROW FORMAT SERDE 'com.cloudera.hive.serde.JSONSerDe'
Location '/hive/externaldata/json';

LOAD DATA LOCAL INPATH '/home/orienit/work/input/hive/student1.json' OVERWRITE into table hivetask.student1_json;

CREATE external TABLE hivetask.student1_json_op(name STRING);
insert into hivetask.student1_json_op(name) select name from hivetask.student1_json where id>2 and course ='spark';


--2. Using LATERAL VIEW /json_tuple

create external table if not exists hivetask.student1_jsonLV (
student STRING
)
Location '/hive/externaldata/json';

LOAD DATA LOCAL INPATH '/home/orienit/work/input/hive/student1.json' OVERWRITE into table hivetask.student1_json;

select t.name from hivetask.student1_jsonLV s LATERAl VIEW json_tuple(s.student, 'name', 'id', 'course') t As name, id, course where t.id > 2 and t.course = 'spark';



------------XML file loading use xml serde , for that download hivexmlserde-1.0.5.3.jar file

ADD jar /home/orienit/work/input/hive/hivexmlserde-1.0.5.3.jar;
-- create table for this data ::::: <student><name>dev</name><id>6</id><course>hadoop</course><year>2015</year></student>
-- Needs to mention output/input formats

create external table if not exists hivetask.student1_xml(name string, id int, course string, year int)
row format serde 'com.ibm.spss.hive.serde2.xml.XmlSerDe'
with serdeproperties(
'column.xpath.name' = '/student/name/text()',
'column.xpath.id' = '/student/id/text()',
'column.xpath.course' = '/student/course/text()',
'column.xpath.year' = '/student/year/text()')
stored as
inputformat 'com.ibm.spss.hive.serde2.xml.XmlInputFormat'
outputformat 'org.apache.hadoop.hive.ql.io.IgnoreKeyTextOutputFormat'
location '/hive/externaldata/xml/task1'
tblproperties('xmlinput.start' = '<student>', 'xmlinput.end' = '</student>');

hdfs dfs -put /home/orienit/work/input/hive/student1.xml /hive/externaldata/xml/task1

select * from hivetask.student_xml

create table hivetask.student1_xml_op (name string);
insert into hivetask.student1_xml_op(name) select name from hivetask.student1_xml where id > 2 and course = 'spark'


