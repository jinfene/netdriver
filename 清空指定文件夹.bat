@echo off
setlocal enabledelayedexpansion

:: 自动请求管理员权限
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo 正在请求管理员权限...
    powershell -command "Start-Process '%~dpnx0' -Verb RunAs"
    exit /b
)

:MAIN
cls
echo ==============================================
echo          安全清空文件夹工具（管理员模式）
echo ==============================================
echo.
echo 请选择操作：
echo 1. 清空预设文件夹（需修改脚本配置）
echo 2. 手动输入文件夹路径
echo 3. 退出
echo.

set /p choice=请输入选项 (1/2/3)：
if "%choice%"=="1" goto PREDEFINED
if "%choice%"=="2" goto CUSTOM
if "%choice%"=="3" exit
goto MAIN

:PREDEFINED
:: 【在此处修改预设路径】格式：set folders=("路径1" "路径2")
set folders=("%USERPROFILE%\Downloads" "D:\mysoft\v2rayN-windows-64-SelfContained-With-Core\guiTemps")
goto CONFIRM_DELETE

:CUSTOM
set /p target=请输入要清空的完整文件夹路径：
set folders=("%target%")
goto CONFIRM_DELETE

:CONFIRM_DELETE
echo.
echo 即将清空以下文件夹内容：
echo.
for %%a in %folders% do echo [危险操作] %%a
echo.
set /p confirm=确认要永久删除这些文件夹内容吗？(y/n) 
if /i "%confirm%" neq "y" (
    echo 操作已取消
    timeout /t 3 >nul
    goto MAIN
)

:CLEANING
for %%F in %folders% do (
    if exist "%%F\" (
        echo 正在清空: %%F
        :: 删除所有文件（包括隐藏/系统文件）
        del /f /s /q "%%F\*.*" >nul
        :: 删除所有子文件夹
        for /d %%D in ("%%F\*") do rd /s /q "%%D" >nul
        echo [完成] %%F 已清空
    ) else (
        echo [错误] 路径不存在: %%F
    )
)

echo.
echo 操作已完成！
echo 5秒后自动关闭...
timeout /t 5 >nul
exit
