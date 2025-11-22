#include-once

#Region - Model

Func Model()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddProperty($this, "ResourcesDirectory", $ELSCOPE_READONLY, @ScriptDir & "\Resources\")
	
	_AutoItObject_AddProperty($this, "SettingsINI", $ELSCOPE_READONLY, @ScriptDir & "\Resources\Settings.ini")
	
	_AutoItObject_AddProperty($this, "ProgramName", $ELSCOPE_READONLY, "Model")

	Return $this
EndFunc   ;==>Model

#EndRegion - Model
