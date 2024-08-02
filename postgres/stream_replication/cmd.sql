drop table t1;
create table t1(id serial, t text);
select ctid,* from t1;
select count(*) from t1;
SELECT pg_size_pretty( pg_total_relation_size('t1') );



select pg_relation_filepath('t1');

SELECT pg_create_physical_replication_slot('stream_wals'); 
SELECT pg_drop_replication_slot('stream_wals'); 

select * from pg_replication_slots;
select * from pg_stat_replication; 

truncate t1;

show data_directory;

select pg_relation_filepath('t1');
select ctid,* from t1;

insert into  t1(t) (SELECT  md5(random()::text) as t from generate_series(1,200000));
insert into  t1(t) (SELECT  md5(random()::text) as t from generate_series(1,400000));
insert into  t1(t) (SELECT  md5(random()::text) as t from generate_series(1,10000000));
insert into  t1(t) (SELECT  md5(random()::text) as t from generate_series(1,200000));
insert into  t1(t) (SELECT  md5(random()::text) as t from generate_series(1,1));
insert into  t1(t) values('11111111111111111111111111111111111');
insert into  t1(t) values('22222222222222222222222222222222222');
insert into  t1(t) values('33333333333333333333333333333333333');

checkpoint;



update t1 set t='4444444444444444444444444444444444' where id=1;
delete from t1  where id=2;
delete from t1  where id>9000;
delete from t1  where id>5000 and id<6000;

vacuum full;
vacuum full t1;
vacuum t1;
VACUUM VERBOSE t1;

CREATE EXTENSION pgstattuple;
SELECT * FROM pgstattuple('t1');

create extension pageinspect;
SELECT * FROM heap_page_items(get_raw_page('t1', 0));
SELECT * FROM page_header(get_raw_page('t1', 0));
SELECT tuple_data_split('t1'::regclass, t_data, t_infomask, t_infomask2, t_bits) FROM heap_page_items(get_raw_page('t1', 0));
SELECT * FROM heap_page_item_attrs(get_raw_page('t1', 0), 't1'::regclass);


SELECT * FROM page_header(get_raw_page('t1', 0));
SELECT * FROM page_header(get_raw_page('t1', 0));
SELECT * FROM page_header(get_raw_page('t1', 0));

SELECT txid_current();
ANALYZE t1;

SELECT * FROM pg_stat_progress_vacuum;	

CREATE EXTENSION pg_buffercache;

SELECT pg_current_wal_insert_lsn(); 0/46ED80B0;
SELECT lsn FROM page_header(get_raw_page('t1',0));0/46ED8448;
SELECT pg_current_wal_lsn(), pg_current_wal_insert_lsn();0/4709F820        |0/4709F820 

SELECT * FROM pg_stat_bgwriter;
