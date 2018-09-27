@setlocal enableextensions
@cd /d "%~dp0"

call rabbitmq-service install
call mysqld --install
call redis-server --service-install %userprofile%\scoop\apps\redis\current\redis.windows-service.conf
call sc create Redis start=auto DisplayName=Redis binpath="\"%userprofile%\scoop\apps\redis\current\redis-server.exe\" --service-run \"%userprofile%\scoop\apps\redis\current\redis.windows-service.conf\""

call start.bat