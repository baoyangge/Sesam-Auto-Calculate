@echo off
cd /d %~dp0

:: change encode into UTF-8
chcp 65001
del /q output.csv > NUL 2>&1
rmdir /s /q work
mkdir work\z > NUL 2>&1
copy /Y pidac_template\* .\work\
copy /Y m1*.csv .\work\
copy /Y sk*.txt .\work\
cd work

set IDAC=%CD%
set PATH=%PATH%;%CD%\bin
.\create_pidac_input2.exe
.\csv_txt.exe z_m1_n.csv z_m1.idm
itmp m1 fcom=z_m1.idm fwav=z_linear.ssw
isel m1
edit_isel.exe z\m1.isel m1.isel
isel_isw m1
isw_csv z\m1.isw 0 3
get_secant_stiffness.exe z\m1.csv m1_skeleton.csv z_m1_n.csv output.csv
copy /Y output.csv ..\

:: restore encode into SHIFT-JIS
::chcp 932
pause
