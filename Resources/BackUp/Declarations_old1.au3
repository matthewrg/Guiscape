
#include-once

#region - Declarations

Global $Guiscape

Global $oError = ObjEvent("AutoIt.Error", _ErrFunc)

Global $NC_CLICKED

Global $clickedForm

Global $clickedTool = "Button"

Func CreateMessage(Const ByRef $message, $form = Null)
	Local $event[]

	$event.ID = $message

	$event.Form = $form

	Return $event
EndFunc   ;==>CreateMessage

Func Print(Const $message)
	ConsoleWrite($message & @CRLF)
EndFunc   ;==>Print

Func _Exit(ByRef $Guiscape, Const ByRef $event)
	#forceref $event

	GUIDelete($Guiscape.Canvas.Hwnd)

	Exit
EndFunc   ;==>_Exit

Func GUIObjectsEvent($hwnd, $msg)
	#forceref $msg

	GUICtrlSendToDummy($NC_CLICKED, $hwnd)
	
	$clickedForm = $hwnd

	Return $GUI_RUNDEFMSG
EndFunc   ;==>GUIObjectsEvent

Func _ErrFunc()
	ConsoleWrite(@ScriptName & " (" & $oError.scriptline & ") : ==> COM Error intercepted !" & @CRLF & _
			@TAB & "err.windescription:" & @TAB & $oError.windescription & @CRLF & _
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

#endregion - Declarations
