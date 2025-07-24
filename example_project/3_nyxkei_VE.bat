@echo off
:: Optional: Set color (light green text on black)
cd /D "%~dp0"
color 0A
cls
title nyxkei VE Creator v1.1
echo ==================================================================
echo ^|              mytitokpg's nyxkei VE CREATOR v1.1                ^|
echo ^|================================================================^|
:: Get the parent folder name of the batch file
set "folder_path=%~dp0"
for %%* in ("%folder_path:~0,-1%") do set "folder_name=%%~nx*"

:: Check if the virtual environment already exists
if exist "%folder_name%\Scripts\activate.bat" (

	echo ^|STEP 1 FOUND EXISTING VENV                                      ^|
	echo ^|----------------------------------------------------------------^|
    echo ^|Virtual environment already exists. Skipping creation.          ^|
	echo ^|                                                                ^|
	echo ^|================================================================^|
	echo ^|STEP 2 ACTIVATE EXISTING VENV                                   ^|
	echo ^|----------------------------------------------------------------^|
	echo ^|Activating the EXISTING virtual environment...                  ^|
    call "%folder_name%\Scripts\activate.bat"
	echo ^|                                                                ^|
) else (
	echo ^|STEP 1 CREATE NEW VENV                                          ^|
	echo ^|----------------------------------------------------------------^|
    echo ^|No existing virtual environment found. Creating a new one...    ^|
    python -m venv "%folder_name%"
	echo ^|                                                                ^|
	echo ^|================================================================^|
	echo ^|STEP 2 ACTIVATE NEW VENV                                        ^|
	echo ^|----------------------------------------------------------------^|
    echo ^|Activating the NEW virtual environment...                       ^|
    call "%folder_name%\Scripts\activate.bat"
	echo ^|                                                                ^|
)

echo ^|================================================================^|
echo ^|Upgrading pip                                                   ^|
echo ^|================================================================^|
echo ^|Attempting to upgrade pip to the latest version...              ^|

python -m pip install --upgrade pip || (
    echo ^|Failed to upgrade pip. Continuing.                                ^|
)

if %errorlevel% equ 0 (
    echo ^|Pip successfully upgraded or already up-to-date.                ^|
) else (
    echo ^|Pip upgrade failed. Continuing with the existing version.       ^|
)

echo ^|================================================================^|
echo ^|STEP 3 SET-UP REQUIREMENTS.TXT                                  ^|
echo ^|----------------------------------------------------------------^|
:: Check if requirements.txt exists; if not, create an empty one
if not exist "requirements.txt" (
    echo ^|requirements.txt not found. Creating empty one now...           ^|
    type nul > requirements.txt
    echo ^|Empty requirements.txt file created.                            ^|
)

:: Proceed with installation only if requirements.txt is non-empty
for %%A in (requirements.txt) do if %%~zA neq 0 (
    echo ^|requirements.txt found and is not empty. Proceeding with installation. ^|
    pip install --upgrade pip setuptools wheel
    pip install -r requirements.txt
) else (
    echo ^|requirements.txt is empty. Skipping installation.               ^|
) 
echo ^|                                                                ^|


color 0A
echo ^|================================================================^|
echo ^|STEP 4 CREATE 1_Start.bat                                       ^|
echo ^|----------------------------------------------------------------^|
:: Step 3.0: Check if 1_Start.bat exists; if it does, skip creation; if not, create an empty file
if exist 1_Start.bat (
    echo ^|1_Start.bat already exists. Skipping creation.                  ^|
    cmd /k  :: Keeps the command prompt open in the virtual environment
    exit /b  :: Ensures no further code executes

) else (
    echo ^|Creating 1_Start.bat as an empty file...                        ^|
    type nul > 1_Start.bat
    echo ^|1_Start.bat has been successfully created!                      ^|
)
echo ^|                                                                ^|

echo ^|================================================================^|
echo ^|STEP 5 WRITE 1_Start.bat                                        ^|
echo ^|----------------------------------------------------------------^|
:: Step 1.1: Write each line individually with blank lines as echo.
:: This will write lines one by one into 1_Start.bat
setlocal enabledelayedexpansion
set "write_success=0"

:: Write each line and check for errors
>>1_Start.bat echo @echo off
if errorlevel 1 set "write_success=1" & echo Failed to write line 1 && goto :error

>>1_Start.bat echo cd /d "%%~dp0"
if errorlevel 1 set "write_success=2" & echo Failed to write line 2 && goto :error

>>1_Start.bat echo.
if errorlevel 1 set "write_success=3" & echo Failed to write line 3 && goto :error

>>1_Start.bat echo REM Get the name of the current folder
if errorlevel 1 set "write_success=4" & echo Failed to write line 4 && goto :error

