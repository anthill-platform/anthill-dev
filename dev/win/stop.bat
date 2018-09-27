@echo off

echo stopping services...
call net stop rabbitmq
call net stop mysql
call net stop redis