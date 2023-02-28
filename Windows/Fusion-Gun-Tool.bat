@echo off &title Fusion Lightgun Tool Version1.00
if not "%minimized%"=="" goto :minimized
set minimized=true
start /min cmd /C "%~dpnx0"
goto :EOF
:minimized
:: v2: less flicker
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
:gui_dialog_1
set first_choices=Calibration,Credits,Layouts,Setup,Finish&set title=Fusion Gun Tool V-1.00
:: Show gui dialog 1=Title 2=choices 3=outputvariable
call :choice "Fusion Gun Tool V-1.00" "%first_choices%" CHOICE
:: Print choices
echo Choice1: %CHOICE% & echo.
:: Continue to dialog_2
goto gui_dialog_2

:gui_dialog_2
:: Process results from dialog_1
if "%CHOICE%"=="Calibration" set next_choices=Calibration-Picture,Calibration-Video,Back&set title=Calibration
if "%CHOICE%"=="Credits"  call :"Credits" &goto Credits no suboption
if "%CHOICE%"=="Layouts" set next_choices=Fusion-Mini-Layout,Back&set title=Gun Layouts
if "%CHOICE%"=="Setup" set next_choices=Loose LEDs,Wii Bars,Back&set title=Setup
if "%CHOICE%"=="Finish"   call :"Finish"  &goto Done no suboption
:: Show gui dialog 1=Title 2=choices 3=outputvariable
call :choice "%title%" "%next_choices%" CHOICE
:: Print choices
echo Choice2: %CHOICE% & echo.
:: Back to dialog_1
if "%CHOICE%"=="Back" goto gui_dialog_1

:: Process final choice
call :"%CHOICE%"

:Done
exit/b

:: Choice code
:"Finish"
echo running code for %0
rem do stuff here
goto :Done
: "Fusion-Mini-Layout"
start %~dp0Pics\Layouts\Mini-Layout.png
goto gui_dialog_1
:"Calibration-Video"
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Make the following video fullscreen', 'Fusion Gun Tool', 'OK', [System.Windows.Forms.MessageBoxIcon]::Information);}"
start %~dp0Videos\Calibration.mp4
goto gui_dialog_1
:"Loose LEDs"
start %~dp0Pics\Loose-LEDs.png
goto gui_dialog_1
:"Wii Bars"
start %~dp0Pics\Wii-Bars.png
goto gui_dialog_1
:"Calibration-Picture"
start %~dp0Pics\Calibration.png
goto gui_dialog_1
:"Credits"
start %~dp0Pics\Credits.png
goto gui_dialog_1



::---------------------------------------------------------------------------------------------------------------------------------
:choice
rem 1=title 2=options 3=output_variable                                          example: call :choice Choose "op1,op2,op3" result
setlocal & set "c=about:<title>%~1</title><head><script language='javascript'>window.moveTo(-200,-200);window.resizeTo(500,500);"
set "c=%c% </script><hta:application innerborder='no' sysmenu='yes' scroll='no'><style>body{background-color:#17141F;}"
set "c=%c% br{font-size:14px;vertical-align:-4px;} .button{background-color:#03a78b;border:2px solid #ffffff; color:white;"
set "c=%c% padding:4px 4px;text-align:center;text-decoration:none;display:inline-block;font-size:28px;cursor:pointer;"
set "c=%c% width:100%%;display:block;}</style></head><script language='javascript'>function choice(){"
set "c=%c% var opt=document.getElementById('options').value.split(','); var btn=document.getElementById('buttons');"
set "c=%c% for (o in opt){var b=document.createElement('button');b.className='button';b.onclick=function(){
set "c=%c% close(new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1).Write(this.value));};"
set "c=%c% b.appendChild(document.createTextNode(opt[o]));btn.appendChild(b);btn.appendChild(document.createElement('br'));};"
set "c=%c% btn.appendChild(document.createElement('br'));var r=window.parent.screen;"
set "c=%c% window.moveTo(r.availWidth/3,r.availHeight/6);window.resizeTo(r.availWidth/3,document.body.scrollHeight);}</script>"
set "c=%c% <body onload='choice()'><div id='buttons'/><input type='hidden' name='options' value='%~2'></body>"
for /f "usebackq tokens=* delims=" %%# in (`mshta "%c%"`) do set "choice_var=%%#"
endlocal & set "%~3=%choice_var%" & exit/b &rem by Gonezo
::--------------------------------------------------------------------------------------------------------------------------------
