
-- Create table in Hive/HBase

set hbase.zookeeper.quorum localhost

CREATE TABLE top_cool_hbase (key string, value map<string, int>)
STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler'
WITH SERDEPROPERTIES ("hbase.columns.mapping" = ":key,review:")
TBLPROPERTIES ("hbase.table.name" = "top_cool");



-- Insert data

ADD JAR /usr/lib/hive/lib/zookeeper.jar;
ADD JAR /usr/lib/hive/lib/hbase.jar;
ADD JAR /usr/lib/hive/lib/hive-hbase-handler-0.10.0-cdh4.3.0.jar
ADD JAR /usr/lib/hive/lib/guava-11.0.2.jar;

INSERT OVERWRITE TABLE top_cool_hbase SELECT name, map(`date`, cast(coolness as int)) FROM top_cool


-- Insert cooler data: restaurant names

INSERT OVERWRITE TABLE top_cool_hbase SELECT name, map(`date`, cast(r.stars as int)) FROM review r join  business b on r.business_id = b.business_id;

