
#include-once

#Region ; Guiscape

#region - AutoIt3Wrapper
;~ #Autoit3Wrapper_Testing=Y
;~ #AutoIt3Wrapper_Run_Debug_Mode=Y
#AutoIt3Wrapper_Add_Constants=n
#AutoIt3Wrapper_Change2CUI=N
#AutoIt3Wrapper_Run_Au3Stripper=N
;~ #Au3Stripper_Parameters=/mo
#AutoIt3Wrapper_Res_HiDpi=N  ;must be n otherwise _WinAPI_SetDPIAwareness() function will fail! --- (Is this so?)
#AutoIt3Wrapper_UseX64=Y
#AutoIt3Wrapper_AU3Check_Parameters=-w 1 -w 2 -w 3 -w 4 -w 5 -w 6 -w 7 -d
#endregion - AutoIt3Wrapper

#region - Opt
Opt("WinTitleMatchMode", 4)
Opt("MouseCoordMode", 2)
;~ Opt("GUICoordMode", 1)
Opt("MustDeclareVars", 1)
#endregion - Opt

#region - Globals
Global $messageQueue

Global $oError = ObjEvent("AutoIt.Error", _ErrFunc)

Global $clickedTool = "Button"
#endregion - Globals

#region - Includes
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
#include "Model.au3"
#include "Main Form\Main Form.au3"
#include "Main Tab\Main Tab.au3"
#include "Menubar\Menubar.au3"
#include "Toolbar\Toolbar.au3"
#include "Canvas\Canvas.au3"
#include "Parameters\Parameters.au3"
#include "Script\Script.au3"
#include "Object Explorer\Object Explorer.au3"
#include "Settings\Settings.au3"
#include "File Manager\File Manager.au3"
#include "GUI Objects\WndCtrlProc.au3"
#include "GUI Objects\GUI Objects.au3"
#endregion - Includes

main()

#region - Functions

Func main()
	_AutoItObject_Startup()

	$messageQueue = MessageQueue()

	$messageQueue.Subscribe(Model())
	$messageQueue.Subscribe(MainForm())
	$messageQueue.Subscribe(Menubar())
	$messageQueue.Subscribe(Toolbar())
	$messageQueue.Subscribe(Maintab())
	$messageQueue.Subscribe(Canvas())
	$messageQueue.Subscribe(Parameters())
;~ 	$messageQueue.Subscribe(Script())
;~ 	$messageQueue.Subscribe(ObjectExplorer())
;~ 	$messageQueue.Subscribe(Settings())
;~ 	$messageQueue.Subscribe(GuiObjects())

	GUIRegisterMsg($WM_NCLBUTTONDOWN, NC_Clicked_Event)

	$messageQueue.Push($messageQueue.CreateEvent("Main", "Init"))
	
	$messageQueue.Push($messageQueue.CreateEvent("Main", "Main Tab Request"))

	$messageQueue.Push($messageQueue.CreateEvent("Main", "Init"))
	
	$messageQueue.Push($messageQueue.CreateEvent("Main", "Main Form Show"))

	$messageQueue.Push($messageQueue.CreateEvent("Main", "Select Canvas Tab"))

	Local $event

	Do
		$event = GUIEvent()

		Switch $event.ID
			Case $GUI_EVENT_NONE
				ContinueLoop

		Case $GUI_EVENT_CLOSE
			Switch $event.Form
				Case $this.View.Hwnd
					_Exit($event)
			EndSwitch
			
				ContinueLoop

			Case Else
				$messageQueue.Push($event)
		EndSwitch
	Until False
EndFunc   ;==>main

Func GUIEvent()
	Local Const $eventArray = GUIGetMsg($GUI_EVENT_ARRAY)

	Local Static $event[]

	$event.Sender = "System"
	$event.ID = $eventArray[0]
	$event.Form = HWnd($eventArray[1])
	$event.Control = HWnd($eventArray[2])
	$event.X = $eventArray[3]
	$event.Y = $eventArray[4]

	Return $event
EndFunc   ;==>GUIEvent

Func Print(Const $message)
	ConsoleWrite($message & @CRLF)
EndFunc   ;==>Print

Func _Exit(Const ByRef $event)
	#forceref $event

	; Ask if the Designer would like to save their progress before closing the window.

	Exit
EndFunc   ;==>_Exit

Func NC_Clicked_Event(Const ByRef $hwnd, Const ByRef $msg)
	#forceref $msg

	Local Const $event = $messageQueue.CreateEvent("System", "GUI_NC_Clicked", "Form", $hwnd)
	
	$messageQueue.Push($event)

	Return $GUI_RUNDEFMSG
EndFunc   ;==>NCClickedEvent

Func _ErrFunc()
	ConsoleWrite(@ScriptName & " (" & $oError.scriptline & ") : ==> COM Error intercepted !" & @CRLF & _
			@TAB & "err.windescription:" & @TAB & $oError.windescription & _
			@TAB & "err.scriptline is: " & @TAB & $oError.scriptline & @CRLF & @CRLF)
EndFunc   ;==>_ErrFunc

Func CreateInput(Const $text, Const $left, Const $top, Const $width)
	Return GUICtrlCreateInput($text, $left * $DPIRatio, $top * $DPIRatio, $width * $DPIRatio, 22 * $DPIRatio)
EndFunc   ;==>CreateInput

Func CreateLabel(Const $text, Const $left, Const $top)
	Return GUICtrlCreateLabel($text, $left * $DPIRatio, $top * $DPIRatio)
EndFunc   ;==>CreateLabel

Func CreateGroup(Const $name, Const $left, Const $top, Const $width, Const $height)
	Return GUICtrlCreateGroup($name, $left * $DPIRatio, $top * $DPIRatio, $width * $DPIRatio, $height * $DPIRatio)
EndFunc   ;==>CreateGroup

Func EndGroup()
	GUICtrlCreateGroup('', -99, -99, 1, 1)
EndFunc   ;==>EndGroup

Func CreateButton(Const $text, Const $left, Const $top)
	Return GUICtrlCreateButton($text, $left * $DPIRatio, $top * $DPIRatio)
EndFunc   ;==>CreateButton

Func CreateEdit(Const $left, Const $top, Const $width, Const $height)
	Return GUICtrlCreateEdit('', $left, $top * $DPIRatio, $width * $DPIRatio, $height * $DPIRatio)
EndFunc   ;==>CreateEdit

Func CreateCheckbox(Const $text, Const $left, Const $top)
	Return GUICtrlCreateCheckbox($text, $left * $DPIRatio, $top * $DPIRatio)
EndFunc   ;==>CreateCheckbox

Func HWndFromPoint()
	Local Static $g_tStruct = DllStructCreate($tagPOINT)

	DllStructSetData($g_tStruct, "x", MouseGetPos(0))

	DllStructSetData($g_tStruct, "y", MouseGetPos(1))

	ConsoleWrite(_WinAPI_WindowFromPoint($g_tStruct) & @CRLF)

	Local $hwnd = _WinAPI_WindowFromPoint($g_tStruct)

	;Return _WinAPI_GetClassName($hwnd)
	Return _WinAPI_GetAncestor($hwnd, $GA_PARENT)
EndFunc   ;==>HWndFromPoint

#endregion - Functions

#endregion - Guiscape
