echo "Start postgres"
pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log -w start
echo "start server"
rails server