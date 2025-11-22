
#include-once

Func Settings()
	Local $this = _AutoItObject_Create()
	
	_AutoItObect_AddMethod($this, "GetSettings", "GuiscapeModel_GetSettings", True)
	_AutoItObect_AddMethod($this, "WriteSetting", "GuiscapeModel_WriteSetting", True)

	_AutoItObect_AddProperty($this, "INI", $ELSCOPE_PRIVATE, @ScriptDir & "\Resources\" & "Settings.ini")
	
	Return $this
EndFunc

Func Settings_GetSettings(Const ByRef $this)
	Return IniReadSection($this.INI, "Settings")
EndFunc   ;==>GuiscapeModel_GetSettings

Func Settings_WriteSetting(Const ByRef $this, Const $key, Const $value)
	Local $setting

	Switch $value
		Case $GUI_CHECKED
			$setting = 1

		Case $GUI_UNCHECKED
			$setting = 0
	EndSwitch

	IniWrite($this.INI, "Settings", $key, $setting)
EndFunc   ;==>GuiscapeModel_WriteSetting