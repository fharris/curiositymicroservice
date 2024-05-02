DROP DATABASE IF EXISTS curiositydb;
DROP USER IF EXISTS curiosity;
CREATE DATABASE curiositydb;
CREATE USER 'curiosity'@'%' IDENTIFIED BY 'Welcome#1';
GRANT ALL PRIVILEGES ON curiositydb.* TO 'curiosity'@'%'; 
DROP DATABASE IF EXISTS championshipdb;
CREATE DATABASE championshipdb;
GRANT ALL PRIVILEGES ON championshipdb.* TO 'curiosity'@'%'; 
SHOW DATABASES;

