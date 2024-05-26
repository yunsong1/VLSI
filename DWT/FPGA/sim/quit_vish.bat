@echo off

set "processName=vish.exe"

tasklist /fi "IMAGENAME eq %processName%" 2>NUL | find /I /N "%processName%" >NUL
if "%ERRORLEVEL%"=="0" (
    echo Process found, killing...
    taskkill /F /IM "%processName%"
) else (
    echo Process not found.
)
timeout /t 1 >nul
echo delay

REM 获取当前目录
set "currentDir=%cd%"

REM 循环遍历当前目录下的文件
for %%F in ("%currentDir%\*") do (
    REM 检查文件是否没有后缀
    if "%%~xF"=="" (
        REM 删除没有后缀的文件
        del "%%F"
        echo delete "%%F"
    )
)

exit
