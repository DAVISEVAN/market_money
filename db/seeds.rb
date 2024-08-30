cmd = "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $(whoami) -d market_money_development db/data/market_money_development.pgdump"
puts "Loading PostgreSQL Data dump into local database with command:"
puts cmd
system(cmd)