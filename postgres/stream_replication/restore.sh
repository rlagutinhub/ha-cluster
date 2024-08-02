service postgresql stop
rm -fr /var/lib/postgresql/14/main/*
tar -xzf /tmp/123/base.tar.gz -C /var/lib/postgresql/14/main
tar -xzf /tmp/123/pg_wal.tar.gz -C /var/lib/postgresql/14/main/pg_wal
touch  /var/lib/postgresql/14/main/recovery.signal
rm -f /var/log/postgresql/*
chown postgres:postgres -R /var/lib/postgresql/14 /tmp/123
rename  's/(.*)\.partial/\1/' /var/lib/postgresql/14/STREAM_WALS/*
service postgresql start
sleep 1
#PGPASSWORD="postgres" psql -Upostgres example -c "select count(*) from t1;"
cat /var/log/postgresql/*.log

