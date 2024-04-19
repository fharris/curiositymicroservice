DROP DATABASE IF EXISTS curiositydb;
#DROP DATABASE IF EXISTS championshipdb;
DROP USER IF EXISTS curiosity;
#DROP USER IF EXISTS championship;
CREATE DATABASE curiositydb;
#CREATE DATABASE championshipdb;
CREATE USER 'curiosity'@'%' IDENTIFIED BY 'Welcome#1';
#CREATE USER 'championship'@'%' IDENTIFIED BY 'Welcome#1';
GRANT ALL PRIVILEGES ON curiositydb.* TO 'curiosity'@'%'; 
#GRANT ALL PRIVILEGES ON championshipdb.* TO 'championship'@'%'; 
#GRANT ALL PRIVILEGES ON championshipdb.* TO 'curiosity'@'%'; 
SHOW DATABASES;

