
#include-once

#Region - Declarations

Global $messageQueue

Global $oError = ObjEvent("AutoIt.Error", _ErrFunc)

Global $clickedTool = "Button"

Func Print(Const $message)
	ConsoleWrite($message & @CRLF)
EndFunc   ;==>Print

Func _Exit(Const ByRef $event)
	#forceref $event

	; Ask if the Designer would like to save their progress before closing the window.

	Exit
EndFunc   ;==>_Exit

Func NCClicked_Event(Const ByRef $hwnd, Const ByRef $msg)
	#forceref $msg

	Local $event = $messageQueue.CreateEvent("System", "GUI_NC_Clicked", "Hwnd", $hwnd)

	$messageQueue.Push($event)

	Return $GUI_RUNDEFMSG
EndFunc   ;==>NCClickedEvent

Func CreateEvent(Const $sender, Const $id, Const $key1 = Null, Const $data1 = Null, Const $key2 = Null, Const $data2 = Null, Const $key3 = Null, Const $data3 = Null, Const $key4 = Null, Const $data4 = Null, Const $key5 = Null, Const $data5 = Null)
	Local $messageMap[]

	$messageMap.Sender = $sender

	$messageMap.ID = $id

	If $key1 Then
		$messageMap[$key1] = $data1
	EndIf

	If $key2 Then
		$messageMap[$key2] = $data2
	EndIf

	If $key3 Then
		$messageMap[$key3] = $data3
	EndIf

	If $key4 Then
		$messageMap[$key4] = $data4
	EndIf

	If $key5 Then
		$messageMap[$key5] = $data5
	EndIf

	Return $messageMap
EndFunc   ;==>MessageQueue_CreateEvent

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

#EndRegion - Declarations
