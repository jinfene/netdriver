@echo off
setlocal enabledelayedexpansion

:: �Զ��������ԱȨ��
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo �����������ԱȨ��...
    powershell -command "Start-Process '%~dpnx0' -Verb RunAs"
    exit /b
)

:MAIN
cls
echo ==============================================
echo          ��ȫ����ļ��й��ߣ�����Աģʽ��
echo ==============================================
echo.
echo ��ѡ�������
echo 1. ���Ԥ���ļ��У����޸Ľű����ã�
echo 2. �ֶ������ļ���·��
echo 3. �˳�
echo.

set /p choice=������ѡ�� (1/2/3)��
if "%choice%"=="1" goto PREDEFINED
if "%choice%"=="2" goto CUSTOM
if "%choice%"=="3" exit
goto MAIN

:PREDEFINED
:: ���ڴ˴��޸�Ԥ��·������ʽ��set folders=("·��1" "·��2")
set folders=("%USERPROFILE%\Downloads" "D:\mysoft\v2rayN-windows-64-SelfContained-With-Core\guiTemps")
goto CONFIRM_DELETE

:CUSTOM
set /p target=������Ҫ��յ������ļ���·����
set folders=("%target%")
goto CONFIRM_DELETE

:CONFIRM_DELETE
echo.
echo ������������ļ������ݣ�
echo.
for %%a in %folders% do echo [Σ�ղ���] %%a
echo.
set /p confirm=ȷ��Ҫ����ɾ����Щ�ļ���������(y/n) 
if /i "%confirm%" neq "y" (
    echo ������ȡ��
    timeout /t 3 >nul
    goto MAIN
)

:CLEANING
for %%F in %folders% do (
    if exist "%%F\" (
        echo �������: %%F
        :: ɾ�������ļ�����������/ϵͳ�ļ���
        del /f /s /q "%%F\*.*" >nul
        :: ɾ���������ļ���
        for /d %%D in ("%%F\*") do rd /s /q "%%D" >nul
        echo [���] %%F �����
    ) else (
        echo [����] ·��������: %%F
    )
)

echo.
echo ��������ɣ�
echo 5����Զ��ر�...
timeout /t 5 >nul
exit
