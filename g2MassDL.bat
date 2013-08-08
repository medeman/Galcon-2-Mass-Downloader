@echo off
set version=0.2.2
title Galcon 2 Mass Downloader
color 07
cls
if not exist wget.exe (
	echo wget.exe is required to run this script.
	echo Press any key to exit.
	pause >NUL
	exit
)
if not exist chgcolor.exe (
	echo chgcolor.exe is required to run this script.
	echo Press any key to exit.
	pause >NUL
	exit
)
:from
set /p from=Download versions from (i.e. 3): 
:to
set /p to=Download versions to (i.e. 11): 
if %to% LSS %from% (
	echo Must be higher or equal to %from%.
	goto to
)
set currentVersion=%from%

chgcolor f

:create_folders
if not %currentVersion% == 16 (
	if not exist %currentVersion% mkdir %currentVersion%
)
set /a currentVersion=%currentVersion%+1
if %currentVersion% GTR %to% (
	set currentVersion=%from%
	goto download
)
goto create_folders

:download
if %currentVersion% LSS "3" (
	set seperator=-
) else (
	set seperator=
)
if %currentVersion% == 16 (
	chgcolor e
	echo 16 is a server-side only update. No download.
	chgcolor f
	goto skipLnx
)
if not exist %currentVersion%\Galcon2.zip (
	if exist Galcon2.zip del Galcon2.zip
	echo Downloading %currentVersion% for Windows...
	wget http://www.galcon.com/g2/files/beta%seperator%%currentVersion%/Galcon2.zip 1> NUL 2> NUL
	if not exist Galcon2.zip (
		chgcolor c
		echo Error downloading %currentVersion% for Windows
		chgcolor f
		goto skipWin
	)
	move Galcon2.zip %currentVersion% >NUL
	chgcolor a
	echo Downloaded %currentVersion% for Windows
	chgcolor f
) else (
	echo Version %currentVersion% for Windows already downloaded
)
:skipWin

if not exist %currentVersion%\Galcon2.dmg (
	if exist Galcon2.dmg del Galcon2.dmg
	echo Downloading %currentVersion% for Mac OS X...
	wget http://www.galcon.com/g2/files/beta%seperator%%currentVersion%/Galcon2.dmg 1> NUL 2> NUL
	if not exist Galcon2.dmg (
		chgcolor c
		echo Error downloading %currentVersion% for Mac OS X
		chgcolor f
		goto skipMac
	)
	move Galcon2.dmg %currentVersion% >NUL
	chgcolor a
	echo Downloaded %currentVersion% for Mac OS X
	chgcolor f
) else (
	echo Version %currentVersion% for Mac OS X already downloaded
)
:skipMac

if %currentVersion% GTR 8 (
	if not exist %currentVersion%\Galcon2.tgz (
		if exist Galcon2.tgz del Galcon2.tgz
		echo Downloading %currentVersion% for Linux...
		wget http://www.galcon.com/g2/files/beta%seperator%%currentVersion%/Galcon2.tgz 1> NUL 2> NUL
		if not exist Galcon2.tgz (
			chgcolor c
			echo Error downloading %currentVersion% for Linux
			chgcolor f
			goto skipLnx
		)
		move Galcon2.tgz %currentVersion% >NUL
		chgcolor a
		echo Downloaded %currentVersion% for Linux
		chgcolor f
	) else (
		echo Version %currentVersion% for Linux already downloaded
	)
) else (
	chgcolor e
	echo Version %currentVersion% not available for Linux
	chgcolor f
)
:skipLnx

set /a currentVersion=%currentVersion%+1
if %currentVersion% GTR %to% (
	echo.
	echo Finished downloading.
	echo Press any key to exit.
	pause >NUL
	exit
)
goto download