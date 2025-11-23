
#include-once

#region - Object Explorer

Func ObjectExplorer()
	Local $this = _AutoItObject_Create(TabItemObject())

	_AutoItObject_AddMethod($this, "Handler", "ObjectExplorer_Handler")
	
	_AutoItObject_OverrideMethod($this, "Create", "ObjectExplorer_Create")
	
	$this.TabItemName = "Object Explorer"

	Return $this
EndFunc   ;==>ObjectExplorer

Func ObjectExplorer_Handler(ByRef $this, Const ByRef $event)
	$this.InitHandler($event)
	
	
	
	Return False
EndFunc

Func ObjectExplorer_Create(ByRef $this)	
	Local Const $prevHwnd = GUISwitch(HWnd($this.TabItemHwnd))



	GUISwitch($prevHwnd)
EndFunc   ;==>ObjectExplorer_Create

#endregion - Object Explorer
