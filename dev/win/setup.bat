@echo off

echo installcing scoop..
call powershell.exe "iex (new-object net.webclient).downloadstring('https://get.scoop.sh')"

echo installing scoop extras..
call scoop bucket add extras

echo installing python 3.5 and various services...
call scoop install python-exp@3.5.2 rabbitmq mysql redis
call scoop install rabbitmq
call scoop install mysql
call scoop install redis

mkdir C:\Anthill

echo creating virtualenv...
call virtualenv -p %userprofile%\scoop\apps\python-exp\3.5.2\python.exe C:\Anthill\venv

call C:\Anthill\venv\Scripts\activate

echo updating virtualenv...
call pip install --upgrade pip setuptools wheel

echo installing anthill services...
pushd ..\..\common
call python setup.py sdist
popd

pushd ..\..\exec
call python setup.py sdist
popd

echo starting services...
start /wait powershell start -verb runas 'setup_services.bat' am_admin
