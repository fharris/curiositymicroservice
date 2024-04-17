echo "Configuring Curiosity Database"

kubectl -n curiosityevents exec -it  `kubectl -n curiosityevents get \
 --no-headers=true pods -l app=mysql-db -o custom-columns=:metadata.name` \
 -- mysql -h 127.0.0.1 -u root -pmySQLpword#2023 < ./databaseconfig/create-curiositydb-resources.sql
