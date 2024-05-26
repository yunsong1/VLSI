@echo off
REM set bin_path=D:/altera/13.1/modelsim_ase/win32aloem
set bin_path=D:/modelsim_dlx64_10.6c/win64pe

set "currentDir=%cd%"

REM 检查 "work" 文件夹是否存在
if not exist "%currentDir%\work\" (
    REM echo no_work
    REM 创建 "work" 文件夹
    mkdir "%currentDir%\work"
    REM echo create_work_ok
) else (
    REM delete_start
    del /q "%currentDir%\work\*.*"
    REM echo delete_ok
)


call "%bin_path%/modelsim"   -do "do {c.do};do {s.do}" -l simulate.log
if "%errorlevel%"=="1" goto END
if "%errorlevel%"=="0" goto SUCCESS
:END
exit 1
:SUCCESS
exit 0




