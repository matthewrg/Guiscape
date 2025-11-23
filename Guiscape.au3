
#include-once

#Region ; Guiscape

#Region - AutoIt3Wrapper
;~ #Autoit3Wrapper_Testing=Y
;~ #AutoIt3Wrapper_Run_Debug_Mode=Y
#AutoIt3Wrapper_Run_Debug=Y
#AutoIt3Wrapper_Add_Constants=n
#AutoIt3Wrapper_Change2CUI=N
#AutoIt3Wrapper_Run_Au3Stripper=N
#Au3Stripper_Parameters=/mo
#AutoIt3Wrapper_Res_HiDpi=N  ;must be n otherwise _WinAPI_SetDPIAwareness() function will fail! --- (Is this so?)
#AutoIt3Wrapper_UseX64=Y
#AutoIt3Wrapper_Run_Au3Check=Y
#AutoIt3Wrapper_Au3Check_Stop_OnWarning=Y
#AutoIt3Wrapper_AU3Check_Parameters=-w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7 -d
#EndRegion - AutoIt3Wrapper

#Region - Opt
Opt("WinTitleMatchMode", 4)
Opt("MouseCoordMode", 2)
;~ Opt("GUICoordMode", 1)
Opt("MustDeclareVars", 1)
#EndRegion - Opt

#Region - Globals
Global $messageQueue

Global $oError = ObjEvent("AutoIt.Error", _ErrFunc)
#EndRegion - Globals

#Region - Includes
#include <APIGdiConstants.au3>
#include <APISysConstants.au3>
#include <ButtonConstants.au3>
#include <StructureConstants.au3>
#include <WindowsNotifsConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <ColorConstants.au3>
#include <WindowsStylesConstants.au3>
#include <Misc.au3>
#include <GUITab.au3>
#include <WindowsSysColorConstants.au3>
#include <GUIConstants.au3>
#include <WinAPI.au3>
#include <GUIButton.au3>
#include <GUIEdit.au3>
#include <WinAPIvkeysConstants.au3>
#include <BorderConstants.au3>

#include "AutoItObject\AutoItObject.au3"
#include "Message Queue\Message Queue.au3"
#include "_WinAPI_DPI\_WinAPI_DPI.au3"
#include "Functions.au3"
#include "Model.au3"
#include "Requests.au3"
#include "Main Form\Main Form.au3"
#include "Main Tab\Main Tab.au3"
#include "Menubar\Menubar.au3"
#include "Toolbar\Toolbar.au3"
#include "Tab Item Object.au3"
#include "Canvas\Canvas.au3"
#include "Parameters\Parameters.au3"
#include "Parameters\Form Parameters.au3"
#include "Script\Script.au3"
#include "Object Explorer\Object Explorer.au3"
#include "Settings\Settings.au3"
#include "File Manager\File Manager.au3"
;~ #include "GUI Objects\WndCtrlProc.au3"
;~ #include "GUI Objects\GUI Objects.au3"
#EndRegion - Includes

_AutoItObject_Startup()

$messageQueue = MessageQueue()

GUIRegisterMsg($WM_NCLBUTTONDOWN, NC_Clicked_Event)

main()

Func main()
	$messageQueue.Subscribe(Guiscape())
	$messageQueue.Subscribe(MainForm())
	$messageQueue.Subscribe(Menubar())
	$messageQueue.Subscribe(Toolbar())
	$messageQueue.Subscribe(Maintab())
	$messageQueue.Subscribe(Canvas())
	$messageQueue.Subscribe(Parameters())
	$messageQueue.Subscribe(FormParameters())
	$messageQueue.Subscribe(Script())
	$messageQueue.Subscribe(ObjectExplorer())
	$messageQueue.Subscribe(Settings())
;~ 	$messageQueue.Subscribe(GuiObjects())

	$messageQueue.Push($messageQueue.CreateEvent("Main", $init))

	$messageQueue.Push($messageQueue.CreateEvent("Main", $showSettingsRequest))
	
	$messageQueue.Push($messageQueue.CreateEvent("Main", $mainFormShowRequest))
	
	Local $event

	Do
		$event = GUIEvent()

		Switch $event.ID
			Case $GUI_EVENT_NONE
				ContinueLoop
		EndSwitch

		$messageQueue.Push($event)
	Until False
EndFunc   ;==>main

Func Guiscape()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Handler", "Guiscape_Handler")

	_AutoItObject_AddProperty($this, "Model", $ELSCOPE_PRIVATE, Model())

	Return $this
EndFunc   ;==>Guiscape

Func Guiscape_Handler(ByRef $this, ByRef Const $event)
	Switch $event.ID
		Case "Resources Directory Request"
			$messageQueue.Push($messageQueue.CreateEvent("Model", "Resources Directory Requested", "ResourcesDirectory", $this.Model.ResourcesDirectory))

			Return True

		Case "Settings INI Request"
			$messageQueue.Push($messageQueue.CreateEvent("Model", "Settings INI Requested", "SettingsINI", $this.Model.SettingsINI))

			Return True

		Case "Program Name Request"
			$messageQueue.Push($messageQueue.CreateEvent("Model", "Program Name Requested", "ProgramName", $this.Model.ProgramName))

			Return True
	EndSwitch

	Return False
EndFunc   ;==>Guiscape_Handler

#EndRegion ; Guiscape