:: You have to do teh %%%% because if you just leave it as %% it will come out like % in the 1_Start.bat file
>>1_Start.bat echo for %%%%* in (.) do set "folder_name=%%%%~nx*"
if errorlevel 1 set "write_success=5" & echo Failed to write line 5 && goto :error

>>1_Start.bat echo.
if errorlevel 1 set "write_success=6" & echo Failed to write line 6 && goto :error

>>1_Start.bat echo echo Folder path: "%%~dp0"
if errorlevel 1 set "write_success=7" & echo Failed to write line 7 && goto :error

>>1_Start.bat echo echo Folder name: "%%folder_name%%"
if errorlevel 1 set "write_success=8" & echo Failed to write line 8 && goto :error

>>1_Start.bat echo.
if errorlevel 1 set "write_success=9" & echo Failed to write line 9 && goto :error

>>1_Start.bat echo REM Delete the __pycache__ folder and any temporary files if they exist
if errorlevel 1 set "write_success=10" & echo Failed to write line 10 && goto :error

>>1_Start.bat echo if exist "__pycache__" (
if errorlevel 1 set "write_success=11" & echo Failed to write line 11 && goto :error

>>1_Start.bat echo     rmdir /s /q "__pycache__"
if errorlevel 1 set "write_success=12" & echo Failed to write line 12 && goto :error

>>1_Start.bat echo     echo Deleted __pycache__ folder
if errorlevel 1 set "write_success=13" & echo Failed to write line 13 && goto :error

>>1_Start.bat echo )
if errorlevel 1 set "write_success=14" & echo Failed to write line 14 && goto :error

>>1_Start.bat echo.
if errorlevel 1 set "write_success=15" & echo Failed to write line 15 && goto :error

>>1_Start.bat echo REM Delete any .pyc and .log files in the directory
if errorlevel 1 set "write_success=16" & echo Failed to write line 16 && goto :error

>>1_Start.bat echo del /q *.pyc
if errorlevel 1 set "write_success=17" & echo Failed to write line 17 && goto :error

>>1_Start.bat echo del /q *.log 2^>nul
if errorlevel 1 set "write_success=18" & echo Failed to write line 18 && goto :error

>>1_Start.bat echo echo Deleted temporary .pyc and .log files
if errorlevel 1 set "write_success=19" & echo Failed to write line 19 && goto :error

>>1_Start.bat echo.
if errorlevel 1 set "write_success=20" & echo Failed to write line 20 && goto :error

>>1_Start.bat echo REM Activate the virtual environment!
if errorlevel 1 set "write_success=21" & echo Failed to write line 21 && goto :error

>>1_Start.bat echo call "%%~dp0%%folder_name%%\Scripts\activate.bat"
if errorlevel 1 set "write_success=22" & echo Failed to write line 22 && goto :error

>>1_Start.bat echo if %%ERRORLEVEL%% NEQ 0 (
if errorlevel 1 set "write_success=23" & echo Failed to write line 23 && goto :error

>>1_Start.bat echo     echo Failed to activate virtual environment!
if errorlevel 1 set "write_success=24" & echo Failed to write line 24 && goto :error

>>1_Start.bat echo     pause
if errorlevel 1 set "write_success=25" & echo Failed to write line 25 && goto :error

>>1_Start.bat echo     exit /b 1
if errorlevel 1 set "write_success=26" & echo Failed to write line 26 && goto :error

>>1_Start.bat echo )
if errorlevel 1 set "write_success=27" & echo Failed to write line 27 && goto :error

>>1_Start.bat echo echo Virtual environment activated!
if errorlevel 1 set "write_success=28" & echo Failed to write line 28 && goto :error

>>1_Start.bat echo.
if errorlevel 1 set "write_success=29" & echo Failed to write line 29 && goto :error

>>1_Start.bat echo REM Run the Python script with the same name as the folder
if errorlevel 1 set "write_success=30" & echo Failed to write line 30 && goto :error

>>1_Start.bat echo python "%%~dp0%%folder_name%%.py"
if errorlevel 1 set "write_success=31" & echo Failed to write line 31 && goto :error

>>1_Start.bat echo.
if errorlevel 1 set "write_success=32" & echo Failed to write line 32 && goto :error

>>1_Start.bat echo REM Keep the command prompt window open
if errorlevel 1 set "write_success=33" & echo Failed to write line 33 && goto :error

>>1_Start.bat echo cmd /k
if errorlevel 1 set "write_success=34" & echo Failed to write line 34 && goto :error

goto :success

:error
echo ^|An error occurred while writing line %write_success% to 1_Start.bat.      ^|

