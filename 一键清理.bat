@echo off
setlocal enabledelayedexpansion

:: 清理系统临时文件
echo 正在清理系统临时文件...
del /f /s /q %systemroot%\Temp\*.* >nul 2>&1
rd /s /q %systemroot%\Temp >nul 2>&1
md %systemroot%\Temp >nul 2>&1

:: 清理用户临时文件
echo 正在清理用户临时文件...
del /f /s /q "%userprofile%\AppData\Local\Temp\*.*" >nul 2>&1
rd /s /q "%userprofile%\AppData\Local\Temp" >nul 2>&1
md "%userprofile%\AppData\Local\Temp" >nul 2>&1

:: 清理预取文件
echo 正在清理预取文件...
del /f /s /q %systemroot%\Prefetch\*.* >nul 2>&1

:: 清理DNS缓存
echo 正在清理DNS缓存...
ipconfig /flushdns >nul 2>&1

:: 清理系统更新缓存
echo 正在清理系统更新缓存...
net stop wuauserv >nul 2>&1
rd /s /q %systemroot%\SoftwareDistribution\Download >nul 2>&1
net start wuauserv >nul 2>&1

:: 清理浏览器缓存（根据需要取消注释）
:: echo 正在清理浏览器缓存...
:: rd /s /q "%userprofile%\AppData\Local\Google\Chrome\User Data\Default\Cache" >nul 2>&1
:: rd /s /q "%userprofile%\AppData\Local\Microsoft\Edge\User Data\Default\Cache" >nul 2>&1

:: 清理回收站
echo 正在清理回收站...
rd /s /q %systemdrive%\$Recycle.bin >nul 2>&1

:: 运行磁盘清理
echo 正在运行磁盘清理...
cleanmgr /sagerun:1 >nul 2>&1

:: 完成提示
echo.
echo 垃圾清理完成！
echo.
pause
