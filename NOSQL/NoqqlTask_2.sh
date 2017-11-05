#Need to covert for proper execution through sh script

hdfs dfs -mkdir -p /user/orienit/kalyan/hbase/

hbase org.apache.hadoop.hbase.mapreduce.Export "student1_csv" "/user/orienit/kalyan/hbase/student1_csv"

#creating new table 'student1_csv1' as student1_csv already exist
create 'student1_csv1','cf'

hbase org.apache.hadoop.hbase.mapreduce.Import -Dimport.columns=cf:name,HBASE_ROW_KEY,cf:course,cf:year student1_csv1 hdfs://quickstart.cloudera:8020/user/orienit/kalyan/hbase/student1_csv/part-m-00000


