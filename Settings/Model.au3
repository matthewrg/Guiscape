
#include-once

#Region - Settings

Func Settings_Model()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "GetSettings", "Settings_Model_GetSettings", True)
	_AutoItObject_AddMethod($this, "WriteSetting", "Settings_Model_WriteSetting", True)

	_AutoItObject_AddProperty($this, "INI", $ELSCOPE_PRIVATE, Null)

	Return $this
EndFunc   ;==>Settings

Func Settings_Model_GetSettings(Const ByRef $this)
	Return IniReadSection($this.INI, "Settings")
EndFunc   ;==>Settings_GetSettings

Func Settings_Model_WriteSetting(Const ByRef $this, Const $key, Const $value)
	Local $setting

	Switch $value
		Case $GUI_CHECKED
			$setting = 1

		Case $GUI_UNCHECKED
			$setting = 0
	EndSwitch

	IniWrite($this.INI, "Settings", $key, $setting)
EndFunc   ;==>Settings_WriteSetting

#EndRegion - Settings
