
#include-once

#AutoIt3Wrapper_Add_Constants=Y
#AutoIt3Wrapper_Change2CUI=N
#AutoIt3Wrapper_Run_Au3Stripper=N
#Au3Stripper_Parameters=/so
#AutoIt3Wrapper_Res_HiDpi=N  ;must be n otherwise _WinAPI_SetDPIAwareness() function will fail! (Is this so?)
#AutoIt3Wrapper_UseX64=Y
#AutoIt3Wrapper_AU3Check_Parameters=-w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7 -d
#AutoIt3Wrapper_Run_Au3Check=Y
#AutoIt3Wrapper_Run_Tidy=N

Opt("WinTitleMatchMode", 4)
Opt("MouseCoordMode", 2)
Opt("GUICoordMode", 1)
Opt("MustDeclareVars", 1)

#include <WindowsNotifsConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <ColorConstants.au3>
#include <WindowsStylesConstants.au3>
#include <Misc.au3>

#include "AutoItObject\AutoItObject.au3"
#include "_WinAPI_DPI\_WinAPI_DPI.au3"
#include "Model.au3"
#include "View.au3"
#include "Menubar\Menubar.au3"
#include "Toolbar\Toolbar.au3"
#include "Main Tab\Main Tab.au3"
#include "GUI Objects\GUI Objects.au3"

_AutoItObject_Startup()