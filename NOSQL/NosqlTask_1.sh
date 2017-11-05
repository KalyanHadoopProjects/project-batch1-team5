#!/bin/bash
#
#Check the hbase-master aand hbase regionserver is running properly using 'service --status-all' command
#sudo su (switch to root)
#service hbase-master restart # On Master host
#service hbase-regionserver restart # On all RS hosts
#For connection refused error - remove /usr/lib/hadoop/etc/hadoop/mapred-site.xml with sudo permission, then restart hbase master
#sudo rm /usr/lib/hadoop/etc/hadoop/mapred-site.xml
# Copy the tsv and csv file in hdfs
hdfs dfs -mkdir -p hdfs://localhost:8020/user/nosql
hdfs dfs -put nosql/student1.tsv hdfs://localhost:8020/user/nosql
hdfs dfs -put nosql/student1.csv hdfs://localhost:8020/user/nosql

#create tables using hbase shell, output can be checked in tmpexecop1 and tmpexecop2

echo "create 'student1_tsv', 'cf'" | hbase shell 2> tmpexecop1
echo "create 'student1_csv', 'cf'" | hbase shell 2> tmpexecop2

hbase org.apache.hadoop.hbase.mapreduce.ImportTsv -Dimporttsv.columns=cf:name,HBASE_ROW_KEY,cf:course,cf:year student1_tsv hdfs://quickstart.cloudera:8020/user/nosql/student1.tsv 2>  tmpexecop3

hbase org.apache.hadoop.hbase.mapreduce.ImportTsv -Dimporttsv.separator=, -Dimporttsv.columns=cf:name,HBASE_ROW_KEY,cf:course,cf:year student1_csv hdfs://quickstart.cloudera:8020/user/nosql/student1.csv 2> tmpexecop4

echo "scan 'student1_tsv', { FILTER => \"RowFilter(>, 'binary:2') AND SingleColumnValueFilter('cf', 'course', = , 'binary:spark')\"}" | hbase shell 2> tmpexecop5

echo "scan 'student1_csv', { FILTER => \"RowFilter(>, 'binary:2') AND SingleColumnValueFilter('cf', 'course', = , 'binary:spark')\"}" | hbase shell 2> tmpexecop6

