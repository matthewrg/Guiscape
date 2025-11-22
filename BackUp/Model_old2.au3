#include-once

#Region - Guiscape Model

Func Guiscape_Model()
	Local $this = _AutoItObject_Create()

	_AutoItObject_AddMethod($this, "Handler", "Guiscape_Model_Handler")

	_AutoItObject_AddProperty($this, $ELSCOPE_PRIVATE, "ResourcesDirectory", @ScriptDir & "\Resources\")
	_AutoItObject_AddProperty($this, $ELSCOPE_PRIVATE, "SettingsINI", @ScriptDir & "\Resources\Settings.ini")
	_AutoItObject_AddProperty($this, $ELSCOPE_PRIVATE, "ProgramName", "Guiscape")

	Return $this
EndFunc   ;==>Guiscape_Model

Func Guiscape_Model_Handler(ByRef $this, Const ByRef $event)
	Switch $event.ID
		Case "Init"
	$messageQueue.Push($messageQueue.CreateEvent("Guiscape", "Init"))

	$messageQueue.Push($messageQueue.CreateEvent("Guiscape", "Main Form Show"))

	$messageQueue.Push($messageQueue.CreateEvent("Guiscape", "Select Canvas Tab"))

			Return True

		Case "Resources Directory Request"
			Print("Resources Directory Request")

			$messageQueue.Push($messageQueue.CreateEvent("Guiscape", "Resources Directory Requested", "ResourcesDirectory", $this.ResourcesDirectory))

			Return True

		Case "Settings INI Request"
			Print("Settings INI Request")

			$messageQueue.Push($messageQueue.CreateEvent("Guiscape", "Settings INI Requested", "ResourcesDirectory", $this.SettingsINI))

			Return True
	EndSwitch

	Return False
EndFunc   ;==>Guiscape_Model_Handler

#EndRegion - Guiscape Model
