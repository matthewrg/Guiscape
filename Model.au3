
#include-once

Func Model()
	Local $formList = []

	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("EventArrayToMap", "Model_EventArrayToMap")
	$this.AddMethod("CursorInfoToMap", "Model_CursorInfoToMap")
	$this.AddMethod("HWndFromPoint", "Model_HWndFromPoint")

	$this.AddProperty("Title", $ELSCOPE_READONLY, "Guiscape")
	$this.AddProperty("ResourcesDir", $ELSCOPE_READONLY, @ScriptDir & "\Resources\")

	Return $this.Object
EndFunc   ;==>Model

Func Model_EventArrayToMap(Const ByRef $this, Const ByRef $eventArray)
	Local $eventMap[]

	$eventMap.ID = $eventArray[0]
	$eventMap.Form = HWnd($eventArray[1])
	$eventMap.Control = HWnd($eventArray[2])
	$eventMap.X = $eventArray[3]
	$eventMap.Y = $eventArray[4]

	Return $eventMap
EndFunc   ;==>Model_EventArrayToMap

Func Model_CursorInfoToMap(Const ByRef $this, Const ByRef $cursorInfo)
	Local $cursorInfoMap[]

	$cursorInfoMap.X = $cursorInfo[0]
	$cursorInfoMap.Y = $cursorInfo[1]
	$cursorInfoMap.Primary = $cursorInfo[2]
	$cursorInfoMap.Secondary = $cursorInfo[3]
	$cursorInfoMap.ID = $cursorInfo[4]

	Return $cursorInfoMap
EndFunc   ;==>Model_CursorInfoToMap

Func Model_HWndFromPoint(Const ByRef $this)
	Local Static $g_tStruct = DllStructCreate($tagPOINT)

	DllStructSetData($g_tStruct, "x", MouseGetPos(0))

	DllStructSetData($g_tStruct, "y", MouseGetPos(1))

	ConsoleWrite(_WinAPI_WindowFromPoint($g_tStruct) & @CRLF)

	Local $hwnd = _WinAPI_WindowFromPoint($g_tStruct)

	;Return _WinAPI_GetClassName($hwnd)
	Return _WinAPI_GetAncestor($hwnd, $GA_PARENT)
EndFunc   ;==>Model_HWndFromPoint
