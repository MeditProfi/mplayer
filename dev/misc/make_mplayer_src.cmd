@echo off

:: Some SVN clients can use localized messages (e.g. SlikSVN), force English
set LC_ALL=C

set PackagingDir=%~dp0
set MPlayer_Revision=
:: set FFmpeg_Revision=
set Packging_Revision=

if exist "pkg_version"  for /f "tokens=*" %%i in ('type pkg_version') do set Packging_Revision=%%i
if "%Packging_Revision%" == ""  set /p Packging_Revision="Revision: "

set OUTPUT_DIR=%PackagingDir%\completed\r%Packging_Revision%

for /f %%i in ("..\sources") do set SourceDir=%%~fi

cd %SourceDir%
for /f "tokens=2" %%i in ('svn info mplayer ^| find "Revision: "') do set MPlayer_Revision=%%i
:: cd mplayer\ffmpeg
:: for /f "tokens=*" %%g in ('git describe --tags --match N') do set FFmpeg_Revision=%%g
:: cd %SourceDir%

echo %MPlayer_Revision%>mplayer\snapshot_version
:: echo %FFmpeg_Revision%>mplayer\snapshot_ffmpeg
ren mplayer mplayer-r%Packging_Revision%

timeout /T 5

7za a -t7z %OUTPUT_DIR%\mplayer-r%Packging_Revision%-src.7z mplayer-r%Packging_Revision% -xr!.git -xr!.svn -mx9

ren mplayer-r%Packging_Revision% mplayer
del mplayer\snapshot_version
:: del mplayer\snapshot_ffmpeg

:end
pause
