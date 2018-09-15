/* Create an internal table for Patent data set. (Make sure not to include the header row)*/

Default Database already Exist, So we do not need to recreate.
use Default;
DROP TABLE IF EXISTS Assignment_Patent;
create table Assignment_Patent
(
PATENT int,
GYEAR int,
GDATE int,
APPYEAR int,
COUNTRY String,
POSTATE String,
ASSIGNEE int,
ASSCODE int,
CLAIMS int,
NCLASS int,
CAT int,
SUBCAT int,
CMADE int,
CRECEIVE int,
RATIOCIT int,
GENERAL int,
ORIGINAL int,
FWDAPLAG int,
BCKGTLAG int,
SELFCTUB int,
SELFCTLB int,
SECDUPBD int,
SECDLWBD int
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
TBLPROPERTIES("skip.header.line.count"="1");

LOAD DATA INPATH '/user/maria_dev/HiveAssignment_1/apat63_93.txt' OVERWRITE INTO TABLE Assignment_Patent;

/*Create an external table with dynamic partitioning for Patent data set so that it can be used 
efficiently for queries which require looking into patents granted for given year. (Use data from 
previous table and partition by Grant Year) */


SET hive.exec.dynamic.partition = true;
set hive.exec.dynamic.partition.mode=nonstrict;
create external table Assignment_PARTITION
(
  PATENT int,
  GDATE int,
  APPYEAR int,
  COUNTRY String,
  POSTATE String,
  ASSIGNEE int,
  ASSCODE int,
  CLAIMS int,
  NCLASS int,
  CAT int,
  SUBCAT int,
  CMADE int,
  CRECEIVE int,
  RATIOCIT int,
  GENERAL int,
  ORIGINAL int,
  FWDAPLAG int,
  BCKGTLAG int,
  SELFCTUB int,
  SELFCTLB int,
  SECDUPBD int,
  SECDLWBD int)
partitioned by (GYEAR int)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
location '/user/maria_dev/HiveAssignment_1/';


SET hive.exec.dynamic.partition = true;
set hive.exec.dynamic.partition.mode=nonstrict;
insert overwrite table Assignment_PARTITION partition(gyear)
select PATENT,GDATE,APPYEAR,COUNTRY,POSTATE,ASSIGNEE,
ASSCODE,CLAIMS,NCLASS,CAT,SUBCAT,CMADE,CRECEIVE,
RATIOCIT,GENERAL,ORIGINAL,FWDAPLAG ,BCKGTLAG ,SELFCTUB ,
SELFCTLB ,SECDUPBD,SECDLWBD,gyear from Assignment_Patent;

/*Find out number of patents granted in year 1963.*/

SELECT count(patent) Count_Patent FROM Assignment_PARTITION where gyear = '1963';

/* Find out number of patents granted in each country in year 1999.*/

SELECT country,count(patent)Count FROM Assignment_PARTITION where gyear = '1999'
GROUP BY country order BY Count desc;
