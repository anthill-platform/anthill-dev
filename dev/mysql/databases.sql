create database dev_admin;
create database dev_login;
create database dev_config;
create database dev_dlc;
create database dev_environment;
create database dev_event;
create database dev_exec;
create database dev_game;
create database dev_leaderboard;
create database dev_message;
create database dev_profile;
create database dev_promo;
create database dev_social;
create database dev_store;
create database dev_static;
create database dev_report;
create database dev_blog;
create database dev_grafana;

CREATE USER 'anthill'@'%' IDENTIFIED BY 'Admin123';
CREATE USER 'grafana'@'%' IDENTIFIED BY 'Grafana123';

GRANT ALL PRIVILEGES ON *.* TO 'anthill'@'%';
GRANT ALL PRIVILEGES ON dev_grafana.* TO 'grafana'@'%';

FLUSH PRIVILEGES;
