@echo off
setlocal enabledelayedexpansion

:: ����ϵͳ��ʱ�ļ�
echo ��������ϵͳ��ʱ�ļ�...
del /f /s /q %systemroot%\Temp\*.* >nul 2>&1
rd /s /q %systemroot%\Temp >nul 2>&1
md %systemroot%\Temp >nul 2>&1

:: �����û���ʱ�ļ�
echo ���������û���ʱ�ļ�...
del /f /s /q "%userprofile%\AppData\Local\Temp\*.*" >nul 2>&1
rd /s /q "%userprofile%\AppData\Local\Temp" >nul 2>&1
md "%userprofile%\AppData\Local\Temp" >nul 2>&1

:: ����Ԥȡ�ļ�
echo ��������Ԥȡ�ļ�...
del /f /s /q %systemroot%\Prefetch\*.* >nul 2>&1

:: ����DNS����
echo ��������DNS����...
ipconfig /flushdns >nul 2>&1

:: ����ϵͳ���»���
echo ��������ϵͳ���»���...
net stop wuauserv >nul 2>&1
rd /s /q %systemroot%\SoftwareDistribution\Download >nul 2>&1
net start wuauserv >nul 2>&1

:: ������������棨������Ҫȡ��ע�ͣ�
:: echo �����������������...
:: rd /s /q "%userprofile%\AppData\Local\Google\Chrome\User Data\Default\Cache" >nul 2>&1
:: rd /s /q "%userprofile%\AppData\Local\Microsoft\Edge\User Data\Default\Cache" >nul 2>&1

:: �������վ
echo �����������վ...
rd /s /q %systemdrive%\$Recycle.bin >nul 2>&1

:: ���д�������
echo �������д�������...
cleanmgr /sagerun:1 >nul 2>&1

:: �����ʾ
echo.
echo ����������ɣ�
echo.
pause