:success
echo ^|All lines were written successfully to 1_Start.bat!              ^|
echo ^|                                                                ^|
echo ^|================================================================^|
echo ^|STEP 6 CREATE 2_Install_Packages.bat                            ^|
echo ^|----------------------------------------------------------------^|
:: Step 5.0: Check if 2_Install_Packages.bat exists; if it does, skip creation; if not, create an empty file
if exist 2_Install_Packages.bat (
    echo ^|2_Install_Packages.bat already exists. Skipping creation.             
    cmd /k  :: Keeps the command prompt open in the virtual environment
    exit /b  :: Ensures no further code executes

) else (
    echo ^|Creating 2_Install_Packages.bat as an empty file...             ^|
    type nul > 2_Install_Packages.bat
    echo ^|2_Install_Packages.bat has been successfully created!            ^|
)
echo ^|                                                                ^|

echo ^|================================================================^|
echo ^|STEP 7 WRITE 2_Install_Packages.bat                             ^|
echo ^|----------------------------------------------------------------^|
:: 2_Install_Packages.bat writer
setlocal enabledelayedexpansion
set "write_success=0"

>>2_Install_Packages.bat echo @echo off
if errorlevel 1 set "write_success=1" & echo Failed to write line 1 && goto :error

>>2_Install_Packages.bat echo setlocal enabledelayedexpansion
if errorlevel 1 set "write_success=2" & echo Failed to write line 2 && goto :error

>>2_Install_Packages.bat echo.
if errorlevel 1 set "write_success=3" & echo Failed to write line 3 && goto :error

>>2_Install_Packages.bat echo REM Capture the current directory path into a variable
if errorlevel 1 set "write_success=4" & echo Failed to write line 4 && goto :error

>>2_Install_Packages.bat echo set "CURRENT_DIR=%%~dp0"
if errorlevel 1 set "write_success=5" & echo Failed to write line 5 && goto :error

>>2_Install_Packages.bat echo.
if errorlevel 1 set "write_success=6" & echo Failed to write line 6 && goto :error

>>2_Install_Packages.bat echo REM Change directory to where the script is located
if errorlevel 1 set "write_success=7" & echo Failed to write line 7 && goto :error

>>2_Install_Packages.bat echo cd /d "%%CURRENT_DIR%%"
if errorlevel 1 set "write_success=8" & echo Failed to write line 8 && goto :error

>>2_Install_Packages.bat echo.
if errorlevel 1 set "write_success=9" & echo Failed to write line 9 && goto :error

>>2_Install_Packages.bat echo REM Delete the __pycache__ folder if it exists
if errorlevel 1 set "write_success=10" & echo Failed to write line 10 && goto :error

>>2_Install_Packages.bat echo if exist "__pycache__" (
if errorlevel 1 set "write_success=11" & echo Failed to write line 11 && goto :error

>>2_Install_Packages.bat echo     rmdir /s /q "__pycache__"
if errorlevel 1 set "write_success=12" & echo Failed to write line 12 && goto :error

>>2_Install_Packages.bat echo     echo Deleted __pycache__ folder
if errorlevel 1 set "write_success=13" & echo Failed to write line 13 && goto :error

>>2_Install_Packages.bat echo )
if errorlevel 1 set "write_success=14" & echo Failed to write line 14 && goto :error

>>2_Install_Packages.bat echo.
if errorlevel 1 set "write_success=15" & echo Failed to write line 15 && goto :error

>>2_Install_Packages.bat echo REM Get the name of the current directory
if errorlevel 1 set "write_success=16" & echo Failed to write line 16 && goto :error

>>2_Install_Packages.bat echo for %%%%i in (.) do set CUR_DIR_NAME=%%%%~nxi
if errorlevel 1 set "write_success=17" & echo Failed to write line 17 && goto :error

>>2_Install_Packages.bat echo.
if errorlevel 1 set "write_success=18" & echo Failed to write line 18 && goto :error

>>2_Install_Packages.bat echo REM Activate the virtual environment
if errorlevel 1 set "write_success=19" & echo Failed to write line 19 && goto :error

>>2_Install_Packages.bat echo echo Current Directory: "%%CURRENT_DIR%%"
if errorlevel 1 set "write_success=20" & echo Failed to write line 20 && goto :error

>>2_Install_Packages.bat echo echo Activating from: "%%CURRENT_DIR%%Scripts\Activate.bat"
if errorlevel 1 set "write_success=21" & echo Failed to write line 21 && goto :error

>>2_Install_Packages.bat echo call "%%CUR_DIR_NAME%%\Scripts\Activate.bat"
if errorlevel 1 set "write_success=22" & echo Failed to write line 22 && goto :error

>>2_Install_Packages.bat echo.
if errorlevel 1 set "write_success=23" & echo Failed to write line 23 && goto :error

