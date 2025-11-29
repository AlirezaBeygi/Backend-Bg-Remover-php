@echo off
echo ====================================
echo Clearing Laravel Cache
echo ====================================
echo.

echo Removing bootstrap cache files...
if exist "bootstrap\cache\*.php" del /Q "bootstrap\cache\*.php"
echo.

echo Cache cleared!
echo.
echo Now try running composer install again.
echo.
pause

