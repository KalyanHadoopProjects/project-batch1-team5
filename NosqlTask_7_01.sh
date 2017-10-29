
# Exporting files local FS to HDFS - commands to be run at terminal
hadoop fs rm -r /project
hadoop fs -mkdir /hbase
hadoop fs -mkdir /hbase/project
hadoop fs -put /home/orienit/nosql/*.* /hbase/project

# Importing data from HBASE to HDFS 

create 'student1_csv', 'cf1'

hbase org.apache.hadoop.hbase.mapreduce.ImportTsv -Dimporttsv.columns=HBASE_ROW_KEY,cf1:name,cf1:course,cf1:year student1_tsv 
hdfs://quickstart.cloudera:8020/hbase/project/student1.tsv

scan 'student1_tsv'

scan 'student1_tsv', {FILTER => "RowFilter(>, 'binary:2') AND ValueFilter(=,'binary:spark')"}

create 'student_tsv', 'cf2'

hbase org.apache.hadoop.hbase.mapreduce.ImportTsv -Dimporttsv.separator=, -Dimporttsv.columns=HBASE_ROW_KEY,cf2:name,cf2:course,cf2:year student1_csv hdfs://quickstart.cloudera:8020/hbase/project/student1.tsv

scan 'student1_csv'

scan 'Student2_csv', {FILTER => "RowFilter(>, 'binary:2') AND ValueFilter(=,'binary:spark')"}



