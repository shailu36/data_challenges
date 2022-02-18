select count(1) from data.esg_scores esg ----7125

select count(1) from data.id_map---9876

select count(1) from data.sp500 --500

--inner join yeilds only 292
select esg.*,mapp.instr_id,mapp.name from 
data.esg_scores esg,data.id_map mapp,data.sp500 sp
where esg.id = mapp.id
and mapp.instr_id = sp.instr_id

---full outer join has lots of missing data but gets the bigger picture 11k rows.
select * from 
data.esg_scores esg
full outer join  data.id_map mapp
on esg.id = mapp.id
full outer join data.sp500 sp
on mapp.instr_id = sp.instr_id

DROP TABLE IF EXISTS data.sp500_esg_scores 
CREATE TABLE data.sp500_esg_scores (
  id bigint,
  total_score numeric(15,6),
  e_score numeric(15,6),
  s_score numeric(15,6),
  g_score numeric(15,6),
  instr_id text,
  name text
);



insert into data.sp500_esg_scores(
select esg.*,mapp.instr_id,mapp.name 
from data.esg_scores esg
full outer join  data.id_map mapp
on esg.id = mapp.id
full outer join data.sp500 sp
on mapp.instr_id = sp.instr_id)

select * from data.sp500_esg_scores

DROP TABLE IF EXISTS data.sp500_esg_scores_new
CREATE TABLE data.sp500_esg_scores_new(
  id bigint,
  total_score numeric(15,6),
  e_score numeric(15,6),
  s_score numeric(15,6),
  g_score numeric(15,6),
  instr_id text,
  name text,
  rank Numeric,
  total_score_median Numeric ,
  e_score_median Numeric ,
  s_score_median Numeric,
  g_score_median Numeric
);

insert into data.sp500_esg_scores_new(
	SELECT s.id,s.total_score,s.e_score,s.s_score,s.g_score,s.instr_id,s.name,
    PERCENT_RANK() OVER (		
        ORDER BY total_score ASC ) AS rank,
    (select percentile_cont(0.5) within group (ORDER BY total_score ) from data.sp500_esg_scores) AS total_score_median,
	(select percentile_cont(0.5) within group (ORDER BY e_score ) from data.sp500_esg_scores)AS e_score_median,
	(select percentile_cont(0.5) within group (ORDER BY s_score ) from data.sp500_esg_scores) AS s_score_median,
	(select percentile_cont(0.5) within group (ORDER BY g_score ) from data.sp500_esg_scores)AS g_score_median

FROM
	data.sp500_esg_scores s
	order by s.id,s.total_score,s.e_score,s.s_score,s.g_score,s.instr_id,s.name);

select * from data.sp500_esg_scores_new

update data.sp500_esg_scores_new
set rank =0,total_score_median=0,e_score_median=0,s_score_median=0,g_score_median=0
where total_score is NULL

DROP TABLE IF EXISTS data.sp500_esg_scores
ALTER TABLE IF EXISTS data.sp500_esg_scores_new
RENAME TO sp500_esg_scores

Recommendations for the pipeline
1. We need to have data coming in where the data quality is good and and not have missing values as much as possible.
2. scheduler step -set up a batch job as this data is getting updated is getting updated say sunday.
3. data processing step-we should be able to wrangle the data and create a table that has all the required columns.
   we should have indexes on primary keys of the table to we can read the table faster and not run into performance issues.
4.We could run the rank update and the percentile calculation as final step of the data wrangling. 
5.Now this table that has the most recent data is ready to send over to the ML model creation/ reporting.


