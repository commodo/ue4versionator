@echo off
setlocal
pushd %~dp0

rem Get the engine...
.\ue4versionator.exe --with-symbols %*
if ERRORLEVEL 1 goto error

rem Setup the git hooks...
if not exist .git\hooks goto no_git_hooks_directory
echo Registering git hooks...
echo #!/bin/sh >.git\hooks\post-checkout
echo ./ue4versionator.exe --with-symbols %* >>.git\hooks\post-checkout
echo #!/bin/sh >.git\hooks\post-merge
echo ./ue4versionator.exe --with-symbols %* >>.git\hooks\post-merge
:no_git_hooks_directory

rem Done!
goto :EOF

rem Error happened. Wait for a keypress before quitting.
:error
pause

