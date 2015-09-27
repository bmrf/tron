@ECHO OFF
CD /D "%~DP0"
SETLOCAL ENABLEDELAYEDEXPANSION
FOR /F "tokens=3*" %%i IN ('REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /V ProductName ^| Find "ProductName"') DO (SET WIN_VER=%%i %%j)


REM Settings for Reg.ini file
IF /I "%WIN_VER:~0,9%"=="Windows 7" (set "REG_TOKENS=1,4,5,6,7")
IF /I "%WIN_VER:~0,9%"=="Windows 8" (set "REG_TOKENS=2,4,5,6,7")
IF /I "%WIN_VER:~0,9%"=="Windows 1" (set "REG_TOKENS=3,4,5,6,7")


FOR /F "eol=# tokens=%REG_TOKENS% delims=	|" %%A IN (Reg.ini) DO (
	IF /I %%A==Y (
		REG ADD "%%B" /T %%E /V %%C /D %%D /F >NUL 2>&1
	)
)




FOR /F "eol=# tokens=%REG_TOKENS% delims=	|" %%A IN (Reg.ini) DO (
	IF /I %%A==Y (
		setacl.exe -ON "%%B" -OT REG -ACTN SETOWNER -OWNR N:ADMINISTRATORS >NUL 2>&1
		setacl.exe -ON "%%B" -OT REG -ACTN ACE -ACE "N:ADMINISTRATORS;P:FULL" >NUL 2>&1
	)
)



pause
