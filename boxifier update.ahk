;verison 0.2


#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetControlDelay -1
;things to do,  check periodically, gui
;check and deleted if last version file cache is present

boxicheckfile=boxifierv
UrlDownloadToFile, http://www.boxifier.com/, %boxicheckfile%.txt
;read downloaded source into variable
FileRead, checkversionsource, %boxicheckfile%.txt
;find position
Foundpos := RegExMatch(checkversionsource,"Download Boxifier (\d\.\d\.\d{1,2}) for Windows", Version)
;check the local version present; i assume it is installed in default location
BoxifierLoc = %A_AppData%\Boxifier\Boxifier.exe
FileGetVersion, BoxifierLocalVer, %BoxifierLoc%

; Count the decimals in the online version
count = 0

Loop, Parse, Version1, .
{
 count += 1
}

actualcount := count - 1

countloc = 0
; Count the decimals in the local version

Loop, Parse, BoxifierLocalVer, .
{
 countloc += 1
}

actualcountloc := countloc - 1
;if both version are not equal in case as local version has one more decimal as 1.5.24.0 while online has 1.5.24
if(actualcount!=actualcountloc)
{
LastDotPos := InStr(BoxifierLocalVer,".",0,0)  ; get position of last occurrence of "."
BoxifierLocalVer2 := SubStr(BoxifierLocalVer,1,LastDotPos-1)  ; get substring from start to last dot
}
else
{
BoxifierLocalVer2:=BoxifierLocalVer
}

if (version1== BoxifierLocalVer2)
 {
 msgbox, You have the latest version Boxifier - %version1% installed.

 
 }
 else
 
 {
;url to download the file
urltodownload = http://www.boxifier.com/Boxifier-Setup-%version1%.exe
UrlDownloadToFile, %urltodownload%, Boxifier-%version1%.exe
;run the downloaded file
run, Boxifier-%version1%.exe
sleep 2000
;further install it 
IfWinExist, Setup - Boxifier
WinActivate ; use the window just found above
sleep 2000
send {Tab}
Send {Up 1}
send {enter}
msgbox, installed
}
;Deleted downloaded html page
 IfExist, %A_ScriptDir%\%boxicheckfile%.txt
{
FileDelete,%A_ScriptDir%/%boxicheckfile%.txt
}