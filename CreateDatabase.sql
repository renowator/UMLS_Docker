DROP DATABASE IF EXISTS `umls`;
DROP DATABASE IF EXISTS `umlsinterfaceindex`;
CREATE DATABASE umls; 
CREATE DATABASE umlsinterfaceindex;
# CREATE USER ‘root’@‘localhost’ IDENTIFIED BY '';
# GRANT ALL PRIVILEGES ON umls.* TO ‘root’@‘localhost' IDENTIFIED BY '';
# GRANT ALL PRIVILEGES ON umlsinterfaceindex.* TO ‘root’@‘localhost';


alter user 'root'@'localhost' identified by '';

USE umls;
