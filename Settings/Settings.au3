
#include-once

#Region - Settings

#include "Model.au3"
#include "View.au3"

Func Settings()
	Local $this = _AutoItObject_Create(TabItemObject())

	_AutoItObject_AddMethod($this, "Handler", "Settings_Handler")
	
	_AutoItObject_OverrideMethod($this, "Create", "Settings_Create")
	
	_AutoItObject_AddProperty($this, "Model", $ELSCOPE_PRIVATE, Settings_Model())
	_AutoItObject_AddProperty($this, "View", $ELSCOPE_PRIVATE, Settings_View())
	
	$this.Name = "Settings"

	Return $this
EndFunc   ;==>Settings

Func Settings_Handler(ByRef $this, Const ByRef $event)
	$this.InitHandler($event)

	Switch $event.ID
		Case "Settings Requested"
			
	EndSwitch
	
	Return False
EndFunc   ;==>Settings_Handler

Func Settings_Create(ByRef $this)
	$this.View.Create()
EndFunc

#EndRegion - Settings
