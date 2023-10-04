@echo on
mkdir SenhasWifi
cd SenhasWifi
setlocal enabledelayedexpansion
for /f "tokens=2delims=:" %%a in ('netsh wlan show profile ^|findstr ":"') do 	(
	set "ssid=%%~a"
	call :getpwd "%%ssid:~1%%"
	netsh wlan show profile name="%ssid:"=%" key^=clear
	
	)

:getpwd
set "ssid=%*"
netsh wlan show profile name^="%ssid:"=%" key^=clear > "%ssid:"=%".txt
