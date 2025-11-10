#include-once
#AutoIt3Wrapper_Add_Constants=n

#include <GuiConstantsEx.au3>

#include <WinAPISysWin.au3>

#include "AutoItObject\AutoItObject.au3"

Func GuiscapeModel()
	Local Const $resourcesDir = @ScriptDir & "\Resources\"

	Local $this = _AutoItObject_Class()

	$this.Create()

	$this.AddMethod("GetSettings", "GuiscapeModel_GetSettings")
	$this.AddMethod("WriteSetting", "GuiscapeModel_WriteSetting")
	$this.AddMethod("Initialize", "GuiscapeModel_Initialize")
	$this.AddMethod("GUIEvent", "GuiscapeModel_GUIEvent")
	$this.AddMethod("CursorInfoToMap", "GuiscapeModel_CursorInfoToMap")

	$this.AddProperty("Title", $ELSCOPE_READONLY, "Guiscape")
	$this.AddProperty("ResourcesDir", $ELSCOPE_READONLY, $resourcesDir)

	$this.AddProperty("INI", $ELSCOPE_PRIVATE, $resourcesDir & "\Settings.ini")

	Return $this.Object
EndFunc   ;==>GuiscapeModel

Func GuiscapeModel_GetSettings(Const ByRef $this)
	Return IniReadSection($this.INI, "Settings")
EndFunc   ;==>GuiscapeModel_GetSettings

Func GuiscapeModel_WriteSetting(Const ByRef $this, Const $key, Const $value)
	Local $setting

	Switch $value
		Case $GUI_CHECKED
			$setting = 1

		Case $GUI_UNCHECKED
			$setting = 0
	EndSwitch

	IniWrite($this.INI, "Settings", $key, $setting)
EndFunc   ;==>GuiscapeModel_WriteSetting

Func GuiscapeModel_GUIEvent(Const ByRef $this)
	#forceref $this
	
	Local Const $eventArray = GUIGetMsg($GUI_EVENT_ARRAY)
	
	Local $eventMap[]

	$eventMap.ID = $eventArray[0]
	$eventMap.Form = HWnd($eventArray[1])
	$eventMap.Control = HWnd($eventArray[2])
	$eventMap.X = $eventArray[3]
	$eventMap.Y = $eventArray[4]

	Return $eventMap
EndFunc   ;==>GuiscapeModel_EventArrayToMap

Func GuiscapeModel_CursorInfoToMap(Const ByRef $this, Const ByRef $cursorInfo)
	#forceref $this

	Local $map[]

	$map.X = $cursorInfo[0]
	$map.Y = $cursorInfo[1]
	$map.Primary = $cursorInfo[2]
	$map.Secondary = $cursorInfo[3]
	$map.ID = $cursorInfo[4]

	Return $map
EndFunc   ;==>GuiscapeModel_CursorInfoToMap
