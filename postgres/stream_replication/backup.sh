rm -rf /tmp/123
rm -f /var/lib/postgresql/14/ARCH_WALS/*
PGPASSWORD="postgres" pg_basebackup --checkpoint=fast -P -Xstream -z -Ft -h 127.0.0.1 -p5432 -Upostgres -D  /tmp/123
