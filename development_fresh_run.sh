echo "Bundle install"
bundle install
echo "Update postgres"
brew install postgres
echo "Start postgres"
pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log -w start
echo "Drop role"
psql postgres -c "DROP ROLE IF EXISTS cocoaheads;"
echo "Create role"
psql postgres -c "CREATE ROLE cocoaheads WITH createdb login PASSWORD 'cocoaheads';"
echo "Drop previous database"
rake db:drop RAILS_ENV=development
echo "Create db"
rake db:create RAILS_ENV=development
rake db:migrate RAILS_ENV=development
rake db:schema:load RAILS_ENV=development
rake db:seed RAILS_ENV=development
echo "start server"
rails server