>>2_Install_Packages.bat echo echo =======================================
if errorlevel 1 set "write_success=24" & echo Failed to write line 24 && goto :error

>>2_Install_Packages.bat echo echo   %%CUR_DIR_NAME%% 00_Start.bat Initiated
if errorlevel 1 set "write_success=25" & echo Failed to write line 25 && goto :error

>>2_Install_Packages.bat echo echo =======================================
if errorlevel 1 set "write_success=26" & echo Failed to write line 26 && goto :error

>>2_Install_Packages.bat echo.
if errorlevel 1 set "write_success=27" & echo Failed to write line 27 && goto :error

>>2_Install_Packages.bat echo REM Initialize a counter
if errorlevel 1 set "write_success=28" & echo Failed to write line 28 && goto :error

>>2_Install_Packages.bat echo set /a counter=0
if errorlevel 1 set "write_success=29" & echo Failed to write line 29 && goto :error

>>2_Install_Packages.bat echo.
if errorlevel 1 set "write_success=30" & echo Failed to write line 30 && goto :error

>>2_Install_Packages.bat echo REM Get Python executable paths
if errorlevel 1 set "write_success=31" & echo Failed to write line 31 && goto :error

>>2_Install_Packages.bat echo for /f "delims=" %%%%a in ('where python') do (
if errorlevel 1 set "write_success=32" & echo Failed to write line 32 && goto :error

>>2_Install_Packages.bat echo     set "FULL_PYTHON_PATH=%%%%a"
if errorlevel 1 set "write_success=33" & echo Failed to write line 33 && goto :error

>>2_Install_Packages.bat echo     echo Project Python Path: !FULL_PYTHON_PATH!
if errorlevel 1 set "write_success=34" & echo Failed to write line 34 && goto :error

>>2_Install_Packages.bat echo     goto :next
if errorlevel 1 set "write_success=35" & echo Failed to write line 35 && goto :error

>>2_Install_Packages.bat echo )
if errorlevel 1 set "write_success=36" & echo Failed to write line 36 && goto :error

>>2_Install_Packages.bat echo :next
if errorlevel 1 set "write_success=37" & echo Failed to write line 37 && goto :error

>>2_Install_Packages.bat echo.
if errorlevel 1 set "write_success=38" & echo Failed to write line 38 && goto :error

>>2_Install_Packages.bat echo REM Get the active virtual environment path
if errorlevel 1 set "write_success=39" & echo Failed to write line 39 && goto :error

>>2_Install_Packages.bat echo set "VENV_PATH=%%VIRTUAL_ENV%%"
if errorlevel 1 set "write_success=40" & echo Failed to write line 40 && goto :error

>>2_Install_Packages.bat echo for %%%%i in ("%%%%VENV_PATH%%%%") do (
if errorlevel 1 set "write_success=41" & echo Failed to write line 41 && goto :error

>>2_Install_Packages.bat echo     set "venvname=%%%%~nxi"
if errorlevel 1 set "write_success=42" & echo Failed to write line 42 && goto :error

>>2_Install_Packages.bat echo )
if errorlevel 1 set "write_success=43" & echo Failed to write line 43 && goto :error

>>2_Install_Packages.bat echo echo Full Virtual Environment: %%VENV_PATH%%
if errorlevel 1 set "write_success=44" & echo Failed to write line 44 && goto :error

>>2_Install_Packages.bat echo echo Virtual Environment Name: %%venvname%%
if errorlevel 1 set "write_success=45" & echo Failed to write line 45 && goto :error

>>2_Install_Packages.bat echo.
if errorlevel 1 set "write_success=46" & echo Failed to write line 46 && goto :error

>>2_Install_Packages.bat echo REM Open a new command line and keep it open
if errorlevel 1 set "write_success=47" & echo Failed to write line 47 && goto :error

>>2_Install_Packages.bat echo cmd /k
if errorlevel 1 set "write_success=48" & echo Failed to write line 48 && goto :error

goto :success

:error
echo ^|An error occurred while writing line %write_success% to 2_Install_Packages.bat. ^|
goto :end

:success
echo ^|All lines were written successfully to 2_Install_Packages.bat!   ^| 

:end
endlocal

)
echo ^|                                                                ^|
echo ^|================================================================^|
echo ^|              VENV SETUP IN %folder_name% IS 100% COMPLETE
echo ==================================================================
echo.
echo ==================================================================
echo ^|                                                                ^|
echo ^|                       Created by mytitokpg                     ^|
echo ^|                   https://github.com/mytitokpg                 ^|
echo ^|                                                                ^|
echo ==================================================================
echo.
cmd /k  :: Keeps the command prompt open in the virtual environment
exit /b  :: Ensures no further code executes
