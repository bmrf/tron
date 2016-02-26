@echo off
REM This is the source code for ProcessKiller-v1.1.0-TRON.exe
REM Kills all unnecessary processes in Windows XP and up.
REM Made for the Tron project by /u/cuddlychops06
REM Updated Sunday, March 9th, 2015 8:05pm
title ~ PROCESS KILLER ~
mode 46,10
color 4F
reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v ProductName | find "Microsoft Windows XP" >nul 2>nul || goto :kill

cls
if exist "%windir%\system32\taskkill.exe" (goto :kill) else (goto :copy)

:kill
cls
echo.
echo.
echo.
echo    ****************************************
echo    ** KILLING ALL UNNECESSARY PROCESSES! **
echo    ****************************************
ping -n 3 127.0.0.1 >nul
taskkill.exe /F /FI "USERNAME eq %USERNAME%" /FI "IMAGENAME ne ClassicShellService.exe" /FI "IMAGENAME ne explorer.exe" /FI "IMAGENAME ne dwm.exe" /FI "IMAGENAME ne cmd.exe" /FI "IMAGENAME ne mbam.exe" /FI "IMAGENAME ne teamviewer.exe" /FI "IMAGENAME ne TeamViewer_Service.exe" /FI "IMAGENAME ne Taskmgr.exe" /FI "IMAGENAME ne Teamviewer_Desktop.exe" /FI "IMAGENAME ne MsMpEng.exe" /FI "IMAGENAME ne tv_w32.exe" /FI "IMAGENAME ne LogMeIn.exe" /FI "IMAGENAME ne Tron.bat" /FI "IMAGENAME ne rkill.exe" /FI "IMAGENAME ne rkill64.exe" /FI "IMAGENAME ne rkill.com" /FI "IMAGENAME ne rkill64.com" /FI "IMAGENAME ne conhost.exe" /FI "IMAGENAME ne dashost.exe" /FI "IMAGENAME ne wget.exe" /FI "IMAGENAME ne TechToolbox.exe" /FI "IMAGENAME ne vmtoolsd.exe" /FI "IMAGENAME ne conhost.exe" >nul 2>nul
exit

:copy
cls
xcopy "%temp%\taskkill.exe" "%windir%\system32\" >nul || goto :failed
goto :kill

:failed
cls
echo Error copying file.
echo Unable to continue.
ping -n 3 127.0.0.1 >nul
exit
