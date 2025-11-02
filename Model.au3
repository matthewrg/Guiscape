#include-once
#include <WinAPISysWin.au3>

#include "AutoItObject.au3"

Func GUIScapeModel()
	Local $formList = ''
	#forceref $formList


	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("CreateFormObject", "GuiscapeModel_CreateFormObject")
	$this.AddMethod("EventArrayToMap", "GuiscapeModel_EventArrayToMap")
	$this.AddMethod("CursorInfoToMap", "GuiscapeModel_CursorInfoToMap")
	$this.AddMethod("HWndFromPoint", "GuiscapeModel_HWndFromPoint")

	$this.AddProperty("Title", $ELSCOPE_READONLY, "Guiscape")
	$this.AddProperty("ResourcesDir", $ELSCOPE_READONLY, @ScriptDir & "\Resources\")

	Return $this.Object
EndFunc   ;==>GUIScapeModel

Func GUIScapeModel_EventArrayToMap(Const ByRef $this, Const ByRef $eventArray)
	#forceref $this
	Local $eventMap[]

	$eventMap.ID = $eventArray[0]
	$eventMap.FormHwnd = $eventArray[1]
	$eventMap.ControlHwnd = $eventArray[2]
	$eventMap.MouseX = $eventArray[3]
	$eventMap.MouseY = $eventArray[4]

	Return $eventMap
EndFunc   ;==>GUIScapeModel_EventArrayToMap

Func GUIScapeModel_CursorInfoToMap(Const ByRef $this, Const ByRef $cursorInfo)
	#forceref $this

	Local $map[]

	$map.MouseX = $cursorInfo[0]
	$map.MouseY = $cursorInfo[1]
	$map.Primary = $cursorInfo[2]
	$map.Secondary = $cursorInfo[3]
	$map.ID = $cursorInfo[4]

	Return $map
EndFunc   ;==>GUIScapeModel_CursorInfoToMap

Func GUIScapeModel_HWndFromPoint(Const ByRef $this)
	#forceref $this

	Local Static $g_tStruct = DllStructCreate($tagPOINT)

	DllStructSetData($g_tStruct, "x", MouseGetPos(0))

	DllStructSetData($g_tStruct, "y", MouseGetPos(1))

	ConsoleWrite(_WinAPI_WindowFromPoint($g_tStruct) & @CRLF)

	Local $hwnd = _WinAPI_WindowFromPoint($g_tStruct)

	;Return _WinAPI_GetClassName($hwnd)
	Return _WinAPI_GetAncestor($hwnd, $GA_PARENT)
EndFunc   ;==>GUIScapeModel_HWndFromPoint
