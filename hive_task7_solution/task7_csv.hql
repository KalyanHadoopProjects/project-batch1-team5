add jar /home/orienit/Desktop/hive_tasks/jars/hive-serde-0.14.0.jar;

create database if not exists taskseven;

use taskseven;

create external table if not exists risk_factor(
YearStart int,
YearEnd int,
LocationAbbr string,
LocationDesc string,
Datasource string,
Class string,
Topic string,
Question string,
Data_Value_Unit string,
Data_Value_Type string,
Data_Value int,
Data_Value_Alt int,
Data_Value_Footnote_Symbol string,
Data_Value_Footnote string,
Low_Confidence_Limit int,
High_Confidence_Limit int,
Sample_Size int,
Total string,Ageyears string,
Education string,Gender string,
Income string,
RaceEthnicity string,
GeoLocation string,
ClassID string,
TopicID string,
QuestionID string,
DataValueTypeID string,
LocationID int,
StratificationCategory1 string,
Stratification1 string,
StratificationCategoryId1 string,
StratificationID1 string
)
ROW FORMAT 
SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
STORED AS 
INPUTFORMAT 'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat' 
LOCATION '/hive/csv/task7';

select * from risk_factor limit 10;

set hive.exec.dynamic.partition.mode=nonstrict;

create external table risk_factor_partition(
YearStart int,
LocationAbbr string,
Datasource string,
Class string,
Topic string,
Question string,
Data_Value_Unit string,
Data_Value_Type string,
Data_Value int,
Data_Value_Alt int,
Data_Value_Footnote_Symbol string,
Data_Value_Footnote string,
Low_Confidence_Limit int,
High_Confidence_Limit int,
Sample_Size int,
Total string,
Ageyears string,
Education string,
Gender string,
Income string,
RaceEthnicity string,
ClassID string,
TopicID string,
QuestionID string,
DataValueTypeID string,
LocationID int,
StratificationCategory1 string,
Stratification1 string,
StratificationCategoryId1 string,
StratificationID1 string
) 
partitioned by (
YearEnd int,
LocationDesc string,
GeoLocation string
) 
row format delimited 
fields terminated by '\t'
lines terminated by '\n'
stored as textfile;

INSERT OVERWRITE TABLE risk_factor_partition PARTITION(YearEnd,LocationDesc,GeoLocation) select * from risk_factor;

select * from risk_factor_partition;
