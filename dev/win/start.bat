@echo off

echo starting services...
call net start rabbitmq
call net start mysql
call net start redis