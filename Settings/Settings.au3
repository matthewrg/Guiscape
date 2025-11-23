
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
	
	$this.TabItemName = "Settings"

	Return $this
EndFunc   ;==>Settings

Func Settings_Handler(ByRef $this, Const ByRef $event)
	$this.InitHandler($event)
	
	$this.View.Handler($event)
	
	Return False
EndFunc   ;==>Settings_Handler

Func Settings_Create(ByRef $this)
	Local Const $prevHwnd = GUISwitch(HWnd($this.TabItemHwnd))

	$this.View.Create()

	GUISwitch($prevHwnd)
EndFunc

#EndRegion - Settings
