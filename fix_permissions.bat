@echo off
echo ====================================
echo Fixing Laravel Directory Permissions
echo ====================================
echo.

echo Creating required directories...
if not exist "bootstrap\cache" (
    mkdir "bootstrap\cache"
    echo Created: bootstrap\cache
)

if not exist "storage\app\public" (
    mkdir "storage\app\public"
    echo Created: storage\app\public
)

if not exist "storage\app\public\images" (
    mkdir "storage\app\public\images"
    echo Created: storage\app\public\images
)

if not exist "storage\app\public\processed" (
    mkdir "storage\app\public\processed"
    echo Created: storage\app\public\processed
)

if not exist "storage\framework\cache" (
    mkdir "storage\framework\cache"
    echo Created: storage\framework\cache
)

if not exist "storage\framework\sessions" (
    mkdir "storage\framework\sessions"
    echo Created: storage\framework\sessions
)

if not exist "storage\framework\views" (
    mkdir "storage\framework\views"
    echo Created: storage\framework\views
)

if not exist "storage\logs" (
    mkdir "storage\logs"
    echo Created: storage\logs
)

echo.
echo ====================================
echo Directories created successfully!
echo ====================================
echo.
echo Note: On Windows, directories are usually writable by default.
echo If you still have permission issues, make sure:
echo   1. You're running as Administrator
echo   2. The folders are not read-only
echo.
echo About the "zip module" warning:
echo   This is just a warning and can be ignored.
echo   To fix it, edit php.ini and remove duplicate extension=zip lines.
echo.
pause

